Return-Path: <linux-kernel+bounces-574892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEF5A6EB35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8717318912AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8132253B52;
	Tue, 25 Mar 2025 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baEVxmc3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0B481C4;
	Tue, 25 Mar 2025 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890406; cv=none; b=rTWm1z6zb/OU9J2cuTdBYtIAOwplb5zDo3LG2M8BiGDnJssMswbbkc0VZ0FSaFgECmEsHLCpFGUEaH9XHlcd1ep8GXq3x3+rlJGUQ5CiflWD+wnBzeQmr6s2NR+LLCYRUHYxZbNYF9+Y4qIBHRHpJIpori+O1YH2Y44+VZJ5BFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890406; c=relaxed/simple;
	bh=f6XJAegToS0M5tfF5z+5zMcVYoym5F06kRgni6qPdOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ+/zidwAYNvyE1juDaub3ba0S5e1P5A0sJEHPupMoYH5lp07cE6QeSLseD/a+P2LNt0uJWQYYrSO9ZbkfaAG9LEoOymBV9ORSQaMwb7aWE0Fjro0FNMWMpQkeco1ogTTGiBptQu4reYAhr8jBymTtHATssxCY3r8x5rhwhbmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baEVxmc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB913C4CEE4;
	Tue, 25 Mar 2025 08:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742890405;
	bh=f6XJAegToS0M5tfF5z+5zMcVYoym5F06kRgni6qPdOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baEVxmc3M4Wz1Zex6nUZ6qxP+swaMOjHIO3FB4/csR5/EO+pEs+wJiHME3ZnE1fSa
	 D7wpUsUNVxOFeyCtB0DT4hcxGOHEF4tHVYaCVN9fIq3bmd6FUPMXcbY7u7gZw5xEd4
	 QMd/uIbZSH4vmVvEj7vq9wu77t/i7XUBAJsMxIOofygKG9Q1Klsi8zveL878QqYVK0
	 l++w4HGhe8xpU2Sl65wzo/lBvI9pkiFXERmljUUq6vecU+hn3XmFbdkhYfGzMdDmVc
	 uWBe7eNddDEEDIJurJvEIQ5yFRquLENP+JbXs35afdO6OAJzQAoCCwGNwnSqcbN58w
	 jve2gNPx5FYag==
Date: Tue, 25 Mar 2025 09:13:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	pierre-henry.moussay@microchip.com, valentina.fernandezalanis@microchip.com, 
	Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Lee Jones <lee@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/9] dt-bindings: soc: microchip: document the
 simple-mfd syscon on PolarFire SoC
Message-ID: <20250325-quiet-waxbill-of-realization-675469@krzk-bin>
References: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
 <20250321-ramrod-scabby-a1869f9979b6@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321-ramrod-scabby-a1869f9979b6@spud>

On Fri, Mar 21, 2025 at 05:22:35PM +0000, Conor Dooley wrote:
> +title: Microchip PolarFire SoC Microprocessor Subsystem (MSS) sysreg register region
> +
> +maintainers:
> +  - Conor Dooley <conor.dooley@microchip.com>
> +
> +description:
> +  An wide assortment of registers that control elements of the MSS on PolarFire
> +  SoC, including pinmuxing, resets and clocks among others.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: microchip,mpfs-mss-top-sysreg
> +      - const: syscon
> +      - const: simple-mfd

You need to list the children if you use simple-mfd. Commit msg
mentioned clock controller, so where is it?


> +
> +  reg:
> +    maxItems: 1
> +
> +  '#reset-cells':
> +    description:
> +      The AHB/AXI peripherals on the PolarFire SoC have reset support, so
> +      from CLK_ENVM to CLK_CFM. The reset consumer should specify the
> +      desired peripheral via the clock ID in its "resets" phandle cell.
> +      See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list
> +      of PolarFire clock/reset IDs.
> +    const: 1

Best regards,
Krzysztof


