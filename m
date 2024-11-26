Return-Path: <linux-kernel+bounces-422702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EBF9D9D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC442830BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF761DDA17;
	Tue, 26 Nov 2024 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LZqBIgWX"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EEA11187
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644789; cv=none; b=T4LUyCp/x/y5sqR4tOJOX5z6pVWmDkGbept89FD5tkcK7239dUcjsvUrQWdEBiu8JAW9U0Tp2CjqUPMaDHfdAlhAWtm7r6UvMCS7FWWW3ha7KZAHByIwyU/QicdtO8DwzxJolZvjWtTlFyXZ5wM3LbSueFv3OcpApQRMpgMwazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644789; c=relaxed/simple;
	bh=N5DXqLLENJurn1n1t0P92WWNwx35eWFGM+6sfF7P2Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHT5Avwp1YsBFBtPeaBRlI9N8fuh0pyyZBfK6WqZ+MlSdMaP3an/V0KGY82ph7k6zN8N1FkOmhPXJ6RtLNHvnxjfxaQ/VXz0IWooJ+VTx4sgOSWtTIKzRU+tPd/Ysb5ISI+TfYEeBOF+qRc85t7HYfDuksd2nL9TX7rZ3++TzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LZqBIgWX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ede8c4fedeso1171364a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732644787; x=1733249587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DRDHH9mII91Onr/ViRKZaUWx6zHyVw0QRYxvAkTS5oQ=;
        b=LZqBIgWXXELEi5P1qyZGXH8IxW7yB1LRjBbqvguAOnFsjrBRHIxoDyTrQNsKQVcgu8
         pfB/si+MBFJxOxnVlZmubTR006Pue8ORxqxWVSLTg6ysdr5L2HKndPTjhaFm/7vSsvCj
         EX8SHUvrFlnMDJK5bKt4dXN9/5hbe0mMI8jfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644787; x=1733249587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRDHH9mII91Onr/ViRKZaUWx6zHyVw0QRYxvAkTS5oQ=;
        b=icVVZW0D3psn1dqDAG/LNXtzL6z7K+jUyTav+nWD47BTfmcz5S5OG0jLNIxgNi6Ut7
         hx7hq7Bs3X+5GkWkKPZuzmBZ/HyjWhtv+JRLHdtVGiA38y7BjlH4Io4aOewyETw/cJ5S
         yGBsURUb+UFunreV+YH2idni0vHMT/2IB4bcBEm7luoJTBRMwjl3CWZ9SNmAwZtsO6Sw
         GQPFrlGPaqfcaebP5rLd0N3Ci9s5W0kGCVnkPRBn6dwweRMPqD869ktLaBIVDg+MNXVP
         HAOe4GzPe9Hr1H74HNZf6XLptq7uIpNYcJRniTXjpqDXYh+NQR0gn4O8EVyVgIiB2mrE
         VYTA==
X-Forwarded-Encrypted: i=1; AJvYcCUb2HVhOoWz0U98l0zTwVqaqe5dqTdNr08CUFZgsJckpCHQqtVtXv+plOvJUFRmET5kDcQ0AlToA5Ag9wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkkAobIIE8dXzbG74DuLd0h33GMoGfA0vnaZuOVmmlN1qPNwOi
	CUKncUwOP1XAoqkIjzzMJOw9ggLc0S7Haq8aXnZgtzTPdbmLXk2bJnteqENJH3lmUUbIxFzp2qQ
	=
X-Gm-Gg: ASbGncv2S9xINz66kte+vX/wBLHs7eN9yD0QAFXpwOb/w3Bf724Eq7J1mkk+qs7Dkxw
	3s7BW+Ff5vqFFM4bRhu1WGxbopvavpWOp4580qZSJFonB+uycaQaPsItuEtI91WuHTmQpWW6tTt
	3JPzNwu5tJcT06MEHhWYLIrXcRF9JCE9tZzW9yLZ5DkniG4pbG2ApGQ15Yu28MP7hiMDkEoVRkv
	1JP9lHHDo9VLTDDc1OZ3lWkEH9GG1xT/+nPgUC3eMw0pB7LkTqD9BtAiH1yk7wguDhlpJVKgOTn
	sosb/mkN2gqbuVMU
X-Google-Smtp-Source: AGHT+IFwfUozuObImAAUQW3j6Nqw44jtV1bUEVQwlhZNFMX43/TJEPvqNbQRtGLNzAwGnd0zXlnorQ==
X-Received: by 2002:a17:90b:3a82:b0:2eb:140d:f6dc with SMTP id 98e67ed59e1d1-2ee08e9d257mr338062a91.7.1732644786776;
        Tue, 26 Nov 2024 10:13:06 -0800 (PST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com. [209.85.215.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d0623e9sm9158987a91.46.2024.11.26.10.13.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 10:13:06 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so4872819a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:13:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXT6Jq+TsNTk1jtT6/YbNe9dG5MBHyQk6Dfln/nvhNhHzFvG0HaF3ha5Wn78Ded5OrnITaogv61ZptPK7E=@vger.kernel.org
X-Received: by 2002:a05:6a21:39a:b0:1e0:dbfd:d254 with SMTP id
 adf61e73a8af0-1e0e0b8cbf0mr485269637.41.1732644785584; Tue, 26 Nov 2024
 10:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org>
 <20241120-uvc-readless-v4-1-4672dbef3d46@chromium.org> <20241126180616.GL5461@pendragon.ideasonboard.com>
In-Reply-To: <20241126180616.GL5461@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 19:12:53 +0100
X-Gmail-Original-Message-ID: <CANiDSCuZkeV7jTVbNhnty8bMszUkb6g9czJfwDvRUFMhNdFp2Q@mail.gmail.com>
Message-ID: <CANiDSCuZkeV7jTVbNhnty8bMszUkb6g9czJfwDvRUFMhNdFp2Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: uvcvideo: Support partial control reads
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 19:06, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Nov 20, 2024 at 03:26:19PM +0000, Ricardo Ribalda wrote:
> > Some cameras, like the ELMO MX-P3, do not return all the bytes
> > requested from a control if it can fit in less bytes.
> > Eg: Returning 0xab instead of 0x00ab.
> > usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
> >
> > Extend the returned value from the camera and return it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index cd9c29532fb0..482c4ceceaac 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -79,6 +79,22 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> >       if (likely(ret == size))
> >               return 0;
> >
> > +     /*
> > +      * In UVC the data is usually represented in little-endian.
>
> I had a comment about this in the previous version, did you ignore it on
> purpose because you disagreed, or was it an oversight ?

I rephrased the comment. I added "usually" to make it clear that it
might not be the case for all the data types. Like composed or xu.
I also r/package/packet/

Did I miss another comment?

>
> > +      * Some devices return shorter USB control packets that expected if the
> > +      * returned value can fit in less bytes. Zero all the bytes that the
> > +      * device have not written.
>
> s/have/has/
>
> And if you meant to start a new paragraph here, a blank line is missing.
> Otherwise, no need to break the line before 80 columns.

The patch is already in the uvc tree. How do you want to handle this?

>
> > +      * We exclude UVC_GET_INFO from the quirk. UVC_GET_LEN does not need to
> > +      * be excluded because its size is always 1.
> > +      */
> > +     if (ret > 0 && query != UVC_GET_INFO) {
> > +             memset(data + ret, 0, size - ret);
> > +             dev_warn_once(&dev->udev->dev,
> > +                           "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
> > +                           uvc_query_name(query), cs, unit, ret, size);
> > +             return 0;
> > +     }
> > +
> >       if (ret != -EPIPE) {
> >               dev_err(&dev->udev->dev,
> >                       "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

