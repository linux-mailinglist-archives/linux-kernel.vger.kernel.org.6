Return-Path: <linux-kernel+bounces-277946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F49B94A886
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BD51C22DD0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886C1E7A52;
	Wed,  7 Aug 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AO1QyPSM"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8DE1E7A3B;
	Wed,  7 Aug 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037114; cv=none; b=lWxQPuyaAe/LgvpRkBk/kFyUyemS1WzoqJ3GnKjOJ5t5dkKFBeFpf67JSw92HFrX/nWbiejunWH+rKPUwb//2kG2VZcTQLZod4YGtKthrWfcZ3CzYAJiMPP5e1Nc5hcw5772Zo/eR9KR8swr5m/lwFyzlrq8e6lfyg2qVqZSc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037114; c=relaxed/simple;
	bh=5xCFrjEdZmLFRfA/F6wPZmAZSz2qOrZVAK9FG0yQPTU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmGboLctyLVNpAjdtW726PCuDfwnmP/+8PYtvv6Hb3PtLtV99utZwvDikj0SYrrl4H8REST3XIgvPvE1KlIXexY6xq932Hu7dEQqnnCaDVhELmexM2lLJWVFGGqX2Ksc0N6+ZPg3+ln7EqKZ6t4JTv5u7MbjW0N2lzoK5ru/CPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AO1QyPSM; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477DP5uO100681;
	Wed, 7 Aug 2024 08:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723037105;
	bh=dTM4H9bqTaHLAvJRg1ebkGBPpTtPuA23CL/9b5SS2cs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=AO1QyPSMpjcqdHYtCG9g51ERNSA432GQEuedshn0nq7DP9QdlfixzBwmGNnVnBQyo
	 j7q9j0tUuFQU35yPEGHWPYXzXNKnpnol0OOrourO0uBW71b4sSPQhnSa4jjKyMhey2
	 XOIM22DRUNJZMZPNpINcWDYTidWIVR65Ei82l+Rk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477DP5XN008550
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 08:25:05 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 08:25:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 08:25:05 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477DP55T008216;
	Wed, 7 Aug 2024 08:25:05 -0500
Date: Wed, 7 Aug 2024 08:25:05 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/9] Introduce J742S2 SoC and EVM
Message-ID: <20240807132505.4aqvgsdck7pzk6kv@impale>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 22:40-20240731, Manorit Chawdhry wrote:
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
> Changes in v3:
> * Nishanth
> - Update copyright string
> - Add TRM link in SoC file.
> - Refactor to split out common soc support between j742s2 and j784s4
> 
> - Add DTC_FLAGS as well for j742s2
> - Link to v2: https://lore.kernel.org/r/20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com
> 
> ---
> Manorit Chawdhry (9):
>       arm64: dts: ti: Move j784s4-{} include files to j784s4-j742s2-{}-common.dtsi
>       arm64: dts: ti: Move k3-j784s4.dtsi to k3-j784s4-j742s2-common.dtsi
>       arm64: dts: ti: Split k3-j784s4-j742s2-common.dtsi
>       arm64: dts: ti: Split k3-j784s4-j742s2-main-common.dtsi

The above 4 patches can be merged into a single patch under SoC
refactoring.

>       arm64: dts: ti: Move k3-j784s4-evm.dts to k3-j784s4-j742s2-evm-common.dtsi
>       arm64: dts: ti: Split k3-j784s4-j742s2-evm-common.dtsi

The above two patches can be squashed to be a single patch for evm
refactoring.

>       dt-bindings: arm: ti: Add bindings for J742S2 SoCs and Boards
>       arm64: dts: ti: Introduce J742S2 SoC family
>       arm64: dts: ti: Add support for J742S2 EVM board

Also it is not clear how cpsw/serdes and pcie changes are handled
here.

> 
>  Documentation/devicetree/bindings/arm/ti/k3.yaml   |    6 +
>  arch/arm64/boot/dts/ti/Makefile                    |    4 +
>  arch/arm64/boot/dts/ti/k3-j742s2-evm.dts           |   26 +
>  arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi         |   45 +
>  arch/arm64/boot/dts/ti/k3-j742s2.dtsi              |   98 +
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 1422 +---------
>  .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  150 ++
>  .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 1436 ++++++++++
>  .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2772 ++++++++++++++++++++
>  ...tsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |    2 +-
>  ...l.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} |    0
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 2764 -------------------
>  arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |  135 +-
>  13 files changed, 4540 insertions(+), 4320 deletions(-)
> ---
> base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
> change-id: 20240620-b4-upstream-j742s2-7ba652091550
> 
> Best regards,
> -- 
> Manorit Chawdhry <m-chawdhry@ti.com>
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

