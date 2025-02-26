Return-Path: <linux-kernel+bounces-533124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06168A455E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B1D3ACC70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995BB268FE3;
	Wed, 26 Feb 2025 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oxUBhg5j"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9CE15B99E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552203; cv=none; b=Q9mNGlATIoYbi1Jsm5uITbcQQGvTTNiffBXZ3OOm8mquvxo+GUO//hq33dLf/8LIXBPfquj2v+sKQdiOy+Wsgg3/x0yeZzx6oP9XGJb7MANwKkmVGmDCD84fj25oDIjKJSLVFRiWvoVfT5GNfYZNfMyq8N/fLgSTpbX6k7oaXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552203; c=relaxed/simple;
	bh=qnlMfGzvX2xlMSjWfM7AQuU6kYZPDfXz1wZRUrYXbew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QLwyA8f+RQ+gFUCxI48cLzzbEtTRBiHrE1TzukgVI5MsVicbUPt4yUYPAZ9iJs3PGCYJpTGrbF+1wjomO0eKKw4pPyfcPTcheg9tfZ7F9a2f4r5Hwwiwb2wEDMUR2tjX1EvR25Rk9LlSbkESAc5v/U7qHnVqRSTXwZ7oc6QmMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oxUBhg5j; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6EbMA1988892
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 00:14:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740550477;
	bh=4GvDwBZD4roAF/SEeFoR3akJsASSfyq/Z0vYBe+bC/I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oxUBhg5jlOUavE2PfQvYffDco9krGEJnYdAr8LdVoxqjbTpitIryBF473WMgGQVdZ
	 izS7JiPwER2NDErhH/mFzE1x/jVwMkfcsFbASWj2Qz3xUTzjXEl5VHabaXV5YRrkpt
	 J4AufRIpCdpPRVgYKi6Y0X7BfbNC5HwSucW5yXKo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6Eb11056311
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Feb 2025 00:14:37 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 00:14:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 00:14:37 -0600
Received: from [172.24.18.117] (lt9560gk3.dhcp.ti.com [172.24.18.117])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51Q6EYfG062836;
	Wed, 26 Feb 2025 00:14:34 -0600
Message-ID: <503fcc32-8062-4b17-bb5d-1a2254afcf58@ti.com>
Date: Wed, 26 Feb 2025 11:44:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable HSR driver
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC: <quic_bjorande@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>
References: <20240419060013.14909-1-r-gunasekaran@ti.com>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20240419060013.14909-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi all,

Any reason why this patch hasn't been merged yet. Other than re-basing 
this to the tip, anything else which needs to be addressed to get this 
merged?

Thanks & Regards,
Meghana Malladi.

On 4/19/2024 11:30 AM, Ravi Gunasekaran wrote:
> HSR is a redundancy protocol that can be realized with any
> two port ethernet controller.
> 
> Many of TI's K3 SoCs support multi port ethernet controller.
> So enable HSR driver inorder to support this protocol on
> such SoCs.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 11fa4aa40094..750343564f41 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -176,6 +176,7 @@ CONFIG_NET_CLS_FLOWER=m
>   CONFIG_NET_CLS_ACT=y
>   CONFIG_NET_ACT_GACT=m
>   CONFIG_NET_ACT_MIRRED=m
> +CONFIG_HSR=m
>   CONFIG_NET_ACT_GATE=m
>   CONFIG_QRTR_SMD=m
>   CONFIG_QRTR_TUN=m


