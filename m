Return-Path: <linux-kernel+bounces-207837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D83901CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6FC1F2113B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7C626CB;
	Mon, 10 Jun 2024 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="HxBPM3Vq"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449884D8BC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007771; cv=none; b=YJQVLU9pBW1sX17Nm9kDRBtUPqDjU74TAqDUua8XnXyRwyPlxnkWnnp9O5M6wnHLqVZ+MFJNnZmnBsq+xW8U/zZCQN3lPKGIr/KIDptj2TulNX4R+d1mXtjBhyiUBYrz/UOJf2/ocgBkIRY6x6RqiEhFUhb7SPTmCBaB5zMIMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007771; c=relaxed/simple;
	bh=pI21Ud12UwCRn2MFzxI2TOXHV2HzWH6YI5gOx+RbkII=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EGwFVo4AeHTaZrGGPdMWw04T1JM14twnrPq1QV4hmfLTQOF52h3pmeUfUgY5tC2J5kiOcZPIL9NK3cgjLiNo++MT+JuVkiFjYSyt6qQIXCNC4EojCpFtDxyKITqVOBeoZXBzlsGWHUMpOirbqXvGZCnQF9FpzjUxTavsnPwcx84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=HxBPM3Vq; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1718006843; x=1720598843;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pI21Ud12UwCRn2MFzxI2TOXHV2HzWH6YI5gOx+RbkII=;
	b=HxBPM3Vq0Bu+H0QFFW0j4YUcqYQ/v8HwIV6brCi1GR0kJSitC+zIeWb2lFtJwwqr
	6CI0EYcqrB8Hw3+RtDnNFQEE3iR3AZOjKXEpR1SRmbkXr72UYhGDIzXavr02qG26
	bvXfWFMw6qugeJPgscc5YPkDMgEkHDNpnGwQEq7/VKk=;
X-AuditID: ac14000a-03251700000021bc-e4-6666b43b80f6
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B1.6B.08636.B34B6666; Mon, 10 Jun 2024 10:07:23 +0200 (CEST)
Received: from [192.168.10.3] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 10:07:22 +0200
Message-ID: <33084cb0-95f4-414d-b094-bf704376fd02@phytec.de>
Date: Mon, 10 Jun 2024 10:07:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add overlays to disable optional hardware in
 k3-am6xx-phycore-som boards
To: Vignesh Raghavendra <vigneshr@ti.com>, Nathan Morrisson
	<nmorrisson@phytec.com>, <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, Daniel Schultz
	<D.Schultz@phytec.de>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240528225137.3629698-1-nmorrisson@phytec.com>
 <4ac40139-eda0-4f6a-8bbe-99110605f91e@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <4ac40139-eda0-4f6a-8bbe-99110605f91e@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWyRpKBR9d6S1qawbkWY4s1e88xWcw/co7V
	Yvnn2ewWL2fdY7PY9Pgaq8XlXXPYLN78OMtk8aFxM5vF/z072C2636lb/D/7gd2B22PTqk42
	j81L6j36u1tYPf5cfMfqcfzGdiaPz5vkAtiiuGxSUnMyy1KL9O0SuDLeT2hgLrjIXzFx8y62
	BsaDPF2MnBwSAiYSR+9MZ+pi5OIQEljCJNGy4xGUc5dR4vCal4wgVbwCNhIz7y4Dsjk4WARU
	Jc5cSIcIC0qcnPmEBcQWFZCXuH9rBjtIibBAmsTlPiOQMSICDxklFl/9ATaTWaCNUeLJwwPM
	IA1CAjkSzRNvgTUzC4hL3HoynwnEZhNQl7iz4RsriM0pYCWx/sVXJogaC4nFbw6yQ9jyEtvf
	zoGaIy/x4tJyFohv5CWmnXvNDGGHSmz9sp1pAqPwLCS3zkKybhaSsbOQjF3AyLKKUSg3Mzk7
	tSgzW68go7IkNVkvJXUTIyjeRBi4djD2zfE4xMjEwXiIUYKDWUmEVygjOU2INyWxsiq1KD++
	qDQntfgQozQHi5I47+qO4FQhgfTEktTs1NSC1CKYLBMHp1QDY7B87i97g6RTm38LmR/1YF0m
	VeVwUTjnUc8EC+8+njCrfYyyL02kuY5phBVaHT9T1CF0xmXfuzuek8rV/xy7coJLaYnOPWbz
	hx81WtNnzFppICCQMW2uSuXnu8rzNrz4v9EuR3Xbkv7P5dOcFhRmm7WuyrrEt23Ls1PCf5gj
	HnXlPtf2C1u4SImlOCPRUIu5qDgRAJHZ5p6lAgAA

Add: Daniel Schultz

Am 03.06.24 um 19:41 schrieb Vignesh Raghavendra:
> Hi Nathan,
> 
> On 29/05/24 04:21, Nathan Morrisson wrote:
>> Add three overlays to disable the eth phy, rtc, and spi nor. These
>> overlays will be used to disable device tree nodes for components
>> that are optionally not populated.
>>
>> v2:
>>    - Add build time tests in makefile
>>
>> Nathan Morrisson (4):
>>    arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
> 
> 
>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disabl spi nor
>>
>>   arch/arm64/boot/dts/ti/Makefile               | 17 +++++++++++++++++
>>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      |  2 +-
>>   .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
>>   .../dts/ti/k3-am6xx-phycore-disable-rtc.dtso  | 15 +++++++++++++++
>>   .../ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
>>   5 files changed, 67 insertions(+), 1 deletion(-)
> 
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
>>
> 
> I am not sure if this a common practice to have overlays to disable
> missing components (at least I dont see such dtso in kernel). I would
> like to see an what DT maintainers feel as such dtsos can explode in
> numbers.
> 
> Is this something that U-Boot can detect and fix up for the Linux DT?
> 
> Unpopulated SPI flash and RTC should ideally not be an issue as drivers
> would gracefully fail albeit with some sort of error msg.
> Not so sure about Eth PHYs though.
> 
> Also, Are these dtso's mutually exclusive? ie can SoM have SPI flash but
> not RTC, have RTC and SPI Flash but no ETH PHY?
> 

