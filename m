Return-Path: <linux-kernel+bounces-544589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F657A4E3AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879AE88557C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7B927C177;
	Tue,  4 Mar 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QwuxhhjI"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08B2284B5E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100771; cv=pass; b=VD6z6t8CAyDRRGiWl84ux+wqdbKdnmZHbpr+Hd6mP+g93EtJig2Q30iVbq2lYf0gLLLn+Rxe2wq0IYi0PURRSN50pAX+20/0ICU+RheWiLy9b4Rf1z/bjtFeRJfUjqjAza9RqZH6hv0XXjjIYc3aHkYdSEGDXD7deTzJ5PwX3b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100771; c=relaxed/simple;
	bh=8C2lBBTuOzy/gLEQfKKi7QGhxyqvHea5OqVTrvMiUmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMF7t5cWxXIevYz/czf8X066IR0zfI+5+/HfvvKS4v92HqOTh6YxuqPkLQbJtiue/C2Mfzt/aHHKY7RztQVbRzdLi89ksyBIiOVzzeODnftpPZp+KgUbm3kLZ5QZaLMO/tyYmGd0UaHsw/2s+EnTPBp+FNX3Q3240d0/fhQXfJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QwuxhhjI; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 28E2740D0479
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:06:07 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6f8r1gHZzFyJH
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:04:12 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id D1F344272E; Tue,  4 Mar 2025 18:04:09 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QwuxhhjI
X-Envelope-From: <linux-kernel+bounces-541256-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QwuxhhjI
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 4E1E642A6A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:17:06 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 2494D2DCE4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:17:06 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5A218853A9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A41F0E45;
	Mon,  3 Mar 2025 09:16:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D64AD27;
	Mon,  3 Mar 2025 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993410; cv=none; b=TTK4NcdtllABfmqKGSmx+soFmF7papWDqMBQAu4aq1wEPbsWhj0cc8M+dfdB4sBxkFgc8l5A5NseWnViZbR7/b+n95nr20csfy3mcPbffyZUd7tseqROQ6T0L6cDh1lmBqg17LxRzxsG9SzVuZDmwc1h6JsOx+z158cYBCd4sGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993410; c=relaxed/simple;
	bh=8C2lBBTuOzy/gLEQfKKi7QGhxyqvHea5OqVTrvMiUmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJa5epGg/nbNdpUYRASKezJGSYaOzn0EaROpey/5G/XTLXdSoDXoU0g2Z+jauETHAReh+ygZlBMq/+91u2ClBnAVp5++LWFKZhXyzIjpJ4oktABGVRXHkXgxKXEDWsvBMO9J/pXi6UM75BMHTiQNf0g87RlJ1Rry6+eEbbSti/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QwuxhhjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F66C4CED6;
	Mon,  3 Mar 2025 09:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740993409;
	bh=8C2lBBTuOzy/gLEQfKKi7QGhxyqvHea5OqVTrvMiUmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwuxhhjI/EWQk7boFqZGYsECDM09hqPvPD9oeDXW2xXJMFcVx+FDw9FPPT5dL7NFM
	 d7z8+pLnWoRYqWZhx9/BS1P03UD2VTC12HY5yIa8PnlATukc7Un4T0sSIsGZEuPzjE
	 QxdEfMQmEujHulpARR+K81sjc84jONwTNHyRHOf8=
Date: Mon, 3 Mar 2025 10:16:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miao Li <limiao870622@163.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH] usb: quirks: Add DELAY_INIT and NO_LPM for Prolific
 PL2303 Serial Port
Message-ID: <2025030339-morbidly-relax-80c0@gregkh>
References: <20250303070047.153591-1-limiao870622@163.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303070047.153591-1-limiao870622@163.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6f8r1gHZzFyJH
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705491.85909@oUlEUCcdVPlNRpMKqFhLEw
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 03:00:47PM +0800, Miao Li wrote:
> From: Miao Li <limiao@kylinos.cn>
> 
> When used on Huawei hisi platforms, Prolific PL2303 Serial Port which
> the VID:PID is in 067b:2731 might fail to enumerate at boot time and
> doesn't work well with LPM enabled, combination quirks:
> USB_QUIRK_DELAY_INIT + USB_QUIRK_NO_LPM
> fixed the problems.
> 
> Signed-off-by: Miao Li <limiao@kylinos.cn>
> ---
>  drivers/usb/core/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index dfcfc142bd5e..8aca5518e003 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -341,6 +341,10 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
>  	  USB_QUIRK_STRING_FETCH_255 },
>  
> +	/* Prolific PL2303 Serial Port */
> +	{ USB_DEVICE(0x067b, 0x2731), .driver_info = USB_QUIRK_DELAY_INIT |
> +	  USB_QUIRK_NO_LPM },

But this is not the device id for a pl2303 device (or at least one that
Linux supports), so how was this tested?

And why would this device suddenly stop working?  This chipset has been
working with Linux for decades now, what is new about this device that
requires this change?

thanks,

greg k-h


