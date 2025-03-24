Return-Path: <linux-kernel+bounces-573861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1BFA6DD47
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FCD188D94C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C016125;
	Mon, 24 Mar 2025 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8sKAZ2+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC125F999;
	Mon, 24 Mar 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827485; cv=none; b=Cw19fMKroZzK9tRYNgs6si2NtTsoUE03QuQMZS4EGdFG23tS+li8ra6Y+RzOLx3VQjvyB8xjidHax+kefmbAzD6qyNO6FVvYh2wXXxkiXwtNAcCPAag4d5gVG2WRflqjUnuipWjZLPoQLqzSgSJuEuFUFZWqdOE7naLqhGurzHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827485; c=relaxed/simple;
	bh=aFlNGtyRy9oVmVjrSqn43hcqtvgmECgCXHyXQI+/7CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n787KEPO/DBtKvMuI4zi4IrUscV7+0aiEXv1DJV6eLWfLJ8qgWtu0wcy1zXLSxQxOZZbeP7slr86yOjeZNPt6qbZ/XPfd3uXUd5chwWZfT8aOZP1G649VFbILplLoQPO4l3C6YfPT3a+8mOmeCtg0ICkc1Q2NXpFAi7A1Jxv+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8sKAZ2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B6FC4CEDD;
	Mon, 24 Mar 2025 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742827485;
	bh=aFlNGtyRy9oVmVjrSqn43hcqtvgmECgCXHyXQI+/7CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q8sKAZ2+lhd8maxG/iv8jyZ89kySEjKbcQAe99pgprGn+u9AfKdb7808l67lJeaGF
	 Gjjc18B1BmUBZTHiuk1t8mbG/La2dNDlIzNDsaaXCRUOYgZ/Kv5lpd2Z9ISGAq7pm1
	 eii8h3re+b8WUU/h0EVRY9Z7E+LhMANHqIEed6c68mAzKQawRweqa/o90LEEs1gMc4
	 uVafHwBKMoVbzhNRRAGQHyLaoacx+cRydC9JjSPffc/csDUSjd548JJaInj2YBmKs8
	 5xPRVxfL3EoAKNzeTFtRW4LltVmhp9kHiExZPz1zw//DzYWz3JZq3yKYDVzzCJMOYU
	 dUryZbbH63Dsg==
Date: Mon, 24 Mar 2025 09:44:43 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Thomas Fossati <thomas.fossati@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: NXP System Timer Module
Message-ID: <20250324144443.GA17721-robh@kernel.org>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324100008.346009-1-daniel.lezcano@linaro.org>

On Mon, Mar 24, 2025 at 11:00:05AM +0100, Daniel Lezcano wrote:
> Add the System Timer Module description found on the NXP s32 platform
> and the compatible for the s32g2 variant.
> 
> Cc: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Thomas Fossati <thomas.fossati@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../bindings/timer/nxp,stm-timer.yaml         | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nxp,stm-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/nxp,stm-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,stm-timer.yaml
> new file mode 100644
> index 000000000000..41093892c617
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/nxp,stm-timer.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/nxp,stm-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP System Timer Module (STM)
> +
> +maintainers:
> +  - Daniel Lezcano <daniel.lezcano@kernel.org>
> +
> +description: |

Don't need '|' and wrap at 80 char.

> +  The System Timer Module supports commonly required system and
> +  application software timing functions. STM includes a 32-bit
> +  count-up timer and four 32-bit compare channels with a separate
> +  interrupt source for each channel. The timer is driven by the STM
> +  module clock divided by an 8-bit prescale value.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nxp,s32g2-stm
> +      - items:
> +          - const: nxp,s32g2-stm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: System Timer Module clock

Just 'maxItems: 1'. The description is rather obvious.

> +
> +  clock-names:
> +    items:
> +      - const: stm

No need for *-names when there is only 1 entry.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    stm@4011c000 {

timer@...

> +        compatible = "nxp,s32g2-stm";
> +        reg = <0x4011c000 0x3000>;
> +        interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clks 0x3b>;
> +        clock-names = "stm";
> +    };
> -- 
> 2.43.0
> 

