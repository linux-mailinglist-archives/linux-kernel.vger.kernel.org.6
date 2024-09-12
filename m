Return-Path: <linux-kernel+bounces-326613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EFF976AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4CE1F2586A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D821A3037;
	Thu, 12 Sep 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DO1yvyfv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8C20E3;
	Thu, 12 Sep 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148150; cv=none; b=kNsuNeMMbx+hgbiVao4Wwd/DZ2xtCBqkv6sFj4ws04u8+CxQPSqndrHlcZ7B5tcq4jDTQNQYGhsTfUo+q1K64GDOSJsAL2qkzENVPmP8p1MuryKS9mgExr37hL7D2h35gvA8hb14J2YDc/4brRdbN0a+0l97cHBu2mPS4x/wAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148150; c=relaxed/simple;
	bh=ADof/3pu2OlQjiLcGq6uD3vBmN1T3CMg5GOWfTMTsek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Woihk+Y+yQCXk51B3AKgU9UFxTQYET24alZK7mIiqvRezUTOq94CL4NkuFS4Lvo4rQzkbMJ0BTY4jYCVg7GQhuXuEAFsEGF8gpTbXkhTYO614q4bpNX/rGPez26FiGUoEQHjCkjf5rk2QRW3JOamWam1ED2Wq6D72g0jfHbbShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DO1yvyfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E70EC4CEC3;
	Thu, 12 Sep 2024 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726148149;
	bh=ADof/3pu2OlQjiLcGq6uD3vBmN1T3CMg5GOWfTMTsek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DO1yvyfvyC13AaocnK0Wcg0A5ZQFquiBA5YCZu46HjmGUxDAA+1Mkdc9RvN0vqs1S
	 1pmvDfaIfnEaJnkupl++Kofq49bYw8veqry/yaxYjVrq2WnLz6pOZjeLQjTZ2WNQCW
	 ucnjttQd7QEyZYCqBcjBKmglDOPy1JR+BI1WESZ8=
Date: Thu, 12 Sep 2024 15:34:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: Roy Luo <royluo@google.com>, Alan Stern <stern@rowland.harvard.edu>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Sumit Garg <sumit.garg@linaro.org>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Chris Wulff <crwulff@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: core: force synchronous registration
Message-ID: <2024091210-capitol-quartet-e3d5@gregkh>
References: <20240912131608.1645554-1-jkeeping@inmusicbrands.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912131608.1645554-1-jkeeping@inmusicbrands.com>

On Thu, Sep 12, 2024 at 02:16:07PM +0100, John Keeping wrote:
> Registering a gadget driver is expected to complete synchronously and
> immediately after calling driver_register() this function checks that
> the driver has bound so as to return an error.
> 
> Set PROBE_FORCE_SYNCHRONOUS to ensure this is the case even when
> asynchronous probing is set as the default.
> 
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> ---
>  drivers/usb/gadget/udc/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index cf6478f97f4a3..a6f46364be65f 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1696,6 +1696,7 @@ int usb_gadget_register_driver_owner(struct usb_gadget_driver *driver,
>  	driver->driver.bus = &gadget_bus_type;
>  	driver->driver.owner = owner;
>  	driver->driver.mod_name = mod_name;
> +	driver->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;

What commit id does this fix?

thanks,

greg k-h

