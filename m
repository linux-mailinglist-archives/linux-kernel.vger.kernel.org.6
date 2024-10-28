Return-Path: <linux-kernel+bounces-385397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F59B36AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8E51F22733
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C895A1DF24C;
	Mon, 28 Oct 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B5DrNiN0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6E1DE8B3;
	Mon, 28 Oct 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133414; cv=none; b=PyGeRRopillqFrPY31Pz6gLDZVD2fNdjSOh2WbMHdru/dJiPVINksv8/9QV/92FbV9Cx9ndkw2d+WPPJvuWbn2jieZ2Vmoka0cLCId5PH/aRreGPVH/AOFckIwv6vQKExHrHT+kiTCNqsNreH/ZcbFd9k4cpkBQRdW3RJ6/FdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133414; c=relaxed/simple;
	bh=QeH5x+SqklQ8CnprYEyXo/Gm/MMehhFlTWuVhjoGnTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hxj7a4kMBSIX0sOJV5hp7NAd+97fpjbmA7o9IWNgzgtNZRHdv5hs8UrchA26gtKCuFfmsgXfB8VyRoujDRJmfsNoCacC5Y+Aajn+92r5AlgM74IMl+efG/Xb4cnpmUkYb7medfRdJJAXhgNEDfdTFCk3+7tGIAdF+w5YttOm/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B5DrNiN0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SGajEu053859;
	Mon, 28 Oct 2024 11:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730133405;
	bh=h/gCeVTPDfCZ9Sq1m6pfoJ1aYry8ZWlrjxDFFQhYtRk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=B5DrNiN0pEhLp8QSnCI5A2+V2KDXIFqTp+MceeqNiuSE+sLDK7LuHXunemDEZG2AE
	 5gfegkfufNVCYnh0U0MIk3UHD6u7zBBwgmJ9UmOydfoBIuJn+y3ccMxbMFL76uL5MD
	 2r1gGviVduJDS9WGCwLYZ8PiquWBzESUSiSXScMk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SGajIk109530;
	Mon, 28 Oct 2024 11:36:45 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 11:36:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 11:36:45 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SGafbs106057;
	Mon, 28 Oct 2024 11:36:42 -0500
Message-ID: <b2dadb0a-fd85-42fc-b340-6c77fe5ded0a@ti.com>
Date: Mon, 28 Oct 2024 22:06:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all
 property in cpsw_mac_syscon node
To: Chintan Vankar <c-vankar@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC: <s-vadapalli@ti.com>, <srk@ti.com>, <danishanwar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20241011110207.600678-1-c-vankar@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20241011110207.600678-1-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 11/10/24 16:32, Chintan Vankar wrote:
> Add bootph-all property in CPSW MAC's eFuse node cpsw_mac_syscon.
> 

Why?

Please make sure commit message is verbose enough to say why the change
is needed vs what that change is (latter is obvious lookng at the diff)

> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> This patch is based on linux-next tagged next-20241011.
> 
>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 44ff67b6bf1e..82d34dfb91ed 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -303,6 +303,10 @@ AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0) /* (C5/C6) WKUP_UART0_TXD */
>  	};
>  };
>  
> +&cpsw_mac_syscon {
> +	bootph-all;
> +};
> +
>  &wkup_uart0 {
>  	/* WKUP UART0 is used by DM firmware */
>  	bootph-pre-ram;

-- 
Regards
Vignesh

