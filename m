Return-Path: <linux-kernel+bounces-345269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6579998B3F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F651B22C54
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C831BBBD6;
	Tue,  1 Oct 2024 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LDDEEblA"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEE736AF8;
	Tue,  1 Oct 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762180; cv=none; b=BLhPK2XZpiX5lyR+BNuUyvhF3Ka7WXHL8FJhhFgJ/mhZISIEkQ6S18jOdKuq7IBCqNtaqIM9Gl7j/WFdmJKwOiI5tMubxC1Rtpvr2TRkV9EsW4p0DT8Tlv73ERwwbt0h92JL1q7bJFjfEPfd5Z7S16ybnwkhvFLPZfwdYStpEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762180; c=relaxed/simple;
	bh=ExMjnSP9sJ1OhmA+NnmHR9K1OURkugire2cpBKFzPjk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmWY6jPVRwILXHbP8fZl8nzahk0ULKfjy/UpMqhuiIIzRTzRuU6KQ3SewB/663Arq5DzEMimkm5E1akWuqBNAzCIGF+1Elkos2dzZaifekSpDxM6fBetT/R/+w7sHWdFgGYWi/7M9lqG0WWQ7ehlbAugebNq6SuAaQKcnlpc2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LDDEEblA; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4915trho116154;
	Tue, 1 Oct 2024 00:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727762153;
	bh=2NdUyEyvt9UUPlWmqWz0ga5Ikg4GePs2gjqgOXQbphc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LDDEEblA1DPsLrfUlyw59AZ9GHr0sDFeCd6Hmj3ZILko830JJjCscs6k9PmlR5DIj
	 u4RxFBCsfzY+q0Afabnw8a1sbH0SOwLR2I4YTa8DYfWaoROTU6N9aHSE97UfdRGmVR
	 PUmKufo6IhES4XPlNhwbKb2H//TUddtgExP88lx8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4915trGO005685
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 1 Oct 2024 00:55:53 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 00:55:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 00:55:52 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4915tpPT008934;
	Tue, 1 Oct 2024 00:55:52 -0500
Date: Tue, 1 Oct 2024 11:25:51 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v6 0/5] Introduce J742S2 SoC and EVM
Message-ID: <20241001055551.md35lxzwsvx4mktj@uda0497581>
References: <20240903-b4-upstream-j742s2-v6-0-49d980fed889@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903-b4-upstream-j742s2-v6-0-49d980fed889@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vignesh/Nishanth,

On 13:42-20240903, Manorit Chawdhry wrote:
> The series adds support for J742S2 family of SoCs. Also adds J742S2 EVM
> Support and re-uses most of the stuff from the superset device J784s4.
> 
> It initially cleans up the J784s4 SoC files so that they can be
> re-usable for j742s2 by introducing -common files. Next it cleans up the
> EVM files for j784s4 in a similar way and then goes about adding the
> support for j742s2.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
> Changes in v6:
> - Rebased on upstream-next
> - Add a comment for MSMC node (Udit)
> - Link to v5: https://lore.kernel.org/r/20240828-b4-upstream-j742s2-v5-0-9aaa02a0faee@ti.com
> 
> Changes in v5:
> - Rebased on upstream-next
> - Align j742s2 and j784s4 comments (Siddharth)
> - Link to v4: https://lore.kernel.org/r/20240819-b4-upstream-j742s2-v4-0-f2284f6f771d@ti.com
> 
> ---
> Manorit Chawdhry (5):
>       arm64: dts: ti: Refactor J784s4 SoC files to a common file
>       arm64: dts: ti: Refactor J784s4-evm to a common file
>       dt-bindings: arm: ti: Add bindings for J742S2 SoCs and Boards
>       arm64: dts: ti: Introduce J742S2 SoC family
>       arm64: dts: ti: Add support for J742S2 EVM board

The patches are still valid for 6.12-rc1.

Regards,
Manorit

> 
>  Documentation/devicetree/bindings/arm/ti/k3.yaml   |    6 +
>  arch/arm64/boot/dts/ti/Makefile                    |    4 +
>  arch/arm64/boot/dts/ti/k3-j742s2-evm.dts           |   26 +
>  arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi         |   45 +
>  arch/arm64/boot/dts/ti/k3-j742s2.dtsi              |   98 +
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 1488 +---------
>  .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  148 +
>  .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 1490 ++++++++++
>  .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2671 ++++++++++++++++++
>  ...tsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |    2 +-
>  ...l.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} |    0
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 2847 +-------------------
>  arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |  133 +-
>  13 files changed, 4592 insertions(+), 4366 deletions(-)
> ---
> base-commit: ecc768a84f0b8e631986f9ade3118fa37852fef0
> change-id: 20240620-b4-upstream-j742s2-7ba652091550
> 
> Best regards,
> -- 
> Manorit Chawdhry <m-chawdhry@ti.com>
> 

