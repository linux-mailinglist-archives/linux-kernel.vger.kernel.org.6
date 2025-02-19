Return-Path: <linux-kernel+bounces-520683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF25A3AD3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01AA7A5C71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5634594A;
	Wed, 19 Feb 2025 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYMECnuh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7C2BAF4;
	Wed, 19 Feb 2025 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925738; cv=none; b=W/RZgcq+2vVU5oY3GP0S5wgjpQjbO10PYEez7LFmMDMJH388juB5tyuYRXG7uL55Cl7kxWXOaXqfxhGF2p50ZiS9pa0pznPV5Hr5bv2BdyAKFShg3imqQTKDwejds72uQP2bZa3kgQ3D8QjAwdOJ1+qk2uV0MF9N+sW2j2swpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925738; c=relaxed/simple;
	bh=khIFgwQ769ZHyT5CdIGu1HrTamF79U/Lvixfrt97yy4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=uLLMWCYjNkLIyJ4ty/+6rDstB+QFifnNxW5pyXbK8DFBzaPbp5aI3Ep6IHw4TJvLDZysgti4vPfj3mh8QhkdyKd9h2Y5p/ISJewpeWx6ZceF6sdXePcvLcFoK9gesuQ4wkRNN3ujASUYzLFd9eGn19LL9Rb3YsGYjbq49bwczwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYMECnuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E737C4CEEA;
	Wed, 19 Feb 2025 00:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739925737;
	bh=khIFgwQ769ZHyT5CdIGu1HrTamF79U/Lvixfrt97yy4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=tYMECnuhBbykHVm1RU15MSPfwodg3z1htxAN/KBLJjEfTm6ZjKKZzvM4LQNkkEvqR
	 ClaezR+1hPyqLCLF9vcsJwyS3LhntD+NWvyEi5YBIFSW0FufMXlY1v2Y3LqPPUDAVR
	 xk+l2T+xh4m0oCPjiQ6a6pP+ZQSZLa2lgZFSJkOQe1mAAOjV497vgDKm+pNJJooPld
	 hebKKloMzj0TIyTVuWJP9YJgRpgmVHlc7LehcPCefynw7SIqVXZockj4d/PfPp8T8+
	 mDTXJSCkCKGNNLetz1B3T4purqsau+/G7TLHts/6T/lZbHqDxHtSBH5R8JQkvnWwJT
	 sCoYAzENbIfkw==
Date: Tue, 18 Feb 2025 18:42:16 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Kevin Hilman <khilman@baylibre.com>, Takashi Iwai <tiwai@suse.com>, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 shuai.li@amlogic.com, Stephen Boyd <sboyd@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jaroslav Kysela <perex@perex.cz>, zhe.wang@amlogic.com, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 Michael Turquette <mturquette@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, jian.xu@amlogic.com, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
To: jiebing chen <jiebing.chen@amlogic.com>
In-Reply-To: <20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com>
References: <20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com>
Message-Id: <173992515659.2064996.1911122760174546370.robh@kernel.org>
Subject: Re: [PATCH v2 0/5] Add support for S4 audio


On Fri, 14 Feb 2025 10:13:39 +0800, jiebing chen wrote:
> Add s4 audio base driver.
> 
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ---
> Changes in v2:
> - remove tdm pad control and change tocodec base on g12a
> - change hifipll rate to support 24bit
> - add s4 audio clock
> - Link to v1: https://lore.kernel.org/r/20250113-audio_drvier-v1-0-8c14770f38a0@amlogic.com
> 
> ---
> jiebing chen (5):
>       dt-bindings: clock: axg-audio: Add mclk and sclk pad for s4
>       dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
>       ASoC: meson: s4:support the audio clk
>       ASoC: meson: s4:support audio tocodec
>       arm64: dts: amlogic: Add Amlogic S4 Audio
> 
>  .../bindings/clock/amlogic,axg-audio-clkc.yaml     |  18 +
>  .../bindings/sound/amlogic,g12a-toacodec.yaml      |   1 +
>  .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     | 219 +++++++++++
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 370 ++++++++++++++++++-
>  drivers/clk/meson/axg-audio.c                      | 410 ++++++++++++++++++++-
>  drivers/clk/meson/axg-audio.h                      |   4 +
>  include/dt-bindings/clock/axg-audio-clkc.h         |  11 +
>  sound/soc/meson/axg-card.c                         |   3 +-
>  sound/soc/meson/g12a-toacodec.c                    |  64 ++++
>  9 files changed, 1095 insertions(+), 5 deletions(-)
> ---
> base-commit: 6ecd20965bdc21b265a0671ccf36d9ad8043f5ab
> change-id: 20250110-audio_drvier-07a5381c494b
> 
> Best regards,
> --
> jiebing chen <jiebing.chen@amlogic.com>
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/amlogic/' for 20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com:

arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-0: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-0: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-0: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-0: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-1: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-1: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-1: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-1: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-2: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-2: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-2: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-2: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller@740: compatible: 'oneOf' conditional failed, one must be fixed:
	['amlogic,s4-toacodec'] is too short
	'amlogic,g12a-toacodec' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,g12a-toacodec.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: sound: 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#






