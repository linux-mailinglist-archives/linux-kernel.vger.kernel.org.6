Return-Path: <linux-kernel+bounces-516373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A703A37041
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E383B0AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DEB1EE019;
	Sat, 15 Feb 2025 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exef2AXX"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986986344;
	Sat, 15 Feb 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739645994; cv=none; b=d6wPUMN1EiDs1z/6jzqKX0P3mX2VUmmy50uxFwkJw6nY8BHLa6pBy7p/cH1H2XKF/DKe1zLdgeDrPWJhDgcljBEGHRSKURxX4v/j7lRfOSWrUNeC1wpDief1HIPAdoCPK0CicjpBrcVA+0tYQJB+TIGVqL34+BFH+J4Y28qJtQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739645994; c=relaxed/simple;
	bh=SIek9AZrmDDSHA/mGhVsfU1xRpl+TjHv7xhuwz2zBwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vv3KtIfZSrPsHcTxjxvr2RNpve7WBkgJm1hw2X+9NPLI5wUpo+AxNNtKKtY4hU6AfnP6ZazyH5AQrujmXj1SzaS5TNXt0XHBOpzWBb3THOWCnZQNaHkx2+rXMMUq8kwlTrCiYnfr8aqEpiAAiZS627O3TSNVdAD+OFLHgJCtvR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exef2AXX; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46b1d40abbdso26099341cf.2;
        Sat, 15 Feb 2025 10:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739645992; x=1740250792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTdyAEdwmG2Xhseb5nN+DvsL/03ZonxPNgdIwAd3G1I=;
        b=exef2AXXTflwkY+dNDig10PxVj7GQKMpcFu4ysLXF1qSiw4UKTJogYCFiyX358Im69
         ZLcZhNPPIfqrYAYQRwhVcGOxo30sBksWyleHx0o5m8HJoU+CQf3gpK0qkl5etffLfTZL
         vhTndnE4olVJv5tnafSUycVJhXWAzQ7tk4s3MFu4Hi9DM/82GP85aImli9QjhzNi43Eu
         tGR5VNCDYfnNHakt1hn2ONnIFUu9fpPEW9O/xVdINLIhz+0yfJmiGCuPS2mnp028iXtZ
         LhueeGVyxSYUgPpc4bBvhkPo2+tfqyEyWKsiU+Gfioap3smIu6/Cgl50xah8LjFkQXEr
         JM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739645992; x=1740250792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTdyAEdwmG2Xhseb5nN+DvsL/03ZonxPNgdIwAd3G1I=;
        b=asNUacTsRepD7QsYMPFKbnswC9/z8EOVnKcsSuCX4aXo1aMwQU190/9yUdu2XArQ7E
         W/GPXdANvLASvGMPdpHXFiZrqVNy+dTWUVMcsiUYoCMWGZjzWllvzs2yws+pJsiKnbip
         f+/5W4HWYiQ4hpuypxD+GpXB+Fh4BHNcP+XHEnU4TcqXxWRcKanJseLJROVo0bB9fIOj
         UOaXn2Z0voL4Hb8+mLTFdTlBy6Eif4oa+m5ogpDCWKG8JErGAybgJg22qgyhB65BWLJZ
         e4udbSsD5omlQURe6szzBy5/IOSRm07jtLEVvNY/P6+JMvqhaGl/aohVNyHcCiCpkcKe
         Ki2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcZ8Vt6ByMkYFjdMnvZ3ivwMUIWBt6cdJCiTyuJOwfYyKk4pfhS19dpGyOFACvPx3mc7J7/JPM1Uk4bpKj@vger.kernel.org, AJvYcCXJqfFMOn56fR2PY/m/4KRUwQrFwEpeycDen7cmfyRI+IpvSw/ZRNQ+MXFG6Zkt/aXY2QGx5JzhxFDE@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ86mT3zUuwukVZ8WVYLw8zrExnxicwwOPR7qlUxBv3eo8MMjN
	PKrSGW0hFoJ56PaaGWcxfFpRru/y5u78k4IofQkeP+8QevKoIqMQer/b+zAgQZsO/Qt7A+vgbHN
	cJZsU7gAhu3DKtNRR82TNvvD/N3vvBUmfYLszdvA6
X-Gm-Gg: ASbGncvbIhMF6XOYjZgkyO5pqXS7b8ruVOUcBcm9EWq2qdCnlGKQ3MXhx6kQRLRykvo
	z+bGfVdDkIi7unaQAtAmlaf+LlPGsbyxc8RgxnoXWmDzP8Jsluli1NzKewyClPGNbMtuCqiQo+m
	c=
X-Google-Smtp-Source: AGHT+IEsmXhJVdCVr8Bg6tahWwwvjf0aL4gfGKBNLDAW1xv9dvvbafCFVU91Pi/cY5fJ/ARik12lizAot8rgosoNp9g=
X-Received: by 2002:ac8:5988:0:b0:471:ae33:b35a with SMTP id
 d75a77b69052e-471dbea0cd0mr53875731cf.41.1739645991985; Sat, 15 Feb 2025
 10:59:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <20240617-rk-dts-additions-v5-7-c1f5f3267f1e@gmail.com> <d8ce8db2-1717-40f8-b53e-24cc71a758c9@cherry.de>
In-Reply-To: <d8ce8db2-1717-40f8-b53e-24cc71a758c9@cherry.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Sat, 15 Feb 2025 21:59:44 +0300
X-Gm-Features: AWEUYZnvNTR7HkacV2LThVjtWGe7OZYAvU7_F4y9BXZkoo6KpcSWYw8wQ8OOOjY
Message-ID: <CABjd4Yw-r-ogfwcrph4K1wbkybS25gk6LFg8wpqLG27uWdybNA@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588j
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kever Yang <kever.yang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Quentin,

On Tue, Feb 11, 2025 at 7:32=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi all,
>
> On 6/17/24 8:28 PM, Alexey Charkov wrote:
> > RK3588j is the 'industrial' variant of RK3588, and it uses a different
> > set of OPPs both in terms of allowed frequencies and in terms of
> > applicable voltages at each frequency setpoint.
> >
> > Add the OPPs that apply to RK3588j (and apparently RK3588m too) to
> > enable dynamic CPU frequency scaling.
> >
> > OPP values are derived from Rockchip downstream sources [1] by taking
> > only those OPPs which have the highest frequency for a given voltage
> > level and dropping the rest (if they are included, the kernel complains
> > at boot time about them being inefficient)
> >
> > [1] https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734=
f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >
>
> Funny stuff actually. Rockchip have their own downstream cpufreq driver
> which autodetects at runtime the SoC variant and filter out OPPs based
> on that info. And this patch is based on those values and filters.
>
> However, they also decided that maybe this isn't the best way to do it
> and they decided to have an rk3588j.dtsi where they remove some of those
> OPPs instead of just updating the mask/filter in their base dtsi
> (rk3588s.dtsi downstream). See
> https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7=
b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588j.dtsi

Funny stuff indeed! Judging by the comments in the file you
referenced, those higher OPP values constitute an 'overdrive' mode,
and apparently the chip shouldn't stay in those for prolonged periods
of time. However, I couldn't locate any dts file inside Rockchip
sources that would include this rk3588j.dtsi - so not sure if we
should follow what it says too zealously.

> So...
>
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3588j.dtsi | 108 +++++++++++++++++++++=
+++++++++
> >   1 file changed, 108 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/boo=
t/dts/rockchip/rk3588j.dtsi
> > index 0bbeee399a63..b7e69553857b 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> > @@ -5,3 +5,111 @@
> >    */
> >
> >   #include "rk3588-extra.dtsi"
> > +
> > +/ {
> > +     cluster0_opp_table: opp-table-cluster0 {
> > +             compatible =3D "operating-points-v2";
> > +             opp-shared;
> > +
> > +             opp-1416000000 {
> > +                     opp-hz =3D /bits/ 64 <1416000000>;
> > +                     opp-microvolt =3D <750000 750000 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +                     opp-suspend;
> > +             };
> > +             opp-1608000000 {
> > +                     opp-hz =3D /bits/ 64 <1608000000>;
> > +                     opp-microvolt =3D <887500 887500 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
> > +             opp-1704000000 {
> > +                     opp-hz =3D /bits/ 64 <1704000000>;
> > +                     opp-microvolt =3D <937500 937500 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
>
> None of those are valid according to Rockchip, we should have

Well, valid but more taxing on the hardware apparently.

>                 opp-1296000000 {
>                         opp-hz =3D /bits/ 64 <1296000000>;
>                         opp-microvolt =3D <750000 750000 950000>;
>                         clock-latency-ns =3D <40000>;
>                         opp-suspend;
>                 };
>
> instead?

I dropped this one because it uses a lower frequency but same voltage
as the 1.416 GHz one, thus being 'inefficient' as the thermal
subsystem says in the logs. It can be added back if we decide to
remove opp-1416000000.

> and...
>
> > +     };
> > +
> > +     cluster1_opp_table: opp-table-cluster1 {
> > +             compatible =3D "operating-points-v2";
> > +             opp-shared;
> > +
> > +             opp-1416000000 {
> > +                     opp-hz =3D /bits/ 64 <1416000000>;
> > +                     opp-microvolt =3D <750000 750000 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
> > +             opp-1608000000 {
> > +                     opp-hz =3D /bits/ 64 <1608000000>;
> > +                     opp-microvolt =3D <787500 787500 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
> > +             opp-1800000000 {
> > +                     opp-hz =3D /bits/ 64 <1800000000>;
> > +                     opp-microvolt =3D <875000 875000 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
> > +             opp-2016000000 {
> > +                     opp-hz =3D /bits/ 64 <2016000000>;
> > +                     opp-microvolt =3D <950000 950000 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
>
> opp-1800000000 and opp-2016000000 should be removed.
>
> and...
>
> > +     };
> > +
> > +     cluster2_opp_table: opp-table-cluster2 {
> > +             compatible =3D "operating-points-v2";
> > +             opp-shared;
> > +
> > +             opp-1416000000 {
> > +                     opp-hz =3D /bits/ 64 <1416000000>;
> > +                     opp-microvolt =3D <750000 750000 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
> > +             opp-1608000000 {
> > +                     opp-hz =3D /bits/ 64 <1608000000>;
> > +                     opp-microvolt =3D <787500 787500 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
> > +             opp-1800000000 {
> > +                     opp-hz =3D /bits/ 64 <1800000000>;
> > +                     opp-microvolt =3D <875000 875000 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
> > +             opp-2016000000 {
> > +                     opp-hz =3D /bits/ 64 <2016000000>;
> > +                     opp-microvolt =3D <950000 950000 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
>
> opp-1800000000 and opp-2016000000 should be removed as well.
>
> Did I misunderstand what Rockchip did here? Adding Kever in Cc at least
> for awareness on Rockchip side :)
>
> I guess another option could be to mark those above as
>
> turbo-mode;
>
> though no clue what this would entail. From a glance at cpufreq, it
> seems that for Rockchip since we use the default cpufreq-dt, it would
> mark those as unusable, so essentially a no-op, so better remove them
> entirely?

I believe the opp core just marks 'turbo-mode' opps as
CPUFREQ_BOOST_FREQ, and cpufreq-dt only passes that flag along to the
cpufreq core. But then to actually use those boost frequencies I would
guess the governor needs to somehow know the power/thermal constraints
of the chip?.. Don't know where that is defined.

Best,
Alexey

