Return-Path: <linux-kernel+bounces-510476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0447A31D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6382D18869D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A8F1E1A05;
	Wed, 12 Feb 2025 04:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0lMFWp1T"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA71208A7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739335739; cv=none; b=nzUoo/uc/LcRc1dyxyOZY5uZMDV7hwPIiwdoSz/dKme2IT+FuBPTBFq+2Lpl/Ampc57k0XhQum+WNKGUGA1zadCgMizF3kge8egaFi20qpmHjUPznGuKVE9TR4RmdtUF7caJbtUJ42UNSEuIMKWzKdGb2U6sTT5CSkhmWQGQvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739335739; c=relaxed/simple;
	bh=K4goNeS5jx9vOeqxSj6nPJuEvuvWZ7J5t9DWFPlyReg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2NB7/XCmlEhqat4K1OKA0TfOxeKC5YLEsnz2piUkdLcT3kQWPvdtA4D2A35foG03FF2nktFetrh/pt5BrhmskriOWrKv2zjH/aUUX3N+vBksCOyJIE05RPahqzRjn4WATZp71P/N8/UPgjFLPIxfLzIS/Gx59hYFZo66QJf0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0lMFWp1T; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e549be93d5eso6097136276.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 20:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739335736; x=1739940536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4vbUZUTkpqr3rG0okFJsZLaxVBB5/ZaX+q2Q50aqnk=;
        b=0lMFWp1TdCwacy3kz8YACkjR08+KWkzayCjpXQiLuW7PpJ2hDYLa50UZQfwraf6moE
         rnlD7L9haNaWJhbGxgwJNxFfCvVO2TJ1vNboLSwhP+Slca/akeQHgEya9dbPIkdeA3U9
         A0zB111syKdCiqXtcBQ20FCUkCnrTrudRzgapGoPPD6ktzrhZGAn0rU546xy/BcddT9W
         mVaVTGQ4UAuPkaUWNO2zRlhp7lbScglv9XjSpg5fYDUHp8lyadvahiGDXhBoksdlZbna
         eiAY7xqw/Bj25wdHIB/TZZH3sH5E2tQdx8K5jIPRdYJ3fwih749XirhQD9Wtd/mchSqv
         le0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739335736; x=1739940536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4vbUZUTkpqr3rG0okFJsZLaxVBB5/ZaX+q2Q50aqnk=;
        b=DBuKNrmb5x9U9QQUjgpi5/MDmuoD8VVWTVHSjUNh8oyecS7XzvsPolkflV+IyveT5d
         XbK0JZLik+wchRKZZrQVDE104UyOnAtW/q4CwmXD/o1WxCOKzq46+iM7Q0Viwakv0Rc7
         q9FnJqTdpGtMTjgfBc1mw9hoQ88cXV6eE+R30hn6lhIwTG1iO1lrh9L837BjYTay0cWW
         L/qbEJM7kZ7+Jp5rLrVyfyw7JfkdEiEaTrAt4K3XrDbcFDUuMQXbiLyyPDJVmNtszZXV
         kaLVgXDVV4hco2pZMweClx1+IDt/mE0fp6F/eFW40OLS4jI7SgemMNNFkYroQf5PJrQn
         FMtg==
X-Forwarded-Encrypted: i=1; AJvYcCV8PsqcqlyvcZQmGQtSNpKfeLlUUZkHJ6IXlIRnEkc59hq/81FWAaXKrW7n9M/pisaj2JB/RlLnkJqgVpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxykeuYw2vzSudpiccv2TunKex6Kn7ciQPpFBJ+JOVD/uL+ENxs
	+UGH6iWRTKgIgJh477+RNULEuq1HNal4BS64asYZTdOyFbVnJWVXUuD5Qdci2KjxvOgdad3FNuE
	FoNGgqesX7GSzNvM+V7dtv61H9CriC3rpTvXJY6Ohob1fbUP+LQ==
X-Gm-Gg: ASbGncsp1eT4e41CtBWZlW/0h7QdlgLcDyj6Elm8RwmYAH4yty7UXrB0/PKXNxJTWoc
	bsXf4i7CSrTa9fJLDxYS+KgGUikRGGYqiN2QD2mwinob/dzgTqt0RJGXfNzXrt7hG3SiwZQ3TnQ
	==
X-Google-Smtp-Source: AGHT+IE5Xh1/6K2tzqDbm+0FgeX0MVlUKWJGOy0qo7qYqOw3FVUwjaXyDF+x/vvLQfzMSijU6o6iB9CfCXWL7WTL7BE=
X-Received: by 2002:a05:6902:2d08:b0:e58:173e:abcc with SMTP id
 3f1490d57ef6-e5d9f0d2103mr1847516276.8.1739335736473; Tue, 11 Feb 2025
 20:48:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210183224.v3.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250210103244.646150-1-chharry@google.com> <CABBYNZJ1LbN_3H1pJsZ6mH1nY7ijb9nbuPSJJwqyvJnC0=U6PQ@mail.gmail.com>
 <CADg1FFe1DeDFmudxWZp3_thvTnm1N=ZOjXts0sJ7mxaUsFxE5Q@mail.gmail.com> <CABBYNZK8-8k5eZ8TZLM-g4KC_wt8VQ+jx_iryS9_xGxHt+u=1g@mail.gmail.com>
In-Reply-To: <CABBYNZK8-8k5eZ8TZLM-g4KC_wt8VQ+jx_iryS9_xGxHt+u=1g@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Wed, 12 Feb 2025 12:48:29 +0800
X-Gm-Features: AWEUYZk8ctHJOT5ECfu-lAdE4F3G2Nsn_DGEWQAHoeAfkXDpGisSwXscNHVUMjw
Message-ID: <CADg1FFcsYSM2SsyYULBzqmML67+4Hx9ipemACOv_oLCrwweiWg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org, 
	Ying Hsu <yinghsu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Thanks, that makes sense to me. I'll resolve this comment in the next versi=
on.

On Wed, Feb 12, 2025 at 6:01=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Mon, Feb 10, 2025 at 11:23=E2=80=AFPM Hsin-chen Chuang <chharry@google=
.com> wrote:
> >
> > Hi Luiz,
> >
> > Thanks for the feedback.
> >
> > On Tue, Feb 11, 2025 at 2:17=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Hsin-chen,
> > >
> > > On Mon, Feb 10, 2025 at 5:32=E2=80=AFAM Hsin-chen Chuang <chharry@goo=
gle.com> wrote:
> > > >
> > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > >
> > > > The functionality was completed in commit 5e5c3898ef49 ("Bluetooth:=
 Fix
> > > > possible race with userspace of sysfs isoc_alt")
> > > >
> > > > Fixes: 5e5c3898ef49 ("Bluetooth: Fix possible race with userspace o=
f sysfs isoc_alt")
> > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  Documentation/ABI/stable/sysfs-class-bluetooth | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Docum=
entation/ABI/stable/sysfs-class-bluetooth
> > > > index 36be02471174..1168e0318e35 100644
> > > > --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> > > > +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> > > > @@ -7,3 +7,15 @@ Description:   This write-only attribute allows us=
ers to trigger the vendor reset
> > > >                 The reset may or may not be done through the device=
 transport
> > > >                 (e.g., UART/USB), and can also be done through an o=
ut-of-band
> > > >                 approach such as GPIO.
> > > > +
> > > > +What:          /sys/class/bluetooth/hci<index>/isoc_alt
> > > > +Date:          10-Feb-2025
> > > > +KernelVersion: 6.13
> > > > +Contact:       linux-bluetooth@vger.kernel.org
> > > > +Description:   This attribute allows users to configure the USB Al=
ternate setting
> > > > +               for the specific HCI device. Reading this attribute=
 returns the
> > > > +               current setting, and writing any supported numbers =
would change
> > > > +               the setting. See the USB Alternate setting definiti=
on in Bluetooth
> > > > +               core spec 5, vol 4, part B, table 2.1.
> > > > +               If the data is not a valid number, the write fails =
with -EINVAL.
> > > > +               The other failures are vendor specific.
> > >
> > > Still not really convinced this is the right way to expose it, it is
> > > not an HCI attribute to begin with, not sure if we couldn't perhaps
> >
> > Could you tell more about why this is not an HCI attr to begin with?
> > The alt setting is bonded to the USB device which is now under btusb's
> > control, and btusb creates a sysfs node for this. This attr location
> > decision seems natural to me.
>
> Well alt setting is (obviously) not covered as part of HCI
> specification, USB is one possible transport bus of HCI, but that
> itself is already saying that we would be mixing the transport with
> actual HCI protocol.
>
> > > add another node to control it or add via USB device?
> >
> > I feel allowing this in the USB sysfs API might be an overkill as that
> > makes all USB devices' alt settings be controllable from the user
> > space. Limiting this usage in the scope of BT makes more sense to me.
>
> Not all, just btusb ones, that said what we could add another level to
> control transport specific attribute e.g
> /sys/class/bluetooth/usb#/isoc_alt than that becomes the parent of
> /sys/class/bluetooth/hci<index>
>
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > --
> > Best Regards,
> > Hsin-chen
>
>
>
> --
> Luiz Augusto von Dentz

