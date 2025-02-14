Return-Path: <linux-kernel+bounces-514570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9722A358A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C88E3AAB86
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EEF2222A8;
	Fri, 14 Feb 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUiTRinQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4541632C8;
	Fri, 14 Feb 2025 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521058; cv=none; b=SMX1vVgb8XTj9Coctl+jZEa7NHvz9HAWaf+e3ksmWJyIJfdWfXbhfMkBw/2YTBtt7hMNAWuxlDXcrfFaq1oFaI8pXj5xea1mlz//QZ495LIXN4KOY6EgrnzhyhF4LZIoTU9k4orKbbjV6mQ3OcmNAQCtpljpVwH503CFSTNoymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521058; c=relaxed/simple;
	bh=khYMJXUxdpUbOJ86mSDRqOVUZc/qDY6VXDZ1TZcdXVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu8r9B48HEaJ3RO16JzAw3WW5vV55Pn1NQ0atSlYxiZM4zVKZM6XNOe/pzrQ0HK8jVmuj+/4uWVPsWGY48AKNCg/3cm2pPtUPSVEabKAXcbH0Ia87neQLlj2BfVrsBdO4u2ouxLaVF7QNGFgY9t0buW6pCTw0Rn4W21jo7b8194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUiTRinQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6017DC4CED1;
	Fri, 14 Feb 2025 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739521057;
	bh=khYMJXUxdpUbOJ86mSDRqOVUZc/qDY6VXDZ1TZcdXVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUiTRinQ1+tt1IaSn3skunbhIMUsgSSE5TD5R+Dox1etBqXuqFjkV0z3SguBPqAH2
	 yqiw710qUk91e3AdWoV6nLCK1Tup7C/bomAbu1IH6q4j7A4IBI6vGMDWe7FuEHZ1L/
	 IknxjsGeAa5hIr1mylb22Q7OIixdht+Hby1EudOA=
Date: Fri, 14 Feb 2025 09:17:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miao Li <limiao870622@163.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH] usb: quirks: Add NO_LPM quirk for Teclast disk
Message-ID: <2025021425-payroll-confining-b677@gregkh>
References: <20250213101259.239530-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213101259.239530-1-limiao870622@163.com>

On Thu, Feb 13, 2025 at 06:12:59PM +0800, Miao Li wrote:
> From: Miao Li <limiao@kylinos.cn>
> 
> Teclast disk which the VID:PID is in 1f75:0917 will encounter work trouble
> used on Huawei hisi platforms with LPM enabled, applying NO_LPM quirk for
> this device fixed the problem.
> 
> Signed-off-by: Miao Li <limiao@kylinos.cn>
> ---
>  drivers/usb/core/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 67732c791c93..3927c7d66dac 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -525,6 +525,9 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	/* Blackmagic Design UltraStudio SDI */
>  	{ USB_DEVICE(0x1edb, 0xbd4f), .driver_info = USB_QUIRK_NO_LPM },
>  
> +	/* Teclast disk */
> +	{ USB_DEVICE(0x1f75, 0x0917), .driver_info = USB_QUIRK_NO_LPM },
> +
>  	/* Hauppauge HVR-950q */
>  	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
>  			USB_QUIRK_CONFIG_INTF_STRINGS },
> -- 
> 2.25.1
> 
> 

This was also sent a day before:
	https://lore.kernel.org/r/20250212093829.7379-1-huanglei814@163.com

