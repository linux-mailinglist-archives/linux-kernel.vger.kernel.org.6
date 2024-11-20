Return-Path: <linux-kernel+bounces-416000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFF69D3EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B72D1F22DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A8C1AA7AA;
	Wed, 20 Nov 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bHFzHwqk"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA745BEC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116381; cv=none; b=a9yyFBSlPgM62P5Hsm1sg7YQnw8deNgCByoG+EgYVPofRc2senjHYumuegHSe1iBR8Jas4IMIDwhcUB9Pap9BScOqS8vd0zMggLrtbOI9Q5oLVhzJFfZ1ItM7e0VmVgA2fIvQ4OzwkUIX5pa5NBBlJTWgm35t+f4BhYxqYKFC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116381; c=relaxed/simple;
	bh=aEpeVL2+MvWMIJH2w921LzuXKvdlr+VXZnWB0rIrw7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTMqna8rx2Zjkz2neqXA26mkVTpCDXLv4GatJ0JjrB+qUSEpd2O1NQYzHfjuXaz/CykaCkR41lBuhyjaVEO0EoO1HZj4MvrxNqi9tq4rtBEusM6QfaRMaTJiLmNDvCX4oy4WFRZQM2IgN48zhJgUWdDHu8VxPl2hx0U8P3VnBG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bHFzHwqk; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so1718169a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732116379; x=1732721179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aiMUFCvmVqIUzNlDz47PSTDNdFjqdtwhxW4WFLT6+Bw=;
        b=bHFzHwqkjf6x7GVq0kbB80ZlzEmzTY7mN8v8ReJpYbgeBKg8B3F9YfHqy2XI/2FZ8w
         XDICrP4u7IBblX5SY9TO90WfJOG/g7wpHQ7U4ogJT5I39Y3Yg5ZCtobyCJlCxjOA8SEL
         USUfYdFIjNAFtuvF5+AlY4TikTaUnAqyiKAxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732116379; x=1732721179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiMUFCvmVqIUzNlDz47PSTDNdFjqdtwhxW4WFLT6+Bw=;
        b=Xt4z2Xo8A3afN/pIdiPyx7Urzgv+qy7w50VxBRQEK0SGqUP+nuzQihff2SzTgGOgjn
         h2F47DR/vO72cFhEF5wBlMIF8aXP1KhgWTBId0s4ED/XA334Yk9vcSxk1wwVSCM2ynXl
         i/KSlUJYY+O3Znn3NAgMIS7a0ffVm1vLass1jsT/aSIJYDoumyca9YY3bBCPNtLSLsHs
         /+XugCFi2LCK83HgrTRzbKWH7OCmg6Q29ahjkOYc5odgZLO0RmLT4oklcyr3oOXcaZD/
         YsVGj4HWyaTUlAfbojQzLhit1mykptJ26eynaktz6EW3yBh82pxVaRny7eNRGqGwqKe1
         nNPw==
X-Forwarded-Encrypted: i=1; AJvYcCV3PqARJa8DVc8/DaEmoFqFu2YpSQDiS/QPKMKON90sntKNH7h6S71JMWaSQ/2/3joOwK8JnnB15grVYK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8SqZYRBX5FZGJrEzCexg6ZMZZU33MbTNm6q/KSHWSUB+78Vtm
	4jJmf5EYDnC1rDpMlgJ+bWEFoZLvRo3tb0WtnH81cmtKy2QMsgy4xYN53DFIuBdOoJgCQA640VI
	=
X-Gm-Gg: ASbGncvzDdkx79ZUseoJTUClpAdCe97Kh1WKSpLKB0hAL3X/uCylCTDUEIjx8K1eP4e
	vjaYEh6DnCc7+du2lidNZnuVlx7WzGA14rlo278Dwce2842AsXx0/pvgzJCBlTAe7fMZZypFjzB
	CmKV9PUd440VS6ubi1ssgdIcO6wgZzpP6pNxyiwV10J+vHJwFgyq++nR13W1B/mwH9WB3hr03Xm
	KDdlxPjcK3TVTyVcjHdnzrNa8+ENqn5XgPi0GiGGb2fQlnOL6GcPELkctGGKH9sZsHMNs0fbjUr
	627jO+9xX6AyEs8U
X-Google-Smtp-Source: AGHT+IGs5YEFlMi/Tv6El2a5bo8wK/UqD3WcVG7LMYSR8zl1xTZx8zsqFRmunkdLWV+giYEsKRVmiQ==
X-Received: by 2002:a05:6a20:d504:b0:1dc:19d4:3754 with SMTP id adf61e73a8af0-1ddb0625021mr4947100637.35.1732116379106;
        Wed, 20 Nov 2024 07:26:19 -0800 (PST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com. [209.85.210.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212500a217esm32966375ad.43.2024.11.20.07.26.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 07:26:16 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72410cc7be9so2158119b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:26:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNe/2+i0tT3QAzpMqajH5gDXqVpPOlqJOJaK3735FzW/YlFdm4pNXy/kY2uPLkrEB2N2c+OlGelhRvuDA=@vger.kernel.org
X-Received: by 2002:a05:6a00:2355:b0:71d:eb7d:20d5 with SMTP id
 d2e1a72fcca58-724beca42camr4163959b3a.8.1732116376003; Wed, 20 Nov 2024
 07:26:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org>
 <20241118-uvc-readless-v3-1-d97c1a3084d0@chromium.org> <20241120140526.GW12409@pendragon.ideasonboard.com>
 <CANiDSCvazZ4Y3OZ9X7chU-_N-4HbeQKUh23eOWkmkAxGaks2QA@mail.gmail.com> <20241120145341.GX12409@pendragon.ideasonboard.com>
In-Reply-To: <20241120145341.GX12409@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 20 Nov 2024 16:26:04 +0100
X-Gmail-Original-Message-ID: <CANiDSCtX9pPS=YLmeCLerbcuvQEwbNiGX4uod=iLSNJnQ9-tQg@mail.gmail.com>
Message-ID: <CANiDSCtX9pPS=YLmeCLerbcuvQEwbNiGX4uod=iLSNJnQ9-tQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] media: uvcvideo: Support partial control reads
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 15:53, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Nov 20, 2024 at 03:43:22PM +0100, Ricardo Ribalda wrote:
> > On Wed, 20 Nov 2024 at 15:05, Laurent Pinchart wrote:
> > > On Mon, Nov 18, 2024 at 05:16:51PM +0000, Ricardo Ribalda wrote:
> > > > Some cameras, like the ELMO MX-P3, do not return all the bytes
> > > > requested from a control if it can fit in less bytes.
> > > > Eg: Returning 0xab instead of 0x00ab.
> > > > usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
> > > >
> > > > Extend the returned value from the camera and return it.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_video.c | 16 +++++++++++++++-
> > > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > index cd9c29532fb0..e165850397a0 100644
> > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > @@ -76,8 +76,22 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> > > >
> > > >       ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
> > > >                               UVC_CTRL_CONTROL_TIMEOUT);
> > > > -     if (likely(ret == size))
> > > > +     if (ret > 0) {
> > > > +             if (size == ret)
> > > > +                     return 0;
> > >
> > > Why is this within the ret > 0 block ? I would write
> > >
> > >         if (likely(ret == size))
> > >                 return 0;
> > >
> > >         if (ret > 0) {
> > >
> > > > +
> > > > +             /*
> > > > +              * In UVC the data is represented in little-endian by default.
> > >
> > > By default, or always ?
> > >
> > > > +              * Some devices return shorter control packages that expected
> > >
> > > What's a "control package" ?
> >
> > usb control transfers.
>
> Ah, did you mean "packet" instead of "package" ?
>
> > > I think you meants "than expected", not "that expected".
> > >
> > > > +              * if the return value can fit in less bytes.
> > > > +              * Zero all the bytes that the device have not written.
> > > > +              */
> > >
> > > Do we want to apply this workaround to GET_INFO and GET_LEN, or can we
> > > restrict it to GET_CUR, GET_MIN, GET_MAX and GET_RES ?
> >
> > I believe that the original behaviour before
> > a763b9fb58be ("media: uvcvideo: Do not return positive errors in
> > uvc_query_ctrl()")
> > was used for all types. I think the safest thing to do is to go back
> > to the old behaviour.
>
> I don't see how reverting that commit would help, or how that's related
> to the question at hand.
>
> I understand the device you're dealing with shortens transfers for
> integer values when they would contain leading 0x00 bytes. The
> workaround should be OK when retrieving the control value or its limits
> and resolution. I wonder if it would be dangerous for GET_INFO, which
> retrieves a bitmask. Does the device you've tested this with skip the
> MSB for GET_INFO as well ?

I have not seen it mangling GET_INFO. Let's exclude GET_INFO it from
the quirk then.



>
> Conceptually GET_LEN could be similarly excluded from the workaround,
> but it will never take this code path as it's a 1 byte value.
>
> > Let me know what you prefer.
> >
> > > > +             memset(data + ret, 0, size - ret);
> > > > +             dev_warn_once(&dev->udev->dev,
> > > > +                           "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
> > > > +                           uvc_query_name(query), cs, unit, ret, size);
> > > >               return 0;
> > > > +     }
> > > >
> > > >       if (ret != -EPIPE) {
> > > >               dev_err(&dev->udev->dev,
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

