Return-Path: <linux-kernel+bounces-534002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C88B9A4615A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49563B02FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8B221544;
	Wed, 26 Feb 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BflfOoIK"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011B22154F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578038; cv=none; b=ZRJHMNCL+fkdz4knV17+kHwAUp7whUzFYoumfykXqe1apuM4weXD4GhcpHPRv4dX7r+2B91CHue8YbI9WIHoy7KwALHYZe3WjMUilOZInkCJWFptAunEtJOg/TMEF3vO9d1uGVIKcdgLQHG9Ayr6fFtnqbUxxiO+DhGUaiEIrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578038; c=relaxed/simple;
	bh=1l3fOC61E5RTw0AZOPG1OtGKg+IVpB0rhJErnTlwZJI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgJmxIHuhV2qcsTVVqcZNu0QlGmi9DETf22GImI2CtgcFL05fYUWx5LbbG8/tHiICky98vZ6jb+lxsjhQTCqKG/KLh82ye4FCORlu+Np3jzt+fZI0HaN3bcfzEUDRh5KBrIRRWnzjz9SxyuYRauAAYmHUwY0CS8b88KJSdrv/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BflfOoIK; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QDrXEg1558673
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 07:53:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740578013;
	bh=2EOvlAclHzeQp38EozYAQpR/NIfs720sD/vFVN9IDmA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=BflfOoIKoe3ZMuBooXdYzUcIURGor7uEcCvrRrE7hwrDtxFPyPAUDQLK9WFwgKo7e
	 mFzx6HAvmdpG9Y30AHISfDanoeG+kOzh4lysq4jVK2LEt1zoArEMjreuwiDjMa+V9d
	 iPeCbZRvSnAIWa/M/CMJ1LDdcaRxl7wmnjrksY1k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51QDrXm1128702
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Feb 2025 07:53:33 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 07:53:32 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 07:53:32 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QDrW4B126476;
	Wed, 26 Feb 2025 07:53:32 -0600
Date: Wed, 26 Feb 2025 07:53:32 -0600
From: Nishanth Menon <nm@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <elinor.montmasson@savoirfairelinux.com>,
        <javier.carrasco@wolfvision.net>, <ebiggers@google.com>,
        <biju.das.jz@bp.renesas.com>, <quic_tdas@quicinc.com>,
        <nfraprado@collabora.com>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <geert+renesas@glider.be>, <quic_bjorande@quicinc.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        "Ravi
 Gunasekaran" <r-gunasekaran@ti.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable HSR driver
Message-ID: <20250226135332.5g3ydyukzy5oqivo@legume>
References: <20250226104517.1746190-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226104517.1746190-1-m-malladi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 16:15-20250226, Meghana Malladi wrote:
> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> HSR is a redundancy protocol that can be realized with any
> two port ethernet controller.
> 
> Many of TI's K3 SoCs support multi port ethernet controller.
> So enable HSR driver inorder to support this protocol on
> such SoCs.

Which boards use this? cam you update the commit message for the same?

> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 
> v1: https://lore.kernel.org/all/20240419060013.14909-1-r-gunasekaran@ti.com/
> 
> v2-v1:
> - Rebase to the latest tip
> - Included TI specific maintainers in 'to'
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c3df5120b23d..f3afc0ec68f0 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -177,6 +177,7 @@ CONFIG_NET_CLS_FLOWER=m
>  CONFIG_NET_CLS_ACT=y
>  CONFIG_NET_ACT_GACT=m
>  CONFIG_NET_ACT_MIRRED=m
> +CONFIG_HSR=m
>  CONFIG_NET_ACT_GATE=m
>  CONFIG_QRTR_SMD=m
>  CONFIG_QRTR_TUN=m
> 
> base-commit: 8433c776e1eb1371f5cd40b5fd3a61f9c7b7f3ad
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

