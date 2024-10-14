Return-Path: <linux-kernel+bounces-364168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4646399CC28
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0816F284303
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8471AA7A6;
	Mon, 14 Oct 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbT5uamD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7141D555;
	Mon, 14 Oct 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914725; cv=none; b=D2H3v3NHua7sav85HUF5GEZimSPXXcfJsTwrZU6WdGkd6fXHP/77m4m5wgWGY9TjlueDxeqLBP4ux/zsKxqcwxYZ9oxBGkECYUrBRAAdbbcwtT+mGkqpVPRwMSVsXn0595D1I7SOzJwOgC1pbtazLtW/IZBqUOSLAUAki7px3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914725; c=relaxed/simple;
	bh=3P53f06q2jOIKqVMldN6nW1SJr0MQe8FU5Df9K3aLhI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=W1i5jMyAdUHhq/XiTa9RDZwRuugIb6ftz9qy/aU0vvgzkckAGehg7G22/pPh+F2Q7VWR/tm2/JwPeyoU1+aMtSlQBM1COTfx7VkCGEnH9nuWwPCukLaeoAfuBNbdHvK8JhcbEFf/HDvhIBbk8l8jL4jLYN+dCK9nl53MF0+RVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbT5uamD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5457AC4CEC3;
	Mon, 14 Oct 2024 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728914725;
	bh=3P53f06q2jOIKqVMldN6nW1SJr0MQe8FU5Df9K3aLhI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GbT5uamDSyndnevVXWG2KlC7P2IwS6nmuUbExiCLXrmmkFB48JHGoQa/v+7q7gnl8
	 j3WA5UKv8GePweo+QBJsLStOSP37Poy41vmA9FfiTDCVQluUxrBZZuYKiVsCsTjjdY
	 k/DZ85uDU+Dzk8l/0NOUHIcKYjoiZZchKJ8FcHg6zuMZkz6eYlsqr5FCt3FhC9vTiF
	 2CqnyhkIEVJejn6ToBMBVucVkiP7Q2ZyceAJml0Zq/vIyDKkn1xNghHvniGO0+Iexv
	 SaJNZEAivboiLNdGNo/s73HzAKYD3RGhbJWAnl2eE/29CEIuNem5kZ/7WMPFJhnZD8
	 bgzwykhU5s3/A==
Date: Mon, 14 Oct 2024 09:05:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Anand Gadiyar <gadiyar@ti.com>, Tero Kristo <kristo@kernel.org>
In-Reply-To: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
References: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
Message-Id: <172891443733.1126799.5690975556564135369.robh@kernel.org>
Subject: Re: [PATCH v3 0/6] firmware: ti_sci: Partial-IO support


On Sat, 12 Oct 2024 16:39:26 +0200, Markus Schneider-Pargmann wrote:
> Hi,
> 
> Series
> ------
> Partial-IO is a poweroff SoC state with a few pingroups active for
> wakeup. This state can be entered by sending a TI_SCI PREPARE_SLEEP
> message.
> 
> The message is sent on poweroff if one of the potential wakeup sources
> for this power state are wakeup enabled. The potential wakeup sources
> are determined by the power supply name of devices as there is one
> always-on power-line that powers all canuart devices that are powered
> through Partial-IO as well. The wakeup sources can be individually
> enabled/disabled by the user in the running system.
> 
> The series is based on v6.12-rc1.
> 
> Partial-IO
> ----------
> This series is part of a bigger topic to support Partial-IO on am62,
> am62a and am62p. Partial-IO is a poweroff state in which some pins are
> able to wakeup the SoC. In detail MCU m_can and two serial port pins can
> trigger the wakeup.
> A documentation can also be found in section 6.2.4 in the TRM:
>   https://www.ti.com/lit/pdf/spruiv7
> 
> This other series is relevant for the support of Partial-IO:
> 
>  - can: m_can: Add am62 wakeup support
>    https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com
>    https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-wakeup-source/v6.12?ref_type=heads
> 
> Testing
> -------
> A test branch is available here that includes all patches required to
> test Partial-IO:
> 
> https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62/v6.12?ref_type=heads
> 
> After enabling Wake-on-LAN the system can be powered off and will enter
> the Partial-IO state in which it can be woken up by activity on the
> specific pins:
>     ethtool -s can0 wol p
>     ethtool -s can1 wol p
>     poweroff
> 
> I tested these patches on am62-lp-sk.
> 
> Best,
> Markus
> 
> Previous versions:
>  v1: https://lore.kernel.org/lkml/20240523080225.1288617-1-msp@baylibre.com/
>  v2: https://lore.kernel.org/lkml/20240729080101.3859701-1-msp@baylibre.com/
> 
> Changes in v3:
>  - Remove other modes declared for PREPARE_SLEEP as they probably won't
>    ever be used in upstream.
>  - Replace the wait loop after sending PREPARE_SLEEP with msleep and do
>    an emergency_restart if it exits
>  - Remove uarts from DT wakeup sources
>  - Split no response handling in ti_sci_do_xfer() into a separate patch
>    and use goto instead of if ()
>  - Remove DT binding parital-io-wakeup-sources. Instead I am modeling
>    the devices that are in the relevant group that are powered during
>    Partial-IO with the power supplies that are externally provided to
>    the SoC. In this case they are provided through 'vddshv_canuart'. All
>    devices using this regulator can be considered a potential wakeup
>    source if they are wakeup capable and wakeup enabled.
>  - Added devicetree patches adding vcc_3v3_sys regulator and
>    vddshv_canuart for am62-lp-sk
>  - Add pinctrl entries for am62-lp-sk to add WKUP_EN for mcu_mcan0 and
>    mcu_mcan1
> 
> Changes in v2:
>  - Rebase to v6.11-rc1
>  - dt-binding:
>     - Update commit message
>     - Add more verbose description of the new binding for a better
>       explanation.
>  - ti_sci driver:
>     - Combine ti_sci_do_send() into ti_sci_do_xfer and only wait on a
>       response if a flag is set.
>     - On failure to enter Partial-IO, do emergency_restart()
>     - Add comments
>     - Fix small things
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> Markus Schneider-Pargmann (6):
>       firmware: ti_sci: Support transfers without response
>       firmware: ti_sci: Partial-IO support
>       arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
>       arm64: dts: ti: am62-lp-sk: Add vcc_3v3_sys regulator
>       arm64: dts: ti: am62-lp-sk: Add vddshv_canuart regulator
>       arm64: dts: ti: am62-lp-sk: Add wakeup mcu_mcan0/1 pinctrl
> 
>  arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts |  79 +++++++++++++++++-
>  arch/arm64/boot/dts/ti/k3-pinctrl.h      |   3 +
>  drivers/firmware/ti_sci.c                | 137 ++++++++++++++++++++++++++++++-
>  drivers/firmware/ti_sci.h                |   5 ++
>  4 files changed, 221 insertions(+), 3 deletions(-)
> ---
> base-commit: 03dc72319cee7d0dfefee9ae7041b67732f6b8cd
> change-id: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447
> prerequisite-change-id: 20241006-tisci-syssuspendresume-e6550720a50f:13
> prerequisite-patch-id: 945b15416a011cb40007c5d95561786c1776bb98
> prerequisite-patch-id: 69a741b9c81d7990937483fc481aafa70e67669d
> prerequisite-patch-id: 15e97947da8cb7055745151990c756d81fded804
> prerequisite-patch-id: a0efbf22e69d23dba8bb96db4032ca644935709b
> prerequisite-patch-id: 2999da190c1ba63aabecc55fae501d442e4e0d7b
> prerequisite-change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8:3
> prerequisite-patch-id: a7c60adc118d6b8bf783686a62d03c88b14b853c
> prerequisite-patch-id: 90f03012d910402b043334ad5a5a8580e33e3d97
> prerequisite-patch-id: 74aa28d4203323744419694568d2f5bbf471e233
> prerequisite-patch-id: 56fd0aae20e82eb2dfb48f1b7088d62311a11f05
> prerequisite-patch-id: f4febebdfba5f2fbfd1f276b8ee8b72be047dfc8
> prerequisite-patch-id: c7f9373ac4b8a623f9cb68788c7d0cb6567e3ed9
> prerequisite-patch-id: 33d27d8c3f8d1913ed1ec2abb9f64f4d7cd9f1fb
> prerequisite-patch-id: 38ba1a5ffe086d1bc186db125d8610b0cdb191f9
> prerequisite-patch-id: 46803aa31b9b00725e58fa27c883be94729941c2
> 
> Best regards,
> --
> Markus Schneider-Pargmann <msp@baylibre.com>
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


New warnings running 'make CHECK_DTBS=y ti/k3-am62-lp-sk.dtb' for 20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com:

arch/arm64/boot/dts/ti/k3-am62-lp-sk.dtb: pinctrl@4084000: 'mcu-mcan0-rx-pins-default', 'mcu-mcan0-rx-pins-wakeup', 'mcu-mcan0-tx-pins-default', 'mcu-mcan1-rx-pins-default', 'mcu-mcan1-rx-pins-wakeup', 'mcu-mcan1-tx-pins-default' do not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#






