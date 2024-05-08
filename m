Return-Path: <linux-kernel+bounces-173297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707278BFEA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C44289C68
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251D473501;
	Wed,  8 May 2024 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diFD0kJc"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB754FA3;
	Wed,  8 May 2024 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174526; cv=none; b=vE7OWVBYujoySdr/iQWFIjdok5UFWFE6JkKSRzwB+JkBjKNxHn76FN/XXS7LyS3fAeKPqAkd0Wy6VirbQIZhu+Hco80tw975x+Ba+krmtsVXXZ7DOsPXKYCM0YT4/JKwOa577pEN/NbgmxcTAEXdXsfPmitZqyE5tfqdVji5z2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174526; c=relaxed/simple;
	bh=LCPIobEyDG4jY1/YMrOAWEhu8Ip5jgYeuhhvYUvw2Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ty74ci1A8U86gyjfHzTSUGds3r4kODw/G0G/nJM9bvyWX+gDnM+Qg2/nos1OPkHjSdfi0YYwhdu5zGK/4RJuYfungAWN70lYZ8vzrtirMtD7KQCCj7IW06Ehmjv5QNj/rfP0tftr9VGAyo95x3m2vTuhbz2a0zI1K5i/R0dHS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diFD0kJc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4702457ccbso1157421466b.3;
        Wed, 08 May 2024 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715174523; x=1715779323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dka4DFHKaoCiu+3AnfU4CqnO9bqrk/85WUkEVYCa+Ss=;
        b=diFD0kJc/XmyVAL65C288PEZEPgspo6uC06l++QM0fPRtQMgRm6rXG0Chl/nrIefaP
         DcEsxQsh/nvW//YIV7+udWyB+Q3AEdL7gNil9vclJoouuxUVzGHz6XruUQyhMqijmbpZ
         b4p/Zj4kRb2HK2hKW2AqcNug+o/WeN/uCBGPNP76sukjgiHOqTbbX0dA5/SIN2sI4e9L
         3DBiRmJ6UVmkIByRsrbOPOztMSuqxvwj+5IKcFy/Jmg5dgZzraRwXuUZ3AHYHdqQiBrR
         8M/XFtpjbjbYQi3Og1TOHpGnYG+ARcl7nc0mVhlcpxnRgrQ/5TrUQx7kx3yCtlcbMc2r
         JePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715174523; x=1715779323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dka4DFHKaoCiu+3AnfU4CqnO9bqrk/85WUkEVYCa+Ss=;
        b=EagMhjvC00SiB+MmUEuElTHSdcbLE4WDu3MSwvj10a9lUxWzjk9nEv5c5z+twHe79r
         Uf/A2xiKrX0MNCS+Da5golADol5qcCPa+XGF3yjrrK9oil5xWaheLcLR0Ze5DCN1VsEK
         2WvjteftWmNJ2ajMAP5m1vu13NKslEyB3kWtAtPbSV8iE1tb1BTpLDaulXfQGx554cWE
         np6uEZfSP6XeUuAFrhTLPHgdhAemMjxMcx3k+RDhk1nvwIVCOUzCZnQFFlpMrGa8AyhV
         UifnO3wEyoPkQCMl7yGIw/LTo1kJr2nWoQE24i+820tXJkglMbjyaDobEW1cScF1Wx5j
         O0fg==
X-Forwarded-Encrypted: i=1; AJvYcCVwVtb7fot6o06i/P2DOENR3fUplOM8P+vpn/1nT921xTFpLZ9cRlS0DqxqWfHYnxBC4WyhWxRe3GH8uNqPOH81nsB3tgCoXiWoiA139tnQ/VeiNH83nG6S8STaI0hw2PYJn/jcryxF+Q==
X-Gm-Message-State: AOJu0YxYmKuPeLHHAHajskJIvakF5N25h91ptcxG5p2ziBh+x7vKz559
	hLgQu0sJMW0syCpUFJIK6nsx05IOxdZl3PZtljvb0jEbzbcvwfYP8T29cwuNrYUokR4G7i/OH8R
	vNAex+Xkxz3HpfLvP0o+gLrbxE6g=
X-Google-Smtp-Source: AGHT+IGlyNUPN7vV37tYaaBGsC5RjUHGDoScBeqJ4jXoTrDQaRpJBR2jD8eT9kiCtNEacysarJ+Vav6qF1JddGfVgfY=
X-Received: by 2002:a17:906:c4d:b0:a59:b8e2:a0c5 with SMTP id
 a640c23a62f3a-a59fb9ce03emr156742266b.51.1715174522351; Wed, 08 May 2024
 06:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-2-271023ddfd40@gmail.com> <2543817.5xW6y1K4kI@bagend>
 <CABjd4Yw-JA5=SfcgtVNYZN37hFbqf14Ut1yHTSz1YZiZ3NQ-pw@mail.gmail.com>
 <CANAwSgTU7UF_RaNnVSZR7SehQqC7Eo6D=JqT11gN7jK2diN_Ug@mail.gmail.com>
 <a1fb157c88f420cd85d56edff2a4d85b@manjaro.org> <CABjd4YwHGYRrpMFn1uoQMRh3Tp4-py111tZiCGgf7afWxNGXnQ@mail.gmail.com>
 <36ecf59460430bb7267b71c1f49fe123@manjaro.org> <CANAwSgTKkFQNW5egYu5cdWx4nkwVL1tXigYUvdnAJRUOdCrxpw@mail.gmail.com>
In-Reply-To: <CANAwSgTKkFQNW5egYu5cdWx4nkwVL1tXigYUvdnAJRUOdCrxpw@mail.gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 8 May 2024 17:21:49 +0400
Message-ID: <CABjd4Yy0P0bwF68bYemvDiGgyrxmHy5g8A3mT7YdcqBq1rYCGQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] arm64: dts: rockchip: enable thermal management on
 all RK3588 boards
To: Anand Moon <linux.amoon@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:51=E2=80=AFPM Anand Moon <linux.amoon@gmail.com> w=
rote:
>
> Hi Dragan, Alexey,
>
> On Wed, 8 May 2024 at 18:08, Dragan Simic <dsimic@manjaro.org> wrote:
> >
> > Hello Alexey,
> >
> > On 2024-05-08 14:30, Alexey Charkov wrote:
> > > On Wed, May 8, 2024 at 3:46=E2=80=AFPM Dragan Simic <dsimic@manjaro.o=
rg> wrote:
> > >> On 2024-05-08 13:40, Anand Moon wrote:
> > >> > On Mon, 6 May 2024 at 18:24, Alexey Charkov <alchark@gmail.com> wr=
ote:
> > >> >> On Mon, May 6, 2024 at 4:29=E2=80=AFPM Diederik de Haas
> > >> >> <didi.debian@cknow.org> wrote:
> > >> >> > On Monday, 6 May 2024 11:36:33 CEST Alexey Charkov wrote:
> > >> >> > > This enables the on-chip thermal monitoring sensor (TSADC) on=
 all
> > >> >> > > RK3588(s) boards that don't have it enabled yet. It provides =
temperature
> > >> >> > > monitoring for the SoC and emergency thermal shutdowns, and i=
s thus
> > >> >> > > important to have in place before CPU DVFS is enabled, as hig=
h CPU
> > >> >> > > operating performance points can overheat the chip quickly in=
 the
> > >> >> > > absence of thermal management.
> > >> >> > >
> > >> >> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > >> >> > > ---
> > >> >> > >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts             =
  | 4 ++++
> > >> >> > >  8 files changed, 32 insertions(+)
> > >> >> > >
> > >> >> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > >> >> > > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts index
> > >> >> > > b8e15b76a8a6..21e96c212dd8 100644
> > >> >> > > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > >> >> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > >> >> > > @@ -742,6 +742,10 @@ regulator-state-mem {
> > >> >> > >       };
> > >> >> > >  };
> > >> >> > >
> > >> >> > > +&tsadc {
> > >> >> > > +     status =3D "okay";
> > >> >> > > +};
> > >> >> > > +
> > >> >> > >  &uart2 {
> > >> >> > >       pinctrl-0 =3D <&uart2m0_xfer>;
> > >> >> > >       status =3D "okay";
> > >> >> >
> > >> >> > I built a kernel with v3 of your patch set and someone tested i=
t on a ROCK 5B
> > >> >> > 'for me' and it had the following line in dmesg:
> > >> >> >
> > >> >> > rockchip-thermal fec00000.tsadc: Missing rockchip,grf property
> > >> >> >
> > >> >> > I'm guessing that turned up due to enabling tsadc, but (also) i=
n v4 I didn't
> > >> >> > see a change wrt "rockchip,grf".
> > >> >> > Should that be done? (asking; I don't know)
> > >> >>
> > >> >> I'm getting the same. Neither the mainline TSADC driver [1], nor =
the
> > >> >> downstream one [2] seems to use the grf pointer on RK3588 at all.=
 It
> > >> >> still works in spite of that warning, although I can't see how (o=
r if)
> > >> >> it configures the reset mechanism without those GRF registers.
> > >> >>
> > >> >> Best regards,
> > >> >> Alexey
> > >> >>
> > >> >> [1]
> > >> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/thermal/rockchip_thermal.c#n818
> > >> >> [2]
> > >> >> https://github.com/radxa/kernel/blob/stable-5.10-rock5/drivers/th=
ermal/rockchip_thermal.c#L961
> > >> >>
> > >> >
> > >> > If the following changes fix the warning.
> > >> >
> > >> > Checking the Rockchip RK3588 TRM V1.0-Part1-20220309.pdf
> > >> > PMU1GRF_SOC_CON3 which has tsadc_shut_reset_trigger_en bit
> > >> > to control the Enable TSADC shut reset trigger for DDR fail safe.
> > >> >
> > >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > >> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > >> > index 85c25d5efdad..5490a44e093e 100644
> > >> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > >> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > >> > @@ -2662,6 +2662,7 @@ tsadc: tsadc@fec00000 {
> > >> >                 rockchip,hw-tshut-temp =3D <120000>;
> > >> >                 rockchip,hw-tshut-mode =3D <0>; /* tshut mode 0:CR=
U
> > >> > 1:GPIO */
> > >> >                 rockchip,hw-tshut-polarity =3D <0>; /* tshut polar=
ity
> > >> > 0:LOW 1:HIGH */
> > >> > +               rockchip,pmu =3D <&pmu1grf>;
> > >> >                 pinctrl-0 =3D <&tsadc_gpio_func>;
> > >> >                 pinctrl-1 =3D <&tsadc_shut>;
> > >> >                 pinctrl-names =3D "gpio", "otpout";
> > >>
> > >> Basically, the rockchip_thermal driver doesn't use GRF at all on
> > >> the RK3588(s), so virtually any value specified as "rockchip,pmu"
> > >> can eliminate the warning.
> > >
> > > To me, specifying an arbitrary GRF in the device tree just to silence
> > > a warning that the current driver emits sounds bad. If the GRF is not
> > > needed for TSADC initialization on RK3588, then it should not be in
> > > the device tree (and it looks like the case here) - otherwise the
> > > device tree ceases to be a truthful description of the hardware.
> >
> > After thinking a bit more about it, I think you're right.  If the
> > rockchip_thermal driver ever gets changed to require use of GRF on
> > the RK3588(s), only then adding that property to the DT would be
> > the right thing to do.
> >
> > > I'm not sure if we need that "DDR fail safe" logic mentioned in the
> > > TRM that Anand quoted, given that neither Rockchip downstream nor
> > > current mainline driver implement it, and furthermore none of the
> > > other SoC revisions supported by the driver mention it. If we do in
> > > fact need it, we should probably first test it along with respective
> > > driver code before committing to an upstream DT and thus making it
> > > part of the ABI.
> > >
> > > IMO this is more of a driver issue than a device tree issue: maybe a
> > > small patch to demote this warning to an info message would be better=
?
> > > It's harmless anyway.
> >
> > After having second thoughts, I'll see to improve the rockchip_thermal
> > driver to emit that warning only when having "rockchip,grf" specified
> > is actually needed for the particular Rockchip SoC.  That's how it
> > should
> > behave, yelling about the wrong hardware description only when that's
> > actually the case.
>
> We need to handle the GRF TSADC for rk3588 tmu driver.
>
> For rk3568 we control the GRF TSADC which seems to be missing in rk3588

Please note that for RK3568 the GRF registers are used to actually
enable the thermal sensing (as can be seen by the link you posted),
which doesn't seem to be necessary on RK3588 as it works just fine
without it. Furthermore, RK3568 has a nearly identical GRF register in
PMU_GRF_SOC_CON3 (see RK3568 TRM part1 page 206) to the one you
proposed referencing in the DT for RK3588, but that register is not
used in the TSADC driver either. It only uses the TSADC_CON register
within SYS_GRF (offset 0x600) on RK3568.

The TRM for RK3588 doesn't document any TSADC_CON register, even
though there is a #define in the current upstream driver that mentions
an offset of 0x100 to that register within the GRF. I'm not sure it
means 0x100 within PMU1_GRF as you mentioned - do you have any
pointers to support that?

Best regards,
Alexey

