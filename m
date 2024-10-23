Return-Path: <linux-kernel+bounces-379007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AB29AD890
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B20AB21A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B7F200106;
	Wed, 23 Oct 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RF0A4JEh"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0C1FF021
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729726901; cv=none; b=ULJqp5xFCda06u45DQiSwoWeji2eBbNzbrj0QXD7UEJIvpYEI/DoUCOUxBsTmHl/zqAbRJljciJk6OW/MxfA7f90jRJhBDNj+OBpc1u/Fe7Lo81AM/vYfIj5X00PMz5fQOTvLCI08z15Yem8JnSp1dVfmPVwa/iymqs9JhzIIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729726901; c=relaxed/simple;
	bh=OHH+9AiQirB+dOyiwIMPVlTShOnN7SWnulXQ+fk22iw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snLI3AEqMBop8Xu+kG48jIVHfxFwru1izbfiyX4JSnSAPED4VdRFM8FN3gEVKycAshleuRRETExS+PjmCyJiw+dI40E+n3LZiJrPmOPExI4diE5B5YPkUE7hfDHg1UzsAMCloxUhs3a5TPVQDpqdagwNzXtmAnN8ZxU2VVWtq5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RF0A4JEh; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9A2F53F295
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729726890;
	bh=3PGQu02YnHPlZo11QYKayLhqc6TqDv+KCeQ0Xgfz3C4=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RF0A4JEhv4fQi8Q/4ca7vHqBrqF1I01GzTTSSRD9kseDfap9qNtRdBIWobry9259j
	 AeViUjXLJbPuR22jwguGXjOO/IrQzLXaJer7WrZGGtM8/wXVoPeGkscR1t/Czmdc02
	 QMkUbYqjrU9E5z0G7P+sr0YVlmREoYG7t5JI5Q1XZGqHvB13ARpaGASIX08rcXnHzR
	 wsJrQFjUz4pOG4Tay6OrtFB3G1ahEOJOQnDDunQmN9Ljavc2wes+PAOedsIXYNkatB
	 s7syojT0Wd14M+CQ3+Cfp8CAfpRjUM7jzuYix+ZIYE7DJkdxez+9FdiMNNgtrK4N7K
	 GaIETST73euGA==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5eb7ed1d6deso195049eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729726889; x=1730331689;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PGQu02YnHPlZo11QYKayLhqc6TqDv+KCeQ0Xgfz3C4=;
        b=RAFXWYvPkGeRXPK6NUyK4cSqN+LwIVfScymL0vosnK2SDYZ8GzOlJJyvkjww05QWkp
         1nbrNmdeBhCw/dCN7RN88Tl9tZvLGgVYd+1QUdjqd2NRTjxg3lhIgsTomjhUpMHDYyAc
         hNp1OmM2PuV7QTzKtO1p61dUNTOk5pVy/ZhCgpZ19xSmBPVJUybILmLREEy3+NhfKgoP
         Rk7QJ4VbkQB1QVBWET1H/DsCdz2/PzvCYelI3OKJ0X8r3KfSE0YRghcaY84QSNjr1udl
         oAtM+FsqmJJ6SOMHX+N1tmyMXJdIngsxmI/JPcwfhbNROfCPaCRMWXuE4VNWzUE26w6r
         TEVw==
X-Forwarded-Encrypted: i=1; AJvYcCX7N1xEspA2DlQ1euXf3/O6OZu7zzWg2BeSowjOcfYdpW/WGgr/ZGNchIBXIYNhO3U23DuUY6TEtLIucjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC1iP78Esm3IDLteZymZQgbY3oaJgd2Kt9mZyJoUnan2n22ezw
	7IEgAF6OiP+ZgVd0RX7ZPQre1tG6uPFFJmI7sbKjr2sNAcrYTnlT7D+Ko18GZbmWJKAJ6mWDmps
	ZMeg7CPL/VrTaoOz4hjINOK0zqR4LjDJuc+fY107hFqzRx5LI7KsT8NUR0fkSS5L25wEG+V2y6d
	WVz6pwXqKLRT0XQY89M++mBZkHNCh6Wvmdm0GriE/f+EdXrqY/9IVii6YPs4lbnQU8MA==
X-Received: by 2002:a05:6870:a2d4:b0:288:50aa:7714 with SMTP id 586e51a60fabf-28ccb83f8b8mr4707234fac.24.1729726889078;
        Wed, 23 Oct 2024 16:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmoFBHnCYHUIGE5FQoeW7XP6jvjOogMHggvGexa+v1/qSORAbovEejIXVxUVEWGhexV1ySLJ9KlbQa+3yyW4Y=
X-Received: by 2002:a05:6870:a2d4:b0:288:50aa:7714 with SMTP id
 586e51a60fabf-28ccb83f8b8mr4707213fac.24.1729726888692; Wed, 23 Oct 2024
 16:41:28 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Oct 2024 19:41:28 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241021103617.653386-3-inochiama@gmail.com>
References: <20241021103617.653386-1-inochiama@gmail.com> <20241021103617.653386-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 23 Oct 2024 19:41:28 -0400
Message-ID: <CAJM55Z8SnjQFui0J2hOD34HmBsGqZfxn8e_KAWhXxiqswqv6Ww@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: net: Add support for Sophgo SG2044 dwmac
To: Inochi Amaoto <inochiama@gmail.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Inochi Amaoto wrote:
> The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> with some extra clock.
>
> Add necessary compatible string for this device.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 145 ++++++++++++++++++
>  2 files changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 3c4007cb65f8..69f6bb36970b 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -99,6 +99,7 @@ properties:
>          - snps,dwmac-5.30a
>          - snps,dwxgmac
>          - snps,dwxgmac-2.10
> +        - sophgo,sg2044-dwmac
>          - starfive,jh7100-dwmac
>          - starfive,jh7110-dwmac
>
> diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> new file mode 100644
> index 000000000000..93c41550b0b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 DWMAC glue layer

I think you forgot to change this when you copied the binding.

/Emil

> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - sophgo,sg2044-dwmac
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sophgo,sg2044-dwmac
> +      - const: snps,dwmac-5.30a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: GMAC main clock
> +      - description: PTP clock
> +      - description: TX clock
> +
> +  clock-names:
> +    items:
> +      - const: stmmaceth
> +      - const: ptp_ref
> +      - const: tx
> +
> +  sophgo,syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to syscon that configures phy
> +          - description: offset of phy mode register
> +          - description: length of the phy mode register
> +    description:
> +      A phandle to syscon with two arguments that configure phy mode.
> +      The argument one is the offset of phy mode register, the
> +      argument two is the length of phy mode register.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - resets
> +  - reset-names
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sophgo,sg2044-dwmac
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          maxItems: 1
> +
> +        interrupt-names:
> +          minItems: 1
> +          maxItems: 1
> +
> +        resets:
> +          maxItems: 1
> +
> +        reset-names:
> +          const: stmmaceth
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    ethernet@30006000 {
> +      compatible = "sophgo,sg2044-dwmac", "snps,dwmac-5.30a";
> +      reg = <0x30006000 0x4000>;
> +      clocks = <&clk 151>, <&clk 152>, <&clk 154>;
> +      clock-names = "stmmaceth", "ptp_ref", "tx";
> +      interrupt-parent = <&intc>;
> +      interrupts = <296 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "macirq";
> +      resets = <&rst 30>;
> +      reset-names = "stmmaceth";
> +      snps,multicast-filter-bins = <0>;
> +      snps,perfect-filter-entries = <1>;
> +      snps,aal;
> +      snps,tso;
> +      snps,txpbl = <32>;
> +      snps,rxpbl = <32>;
> +      snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> +      snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> +      snps,axi-config = <&gmac0_stmmac_axi_setup>;
> +      status = "disabled";
> +
> +      gmac0_mtl_rx_setup: rx-queues-config {
> +        snps,rx-queues-to-use = <8>;
> +        snps,rx-sched-wsp;
> +        queue0 {};
> +        queue1 {};
> +        queue2 {};
> +        queue3 {};
> +        queue4 {};
> +        queue5 {};
> +        queue6 {};
> +        queue7 {};
> +      };
> +
> +      gmac0_mtl_tx_setup: tx-queues-config {
> +        snps,tx-queues-to-use = <8>;
> +        queue0 {};
> +        queue1 {};
> +        queue2 {};
> +        queue3 {};
> +        queue4 {};
> +        queue5 {};
> +        queue6 {};
> +        queue7 {};
> +      };
> +
> +      gmac0_stmmac_axi_setup: stmmac-axi-config {
> +        snps,blen = <16 8 4 0 0 0 0>;
> +        snps,wr_osr_lmt = <1>;
> +        snps,rd_osr_lmt = <2>;
> +      };
> +    };
> --
> 2.47.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

