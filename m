Return-Path: <linux-kernel+bounces-187624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEE68CD575
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3D31F228A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFAB14B946;
	Thu, 23 May 2024 14:15:20 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D846D14AD36
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473719; cv=none; b=ThGqknLyErSfNJEJE5+qsnquSmkxFXkHoy35JNG5aD/Lz9ua2BOAnBkIELZql0fBfweQ2pkr2WLfHa+vmlI7bCFhqxHPN11UbsHjy4in3DqU9l9FPhWJdg3furAqT8Qq8MxxH5Iaz4mVUHKk+hm6s6VFTdwYslDJOpmeBoCu3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473719; c=relaxed/simple;
	bh=5IUf0+zG4fFL42YLfBx8BZeqPX1R//xyjwcl6cKW7dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yeb+9BkK9+AkJGS4snkARQyNh7PvGM/MhNWWx0Ob+Qs/fzc5Rdr2wbdxA21C2XGNNXQqg01EB4tuN0n/zeRVwTOwEnxbvoGm0H20+dz8QCa+V+tcVURFBlQcSdSCKmdB4W96YIopa0c77axZiG8DyzjT9mOcwDXiV/aZ2v5a0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 539510 invoked by uid 1000); 23 May 2024 10:15:17 -0400
Date: Thu, 23 May 2024 10:15:17 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Shichao Lai <shichaorai@gmail.com>
Cc: gregkh@linuxfoundation.org, oneukum@suse.com, linux-usb@vger.kernel.org,
  usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
  xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCHv2] Check whether divisor is non-zero before division
Message-ID: <bb581989-4ac5-4ffe-9f80-01b5f993146f@rowland.harvard.edu>
References: <20240523092608.874986-1-shichaorai@gmail.com>
 <a0afa88b-f84c-4b45-a265-2e6bcbb84b35@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0afa88b-f84c-4b45-a265-2e6bcbb84b35@rowland.harvard.edu>

On Thu, May 23, 2024 at 09:58:21AM -0400, Alan Stern wrote:
> On Thu, May 23, 2024 at 05:26:08PM +0800, Shichao Lai wrote:
> > Since uzonesize may be zero, so judgements for non-zero are nessesary in both place.
> > Previous check is moved out of loop, and one more check is added in alauda_write_lba.
> > 
> > Reported-by: xingwei lee <xrivendell7@gmail.com>
> > Reported-by: yue sun <samsun1006219@gmail.com>
> > Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> > ---
> >  drivers/usb/storage/alauda.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> > index 115f05a6201a..a6e60ef5cb0d 100644
> > --- a/drivers/usb/storage/alauda.c
> > +++ b/drivers/usb/storage/alauda.c
> > @@ -818,6 +818,8 @@ static int alauda_write_lba(struct us_data *us, u16 lba,
> >  	unsigned int blocksize = MEDIA_INFO(us).blocksize;
> >  	unsigned int lba_offset = lba % uzonesize;
> >  	unsigned int new_pba_offset;
> > +	if (!uzonesize)
> > +		return USB_STOR_TRANSPORT_ERROR;
> >  	unsigned int zone = lba / uzonesize;
> >  
> >  	alauda_ensure_map_for_zone(us, zone);
> > @@ -923,6 +925,8 @@ static int alauda_read_data(struct us_data *us, unsigned long address,
> >  	unsigned int uzonesize = MEDIA_INFO(us).uzonesize;
> >  	struct scatterlist *sg;
> >  	int result;
> > +	if (!uzonesize)
> > +		return USB_STOR_TRANSPORT_ERROR;
> >  
> >  	/*
> >  	 * Since we only read in one block at a time, we have to create
> 
> This is definitely NOT the right way to fix the bug!
> 
> uzonesize is set once, when the device is probed, in 
> alauda_init_media().  That is where the check belongs; if uzonesize is 0 
> then the function should print a warning and return 
> USB_STOR_TRANSPORT_ERROR, because the device is unusable.
> 
> It's probably a good idea to check pagesize, blocksize, and zonesize at 
> the same time, even though none of them are used for any divisions.

Wait a minute.  I just went through the code more carefully.  It should 
not be possible for uzonesize to be 0, because it is defined by:

	MEDIA_INFO(us).uzonesize = ((1 << media_info->zoneshift) / 128) * 125;

where media_info->zoneshift is always a value between 8 and 12.

So the whole idea behind this patch is misguided.  The real problem is 
to find out why uzonesize ended up being 0.

(And it's not necessary to check pagesize, blocksize, or zonesize, 
because none of them can ever be 0 either.)

Alan Stern

