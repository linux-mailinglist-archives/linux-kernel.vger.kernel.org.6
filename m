Return-Path: <linux-kernel+bounces-406577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC2C9C60F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3959282B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC2A217905;
	Tue, 12 Nov 2024 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A7iUW1BI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981F202643
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438168; cv=none; b=qLiGup9hN03p7keFwNUCxhaCpA23I5VSjjMg9C4CmvfnOq9BnCN8GHkWzbi90e1Cxl0jcJGsdNb5OWUElkMOM8xwFVFWs7AGN49efFpM0wV7pMhEASIXIevgqc/kJajsoj+yRaidZO+M0ZpolpoMyEgO/1hO5NHZanUxNl1A4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438168; c=relaxed/simple;
	bh=v4XxnSYvhO0hiBWm/6Sb/kT41gIr3bfWt6NvvoHkjLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jwf+jWpvYsUbZhlYUezshMvnq6EXtzqGngbA9a0RecjDVpLE3UKyHAsfwN2PTsOIjidQNWfCMBIgJQFGi096I3pcKG39QDiRSVajmn33UnRk9LpKRlpZ8tmBQc+/Jbfly9vmwIasbjWoZsJvbBwpJhV251psNO+gCjuoMiED3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A7iUW1BI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67FCC4CECD;
	Tue, 12 Nov 2024 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731438168;
	bh=v4XxnSYvhO0hiBWm/6Sb/kT41gIr3bfWt6NvvoHkjLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7iUW1BIL+1nJoK7+afCIrfUQHQMGhzMVKRrMDWZV4/66H8dYPJCc1v4QpBMedpWe
	 4Lj4N9yQvH7jcEm9RQrCnlJifzVgKJ4BEdzbWkycayvSXXIUi1G9yodkPQkEBZDWXK
	 VZ+x8ZPUKVO9IImiiPxLNrZc3K95Xu7OpHT+QYHY=
Date: Tue, 12 Nov 2024 20:02:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] driver core: Fix concurrency issue in match driver
 interface.
Message-ID: <2024111257-diabetic-parsley-84e9@gregkh>
References: <20241112163041.40083-1-chenqiuji666@gmail.com>
 <2024111214-casing-gong-5c78@gregkh>
 <CANgpojUSQzmcKcJxQo4WkWF8A_vFVwRrG2x=n0Q7cJuA3ZKgGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgpojUSQzmcKcJxQo4WkWF8A_vFVwRrG2x=n0Q7cJuA3ZKgGQ@mail.gmail.com>

On Wed, Nov 13, 2024 at 02:21:57AM +0800, Qiu-ji Chen wrote:
> Hi, Greg
> 
> The driver_override is updated by driver_set_override(), a function
> provided by the driver core. In driver_set_override(), the
> driver_override is updated while holding the device_lock. Therefore,
> locking is required when calling match to prevent the driver_override
> from being modified within driver_set_override().

I'm sorry, but I lost all context.  What are you referring to here?

Remember, some of use get 1000+ emails a day to do something with,
always respond with proper quoting and response in order to have a
conversation that everyone can understand.

thanks,

greg k-h

