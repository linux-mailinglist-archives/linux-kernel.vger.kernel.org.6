Return-Path: <linux-kernel+bounces-569267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80163A6A0C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60447ADAF7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C667D206F2E;
	Thu, 20 Mar 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snS1grv8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50E1FC7D9;
	Thu, 20 Mar 2025 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456980; cv=none; b=hGjdglMYm3p682guMsSx0JMw5bIBkhRcw0guxy6PHNV0QVmOMdpiZtRwvC6oUjaW6UsqIJc3iL28djYTkB9wj8XO1WXat2psbdL3hqAkrUeYtmwWc6VMot2WsX+zZE5p9hqTAEJftQfjHyZNuVTb59XqmsncIwjEMsklSOcZFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456980; c=relaxed/simple;
	bh=CuA49i30/31eyy2ImyzsQrPw/ocmxxknakwwfXAeSt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5VOSwkMURzmpTo2ZNOmoafkgaAVmcOA6kVci7Czv9TlZWgzdgA7UOW7TXBFMOPDothiZDd63CT6hSjkw6FAN54+T9MWDfSbHhort8l8C+0alUAlCkcH92HXdbzM9HG/wkb1TAB1PTHYyQciW0itwtot3rRhfHkAnElLE5SRFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snS1grv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A72C4CEDD;
	Thu, 20 Mar 2025 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742456979;
	bh=CuA49i30/31eyy2ImyzsQrPw/ocmxxknakwwfXAeSt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snS1grv8KtR8otHUudpGt37sgc1u2VrceAhX+ZFxSovi1HqKAm1OE7NRuF2nPjR4L
	 auW1qKfYw3vIvn5+AcBSMWOJv6O7Z896sGVvssMBsUk0mx2XkbvxAVHjkNYiiRmVuj
	 9UduaACNpOb9Og9PLSRuGxK/sspaJHfS0DJV2+sJDUpovUaheyJ7gVxzVkotQ5WP2R
	 /gh+fRBeiEBBjN0cllZ5JM7F2hUEIG5KgYGoe/HOwQscrVbB8DTRbMoi+4kwcrkcvs
	 KhKgIUNJRgad22N/A21ryTSgOUNrEx1Lnzojut2FRu+jG3mbSYKKs4++tq6I7LjVZs
	 CLOeHT0LZmC4A==
Date: Thu, 20 Mar 2025 08:49:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "hailong.fan" <hailong.fan@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, Jjian.Zhou@mediatek.com, Xiangzhi.Tang@mediatek.com
Subject: Re: [PATCH 2/2] dt-bindings: dsp: mediatek: add mt8196 dsp document
Message-ID: <20250320-divergent-soft-bird-bcd938@krzk-bin>
References: <20250320031753.13669-1-hailong.fan@mediatek.com>
 <20250320031753.13669-3-hailong.fan@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320031753.13669-3-hailong.fan@mediatek.com>

On Thu, Mar 20, 2025 at 11:17:25AM +0800, hailong.fan wrote:
> This patch adds mt8196 dsp document. The dsp is used for Sound Open
> Firmware driver node. It includes registers,  clocks, memory regions,
> and mailbox for dsp.
> 
> Signed-off-by: hailong.fan <hailong.fan@mediatek.com>

Don't use login as full name, but proper Latin-alphabet transcription or
original name in UTF.

This cannot be tested due to dependency, so limited review.

> ---
>  .../bindings/dsp/mediatek,mt8196-dsp.yaml     | 96 +++++++++++++++++++

Don't grow dsp directory. Either this is remoteproc or some sound
component, so place it accordingly.

>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
> new file mode 100644
> index 000000000000..62bcd97bd0f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dsp/mediatek,mt8196-dsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek mt8196 DSP core
> +
> +maintainers:
> +  - Hailong Fan <hailong.fan@mediatek.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Some boards from mt8196 contain a DSP core used for

Boards or MT8196? If boards, how is this related to SoC in the first
place? Thus wrong compatible.

> +  advanced pre- and post- audio processing.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8196-dsp

If this is part of the SoC, then wrong description.

> +
> +  reg:
> +    items:
> +      - description: Address and size of the DSP Cfg registers

s/Address and size of the//

Write concise and accurate description. This cannot be anything else, so
no need to state obvious.

> +      - description: Address and size of the DSP SRAM
> +      - description: Address and size of the DSP secure registers
> +      - description: Address and size of the DSP bus registers
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: sram
> +      - const: sec
> +      - const: bus
> +
> +  clocks:
> +    items:
> +      - description: mux for dsp clock
> +      - description: 26M clock
> +      - description: ADSP PLL clock
> +
> +  clock-names:
> +    items:
> +      - const: adsp_sel
> +      - const: clk26m
> +      - const: adsppll
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mboxes:
> +    items:
> +      - description: mailbox for receiving audio DSP requests.
> +      - description: mailbox for transmitting requests to audio DSP.
> +
> +  mbox-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  memory-region:
> +    items:
> +      - description: dma buffer between host and DSP.
> +      - description: DSP system memory.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - mbox-names
> +  - mboxes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8196-clk.h>
> +    #include <dt-bindings/power/mt8196-power.h>
> +    adsp: adsp@1a000000 {

Drop unused label

> +        compatible = "mediatek,mt8196-dsp";
> +        reg = <0x1a000000 0x5000>,
> +              <0x1a210000 0x80000>,
> +              <0x1a345000 0x300>,
> +              <0x1a00f000 0x1000>;
> +        reg-names = "cfg", "sram", "sec", "bus";
> +        power-domains = <&scpsys MT8196_POWER_DOMAIN_ADSP_TOP_DORMANT>;
> +        clocks = <&cksys_clk CLK_CK_ADSP_SEL>,
> +                 <&cksys_clk CLK_CK_TCK_26M_MX9>,
> +                 <&cksys_clk CLK_CK_ADSPPLL>;
> +        clock-names = "adsp_sel",
> +                      "clk26m",
> +                      "adsppll";
> +        mbox-names = "rx", "tx";
> +        mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;

Reverse order of mboxes and mbox-names properties. xxx-names follows the
xxx.

Best regards,
Krzysztof


