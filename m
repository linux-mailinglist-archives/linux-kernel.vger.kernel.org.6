Return-Path: <linux-kernel+bounces-347339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4C998D151
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B062284741
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD151E6DE7;
	Wed,  2 Oct 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="iDxiiJuo"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526141E6DDF
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865170; cv=none; b=Ow2fO8ItNWBGmhB0H1zvVbGrA6ZKEJPrKj84pFrtLuGPc4YHQivVL7DNUE0KSebMJXt/IaNR5iRY+ViNcNsJDP3JNfCazzILD1rcc2psLe/uTHEgLdEtKRbDScZZl3jcwPMt/MYmxFIIg5Z/pXWDTYozioWvoSqJgSqbsC1837c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865170; c=relaxed/simple;
	bh=qhhMp+5PFLjPuBGv4Wz2Z9oy/cOs7iyLNZQzMP1vyPs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=tEC1XjqZ4CdioR6wZYAar23RCQAiBb+aRfDffU4yTDtxoeXWUO8xaYgxFS8mU0HNx8FT74XUbNUvhtuRad6BUSKAr1khd5fOHUI/RCIbtoT+QUQ5tMdVZMCl92Uy4RW7lqo8l+sMESld69/yOXS90AecnbLM3sgp9MnEREGlTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=iDxiiJuo; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1727865164; x=1730457164;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qhhMp+5PFLjPuBGv4Wz2Z9oy/cOs7iyLNZQzMP1vyPs=;
	b=iDxiiJuoQlUbNVSWJ9GWBRPohlZ4p3XTXHlOFa17mS034xJS5AQ+f97ubw8RSqjc
	Rkx1JAuJy771YcDx5EtvDGmj60USSLF6gVHFfyOlbmMiEh8vH/tZbK61SbaQlHNk
	mQctrEyQLZj5HBXnE1+DfcpED2mAqyiYq4b5/bz8Cyg=;
X-AuditID: ac14000a-4637f70000004e2a-61-66fd214c4664
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CE.8F.20010.C412DF66; Wed,  2 Oct 2024 12:32:44 +0200 (CEST)
Received: from [192.168.10.3] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 2 Oct 2024
 12:32:43 +0200
Message-ID: <4238b46e-58eb-41b8-863c-2c66e823f594@phytec.de>
Date: Wed, 2 Oct 2024 12:32:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH] arm64: defconfig: Enable PCF857X GPIO expander
From: Wadim Egorov <w.egorov@phytec.de>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <quic_bjorande@quicinc.com>,
	<krzysztof.kozlowski@linaro.org>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <shawnguo@kernel.org>,
	<neil.armstrong@linaro.org>, <arnd@arndb.de>, <m.szyprowski@samsung.com>,
	<nfraprado@collabora.com>, <u-kumar1@ti.com>
CC: <upstream@lists.phytec.de>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240718095239.922641-1-w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20240718095239.922641-1-w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWyRpKBR9dH8W+awYZvShZ/Jx1jt3i/rIfR
	YuL5n2wWc2dPYrTY+3oru8Wmx9dYLS7vmsNmsfbIXaCSnbcYLb5ufsFs0fh4BqPFiy3iFtP2
	zmC26H6nbtFyx9SB32PNvDWMHr9/TWL02HF3CaPHxLO6HptWdbJ53Lm2h81j85J6j/7uFlaP
	iXvqPPq2rGL0OH5jO5PH501yATxRXDYpqTmZZalF+nYJXBldE/6wFPxjrdi0fy9bA+Mfli5G
	Dg4JAROJs6ejuxi5OIQEljBJrPmyghXCucMosarjBmMXIycHr4CNRMOX5SwgNouAisTSbR+Z
	IOKCEidnPgGLiwrIS9y/NYMdxBYW8JP40PGKGcRmE1CXuLPhG9hQEYEDTBLTZl4ASzALZEhs
	enWJDcQWErCQeLPxFhtEXFzi1pP5YAs4BSwl7u/6wA4Rt5BY/OYglC0vsf3tHGaIXnmJF5cg
	jpMAsqede80MYYdKbP2ynWkCo/AsJLfOQrJiFpKxs5CMXcDIsopRKDczOTu1KDNbryCjsiQ1
	WS8ldRMjKJZFGLh2MPbN8TjEyMTBeIhRgoNZSYT33qGfaUK8KYmVValF+fFFpTmpxYcYpTlY
	lMR5V3cEpwoJpCeWpGanphakFsFkmTg4pRoYJx+Mnp28LGDCzcrpJku0GL02TMs56vy4bE9p
	RtyzH6e5Xl49GTGxVdzGcIX53u2dvMZzDBzKF6VurOT4v+BB5fHgX2pxC90+9Rpsb5Pbtj0o
	QObQ9aig7lCh3ROjk/webQoofrQhqtkp8V2rn+OWIz5TXb8Gnz7HO/3diyuHZka8mbhaes2B
	WUosxRmJhlrMRcWJAOm3YbDTAgAA



Am 18.07.24 um 11:52 schrieb Wadim Egorov:
> Enable the PCF857X GPIO expander which is equipped on
> the PHYTEC phyBOARD-Lyra AM625.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

Is there something wrong with this change?

> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ef2235838c44..0c7d3f7717ff 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -655,6 +655,7 @@ CONFIG_GPIO_XGENE_SB=y
>   CONFIG_GPIO_MAX732X=y
>   CONFIG_GPIO_PCA953X=y
>   CONFIG_GPIO_PCA953X_IRQ=y
> +CONFIG_GPIO_PCF857X=m
>   CONFIG_GPIO_BD9571MWV=m
>   CONFIG_GPIO_MAX77620=y
>   CONFIG_GPIO_SL28CPLD=m


