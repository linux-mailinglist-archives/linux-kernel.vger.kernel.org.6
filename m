Return-Path: <linux-kernel+bounces-533074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB41A4556A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54727188BCFE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98C267F5F;
	Wed, 26 Feb 2025 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sxP3HswG"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401B29D0E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550708; cv=none; b=LjECKxZaGF6cV7IWXe/S11pF+T7HoY3vjpJTrKhwWuNySo2k5yeyy1riB3JQjHNu6j9DHCHeWvoYRDXP/FoZH38MRKWtPKatAjzsUQRC9SaHc5dzkJACdCLCJn2XjKdfx9Z5v8eQ7BJhEG0Uw+YtvXZY/G2Cn0eXt30xMK0NTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550708; c=relaxed/simple;
	bh=rnGhfy7NnUxsUsjov/XDOXWGIuCyAAiKL4iAb7KmuyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L4PRWXycvBiXsJfANvqrfGuTyYnAKZnRxsKYQV63ptPZCeJT1r8+AJlk9y8LHskfabpUn4NAaewrfr/O9RCDjSwhj5xuiwt661/6j8hVRhN7EFaFnDZX1jWVQQ+DmrJP256cXp2PaRG/xeJv6ITvj9I5ygGWEvKkWU6pe2j6fRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sxP3HswG; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6IEE71383194
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 00:18:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740550694;
	bh=G8TuloVcDoxRcDVBKwXj6LZhpioTi4Wo9bQZpOdphDk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=sxP3HswGCwWbrDxJsI19Ccv5P4GIoMX95NtmgkUrHnoFZOTNpJdgfgTLnnfzvrxnC
	 maKAzLi1q3d75Ox6loFNLYDCIW/RiTxt2zF+TfCdZbIYG6FnbQAnqvuV41afz1h24Y
	 Zm2Gv1EU3ZAYMXUYdxPMDCndXtqO6Zl/by3W3lsI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51Q6IEwS125352
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Feb 2025 00:18:14 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 00:18:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 00:18:14 -0600
Received: from [172.24.18.117] (lt9560gk3.dhcp.ti.com [172.24.18.117])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51Q6IBcG068437;
	Wed, 26 Feb 2025 00:18:12 -0600
Message-ID: <686f583d-6bf4-4486-b9e4-20c1e268eda6@ti.com>
Date: Wed, 26 Feb 2025 11:48:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable HSR driver
To: <catalin.marinas@arm.com>, <will@kernel.org>
CC: <quic_bjorande@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        "Anwar, Md Danish"
	<danishanwar@ti.com>
References: <20240419060013.14909-1-r-gunasekaran@ti.com>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20240419060013.14909-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi all,

Apologies in case you are receiving this email for the second time.
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


