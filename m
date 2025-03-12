Return-Path: <linux-kernel+bounces-557666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4FA5DC27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D793218947EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD74B23F39D;
	Wed, 12 Mar 2025 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQHqGr28"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5214F117;
	Wed, 12 Mar 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780998; cv=none; b=QvGoWnum2NmYvoFLf+gWai9y44HMc9BjlDEv9hIRLqpSebbi6CsJbMMfPRmI127lFuQObhRrD6tK64JBiyBXwc8hGO/q8uARxmkWigi3GuJbgxoa0A+sL297vTBuSTyJx/oc21ktG+ZUnpymmj94M/XhCLimfSPA2DRIJgKUvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780998; c=relaxed/simple;
	bh=7fyVSWAB8Ertria+vE/ZF+M57y8nsHzIxjq/lWexlzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gybDL/0T9bpOLbxYTybFZm1iOOS2mAq+fXkKb9uigBSlR5U5iTXBOb9LPhtvR/Tl7vrto/oh3lhH9ueA2H3TFDfPHvkT+xkkcWL9K5XDC4Dd3jYv+azUE+XcBtkkC0Y1q1Hnk9UexROQ+13luzUr9VPd7gVk16LFplXL6SSsAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQHqGr28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C3EC4CEE3;
	Wed, 12 Mar 2025 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741780997;
	bh=7fyVSWAB8Ertria+vE/ZF+M57y8nsHzIxjq/lWexlzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQHqGr280PrWdMuhLX6TgwQYWT1XEsPRZi/aGuLUufvkxrLutUR/PenBmMclmv9yd
	 gPpbnjLWMBbRGBjASWhRVGQH7F6eUfw/sa8snCkEkLrCuHiuBS+ET6LBnpoK60rh2q
	 q6rRvPH6m3lucVqdN8YvzSXgUhDFQG2Ut3Uxhl7GaLIoxBNyQo75Y/0dJXHoNxkKGO
	 opGU+MVwm4b4QBfD0cYC8gsmJe/czNM1q31T7je8i9qqNpoWcMrhU2qFk78vXcD/XE
	 +N2060+q9Jyqj65y/V6uvMiLr265IgXnbf49XCQgQXceZj27wQG9hI/6OGBS4mwaPv
	 Di60w3Js6WqGA==
Date: Wed, 12 Mar 2025 13:03:09 +0100
From: Matthias Brugger <matthias.bgg@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl, Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: riscv: Add SiFive HiFive Premier P550
 board
Message-ID: <Z9F3_Zb4RvHLvgSd@ziggy.stardust>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311073432.4068512-5-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311073432.4068512-5-pinkesh.vaghela@einfochips.com>

On Tue, Mar 11, 2025 at 01:04:26PM +0530, Pinkesh Vaghela wrote:
> From: Pritesh Patel <pritesh.patel@einfochips.com>
> 
> Add DT binding documentation for the ESWIN EIC7700 SoC and
> HiFive Premier P550 Board
> 
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> ---
>  .../devicetree/bindings/riscv/eswin.yaml      | 29 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/eswin.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/eswin.yaml b/Documentation/devicetree/bindings/riscv/eswin.yaml
> new file mode 100644
> index 000000000000..c603c45eef22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/eswin.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/eswin.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ESWIN SoC-based boards
> +
> +maintainers:
> +  - Min Lin <linmin@eswincomputing.com>
> +  - Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> +  - Pritesh Patel <pritesh.patel@einfochips.com>
> +
> +description:
> +  ESWIN SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sifive,hifive-premier-p550
> +          - const: eswin,eic7700

That should be the other way around. You could have, let's say eic7701
with different peripherals but smae p550 IP core. I don't expect a new
eic7700 with a CPU IP other then p550.

Regards,
Matthias

> +
> +additionalProperties: true
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353d..901d0e0adb25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8572,6 +8572,12 @@ L:	linux-can@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/can/usb/esd_usb.c
>  
> +ESWIN DEVICETREES
> +M:	Min Lin <linmin@eswincomputing.com>
> +M:	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> +M:	Pritesh Patel <pritesh.patel@einfochips.com>
> +S:	Maintained
> +
>  ET131X NETWORK DRIVER
>  M:	Mark Einon <mark.einon@gmail.com>
>  S:	Odd Fixes
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

