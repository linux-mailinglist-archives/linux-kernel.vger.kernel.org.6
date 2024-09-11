Return-Path: <linux-kernel+bounces-325527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63904975AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D1E1C2241D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C571BA86F;
	Wed, 11 Sep 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QmUxzc0N"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333CF1BA28F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082870; cv=none; b=m9TkOFY++7siZ9/hmJyPXMSzZz1QqWC/A7y7T38jz1NpsCGuh91tijAkQ4TQvOgoS50ZnsyJ1jpWZGiqAIjsGxt8328pwnjo9Vx13j+IzTm6KjFWdjS7dylncVJkUE+SNJAJPzXqePaQD+1cnNalLExAw3V0zcrMzCA4jh26jqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082870; c=relaxed/simple;
	bh=28VQxxTcF6zriSW//kiDBloDgrUWMiPf3s4r6H2DoeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMxcRI2kMbODWtQ87qHH6RiYZyyqrtFjgHFPW3RexoiXZoiRDHmHgo0y8rtZbmxA01FX52C1xANRpjpV/VP/4qOxoidGEKk7ntbjbOJcnes5SMh06a5OzN6GibqwvSw0l6xZ6LG3b+q3GfdrUTmi5UnEseU6vockziJHLfFI0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QmUxzc0N; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53659867cbdso242768e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726082865; x=1726687665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVNn2ed2GBXRXi1IS2byeByLJGlVq8ZELsiy66KEkNM=;
        b=QmUxzc0NMI+Gw3nYTWZ8pHFwF2doPnLEKY2+kx/12AiTOVys85NyEFL/6tdB1vMb5N
         s86zic89XqHQgvlaNSto/MPbnm0JU1yYzutX8DHibdZtb+LdRp6Q4SCuzPL0lgXv9C0F
         catIz9V4+9uGUQyFI+VCDzFuSzUQgOfh0eJsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726082865; x=1726687665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVNn2ed2GBXRXi1IS2byeByLJGlVq8ZELsiy66KEkNM=;
        b=XMDpxivxgE+uPBnB0SkqE86/TVTK8ZCE+iyPek5WdBKzTgOL2gc5PT1T4xZVcxsjIy
         +zlpZ07DT/6rPJI9Rd+PNlPflphh2FYyav93npyvOu/r5qwUnPZDD1NXMT15krWNaNrl
         U0EurJfOWE2Jj9y5tfejmeaHjAcP3br4CCedEwxLOs0CXtgkjN5PPWgUcM1R5bIkFst7
         x8YHb6OmEWHFAre0Yup+tqLPlmRGfoEvzg+YcrBQCJq787XBdfRWWaIpqBTZsFRQ6eJT
         zmTToe2fcOuKJMLQEaexr2sg5maT8ZtBuFDZsRdp8diHux+TnZBEbvhgwMxsJb+O3Vmn
         eYVg==
X-Forwarded-Encrypted: i=1; AJvYcCVUfMDSTwX/VV3bb4ZAR0+ZOtJPy++HOpTWeyi/QduXg7QIvPLeOw6y0YRYvy4ZKJTmIU4XpwktPrZDEqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTFoKzarzE9wU6sjOoszv7JJy4MyR3HgDm2NDsdDBg1fUVnTmU
	9yDs7/XlPtwtk0jb/kmXhkE8Y5nfuI325tgTtXMsNj5F1V2fJm8zsQR8bleyc/XBoV3Ck6EY1kU
	QSDddXWzIGn3UCRVNZ2uE2kOxKK3i9y5MdfuD
X-Google-Smtp-Source: AGHT+IEW2bxQx2PeMhxbvntpzjVnkkvCp2gCzaOGUyXEwbimgXH5Avs6JFBqhKxW4Eh2kobLxWBwS7SfV7odLAGzdEE=
X-Received: by 2002:a05:6512:ac9:b0:52e:932d:88ab with SMTP id
 2adb3069b0e04-53678fb7165mr370248e87.23.1726082865014; Wed, 11 Sep 2024
 12:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906211445.3924724-1-joshuapius@google.com>
 <878qw2d1ry.wl-tiwai@suse.de> <CAFs7P=g8Pqk2-WH8kX6spNSjJ8x80GnDur0ny2CvpzTKb7oa+Q@mail.gmail.com>
 <87o74v7w43.wl-tiwai@suse.de>
In-Reply-To: <87o74v7w43.wl-tiwai@suse.de>
From: Joshua Pius <joshuapius@chromium.org>
Date: Wed, 11 Sep 2024 15:27:34 -0400
Message-ID: <CAPUqXZAabm2xCK_H9bf=JBZk25BXKzsCUtcGEv0dHsMCyUTcZQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Add logitech Audio profile quirk
To: Takashi Iwai <tiwai@suse.de>
Cc: Joshua Pius <joshuapius@google.com>, alsa-devel@alsa-project.org, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	"Steven 'Steve' Kendall" <skend@chromium.org>, Karol Kosik <k.kosik@outlook.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Done.


On Tue, Sep 10, 2024 at 4:25=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 09 Sep 2024 04:03:36 +0200,
> Joshua Pius wrote:
> >
> > Yes, this change is for UCM profiles.
> >
> > Yes this should be a one time occurrence as afterwards effort is being
> > made to migrate over to UCM v2.
>
> OK, then I'll take it.  But, I noticed that your Signed-off-by tag was
> with google.com address while you submitted from chromium.org.
> Could you align those?
>
>
> thanks,
>
> Takashi
>
> >
> > Thanks,
> >
> > Joshua P
> >
> >
> >
> >
> >
> > On Sun, Sep 8, 2024 at 3:47=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wro=
te:
> > >
> > > On Fri, 06 Sep 2024 23:14:38 +0200,
> > > Joshua Pius wrote:
> > > >
> > > > Specify shortnames for the following Logitech Devices: Rally bar, R=
ally
> > > > bar mini, Tap, MeetUp and Huddle.
> > > >
> > > > Signed-off-by: Joshua Pius <joshuapius@chromium.org>
> > >
> > > Is this change needed only for UCM profiles?  UCM v2 should be able t=
o
> > > handle better to identify models, and such short name updates aren't
> > > needed for them.
> > >
> > > OTOH, I don't mind much to take this kind of small harmless changes
> > > (unless it happens too frequently).  So I'll likely take this, but
> > > just for verifying the situation.
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> > >
> > > > ---
> > > >  sound/usb/card.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/sound/usb/card.c b/sound/usb/card.c
> > > > index 778de9244f1e..9c411b82a218 100644
> > > > --- a/sound/usb/card.c
> > > > +++ b/sound/usb/card.c
> > > > @@ -384,6 +384,12 @@ static const struct usb_audio_device_name usb_=
audio_names[] =3D {
> > > >       /* Creative/Toshiba Multimedia Center SB-0500 */
> > > >       DEVICE_NAME(0x041e, 0x3048, "Toshiba", "SB-0500"),
> > > >
> > > > +     /* Logitech Audio Devices */
> > > > +     DEVICE_NAME(0x046d, 0x0867, "Logitech, Inc.", "Logi-MeetUp"),
> > > > +     DEVICE_NAME(0x046d, 0x0874, "Logitech, Inc.", "Logi-Tap-Audio=
"),
> > > > +     DEVICE_NAME(0x046d, 0x087c, "Logitech, Inc.", "Logi-Huddle"),
> > > > +     DEVICE_NAME(0x046d, 0x0898, "Logitech, Inc.", "Logi-RB-Audio"=
),
> > > > +     DEVICE_NAME(0x046d, 0x08d2, "Logitech, Inc.", "Logi-RBM-Audio=
"),
> > > >       DEVICE_NAME(0x046d, 0x0990, "Logitech, Inc.", "QuickCam Pro 9=
000"),
> > > >
> > > >       DEVICE_NAME(0x05e1, 0x0408, "Syntek", "STK1160"),
> > > > --
> > > > 2.46.0.598.g6f2099f65c-goog
> > > >

