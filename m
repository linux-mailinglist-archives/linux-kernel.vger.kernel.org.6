Return-Path: <linux-kernel+bounces-284289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCCD94FF63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1D6281D76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A5137C2A;
	Tue, 13 Aug 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dz+TdzqN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A63B192;
	Tue, 13 Aug 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536712; cv=none; b=JJB+luDO++O0HZwfzLjOHyzVLK/wvNWWsMCvMHeXQwcY/z0mM42IVHyxG4Y9swkJPcSRYWXsUnRhekScpLiklzcoOfjzxUWcgRANNYlq9vLiD+J4g9s0/RwISxizO7BUo4G41aT9IJ6cXKfNObUtfgAr+cMCB5QklLyosnekDcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536712; c=relaxed/simple;
	bh=OjJdzkn31p13CLDE9/RYDv7S79m7A/l963A3TrU4zQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvCN9gL+rT6/r1wuS05wsYkjPGO8STErcNAgPw+Y42Z8DWQQ/CEDZIY23QQjFAvpQU3gA9JeDEIVEc47WTEhWEBwaFxTx9Qpti84D4qdvd5xETj0Wlr03vW865QMnTa7lcP+sQQy9bZmoNBgSkTX72lKKUctyI4UnLuJ2R1x4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dz+TdzqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69700C4AF09;
	Tue, 13 Aug 2024 08:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723536711;
	bh=OjJdzkn31p13CLDE9/RYDv7S79m7A/l963A3TrU4zQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dz+TdzqNPfLKm22RYAZNSe90opF1FUV4DiUPnZ3xbrkaJCWRdMnJfadOFvvan+a2/
	 20nGDftoxI9XAHLVb6DQ2+b9s1mvJoungAWGZWzlHrx3rAo5pdgohnCHrp1TSH1PwD
	 uJINdlU+P0+pojeZn4iZbVHC8U34UvKpdXNbypMQ=
Date: Tue, 13 Aug 2024 10:11:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com,
	skhan@linuxfoundation.org, dan.carpenter@linaro.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Message-ID: <2024081321-kiwi-gibberish-d065@gregkh>
References: <20240802180247.519273-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802180247.519273-1-abhishektamboli9@gmail.com>

On Fri, Aug 02, 2024 at 11:32:47PM +0530, Abhishek Tamboli wrote:
> Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> and uvc_v4l2_enum_format().
> 
> Fix the following smatch errors:
> 
> drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> error: 'fmtdesc' dereferencing possible ERR_PTR()
> drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> error: 'fmtdesc' dereferencing possible ERR_PTR()
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
>  drivers/usb/gadget/function/uvc_v4l2.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> index a024aecb76dc..9dd602a742c4 100644
> --- a/drivers/usb/gadget/function/uvc_v4l2.c
> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> @@ -121,6 +121,9 @@ static struct uvcg_format *find_format_by_pix(struct uvc_device *uvc,
>  	list_for_each_entry(format, &uvc->header->formats, entry) {
>  		const struct uvc_format_desc *fmtdesc = to_uvc_format(format->fmt);
> 
> +		if (IS_ERR(fmtdesc))
> +			continue;
> +
>  		if (fmtdesc->fcc == pixelformat) {
>  			uformat = format->fmt;
>  			break;
> @@ -389,6 +392,9 @@ uvc_v4l2_enum_format(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>  		return -EINVAL;
> 
>  	fmtdesc = to_uvc_format(uformat);
> +	if (IS_ERR(fmtdesc))
> +		return -EINVAL;
> +
>  	f->pixelformat = fmtdesc->fcc;

You are now only checking 2 of the responses here, not all of them,
which feels odd.

Either fix all calls to this function, or none of them :)

thanks,

greg k-h

