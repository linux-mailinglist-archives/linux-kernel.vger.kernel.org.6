Return-Path: <linux-kernel+bounces-296185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E395A6CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD17285D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF4D1791ED;
	Wed, 21 Aug 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="S3++nMM5"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B284113A3E8;
	Wed, 21 Aug 2024 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276346; cv=none; b=gkTKZAxsVw0+D9zjNSRsZEiUVHVkpx1B4MHlk1PEMN34ssXnQL2I6bCjJQkJ2PXFticeDB/0PQ1vfcrG6+Ma9NS/HwCh85UKCQ2V1lK1Xz6Ivk0ANg42VeSfDW/bvbD0U8jdMDGyvB3gakiA20z3/DUDO/rwRCtlZpqacZi4vuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276346; c=relaxed/simple;
	bh=QAeqAvUvhrbxTHHI4KQXAx7QgSWXyZ9qn9Zx2bP21hA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PclAnIZPIOElnpnLCcqHvmC3QC4fIt2XOnpO+55sLL+hfz1UgR/sODaTf7gbsaP0bFHoVY0GSWqfGYlO1zzMStDF9wzT2CX4qI/l/Sxmgw0l6h9zYkJcIqp6VXvqtqBXPcLWlWeuZm7jHc05bDDJNernRi8+fy6lLsdUyBSvOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=S3++nMM5; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MSF43bIu1gEw1AF3I55gly83QapAUrJr9/SaStsKq/4=; b=S3++nMM5yRgsyDIHX/FfyQrtY+
	LWD2rS/byAt7A+HSffH4ittnDi2ljMrbZPBscHrcPF77Z+YGyoWSWrfWCwzKRfimOOfrcLdj64xHs
	jOEagMKvI7PUjQHsgejDWUgqrLx7rWtYS+MXW+6iW+EPp1C6HsfKTzjSmDzqOsKvvGLcu7QVjv7Nu
	0gxb5/+aC7CpTyFyjmNe7YT5t+mNbVoVBg4hnGpv0owtvkiJR99tm9/f8ggvVEjF5nInmoMuaf4DB
	HUsCAHpumBTV2Yl+Po0DSvp/XXUh/TMn4fJvXPt1p396/VX2nPrMRtGwJS7XYnhe4zlFBZeQ2a3ek
	FMV3YUJA==;
Received: from i53875aca.versanet.de ([83.135.90.202] helo=[127.0.0.1])
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sgt26-0000W5-MN; Wed, 21 Aug 2024 23:38:22 +0200
Date: Wed, 21 Aug 2024 23:38:24 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Conor Dooley <conor@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
CC: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_3/4=5D_dt-bindings=3A_display=3A_rock?=
 =?US-ASCII?Q?chip=3A_Add_schema_for_RK3588_HDMI_TX_Controller?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240821-stretch-scam-09d7adc08a4c@spud>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com> <20240819-b4-rk3588-bridge-upstream-v4-3-6417c72a2749@collabora.com> <20240819-bobbing-purplish-99e48baa2304@spud> <ec84bc0b-c4c2-4735-9f34-52bc3a852aaf@collabora.com> <20240820-tropics-hunchback-6fdcd0b37f91@spud> <038073d0-d4b9-4938-9a51-ea2aeb4530f6@collabora.com> <20240821-evoke-mop-fb09ceef3597@spud> <5813cea2-4890-4fa9-8826-19be5bf3e161@collabora.com> <20240821-stretch-scam-09d7adc08a4c@spud>
Message-ID: <7E8109D4-A353-4FE3-9152-3C3C6CB7D634@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Am 21=2E August 2024 23:28:55 MESZ schrieb Conor Dooley <conor@kernel=2Eor=
g>:
>Cristian, Heiko,
>
>On Wed, Aug 21, 2024 at 11:38:01PM +0300, Cristian Ciocaltea wrote:
>> On 8/21/24 6:07 PM, Conor Dooley wrote:
>> > On Tue, Aug 20, 2024 at 11:12:45PM +0300, Cristian Ciocaltea wrote:
>> >> On 8/20/24 7:14 PM, Conor Dooley wrote:
>> >>> On Tue, Aug 20, 2024 at 03:37:44PM +0300, Cristian Ciocaltea wrote:
>> >>>> On 8/19/24 7:53 PM, Conor Dooley wrote:
>> >>>>> On Mon, Aug 19, 2024 at 01:29:30AM +0300, Cristian Ciocaltea wrot=
e:
>> >>>>>> +  rockchip,grf:
>> >>>>>> +    $ref: /schemas/types=2Eyaml#/definitions/phandle
>> >>>>>> +    description:
>> >>>>>> +      Most HDMI QP related data is accessed through SYS GRF reg=
s=2E
>> >>>>>> +
>> >>>>>> +  rockchip,vo1-grf:
>> >>>>>> +    $ref: /schemas/types=2Eyaml#/definitions/phandle
>> >>>>>> +    description:
>> >>>>>> +      Additional HDMI QP related data is accessed through VO1 G=
RF regs=2E
>> >>>>>
>> >>>>> Why are these required? What prevents you looking up the syscons =
by
>> >>>>> compatible?
>> >>>>
>> >>>> That is for getting the proper instance:
>> >>>
>> >>> Ah, that makes sense=2E I am, however, curious why these have the s=
ame
>> >>> compatible when they have different sized regions allocated to them=
=2E
>> >>
>> >> Good question, didn't notice=2E  I've just checked the TRM and, in b=
oth
>> >> cases, the maximum register offset is within the 0x100 range=2E  Pre=
sumably
>> >> this is nothing but an inconsistency, as the syscons have been added=
 in
>> >> separate commits=2E
>> >=20
>> > Is that TRM publicly available? I do find it curious that devices sou=
nd
>> > like they have different contents have the same compatible=2E In my v=
iew,
>> > that is incorrect and they should have unique compatibles if the
>> > contents (and therefore the programming model) differs=2E
>>=20
>> Don't know if there's an official location to get it from, but a quick
>> search on internet shows a few repos providing them, e=2Eg=2E [1]=2E
>>=20
>> Comparing "6=2E14 VO0_GRF Register Description" at pg=2E 777 with "6=2E=
15 VO1_GRF
>> Register Description" at pg=2E 786 (from Part1) reveals the layout is m=
ostly
>> similar, with a few variations though=2E
>
>Page references and everything, thank you very much=2E I don't think thos=
e
>two GRFs should have the same compatibles, they're, as you say, similar
>but not identical=2E Seems like a bug to me!
>
>Heiko, what do you think?

Yes, while the register names sound similar, looking at the bit definition=
s this evening revealed that they handle vastly different settings=2E

So I guess we should fix the compatibles=2E They are all about graphics st=
uff and HDMI actually is the first output, so right now WE can at least sti=
ll claim the no-users joker ;-)


Heiko

>
>> [1] https://github=2Ecom/FanX-Tek/rk3588-TRM-and-Datasheet
>>=20
>> >>
>> >>>> 	vo0_grf: syscon@fd5a6000 {
>> >>>> 		compatible =3D "rockchip,rk3588-vo-grf", "syscon";
>> >>>> 		reg =3D <0x0 0xfd5a6000 0x0 0x2000>;
>> >>>> 		clocks =3D <&cru PCLK_VO0GRF>;
>> >>>> 	};
>> >>>>
>> >>>> 	vo1_grf: syscon@fd5a8000 {
>> >>>> 		compatible =3D "rockchip,rk3588-vo-grf", "syscon";
>> >>>> 		reg =3D <0x0 0xfd5a8000 0x0 0x100>;
>> >>>> 		clocks =3D <&cru PCLK_VO1GRF>;
>> >>>> 	};
>> >

--=20
Diese Nachricht wurde von meinem Android-Ger=C3=A4t mit K-9 Mail gesendet=
=2E

