Return-Path: <linux-kernel+bounces-533449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB1A45A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A02F17266D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13901238157;
	Wed, 26 Feb 2025 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="UxU4kX0W";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="qN+vMNFA"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257F1A5BBD;
	Wed, 26 Feb 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563315; cv=none; b=SLJFFNWUhzQAYQg296jcFDq1btMPrsah5JBD1vi2pO0DyDHaY3WPiG50VGzAcWWn7/ErLyYspeJz6gUKdnPDiIenfY5/M+AURDINImFNZ5U5p4oCzdjXl0oqb/pCINcFU5aab+AyM8m/wwyY1dzL2CxjGcuB1vjH9BXUbzB0pMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563315; c=relaxed/simple;
	bh=LkZyuKwaSW8zcDmPya1x245tMT6mymapIih8JYe3piE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxQsFeDjdCo/nRhP3lA+grXEK6suENE/teCu+H3Y4ytvxm6YW0yILy9elHOMGpCBQ2MGpzivGmIbiROWNNSr/KbmTCAFK42smzVQhkmwUPK0xwPVIO05DH/u+M5QlD6bRdKdtUh1lNM6yhrebR7+dHJsVmsAtwvp8+2EW0L1AyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=UxU4kX0W; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=qN+vMNFA; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1740562914; bh=LkZyuKwaSW8zcDmPya1x245tMT6mymapIih8JYe3piE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UxU4kX0WA0LEjSR/J2FuSEVinUUskselig4PGOcL/EPRm10/+o/zHB3c/ypjYOCPg
	 OfqPdGDxqED72PH2HXJlN6iXKUTqzYos+R8GcmlMpTd/wQcKQRUN2CmlQh1KDS6+16
	 vBGnnPfZaEjMaU5R7HqS6K5UAu5AD3TP3vHL5PfSJWb9fiZjmpb/dD7rCdPxLKaTi5
	 EAMYmIDQKXV1t/TZSnY8gTAoz8bDMdW/Q8HmhZJRL6AgCPfqIBh6TxKvZpWjpag9cB
	 QA8EtIMlT08DVOx58oAEO+8O6cH1Ed5kLb1GPit7PdiSVAmVMk1lCkUSNC/BE5oyWf
	 LZUajO5NlzE6Q==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id ED6793A51E8;
	Wed, 26 Feb 2025 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1740562913; bh=LkZyuKwaSW8zcDmPya1x245tMT6mymapIih8JYe3piE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qN+vMNFAtx/Iu0ktqgWpo7xMexJ2nKXDfu4hScTkH6zyw8Mg+Sbnzp2d+rff1UUs5
	 J17m8Znqc2We6B/6D69yNmzdz5Baa4LBgozcyQTA0yzpcjJ+3oeKcy+cjI7/RFGgwF
	 tC78FG/Q+SDUaeUL7wE1OdWV/rfNu+7wQrVzkAbezcYGTHF5r5TGEWNX4H/IZbBFre
	 fcowh0akKI4Jq+edFpVuBOhHMXu49pWbDIbjtz0UKt3vHtI/E9WAlRl2fwaqE2qL3g
	 JJgd7+E3L27DGDIcgN/vBKCCY5ThP9b4xgPusVechuviwyL+LMtWVYgRBzgH4Gxin/
	 VAEhGCg48tTEw==
Message-ID: <29ce9b9b-3993-4b88-a201-5d67050d53ae@mleia.com>
Date: Wed, 26 Feb 2025 11:41:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert
 nxp,lpc3220-mic.txt to yaml format
Content-Language: ru-RU
To: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>,
 tglx@linutronix.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250226010956.50566-1-leo.fthirata@gmail.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20250226010956.50566-1-leo.fthirata@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250226_094153_988776_2EF0AB3B 
X-CRM114-Status: GOOD (  15.13  )

Hello Leonardo,

thank you so much for working on this.

On 2/26/25 03:09, Leonardo Felipe Takao Hirata wrote:
> Convert NXP LPC3220-MIC to DT schema.
> 
> Signed-off-by: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
> ---
> Changes in v2:
>   - Fix SoB
>   - Remove reg description
>   - List #interrupt-cell items
>   - Add interrupt restriction per variant
>   - Remove extra examples
> ---
>   .../interrupt-controller/nxp,lpc3220-mic.txt  | 58 --------------
>   .../interrupt-controller/nxp,lpc3220-mic.yaml | 80 +++++++++++++++++++
>   2 files changed, 80 insertions(+), 58 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
> 

<snip>

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
> new file mode 100644
> index 000000000000..489bd329bc4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/nxp,lpc3220-mic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
> +
> +maintainers:
> +  - Vladimir Zapolskiy <vz@mleia.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,lpc3220-mic
> +      - nxp,lpc3220-sic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupts:
> +    items:
> +      - description:
> +          IRQ number.

For sake of better understanding SIC1 and SIC2 interrupt controllers
are chained to MIC, that's why there is 'interrupts' property present,
and here 0/1 interrupt values are for regular IRQ, 30/31 are for fast IRQ.

Also please add here

   minItems: 2
   maxItems: 2

I believe that the 'interrupts' property can be just left without any
given description, or just give a simple description like

   IRQ and FIQ outputs of sub interrupt controllers to the main interrupt controller

> +      - description: |
> +          IRQ type. Can be one of:
> +
> +              IRQ_TYPE_EDGE_RISING = Low-to-high edge triggered,
> +              IRQ_TYPE_EDGE_FALLING = High-to-low edge triggered,
> +              IRQ_TYPE_LEVEL_HIGH = Active high level-sensitive,
> +              IRQ_TYPE_LEVEL_LOW = Active low level-sensitive.
> +
> +          Reset value is IRQ_TYPE_LEVEL_LOW.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,lpc3220-sic
> +    then:
> +      required:
> +        - interrupts
> +    else:
> +      properties:
> +        interrupts: false

Please check if this 'else' condition can be removed.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mic: interrupt-controller@40008000 {
> +      compatible = "nxp,lpc3220-mic";
> +      reg = <0x40008000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +    };
> +
> +    sic1: interrupt-controller@4000c000 {
> +      compatible = "nxp,lpc3220-sic";
> +      reg = <0x4000c000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      interrupt-parent = <&mic>;
> +      interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
> +                  <30 IRQ_TYPE_LEVEL_LOW>;
> +    };

--
Best wishes,
Vladimir

