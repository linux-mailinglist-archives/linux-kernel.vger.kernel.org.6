Return-Path: <linux-kernel+bounces-347035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F0698CCDA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44CF1C21607
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728F78C75;
	Wed,  2 Oct 2024 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="YiJZRziY"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1828F4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727848882; cv=none; b=HgJKFLU42ALo+Ue7ydABIdlZCEpwoSMf6GUTDLtFb6JmDfBkyDVpxj+v3d90XpV1JF2RWtO4YJOwKYflNP6TuKGXVWOxvM3Y1RXs/RdgX5lAPxxNFXmIqCW6nckHzqgJmcrr5AmxULdDULuzSlkSpBfmIWi7uSNRDJB2JYs0L18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727848882; c=relaxed/simple;
	bh=LKTbHHLO/vnysOazd45eOK3cXhulBrSxhF15nrK9ROE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=izeUGcCcIjmp/DJ6ud7HO2dhnXzl53T/RQQgG3zUR7O2OFKpVID3rk+Oj/kB8VqaX90LPrU39/CxuH8iLbD2C4Tri/AxQSLm5EB7mwQtx+lhwYL0WUKhiTkUHg8qHdu68idJPgVWhz0hEmS+BPhvGxslxjst1bAVRFw0Dsf37U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=YiJZRziY; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1727848870; x=1730440870;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LKTbHHLO/vnysOazd45eOK3cXhulBrSxhF15nrK9ROE=;
	b=YiJZRziYYvMhFRzOgifMXgeWGIqwO/7s96Vb3szJVIi53nV98xbz/G9gs4Swtvpp
	Ze1oIJS42cTUBqzzQ1LMF6n14XdPvuMi7BVERm3mXyRGpD8aagyukx1aA+H7yF8Q
	/gmepxhXyOLwBbf7VAXFpEgC5oH2hNBp5yRmfmkr/bo=;
X-AuditID: ac14000a-4637f70000004e2a-8f-66fce1a64790
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A8.6D.20010.6A1ECF66; Wed,  2 Oct 2024 08:01:10 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 2 Oct 2024
 08:01:08 +0200
Message-ID: <67d9f315-3c18-4a40-9167-afe8f6be8a2f@phytec.de>
Date: Wed, 2 Oct 2024 08:01:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 1/2] arm64: dts: ti: k3-am64-phycore-som: Fix
 bus-width property in MMC nodes
To: John Ma <jma@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <upstream@lists.phytec.de>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240926174404.3122100-1-jma@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240926174404.3122100-1-jma@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWyRpKBR3fZwz9pBo2bFSzW7D3HZDH/yDlW
	i2edTcwWyz/PZrd4Oesem8Wmx9dYLS7vmsNm8ebHWSaL/3t2sFt0v1O3+H/2A7sDt8emVZ1s
	HpuX1Hv0d7ewevy5+I7V4/iN7UwenzfJBbBFcdmkpOZklqUW6dslcGU8XTWLveAeW8W0vZOY
	GxiPsnYxcnJICJhI9K2/zdbFyMUhJLCESWLVldOsEM4dRolLbz6xgVTxCthI9C48xg5iswio
	SGx50ccIEReUODnzCQuILSogL3H/1gywGmGBPInHy18xggwSEZjKKLFu20kmEIdZoI1R4sGG
	bqCpHEArTCVurtAEaWAWEJe49WQ+E4jNJqAucWfDN7DzOAXMJDpOzGKEqLGQWPzmIDuELS+x
	/e0cZhBbCMh+cWk5C8Q78hLTzr1mhrBDJY5sWs00gVF4FpJbZyFZNwvJ2FlIxi5gZFnFKJSb
	mZydWpSZrVeQUVmSmqyXkrqJERRxIgxcOxj75ngcYmTiYDzEKMHBrCTCe+/QzzQh3pTEyqrU
	ovz4otKc1OJDjNIcLErivKs7glOFBNITS1KzU1MLUotgskwcnFINjLsqnhc+1GOe7fXP8dfv
	wktKbZzbW1U8jvkUf98T5LP5D7dTbESG9j+X02b/ZcJrhJ49CFZTc2J1TJA/YXLTLjnrjJe7
	TNrMv3a+yxMyzeO/nZr95EqGSuS87/xpV4rbXlwSzTMRu6PN/qP4QWVnDiOnpO/rL7sNRc2v
	33Ly7rs07wxzSxyvEktxRqKhFnNRcSIAImqirqYCAAA=



Am 26.09.24 um 19:44 schrieb John Ma:
> The bus-width property was moved to k3-am64-main.dtsi.
> 
> See commit 0ae3113a46a6 ("arm64: dts: ti: k3-am6*: Fix bus-width property
> in MMC nodes")
> 
> Signed-off-by: John Ma <jma@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> index 6bece2fb4e95..75e08d0bf4ab 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -354,7 +354,6 @@ serial_flash: flash@0 {
>   
>   &sdhci0 {
>   	status = "okay";
> -	bus-width = <8>;
>   	non-removable;
>   	ti,driver-strength-ohm = <50>;
>   	disable-wp;


