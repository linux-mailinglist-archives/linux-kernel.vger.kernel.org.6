Return-Path: <linux-kernel+bounces-285160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 024E79509FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34ECE1C225E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D381A0B04;
	Tue, 13 Aug 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvWl+3q9"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F761FCF;
	Tue, 13 Aug 2024 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565852; cv=none; b=UvCr00U5aYIhJnWUCAF5ho+bXUw74e38IFbgA92UAAjoU9r7T7fSdexLf6Ep4th9EyS1OT1OqAN7HEa8vQXYcHRp6i4ENw/tHVczV9PFZrcWTOM+4PThul3/dqKwf3JccqShvYA84UjK94ov6anWeNc2yZy6PJNQp24I2kLmGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565852; c=relaxed/simple;
	bh=LsSMG6vRHJ7kQTpLpA/9FQUL3qXJ2zt8pyl227W6k7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMj9uoAqNayqxc/YSKBt2CgQ+y2BE99K+ZDL3zsYUWXLQXmb9OL/KXwxx1rjTNROg98h+g6iV7wnRkIkMTiPnW4ZVPMxOUuKbpK970M24JRFBawkcyyc7f/WEhsD/iA1CBevQeTwsrF7uR/y2pA1D8SEC/R6dox923GtwYpbyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvWl+3q9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-710ec581999so2691605b3a.2;
        Tue, 13 Aug 2024 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723565851; x=1724170651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj45Nw4+kE50bs1SyxLZHW9uaBTA/6n4EMAtKboeG4s=;
        b=TvWl+3q9K6qQTOgBtj/N1MEMeo+KwkPwmBdnhRzA5tropj8lksQKTrZ24a3ENkHVaO
         tczxeiBnzhhUhSnRUfi+PuRLz4RBlGtz319QMzR1wCH9wxhD8Gf7fPJE8TiwQfKiCJFc
         H8yAfJN/m4rtkC6AujHCG4YiOUkJUMPo2MeQKvcZm+nSp/ksYeZaKnJhLuJ2e2/qPf1a
         V+2Q8AigNiArnGOcN5xJ0KYTAPBFJV35pl9Y2/ZcxAanE1lmyQuOWqiGmR9fE4JSReru
         KNsThjjNinIUtonkwt3+CE9f68daz1gMsuTqXIDGdggBARj9XUD+2YRF/qGcDvrbXiKs
         5yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565851; x=1724170651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kj45Nw4+kE50bs1SyxLZHW9uaBTA/6n4EMAtKboeG4s=;
        b=tAFX6YCg/p1wRovA4gy6Uh2gb8xVMK9gNnr6XdvAkKkLMZ8dxQh2Cm9nf04yfr7u3L
         7rAP5hqz8Q+rh7KnRBbsiPO47es6tESdPgQvqHR1EUj8GUFgQaQ5NjT90MTa4IGsfV83
         aIXoOhbsdrIyL0YL73ELkzAi6W5sZf8h+mgLECdFGN/CEFWiY7Qcjxy7B9Q8BekTOMKS
         5OmGqtawgN0Y8oPB3echsEodOr9hhi7YNLYg0SBUFM+9Ryot+AhjR8jfKz+L4CUtb7iU
         75MegjJDhoLvmHr58xijqdZVWNz6zzuXYhxH7yNNl1VOuqKp3PjlMxEgOnGGcgdJFd6g
         XJHg==
X-Forwarded-Encrypted: i=1; AJvYcCVxAEu7t+6gFTsLaqSH25GtAf6fPMs5Q/XJUwarywrACq+CX2ZbMDs2YAEA0t6XR7GFgCCYgSwcsKwI0AAF/FqPrr0aJ80T+rOTaYzDLxrnKeRaOEgwSGn6sKkRb7xABu+Eld3QrTRo
X-Gm-Message-State: AOJu0YwfnFRUwQQNwOKCfcDHr7nZJsqnTjQQvWZ6RUEXsvhObHlETxVc
	G7MiYWP0ImQeqW6VQrt1EN+rsfJhFRlgcflwzospgaH1Mqch366e6zf5FmzC
X-Google-Smtp-Source: AGHT+IEZ+myyPTgXTATkJ3lHygNW+WYSv2xP/Oost0Ndgo/r1rgYIYpFhHgNxK0mz+1xlo77nDnAeQ==
X-Received: by 2002:a05:6a20:c68e:b0:1c3:a760:9757 with SMTP id adf61e73a8af0-1c8eaf8c296mr274837637.49.1723565850455;
        Tue, 13 Aug 2024 09:17:30 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([122.177.118.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a003efsm1683331a12.40.2024.08.13.09.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:17:29 -0700 (PDT)
Date: Tue, 13 Aug 2024 21:45:56 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com,
	skhan@linuxfoundation.org, dan.carpenter@linaro.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Message-ID: <ZruGvIf5+UVEcajd@embed-PC.myguest.virtualbox.org>
References: <20240802180247.519273-1-abhishektamboli9@gmail.com>
 <2024081321-kiwi-gibberish-d065@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081321-kiwi-gibberish-d065@gregkh>

Hi Greg,
Thank you for the feedback.

On Tue, Aug 13, 2024 at 10:11:48AM +0200, Greg KH wrote:
> On Fri, Aug 02, 2024 at 11:32:47PM +0530, Abhishek Tamboli wrote:
> > Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> > and uvc_v4l2_enum_format().
> > 
> > Fix the following smatch errors:
> > 
> > drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> >  drivers/usb/gadget/function/uvc_v4l2.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> > index a024aecb76dc..9dd602a742c4 100644
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
> > @@ -389,6 +392,9 @@ uvc_v4l2_enum_format(struct file *file, void *fh, struct v4l2_fmtdesc *f)
> >  		return -EINVAL;
> > 
> >  	fmtdesc = to_uvc_format(uformat);
> > +	if (IS_ERR(fmtdesc))
> > +		return -EINVAL;
> > +
> >  	f->pixelformat = fmtdesc->fcc;
> 
>You are now only checking 2 of the responses here, not all of them,
I addressed only the errors reported by Smatch.
> which feels odd.
> 
> Either fix all calls to this function, or none of them :)
As you suggested, I'll review the remaining calls to this function 
and submit an updated patch that covers all cases.

Regards,
Abhishek


