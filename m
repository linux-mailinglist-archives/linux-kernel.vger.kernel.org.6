Return-Path: <linux-kernel+bounces-306156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ADC963A07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180541C226F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E43148FF7;
	Thu, 29 Aug 2024 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="gr9Oru55"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E38A92D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910621; cv=none; b=HYN+6yi9FquvSC2eL80r2ljn3eHp4JzU0QgRqrw4KWpYx+OZ6GKQcYobvrc+lhDJ7Pg7ZKUtsEDm+oBDDdKqwHblSLVAeG4Hi/3s47x9y5Hri0JueC6eTQWL77Ey/oCvG5bKHYq0KSACHWAM68srU/NWRkzsa1AZRD67f7+PEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910621; c=relaxed/simple;
	bh=wdBzlHPzqbQqgzcrw6a0vj9ow8E9XI7yoBVOFCltyaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tsq9TAgKgs+q8yRqK08837diKdyu4OVcEVwkXHIpPIW9RgY8Vdss0dmBuilKspjX5GJuyJe9MsxwAe6KR0oNv3wXxeyJRdv8Ew88IolYZc0silgsm0cLxhXaEojJOd3k7gtgQfMCN4cvMMM+JQ4ZkTI/VagmrRA8wY2W7Is3Q8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=gr9Oru55; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724910607; x=1727502607;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wdBzlHPzqbQqgzcrw6a0vj9ow8E9XI7yoBVOFCltyaU=;
	b=gr9Oru55Ya8fIOEFTJWgUwzKTqZam7nORIKE3fTzALaiTx0pAKu65g1vzQoJqCg5
	mNKhf6TdxESteR7fMWLpVclafPuHc55yRjAMrmBXl2ghL0yWMeOVv3Bi+ZeDdMPF
	+DBqbTnjhNLy2Rm2Wjl1Pfz8PYqAHuVHSZvo944m3p4=;
X-AuditID: ac14000a-03e52700000021bc-3d-66d00c0f9590
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D9.1B.08636.F0C00D66; Thu, 29 Aug 2024 07:50:07 +0200 (CEST)
Received: from [10.0.0.19] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 29 Aug
 2024 07:50:02 +0200
Message-ID: <2d454d61-6f17-4c31-9d03-b065489b26c9@phytec.de>
Date: Thu, 29 Aug 2024 07:49:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64* Disable ethernet by default
 at SoC level
To: Logan Bristol <logan.bristol@utexas.edu>
CC: Josua Mayer <josua@solid-run.com>, Wadim Egorov <w.egorov@phytec.de>,
	<linux@ew.tq-group.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
References: <20240809135753.1186-1-logan.bristol@utexas.edu>
 <4e884c6c-ec82-4229-a2a4-55da66cc284f@phytec.de>
 <6fa4f5e5-7f7b-495a-a95a-82d7b105d2d7@utexas.edu>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <6fa4f5e5-7f7b-495a-a95a-82d7b105d2d7@utexas.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWyRpKBR5ef50KawaxnmhZr9p5jsph/5Byr
	xfLJC9gtXs66x2ax6fE1VovLu+awWXxdd4bV4k/3ViaLNz/OMln8P/uB3YHL48WEf0wem1Z1
	snlsXlLv8a/1MbPH8RvbmTza9gV6fN4kF8AexWWTkpqTWZZapG+XwJXxddME9oLZChXvJ8xh
	b2DcKN3FyMkhIWAi8W/advYuRi4OIYElTBIrXl2Fcm4xSuz9vZsdpIpXwEbi05cvTCA2i4Cq
	xKfbT5gh4oISJ2c+YQGxRQXkJe7fmgFWLywQLXFz0jmwGhEBHYmnWzvAhjILPGCSmPt6BtSG
	xYwSa5r+sIFUMQuIS9x6Mh9sA5uAlsSdLXPBujkF7CQOXr7PClFjIbH4zUF2CFteonnrbLAa
	IQEFidnbJjNC/CMvMe3ca2YIO1TiyKbVTBMYhWchOXYWknWzkIydhWTsAkaWVYxCuZnJ2alF
	mdl6BRmVJanJeimpmxhBMSfCwLWDsW+OxyFGJg7GQ4wSHMxKIrwnjp9NE+JNSaysSi3Kjy8q
	zUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1CCbLxMEp1cDom3dasi3/3jT/lHl75H8Ff6ve
	6eq1rfBO5o97US0n//RO/WsneUZAPjtqxtPzZVtaz170fpKVs2Zms47r/Nkts5r8ApMKmRU7
	/jwXU1hxcd858wX6tnv3hzYbzWV4/fHnpbm3dzDHaIveazoZ82FV89WPtU0HNpbfXS2YtO0r
	/1eOzwt5alIuK7EUZyQaajEXFScCABb3uGenAgAA


On 26.08.24 23:17, Logan Bristol wrote:
> Hi Daniel,
>
> On 8/26/2024 12:29 AM, Daniel Schultz wrote:
>> Hey Logan,
>>
>> my feedback is similar to Josua's.
>>
>> On 09.08.24 15:57, Logan Bristol wrote:
>>> External interfaces should be disabled at the SoC DTSI level, since
>>> the node is incomplete. Disable Ethernet switch and ports in SoC DTSI
>>> and enable them in the board DTS. If the board DTS includes a SoM DTSI
>>> that completes the node description, enable the Ethernet switch and 
>>> ports
>>> in SoM DTSI.
>>>
>>> Reflect this change in SoM DTSIs by removing ethernet port disable.
>>>
>>> Signed-off-by: Logan Bristol <logan.bristol@utexas.edu>
>>> ---
>>> Changes since v1:
>>> - Enabled cpsw3g and cpsw_port1 in SoM DTSI instead of board DTS
>>> if board DTS included SoM DTSI
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 3 +++
>>>   arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi        | 6 ++----
>>>   arch/arm64/boot/dts/ti/k3-am642-evm.dts                | 3 +++
>>>   arch/arm64/boot/dts/ti/k3-am642-sk.dts                 | 3 +++
>>>   arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi            | 6 ++----
>>>   arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts | 6 ++----
>>>   6 files changed, 15 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/ 
>>> boot/dts/ti/k3-am64-main.dtsi
>>> index f8370dd03350..69c5af58b727 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>>> @@ -677,6 +677,7 @@ cpsw3g: ethernet@8000000 {
>>>           assigned-clock-parents = <&k3_clks 13 9>;
>>>           clock-names = "fck";
>>>           power-domains = <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
>>> +        status = "disabled";
>>>           dmas = <&main_pktdma 0xC500 15>,
>>>                  <&main_pktdma 0xC501 15>,
>>> @@ -701,6 +702,7 @@ cpsw_port1: port@1 {
>>>                   phys = <&phy_gmii_sel 1>;
>>>                   mac-address = [00 00 00 00 00 00];
>>>                   ti,syscon-efuse = <&main_conf 0x200>;
>>> +                status = "disabled";
>>>               };
>>>               cpsw_port2: port@2 {
>>> @@ -709,6 +711,7 @@ cpsw_port2: port@2 {
>>>                   label = "port2";
>>>                   phys = <&phy_gmii_sel 2>;
>>>                   mac-address = [00 00 00 00 00 00];
>>> +                status = "disabled";
>>>               };
>>>           };
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/ 
>>> arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>>> index ea7c58fb67e2..6bece2fb4e95 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>>> @@ -185,6 +185,7 @@ AM64X_IOPAD(0x0278, PIN_INPUT, 7)    /* (C19) 
>>> EXTINTn.GPIO1_70 */
>>>   &cpsw3g {
>>>       pinctrl-names = "default";
>>>       pinctrl-0 = <&cpsw_rgmii1_pins_default>;
>>> +    status = "okay";
>>>   };
>>>   &cpsw3g_mdio {
>>> @@ -208,10 +209,7 @@ cpsw3g_phy1: ethernet-phy@1 {
>>>   &cpsw_port1 {
>>>       phy-mode = "rgmii-rxid";
>>>       phy-handle = <&cpsw3g_phy1>;
>> The connected phy is located on the SOM and should be enabled by 
>> default.
>>> -};
>>> -
>>> -&cpsw_port2 {
>>> -    status = "disabled";
>>> +    status = "okay";
>>>   };
>>
>> This port is routed to the carrier-board. Please drop this node.
>
> I replied similarly to Josua's comments, but if cpsw_port1 is to be 
> enabled and cpsw_port2 should be dropped from this DTSI, isn't that 
> shown in this diff?

Ah, sorry. I did the same mistake :)

Acked-by: Daniel Schultz <d.schultz@phytec.de>

>
> Thank you,
> Logan Bristol
>

