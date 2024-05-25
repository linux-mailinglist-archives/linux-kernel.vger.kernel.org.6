Return-Path: <linux-kernel+bounces-189367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE38CEF1D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 15:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D461F218A5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626BA4F1E5;
	Sat, 25 May 2024 13:32:35 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C75FD23769
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716643955; cv=none; b=sgtvp/aEo3PEh9F2Qber0Aql71eIdtnRy/Lq1KaDdlSO+rjUHeS070BGlmQJ0FO60ja0R+ynwwP3RWIMKB8mH6Qysrlq1QS/eyjfuvYo8j5YcYZ+OBiGUg9Bbk55U38ROO0yA47HeYXpoHOAbpCUL9oOdOxXGM5fbCScI/suNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716643955; c=relaxed/simple;
	bh=Axz9OkkEOjo4Fx6zfmpIBHHrgAhOr5F5OL+y8qm3kQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLkurS7IC/ccRUv3PtQ7Di5dVDHfZ7Qgeftup3xOWYo49xr8C8jqW0bPfnTVPcuhD6Wi1CQFsxCanTTnvruEFI4/X5ae5FsfM8EOSkDmCA2LCWLo5lawbgxsgZ7Rv7LxeID2KheVxGNL+e05WnyBWdirx03XyjX1xtrIHAlGpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 606348 invoked by uid 1000); 25 May 2024 09:32:30 -0400
Date: Sat, 25 May 2024 09:32:30 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Shichao Lai <shichaorai@gmail.com>
Cc: gregkh@linuxfoundation.org, oneukum@suse.com, linux-usb@vger.kernel.org,
  usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
  xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v4] usb-storage: Check whether the media is initialized
 successfully
Message-ID: <503256e5-fea7-42ab-af15-015b0f78ab33@rowland.harvard.edu>
References: <20240525063653.2331587-1-shichaorai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525063653.2331587-1-shichaorai@gmail.com>

On Sat, May 25, 2024 at 02:36:53PM +0800, Shichao Lai wrote:
> The member "uzonesize" of struct alauda_info will remain 0
> if alauda_init_media() fails, potentially causing divide errors
> in alauda_read_data() and alauda_write_lba().
> - Add a member "initialized" to struct alauda_info as a symbol
>   for media initialization.
> - Change a condition in alauda_check_media() to ensure the
>   first initialization.
> - Add an error check for the return value of alauda_init_media().
> 
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Suggested-by: Oliver Neukum <oneukum@suse.com>

Oliver did not suggest that the patch be written this way.

> Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> ---
> Changes since v1:
> - Check the initialization of alauda_check_media() 
>   which is the root cause.
> 
>  drivers/usb/storage/alauda.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 115f05a6201a..ddf0da203481 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -105,6 +105,8 @@ struct alauda_info {
>  	unsigned char sense_key;
>  	unsigned long sense_asc;	/* additional sense code */
>  	unsigned long sense_ascq;	/* additional sense code qualifier */
> +
> +	bool initialized;           /* true if the media is initialized */

Now with the patch written out, I think a better name for this variable 
would be media_initialized.  That is a better description of what it 
means (it doesn't mean that the driver or the device is initialized).  
And then you could remove the comment, because it would be obvious.

>  };
>  
>  #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
> @@ -476,11 +478,12 @@ static int alauda_check_media(struct us_data *us)
>  	}
>  
>  	/* Check for media change */
> -	if (status[0] & 0x08) {
> +	if (status[0] & 0x08 || !info->initialized) {
>  		usb_stor_dbg(us, "Media change detected\n");
>  		alauda_free_maps(&MEDIA_INFO(us));
> -		alauda_init_media(us);
> -
> +		rc = alauda_init_media(us);
> +		if (rc == USB_STOR_TRANSPORT_GOOD)
> +			info->initialized = true;
>  		info->sense_key = UNIT_ATTENTION;
>  		info->sense_asc = 0x28;
>  		info->sense_ascq = 0x00;
> @@ -1120,6 +1123,7 @@ static int init_alauda(struct us_data *us)
>  	info->wr_ep = usb_sndbulkpipe(us->pusb_dev,
>  		altsetting->endpoint[0].desc.bEndpointAddress
>  		& USB_ENDPOINT_NUMBER_MASK);
> +	info->initialized = false;

You don't need to do this.  The info pointer is an alias for us->extra, 
which is allocated by kzalloc(), which clears all the memory it 
allocates to zero.

Alan Stern

