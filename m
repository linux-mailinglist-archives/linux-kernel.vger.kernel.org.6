Return-Path: <linux-kernel+bounces-191059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C207C8D0605
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBE61C21524
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30C155CA0;
	Mon, 27 May 2024 15:20:36 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7961B155C9C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823236; cv=none; b=U1b5F0YNUjWPp0zT0ix+703/YFXNb/74KNmjEzMg23z25CAE0ZS4a8e+Y5fiaLZYPKQaU/sla1iR8Lj+Dw/z5N3/CA4z3awxwziCAJDamH2AbbQD03iGrstORiebgDP4RDSPODh1xc7oUPFhCIvbRxFA/yeQbpkwbZmGsfsFoOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823236; c=relaxed/simple;
	bh=bE0HQufswAxv3T+Fq+LbBkckUaBwmisMgO+tUoa1gKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhcbjzEE2v9mGbvxpk15SfwMHwF3Q8kN7i47P4+jgHRaEc0dxUXtOzmdK7MTcciXOKy06RNtAlZShhftKKMvOkfPFbEfJ3jjr939zW5EFrqlWMgpBgHt5+bXfh7IGDe5pptBwUTBmdEpxXA5g3ESVCE79iNSTFoHr8uMk4caoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 662485 invoked by uid 1000); 27 May 2024 11:20:33 -0400
Date: Mon, 27 May 2024 11:20:33 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Shichao Lai <shichaorai@gmail.com>, gregkh@linuxfoundation.org,
  Markus.Elfring@web.de, linux-usb@vger.kernel.org,
  usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
  xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v6] usb-storage: alauda: Check whether the media is
 initialized
Message-ID: <5a3057a5-8d20-4fc1-92d7-932c0f2b6c92@rowland.harvard.edu>
References: <20240526012745.2852061-1-shichaorai@gmail.com>
 <8176c55f-980c-4dcb-9e17-8c9c948ce216@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8176c55f-980c-4dcb-9e17-8c9c948ce216@suse.com>

On Mon, May 27, 2024 at 05:01:13PM +0200, Oliver Neukum wrote:
> On 26.05.24 03:27, Shichao Lai wrote:
> 
> Hi,
> 
> 
> > The member "uzonesize" of struct alauda_info will remain 0
> > if alauda_init_media() fails, potentially causing divide errors
> > in alauda_read_data() and alauda_write_lba().
> 
> This means that we can reach those functions.
> 
> > - Add a member "media_initialized" to struct alauda_info.
> > - Change a condition in alauda_check_media() to ensure the
> >    first initialization.
> > - Add an error check for the return value of alauda_init_media().
> > 
> > Fixes: e80b0fade09e ("[PATCH] USB Storage: add alauda support")
> > Reported-by: xingwei lee <xrivendell7@gmail.com>
> > Reported-by: yue sun <samsun1006219@gmail.com>
> > Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> > ---
> > Changes since v5:
> > - Check the initialization of alauda_check_media()
> >    which is the root cause.
> > 
> >   drivers/usb/storage/alauda.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> > index 115f05a6201a..40d34cc28344 100644
> > --- a/drivers/usb/storage/alauda.c
> > +++ b/drivers/usb/storage/alauda.c
> > @@ -105,6 +105,8 @@ struct alauda_info {
> >   	unsigned char sense_key;
> >   	unsigned long sense_asc;	/* additional sense code */
> >   	unsigned long sense_ascq;	/* additional sense code qualifier */
> > +
> > +	bool media_initialized;
> >   };
> >   #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
> > @@ -476,11 +478,12 @@ static int alauda_check_media(struct us_data *us)
> >   	}
> >   	/* Check for media change */
> > -	if (status[0] & 0x08) {
> > +	if (status[0] & 0x08 || !info->media_initialized) {
> 
> If we take this branch due to !info->media_initialized and only due
> to this condition, alauda_check_media() will return an error
> 
> (Quoting the current state):
>         /* Check for media change */
>         if (status[0] & 0x08) {
>                 usb_stor_dbg(us, "Media change detected\n");
>                 alauda_free_maps(&MEDIA_INFO(us));
>                 alauda_init_media(us);
> 
>                 info->sense_key = UNIT_ATTENTION;
>                 info->sense_asc = 0x28;
>                 info->sense_ascq = 0x00;
>                 return USB_STOR_TRANSPORT_FAILED;

Indeed.  That's what would happen with a properly functioning device, as 
opposed to a malicious one or a purposely defective fuzzing emulation.  
The point of the patch is to make the system treat these other things in 
the same way as it treats normal devices.

> >   		usb_stor_dbg(us, "Media change detected\n");
> >   		alauda_free_maps(&MEDIA_INFO(us));
> > -		alauda_init_media(us);
> > -
> > +		rc = alauda_init_media(us);
> > +		if (rc == USB_STOR_TRANSPORT_GOOD)
> > +			info->media_initialized = true;
> >   		info->sense_key = UNIT_ATTENTION;
> >   		info->sense_asc = 0x28;
> >   		info->sense_ascq = 0x00;
> 
> It seems to that we need to evaluate the reasons for taking this branch
> and the result of alauda_init_media() to compute the correct return
> of this function.

The return value is what it should be.  With a normal device:

	We see that the device reports a media change.  We read the
	characteristics of the new media and report a UNIT ATTENTION
	error, notifyng the SCSI layer about the new media and forcing
	it to retry the command.

With the defective syzbot emulation and the original code:

	We don't see a report of a media change, so we try to carry
	out a READ or WRITE operation without knowing any of the
	media characteristics.  Result: division by zero.

With the defective syzbot emulation and the patched code:

	We don't see a report of a media change, but we do see that
	the media hasn't been initialized, so we try to read the
	characteristics of the media.  This fails, so the
	media_initialized flag remains clear and the command continues 
	to fail until the SCSI layer gives up.  (Although maybe it would 
	be better to report a different error to the SCSI layer when
	this happens; UNIT ATTENTION with 0x28: Media May Have Changed 
	doesn't seem right.)

Alan Stern

