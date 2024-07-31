Return-Path: <linux-kernel+bounces-269496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E594337C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECC81F2108E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8066C1BBBC8;
	Wed, 31 Jul 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYfjhX/J"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354E5A10B;
	Wed, 31 Jul 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440296; cv=none; b=obWodx+/DR9Rjx9MCMJV5biSwEVKu02ipAxh+2QD5DFy0O7DyMOn1yNvWTTBg6Ju65DfNxvk0SpWewfzWAuCnlvsX4DMljA6d1ntNEhw5z3hkLYDDW7RPmjic2uCte8nm2a4V+uQqUkYgN6qKCQK2Y/cX1aqvgnoI//P/w31de4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440296; c=relaxed/simple;
	bh=jERLuTt02jJk/A/GUIrlU2l3C3Z8RJ7b6O+Cw9tC1EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBtMIkmWsMMgo+WGcnsbVrGqY9VfU7inRVrbT6Y08nU7mRhzoRKWnYFYpNiALDUzFwUcAN/OBvJWPwf1M+Fe6++1eByzSpRZNiCoI7pJAJ2QIZwZ+QgWDfal8gCC2DaY7bIsNubgn6MVete4dlQgzMm2DX1EjTqwZb/vr29ZAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYfjhX/J; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efc89dbedso7572764e87.3;
        Wed, 31 Jul 2024 08:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722440293; x=1723045093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jERLuTt02jJk/A/GUIrlU2l3C3Z8RJ7b6O+Cw9tC1EM=;
        b=lYfjhX/JXtD4KdcbuZ77s4y8TUOTMQvQm5i2RwRStrua2SF+zjPGJzj3hwl/axAKBo
         1rSAHHr7T8GoyjuYTBHLd2AzWZ1fRlrHsg0Bv104opjlNuCRam6cqkW/szZPCq/IT3Wc
         59NiG4VdDuSV/6jPDx782qoY4J0KIahhNGLYSMxbWvxrXZz9vM73lUXsmq4WK+NsoPd9
         0Cp2YejZ/5Q7JJQKCi9lLpRhgEYJpa0zHhUCFmiEVD0MLU5MDeWW8YB0VRMiDf+17z8h
         oatEPxznOZ/EQOAVnIq3yeDF/EaZGlnK9n636M2JM+cyyhqRcxHdY2P8lYrQMXOI844Y
         T++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722440293; x=1723045093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jERLuTt02jJk/A/GUIrlU2l3C3Z8RJ7b6O+Cw9tC1EM=;
        b=ET7Vibt/VoPpN8rd5/nn3Nne9lggWC+pEKT97Q4zRyQofjSeVSHGhccJlAjVGUx4Pa
         dleu1CP64zcdZaHSN6/rCxBjFJbHme/P+IAVhyIZ3eEzZ27OPK99cPNuNtVkuQaOShK/
         ylxnBeNa6AfQEHSiVzNDlszIU21J1L97UJotzQrOi4Fo701OLGmAwuWherZ8+2svfOnS
         zbyZrwkiBw2XeJAXtk8IOyz8QRCA8F2tVodPKeM+qIolWUN+QNRAWbMFMboHcptEBGCU
         gqqHZBZSYjpm9sI8Dc2gbDqmCjaVCxhxcV0irUkIAS4qf9PyiuXonAr/0DB2Uw572MXs
         epTw==
X-Forwarded-Encrypted: i=1; AJvYcCVERyOUNejf+xPaUB5fZ3pxyCxwhQq/y5jJzlL82MoP7YzO1U9hupuPAi0fUNSZhetbiWeAEroeJ4TbwYTlNyKq7nefWO5BIwV+F2hvEbf73R9JKvYw6iMeHwQDl/WHygs2YjmyiRHMFA==
X-Gm-Message-State: AOJu0Yxyo0u3iEcBVozFrkyOS9ITGhZVk/2GukWFbbS9cHGOrDQ6T/I3
	Fz9IU8LgvoO6bpR5y/bva8erDZCHiH51yevQIS8tyS4VS4Mxa9qLmuqt026DDMeki4r2JaE8xK0
	C38QOwk5PM9QeijkEyNrXKak9agk=
X-Google-Smtp-Source: AGHT+IGkJsJtNdAtG/b1OGSx0qCLw0OdPM2gilMKAJkE1fAxyLPvtTaf8Ncjy/D6UEHIX+V3+SrgLLfetZIu+f87aI0=
X-Received: by 2002:a05:6512:292:b0:52f:c13f:23d2 with SMTP id
 2adb3069b0e04-5309b2803e4mr8857034e87.25.1722440292308; Wed, 31 Jul 2024
 08:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208062510.893392-1-CFSworks@gmail.com> <66f413d2-1a5b-b9e3-3c86-35a1d150f486@gmail.com>
 <659dfd80-5962-4265-836d-5761c3e41ca0@incomsystems.biz> <2401016.9fHWaBTJ5E@diego>
In-Reply-To: <2401016.9fHWaBTJ5E@diego>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 31 Jul 2024 08:38:00 -0700
Message-ID: <CAH5Ym4gW0KBcRGjfazMAjKDHmJFPYK6yc5MBFKC34Jh=P_Erkw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add PCIe pinctrls to Turing RK1
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>, Jonathan Bennett <jbennett@incomsystems.biz>, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	=?UTF-8?Q?Daniel_Kukie=C5=82a?= <daniel@kukiela.pl>, 
	Sven Rademakers <sven.rademakers@gmail.com>, Joshua Riek <jjriek@verizon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 12:09=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.d=
e> wrote:
>
> Hi Jonathan, Sam,
>
> Am Mittwoch, 5. Juni 2024, 21:45:42 CEST schrieb Jonathan Bennett:
> > On 12/8/23 11:27 AM, Sam Edwards wrote:
> > > On 12/8/23 04:05, Heiko St=C3=BCbner wrote:
> > >> Am Freitag, 8. Dezember 2023, 07:25:10 CET schrieb Sam Edwards:
> > >>> The RK3588 PCIe 3.0 controller seems to have unpredictable behavior
> > >>> when
> > >>> no CLKREQ/PERST/WAKE pins are configured in the pinmux. In
> > >>> particular, it
> > >>> will sometimes (varying between specific RK3588 chips, not over
> > >>> time) shut
> > >>> off the DBI block, and reads to this range will instead stall
> > >>> indefinitely.
> > >>>
> > >>> When this happens, it will prevent Linux from booting altogether. T=
he
> > >>> PCIe driver will stall the CPU core once it attempts to read the
> > >>> version
> > >>> information from the DBI range.
> > >>>
> > >>> Fix this boot hang by adding the correct pinctrl configuration to t=
he
> > >>> PCIe 3.0 device node, which is the proper thing to do anyway. While
> > >>> we're at it, also add the necessary configuration to the PCIe 2.0 n=
ode,
> > >>> which may or may not fix the equivalent problem over there -- but i=
s
> > >>> the
> > >>> proper thing to do anyway. :)
> > >>>
> > >>> Fixes: 2806a69f3fef6 ("arm64: dts: rockchip: Add Turing RK1 SoM
> > >>> support")
> > >>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > >>> ---
> > >>>
> > >>> Hi list,
> > >>>
> > >>> Compared to v1, v2 removes the `reset-gpios` properties as well --
> > >>> this should
> > >>> give control of the PCIe resets exclusively to the PCIe cores. (And
> > >>> even if the
> > >>> `reset-gpios` props had no effect in v1, it'd be confusing to have
> > >>> them there.)
> > >>
> > >> Hmm, I'd think this could result in differing behaviour.
> > >>
> > >> I.e. I tried the same on a different board with a nvme drive on the
> > >> pci30x4
> > >> controller. But moving the reset from the gpio-way to "just" setting=
 the
> > >> perstn pinctrl, simply hung the controller when probing the device.
> > >
> > > Ah, I'm guessing it died in:
> > > ver =3D dw_pcie_readl_dbi(pci, PCIE_VERSION_NUMBER);
> > >
> > > If so, that's the same hang that this patch is aiming to solve. I'm
> > > starting to wonder if having muxed pins !=3D 1 for a given signal ups=
ets
> > > the RC(s). Is your board (in an earlier boot stage:
> > > reset/maskrom/bootloader) muxing a different perstn pin option to tha=
t
> > > controller (and Linux doesn't know to clear it away)? Then when you
> > > add the perstn pinctrl the total number of perstns muxed to the
> > > controller comes to 2, and without a reset-gpios =3D <...>; to take i=
t
> > > away again, that number stays at 2 to cause the hang upon the DBI rea=
d?
> > >
> > > If so, that'd mean the change resolves the hang for me, because it
> > > brings the total up to 1 (from 0), but also causes the hang for you,
> > > because it brings the total up to 2 (away from 1).
> > >
> > >>
> > >> So I guess I'd think the best way would be to split the pinctrl up
> > >> into the
> > >> 3 separate functions (clkreqn, perstn, waken) so that boards can inc=
lude
> > >> them individually.
> > >
> > > Mm, maybe. Though that might be more appropriate if a board comes
> > > along that doesn't connect all of those signals to the same group of
> > > pins. I worry that attempting to solve this hang by doing that will
> > > instead just mask the real problem.
> > >
> > >>
> > >> Nobody is using the controller pinctrl entries so far anyway :-) .
> > >
> > > Then it's interesting that this board requires them in order to avoid
> > > a hang on boot. I'll see if there's anything else that I can find out=
.
> >
> > I've just finished testing the latest iteration of this patch with
> > 6.10-rc2 on my RK1 on a Turing Pi 2 carrier board. I can confirm that
> > unpatched mainline fails to boot with the same hang described here, and
> > the patch does make the board boot again.
>
> Can you possibly test if
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D28b8d7793b8573563b3d45321376f36168d77b1e
>
> changes anything? In 6.11-rc1 now.
>
> The PERST# toggling happening before that patch could've caused
> issues with your PCIe device.
>
>
> Heiko
>
>

Good day Heiko,

Thanks for thinking of this! But I believe that this problem is not
with PERST# but rather CLKREQ#:

Evidently, the RK3588's PCIe 3.0 (and not 2.0?) PHYs depend on the bus
reference clock not just for external transfers, but for completion of
some/all PIPE transactions as well. This means that, without that
external clock, the RC block stalls indefinitely even for trivial
things like reading the version information from the DBI range. This
is the boot hang that Jonathan and I are seeing.

I would guess that it hasn't been a problem for most RK3588 boards,
which either do not support PCIe 3.0 (and thus have these blocks
disabled in the DT) or have a fixed clock generator feeding the
necessary pins. However, many Jetson SoM-type boards (Turing RK1,
Mixtile Core 3588E [1], ...) have the clock switchable, requiring that
CLKREQ# be asserted/low to provide that to the RK3588.

Fortunately, the PCIe 3.0 PHY knows when it needs that clock and
provides the necessary CLKREQ# signal. But unfortunately, the current
DT does not mux this out to the board, causing this boot hang for only
those RK3588 boards.

I can still give 6.11-rc1 a whirl now if you think it has a strong
chance of mitigating the issue, or if not I can take another stab at
the DT patch in a few weeks once my availability for kernel hacking
returns. :)

Cheers,
Sam

[1]: https://downloads.mixtile.com/core3588e/file/core3588e_schematic_drawi=
ng_v1_1_0_20230922.pdf
sheet 19 of 20

