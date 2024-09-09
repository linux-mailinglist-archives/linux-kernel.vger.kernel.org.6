Return-Path: <linux-kernel+bounces-320539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0D9970BB6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE741F209A7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39462171A1;
	Mon,  9 Sep 2024 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTzOy8i1"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014B511CA1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847457; cv=none; b=qlDGwcAY1TXnHVbC/8F+ju5IEm1QrJ6r+art+Y9v0F4JMtkyg+DkVyLBGbElmfRooOqm9aaUiSZgYdekrXbyBUmAC1jcUwHko+nj3CGUNe3Nm3t8TbUOcUEhRUe5abVrNzJpXXM9MW/JnMs1sgr3RljF2GPihQHM0A/D8cLp6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847457; c=relaxed/simple;
	bh=HhFHAkcIkSLH9d0maMPyRChdvunG8qAN1QPbL49mMfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCxpht7PSfL1gC31SwGNWnBUpYHSX/aYFDPIFwZF7jHUbQZ97HDCpzCMa4iH0ZKEuDvBq4yk1eLlC8RDJtInlLF52iICVmZs+P+Ew5LKQ1BgGOT2oXR84sAr6s890lNt9WT8n8o7Foij5g6J9XjjYgLwpy4UVQ86wnEEkc7U5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTzOy8i1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb417182bso245e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 19:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725847454; x=1726452254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMyPt7AhPbkwJLr/QUbCyAauSRNgXD7xB86A6jpKbvI=;
        b=oTzOy8i112zpwoN3Bz64bUUO2bnTqIWInxo3aR2cMboaY+STdfHiKzM1hass3qb8ZW
         4bnPZTfHycyJolmYON1KHTtiYnDKXRhIejqoDs+3Qo0Jvu4S6ueMXr0nWiOL+sdNMvKw
         A8bKo3dIT9iKG6DvuZj9HM3z2UdhbGiRME9jDFWjYzxFEMjxA5khwWko7U7WBPjLHMX+
         Jc0+HK50W3fFtP02oja/+kwaiWaOKX1BhdNjPvlJqPSKoMvlFH3wwHYKJu0dLgKlCaXs
         pJkNzEuMRYI3V5hAZMmHoxy958DYX/uqq4cNQck8HZvxKoQcGnIYHr8vcmcrlRN+LFuo
         9GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725847454; x=1726452254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMyPt7AhPbkwJLr/QUbCyAauSRNgXD7xB86A6jpKbvI=;
        b=hCj3LtGAv4frSQaXRfDhjLYqX0lBsgUH9XAQzI98LYgAuhR4noWrIkAYNodZcEPXlX
         dcC+3+OVwTkNICEK4lCNEGDvqQ/Nky90c/K+OyNNQLgvtLFaC6jn1dil93GzrtVySNFA
         IbuEUAja5bXhPXHMASSIW6WMGGQnP1OIWV1nwmc9v1Y6XnxRLTb10hyu27jWYCqM4grS
         hQ+D9cfitrfO7no2B9v44PVDIbwMxZiZbnFvC3t40tRNrOg5MLaC9bfYXeBiGn4Ti+BX
         6cfEHW5TK7P2vBs6wZJUKO+XoMaGScNLfEMt2syuYYhnca0NLvQYkJvPqZUVf10xlW4B
         x+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUrgwMt330dW6VPKzXh0WDItp7SAYi8hmYnBOc0l7G6pmpgnJ+mGMGsBpv50CVlZGU0fKLoNoqBhf4ZKSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHplibGFbxDnZVlAI+JQzRv/oyzKbKkUiqx4TIAMGKaO9jpIi
	Ex9H4GhuimY0EhhdzafwuV9NMspTIJMdAFxMzhVho7RSl5UoHobewZj1K3pbtabpKgR+O/t+RTT
	0Fy6OO/D2a/KqH+lDcd8ZFBJBv2Z67omTw4Y=
X-Gm-Gg: ASbGnct3w2aB4yamav0P1zbw1ujTjAnDSHIvlL6RNhbJL5VQ2c6ofXrcvfbMmEKZuEe
	G4+PJm6nrwGNkhu3jJehV9YncpzVWAmeNPHL1kGTqkdJmsCW0d0KT0BulHBWE7Vrc
X-Google-Smtp-Source: AGHT+IHBuiIVx/1GaXcuzHos7shtGEUjI71oFo8vaT0N0MHIstJosoRZ+W29ygUeClp98PfK53cU1PezpJckObMmvS0=
X-Received: by 2002:a05:600c:1c13:b0:424:a2ae:8d1d with SMTP id
 5b1f17b1804b1-42cb9d53133mr3975e9.2.1725847453147; Sun, 08 Sep 2024 19:04:13
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906211445.3924724-1-joshuapius@google.com> <878qw2d1ry.wl-tiwai@suse.de>
In-Reply-To: <878qw2d1ry.wl-tiwai@suse.de>
From: Joshua Pius <joshuapius@google.com>
Date: Sun, 8 Sep 2024 22:03:36 -0400
Message-ID: <CAFs7P=g8Pqk2-WH8kX6spNSjJ8x80GnDur0ny2CvpzTKb7oa+Q@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Add logitech Audio profile quirk
To: Takashi Iwai <tiwai@suse.de>
Cc: Joshua Pius <joshuapius@chromium.org>, alsa-devel@alsa-project.org, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	"Steven 'Steve' Kendall" <skend@chromium.org>, Karol Kosik <k.kosik@outlook.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, this change is for UCM profiles.

Yes this should be a one time occurrence as afterwards effort is being
made to migrate over to UCM v2.

Thanks,

Joshua P





On Sun, Sep 8, 2024 at 3:47=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 06 Sep 2024 23:14:38 +0200,
> Joshua Pius wrote:
> >
> > Specify shortnames for the following Logitech Devices: Rally bar, Rally
> > bar mini, Tap, MeetUp and Huddle.
> >
> > Signed-off-by: Joshua Pius <joshuapius@google.com>
>
> Is this change needed only for UCM profiles?  UCM v2 should be able to
> handle better to identify models, and such short name updates aren't
> needed for them.
>
> OTOH, I don't mind much to take this kind of small harmless changes
> (unless it happens too frequently).  So I'll likely take this, but
> just for verifying the situation.
>
>
> thanks,
>
> Takashi
>
>
> > ---
> >  sound/usb/card.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/sound/usb/card.c b/sound/usb/card.c
> > index 778de9244f1e..9c411b82a218 100644
> > --- a/sound/usb/card.c
> > +++ b/sound/usb/card.c
> > @@ -384,6 +384,12 @@ static const struct usb_audio_device_name usb_audi=
o_names[] =3D {
> >       /* Creative/Toshiba Multimedia Center SB-0500 */
> >       DEVICE_NAME(0x041e, 0x3048, "Toshiba", "SB-0500"),
> >
> > +     /* Logitech Audio Devices */
> > +     DEVICE_NAME(0x046d, 0x0867, "Logitech, Inc.", "Logi-MeetUp"),
> > +     DEVICE_NAME(0x046d, 0x0874, "Logitech, Inc.", "Logi-Tap-Audio"),
> > +     DEVICE_NAME(0x046d, 0x087c, "Logitech, Inc.", "Logi-Huddle"),
> > +     DEVICE_NAME(0x046d, 0x0898, "Logitech, Inc.", "Logi-RB-Audio"),
> > +     DEVICE_NAME(0x046d, 0x08d2, "Logitech, Inc.", "Logi-RBM-Audio"),
> >       DEVICE_NAME(0x046d, 0x0990, "Logitech, Inc.", "QuickCam Pro 9000"=
),
> >
> >       DEVICE_NAME(0x05e1, 0x0408, "Syntek", "STK1160"),
> > --
> > 2.46.0.598.g6f2099f65c-goog
> >

