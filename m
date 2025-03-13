Return-Path: <linux-kernel+bounces-560234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B461A6004C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1BA3AC485
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9131EEA51;
	Thu, 13 Mar 2025 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xR6BM2cm"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E078C9C;
	Thu, 13 Mar 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892465; cv=none; b=oRNjT0TXnbQzIQlSKPqRZnMwMiHaVhgQ3lAO2VyRgT7s7m1fa4W00yOmzq6KxToBeUtbux1IKKC3oaPJv7Ze8xLlo+iPYx9RyuQOpj0ZKzrS7eKfjhxyMqKsXBEi6LEL/YqVWiKHwuB4jgIi+hhrrpC+l2fxj2WAlQi9u7gfrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892465; c=relaxed/simple;
	bh=pSVmGllTttvTFJsoQA7Fl64POuhcfvRXwFGcwndmA0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZwdt3I/61hVwWWVrmpWiFR930wEjKjpz0Y2zOEDQsY5kxgeYwWwlOf453GO6IT9Tf1ZreWwKfZZXPuvjaFQNyOnPsQr9+BZyBzwp/mQjkruQlAEoP+pbsXAjs+dlRlpNSt5oQqGhV+lcVRZ+AHveMcQjw54ICHDcdR+ZBoDMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xR6BM2cm; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WMLsc23o2VA6gSpVgAlsayo+yB0H4z9pqmva5w2FXqE=; b=xR6BM2cm1nS6H6rY4RiY0+X6Ij
	xE8g9qEk22quDoCqK0SF9kL9fPMDzVcvNE60rbRbSQlcfonOKugQpfSwhtNlCZSTrLNu51Fi4uH/x
	loNeU6y2XSXUE+03P88VQegXy9KpaqS1u0MrO6zH2s6VRdzG7FZEwNjSYC8srFzHxxFCAwtgebKmj
	bjSIRs3sg0F5FE7TythvpFujR9I+A8Qlgr3axVGZwfW2bcqLBGY8GbwNqpTBHBjO/MS12iZ/qJ9us
	WbZzkUVDzmgUzQ/I6ct7Rvf4DXgkJM2uVPva5a8aHl5TbUmTIo5RgbzWy43xcBmZtwjiI4ctyQct0
	kCp7WkrA==;
Received: from ip-185-104-138-79.ptr.icomera.net ([185.104.138.79] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsnnU-0001rO-Mo; Thu, 13 Mar 2025 20:00:49 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Dragan Simic <dsimic@manjaro.org>
Cc: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>,
 Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Kever Yang <kever.yang@rock-chips.com>
Subject:
 Re: [PATCH v5 7/8] arm64: dts: rockchip: Add OPP data for CPU cores on
 RK3588j
Date: Thu, 13 Mar 2025 20:00:40 +0100
Message-ID: <3271211.5fSG56mABF@phil>
In-Reply-To: <2cf3889741f84584d8f23a4407fed08e@manjaro.org>
References:
 <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <a56b59a21dc3c21192fe45197eee4865@manjaro.org>
 <2cf3889741f84584d8f23a4407fed08e@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 13. M=C3=A4rz 2025, 11:42:17 MEZ schrieb Dragan Simic:
> Hello all,
>=20
> On 2025-03-12 11:34, Dragan Simic wrote:
> > On 2025-03-12 11:15, Quentin Schulz wrote:
> >> On 2/16/25 1:32 PM, Alexey Charkov wrote:
> >>> On Sat, Feb 15, 2025 at 11:30=E2=80=AFPM Heiko St=C3=BCbner <heiko@sn=
tech.de>=20
> >>> wrote:
> >>>> Am Samstag, 15. Februar 2025, 19:59:44 MEZ schrieb Alexey Charkov:
> >>>>> On Tue, Feb 11, 2025 at 7:32=E2=80=AFPM Quentin Schulz=20
> >>>>> <quentin.schulz@cherry.de> wrote:
> >>>>>> On 6/17/24 8:28 PM, Alexey Charkov wrote:
> >> [...]
> >>>>>>> +     };
> >>>>>>> +
> >>>>>>> +     cluster2_opp_table: opp-table-cluster2 {
> >>>>>>> +             compatible =3D "operating-points-v2";
> >>>>>>> +             opp-shared;
> >>>>>>> +
> >>>>>>> +             opp-1416000000 {
> >>>>>>> +                     opp-hz =3D /bits/ 64 <1416000000>;
> >>>>>>> +                     opp-microvolt =3D <750000 750000 950000>;
> >>>>>>> +                     clock-latency-ns =3D <40000>;
> >>>>>>> +             };
> >>>>>>> +             opp-1608000000 {
> >>>>>>> +                     opp-hz =3D /bits/ 64 <1608000000>;
> >>>>>>> +                     opp-microvolt =3D <787500 787500 950000>;
> >>>>>>> +                     clock-latency-ns =3D <40000>;
> >>>>>>> +             };
> >>>>>>> +             opp-1800000000 {
> >>>>>>> +                     opp-hz =3D /bits/ 64 <1800000000>;
> >>>>>>> +                     opp-microvolt =3D <875000 875000 950000>;
> >>>>>>> +                     clock-latency-ns =3D <40000>;
> >>>>>>> +             };
> >>>>>>> +             opp-2016000000 {
> >>>>>>> +                     opp-hz =3D /bits/ 64 <2016000000>;
> >>>>>>> +                     opp-microvolt =3D <950000 950000 950000>;
> >>>>>>> +                     clock-latency-ns =3D <40000>;
> >>>>>>> +             };
> >>>>>>=20
> >>>>>> opp-1800000000 and opp-2016000000 should be removed as well.
> >>>>>>=20
> >>>>>> Did I misunderstand what Rockchip did here? Adding Kever in Cc at=
=20
> >>>>>> least
> >>>>>> for awareness on Rockchip side :)
> >>>>>>=20
> >>>>>> I guess another option could be to mark those above as
> >>>>>>=20
> >>>>>> turbo-mode;
> >>>>>>=20
> >>>>>> though no clue what this would entail. From a glance at cpufreq,=20
> >>>>>> it
> >>>>>> seems that for Rockchip since we use the default cpufreq-dt, it=20
> >>>>>> would
> >>>>>> mark those as unusable, so essentially a no-op, so better remove=20
> >>>>>> them
> >>>>>> entirely?
> >>>>>=20
> >>>>> I believe the opp core just marks 'turbo-mode' opps as
> >>>>> CPUFREQ_BOOST_FREQ, and cpufreq-dt only passes that flag along to=20
> >>>>> the
> >>>>> cpufreq core. But then to actually use those boost frequencies I=20
> >>>>> would
> >>>>> guess the governor needs to somehow know the power/thermal=20
> >>>>> constraints
> >>>>> of the chip?.. Don't know where that is defined.
> >>>>=20
> >>>> personally I don't believe in "boost" frequencies - except when they=
=20
> >>>> are
> >>>> declared officially.
> >>>>=20
> >>>> Rockchip for the longest time maintains that running the chip=20
> >>>> outside
> >>>> the declared power/rate envelope can reduce its overall lifetime.
> >>>>=20
> >>>> So for Rockchip in mainline a "it runs stable for me" has never been=
=20
> >>>> a
> >>>> suitable reasoning ;-) .
> >>>=20
> >>> My key concern here was perhaps that we are looking at a file inside
> >>> the Rockchip source tree which looks relevant by the name of it, but
> >>> doesn't actually get included anywhere for any of the boards. This=20
> >>> may
> >>> or may not constitute an endorsement by Rockchip of any OPPs listed
> >>> there :-D
> >>=20
> >> Rockchip support stated:
> >>=20
> >> """
> >> If you run overdrive mode, you do not need to include rk3588j.dtsi,
> >> and you can change it to #incldue rk3588.dtsi to ensure that the
> >> maximum frequency can reach 2GHz
> >>=20
> >> below picture from datasheet.
> >> """
> >>=20
> >> The picture is the table 3-2 Recommended operating conditions, page 30
> >> from the RK3588J datasheet, e.g.
> >> https://www.lcsc.com/datasheet/lcsc_datasheet_2403201054_Rockchip-RK35=
88J_C22364189.pdf
> >>=20
> >> What is overdrive?
> >>=20
> >> """
> >> Overdrive mode brings higher frequency, and the voltage will increase
> >> accordingly. Under
> >> the overdrive mode for a long time, the chipset may shorten the
> >> lifetime, especially in high temperature condition
> >> """
> >>=20
> >> according to the same datasheet, end of the same table, page 31.
> >>=20
> >> so this seems like a turbo-mode frequency to me.
> >>=20
> >> Additionally, the note for the "normal mode" (the one with the lower
> >> freqs) states:
> >>=20
> >> """
> >> Normal mode means the chipset works under safety voltage and=20
> >> frequency. For the
> >> industrial environment, highly recommend to keep in normal mode, the=20
> >> lifetime is
> >> reasonably guaranteed.
> >> """
> >>=20
> >> I believe "industrial environment" means RK3588J used in the
> >> temperatures that aren't OK for the standard RK3588 variant?
> >=20
> > Thanks a lot for obtaining these clarifications!
> >=20
> > Yes, I'd say that in this case "industrial environment" boils down
> > to the extended temperature range for the RK3588J variant.
> >=20
> >>> I haven't seen a TRM for the J variant, nor do I have a board with
> >>> RK3588J to run tests, so it would be great if Kever could chime in
> >>> with how these OPPs are different from the others (or not).
> >>>=20
> >>>> So while the situation might be strange for the rk3588j, I really=20
> >>>> only want
> >>>> correct frequencies here please - not any pseudo "turbo freqs".
> >>>>=20
> >>>> I don't care that much what people do on their own device{s/trees},=
=20
> >>>> but
> >>>> the devicetrees we supply centrally (and to u-boot, etc) should only
> >>>> contain frequencies vetted by the manufacturer.
> >>>=20
> >>> Fair enough. Let's just try and get another data point on whether
> >>> these frequencies are vetted or not.
> >>=20
> >> So the higher freqs seems to be vetted (and used by default on
> >> Rockchip's BSP kernel), it just feels like you aren't really supposed
> >> to run those higher frequencies all the time? And especially not in
> >> "industrial environment"?
> >>=20
> >> I would assume we want to stay on the safer side and remove those
> >> higher frequencies? Heiko?
> >=20
> > I agree, we should remove the higher-frequency OPPs.  I'd like
> > to go through everything once again in detail and prepare a patch
> > that removes the unsafe OPPs, and you could review it once it's
> > on the ML, to make sure it's fine.
>=20
> Just as a note, everything above (and even a bit more) is confirmed
> and clearly described in the publicly available RK3588J datasheet,
> which I'll provide as a reference in my upcoming patch.

so just to reiterate my stance, in mainline I really only want frequencies
that are not possibly influencing the lifetime of the chip.

It doesn't even matter about the variant we're talking about being
industrial :-) . When someone is using mainline I want them to be
reasonable assured that we don't have stuff in here that may affect
the lifetime of their board.

All gambling on performance for possible lifetime reduction people
can do on their own ... for example with a dt-overlay ;-) .

So TL;DR, I agree to both Quentin and Dragan


Heiko



