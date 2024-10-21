Return-Path: <linux-kernel+bounces-374895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930EE9A71A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240912846A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F81F9401;
	Mon, 21 Oct 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2/4UGx1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38C71FAC46;
	Mon, 21 Oct 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533519; cv=none; b=X6lqqtNQZGN6tb9r/iPWd240+1vP8Ast0i9lNkHf8nOgWBQbajvgM1B0QGhnv6wrI/qvU6Qo62yrEAsyXz/rLjQQuYdAglvNfe+m0mnDVzB2nJu4XyQhPkZkbAF9VMnqHpzD8uM5udIIsYsTcHXz3M1LMoUOtwxkfaamGvJcZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533519; c=relaxed/simple;
	bh=yXoirqU/qZUsfcnoZa9R80ThNPyGcVM6120nlo3jvJk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=lWD9HQvPM6Qj0YQozuec3XAJjpC2wtFojXAjwIGloZxv1w2MDqNW0o4eVt6TCId2+jbnm5tTrqvbLjDZKnAAeXPkik9pdozW6PITf1KyMAy6wZHv4t/Pv2/W5F5EPItCG6lCFiH4ayY+bDrZKJf+GHgjnSTfXBFV/ncSZ3Fe4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2/4UGx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F572C4CEEA;
	Mon, 21 Oct 2024 17:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533518;
	bh=yXoirqU/qZUsfcnoZa9R80ThNPyGcVM6120nlo3jvJk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=N2/4UGx1YOJ1iJLOwE+VIV7wQTzYn/kAJsu3mRbcLPmrFqUkgHAw3gf1p0rlfAiry
	 6G/7UyCOfCk2jTG7fgKrGaZeLwHjRriz8XDwfIK+G63zLOU1WTHOHvYuD41dOu/ZWW
	 gG6zEjDzwZwTSQs+Y67GScJgAs0vxDHGxnExH4h40gVS3b3dKfNu094Ho/VNxc0rZL
	 4owDei9Lp48AB1rU+zo36UNyGUruZ2XgIhHhS91uRajdJi6yTmWF3oAs7/FKJhM4JR
	 WTOaNJbT9Y6am7DshOqL1vbELuB3sMNoh/mPcY4K+yLOOU3hMkgHBJ30VECsdXkfCb
	 Zj6jiVzU7IFog==
Date: Mon, 21 Oct 2024 12:58:37 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: OpenBMC Maillist <openbmc@lists.ozlabs.org>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Khanh Pham <khpham@amperecomputing.com>, 
 Quan Nguyen <quan@os.amperecomputing.com>, linux-kernel@vger.kernel.org, 
 Phong Vo <phong@os.amperecomputing.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org, 
 Open Source Submission <patches@amperecomputing.com>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Thang Nguyen <thang@os.amperecomputing.com>
In-Reply-To: <20241021083702.9734-1-chanh@os.amperecomputing.com>
References: <20241021083702.9734-1-chanh@os.amperecomputing.com>
Message-Id: <172953338016.748488.8980857453894882513.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Add device tree for Ampere's Mt. Jefferson BMC


On Mon, 21 Oct 2024 08:37:00 +0000, Chanh Nguyen wrote:
> The Mt. Jefferson BMC is an ASPEED AST2600-based BMC for the Mt. Jefferson
> hardware reference platform with AmpereOne(TM)M processor.
> 
> These patches add a device-tree and binding for the Ampere's Mt. Jefferson
> BMC board.
> 
> Changes in v2:
>  - Document Mt. Jefferson board compatible                      [Krzysztof]
>  - Remove the PSU node with pmbus compatible                       [Andrew]
>  - Remove clock-names property in mac3 node                        [Andrew]
> 
> Chanh Nguyen (2):
>   dt-bindings: arm: aspeed: add Mt. Jefferson board
>   ARM: dts: aspeed: Add device tree for Ampere's Mt. Jefferson BMC
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../aspeed/aspeed-bmc-ampere-mtjefferson.dts  | 622 ++++++++++++++++++
>  3 files changed, 624 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
> 
> --
> 2.43.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ampere-mtjefferson.dtb' for 20241021083702.9734-1-chanh@os.amperecomputing.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: bus@1e600000: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: syscon@1e6e2000: 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^silicon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb@1e6e0000/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb@1e6e0000/syscon@1e6e2000/interrupt-controller@560: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic0']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb@1e6e0000/syscon@1e6e2000/interrupt-controller@570: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic1']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb@1e6e0000/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: adc@1e6e9000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: adc@1e6e9100: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: crypto@1e6fa000: 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/video@1e700000: failed to match any schema with compatible: ['aspeed,ast2600-video-engine']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: sdc@1e740000: sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: sdc@1e740000: sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: gpio@1e780000: 'ocp-aux-pwren-hog' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb@1e780000/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: lpc@1e789000: lpc-snoop@80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: lpc@1e789000: reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: kcs@24: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: kcs@28: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: kcs@2c: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: kcs@114: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb@1e780000/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb@1e780000/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: fsi@1e79b000: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb@1e790000/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: fsi@1e79b100: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb@1e790000/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb@1e790000/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']






