Return-Path: <linux-kernel+bounces-437781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6779E988B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636F01621AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D111B0419;
	Mon,  9 Dec 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VidCF00g"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F135950
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753729; cv=none; b=AAxLCu+fy31uyRzj8oo8Wn75WQcmaT8RWoy+3Cse974138PgMz/L2D8FfhAppO367d64GS8wEV0kDr0dcyMpbLexJBjZ7RFF9aS8c5jItPitmMnk99l3LWjdrJScb/Rp6qhV7AXPoJfE4hdwx3IhZ2lHj4wRC/Fc2My5upiTeEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753729; c=relaxed/simple;
	bh=VFVhE2QTlvv6e1vmvz2TkVwkpNZdis5j2cIivqIwFtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQdawRkbPRm2nmNrjWJbrlcDUSe+k+1/BPsvW49ajazv1CL0NeBt76S+UhOq5drwaABApP1nJkD4rYrCiZLTVBzCMBt2FgphKaOrfxe74Rp2HHUTCZXSS7IdK7IzoXQM8uqaNxrWM8x4i4KlLFlD9n8i5JPl8WYzo1WF21jj1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VidCF00g; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216585cbe1eso8148845ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733753726; x=1734358526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xzxXRCzTVTG5CQYsalZ5w45qQHvajfokh5rpMY9TcsI=;
        b=VidCF00gOQoq7h6hJdpJMVWNZscyreCGOmqBKvDuyeoYACS4FRwmr7kBQ5D/tijLr6
         f3iCo+qXt9A6vSVI7/cgM0+4BOnX1qfS+r1zMA/Hux+FpPeJN4h+/askbgkPATGTi2xc
         5qOI106DXDj54+Pfe01U2Yk3Kw1wuhvSIQBAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753726; x=1734358526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzxXRCzTVTG5CQYsalZ5w45qQHvajfokh5rpMY9TcsI=;
        b=ivreJZlwCEXrD0GTx2SKJxazuOrzdfvfnKdQtpZom1oaTCuLryFWPhce2ZjFhDXCRU
         wCzrPJ3SnQp6vJGLE9UbZkkKHkvK3Bv7GNa55aNfccoH2nkDLLqn4WPRjAQr4IkLseSP
         i5cC82QbNZEkjJIkFbWuqcKvnuS7aDOhWh84l0mFb7Byx+3FHUm3/hciy5JLHN30eiEa
         djjx61kLafw4AEZt8q8ySy8C6Tyo65b8sBEO+l4vvLi5I2KoKSIFdFnQ+BXWkfFYKnh1
         XBIwi6eU1DrsPWB2J6iQp+OQSAVXrHCOwzxNxHJtzcyNT846EBnU4cx2pWRyCVz4Ax0B
         DAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHFtxPv81U8LT1XWM3X+RKr1AdTEHEUPSzNU/A4ijGFCRH1ds/wpmybDeAKPn8vnPsVs3zcfzLi8YFLfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbZ/dOef00rnDTGM49sjLPEfsStLc3hQRRsro1icFeimRxkCXk
	y4w7ZAmwYEKo6hsnAlcz5gglpARFP3MJAvC/oNaDAurYl1dbdg3Xuuhs5XpZerz0HWnBY0OjD/k
	=
X-Gm-Gg: ASbGncsn0LAd1rZmdn+qmd7lpP2ZiBt/Kv64HmRX27FH3S1dcB8SCBOqQeJzZq5nSYc
	A1MlZZm2mEITQmwtRdN6+fkixAaQpwCOSKrGMjVGoHYRfrHsrGIPPJw0370Mibm8+mdPO6p2gWj
	b87s0bNiwtIdpMdLLkHqs9IYmWb1xQ4TzTMFDsSiJYXuJQuGjDW/UxaOCEqpTUYkUYFjsBzMXKr
	vv+5db6oMs7lP8Hc7v7tS1oRDDBATkfMmpo3fpAC0qIidI1fGRLdr5Hmx6fkfIj5/Cd6IEQHHAf
	gugNesCjxQ4/
X-Google-Smtp-Source: AGHT+IF+aqPx9DxqJO3KxHf1ehVT16VzLRszy5Y8v+C0PFD+1PaJDBoF6pbcnZxHl04E7y013pTdZg==
X-Received: by 2002:a17:902:cec4:b0:216:501e:e314 with SMTP id d9443c01a7336-21669fb7abcmr7420555ad.20.1733753725620;
        Mon, 09 Dec 2024 06:15:25 -0800 (PST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21622f3a5f1sm48992945ad.37.2024.12.09.06.15.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:15:24 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso1526873a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:15:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0b9X/yLmHKJ5jTmTWQN0HMAs6fYWpC7Idnttm+HzEYL9t3Vv3L7fdn0pK1za04dxogl8q0Bx28bCXhfw=@vger.kernel.org
X-Received: by 2002:a17:90b:530b:b0:2ee:fc08:1bc1 with SMTP id
 98e67ed59e1d1-2efcf2ba6d4mr1028618a91.37.1733753723393; Mon, 09 Dec 2024
 06:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-17-64cfeb56b6f8@chromium.org> <8258ce59-cd06-46ba-b275-97eb9ae4d64c@redhat.com>
In-Reply-To: <8258ce59-cd06-46ba-b275-97eb9ae4d64c@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 9 Dec 2024 15:15:11 +0100
X-Gmail-Original-Message-ID: <CANiDSCt_5aArcnhLvAKKfOW4sUBNZtB0QQGkS_-AWmTxh_vKMA@mail.gmail.com>
X-Gm-Features: AZHOrDnj6sP9Y52Rjxyokva7bCUrrfnBh_aHGTI1dw9kdeFQcdL7UjePmPkl7k0
Message-ID: <CANiDSCt_5aArcnhLvAKKfOW4sUBNZtB0QQGkS_-AWmTxh_vKMA@mail.gmail.com>
Subject: Re: [PATCH v15 17/19] media: uvcvideo: Add sanity check to uvc_ioctl_xu_ctrl_map
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ricardo Ribalda <ribalda@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 15:12, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> > Do not process unknown data types.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_v4l2.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index 5000c74271e0..4c88dab15554 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -106,6 +106,12 @@ static int uvc_ioctl_xu_ctrl_map(struct uvc_video_chain *chain,
> >       struct uvc_control_mapping *map;
> >       int ret;
> >
> > +     if (xmap->data_type > UVC_CTRL_DATA_TYPE_BITMASK) {
> > +             uvc_dbg(chain->dev, CONTROL,
> > +                     "Unsupported UVC data type %u\n", xmap->data_type);
> > +             return -ENOTTY;
>
> This seems like a textbook case for -EINVAL ?

Indeed, :) https://lore.kernel.org/linux-media/8258ce59-cd06-46ba-b275-97eb9ae4d64c@redhat.com/T/#m2d38a4cf184ad3e4ea335e92ea74258d1da267c1

Thanks!

>
> Otherwise patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans
>
>
>
> > +     }
> > +
> >       map = kzalloc(sizeof(*map), GFP_KERNEL);
> >       if (map == NULL)
> >               return -ENOMEM;
> >
>


--
Ricardo Ribalda

