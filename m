Return-Path: <linux-kernel+bounces-174168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162368C0B13
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FD41C2353E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551071494AB;
	Thu,  9 May 2024 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XppLSR6r"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2E7149DE4;
	Thu,  9 May 2024 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232920; cv=none; b=DtkvM49Cb7Pn9y2BShUKY9k/vV/RSCDO9wODmmtuIUcsyLTPj6uVThFyroBzZ4n+PBFBK4g6Q4j7b5mcIhiVZ9+T91pgFvgVBGe8aylJcImboOEOuN7sc7sqCSxQ8EcB5FCbxGKEf1637/EgE6HpQ4VXcHLvzYIngshW5Gb1xSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232920; c=relaxed/simple;
	bh=AvwsUiPv9U02KWv2jFO6quv9aOFmjzmZ/i/B3C9r+18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uU34niAE1Yqw+E7kd66JQU0uYOA2TWq+99+0dLl/c6MdJhR5cLY0ARECMdWggqs6THYTz/rVdZOmESdF9AaW+GTeqvYTeo+JuDv4H7r8je6Qtofsv7UZTSdmUqwihSWN+g1V0Vda2ujrf15Opg57LS127e+uxu6Fbe7REIPUsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XppLSR6r; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ad2da2196aso330923eaf.2;
        Wed, 08 May 2024 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715232917; x=1715837717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKzxn2kAVfFNER0CXFQyB1cHEfp+OjAZ2AhDST5fDu0=;
        b=XppLSR6rK5EGtEqbmkY1/Ktc05h2T7y5fkO+jQ+YIcOt3+v54yL9qxVSlf5uxVTcIm
         qH87cOPYKrwzxdB2b4x4vXpFkYF4DyGSg4Ez2T/NJVnI3S64mt3DAUGjRKUrn+v84+Qc
         0P8e/Xdo0m1LIh8M36XgIuIPXQes0GUsGGOizOlsmvoMrtdkzPqBEFKtil7izWltVPuk
         48HqIUCgevjHYpxkqcilxzjgBKNfwb04RtghOcXVbEhGxaG2L6GmS94pmwZ0BHnAlIP1
         KvLIND2/8oN2NH+88RiG7/bIxwsKkOsFvoKHl/ZicU6zUoikHqilPYfqtSjVKyh+Vf4P
         ycSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715232917; x=1715837717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKzxn2kAVfFNER0CXFQyB1cHEfp+OjAZ2AhDST5fDu0=;
        b=uL8D4BB0Z2IcNfvD+0D8e6erJ4BwE1eyiM6yCEHtPUA/Zgnq2L7FUabsPs7nxNmD19
         9ce5/P0QUNc3l3xj525E0kDecQvP0FJ8SxaUbRCkqo0zN3tOd3ixFHk7ArSyXYt/4lly
         OnaZqs+LqhnCOQMAZGNumAwDrhuOCWtE9U3oiGq6YeJs0jxI74W2flNR+wCmFKqOAd1+
         a1SDkq75eeFWH1KAGvkkJd2YYkbVdEOblZ+VMGPMu330BPJTkyn9woRc87cR4vD82C/w
         n/oM56aEseBx4aOvl9Hoq+J7AdCKw178J7aLmoBFNyRLn8MjSN3sFAEvKAAfyk/aob5m
         442A==
X-Forwarded-Encrypted: i=1; AJvYcCVo688e1H3pGjqJmkjoU8FJEzhTQ0mlqvza8df0IWu7DcFVEWvewmP/LqF+qgO8oW4PCZyIyTw97sC34cSn0wR4vIxVNU21OPndQIOnBoK+DdTrdqtZ1kUEt95nh5FhThLGSh290QcX5A==
X-Gm-Message-State: AOJu0YwZv8GJoPVRtMTRMwdKoVYR5t7eunaabMWAxD+2Q1SMJBGHzgxS
	/Oj+mdqZDYKfM5Ee2WR5NysK2ymrNPyXMtjTRcYfmdKJ2gWYf5kNzYqVovYv/mGNjFRVdJKW1fT
	5+31bqeoyMfWVoMQEllCkFk+beJY=
X-Google-Smtp-Source: AGHT+IHd2RCFuGDk9SLLJIqDTUOQEXeig/MLqJhEqch6QMXawp2yuqGzt4wgGL4dSMB0R2kWbJDsHg2oIjjuw2dZ8Ho=
X-Received: by 2002:a4a:ab05:0:b0:5b2:3782:7847 with SMTP id
 006d021491bc7-5b24d73ada9mr4955478eaf.7.1715232917458; Wed, 08 May 2024
 22:35:17 -0700 (PDT)
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
 <CABjd4Yy0P0bwF68bYemvDiGgyrxmHy5g8A3mT7YdcqBq1rYCGQ@mail.gmail.com>
In-Reply-To: <CABjd4Yy0P0bwF68bYemvDiGgyrxmHy5g8A3mT7YdcqBq1rYCGQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 9 May 2024 11:05:01 +0530
Message-ID: <CANAwSgQaVVVwB9J+2JDE1hygUvL1zPDjGxRZ6rVwbsUQ=Uxwvw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] arm64: dts: rockchip: enable thermal management on
 all RK3588 boards
To: Alexey Charkov <alchark@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexey,

On Wed, 8 May 2024 at 18:52, Alexey Charkov <alchark@gmail.com> wrote:
>
> On Wed, May 8, 2024 at 4:51=E2=80=AFPM Anand Moon <linux.amoon@gmail.com>=
 wrote:
> >
> > Hi Dragan, Alexey,
> >
> > On Wed, 8 May 2024 at 18:08, Dragan Simic <dsimic@manjaro.org> wrote:
> > >
> > > Hello Alexey,
> > >
> > > On 2024-05-08 14:30, Alexey Charkov wrote:
> > > > On Wed, May 8, 2024 at 3:46=E2=80=AFPM Dragan Simic <dsimic@manjaro=
org> wrote:
> > > >> On 2024-05-08 13:40, Anand Moon wrote:
> > > >> > On Mon, 6 May 2024 at 18:24, Alexey Charkov <alchark@gmail.com> =
wrote:
> > > >> >> On Mon, May 6, 2024 at 4:29=E2=80=AFPM Diederik de Haas
> > > >> >> <didi.debian@cknow.org> wrote:
> > > >> >> > On Monday, 6 May 2024 11:36:33 CEST Alexey Charkov wrote:
> > > >> >> > > This enables the on-chip thermal monitoring sensor (TSADC) =
on all
> > > >> >> > > RK3588(s) boards that don't have it enabled yet. It provide=
s temperature
> > > >> >> > > monitoring for the SoC and emergency thermal shutdowns, and=
 is thus
> > > >> >> > > important to have in place before CPU DVFS is enabled, as h=
igh CPU
> > > >> >> > > operating performance points can overheat the chip quickly =
in the
> > > >> >> > > absence of thermal management.
> > > >> >> > >
> > > >> >> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > > >> >> > > ---
> > > >> >> > >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts           =
    | 4 ++++
> > > >> >> > >  8 files changed, 32 insertions(+)
> > > >> >> > >
> > > >> >> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dt=
s
> > > >> >> > > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts index
> > > >> >> > > b8e15b76a8a6..21e96c212dd8 100644
> > > >> >> > > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > >> >> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > >> >> > > @@ -742,6 +742,10 @@ regulator-state-mem {
> > > >> >> > >       };
> > > >> >> > >  };
> > > >> >> > >
> > > >> >> > > +&tsadc {
> > > >> >> > > +     status =3D "okay";
> > > >> >> > > +};
> > > >> >> > > +
> > > >> >> > >  &uart2 {
> > > >> >> > >       pinctrl-0 =3D <&uart2m0_xfer>;
> > > >> >> > >       status =3D "okay";
> > > >> >> >
> > > >> >> > I built a kernel with v3 of your patch set and someone tested=
 it on a ROCK 5B
> > > >> >> > 'for me' and it had the following line in dmesg:
> > > >> >> >
> > > >> >> > rockchip-thermal fec00000.tsadc: Missing rockchip,grf propert=
y
> > > >> >> >
> > > >> >> > I'm guessing that turned up due to enabling tsadc, but (also)=
 in v4 I didn't
> > > >> >> > see a change wrt "rockchip,grf".
> > > >> >> > Should that be done? (asking; I don't know)
> > > >> >>
> > > >> >> I'm getting the same. Neither the mainline TSADC driver [1], no=
r the
> > > >> >> downstream one [2] seems to use the grf pointer on RK3588 at al=
l. It
> > > >> >> still works in spite of that warning, although I can't see how =
(or if)
> > > >> >> it configures the reset mechanism without those GRF registers.
> > > >> >>
> > > >> >> Best regards,
> > > >> >> Alexey
> > > >> >>
> > > >> >> [1]
> > > >> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/drivers/thermal/rockchip_thermal.c#n818
> > > >> >> [2]
> > > >> >> https://github.com/radxa/kernel/blob/stable-5.10-rock5/drivers/=
thermal/rockchip_thermal.c#L961
> > > >> >>
> > > >> >
> > > >> > If the following changes fix the warning.
> > > >> >
> > > >> > Checking the Rockchip RK3588 TRM V1.0-Part1-20220309.pdf
> > > >> > PMU1GRF_SOC_CON3 which has tsadc_shut_reset_trigger_en bit
> > > >> > to control the Enable TSADC shut reset trigger for DDR fail safe=
.
> > > >> >
> > > >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > > >> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > > >> > index 85c25d5efdad..5490a44e093e 100644
> > > >> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > > >> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > > >> > @@ -2662,6 +2662,7 @@ tsadc: tsadc@fec00000 {
> > > >> >                 rockchip,hw-tshut-temp =3D <120000>;
> > > >> >                 rockchip,hw-tshut-mode =3D <0>; /* tshut mode 0:=
CRU
> > > >> > 1:GPIO */
> > > >> >                 rockchip,hw-tshut-polarity =3D <0>; /* tshut pol=
arity
> > > >> > 0:LOW 1:HIGH */
> > > >> > +               rockchip,pmu =3D <&pmu1grf>;
> > > >> >                 pinctrl-0 =3D <&tsadc_gpio_func>;
> > > >> >                 pinctrl-1 =3D <&tsadc_shut>;
> > > >> >                 pinctrl-names =3D "gpio", "otpout";
> > > >>
> > > >> Basically, the rockchip_thermal driver doesn't use GRF at all on
> > > >> the RK3588(s), so virtually any value specified as "rockchip,pmu"
> > > >> can eliminate the warning.
> > > >
> > > > To me, specifying an arbitrary GRF in the device tree just to silen=
ce
> > > > a warning that the current driver emits sounds bad. If the GRF is n=
ot
> > > > needed for TSADC initialization on RK3588, then it should not be in
> > > > the device tree (and it looks like the case here) - otherwise the
> > > > device tree ceases to be a truthful description of the hardware.
> > >
> > > After thinking a bit more about it, I think you're right.  If the
> > > rockchip_thermal driver ever gets changed to require use of GRF on
> > > the RK3588(s), only then adding that property to the DT would be
> > > the right thing to do.
> > >
> > > > I'm not sure if we need that "DDR fail safe" logic mentioned in the
> > > > TRM that Anand quoted, given that neither Rockchip downstream nor
> > > > current mainline driver implement it, and furthermore none of the
> > > > other SoC revisions supported by the driver mention it. If we do in
> > > > fact need it, we should probably first test it along with respectiv=
e
> > > > driver code before committing to an upstream DT and thus making it
> > > > part of the ABI.
> > > >
> > > > IMO this is more of a driver issue than a device tree issue: maybe =
a
> > > > small patch to demote this warning to an info message would be bett=
er?
> > > > It's harmless anyway.
> > >
> > > After having second thoughts, I'll see to improve the rockchip_therma=
l
> > > driver to emit that warning only when having "rockchip,grf" specified
> > > is actually needed for the particular Rockchip SoC.  That's how it
> > > should
> > > behave, yelling about the wrong hardware description only when that's
> > > actually the case.
> >
> > We need to handle the GRF TSADC for rk3588 tmu driver.
> >
> > For rk3568 we control the GRF TSADC which seems to be missing in rk3588
>
> Please note that for RK3568 the GRF registers are used to actually
> enable the thermal sensing (as can be seen by the link you posted),
> which doesn't seem to be necessary on RK3588 as it works just fine
> without it. Furthermore, RK3568 has a nearly identical GRF register in
> PMU_GRF_SOC_CON3 (see RK3568 TRM part1 page 206) to the one you
> proposed referencing in the DT for RK3588, but that register is not
> used in the TSADC driver either. It only uses the TSADC_CON register
> within SYS_GRF (offset 0x600) on RK3568.
>

I feel there is no PMUGRF configuration for TS-ADC on RK3588 SoC as per the=
 TRM.
So we can ignore the warning.

> The TRM for RK3588 doesn't document any TSADC_CON register, even
> though there is a #define in the current upstream driver that mentions
> an offset of 0x100 to that register within the GRF. I'm not sure it
> means 0x100 within PMU1_GRF as you mentioned - do you have any
> pointers to support that?
>

Yes, you can drop them as there is no RK3588_GRF0_TSADC_CON register
to support such settings.

Thanks

-Anand

