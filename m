Return-Path: <linux-kernel+bounces-228642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2485B91640C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450DE1C225EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019614A09C;
	Tue, 25 Jun 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="gY2jBB6u"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D624B34;
	Tue, 25 Jun 2024 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309196; cv=none; b=Jlyniyb47+dgeWyPgxm0igz4Oi0SHZ6qVXPjklsV4Pf8FvkfgaKOHbDFOB0640VhJdGgTPB5S4nTRRyMKnCageDFxfsUcog/GiVccijA+Wfu21IOFAPPlaKXI0hH8DRyU7lDiODa6W6xQsxiI1VTlXCYRAsYnGSt7lSPdHT2Nyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309196; c=relaxed/simple;
	bh=laocTupcpwpo03bPQmm5WTanJuRMlrVao+VZtjAK0uw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP9MAu7O/a5IN7KU7sdSBDRIT/rmW1SOSN/0h9oARXj1Cqba2Ge3WlbMG5+7otEyi4ZCQfPyATXcc8GrpokxYbErCrBnhZftqErOD2zeCUCN3ZLyhIK/o3dBlMghvquCCJYPKMm7a2XhgJ4UJfANZIRU40GswC2a+M7MhuiTxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=gY2jBB6u; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BC992120009;
	Tue, 25 Jun 2024 12:53:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BC992120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1719309181;
	bh=+CIW1+X2Rn5dOGkYI0XQ6szG1FfJLJX2NsCdYcopmHk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=gY2jBB6ualz/ekdcu8Cpnw79rvv0Lq5W7E8NcqIYqMTektp0mqbbRCtYo2Ijgg/yu
	 LcdOKN6lWfk/xdYNjaY+n48ayJYLp+eqQK0i27W6OqW0VH/YcGOmhQb5wjpIS3FtfN
	 rTs80AwqAf5kcpHndpcYaoWxKpzS0pETYLDeztvu8x469DvQe9TQ+MK9gUjn+d3p0g
	 Pw/Nx/28QwyyHfQIp8RlX21WEa6iT02pbaGLnxMV7N47x9RXEGuRNJoYiPwqNH00Vn
	 S/ORWVx7X0aE6Nv+rZJetddmtYhq1elVviMfDscndq7lm+f6nWrgqcy7AbfEf9OhnT
	 L3vcqtRnY/ISA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 25 Jun 2024 12:53:01 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 25 Jun
 2024 12:53:00 +0300
Date: Tue, 25 Jun 2024 12:53:00 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: amlogic: ad402: fix thermal zone node name
Message-ID: <20240625095210.mnwer2d3bc5wkits@CAB-WSD-L081021>
References: <20240624-topic-amlogic-upstream-bindings-fixes-dts-round-2-v1-1-0a21f456eb8d@linaro.org>
 <1ad3429c-0bad-4662-bc9d-b912f88e7b3a@kernel.org>
 <4c4c7840-917e-4d00-b8a4-b97a01ca2e6a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4c4c7840-917e-4d00-b8a4-b97a01ca2e6a@linaro.org>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186120 [Jun 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;devicetree.org:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/25 02:33:00
X-KSMG-LinksScanning: Clean, bases: 2024/06/25 02:33:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/25 01:39:00 #25693004
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Neil and Krzysztof,

Before posting any commit I've running dt_binding_check and dtbs_check.
Which target should highlight the errors like mentioned in this fix?
Please advise what I'm doing wrong.

My commands:

$ /usr/bin/make ARCH=arm64 INSTALL_MOD_PATH=$ROOT/out/$TARGET/target CROSS_COMPILE="$ROOT/out/$TARGET/host/bin/aarch64-buildroot-linux-gnu-" DEPMOD=$ROOT/out/$TARGET/host/sbin/depmod INSTALL_MOD_STRIP=1 -C $ROOT/out/$TARGET/build/linux-custom dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/example_device.yaml
$ /usr/bin/make ARCH=arm64 INSTALL_MOD_PATH=$ROOT/out/$TARGET/target CROSS_COMPILE="$ROOT/out/$TARGET/host/bin/aarch64-buildroot-linux-gnu-" DEPMOD=$ROOT/out/$TARGET/host/sbin/depmod INSTALL_MOD_STRIP=1 -C $ROOT/out/$TARGET/build/linux-custom dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/example_device.yaml

On Mon, Jun 24, 2024 at 11:45:51AM +0200, Neil Armstrong wrote:
> On 24/06/2024 11:28, Krzysztof Kozlowski wrote:
> > On 24/06/2024 10:59, Neil Armstrong wrote:
> > > Fixes the following:
> > > thermal-zones: 'soc_thermal' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
> > >          from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> > > 
> > > Fixes: 593ab951232b ("arm64: dts: amlogic: ad402: setup thermal-zones")
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
> > > index 6883471a93b4..0d92f5253b64 100644
> > > --- a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
> > > +++ b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
> > > @@ -86,7 +86,7 @@ vddio_1v8: regulator-vddio-1v8 {
> > >   	};
> > >   	thermal-zones {
> > > -		soc_thermal: soc_thermal {
> > > +		soc_thermal: soc-thermal {
> > 
> > I was fixing all underscores... but then mentioned above commit
> > re-introduced them.
> 
> Sorry about that, I'm removing all dtbs check errors, so I'll be able to spot
> this before merging anything now !
> 
> > 
> > Some fixes need to be done more than once to stick. :)
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> >
> > Best regards,
> > Krzysztof
> > 
> 
> Thanks,
> Neil

-- 
Thank you,
Dmitry

