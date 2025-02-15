Return-Path: <linux-kernel+bounces-516392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158BEA37098
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 21:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C647016F6C9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951471EEA5A;
	Sat, 15 Feb 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Flupwaio"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0512523CE;
	Sat, 15 Feb 2025 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739651480; cv=none; b=ciT/70IsIqsAageBWzt/8cuIZhWmrBrJZbkNt5bksIGx38JZDmPYgyRt1WnCXXo0fGQUV5lix+p8UDVIA5F7xVQKL05MSv2n1B37p+Zac/IeNdH5UbbEmRJrY0K04Egu782I2mmx9j80MQT55GD53OP/kgl56EZcmMetgeQJ68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739651480; c=relaxed/simple;
	bh=Yt//KzhuEt5j9EVqjPB9bfExJy6w6nFCzpoBkKKFJak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxNOHNySyQ1fyLVBTm1SLqF4ATEnyZwk9Y54Gp+SOsC7UqqF7CYD/9UAqjnu+ZU78Yv8qkN0rQiEoGRH3dLBMtklLfenuyI3ivGRYOOW07rKJjWn6nwNNluMsMVstBkzOuCSGL1R/l6ie8jNsC60EPI2LA8iMM6gvTII4CrDOGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Flupwaio; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A2L2E31Kpcq2+Iyw5Ftui3TXJtYkGBgQkdNUSK6FOPU=; b=Flupwaio4FmJ5qZoIxxEyCdL4j
	Rv1lnQoaicYreRiyWAyW6vkXr/NvviMBnAR+873c+sjRIkLY6Ed90qjsEyz/zppb4wmlgmcr0E/K2
	WzmCh9Mbpe0HlZy4FfXCx/OUNLZLFVxYFT7EdzTsppKcPGJWq7sQaRU/hiHVs7xB+P+fv91XCR4Qe
	MDMylFpyZdVm5iy1yiAvk3Xqr2rZX+o7351DSyfMp3nBqqXlW3W1wS0fCHLqOLZ/oXJNDMPJgqnPb
	7TKCFzsuYAz5GUVyfwDPBq/x9iObMpIwaWsZKUdd+KctiCEOsAhNoFP9zteep+TfXe3cUbhouijFs
	GwsVFESQ==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tjOoP-0007aw-OE; Sat, 15 Feb 2025 21:30:53 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kever Yang <kever.yang@rock-chips.com>
Subject:
 Re: [PATCH v5 7/8] arm64: dts: rockchip: Add OPP data for CPU cores on
 RK3588j
Date: Sat, 15 Feb 2025 21:30:52 +0100
Message-ID: <2914631.KiezcSG77Q@diego>
In-Reply-To:
 <CABjd4Yw-r-ogfwcrph4K1wbkybS25gk6LFg8wpqLG27uWdybNA@mail.gmail.com>
References:
 <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <d8ce8db2-1717-40f8-b53e-24cc71a758c9@cherry.de>
 <CABjd4Yw-r-ogfwcrph4K1wbkybS25gk6LFg8wpqLG27uWdybNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Samstag, 15. Februar 2025, 19:59:44 MEZ schrieb Alexey Charkov:
> On Tue, Feb 11, 2025 at 7:32=E2=80=AFPM Quentin Schulz <quentin.schulz@ch=
erry.de> wrote:
> > On 6/17/24 8:28 PM, Alexey Charkov wrote:
> > > RK3588j is the 'industrial' variant of RK3588, and it uses a different
> > > set of OPPs both in terms of allowed frequencies and in terms of
> > > applicable voltages at each frequency setpoint.
> > >
> > > Add the OPPs that apply to RK3588j (and apparently RK3588m too) to
> > > enable dynamic CPU frequency scaling.
> > >
> > > OPP values are derived from Rockchip downstream sources [1] by taking
> > > only those OPPs which have the highest frequency for a given voltage
> > > level and dropping the rest (if they are included, the kernel complai=
ns
> > > at boot time about them being inefficient)
> > >
> > > [1] https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c7=
34f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > >
> >
> > Funny stuff actually. Rockchip have their own downstream cpufreq driver
> > which autodetects at runtime the SoC variant and filter out OPPs based
> > on that info. And this patch is based on those values and filters.
> >
> > However, they also decided that maybe this isn't the best way to do it
> > and they decided to have an rk3588j.dtsi where they remove some of those
> > OPPs instead of just updating the mask/filter in their base dtsi
> > (rk3588s.dtsi downstream). See
> > https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fa=
b7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>=20
> Funny stuff indeed! Judging by the comments in the file you
> referenced, those higher OPP values constitute an 'overdrive' mode,
> and apparently the chip shouldn't stay in those for prolonged periods
> of time. However, I couldn't locate any dts file inside Rockchip
> sources that would include this rk3588j.dtsi - so not sure if we
> should follow what it says too zealously.
>=20
> > So...
> >
> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > > ---
> > >   arch/arm64/boot/dts/rockchip/rk3588j.dtsi | 108 +++++++++++++++++++=
+++++++++++
> > >   1 file changed, 108 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk3588j.dtsi
> > > index 0bbeee399a63..b7e69553857b 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> > > @@ -5,3 +5,111 @@
> > >    */
> > >
> > >   #include "rk3588-extra.dtsi"
> > > +
> > > +/ {
> > > +     cluster0_opp_table: opp-table-cluster0 {
> > > +             compatible =3D "operating-points-v2";
> > > +             opp-shared;
> > > +
> > > +             opp-1416000000 {
> > > +                     opp-hz =3D /bits/ 64 <1416000000>;
> > > +                     opp-microvolt =3D <750000 750000 950000>;
> > > +                     clock-latency-ns =3D <40000>;
> > > +                     opp-suspend;
> > > +             };
> > > +             opp-1608000000 {
> > > +                     opp-hz =3D /bits/ 64 <1608000000>;
> > > +                     opp-microvolt =3D <887500 887500 950000>;
> > > +                     clock-latency-ns =3D <40000>;
> > > +             };
> > > +             opp-1704000000 {
> > > +                     opp-hz =3D /bits/ 64 <1704000000>;
> > > +                     opp-microvolt =3D <937500 937500 950000>;
> > > +                     clock-latency-ns =3D <40000>;
> > > +             };
> >
> > None of those are valid according to Rockchip, we should have
>=20
> Well, valid but more taxing on the hardware apparently.
>=20
> >                 opp-1296000000 {
> >                         opp-hz =3D /bits/ 64 <1296000000>;
> >                         opp-microvolt =3D <750000 750000 950000>;
> >                         clock-latency-ns =3D <40000>;
> >                         opp-suspend;
> >                 };
> >
> > instead?
>=20
> I dropped this one because it uses a lower frequency but same voltage
> as the 1.416 GHz one, thus being 'inefficient' as the thermal
> subsystem says in the logs. It can be added back if we decide to
> remove opp-1416000000.
>=20
> > and...
> >
> > > +     };
> > > +
> > > +     cluster1_opp_table: opp-table-cluster1 {
> > > +             compatible =3D "operating-points-v2";
> > > +             opp-shared;
> > > +
> > > +             opp-1416000000 {
> > > +                     opp-hz =3D /bits/ 64 <1416000000>;
> > > +                     opp-microvolt =3D <750000 750000 950000>;
> > > +                     clock-latency-ns =3D <40000>;
> > > +             };
> > > +             opp-1608000000 {
> > > +                     opp-hz =3D /bits/ 64 <1608000000>;
> > > +                     opp-microvolt =3D <787500 787500 950000>;
> > > +                     clock-latency-ns =3D <40000>;
> > > +             };
> > > +             opp-1800000000 {
> > > +                     opp-hz =3D /bits/ 64 <1800000000>;
> > > +                     opp-microvolt =3D <875000 875000 950000>;
> > > +                     clock-latency-ns =3D <40000>;
> > > +             };
> > > +             opp-2016000000 {
> > > +                     opp-hz =3D /bits/ 64 <2016000000>;
> > > +                     opp-microvolt =3D <950000 950000 950000>;
> > > +                     clock-latency-ns =3D <40000>;
> > > +             };
> >
> > opp-1800000000 and opp-2016000000 should be removed.
> >
> > and...
> >
> > > +     };
> > > +
> > > +     cluster2_opp_table: opp-table-cluster2 {
> > > +             compatible =3D "operating-points-v2";
> > > +             opp-shared;
> > > +
> > > +             opp-1416000000 {
> > > +                     opp-hz =3D /bits/ 64 <1416000000>;
> > > +                     opp-microvolt =3D <750000 750000 950000>;
> > > +                     clock-latency-ns =3D <40000>;
> > > +             };
> > > +             opp-1608000000 {
> > > +                     opp-hz =3D /bits/ 64 <1608000000>;
> > > +                     opp-microvolt =3D <787500 787500 950000>;
> > > +                     clock-latency-ns =3D <40000>;
> > > +             };
> > > +             opp-1800000000 {
> > > +                     opp-hz =3D /bits/ 64 <1800000000>;
> > > +                     opp-microvolt =3D <875000 875000 950000>;
> > > +                     clock-latency-ns =3D <40000>;
> > > +             };
> > > +             opp-2016000000 {
> > > +                     opp-hz =3D /bits/ 64 <2016000000>;
> > > +                     opp-microvolt =3D <950000 950000 950000>;
> > > +                     clock-latency-ns =3D <40000>;
> > > +             };
> >
> > opp-1800000000 and opp-2016000000 should be removed as well.
> >
> > Did I misunderstand what Rockchip did here? Adding Kever in Cc at least
> > for awareness on Rockchip side :)
> >
> > I guess another option could be to mark those above as
> >
> > turbo-mode;
> >
> > though no clue what this would entail. From a glance at cpufreq, it
> > seems that for Rockchip since we use the default cpufreq-dt, it would
> > mark those as unusable, so essentially a no-op, so better remove them
> > entirely?
>=20
> I believe the opp core just marks 'turbo-mode' opps as
> CPUFREQ_BOOST_FREQ, and cpufreq-dt only passes that flag along to the
> cpufreq core. But then to actually use those boost frequencies I would
> guess the governor needs to somehow know the power/thermal constraints
> of the chip?.. Don't know where that is defined.

personally I don't believe in "boost" frequencies - except when they are
declared officially.

Rockchip for the longest time maintains that running the chip outside
the declared power/rate envelope can reduce its overall lifetime.

So for Rockchip in mainline a "it runs stable for me" has never been a
suitable reasoning ;-) .

So while the situation might be strange for the rk3588j, I really only want
correct frequencies here please - not any pseudo "turbo freqs".

I don't care that much what people do on their own device{s/trees}, but
the devicetrees we supply centrally (and to u-boot, etc) should only
contain frequencies vetted by the manufacturer.


Heiko



