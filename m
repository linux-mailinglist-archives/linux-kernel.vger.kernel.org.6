Return-Path: <linux-kernel+bounces-347036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D9B98CCDC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3D52846A3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2799880054;
	Wed,  2 Oct 2024 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="L47dlokU"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18B28F4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727848890; cv=none; b=tJNSWDzWgxH1jm+A74niHLHqSouwlEt5z1HkdvsdHfv1Ofl0siMUtTgLkr2gsuNJ5kDQxAtqdz0xTrMVkd2NXzRLcOLela3kEsDcQSBulnN8QrnNN3yi+q2jpGIuTiGJH+k/a++/9VIkiMGV0HXtBnczyj/TFzbGa5ZR3kcR6Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727848890; c=relaxed/simple;
	bh=3L5glRFfDrX9muBiw0OMsc0+e0+Q4+wEMxElYwnYZ+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MKV+Ui2LoL5GoQpx0YeLtaTOD2nxyHkVAbLkDR3Uia+tPZTe0YgCXXpqS+iGCiX6K29XJu26q9Wa3ph69js9GU1Eemoi7PMvOraA6/5Xrc04hCaTfQC8E0EmpibhUMFNUYLj9T9qx4LQJ8z3ve443gr9M4eEJpNFcFLFdvF4KyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=L47dlokU; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1727848888; x=1730440888;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3L5glRFfDrX9muBiw0OMsc0+e0+Q4+wEMxElYwnYZ+0=;
	b=L47dlokUskyZOicXCD+JfjrZaZqtBgLb43CIl5V/zt8oEBRE9zakDsthUWI6+R0M
	fjXWhplyMHce+Qq1cYgapFsy//+vmlbnq9Mb0kEYN75WqYltqrqrdsCrZDRDQ9nE
	Ssc5h/TQivZBIYCxsmiV4RK3GvxTIG1O0WlKaGVLoGg=;
X-AuditID: ac14000a-4637f70000004e2a-93-66fce1b80014
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CA.6D.20010.8B1ECF66; Wed,  2 Oct 2024 08:01:28 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 2 Oct 2024
 08:01:26 +0200
Message-ID: <6f929aed-0b87-49d2-9a2b-fa97d791877a@phytec.de>
Date: Wed, 2 Oct 2024 08:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 2/2] arm64: dts: ti:
 k3-am642-phyboard-electra-rdk: Fix bus-width property in MMC nodes
To: John Ma <jma@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <upstream@lists.phytec.de>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240926174404.3122100-1-jma@phytec.com>
 <20240926174404.3122100-2-jma@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240926174404.3122100-2-jma@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWyRpKBR3fHwz9pBpvbRCzW7D3HZDH/yDlW
	i2edTcwWyz/PZrd4Oesem8Wmx9dYLS7vmsNm8ebHWSaL/3t2sFt0v1O3+H/2A7sDt8emVZ1s
	HpuX1Hv0d7ewevy5+I7V4/iN7UwenzfJBbBFcdmkpOZklqUW6dslcGU8XPCEsWAhe8Wdtpls
	DYztbF2MnBwSAiYST/acZ+li5OIQEljCJPFw6zZmCOcOo8Sh28/ZQap4BWwkTh5azgRiswio
	SJzs38MIEReUODnzCQuILSogL3H/1gygeg4OYYEKiYuPAkHmiAhMZZRYt+0kE4jDLNDGKPFg
	QzfYaiGBRImdS36CNTMLiEvcejIfbAGbgLrEnQ3fWEFsTgEziUX75zJD1FhILH5zkB3ClpfY
	/nYOM8QceYkXl5azQLwjLzHt3GtmCDtU4sim1UwTGIVnIbl1FpJ1s5CMnYVk7AJGllWMQrmZ
	ydmpRZnZegUZlSWpyXopqZsYQREnwsC1g7FvjschRiYOxkOMEhzMSiK89w79TBPiTUmsrEot
	yo8vKs1JLT7EKM3BoiTOu7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAWPKOY1nvjdWd3t8UKmb8
	nThV72vErh5Jb86jN2TivXgr5ou/vlxztvZkXMNx7b+O/y4/f3jWrsdQvnfllellCvt+awju
	2Lr5pA7/uZDQp5LeOk4vE/bsn5eulnhE/13Q8kt3d4karjk1K/KzpP1k0SWHktm3xHLesDz9
	3e/CXA7Rc9HWektKLyixFGckGmoxFxUnAgBynIeupgIAAA==



Am 26.09.24 um 19:44 schrieb John Ma:
> The bus-width property was moved to k3-am64-main.dtsi.
> 
> See commit 0ae3113a46a6 ("arm64: dts: ti: k3-am6*: Fix bus-width property
> in MMC nodes")
> 
> Signed-off-by: John Ma <jma@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> index 60285d736e07..73b8df86b16b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> @@ -423,7 +423,6 @@ &sdhci1 {
>   	vmmc-supply = <&vcc_3v3_mmc>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_mmc1_pins_default>;
> -	bus-width = <4>;
>   	disable-wp;
>   	no-1-8-v;
>   };


