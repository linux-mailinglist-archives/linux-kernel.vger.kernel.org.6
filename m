Return-Path: <linux-kernel+bounces-189378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D338CEF43
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB8F1C20926
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D8F4EB2C;
	Sat, 25 May 2024 14:18:28 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2CB874F1E5
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716646708; cv=none; b=MMCmqPswU7dhJBBLyuPAJm9YEE2lOCNvX9r+cBbZyp8+CZUBqzEmLzNvGMiYMWFg/krwd581IS8RryPBd8vm6SfMhmRwoyZVzyY0eQ9gZaDaZ6XWcscCqmnJfrvi7/ZgE9wj+VvzpH/Va/A3civbv1SKwMlil40i4dG4kTnvvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716646708; c=relaxed/simple;
	bh=wbrXg/b1lNy7sgScKy9Bm4Ynn5Glx/YJGDrRYEX3l7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPiQVSd8qUHNsB2OqVTbP0lRdAPNQvueRYj5yzODFjkjU75asDX5UixIFv+aZ5k2K0G0qDuHZdw8FmAflDXem8jz3VE+V1vqnNY6DMNj1z45dOcR81BpVoo/PnfZaC80nUzWC19/GZF8fldHVSZGN7YfsypkuuVteQqGYHbMnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 607144 invoked by uid 1000); 25 May 2024 10:18:25 -0400
Date: Sat, 25 May 2024 10:18:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Shichao Lai <shichaorai@gmail.com>
Cc: gregkh@linuxfoundation.org, oneukum@suse.com, linux-usb@vger.kernel.org,
  usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
  xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v5] usb-storage: Check whether the media is initialized
 successfully
Message-ID: <a32fb17f-aa58-4975-9f67-3509928ca249@rowland.harvard.edu>
References: <20240525141020.2520942-1-shichaorai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525141020.2520942-1-shichaorai@gmail.com>

On Sat, May 25, 2024 at 10:10:20PM +0800, Shichao Lai wrote:
> The member "uzonesize" of struct alauda_info will remain 0
> if alauda_init_media() fails, potentially causing divide errors
> in alauda_read_data() and alauda_write_lba().
> - Add a member "media_initialized" to struct alauda_info.
> - Change a condition in alauda_check_media() to ensure the
>   first initialization.
> - Add an error check for the return value of alauda_init_media().
> 
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> ---
> Changes since v1:

You mean changes since v4.  Regardless:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

> - Check the initialization of alauda_check_media()
>   which is the root cause.
> 
>  drivers/usb/storage/alauda.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 115f05a6201a..40d34cc28344 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -105,6 +105,8 @@ struct alauda_info {
>  	unsigned char sense_key;
>  	unsigned long sense_asc;	/* additional sense code */
>  	unsigned long sense_ascq;	/* additional sense code qualifier */
> +
> +	bool media_initialized;
>  };
>  
>  #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
> @@ -476,11 +478,12 @@ static int alauda_check_media(struct us_data *us)
>  	}
>  
>  	/* Check for media change */
> -	if (status[0] & 0x08) {
> +	if (status[0] & 0x08 || !info->media_initialized) {
>  		usb_stor_dbg(us, "Media change detected\n");
>  		alauda_free_maps(&MEDIA_INFO(us));
> -		alauda_init_media(us);
> -
> +		rc = alauda_init_media(us);
> +		if (rc == USB_STOR_TRANSPORT_GOOD)
> +			info->media_initialized = true;
>  		info->sense_key = UNIT_ATTENTION;
>  		info->sense_asc = 0x28;
>  		info->sense_ascq = 0x00;
> -- 
> 2.34.1
> 

