Return-Path: <linux-kernel+bounces-209911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A6903CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C935C1F23FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD1D17C7CB;
	Tue, 11 Jun 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="autcCY38"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46480178CCF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111534; cv=none; b=L16pSTEPheVsc4PW+rPxFdmgenMNicMmI5Jegk2PywbinEBPc7rD4Os7Pw3pf6TxtV4gpHC3My805rkNv9+1r0B1IYhPXULUHjh1ojzCvLejE0+cTSbZflQ/kKxmxYVBjD9fVGQeJHVz+jPQcyQ55ySprecVpbTDgU2C1OSaOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111534; c=relaxed/simple;
	bh=1uyVeCNwdm3i9R+X7AEUciEH3LQi9dhrZKghSZoyxC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WxP18pS3mT3Z3mPm595u2yCyHENLD3rZF2HWsMkQW7nwiseUOQd44v594tlBRBuHGbzLdjiu/jexKVB89c5jI4g9dsgzTrd91j7U7kzy3h6ETd0LWLhFBBhhvMS6peDLTeXKmkPaIU/8ircgvIvxGdoFnMoB0haKGPBZIkrf268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=autcCY38; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1718111528; x=1720703528;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1uyVeCNwdm3i9R+X7AEUciEH3LQi9dhrZKghSZoyxC8=;
	b=autcCY38H97S1LBqDZ3xhC8kq/YUV7TFGJqjn9+PQd+a5Z9uDyO7c7vE2dHrALku
	fK2VyTcMNyLMxtpEP+Cfz+wqaOM6+wtjzchbJZ6woOkrI05lXapMNL20bZD9gw/a
	f1isyGFKfxwR35GfDaKhet5Pl74qdWPaet6I+nVjwDo=;
X-AuditID: ac14000a-03e52700000021bc-0f-66684d283699
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CD.94.08636.82D48666; Tue, 11 Jun 2024 15:12:08 +0200 (CEST)
Received: from [10.0.0.19] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 11 Jun
 2024 15:12:03 +0200
Message-ID: <4e7dd467-20be-43ce-936d-200ede6d511b@phytec.de>
Date: Tue, 11 Jun 2024 15:11:59 +0200
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
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>, Wadim Egorov
	<w.egorov@phytec.de>
References: <20240528225137.3629698-1-nmorrisson@phytec.com>
 <4ac40139-eda0-4f6a-8bbe-99110605f91e@ti.com>
 <33084cb0-95f4-414d-b094-bf704376fd02@phytec.de>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <33084cb0-95f4-414d-b094-bf704376fd02@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWyRpKBR1fDNyPNYMcHA4s1e88xWcw/co7V
	Yvnn2ewWL2fdY7PY9Pgaq8XlXXPYLN78OMtk8aFxM5vF/z072C2636lb/D/7gd2B22PTqk42
	j81L6j36u1tYPf5cfMfqcfzGdiaPz5vkAtiiuGxSUnMyy1KL9O0SuDKenfnLXnBcvmL38vgG
	xvuSXYycHBICJhLru18xdjFycQgJLGGS6J8/B8q5xShxdt8tVpAqXgEbiQ3vbrCB2CwCqhJ9
	/1ezQcQFJU7OfMICYosKyEvcvzWDvYuRg0NYIE3icp8RyBwRgZ2MEpNuvGAFcZgFVjNKPJiy
	jB1iw3xGiVkTrjOBdDMLiEvcejIfzGYT0JK4s2UuM8gkTgFbiQ+TEyFKLCQWvznIDmHLSzRv
	nc0MYgsJKEjM3jaZEeIdeYlp514zQ9ihEkc2rWaawCg8C8mts5Bsm4Vk7CwkYxcwsqxiFMrN
	TM5OLcrM1ivIqCxJTdZLSd3ECIo3EQauHYx9czwOMTJxMB5ilOBgVhLhPROTnibEm5JYWZVa
	lB9fVJqTWnyIUZqDRUmcd3VHcKqQQHpiSWp2ampBahFMlomDU6qBsWfzr/meR3sqt030bLaY
	YPRi+47whjMPKvYnq4hfWL5/84dVP8Nk8gvfPtl7t/narfuV72LfuJevemCy4+85DrdNbzZK
	GUR5sNjbMOtp9E59svLhq7mXlnezfS52LHDV4YxVfDMta33M8lu32g3uebgdXZ/dV7V7l329
	oeet1zO2vdkn1LVmd5ASS3FGoqEWc1FxIgA2f7xBpQIAAA==

Hi Vignesh,

On 10.06.24 10:07, Wadim Egorov wrote:
> Add: Daniel Schultz
>
> Am 03.06.24 um 19:41 schrieb Vignesh Raghavendra:
>> Hi Nathan,
>>
>> On 29/05/24 04:21, Nathan Morrisson wrote:
>>> Add three overlays to disable the eth phy, rtc, and spi nor. These
>>> overlays will be used to disable device tree nodes for components
>>> that are optionally not populated.
>>>
>>> v2:
>>>    - Add build time tests in makefile
>>>
>>> Nathan Morrisson (4):
>>>    arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
>>
>>
>>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
>>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
>>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disabl spi nor
>>>
>>>   arch/arm64/boot/dts/ti/Makefile               | 17 +++++++++++++++++
>>>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      |  2 +-
>>>   .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 
>>> +++++++++++++++++++
>>>   .../dts/ti/k3-am6xx-phycore-disable-rtc.dtso  | 15 +++++++++++++++
>>>   .../ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
>>>   5 files changed, 67 insertions(+), 1 deletion(-)
>>
>>>   create mode 100644 
>>> arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
>>>   create mode 100644 
>>> arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
>>>   create mode 100644 
>>> arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
>>>
>>
>> I am not sure if this a common practice to have overlays to disable
>> missing components (at least I dont see such dtso in kernel). I would
>> like to see an what DT maintainers feel as such dtsos can explode in
>> numbers.
>>
>> Is this something that U-Boot can detect and fix up for the Linux DT?
>>
>> Unpopulated SPI flash and RTC should ideally not be an issue as drivers
>> would gracefully fail albeit with some sort of error msg.
>> Not so sure about Eth PHYs though.
>>
>> Also, Are these dtso's mutually exclusive? ie can SoM have SPI flash but
>> not RTC, have RTC and SPI Flash but no ETH PHY?

Let me explain a little bit why we would like to have those overlays 
upstream.

Our SOMs come with a so-called "option tree" to produce one product with 
different components. For example, our standard part name for the 
phyCORE-AM62x is PCM-071-5432DE11I.A0 and the option tree is located 
between PCM-071 and A0. In this particular tree, the fourth character 
defines the DDR size with 2GB. If we have a customer with less memory 
requirements, we can simply produce the 1GB variant (PCM-071-5431...) 
and lower the cost.

Luckily, we can read the TI SOC part number in u-boot and disable 
non-existing components like CPU cores, GPUs, etc. in the Linux 
device-tree. However, we still need to handle all modifiable parts on 
our SOMs. For the phyCORE-AM62x, this would be the DDR size, SPI-NOR 
size and flash type (Q/OSPI), and whether the RTC and Ethernet PHY are 
populated. The DDR size can be handled completely in SPL, but for 
everything else we need to modify our Linux device-tree. The easiest and 
cleanest way to do that is by applying overlays, which are located next 
to the device-tree. I'm not a fan of letting drivers fail to probe. 
Customers with extensive product verifications most likely need to 
disable those manually, which is against the idea of buying a 
fully-functional SOM. Alternatively, we need to hard-code fixups in our 
U-Boot which means some U-Boot/Linux combinations might not boot anymore 
or we maintain them in a Phytec repository and never archive fully 
upstream status for our products.

Regarding the number of overlays. We use those three plus an additional 
one, which we need to upstream too, for the AM62x, AM62Ax, and AM64x. 
The upcoming AM62P and AM67 require one additional overlay for an 
optional, second EEPROM. In total we need 5 overlays for 5 AM6 products.

Best Regards,
Daniel



