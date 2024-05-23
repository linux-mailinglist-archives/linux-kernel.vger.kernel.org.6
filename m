Return-Path: <linux-kernel+bounces-187099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A648CCD19
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5401F21B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF0713CAA5;
	Thu, 23 May 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YdJ/BuzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CFC13C809;
	Thu, 23 May 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449772; cv=none; b=UZ0vMnx50Hz8VuOMg0ODHPXcKgB+3TE1fQL5eieR1jkhJq0TQP6fVnFfb+LQOIst4C+0rPspZeFhe/zydqiU8tyBSpZl8Uok14yAI+w7uauO3aZ6D2EnlRNH9+iY2IrIRNzRQqrv3dArklAiWqEX0p3Il7SEEygSDT3c+kLM3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449772; c=relaxed/simple;
	bh=ZVXhu+FLBy1CzMwEfEAguNuZ/zCGkVR+Om75Tniq6VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxkkq0JNNSE76jIGkZ8gq/j3DzUV8ZKHMS/Idrys7RksiUWOPcI3vUbdJceogntONO4uwWzdKmofM2X1NkWPQuKT9ZYXyMAawU1bs75E5crYHUuE7SQ4tJvdmU9kbjS8hS5KkuCYfTjlk5kVXV5FVSsqFDIm1z87+U80smLk7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YdJ/BuzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46206C2BD10;
	Thu, 23 May 2024 07:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716449771;
	bh=ZVXhu+FLBy1CzMwEfEAguNuZ/zCGkVR+Om75Tniq6VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YdJ/BuzXaIAP99iZyNFDJXjbUPTHNjoyJLzESWTB9nd+x1QI54nNI8fCBHNQEKek3
	 YRrZet6z87ETJa38yZ4RgjXDTF97rdHAhoNt1Hf9lDiNbIY08bYobjQ40n3a+YS51M
	 PI1T/+HHFuQ5MZf0FnGO2ZHV18pYNAyNMU4FCQyo=
Date: Thu, 23 May 2024 09:36:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shichao Lai <shichaorai@gmail.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH] Check whether divisor is non-zero before division
Message-ID: <2024052349-gossip-blurry-eda0@gregkh>
References: <20240523072242.787164-1-shichaorai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523072242.787164-1-shichaorai@gmail.com>

On Thu, May 23, 2024 at 03:22:42PM +0800, Shichao Lai wrote:
> Since uzonesize may be zero, so a judgement for non-zero is nessesary.
> 
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> ---
>  drivers/usb/storage/alauda.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 115f05a6201a..db075a8c03cb 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -947,6 +947,8 @@ static int alauda_read_data(struct us_data *us, unsigned long address,
>  	sg = NULL;
>  
>  	while (sectors > 0) {
> +		if (!uzonesize)
> +			return USB_STOR_TRANSPORT_ERROR;
>  		unsigned int zone = lba / uzonesize; /* integer division */
>  		unsigned int lba_offset = lba - (zone * uzonesize);
>  		unsigned int pages;
> -- 
> 2.34.1
> 
> 

Looks good, thanks!  I'll queue this up after 6.10-rc1 is out.

greg k-h

