Return-Path: <linux-kernel+bounces-177713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98B58C438B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766E7286627
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668604C74;
	Mon, 13 May 2024 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="uMen/Hxk"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4904A1C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612150; cv=none; b=gW5DowoxCuuTh6cCWLb3AnvRaqecLJCnT1Ww+oOYo5HO004nVGyT8DvEPrTVtB4L0ygEeJreVlUHotZHKQYAjDj+jZffkqNfxsSJhibY7TDi0u12lpplSIv8dh3C9u0TIEiQKV461GKiXDt/v3zCU6+/DC2FcoWgUrBwmP+tkvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612150; c=relaxed/simple;
	bh=3cZav8ejTt13pLhtSbloErbGOfDsyxXvZLt/W21i3BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JE0lzbLnS9hbFg9o380htLfgFuT7tBqUIqrFksfMoxYLPe55qXQdx0lYY6sN4usdbGAFUGHHwlYI8Nf4RzGJ6UZjvcN+QbKUC0e5EgGoVzizLaD6C0UttVQZBBe1fIeI76bbGB5nn03nsLLZWITSzJaDTPyHCr9LMfoE3wog9Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=uMen/Hxk; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1715612136; x=1718204136;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3cZav8ejTt13pLhtSbloErbGOfDsyxXvZLt/W21i3BI=;
	b=uMen/HxkXlRKMB3RFKWTE4fjXJ8npTX4+Arb/TxQGlbabSH+MrfUIaueaWFFU+Z1
	rSniryb0Kd8TSmKoYlUPvV76btvsK2cKviAFl2YTmmCUXrE1EZigYVkPNdHdXvNR
	llSslCoSjsoEY4433FE+OSXFvR/enkLxesShzlaokNw=;
X-AuditID: ac14000a-fadff7000000290d-91-664229e8634b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F5.BB.10509.8E922466; Mon, 13 May 2024 16:55:36 +0200 (CEST)
Received: from [192.168.10.3] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 13 May
 2024 16:55:34 +0200
Message-ID: <9a3b5af5-7370-4bc4-9529-48f9fb4b1c5a@phytec.de>
Date: Mon, 13 May 2024 16:55:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to
 disable eth phy
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240502230829.1983678-1-nmorrisson@phytec.com>
 <20240502230829.1983678-3-nmorrisson@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240502230829.1983678-3-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWyRpKBR/eFplOaQdtJFYs1e88xWcw/co7V
	Yvnn2ewWL2fdY7PY9Pgaq8XlXXPYLN78OMtk8aFxM5vF/z072C2636lb/D/7gd2B22PTqk42
	j81L6j36u1tYPf5cfMfqcfzGdiaPz5vkAtiiuGxSUnMyy1KL9O0SuDLe7FzLWHCBv+L29Pks
	DYxtvF2MnBwSAiYSfdPmMHYxcnEICSxhkpgx9R6Uc5dRovvUZGaQKl4BG4l9Jw6D2SwCqhIz
	/u2CigtKnJz5hAXEFhWQl7h/awY7iC0sEC/xv7mRHWSQiMBSRonHq3YwgTjMAm2MEk8eHgDr
	FhLIl2hYP4sNxGYWEJe49WQ+E4jNJqAucWfDN1YQm1PAVqJt5xRGiBoLicVvDrJD2PIS29/O
	gZojL/Hi0nIWiH/kJaade80MYYdKHNm0mmkCo/AsJMfOQrJuFpKxs5CMXcDIsopRKDczOTu1
	KDNbryCjsiQ1WS8ldRMjKOZEGLh2MPbN8TjEyMTBeIhRgoNZSYTXodA+TYg3JbGyKrUoP76o
	NCe1+BCjNAeLkjjv6o7gVCGB9MSS1OzU1ILUIpgsEwenVAOjIOe8M3G8rBcXrp199d8MXu7N
	Fvybd+ybdb4zu+D9ztIFk5q8b2wrelq855V6+4knnxp99WIrvZR4jT/rHKxUZzuX8/rgG7Pr
	4ZXasxbIref+nP/to/cn9yPbNoWsOjKRsd67aofHsv9FKjVPFdkmreSzLXyqnnX8a9uU63Hh
	lU+3Xbf/LpsUocRSnJFoqMVcVJwIAKe84UenAgAA

Hi Nathan,

Am 03.05.24 um 01:08 schrieb Nathan Morrisson:
> Add an overlay to disable the eth phy for all am6xx-phycore-som
> boards.
> 
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |  3 +++
>   .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
>   2 files changed, 22 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 9a722c2473fb..030c47b2d7de 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -53,6 +53,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
>   
> +# Common overlays for the phyCORE-AM6* family of boards
> +dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-eth-phy.dtbo
> +

Don't you want to add the entries for build time tests/CONFIG_OF_ALL_DTBS?

Regards,
Wadim

>   # Boards with AM65x SoC
>   k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
>   	k3-am654-base-board-rocktech-rk101-panel.dtbo \
> diff --git a/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
> new file mode 100644
> index 000000000000..356c82bbe143
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2023 PHYTEC America, LLC
> + * Author: Garrett Giordano <ggiordano@phytec.com>
> + *
> + * Copyright (C) 2024 PHYTEC America, LLC
> + * Author: Nathan Morrisson <nmorrisson@phytec.com>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&cpsw3g_phy1 {
> +	status = "disabled";
> +};
> +
> +&cpsw_port1 {
> +	status = "disabled";
> +};

