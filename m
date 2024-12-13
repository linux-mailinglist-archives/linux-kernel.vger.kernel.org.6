Return-Path: <linux-kernel+bounces-444281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A019F0404
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2437188AAA5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4D0186E56;
	Fri, 13 Dec 2024 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="C86JtZ1z"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F42C181;
	Fri, 13 Dec 2024 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734066488; cv=none; b=fKqzrB+hxDG/XMlx0ixIex9yi0XfZlSmYW4laugaciCCpZu/Aww2OIsFkAHXCNwZzFDiVVfjiIcqeLj1KgOyhB07Hud+Bfe7SX/D2G+blCjSaUutpp/lNOpvXz9poQyGhGnRga9UyE+tqvKpK7Ij+x6oBQ6EyZliGzEIXVQoojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734066488; c=relaxed/simple;
	bh=9AEGl5ElwpjNS1/xC3yqlInieIsycY0WHHNck3fN87Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CSLcYtH0UX65EgXedzAv6tc9iXSiIncOm9rnqlHPYZWudOrNNKWV1yeLo/SOCTTTc5N/VW4KWaS3ctxjCISy3lccg5yBsvmzHY+fxNDvYV2GmWKf3mjuKMjTaKMS4SBCPpbmuK/2jByWHjGmknA+Nm2yZq3+ojHbFP50kxlZy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=C86JtZ1z; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1734066479;
	bh=Ob6gfCfTJHcT1k8fkHYM0XMpgJYwAe0EV0uca1nDr9I=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=C86JtZ1z9ScLdE1lNtMuIngcOj/VqRvKOHDmgo896hr3259jdBQvgCmOjjv884YfA
	 xAKjpd0m+DxSyccXXYzrkjQwe9L5cTwm+0F8hSoMyCQVtMV2I2e1mXWWbyawdizg/6
	 a7qJyp73jmuPa7/ow/rx0Eh+W3D5DGKqh4Y+X/fpeEuZxfmRmX424WCai3N8oudT2a
	 hW0hQAIxJiDgt+gv8OlIDTbIR3cqXI3k9m1qCPXHp3GCCWh4HsKYCzQbrrvN4yzbTW
	 B3B6qG1Zsc8BEaI1gAecV+2VIE66oIGPX3VP7YRviJXYiCkdVJWRRw3jZ1xmekqMCg
	 QuPaKtwScp9UA==
Received: from [192.168.68.112] (203-173-6-153.dyn.iinet.net.au [203.173.6.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9893B6E54C;
	Fri, 13 Dec 2024 13:07:53 +0800 (AWST)
Message-ID: <5d91b7a7169e6db27b2493213d0df2b77699a49e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 0/6] Introduce ASPEED AST27XX BMC SoC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Chen <kevin_chen@aspeedtech.com>, robh@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org, joel@jms.id.au,
 tglx@linutronix.de, catalin.marinas@arm.com,  will@kernel.org,
 arnd@arndb.de, olof@lixom.net, quic_bjorande@quicinc.com, 
 geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
 konradybcio@kernel.org,  neil.armstrong@linaro.org,
 johan+linaro@kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, soc@lists.linux.dev
Date: Fri, 13 Dec 2024 15:37:52 +1030
In-Reply-To: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kevin,

On Thu, 2024-12-12 at 23:52 +0800, Kevin Chen wrote:
> ---
> v3:
> =C2=A0 - Split clk and reset driver to other commits, which are in series
> of
> =C2=A0=C2=A0=C2=A0 "Add support for AST2700 clk driver".
> =C2=A0 - For BMC console by UART12, add uart12 using ASPEED INTC
> architecture.
>=20
> aspeed,ast2700-intc.yaml
> =C2=A0 - Add minItems to 1 to fix the warning by "make dtbs_check W=3D1".
> =C2=A0 - Add intc1 into example.
>=20
> Kconfig.platforms
> =C2=A0 - Remove MACH_ASPEED_G7.
>=20
> Kevin Chen (6):
> =C2=A0 dt-bindings: interrupt-controller: Refine size/interrupt-cell
> usage.
> =C2=A0 dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
> =C2=A0 arm64: aspeed: Add support for ASPEED AST27XX BMC SoC
> =C2=A0 arm64: dts: aspeed: Add initial AST27XX device tree
> =C2=A0 arm64: dts: aspeed: Add initial AST2700 EVB device tree
> =C2=A0 arm64: defconfig: Add ASPEED AST2700 family support

Do you mind sending a v4, because I received a confusing arrangement of
patches:

[PATCH v3 1/6] dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
[PATCH v3 1/6] dt-bindings: interrupt-controller: Refine size/interrupt-cel=
l usage.
[PATCH v3 2/6] dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
[PATCH v3 2/6] dt-bindings: interrupt-controller: Fix the size-cells in ast=
2700-intc
...

Where the content of=20

   [PATCH v3 1/6] dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
  =20
and

   [PATCH v3 2/6] dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
  =20
Differs, as does the content of

   [PATCH v3 1/6] dt-bindings: interrupt-controller: Refine size/interrupt-=
cell usage.
  =20
and

   [PATCH v3 2/6] dt-bindings: interrupt-controller: Fix the size-cells in =
ast2700-intc

Despite sounding like they might have the same intent

Andrew

