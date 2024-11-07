Return-Path: <linux-kernel+bounces-400175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BAC9C09F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663291F21878
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E6213134;
	Thu,  7 Nov 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxY+5tfQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE68212EF7;
	Thu,  7 Nov 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992962; cv=none; b=ryDHeZcPSE6Iv526kd26EU0VWKKsBhmLFJEcWB/ZxjiTS7O/QMOO+U5j9p9oY+H2kIhRxk8zeUjMYjMsGHOGryTg4iMtNrQY6xIQEE29i7nq97C5kO3+kC1Xw0oIdnxwOgAfBSNEXp/EKB4c7hYh7mIgv/QRGdxuEyrXUutOH/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992962; c=relaxed/simple;
	bh=vKrgrqu16tNf3GZ8c9u9NoA7wIjTcJf1oi4Jnf+fPAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSaml2XvTBtvxWge04hNkeTAemmAcpwrIJrWVeQ/yVVNpekeyGdI0XXSiiqkW+WJUKXOO/ta3HMiC0qzhtEHVb5AOifRwChxGniVX7PsCjX3crF2KZbbTgEmwue6SmKdhVRchEKcrZF1WgHy7hg/UsrC6D1qozt4aseZDxzkeiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxY+5tfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5E2C4CECD;
	Thu,  7 Nov 2024 15:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730992960;
	bh=vKrgrqu16tNf3GZ8c9u9NoA7wIjTcJf1oi4Jnf+fPAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxY+5tfQpoXsobtdJ7qYsD9j4ozcCqxy59kGPVve+qbdf87c3JH1wA5SsDMqWIyt4
	 amOAkaK5DJtTbTAZHRDme5pYgmjWd1Q5O+ze3Ddtcu86Q18DfzYKQu6+R8Xx0iQFVJ
	 ehtLQ7nUdJRhWq+mTGQCJuXeFdL2AkeHljt6GOsqjHAnfn2opCpU1AT7AlXjdEXMjN
	 /oGjf/fZ2PPjUhOAgpdVWAfG9PGMguBmR3p6NlKN8RfFTkrK5cq6aiYnc7axQbFJch
	 7o8/DpB3urd+FMcvAJ2DVtMTuu74MWcx4wqfDoiSzrXRvf3TmlHC5GPmlNr8+wJDoM
	 84yEtArgSO+VQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t94LJ-000000004HS-1bjy;
	Thu, 07 Nov 2024 16:22:42 +0100
Date: Thu, 7 Nov 2024 16:22:41 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Qiu-ji Chen <chenqiuji666@gmail.com>, dtwlin@gmail.com,
	elder@kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH v3] staging: greybus: uart: Fix atomicity violation in
 get_serial_info()
Message-ID: <ZyzbQQGEaBRIRYi1@hovoldconsulting.com>
References: <20241107113337.402042-1-chenqiuji666@gmail.com>
 <2024110724-overbuilt-liquid-3734@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024110724-overbuilt-liquid-3734@gregkh>

On Thu, Nov 07, 2024 at 04:11:00PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 07, 2024 at 07:33:37PM +0800, Qiu-ji Chen wrote:
> > Our static checker found a bug where set_serial_info() uses a mutex, but 
> > get_serial_info() does not. Fortunately, the impact of this is relatively 
> > minor. It doesn't cause a crash or any other serious issues. However, if a 
> > race condition occurs between set_serial_info() and get_serial_info(), 
> > there is a chance that the data returned by get_serial_info() will be 
> > meaningless.
> 
> Trailing whitespace :(
> 
> You should fix your editor to highlight this so it doesn't keep showing
> up.
> 
> > 
> > Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> > Fixes: 0aad5ad563c8 ("greybus/uart: switch to ->[sg]et_serial()")

> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.

The CC-stable tag was left out on purpose (on my request IIRC) as this
is not fixing anything that's really a problem and is basically just
shutting the static checker up.

I believe this was also reflected in the commit message of v2 (even if
"inconsistent" may have been a better word than "meaningless").

Johan

