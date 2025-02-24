Return-Path: <linux-kernel+bounces-528317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7254CA4162E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A8216C4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F407A4414;
	Mon, 24 Feb 2025 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWlCtr56"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EFC1CAA62
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381870; cv=none; b=hQGTzFeR2I6dsTWg2pSEtuhVQcagDgI1/Qthj8hzDYAIwmN7ivNdUBDAdB74S3IMpJ+UmK+n2W9hmn73dr/drECDsXTweJOiscbLFWbq5sBL70soc+6b7ruWh+OVRtkHhJFGyODS5EsBAUKzbaq0NMUZCGuSldvNYUMpPfD7Gc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381870; c=relaxed/simple;
	bh=wKkhTzsDSb1efBGP8vXqImXH9nHH4mzn6DEm5tLiY2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umLGOFG6pCu7PDcGYRoHMy2Pb8hAGwZ7MXyUKF2rLhHU5HlC5CezNyhuv6c4iNof1US98IOr8X086BPZtaA8l+lZHsMjYpMMULi1/kxoixbuW87OdueiP8ntpsFe99eMjQQPCWKgn9S24elOE1Ui67K84V3v4Do7fNFRFgEp0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWlCtr56; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30613802a04so43198401fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740381867; x=1740986667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G22ILij8njBSzOjweCTKXJ1pvtGVjwFldH02tbpqc1s=;
        b=TWlCtr56vWOS13GnuMfEvkh5U7av7o8knB7yQTAbj5+9vyDU8SzMRUgDBnf/B+oGVM
         dsVVsvorwU0KY9inlcpKTVkqrFD+rVDyRp4sjRAgc5DdXkg25/o+tpEe3zCSBdoLZZCc
         746ClGKT3u27t7F6lt8pcp1TcMMbHuJyN7XElY9YgE53FUWmjyWgyJdc3Qjpvsx6Zkm8
         PoI996lvSB+JiqN7SfAJoewEuRIyLgjdy2FTKFDS3B78kHDJL3d5eImJGninJP31t1uv
         7jd+f34qhI9WYzW7ywJmlOhsvzxrA3sv+OTix+IaJtSO+otGoYCKqSCIO7SHqcvB/t6d
         H1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740381867; x=1740986667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G22ILij8njBSzOjweCTKXJ1pvtGVjwFldH02tbpqc1s=;
        b=WStz3hJrcehO9NrHPXxgCQFLF//rbEsZWtXmmbW2QFcunanhEieYE9fXNAZ6yan/z1
         P5yh/SRp8XtG6EGiixSwrxcfjEw3ffFjFr57pP4N1u3j8BYkEwXVDPJNVjSeSbcnA2Hd
         GwYc+XwpKUy3BCnBKzs9Wn0+LXdXDSGEtH6+Rk/3giBAwp6lw397CBOfAdPnR0iZjjnt
         NwwLbUA4jybcu3mtCMAOy/QFqa/MbOVR9XOG8g2YqnWafOmChNNtcSHHxQWsOaMkteHL
         4ycUe1pBkgF9Ot+f3zHstTzMnWOw+JJvZQ/4JVOL3xLDeeGlksAApcfHCksvWxlvx4WM
         4gdg==
X-Forwarded-Encrypted: i=1; AJvYcCW4qTJ+9J59GbKQo+KSGfaV+8QUM0l5ou6kZaCkD8xyQph3AiQUjc37KhWO2/22fMkh+SaZdjWoX7j4Jaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4uWjDHc37JZ68pkwHlCJFXFYg+dfFmwxXYMn43Q1kq3rN10Q
	rjvsXVwIM5Fj5+vWqzHlbjh+VsIudNXWWhcB+F9IEVQ8sodcy4l0Ly615VGqMCsZPpfthYf+rnu
	MyoVJcwKlIw0uHjSatR5LF7oTkXk=
X-Gm-Gg: ASbGnctsGrgHzGMrx5n9FtVLjeVHuwHtmzbb8XZ4jllrUZ31LpWWvHlud93zmd4a6Fi
	WOA5R7kjS+SopqJxQiZAkIn8DAQhCbHCiyDv5CYf7Hcr4RoH1acRMpk3b530m9ztlLrau3Jpajz
	7g5POSOv6+
X-Google-Smtp-Source: AGHT+IFZOn0rVAzGe6Q3yijVzxFT7K0H1QEjYK2Kl27VSIuvKSvr+a4IJ8kW0jyGmv4r3j4A6uXmDucwtjKMAZyNp1o=
X-Received: by 2002:a05:6512:e88:b0:545:2f0d:8836 with SMTP id
 2adb3069b0e04-548392598f5mr4086669e87.40.1740381866544; Sun, 23 Feb 2025
 23:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129154920.6773-1-ubizjak@gmail.com> <31e1c7e4-5b24-4e56-9f17-8be9553fb6f9@kernel.org>
In-Reply-To: <31e1c7e4-5b24-4e56-9f17-8be9553fb6f9@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 24 Feb 2025 08:24:15 +0100
X-Gm-Features: AWEUYZnWJQoJwMEoizVBFuAzKOt1HtE0zCgOvuCo18gSs0aAxY_ocJ6jNDMCOOs
Message-ID: <CAFULd4a4qbMiP3dYXDp0_vPapkoi-i-ApOY5pHfKG1h7=vfbbA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/bootflag: Change some static functions to bool
To: Jiri Slaby <jirislaby@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:18=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 29. 01. 25, 16:47, Uros Bizjak wrote:
> > The return values of some functions are of boolean type. Change the
> > type of these function to bool and adjust their return values.
> >
> > No functional change intended.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > ---
> >   arch/x86/kernel/bootflag.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
> > index 3fed7ae58b60..4d89a2d80d0f 100644
> > --- a/arch/x86/kernel/bootflag.c
> > +++ b/arch/x86/kernel/bootflag.c
> > @@ -20,7 +20,7 @@
> >
> >   int sbf_port __initdata =3D -1;       /* set via acpi_boot_init() */
> >
> > -static int __init parity(u8 v)
> > +static bool __init parity(u8 v)
> >   {
> >       int x =3D 0;
> >       int i;
> > @@ -30,7 +30,7 @@ static int __init parity(u8 v)
> >               v >>=3D 1;
> >       }
> >
> > -     return x;
> > +     return !!x;
>
> This "!!" is unnecessary and only obfuscates the code, right?

Not really, this idiom is used in place of (x !=3D 0) to change the type
to the return type of the function in a pedantic way.

Uros.

