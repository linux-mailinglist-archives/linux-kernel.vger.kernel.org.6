Return-Path: <linux-kernel+bounces-186300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE88CC262
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A543D282066
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADC01411F3;
	Wed, 22 May 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBGFgFqG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2817FE;
	Wed, 22 May 2024 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385597; cv=none; b=f6xqtKZaYUwRXGYqDIT0TRDvImPfXNeJN9CmFh+p1NZQ6+nBKbvBSSWNXVRxrdPiU7QN2XqGPsybb0QShzxoV9VamkmCrm98INcIBbZL9H+taxVhAOHjTnxUOsj+CjXOAaN1BmUCGTTgXYJnbZasR3dsalRoAwJpEUoaisBHKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385597; c=relaxed/simple;
	bh=iv23FVjeQKm1NNTk/dWFfJ2tDnqx1XnfEogDHQlZoj8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=PLjov1R2s45Z+p0LFmwVSMFX7dWXyw5Dgit36vJmi/VHtKeZLoRe+h2tMWota6q2B2ygf5yik4kRFRZs1ZxgqJ7sQ8sw57iNpJO79I0wZZ1k0+kyCjayT9zpCUKcQ1Q7lbiBjgSpPPjqPBAqg8OjlmH/yOOjzS7PUziIkuwGbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBGFgFqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696FDC2BBFC;
	Wed, 22 May 2024 13:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716385597;
	bh=iv23FVjeQKm1NNTk/dWFfJ2tDnqx1XnfEogDHQlZoj8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iBGFgFqGj8zFV3wbU1qQCwnEIYFOprpN0cFQVbDZO1y3YoKyrYFKqtihDTmR170Tq
	 y026iootcvRWZK/HCL8G7UTqTtN1RH6rSRPE7FTrvgMXpY7jGvEB69qy9k/8PDR/Yc
	 g2S96td4p0cL1pJ9oXHQ4QuJiMBiH+2hNUIytalF3b1I658zA9uGe499XqcHsnb9xZ
	 lO9w3IjK4N0ba3b+nSbXgiWze9X+i4TkBaAddwa7V0EPPlEJMfgX7GsRuLvCKTBOkR
	 lIRQMNb6uwo4hrU9XIBHT4ZmqLUiv0D/hOqnOnNWRqNTMxHsBKOKnecO1UaPjPu4BR
	 E0TVKRUPlwYAg==
Date: Wed, 22 May 2024 08:46:36 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Lucas Tanure <tanure@linux.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-amlogic@lists.infradead.org
In-Reply-To: <20240521222155.28094-1-jan.dakinevich@salutedevices.com>
References: <20240521222155.28094-1-jan.dakinevich@salutedevices.com>
Message-Id: <171638551693.3169786.7201121718393921307.robh@kernel.org>
Subject: Re: [PATCH 0/3] Introduce initial support of Amlogic AC200 board


On Wed, 22 May 2024 01:21:52 +0300, Jan Dakinevich wrote:
>  - Make some cosmetics in existing device tree files;
> 
>  - Add the board.
> 
> Jan Dakinevich (3):
>   arch/arm64: dts: ac2xx: make common the sound card
>   dt-bindings: arm: amlogic: document AC200 support
>   arch/arm64: dts: ac200: introduce initial support of the board
> 
>  .../devicetree/bindings/arm/amlogic.yaml      |  1 +
>  .../dts/amlogic/meson-sm1-a95xf3-air-gbit.dts | 87 -------------------
>  .../boot/dts/amlogic/meson-sm1-a95xf3-air.dts | 87 -------------------
>  .../boot/dts/amlogic/meson-sm1-ac200.dts      | 22 +++++
>  .../boot/dts/amlogic/meson-sm1-ac2xx.dtsi     | 87 +++++++++++++++++++
>  .../boot/dts/amlogic/meson-sm1-h96-max.dts    | 87 -------------------
>  .../dts/amlogic/meson-sm1-x96-air-gbit.dts    | 87 -------------------
>  .../boot/dts/amlogic/meson-sm1-x96-air.dts    | 87 -------------------
>  8 files changed, 110 insertions(+), 435 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dts
> 
> --
> 2.34.1
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


New warnings running 'make CHECK_DTBS=y amlogic/meson-sm1-a95xf3-air-gbit.dtb amlogic/meson-sm1-a95xf3-air.dtb amlogic/meson-sm1-ac200.dtb amlogic/meson-sm1-h96-max.dtb amlogic/meson-sm1-x96-air-gbit.dtb amlogic/meson-sm1-x96-air.dtb' for 20240521222155.28094-1-jan.dakinevich@salutedevices.com:

arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dtb: audio-controller@380: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: /soc/bus@ff600000/bus@60000/clock-controller@0: failed to match any schema with compatible: ['amlogic,sm1-audio-clkc']
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@300: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@340: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@380: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@3c0: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: /soc/bus@ff600000/bus@60000/audio-controller@744: failed to match any schema with compatible: ['amlogic,sm1-tohdmitx', 'amlogic,g12a-tohdmitx']
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: /soc/bus@ff600000/bus@60000/audio-controller@744: failed to match any schema with compatible: ['amlogic,sm1-tohdmitx', 'amlogic,g12a-tohdmitx']
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-0: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-0: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-0: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-2: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-2: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-2: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: sound: 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#






