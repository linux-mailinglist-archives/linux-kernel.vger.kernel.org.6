Return-Path: <linux-kernel+bounces-348405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A8698E73C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91C91F25B81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053319F10C;
	Wed,  2 Oct 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NmiGzJVX"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46819EEBD;
	Wed,  2 Oct 2024 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912636; cv=none; b=MPilJOcZ9gK0RA8prrfpLlqOaA+SKDLK7jD0GcKFOD/VtBJ5EVNl215f264L5ceOBV2r8OiFrX/cx90phI6JjoA63+Orz/4L1xwA5kqFGWo70AkTClyeA4OE/XjjDoxHfzO2RQeaDBY7vnQ+0WdNX3tsWK/J0hIsfvvi0qaPInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912636; c=relaxed/simple;
	bh=FqrBFAUZGs/PjUJVRT5EvMyKflw87Pe39tyI4eH2Cwc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fjWOUZfescYOAgXbfg03Z96poWYgCpkQ/r7h1y82IZ6dq1aEN/F7WcgRxsaY9lNZuWyqoagtVHeBevKIvHkGdiqMgixpMhHJT5IVpzlI7wDk7YXtKOOWzs6IzOhxqHeVJ3dk3YXiqX7KDufXmzIe5ZhwHzCZSsiP9SFwQQXQR8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NmiGzJVX; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727912630;
	bh=rgD4cAwDrVI3FRgj3OYN0L9QDMGV/rqHFoOMCb4lQXE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NmiGzJVXBgg9Sx0mkNOPddinsBePu0VR96xpZtAy65tlNbLSbHIGTWFaoFAfCJcAN
	 Wq0FftekOs8B/FY/M6xaKCKjqhtChbuk1JHEzB+FAGY5Ru0Br+CK7xn4G995ziCvbJ
	 cTMv+vHY+EDHoWFcur2Ab2rU42pHEZP/dN7jhCHw7WedsYBPeaWouDFE/YX4Qd/QVH
	 YJSiCXy4HHwzGuMqij+XhtGU26/V2VfZ5kAqEAHUIkKYYKvTK8ICdiVt3nFc294q0D
	 TS7NCxWtOx4+6SfZSiCIga68+7pn6vqZ5ZM0jby6uLIl3bge3vjM2wqaFkvwGCdb/O
	 GGSrSorJsAaPA==
Received: from [192.168.68.112] (ppp118-210-88-173.adl-adc-lon-bras32.tpg.internode.on.net [118.210.88.173])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 686B165013;
	Thu,  3 Oct 2024 07:43:49 +0800 (AWST)
Message-ID: <be2630fe0abf590866c306880395659b33128111.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: linux-aspeed@lists.ozlabs.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Joel
 Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Oct 2024 09:13:48 +0930
In-Reply-To: <172790540060.1353939.8456815650107227718.robh@kernel.org>
References: <20241002084023.467383-1-naresh.solanki@9elements.com>
	 <172790540060.1353939.8456815650107227718.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Naresh,

On Wed, 2024-10-02 at 16:45 -0500, Rob Herring (Arm) wrote:
> On Wed, 02 Oct 2024 14:10:17 +0530, Naresh Solanki wrote:
> > Document the new compatibles used on IBM SBP1.
> >=20
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
>   pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ibm-sbp1.dtb'=
 for 20241002084023.467383-1-naresh.solanki@9elements.com:

A bunch of what follows are issues caused by the lack of dt-schema
bindings for the ASPEED SoC peripherals. You can ignore those errors
for now.

However, some of those below are specific to your devicetree. Can you
please address them?

>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: timer: 'clocks' does no=
t match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml=
#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /sdram@1e6e0000: failed=
 to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon=
']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: bus@1e600000: compatibl=
e: ['aspeed,ast2600-ahbc', 'syscon'] is too long
> 	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.y=
aml#

For instance, ignore the above for now.

> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mdio@1e650010: Unevalua=
ted properties are not allowed ('reset-assert-us', 'reset-deassert-us' were=
 unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/aspeed,ast2600-mdio.y=
aml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mdio@1e650018: Unevalua=
ted properties are not allowed ('reset-assert-us', 'reset-deassert-us' were=
 unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/aspeed,ast2600-mdio.y=
aml#

Check the bindings regarding these - it seems they should go in a phy
subnode of the MDIO controller.

> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: syscon@1e6e2000: 'smp-m=
emram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-=
f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^silicon-id@[0=
-9a-f]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.ya=
ml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/syscon@1e6e200=
0/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2=
600-smpmem']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/syscon@1e6e200=
0/interrupt-controller@560: failed to match any schema with compatible: ['a=
speed,ast2600-scu-ic0']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/syscon@1e6e200=
0/interrupt-controller@570: failed to match any schema with compatible: ['a=
speed,ast2600-scu-ic1']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/display@1e6e60=
00: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'sys=
con']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: adc@1e6e9000: 'interrup=
ts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-ad=
c.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: adc@1e6e9100: 'interrup=
ts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-ad=
c.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: crypto@1e6fa000: 'aspee=
d,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acr=
y.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/video@1e700000=
: failed to match any schema with compatible: ['aspeed,ast2600-video-engine=
']

Ignore the above for now.

> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: gpio@1e780000: 'gpio-re=
served-ranges' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.=
yaml#

I'm not sure why this one is flagged, though it is one you should
resolve. You might need some input from the devicetree maintainers.

> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/timer@1e782000=
: failed to match any schema with compatible: ['aspeed,ast2600-timer']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: lpc@1e789000: lpc-snoop=
@80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: lpc@1e789000: reg-io-wi=
dth: 4 is not of type 'object'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: kcs@24: 'clocks' does n=
ot match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: kcs@28: 'clocks' does n=
ot match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: kcs@2c: 'clocks' does n=
ot match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: kcs@114: 'clocks' does =
not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/lpc@1e789000/l=
hc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/lpc@1e789000/i=
bt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bm=
c']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: sdc@1e740000: sdhci@1e7=
40100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: sdc@1e740000: sdhci@1e7=
40200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/sdc@1e740000/s=
dhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600=
-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/sdc@1e740000/s=
dhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600=
-sdhci', 'sdhci']

Ignore the above for now.

> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ir38263-pvcore-nic2@40:=
 Unevaluated properties are not allowed ('regulators' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/regulator/infineon,ir3806=
0.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ir38263-pvcore-nic1@40:=
 Unevaluated properties are not allowed ('regulators' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/regulator/infineon,ir3806=
0.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ir38263-p3v3-nic@40: Un=
evaluated properties are not allowed ('regulators' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/regulator/infineon,ir3806=
0.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ir38263-p1v2-nic@40: Un=
evaluated properties are not allowed ('regulators' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/regulator/infineon,ir3806=
0.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ir38263-p1v8-nic@40: Un=
evaluated properties are not allowed ('regulators' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/regulator/infineon,ir3806=
0.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/bus@1e78a000/i=
2c@280/bmc-slave@10: failed to match any schema with compatible: ['ipmb-dev=
']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: r38263-p1v05-pch-aux@40=
: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts',=
 'regulators' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/regulator/infineon,ir3806=
0.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ir38060-p1v8-pch-aux@40=
: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts',=
 'regulators' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/regulator/infineon,ir3806=
0.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mux@77: interrupts: Fal=
se schema does not allow [[44, 4]]
> 	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu2@=
58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cp=
u2@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu1@=
58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cp=
u1@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu3@=
58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cp=
u3@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ir38263-p5v-aux@40: Une=
valuated properties are not allowed ('regulators' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/regulator/infineon,ir3806=
0.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ir38263-p3v3-aux@40: Un=
evaluated properties are not allowed ('regulators' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/regulator/infineon,ir3806=
0.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu0@=
58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cp=
u0@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#

These all look like they need to be addressed.

> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: fsi@1e79b000: compatibl=
e: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
> 	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-ma=
ster.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/fsi@1e79b000: =
failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', '=
fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: fsi@1e79b100: compatibl=
e: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
> 	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-ma=
ster.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/fsi@1e79b100: =
failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', '=
fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /ahb/apb/dma-controller=
@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udm=
a']
>=20

Ignore these for now.

Andrew

