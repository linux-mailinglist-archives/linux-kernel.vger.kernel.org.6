Return-Path: <linux-kernel+bounces-350009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E22498FE9F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3C6281A72
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5089913F43B;
	Fri,  4 Oct 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwMhlpyQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121881ACA;
	Fri,  4 Oct 2024 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029224; cv=none; b=nMQhlDh2NVznUcHoIftw+nyRBQGEcGygfb4n4jTtTR7QPT671Xr8A5KO2rDeeiYseIy+ltXtiacMCJHa1GS7zak5UPT5OOTNpDXCAKR028DZzU1zB4pLr9pJl19G/b1ynvvtK1njvnIQofttnQOZVy7/HOlWInFuCC8EvDlvy5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029224; c=relaxed/simple;
	bh=fgmGAPdGNi7136BgDzr91cgBaR36Uz6sUXwgQM355gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krVcSCNHGdSUzw707CUhd/YzPj/yPcIMQbxfaP25sYaYezga95XNecLw5GMXr++IvkzRmnTrvOdgL+YIXaqM62/cUZKFJVRTHaj3t/LZrstrkyuTaJFim0sH7BwztbOb7g6bHskkiYlvC2vRO353Kz2eIcOpDYs5yXKJ1SOjgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwMhlpyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57D9C4CEC6;
	Fri,  4 Oct 2024 08:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728029224;
	bh=fgmGAPdGNi7136BgDzr91cgBaR36Uz6sUXwgQM355gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IwMhlpyQnT61owbiMSyPvjMM5iZn9b1MnBaP5FPI9pSHnU2KXcuM0wJxUA5XtKRGc
	 9pseGEJyX1QjxYhc/bFalW+JVB1fLnc4MFLHpobQIlXqtRaIufp7uSoLyX6IOYsuzi
	 o4Dyi12dJ5lzvqkTgi+jHreKloWmYmoOIyUoyQfI=
Date: Fri, 4 Oct 2024 10:07:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Olivier Dautricourt <olivierdautricourt@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: xhci_setup_port_arrays: early -ENODEV if
 maxports is 0.
Message-ID: <2024100407-hatless-goofy-bf12@gregkh>
References: <20240930052336.80589-1-olivierdautricourt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930052336.80589-1-olivierdautricourt@gmail.com>

On Mon, Sep 30, 2024 at 07:23:29AM +0200, Olivier Dautricourt wrote:
> If the controller reports HCSPARAMS1.maxports==0 then we can skip the
> whole function: it would fail later after doing a bunch of unnecessary
> stuff. It can occur on a buggy hardware (the value is driven by external
> signals).

What "buggy hardware" is this that can not pass the USB testing for this
type of issue?

> 
> Signed-off-by: Olivier Dautricourt <olivierdautricourt@gmail.com>
> ---
>  drivers/usb/host/xhci-mem.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index d2900197a49e..e8406db78782 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -2160,6 +2160,11 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
>  	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
>  
>  	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
> +	if (num_ports == 0) {
> +		xhci_warn(xhci, "Host controller has no port enabled\n");
> +		return -ENODEV;
> +	}

Should this be backported to older kernels, if so, how far back if this
is common hardware?

thanks,

greg k-h

