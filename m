Return-Path: <linux-kernel+bounces-247614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4187F92D1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB8E1F24EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB49C1922C7;
	Wed, 10 Jul 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CUWKPISU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EAA17B05F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615818; cv=none; b=EmnlPH5hS9SFYIG8dNA1mtKHbjPNjYfzqDXNLAJ+lVlJpB9CuuMUTMsDKLXlzqDBRLSUEQv8q3igPDJ3HLAJNztoSmvNa6HrsiewI4DqNTqFKzYwwZrzeyAsKbMBSneh38OMLwXJ+yuruHkui1Vl3uywEM/KZmSftnvjwwlYil8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615818; c=relaxed/simple;
	bh=RoLcVlH35IFxlylXg9qRj0Y7rugYee8KxiP01sNHbUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8olzAPUxtTGOFmOIqPxuIZNWooALjn6+iKAztswlUyE3F2CyspZ3Nd1agBha+5LF5U/GOFXPuEfR23ULl6fmU72d4SgdKpvRQFRQFvjIMIWKQdap7j5SbPb9AMV8SIBe9TkA7SNfHkcpoX4yy7aRggqTPL4VEl9OepvHPCDKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CUWKPISU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE706C32782;
	Wed, 10 Jul 2024 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720615817;
	bh=RoLcVlH35IFxlylXg9qRj0Y7rugYee8KxiP01sNHbUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUWKPISUezYmz3PzA7+WyzDInqOsf8UVKz1oIRRlo98fNBphlUEZvrp0w1IsVd8k7
	 kx53VNtw64rDAHNErFtS4jejenOX7B+XoQVym/Co27yY93rNoSjPg7NEO2VGmXIwVi
	 8AnK8zG4yU/GRspw2DjYX76vziOLtlQ8Vc9Kz0Zs=
Date: Wed, 10 Jul 2024 14:50:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lizhe <sensor1010@163.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] driver:core: no need to invert the return value of
 the call_driver_probe()
Message-ID: <2024071007-dimly-jazz-5e1f@gregkh>
References: <20240709141417.3349-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709141417.3349-1-sensor1010@163.com>

On Tue, Jul 09, 2024 at 07:14:17AM -0700, Lizhe wrote:
> In the probe function (either drv->bus->probe() or drv->probe()),
> there is no return value of EPROBE_DEFER. the error return from probe
> should be -EPROBE_DEFER, hence no negation of call_driver_probe()'s
> return is needed, nor should there be an EPROBE_DEFER check in
> driver_probe_device()
> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> 
> v3:
> 	Modify commit message and versions go below the ---

That didn't happen here :(


