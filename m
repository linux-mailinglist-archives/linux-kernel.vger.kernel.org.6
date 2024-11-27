Return-Path: <linux-kernel+bounces-423240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A09DA4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905711625D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ED0193081;
	Wed, 27 Nov 2024 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A6cIR1kO"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920D188CB5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700171; cv=none; b=QaTBzvxzaiCeg8XRozd/pwYkFfRJR9ukpPNaAAqub0n7/YA5y/cXuk7dLviBNymtl2FAvNLmmrOC/UFjqr9erfCTkERT9oy6TR8UvmfuBDfMr0UGYdGgXKxGBxRcZP/bTOyKfqxGTNeV/w6+EnBR97H4s/rGgVU8LiW0iLbGZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700171; c=relaxed/simple;
	bh=3faT5F9J14w90KJBMsHvfrz0n9EfaIV2bM/RpbX0mzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvlf7sWtS7enft6N5S0/v3oZBS2Igs3Y8ojhVi6KIHHhhWCRyvF5++W32i1PB/JzBPxgEAjcJPEgP63+WGOonIoawNFZJYgtLbhzgYM+Ke6GQBwhgGejH4+AvchYhGUtns6CPvSr9oCY1Wlv7ma3YChiRoLInRSfd565PEQvBJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A6cIR1kO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2126408cf31so47457985ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732700169; x=1733304969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EnK2dcdalpmGY5jgzTnos37anlqTQntnz3I6QcXPIDU=;
        b=A6cIR1kO9WMZSxFXpFmBw0qxVjl31xVQM20UDU8ZfOfWQRaCvGY+ox7NRdYXN59jar
         Chh1uRoECX5tpdkUCwbg/SgPB7cCWrhA/bNNchuLwkQUULE/RvghtVRqjE7GIrU/tV3Y
         NVJ64IosAZAEJaixRpZ6HpddpT6UnXMnZ6eLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732700169; x=1733304969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnK2dcdalpmGY5jgzTnos37anlqTQntnz3I6QcXPIDU=;
        b=AsBx4KZTF7wprefZ62AHW0hZ7Wv7ixcsCgMP26wI5I9O/wOKgSb0mWOp40hG13kZjB
         rkn8CazLwnrjK1HDphKCpldt2whRHioghC6ltWCCde9tpqOgkXom6/eTgJf8IEn6kQWf
         6d7OcsezdjpWEe65Ch6Cl3FiGI7BfCMTsezZF2yuSrpODmF4yp5LGz/Hi5twfxkiwr7i
         4RCR0OTWiPUmsFpChXsKZOCBdNsxZK1WNsM9DQCKZxvqVJjGi2H+WG6teopcjDxEvZ6M
         cvgxkOeqkJLznwxkI2LU93HJ1/bsi0gzg2OzM6yl0Imy/IBCXeMNJvWPFmxjb4NDs7No
         R7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCW+zLu1rW4MC6ZMGpgahgx6/D3BU87cTJCU096SmgF1efRH24xfcmKQSVAcWL41vj1SDa4JZjy4gx+btig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhElt1xmjh3WkLtgbSsYoaREU7Jjl37E16lt2i4rUe5+cXPcK
	dd/5wdLSc098hUenzjgRdROc5W/Lf/hU3Q4n0K2W2rj1MBRhhoe6nB5PLJLPGgey7mb0B5PQY64
	=
X-Gm-Gg: ASbGncsPnSnls7I2KARoJUi/6Dm9kNPxD/DQjRvJGfurSlgZ42B6WzYgRpbWxgBOk0L
	bQ5cIJZ5tzYKNtGVHv4hUE9Th6yfcbib7bb76E8P18BPFvmjB7MeMtnyZHggMds+5mLL/8Hq4w5
	HIQspEqKxroD1pi2P/4FOQ4f85r0NfiakjmyWPPwfJkFUyrQItrtYe14XinA5LVpKLQVgB5CwMi
	Mln7YbeKjLsLCGbRl3R/0I6ZieJ8WTNBXLKytJPYnQzwVnRl34u1LYgsh6HmAMqiJZSMavadHjW
	UTunSurMKglm3Ezh
X-Google-Smtp-Source: AGHT+IHkeyOInmCna4LidnpkOusNrcDMI5AbxBS7EKzpoFj2jlgKEBE3xFTAVe/j0ZVYO0/z9TBekg==
X-Received: by 2002:a17:903:22c2:b0:211:f335:ac8 with SMTP id d9443c01a7336-21501385201mr24803385ad.29.1732700168678;
        Wed, 27 Nov 2024 01:36:08 -0800 (PST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com. [209.85.215.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc20b7fsm98948475ad.242.2024.11.27.01.36.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 01:36:07 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so5387853a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:36:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuVrAJxK/sNqq7FvFQdeZjuLj1uzNnarKOhN4tdXNTpkdpqo/2Y3TYBCmwkge+KvwPOG3eT64xC2CvP7U=@vger.kernel.org
X-Received: by 2002:a05:6a21:3289:b0:1e0:d14b:d54c with SMTP id
 adf61e73a8af0-1e0e0b58d0fmr3827817637.30.1732700166977; Wed, 27 Nov 2024
 01:36:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org>
 <20241120-uvc-readless-v4-1-4672dbef3d46@chromium.org> <20241126180616.GL5461@pendragon.ideasonboard.com>
 <CANiDSCuZkeV7jTVbNhnty8bMszUkb6g9czJfwDvRUFMhNdFp2Q@mail.gmail.com>
 <20241127083444.GV5461@pendragon.ideasonboard.com> <CANiDSCvvCtkiHHPCj0trox-oeWeh_rks3Cqm+kS9Hvtp9QC6Yg@mail.gmail.com>
 <20241127091400.GB31095@pendragon.ideasonboard.com>
In-Reply-To: <20241127091400.GB31095@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 10:35:54 +0100
X-Gmail-Original-Message-ID: <CANiDSCs8o4SFx1TJYXNcWkgrzk6COoTxOKD1a02AuO4CYKxx+g@mail.gmail.com>
Message-ID: <CANiDSCs8o4SFx1TJYXNcWkgrzk6COoTxOKD1a02AuO4CYKxx+g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: uvcvideo: Support partial control reads
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 10:14, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Nov 27, 2024 at 09:58:21AM +0100, Ricardo Ribalda wrote:
> > On Wed, 27 Nov 2024 at 09:34, Laurent Pinchart wrote:
> > > On Tue, Nov 26, 2024 at 07:12:53PM +0100, Ricardo Ribalda wrote:
> > > > On Tue, 26 Nov 2024 at 19:06, Laurent Pinchart wrote:
> > > > > On Wed, Nov 20, 2024 at 03:26:19PM +0000, Ricardo Ribalda wrote:
> > > > > > Some cameras, like the ELMO MX-P3, do not return all the bytes
> > > > > > requested from a control if it can fit in less bytes.
> > > > > > Eg: Returning 0xab instead of 0x00ab.
> > > > > > usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
> > > > > >
> > > > > > Extend the returned value from the camera and return it.
> > > > > >
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
> > > > > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > >  drivers/media/usb/uvc/uvc_video.c | 16 ++++++++++++++++
> > > > > >  1 file changed, 16 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > > > index cd9c29532fb0..482c4ceceaac 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > > > @@ -79,6 +79,22 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> > > > > >       if (likely(ret == size))
> > > > > >               return 0;
> > > > > >
> > > > > > +     /*
> > > > > > +      * In UVC the data is usually represented in little-endian.
> > > > >
> > > > > I had a comment about this in the previous version, did you ignore it on
> > > > > purpose because you disagreed, or was it an oversight ?
> > > >
> > > > I rephrased the comment. I added "usually" to make it clear that it
> > > > might not be the case for all the data types. Like composed or xu.
> > >
> > > Ah, that's what you meant by "usually". I read it as "usually in
> > > little-endian, but could be big-endian too", which confused me.
> > >
> > > Data types that are not integers will not work nicely with the
> > > workaround below. How do you envision that being handled ? Do you
> > > consider that the device will return too few bytes only for integer data
> > > types, or that affected devices don't have controls that use compound
> > > data types ? I don't see what else we could do so I'd be fine with such
> > > a heuristic for this workaround, but it needs to be clearly explained.
> >
> > Non integer datatypes might work if the last part of the data is
> > expected to be zero.
> > I do not think that we can find a heuristic that can work for all the cases.
> >
> > For years we have ignored partial reads and it has never been an
> > issue. I vote for not adding any heuristics, the logging should help
> > identify future issues (if there is any).
>
> What you're doing below is already a heuristic :-) I don't think the
> code needs to be changed, but I'd like this comment to explain why we
> consider that the heuristic in this patch is fine, to help the person
> (possibly you or me) who will read this code in a year and wonder what's
> going on.

What about:

* Some devices return shorter USB control packets than expected if the
* returned value can fit in less bytes. Zero all the bytes that the
* device has not written.
*
* This quirk is applied to all datatypes, even to non little-endian integers
* or composite values. We exclude UVC_GET_INFO from the quirk.
* UVC_GET_LEN does not need to be excluded because its size is
* always 1.

>
> > > > I also r/package/packet/
> > > >
> > > > Did I miss another comment?
> > > >
> > > > > > +      * Some devices return shorter USB control packets that expected if the
> > > > > > +      * returned value can fit in less bytes. Zero all the bytes that the
> > > > > > +      * device have not written.
> > > > >
> > > > > s/have/has/
> > > > >
> > > > > And if you meant to start a new paragraph here, a blank line is missing.
> > > > > Otherwise, no need to break the line before 80 columns.
> > > >
> > > > The patch is already in the uvc tree. How do you want to handle this?
> > >
> > > The branch shared between Hans and me can be rebased, it's a staging
> > > area.
> >
> > I will send a new version, fixing the typo. and the missing new line.
> > I will also remove the sentence
> > `* In UVC the data is usually represented in little-endian.`
> > It is confusing.
> >
> > > > > > +      * We exclude UVC_GET_INFO from the quirk. UVC_GET_LEN does not need to
> > > > > > +      * be excluded because its size is always 1.
> > > > > > +      */
> > > > > > +     if (ret > 0 && query != UVC_GET_INFO) {
> > > > > > +             memset(data + ret, 0, size - ret);
> > > > > > +             dev_warn_once(&dev->udev->dev,
> > > > > > +                           "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
> > > > > > +                           uvc_query_name(query), cs, unit, ret, size);
> > > > > > +             return 0;
> > > > > > +     }
> > > > > > +
> > > > > >       if (ret != -EPIPE) {
> > > > > >               dev_err(&dev->udev->dev,
> > > > > >                       "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

