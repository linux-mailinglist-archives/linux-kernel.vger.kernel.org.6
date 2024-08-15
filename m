Return-Path: <linux-kernel+bounces-287753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7E952C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0473DB22C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4C1C3F34;
	Thu, 15 Aug 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b5w9JmZO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7B54FAD;
	Thu, 15 Aug 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714336; cv=none; b=TGQpOgcqEGg15q++m0uDHlnrfGSTNo5t9FpTuhjTS6nbAB+NGF+Y5JEDTG2+GEkMw8sDoxiE90WH2+zHE82WiU+hhenAlF8bQJT0HMcu4Pm+S4cFKfzsz7MBJh+ZZOwBEl6dLv02K9gi2ZuPxRrtwtSMPP3XG3q1vRSLuPDwrMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714336; c=relaxed/simple;
	bh=jZHRHvaX/IzmII2xnKjKwDcMo3fvzr76zrIGPbhbC5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOjNBLByQ45U2ktc18kvu1VPDq+xyEs9zQn4+oiQbk6XO+6urL8ADIOkv0zrmhk6+EJnrMYkPdvReRxzeHuGsNa5ruTvjwJ+MBFXNFxpWH2RrI9XNvAhvsfFP62s/Mr8bE9TFPsAcWO+N7EZPFp2cxq+4HjNO/jeLcvp69RbUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b5w9JmZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9612C32786;
	Thu, 15 Aug 2024 09:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723714336;
	bh=jZHRHvaX/IzmII2xnKjKwDcMo3fvzr76zrIGPbhbC5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5w9JmZO/0uLOLEI8W1JTlJCPEZvnb/z+af2l63C499M15qf3Ln68iyBnE5JwtbCK
	 /t88TdX5gUgqjNptY7VMOtjDZr2mv+hE1d565m065Z6gaVEr5hkrY79Jukc9ruWLjR
	 5t/asageQLqEJTB/PsmVoiXyTfwBiblkCnzFs1Gg=
Date: Thu, 15 Aug 2024 11:32:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
	dan.carpenter@linaro.org, linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: Fix ERR_PTR dereference in
 uvc_v4l2.c
Message-ID: <2024081508-swinger-arrange-02dd@gregkh>
References: <20240815071416.585559-1-abhishektamboli9@gmail.com>
 <2024081508-okay-underpaid-5029@gregkh>
 <Zr3IKD4LCrlke+8H@embed-PC.myguest.virtualbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr3IKD4LCrlke+8H@embed-PC.myguest.virtualbox.org>

On Thu, Aug 15, 2024 at 02:49:36PM +0530, Abhishek Tamboli wrote:
> Hi Greg,
> Thank you for the feedback.
> 
> On Thu, Aug 15, 2024 at 10:00:27AM +0200, Greg KH wrote:
> > On Thu, Aug 15, 2024 at 12:44:16PM +0530, Abhishek Tamboli wrote:
> > > Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> > > and uvc_v4l2_enum_format().
> > > 
> > > Fix the following smatch errors:
> > > 
> > > drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> > > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > > 
> > > drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> > > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > > 
> > > Also, fix similar issue in uvc_v4l2_try_format() for potential
> > > dereferencing of ERR_PTR().
> > > 
> > > Fixes: 588b9e85609b ("usb: gadget: uvc: add v4l2 enumeration api calls")
> > > Fixes: e219a712bc06 ("usb: gadget: uvc: add v4l2 try_format api call")
> > > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Add check for dereferencing of ERR_PTR() in uvc_v4l2_try_format()
> > > 
> > >  drivers/usb/gadget/function/uvc_v4l2.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> > > index a024aecb76dc..8bb88c864b60 100644
> > > --- a/drivers/usb/gadget/function/uvc_v4l2.c
> > > +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> > > @@ -121,6 +121,9 @@ static struct uvcg_format *find_format_by_pix(struct uvc_device *uvc,
> > >  	list_for_each_entry(format, &uvc->header->formats, entry) {
> > >  		const struct uvc_format_desc *fmtdesc = to_uvc_format(format->fmt);
> > > 
> > > +		if (IS_ERR(fmtdesc))
> > > +			continue;
> > > +
> > >  		if (fmtdesc->fcc == pixelformat) {
> > >  			uformat = format->fmt;
> > >  			break;
> > > @@ -240,6 +243,7 @@ uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
> > >  	struct uvc_video *video = &uvc->video;
> > >  	struct uvcg_format *uformat;
> > >  	struct uvcg_frame *uframe;
> > > +	const struct uvc_format_desc *fmtdesc;
> > >  	u8 *fcc;
> > > 
> > >  	if (fmt->type != video->queue.queue.type)
> > > @@ -277,7 +281,10 @@ uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
> > >  		fmt->fmt.pix.height = uframe->frame.w_height;
> > >  		fmt->fmt.pix.bytesperline = uvc_v4l2_get_bytesperline(uformat, uframe);
> > >  		fmt->fmt.pix.sizeimage = uvc_get_frame_size(uformat, uframe);
> > > -		fmt->fmt.pix.pixelformat = to_uvc_format(uformat)->fcc;
> > > +		fmtdesc = to_uvc_format(uformat);
> > > +		if (IS_ERR(fmtdesc))
> > > +			return -EINVAL;
> > 
> > Why not return the error given to you?
> Returning -EINVAL directly was based on the current implementation of to_uvc_format(), 
> which only returns ERR_PTR(-EINVAL) in case of error.
> > 
> > > +		fmt->fmt.pix.pixelformat = fmtdesc->fcc;
> > >  	}
> > >  	fmt->fmt.pix.field = V4L2_FIELD_NONE;
> > >  	fmt->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
> > > @@ -389,6 +396,9 @@ uvc_v4l2_enum_format(struct file *file, void *fh, struct v4l2_fmtdesc *f)
> > >  		return -EINVAL;
> > > 
> > >  	fmtdesc = to_uvc_format(uformat);
> > > +	if (IS_ERR(fmtdesc))
> > > +		return -EINVAL;
> > 
> > Same here.
> If you'd like me to make the changes to use PTR_ERR()? 

Yes please.

