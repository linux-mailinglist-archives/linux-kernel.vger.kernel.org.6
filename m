Return-Path: <linux-kernel+bounces-173255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 383258BFDB0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18BDB22D3A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA25B5823F;
	Wed,  8 May 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F20KSvgj"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFA22071;
	Wed,  8 May 2024 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172697; cv=none; b=Fa7SIFev4458MyaBxFL68n9Hm88FFOjYh0s7cDL31s9lR4zJOeLvVig4ofHTKdskwwOYiO0EeBY69yj5BBEG0mzOMsdEDf3L8n1/kZjG79uxPE6nW8ly8Zwcb0OVMjY5UOD5rGxHy0yH2Uwx3GdHKMP83joR007rsw/zgPDgxg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172697; c=relaxed/simple;
	bh=CAzoEKa5hK4zWfbFjA0pcqooBHApZbVvDFsR2noPOio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgYJN/jbUof29CLYzSYodFRPXlAvKlMwiCafk+kxBU1GPtUxa3JE2wJiAmHvw7jAt2muJjdH9Lja5Ee6Ydd/cXzIr+ie/+WhabQbkQ2IZM0zifSZQrk9rVBI/4bSdjr8uB5rIGsWYubm8mnz5MJuwJPB9Lwdm/Bth7Q6VtE4pLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F20KSvgj; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5aa3f0fcd46so2437310eaf.1;
        Wed, 08 May 2024 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715172694; x=1715777494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hktVQAvADFWmrIMeYBp/UjfrNNVGa5etZaPbkoRNU1U=;
        b=F20KSvgjMSg5NkjMNJRRNWr9/KDDbw0hMJWr2FquGOW4qmQ32taXuk209RCfOq3i+u
         t99wQuCALLN0A65e5RJ95FR73uppfykjK9cFCDa0M4KZO9nfdroZ5IeMnCzcY1DgZoQ5
         bBEtSkqQtVk6a/SGQiBXCNajR7tKRSSY26qeTT/khNpVga+mgFXgEFWwQU8lXRfb5RuR
         ukJ7uo6qDWd4ey0X9W4xWG4Ze4mJYghLpqnB0dBIbC1kHYZi3nuKV7lWv6fLooHHkXmT
         tP6bSK73GN7xvNhaspjCzFuQ+3PALz9OW50kiq7fdV9ODYAl8RAmQiMff6cXrsqfaL3Q
         bqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715172694; x=1715777494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hktVQAvADFWmrIMeYBp/UjfrNNVGa5etZaPbkoRNU1U=;
        b=NQaiG2wOsKJ3u0iPUX4j95myACU2v1lOlygbyZZiHT54QqwuveGPNchwdS9colmRsv
         5Lli+yX4xRCF2gUsF15OsQbsmU/tsIW2PHVno1pZ44mWco8/KQttL2Xsh4MXT9YBJuQ4
         TuDvmyRr+xC92mAg19S++OQvUaf1eFRtlopDIYmUeBeRiKsuWGBDRA2mHyzjFYFAAOkZ
         3Gf4g/8AwzCnV12QgjnfIrmkXEoiBf//ydHyNeOvMM14yc6YEWpXuNuEgQ14kHy0EaI6
         pn1ZUb9GXFHYj7LW8eCyT39YdjBiTBJh29c6c8nILcri3qxgiBvidHaKX3pOLHtcqVp/
         BPxA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Si/uIw6j768gu+hvLDHi9QnxKbt+K1AfoqqfclV2AS0lXMcS70PU0uI1DpuVBRKSdaUKZTWpdCRNFuMas1b3AL4fMhZu1mWXEVsgdhT1tPyu/xm9JRi4PUOqp0Jf7yf4zZI/KZ1s3Q==
X-Gm-Message-State: AOJu0YyG2PmNMkpD7eQ2/Bk2Qr48pcqMmOTG8i3jGTBzIA7A5JAAlLVc
	DCyEq7s+IPZsIU5fr+DeMczx/71jJbm8V/ICGn0nWRO9CRnA9lqSyaW3nn/LyWCp91md7R4ez71
	R4g6gT7ACLXSQ/Gln6DTXEyBOcQmtzxhYC3I=
X-Google-Smtp-Source: AGHT+IHXyYtAELOQYY1GekTOBPTT6BceVgA1zGGyIv2RI6xCofIfdNTh/HCPD5CnNLFokQaVb0DNiyH4RAKwGaYgVkk=
X-Received: by 2002:a4a:aa09:0:b0:5af:c4b3:7c6d with SMTP id
 006d021491bc7-5b24d5e69dfmr2472033eaf.5.1715172694506; Wed, 08 May 2024
 05:51:34 -0700 (PDT)
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
 <36ecf59460430bb7267b71c1f49fe123@manjaro.org>
In-Reply-To: <36ecf59460430bb7267b71c1f49fe123@manjaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 8 May 2024 18:21:17 +0530
Message-ID: <CANAwSgTKkFQNW5egYu5cdWx4nkwVL1tXigYUvdnAJRUOdCrxpw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] arm64: dts: rockchip: enable thermal management on
 all RK3588 boards
To: Dragan Simic <dsimic@manjaro.org>
Cc: Alexey Charkov <alchark@gmail.com>, Diederik de Haas <didi.debian@cknow.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragan, Alexey,

On Wed, 8 May 2024 at 18:08, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Hello Alexey,
>
> On 2024-05-08 14:30, Alexey Charkov wrote:
> > On Wed, May 8, 2024 at 3:46=E2=80=AFPM Dragan Simic <dsimic@manjaro.org=
> wrote:
> >> On 2024-05-08 13:40, Anand Moon wrote:
> >> > On Mon, 6 May 2024 at 18:24, Alexey Charkov <alchark@gmail.com> wrot=
e:
> >> >> On Mon, May 6, 2024 at 4:29=E2=80=AFPM Diederik de Haas
> >> >> <didi.debian@cknow.org> wrote:
> >> >> > On Monday, 6 May 2024 11:36:33 CEST Alexey Charkov wrote:
> >> >> > > This enables the on-chip thermal monitoring sensor (TSADC) on a=
ll
> >> >> > > RK3588(s) boards that don't have it enabled yet. It provides te=
mperature
> >> >> > > monitoring for the SoC and emergency thermal shutdowns, and is =
thus
> >> >> > > important to have in place before CPU DVFS is enabled, as high =
CPU
> >> >> > > operating performance points can overheat the chip quickly in t=
he
> >> >> > > absence of thermal management.
> >> >> > >
> >> >> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> >> > > ---
> >> >> > >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts               =
| 4 ++++
> >> >> > >  8 files changed, 32 insertions(+)
> >> >> > >
> >> >> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> >> > > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts index
> >> >> > > b8e15b76a8a6..21e96c212dd8 100644
> >> >> > > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> >> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> >> > > @@ -742,6 +742,10 @@ regulator-state-mem {
> >> >> > >       };
> >> >> > >  };
> >> >> > >
> >> >> > > +&tsadc {
> >> >> > > +     status =3D "okay";
> >> >> > > +};
> >> >> > > +
> >> >> > >  &uart2 {
> >> >> > >       pinctrl-0 =3D <&uart2m0_xfer>;
> >> >> > >       status =3D "okay";
> >> >> >
> >> >> > I built a kernel with v3 of your patch set and someone tested it =
on a ROCK 5B
> >> >> > 'for me' and it had the following line in dmesg:
> >> >> >
> >> >> > rockchip-thermal fec00000.tsadc: Missing rockchip,grf property
> >> >> >
> >> >> > I'm guessing that turned up due to enabling tsadc, but (also) in =
v4 I didn't
> >> >> > see a change wrt "rockchip,grf".
> >> >> > Should that be done? (asking; I don't know)
> >> >>
> >> >> I'm getting the same. Neither the mainline TSADC driver [1], nor th=
e
> >> >> downstream one [2] seems to use the grf pointer on RK3588 at all. I=
t
> >> >> still works in spite of that warning, although I can't see how (or =
if)
> >> >> it configures the reset mechanism without those GRF registers.
> >> >>
> >> >> Best regards,
> >> >> Alexey
> >> >>
> >> >> [1]
> >> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/thermal/rockchip_thermal.c#n818
> >> >> [2]
> >> >> https://github.com/radxa/kernel/blob/stable-5.10-rock5/drivers/ther=
mal/rockchip_thermal.c#L961
> >> >>
> >> >
> >> > If the following changes fix the warning.
> >> >
> >> > Checking the Rockchip RK3588 TRM V1.0-Part1-20220309.pdf
> >> > PMU1GRF_SOC_CON3 which has tsadc_shut_reset_trigger_en bit
> >> > to control the Enable TSADC shut reset trigger for DDR fail safe.
> >> >
> >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > index 85c25d5efdad..5490a44e093e 100644
> >> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> > @@ -2662,6 +2662,7 @@ tsadc: tsadc@fec00000 {
> >> >                 rockchip,hw-tshut-temp =3D <120000>;
> >> >                 rockchip,hw-tshut-mode =3D <0>; /* tshut mode 0:CRU
> >> > 1:GPIO */
> >> >                 rockchip,hw-tshut-polarity =3D <0>; /* tshut polarit=
y
> >> > 0:LOW 1:HIGH */
> >> > +               rockchip,pmu =3D <&pmu1grf>;
> >> >                 pinctrl-0 =3D <&tsadc_gpio_func>;
> >> >                 pinctrl-1 =3D <&tsadc_shut>;
> >> >                 pinctrl-names =3D "gpio", "otpout";
> >>
> >> Basically, the rockchip_thermal driver doesn't use GRF at all on
> >> the RK3588(s), so virtually any value specified as "rockchip,pmu"
> >> can eliminate the warning.
> >
> > To me, specifying an arbitrary GRF in the device tree just to silence
> > a warning that the current driver emits sounds bad. If the GRF is not
> > needed for TSADC initialization on RK3588, then it should not be in
> > the device tree (and it looks like the case here) - otherwise the
> > device tree ceases to be a truthful description of the hardware.
>
> After thinking a bit more about it, I think you're right.  If the
> rockchip_thermal driver ever gets changed to require use of GRF on
> the RK3588(s), only then adding that property to the DT would be
> the right thing to do.
>
> > I'm not sure if we need that "DDR fail safe" logic mentioned in the
> > TRM that Anand quoted, given that neither Rockchip downstream nor
> > current mainline driver implement it, and furthermore none of the
> > other SoC revisions supported by the driver mention it. If we do in
> > fact need it, we should probably first test it along with respective
> > driver code before committing to an upstream DT and thus making it
> > part of the ABI.
> >
> > IMO this is more of a driver issue than a device tree issue: maybe a
> > small patch to demote this warning to an info message would be better?
> > It's harmless anyway.
>
> After having second thoughts, I'll see to improve the rockchip_thermal
> driver to emit that warning only when having "rockchip,grf" specified
> is actually needed for the particular Rockchip SoC.  That's how it
> should
> behave, yelling about the wrong hardware description only when that's
> actually the case.

We need to handle the GRF TSADC for rk3588 tmu driver.

For rk3568 we control the GRF TSADC which seems to be missing in rk3588

[[0] https://elixir.bootlin.com/linux/v6.8.9/source/drivers/thermal/rockchi=
p_thermal.c#L798

Thanks
-Anand

