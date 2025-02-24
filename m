Return-Path: <linux-kernel+bounces-528528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6386A418AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CED3A3BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CECD244EA1;
	Mon, 24 Feb 2025 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="R+QVTnMS"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140D260A20;
	Mon, 24 Feb 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388177; cv=none; b=Dy6eO1XH4GJqILK9pG9f14tV3jZeB7B5r1OHtDHpccHHdMsiTK0DWaWvQ2eGjtsRVFeM8O+FDbIweaf+Y/fobk0wGuF+E1PE1kGgJ7/tmnl/bwzGBlbkCNjojRzcRnkVkVwTaqUTRh/q1z6l7CK+6lq1bS4Ta5ktjvhhMXUeW2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388177; c=relaxed/simple;
	bh=KsX/8SSW+cz7CNwOY/YoaslQjS4o9b23XIs173sPnl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdI6/uSSZPFrHo594R87ppT2MgLjn15YWm246jZmoANpI2lBgzb78KzH+aSLTmgrfU84RxruIR7kO9Jlnujgr2ay5mtyOLpDA30J6AOGvobv3PagITfeL3mrKr9LdFf0hryOrDxv4UmZFsVYGyc0YBUioWlfsBdCTglJQ4mcE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=R+QVTnMS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5M7Vwq3vPNXFx3Y80ZtwPFH+1emkyTe/+TzCV6/qris=; b=R+QVTnMSw7oi9Bpt0LYcT9UKq4
	S6qh/hExWGY2MjGrAJXZ/UJskhRHgBhj7NUc8YCb3yyXdogA+XM46XRTwGYtaqlpzCddUycQ8lzsc
	sEzsEzeaR1HNprpcfA6U1gcWl0A4r2udHsy5rky6or/YSAao6UgyyY10qEc8ZFiX1IPVFvpAWy7qE
	EOBGQxYwKIh4P4TOHMiTHxf24QgzXBFZQWRYKsdUsFQZZBbe9X3WuP+FDdIivF+dF/rYq7QkMdHcV
	zwgrnMRfH8orgTr+O/6F04Xv+AyGhBl178+B/g5mZgDJXW1U9WCwepbxYIHlhJIE0X69qJ/C9JGKR
	lmKWR6uA==;
Received: from i53875a0d.versanet.de ([83.135.90.13] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tmUSw-0006ts-IJ; Mon, 24 Feb 2025 10:09:30 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Yao Zi <ziyao@disroot.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Yao Zi <ziyao@disroot.org>
Subject:
 Re: [PATCH v3 1/5] dt-bindings: clock: Document clock and reset unit of
 RK3528
Date: Mon, 24 Feb 2025 10:09:29 +0100
Message-ID: <49730692.MN2xkq1pzW@diego>
In-Reply-To: <20250217061142.38480-6-ziyao@disroot.org>
References:
 <20250217061142.38480-5-ziyao@disroot.org>
 <20250217061142.38480-6-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Montag, 17. Februar 2025, 07:11:42 MEZ schrieb Yao Zi:
> There are two types of clocks in RK3528 SoC, CRU-managed and
> SCMI-managed. Independent IDs are assigned to them.
> 
> For the reset part, differing from previous Rockchip SoCs and
> downstream bindings which embeds register offsets into the IDs, gapless
> numbers starting from zero are used.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  .../bindings/clock/rockchip,rk3528-cru.yaml   |  64 +++
>  .../dt-bindings/clock/rockchip,rk3528-cru.h   | 453 ++++++++++++++++++
>  .../dt-bindings/reset/rockchip,rk3528-cru.h   | 241 ++++++++++
>  3 files changed, 758 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rk3528-cru.h
>  create mode 100644 include/dt-bindings/reset/rockchip,rk3528-cru.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> new file mode 100644
> index 000000000000..5a3ec902351c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rk3528-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3528 Clock and Reset Controller
> +
> +maintainers:
> +  - Yao Zi <ziyao@disroot.org>
> +
> +description: |
> +  The RK3528 clock controller generates the clock and also implements a reset
> +  controller for SoC peripherals. For example, it provides SCLK_UART0 and
> +  PCLK_UART0 as well as SRST_P_UART0 and SRST_S_UART0 for the first UART
> +  module.
> +  Each clock is assigned an identifier, consumer nodes can use it to specify
> +  the clock. All available clock and reset IDs are defined in dt-binding
> +  headers.
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3528-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:

I do think this needs a
    minItems: 1
    maxItems: 2
or similar.

xin24m is the main oscillator everything else is supplied from, so is
absolutely required, but that gmac0 supply comes from an (probably)
optional clock supply from a mac phy?

So is possibly not available on a system without ethernet hardware?


Heiko



