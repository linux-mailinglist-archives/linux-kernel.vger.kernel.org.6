Return-Path: <linux-kernel+bounces-516570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD92A37420
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFCD3AAA55
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528518F2EA;
	Sun, 16 Feb 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPafPQNU"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F89450;
	Sun, 16 Feb 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739709131; cv=none; b=ML8bzjUHpgLfjOoCVrIRfraL5dym5iZ4yN99o5bCypw9e2deszxXnZScuUqzvPU7pkm3+hTFLw9VXSZGvNc09VZXtNYObspD13+xaH7zWa04E4U5nOxlJtkcj4R5rGfYp2aJU0Tmyy/0V6Oq8GUGyX6Qj1Jx/DEV1zRVYoIxljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739709131; c=relaxed/simple;
	bh=BWfZJmwKHkGRJvK3yJiVpCNBiYui01PINhOsku8NgP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7RdmPounz0Jngyoe+MgvFbPcXkw0tbfkA1Psy0/bUGrr1CHGIsoHGtsAK5IyD7xGUPqw3FlpNogd9ol54vCzyBhRgf2mFxrtk54Q2Z43kt3Lzp+bpye50ayyRcQUzOXFs7vuYsgyCwTYpkhWYgajkZeEsB7iRb79tw8vTaJbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPafPQNU; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471dc990e18so11275771cf.0;
        Sun, 16 Feb 2025 04:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739709128; x=1740313928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pmRU4oV8Lwr70PJWkHKSc+JQWjhbwJ0zctlvUTldiE=;
        b=XPafPQNUOG+hB6BDxVNRRlL/cGIRgfp847dzxwa0WzlLb5ZI7Y+csQJF4wGTC+s3Nu
         D8hkTyRZOrUA96QNKD0feIv25zwnk4/jR2hII3FrH+GPS/wdJ9LzX92i/xqB7KpEuWfD
         3W7dKDIEgRZ0QV/Q64tmmqBAZek0yakN8PRGkg6+YpxB+whQ5gvCoO85JorXCIzI+Sco
         clANxBRgOhKfvFXSk/xTAVlmAvR7OIXFe/MkD3FC5XU/urYCShPd/3yBd7BR0miqJ5Pb
         FKvaK2KtnbwU5rWxLEvMoQaBHkSgb4ajmE5PnwIG5SgxfhNnh+uyFGkjXsA/j0qqQk2y
         ErcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739709128; x=1740313928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pmRU4oV8Lwr70PJWkHKSc+JQWjhbwJ0zctlvUTldiE=;
        b=Hx6doaiqSsuTXFtGsgCVNNCPCBFx0h1s7PdF8g9GqReM+b/ff0U6iztppAzSFzpMAy
         80uOMQpnWfQPvuGy1yCcDreFvDEvvWD4xtHqBmYN15SbEJEuXvkjFpsM/RbHMdLskOqV
         jesC/pdRNzSYYY8RaijHL0/oIjhqtN4aFMW4drY7b06/KWaSKsqfrVNcHZ6fjaOiRGV6
         tgAn15/zM5qM5kRsbpki3R7vfHXohv+UxvzZcjCEr27oNXQWrnngI/KdyGzkBt38Kmjf
         676OGd2Kn1Ql/fm/aGk0UivvljmLVwdpCn2m9OQw8coLhIGSf8CSIsGCJ+Qq3O3IXnaP
         sInQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6cTCSqdEvyxL3eKe2jRx3m/RqZ16fCJjXRdNuMKZJRHCVgErVCX3CYUrRjvMWoMjRZbk3/Z1EFwja@vger.kernel.org, AJvYcCXbplmTyXrjYwPK8JXpQ5cceabzZmN5Maq9cdpSjQkaqC7LRuHAeQTxOhvUogGw9rJkFZjqa+Yr0p6WKV/T@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bsMPSoRQBRMpKZngftjDMNDwMyszQNuVb4Vo3j9DK551uHPi
	UF6sDgpDF7F989Hi5Bj2QyhoN7nHG+uH3t/ezttR2OyDWcwMq6apNBpywYJAPQH29VzYqAPi2CJ
	XMU+ukFhbvY6X1jjCa70l2NuT+UQ=
X-Gm-Gg: ASbGncvUb+1on03G4bNRtyovKpTo+KvwsZkkaMq/W66sdUddxPeQUgGw4UfeQBj5rG+
	JfaNKNFAKyw53tvTLQ4u58X98RNb7gZLGVKK6+WgKAPM8krYJlPC5Ok/WiGTN+4wDvjxYYY4c2+
	w=
X-Google-Smtp-Source: AGHT+IHWuSE1Y3gFhYEtN+DZ/0JnI2ICnduM/7vMvfprywwSYgWgj2BhMei/y/cbzJAVNP5zlk73gFgjgP1Mp2EmMmg=
X-Received: by 2002:ac8:7e8d:0:b0:471:d132:f91b with SMTP id
 d75a77b69052e-471dbccbaa2mr79514361cf.3.1739709127957; Sun, 16 Feb 2025
 04:32:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <d8ce8db2-1717-40f8-b53e-24cc71a758c9@cherry.de> <CABjd4Yw-r-ogfwcrph4K1wbkybS25gk6LFg8wpqLG27uWdybNA@mail.gmail.com>
 <2914631.KiezcSG77Q@diego>
In-Reply-To: <2914631.KiezcSG77Q@diego>
From: Alexey Charkov <alchark@gmail.com>
Date: Sun, 16 Feb 2025 15:32:01 +0300
X-Gm-Features: AWEUYZnpDb3wjAorVn4kGg8idUTWI0ik5GUkTOikdcLRJ5KAatVLRX81_8fVTX4
Message-ID: <CABjd4YxF4N1tAgGUZk-oKkMUO+Q9rWHZsas9gMQdJ+TF4A1=NA@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588j
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Dragan Simic <dsimic@manjaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kever Yang <kever.yang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Sat, Feb 15, 2025 at 11:30=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.d=
e> wrote:
>
> Am Samstag, 15. Februar 2025, 19:59:44 MEZ schrieb Alexey Charkov:
> > On Tue, Feb 11, 2025 at 7:32=E2=80=AFPM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> > > On 6/17/24 8:28 PM, Alexey Charkov wrote:
> > > > RK3588j is the 'industrial' variant of RK3588, and it uses a differ=
ent
> > > > set of OPPs both in terms of allowed frequencies and in terms of
> > > > applicable voltages at each frequency setpoint.
> > > >
> > > > Add the OPPs that apply to RK3588j (and apparently RK3588m too) to
> > > > enable dynamic CPU frequency scaling.
> > > >
> > > > OPP values are derived from Rockchip downstream sources [1] by taki=
ng
> > > > only those OPPs which have the highest frequency for a given voltag=
e
> > > > level and dropping the rest (if they are included, the kernel compl=
ains
> > > > at boot time about them being inefficient)
> > > >
> > > > [1] https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96=
c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > > >
> > >
> > > Funny stuff actually. Rockchip have their own downstream cpufreq driv=
er
> > > which autodetects at runtime the SoC variant and filter out OPPs base=
d
> > > on that info. And this patch is based on those values and filters.
> > >
> > > However, they also decided that maybe this isn't the best way to do i=
t
> > > and they decided to have an rk3588j.dtsi where they remove some of th=
ose
> > > OPPs instead of just updating the mask/filter in their base dtsi
> > > (rk3588s.dtsi downstream). See
> > > https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2=
fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> >
> > Funny stuff indeed! Judging by the comments in the file you
> > referenced, those higher OPP values constitute an 'overdrive' mode,
> > and apparently the chip shouldn't stay in those for prolonged periods
> > of time. However, I couldn't locate any dts file inside Rockchip
> > sources that would include this rk3588j.dtsi - so not sure if we
> > should follow what it says too zealously.
> >
> > > So...
> > >
> > > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > > > ---
> > > >   arch/arm64/boot/dts/rockchip/rk3588j.dtsi | 108 +++++++++++++++++=
+++++++++++++
> > > >   1 file changed, 108 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64=
/boot/dts/rockchip/rk3588j.dtsi
> > > > index 0bbeee399a63..b7e69553857b 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> > > > @@ -5,3 +5,111 @@
> > > >    */
> > > >
> > > >   #include "rk3588-extra.dtsi"
> > > > +
> > > > +/ {
> > > > +     cluster0_opp_table: opp-table-cluster0 {
> > > > +             compatible =3D "operating-points-v2";
> > > > +             opp-shared;
> > > > +
> > > > +             opp-1416000000 {
> > > > +                     opp-hz =3D /bits/ 64 <1416000000>;
> > > > +                     opp-microvolt =3D <750000 750000 950000>;
> > > > +                     clock-latency-ns =3D <40000>;
> > > > +                     opp-suspend;
> > > > +             };
> > > > +             opp-1608000000 {
> > > > +                     opp-hz =3D /bits/ 64 <1608000000>;
> > > > +                     opp-microvolt =3D <887500 887500 950000>;
> > > > +                     clock-latency-ns =3D <40000>;
> > > > +             };
> > > > +             opp-1704000000 {
> > > > +                     opp-hz =3D /bits/ 64 <1704000000>;
> > > > +                     opp-microvolt =3D <937500 937500 950000>;
> > > > +                     clock-latency-ns =3D <40000>;
> > > > +             };
> > >
> > > None of those are valid according to Rockchip, we should have
> >
> > Well, valid but more taxing on the hardware apparently.
> >
> > >                 opp-1296000000 {
> > >                         opp-hz =3D /bits/ 64 <1296000000>;
> > >                         opp-microvolt =3D <750000 750000 950000>;
> > >                         clock-latency-ns =3D <40000>;
> > >                         opp-suspend;
> > >                 };
> > >
> > > instead?
> >
> > I dropped this one because it uses a lower frequency but same voltage
> > as the 1.416 GHz one, thus being 'inefficient' as the thermal
> > subsystem says in the logs. It can be added back if we decide to
> > remove opp-1416000000.
> >
> > > and...
> > >
> > > > +     };
> > > > +
> > > > +     cluster1_opp_table: opp-table-cluster1 {
> > > > +             compatible =3D "operating-points-v2";
> > > > +             opp-shared;
> > > > +
> > > > +             opp-1416000000 {
> > > > +                     opp-hz =3D /bits/ 64 <1416000000>;
> > > > +                     opp-microvolt =3D <750000 750000 950000>;
> > > > +                     clock-latency-ns =3D <40000>;
> > > > +             };
> > > > +             opp-1608000000 {
> > > > +                     opp-hz =3D /bits/ 64 <1608000000>;
> > > > +                     opp-microvolt =3D <787500 787500 950000>;
> > > > +                     clock-latency-ns =3D <40000>;
> > > > +             };
> > > > +             opp-1800000000 {
> > > > +                     opp-hz =3D /bits/ 64 <1800000000>;
> > > > +                     opp-microvolt =3D <875000 875000 950000>;
> > > > +                     clock-latency-ns =3D <40000>;
> > > > +             };
> > > > +             opp-2016000000 {
> > > > +                     opp-hz =3D /bits/ 64 <2016000000>;
> > > > +                     opp-microvolt =3D <950000 950000 950000>;
> > > > +                     clock-latency-ns =3D <40000>;
> > > > +             };
> > >
> > > opp-1800000000 and opp-2016000000 should be removed.
> > >
> > > and...
> > >
> > > > +     };
> > > > +
> > > > +     cluster2_opp_table: opp-table-cluster2 {
> > > > +             compatible =3D "operating-points-v2";
> > > > +             opp-shared;
> > > > +
> > > > +             opp-1416000000 {
> > > > +                     opp-hz =3D /bits/ 64 <1416000000>;
> > > > +                     opp-microvolt =3D <750000 750000 950000>;
> > > > +                     clock-latency-ns =3D <40000>;
> > > > +             };
> > > > +             opp-1608000000 {
> > > > +                     opp-hz =3D /bits/ 64 <1608000000>;
> > > > +                     opp-microvolt =3D <787500 787500 950000>;
> > > > +                     clock-latency-ns =3D <40000>;
> > > > +             };
> > > > +             opp-1800000000 {
> > > > +                     opp-hz =3D /bits/ 64 <1800000000>;
> > > > +                     opp-microvolt =3D <875000 875000 950000>;
> > > > +                     clock-latency-ns =3D <40000>;
> > > > +             };
> > > > +             opp-2016000000 {
> > > > +                     opp-hz =3D /bits/ 64 <2016000000>;
> > > > +                     opp-microvolt =3D <950000 950000 950000>;
> > > > +                     clock-latency-ns =3D <40000>;
> > > > +             };
> > >
> > > opp-1800000000 and opp-2016000000 should be removed as well.
> > >
> > > Did I misunderstand what Rockchip did here? Adding Kever in Cc at lea=
st
> > > for awareness on Rockchip side :)
> > >
> > > I guess another option could be to mark those above as
> > >
> > > turbo-mode;
> > >
> > > though no clue what this would entail. From a glance at cpufreq, it
> > > seems that for Rockchip since we use the default cpufreq-dt, it would
> > > mark those as unusable, so essentially a no-op, so better remove them
> > > entirely?
> >
> > I believe the opp core just marks 'turbo-mode' opps as
> > CPUFREQ_BOOST_FREQ, and cpufreq-dt only passes that flag along to the
> > cpufreq core. But then to actually use those boost frequencies I would
> > guess the governor needs to somehow know the power/thermal constraints
> > of the chip?.. Don't know where that is defined.
>
> personally I don't believe in "boost" frequencies - except when they are
> declared officially.
>
> Rockchip for the longest time maintains that running the chip outside
> the declared power/rate envelope can reduce its overall lifetime.
>
> So for Rockchip in mainline a "it runs stable for me" has never been a
> suitable reasoning ;-) .

My key concern here was perhaps that we are looking at a file inside
the Rockchip source tree which looks relevant by the name of it, but
doesn't actually get included anywhere for any of the boards. This may
or may not constitute an endorsement by Rockchip of any OPPs listed
there :-D

I haven't seen a TRM for the J variant, nor do I have a board with
RK3588J to run tests, so it would be great if Kever could chime in
with how these OPPs are different from the others (or not).

> So while the situation might be strange for the rk3588j, I really only wa=
nt
> correct frequencies here please - not any pseudo "turbo freqs".
>
> I don't care that much what people do on their own device{s/trees}, but
> the devicetrees we supply centrally (and to u-boot, etc) should only
> contain frequencies vetted by the manufacturer.

Fair enough. Let's just try and get another data point on whether
these frequencies are vetted or not.

Best regards,
Alexey

