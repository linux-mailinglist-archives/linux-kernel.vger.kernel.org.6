Return-Path: <linux-kernel+bounces-199525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16FC8D8821
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE151C20901
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40961137923;
	Mon,  3 Jun 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PJrzINqc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D0135A6F;
	Mon,  3 Jun 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436529; cv=none; b=X/EGjX+b327Mn/mXuqokKFf4+c+QXqKnBg5gBalxXbxlrUJaG/u5Q5ra4/HeCfX2QVnS8M/l7t2nkEmaR2lgybDS6+XjJoui1leFGnmL3bZ3tOoSyE/6t+chhgDD27wFzsj/0ZIufi0FQTl8Se2XJ0vrKMCRsu6/iy+jWoLWQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436529; c=relaxed/simple;
	bh=FTMHYBDXrMSnzSW1m3RkobvbHdA+rKpO/+FvnIJ+Qt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AWKO8JNzjQjmG6TvbQYOfJkB2LqKUDAp6S0OorJbYpcs6m1jdM+6jDRJPs8aKhUWsKTfT6ABWx5RblRFOq4Uo3HTNuFgiRIxvG8Um3xzrV7b+pJ8TgjwwkKIb+cDN+3pwbczL4uzj4GlL3FVxyK9NNT5yE1VzxJGzGbtH2kzWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PJrzINqc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 453HfsKw090374;
	Mon, 3 Jun 2024 12:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717436514;
	bh=TRuU8G9/d6lkp3hInz5RWXba11O8+BAQ5y7S3nHRwEw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PJrzINqcZ9Rdj/ryi7UrbPQqzzmZffuvavnkkk/PnSsSErwZfikiEhpuSmLlek7lq
	 dBP8JRq4FoevchYIgWbcsnxJsyIE/qbSEztaHvDl6FwEWkls4hBlILYfoqtaiERt6Q
	 H2rgG3+ORj5DUoQ1YfvMGQLKcSd9QFQ1hmwjYw3M=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 453HfsgA032152
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 12:41:54 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 12:41:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 12:41:54 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 453HfoOg069313;
	Mon, 3 Jun 2024 12:41:51 -0500
Message-ID: <4ac40139-eda0-4f6a-8bbe-99110605f91e@ti.com>
Date: Mon, 3 Jun 2024 23:11:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add overlays to disable optional hardware in
 k3-am6xx-phycore-som boards
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
References: <20240528225137.3629698-1-nmorrisson@phytec.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240528225137.3629698-1-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nathan,

On 29/05/24 04:21, Nathan Morrisson wrote:
> Add three overlays to disable the eth phy, rtc, and spi nor. These
> overlays will be used to disable device tree nodes for components
> that are optionally not populated.
> 
> v2:
>   - Add build time tests in makefile
> 
> Nathan Morrisson (4):
>   arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label


>   arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
>   arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
>   arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disabl spi nor
> 
>  arch/arm64/boot/dts/ti/Makefile               | 17 +++++++++++++++++
>  .../boot/dts/ti/k3-am64-phycore-som.dtsi      |  2 +-
>  .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
>  .../dts/ti/k3-am6xx-phycore-disable-rtc.dtso  | 15 +++++++++++++++
>  .../ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
>  5 files changed, 67 insertions(+), 1 deletion(-)

>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
> 

I am not sure if this a common practice to have overlays to disable
missing components (at least I dont see such dtso in kernel). I would
like to see an what DT maintainers feel as such dtsos can explode in
numbers.

Is this something that U-Boot can detect and fix up for the Linux DT?

Unpopulated SPI flash and RTC should ideally not be an issue as drivers
would gracefully fail albeit with some sort of error msg.
Not so sure about Eth PHYs though.

Also, Are these dtso's mutually exclusive? ie can SoM have SPI flash but
not RTC, have RTC and SPI Flash but no ETH PHY?

-- 
Regards
Vignesh

