Return-Path: <linux-kernel+bounces-217693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9CE90B30B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA5E1F26C56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1815381E;
	Mon, 17 Jun 2024 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="AugFae0a"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35ED4DA08
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633055; cv=none; b=kybvRXIHWcrM2w6QjMiNJePLty3CqLfEx1gyug0tpyem5EvX+K8HQeTIeXxyMWFUPI0rGViiWN8nHcvqHpsTeZBvRHVP+nmK1mLqnOc4xjvQTQcdp4CMnaaIt+OrkyaleR+xP/GXkrQr+3Tghmz9sRMV/ZQwbXDuVJHjXVzLhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633055; c=relaxed/simple;
	bh=MjD4ZE+6naOtLtBeDZvuCR1SEEnsovy83BQVgEomThQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JgIgZ9nLgMaPhe4a5MrPp+jm/Hn1ZB13ekvjXKkv8Ts3L194wUAsMTmPboWOfDaYtHeUYt0XDvpW6r++JJdNSWOai6ZnLE5OBzWZzRI2qNqv3rxCnP0sRavEjwr/EuzWr+bCjFYZmZI+IOdv2IRaext0cxQYvcnBZRYNn2ZGeik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=AugFae0a; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1718633040; x=1721225040;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MjD4ZE+6naOtLtBeDZvuCR1SEEnsovy83BQVgEomThQ=;
	b=AugFae0a9Z7Lff8h/Jszm/djqaIRVdvaiYEVJfZxNVTC7rIZ0eURrB/4ma/WfMAY
	ZOzR+ovjZGgcx1U8HiE8SCmYkAgSdBnCCSA/64gu6T7QEBQtErUrF15wGj9rnJc2
	R6wcFBqDcBz/bttROBVBNP+P04jUZkxtJt2qZ00Zg0I=;
X-AuditID: ac14000a-03e52700000021bc-7f-66704250efd7
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F1.D1.08636.05240766; Mon, 17 Jun 2024 16:04:00 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 17 Jun
 2024 16:03:59 +0200
Message-ID: <fefe9e73-ee4d-4d7a-804b-baf8398a4893@phytec.de>
Date: Mon, 17 Jun 2024 16:03:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add overlays to disable optional hardware in
 k3-am6xx-phycore-som boards
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240613230759.1984966-1-nmorrisson@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240613230759.1984966-1-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWyRpKBRzfAqSDNYPNcWYs1e88xWcw/co7V
	Yvnn2ewWL2fdY7PY9Pgaq8XlXXPYLN78OMtk8aFxM5vF/z072C2636lb/D/7gd2B22PTqk42
	j81L6j36u1tYPf5cfMfqcfzGdiaPz5vkAtiiuGxSUnMyy1KL9O0SuDLeNm1gLfjLXdH64gNL
	A+M7zi5GTg4JAROJ9zubWLoYuTiEBJYwSZxe/ocVwrnLKLHt5E4WkCpeARuJ/482s4HYLAKq
	EvsWP2OEiAtKnJz5BKxGVEBe4v6tGewgtrBAmsTxfdPZQQaJCCxllHi8agcTiMMs0MYo8eTh
	AeYuRg6gFTYS/c8kQBqYBcQlbj2ZzwRiswmoS9zZ8I0VpIRTwFZixfp6iBILicVvDrJD2PIS
	29/OYQaxhYDsF5eWs0B8Iy8x7dxrZgg7VGLrl+1MExiFZyE5dRaSbbOQjJ2FZOwCRpZVjEK5
	mcnZqUWZ2XoFGZUlqcl6KambGEHxJsLAtYOxb47HIUYmDsZDjBIczEoivE7T8tKEeFMSK6tS
	i/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2CyTJxcEo1MGpJe7EIrL+5szxnTqW9
	jOUdjbmdexasKeu9+6Jo0httG/HWSReT9m7ukblUtepj5sJrX9+auZ5NitFtst7i+t02sC6l
	QbyVv2KihEPgGfZv2rvnfntnUpLsu10rKO2zlcnMj5PNFslqHzYSizjEke6QdOSi87wO0ZIg
	qc3Lb1XwSIip5LqWKbEUZyQaajEXFScCAF+OMOWlAgAA



Am 14.06.24 um 01:07 schrieb Nathan Morrisson:
> Add three overlays to disable the eth phy, rtc, and spi nor. These
> overlays will be used to disable device tree nodes for components
> that are optionally not populated.
> 
> v3:
>    - Explain the logic behind adding the overlays in commit messages

Looks like you forgot to pick up my Reviewed-by

https://lore.kernel.org/linux-arm-kernel/20240528225137.3629698-4-nmorrisson@phytec.com/T/#me4ddd3a713c4ff65e36fad333d59979ef1a92e8f


> 
> v2:
>    - Add build time tests in makefile
> 
> Nathan Morrisson (4):
>    arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable spi nor
> 
>   arch/arm64/boot/dts/ti/Makefile               | 17 +++++++++++++++++
>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      |  2 +-
>   .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
>   .../dts/ti/k3-am6xx-phycore-disable-rtc.dtso  | 15 +++++++++++++++
>   .../ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
>   5 files changed, 67 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
> 

