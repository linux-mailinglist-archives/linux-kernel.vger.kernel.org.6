Return-Path: <linux-kernel+bounces-287736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B944F952C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2804AB24672
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7541EA0CE;
	Thu, 15 Aug 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPBd+kzI"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137C177980;
	Thu, 15 Aug 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713674; cv=none; b=MahmH/0W32wOuJILp1HcbXh+5WPrt6qG6TyEgU7lwZds553UTW3XqtyxoKGkiKb130QEekBbSk2p80C9t1dHWlfc6EyVFSI+rolZBZZoxa1Uf9qjrKruuiK+SI6dfmUoMAxfbwZV6n0vuI+2Ujhu/p4SVVSVVFnocRENq3tXd8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713674; c=relaxed/simple;
	bh=LEAaTUL/m1UfwuCT5ykEacZwJo/XFbrWRhtoWiRmXHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkPRbWxHHgewxzfEMNoRsKW6cInjPcQA2ttN+pMDfx8puMnbLCIfJXGyTwB3rLknhU8Me0N3usr2LB/J0FryPUuifZhOP4vJic5ZqfEbeUBCaVlMDKl71g3Mz8zydKcsWVbwCtUciBfVQLXRiEypb9WyjZ2iIl3xEJQKNeRDsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPBd+kzI; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-26ff21d8382so552420fac.1;
        Thu, 15 Aug 2024 02:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723713672; x=1724318472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi6j369DIWifgZYQDtobMfSWY9tnI4w0uorMz2TgSfw=;
        b=XPBd+kzIAlfU2wSSR54u0x0M41P+CzcwX6lUOvPPPvOcsf+bfitXBtm5PDtxB1WMin
         7VYxVy8UeramCG21i3hBSACAtzlUY2w3Dl99JteYl+cCCHhByDik1QL85fiFJSKV/6bk
         wl33cpG/d18Fw/T4bG05501VIpKRBUNy8CktwlkLSn8iVc4KbSkdg/qc9UfrnJXpHbNW
         rUUtCiAmAQBGlR2Y3yDHgWuXI4ruNfDPm+SC+W2hiBZHuDG7TysmRXEJnt31bPG4KKMi
         uBZKJEtuAzjOlj3ockIgNRxcL5Z1eVq1uT52rgy/kkZxuM48apTbfoNBte6YPyimVQro
         wYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713672; x=1724318472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi6j369DIWifgZYQDtobMfSWY9tnI4w0uorMz2TgSfw=;
        b=Zgn3/of+wcBDQBmP6JxpNhMBLL5C2eA5wb9jmA/v4Qbx9RJawER2Z2jBmo922QHDnk
         RBZsjEKSrcYIeYBxRao/sYPBOUBuMG7Nf0j7D3FH0rRorI6V4HOx2L7TfPWkbb4mMsL0
         5iFL8qBbl+ZTojH3fdBTP0oaG01eAaMbo7L4A0mWz5gkZMvgLTLChZ2bZ6/A6Nh+RxO7
         z1yqupUZ+Qph4DNEXIGlhqrUB6xUSfaa1CkyNuEcaKL10M7wWpR6Fx4SQ3g92pSmbHq9
         W6kLS0fx6SSGvgm63tr3H6IAoqAJ2R6d3yUWaFdqqQ23gcB+yf7sLJY2Ft/uHN/uDFJd
         sFEw==
X-Forwarded-Encrypted: i=1; AJvYcCW+TCiu/6sR5pJfEyLOuiMKKQuEg3zqLpBLos981po8mGE1XInW5zPo8LTPX+xHJR8zWPDFPAAS1Dz6WRSkJTh7hgzQ0kpU+4AhzGode4xP4Wgyr9c/fC6N0Im8mJ6SIULty4ogiUQu
X-Gm-Message-State: AOJu0YztO5BGvYp8Xl7aKFXi1CcLvK39V2QwC6QLDm9L9t3qyPyWEwM0
	oabFlb40IEDNVkaxo9mLeJHfXHRBPCeh0ba+TzZMVdpdITiRdrn9
X-Google-Smtp-Source: AGHT+IFLqJDIEXOm/K0lfX/wPxuF7uQ7WMGUH1+1NkQVI8GwKgY/Byn8kdtkr9KxEr3jvY/cQJWXJQ==
X-Received: by 2002:a05:6870:7311:b0:254:8666:cded with SMTP id 586e51a60fabf-26fe5a2cd82mr6666647fac.11.1723713672062;
        Thu, 15 Aug 2024 02:21:12 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.235.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef65acsm693923b3a.117.2024.08.15.02.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:21:11 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:49:36 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
	dan.carpenter@linaro.org, linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: Fix ERR_PTR dereference in
 uvc_v4l2.c
Message-ID: <Zr3IKD4LCrlke+8H@embed-PC.myguest.virtualbox.org>
References: <20240815071416.585559-1-abhishektamboli9@gmail.com>
 <2024081508-okay-underpaid-5029@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081508-okay-underpaid-5029@gregkh>

Hi Greg,
Thank you for the feedback.

On Thu, Aug 15, 2024 at 10:00:27AM +0200, Greg KH wrote:
> On Thu, Aug 15, 2024 at 12:44:16PM +0530, Abhishek Tamboli wrote:
> > Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> > and uvc_v4l2_enum_format().
> > 
> > Fix the following smatch errors:
> > 
> > drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > 
> > drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > 
> > Also, fix similar issue in uvc_v4l2_try_format() for potential
> > dereferencing of ERR_PTR().
> > 
> > Fixes: 588b9e85609b ("usb: gadget: uvc: add v4l2 enumeration api calls")
> > Fixes: e219a712bc06 ("usb: gadget: uvc: add v4l2 try_format api call")
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> > Changes in v2:
> > - Add check for dereferencing of ERR_PTR() in uvc_v4l2_try_format()
> > 
> >  drivers/usb/gadget/function/uvc_v4l2.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> > index a024aecb76dc..8bb88c864b60 100644
> > --- a/drivers/usb/gadget/function/uvc_v4l2.c
> > +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> > @@ -121,6 +121,9 @@ static struct uvcg_format *find_format_by_pix(struct uvc_device *uvc,
> >  	list_for_each_entry(format, &uvc->header->formats, entry) {
> >  		const struct uvc_format_desc *fmtdesc = to_uvc_format(format->fmt);
> > 
> > +		if (IS_ERR(fmtdesc))
> > +			continue;
> > +
> >  		if (fmtdesc->fcc == pixelformat) {
> >  			uformat = format->fmt;
> >  			break;
> > @@ -240,6 +243,7 @@ uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
> >  	struct uvc_video *video = &uvc->video;
> >  	struct uvcg_format *uformat;
> >  	struct uvcg_frame *uframe;
> > +	const struct uvc_format_desc *fmtdesc;
> >  	u8 *fcc;
> > 
> >  	if (fmt->type != video->queue.queue.type)
> > @@ -277,7 +281,10 @@ uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
> >  		fmt->fmt.pix.height = uframe->frame.w_height;
> >  		fmt->fmt.pix.bytesperline = uvc_v4l2_get_bytesperline(uformat, uframe);
> >  		fmt->fmt.pix.sizeimage = uvc_get_frame_size(uformat, uframe);
> > -		fmt->fmt.pix.pixelformat = to_uvc_format(uformat)->fcc;
> > +		fmtdesc = to_uvc_format(uformat);
> > +		if (IS_ERR(fmtdesc))
> > +			return -EINVAL;
> 
> Why not return the error given to you?
Returning -EINVAL directly was based on the current implementation of to_uvc_format(), 
which only returns ERR_PTR(-EINVAL) in case of error.
> 
> > +		fmt->fmt.pix.pixelformat = fmtdesc->fcc;
> >  	}
> >  	fmt->fmt.pix.field = V4L2_FIELD_NONE;
> >  	fmt->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
> > @@ -389,6 +396,9 @@ uvc_v4l2_enum_format(struct file *file, void *fh, struct v4l2_fmtdesc *f)
> >  		return -EINVAL;
> > 
> >  	fmtdesc = to_uvc_format(uformat);
> > +	if (IS_ERR(fmtdesc))
> > +		return -EINVAL;
> 
> Same here.
If you'd like me to make the changes to use PTR_ERR()? 
I'll update the patch.

Regards,
Abhishek

