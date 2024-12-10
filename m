Return-Path: <linux-kernel+bounces-439131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6809EAB38
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E460280EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A464230D1A;
	Tue, 10 Dec 2024 09:02:41 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B5230D0D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821360; cv=none; b=Zt3lJtS4F4FUy8LkseFmkytiSUF9C3Hg3fYaiMsSTP8vKPWN0KUXFDplEmktIoxIoI0/jetIgAevshUDz64q2T4sVLNf0RoUoNQHi34/l/uPTS/WZxhFNfo0PJotyXNNgVVxlfi1TZftLjEIuI75ofFMI9BW/y2ocEeWG8kaUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821360; c=relaxed/simple;
	bh=gU/nJ5teQLO8Yr0g3gfN2+SqWjZBr2rh+zUl+DWLrVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5pvDQj4ex50Ryggnrb8491sil6lM2ZVHfqWVo+gyAYKwHP2EzSo+D2TuMOCygFMQuO5tyFRAaSBZvkKmMSGJ/EizJUk/1PnOeQrdZB80k3n6yXYASB5pQDrnvYBP3QJK9Rgh8YbSAamSxvOREviAGjC7X/kpFN5pj1OfS2Jolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-518802a1e7eso760720e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821357; x=1734426157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0u2asYMwtHNjmsewIhDxVhemB7gjctoxb772Jm7kqe4=;
        b=rkjn2MYOGUrwK/LuboTugDXSjsDPXCYt9NTggwYKesfLf9Er+Kc0G1OKBa/VtJAAUx
         A82n/rpvi98RK0cZRk8RpAznStDDka7yE7Nm5a7oPxHMMH1hEicOfvSjqVJKZimeakSN
         Juo/sMXHv1fZysTIOntW3oMky3mg+G04NYnSUonNTisS53E/tTZUiXCWxbg+4bP3ncaB
         7kQ1lHlEuaJXCAKauFW93LNH2yzLowwr65ZT+d53WjAFkXKfIuiTVyFtxlwdlSjjW4Ev
         Q1Szji5fLQLh8clxBYhOyuGTMg8QzmrO0T4MapZkO75K1Yhn3wShjyLuh2CRMbKTMNNK
         VgNA==
X-Forwarded-Encrypted: i=1; AJvYcCVhGeTSora8uEFajPfbG19FB5DaVJiK0XDQEOutHZc7z53SYFsWshAmedRt+oOi0qsPq4tgzY1N9nCyHrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ0tf4+PJl7NM6LOat8eyGBBlOS+FO/ggy9aK8rhfQLtUfVH0F
	ND/9+2PWFok3x5LZt9mJorMUXQ3t17st7lfuDKIgrn17fkWvp6rmr4BU3PHT
X-Gm-Gg: ASbGnctTMorJgKevqMcB3p5ROL+NcVtM9+OEoRPjXjyxoibZo4Hg/1wMmbSQmUl1w9g
	39d6Eum4UGWAWek7qvtRvCazD/Ss0QZSCx+1n6fUKCo7pesZ7MvwwcqeUz04yw7nvpBtW4icirT
	Q2WTpOM7Swu9QUIYrtbc4kRDuRJLV7jRJfNT2ERzDxYclIHPxrkIXTaSxGVRMbPEr/2O3tdVV/Z
	PL3ymT6r4cEflqpqhHuSfJuQbcnxM5FzgG7kUpRGpHjqFa43o47TYb+q5XrhlIiUNxHSD5vZtAX
	CgQZoFPMTzMPNfnG
X-Google-Smtp-Source: AGHT+IEvlZJmGe+dYC7LvXWIjfrhp+3pGsTd4mOMhiXIm1losl+bIL1/jCw8xspo8Jh1aPdKQhKSew==
X-Received: by 2002:a05:6122:3d44:b0:50d:6a43:d525 with SMTP id 71dfb90a1353d-518882f1044mr3921446e0c.1.1733821356691;
        Tue, 10 Dec 2024 01:02:36 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-515eae41618sm830333e0c.19.2024.12.10.01.02.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:02:36 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4afed12283eso1394064137.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:02:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjeDikWeTEtL15ZgWJ6dS5PiazHitkWa9tCz9cWKHYilPd8C5i3Pkw6cIYSgqAuycYn2rs2mpStmGvXDk=@vger.kernel.org
X-Received: by 2002:a05:6102:38ca:b0:4af:f5bd:6378 with SMTP id
 ada2fe7eead31-4b1160555f1mr3406114137.9.1733821356202; Tue, 10 Dec 2024
 01:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204162128.25617-1-dpenkler@gmail.com> <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>
 <ddc720b2-8bb4-4a07-8280-dadeb2de5b26@roeck-us.net> <CAMuHMdUb-tpmTiKV5BFopCWoY96D_HYNG60Kv+wVRKnDFF+COA@mail.gmail.com>
 <2024121051-snowiness-sampling-2fe2@gregkh>
In-Reply-To: <2024121051-snowiness-sampling-2fe2@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Dec 2024 10:02:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV2Nh6ZZ-0tW0dCt5OoBH5_OrcpON32X1YJBQYgF=eywA@mail.gmail.com>
Message-ID: <CAMuHMdV2Nh6ZZ-0tW0dCt5OoBH5_OrcpON32X1YJBQYgF=eywA@mail.gmail.com>
Subject: Re: [PATCH v5] staging: gpib: Fix i386 build issue
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Dave Penkler <dpenkler@gmail.com>, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Dec 10, 2024 at 9:39=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Tue, Dec 10, 2024 at 08:52:08AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Dec 9, 2024 at 5:18=E2=80=AFPM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> > > The underlying problem is that the code uses a pointer to store the p=
hysical
> > > address. That doesn't work if sizeof(pointer) < sizeof(physical addre=
ss),
> > > which affects systems with X86_PAE enabled. I have not seen the probl=
em
> > > anywhere else.
> >
> > I could reproduce the build issue on ARM, with CONFIG_ARM_LPAE=3Dy,
> > which is not enabled by allmodconfig.
>
> So does that mean this patch is incorrect?

Purely from an arch-agnostic LPAE PoV, it should be:

    depends on 64BIT || !PHYS_ADDR_T_64BIT

However, that assumes the driver actually works on 64-bit or non-x86.
Perhaps people keep an old i386 to control their GPIB gear?

The drivers do not use ioremap(), but just cast the PCI resource
addresses to void * pointers. No idea if that works on x86_64.
It will probably crash spectacularly on non-x86...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

