Return-Path: <linux-kernel+bounces-309226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95A39667C1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DEA282F38
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986261BB6B9;
	Fri, 30 Aug 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zi9qqszB"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634B1BAEFB;
	Fri, 30 Aug 2024 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038062; cv=none; b=IoNOt3HE9AAiqZYavALREe8BLeIg7yL8Zvh0B2rfMhoUcNl9hNU4OBhRs4EiCXQ+5Zmx5c5Vhks0PfB/7e0pxKEfJqDaOLfsWw4eB+ZlGslNCKAc5sK9ku0/cVfutJ/Rku2bqhz3NI7OCUZGqFC0nuxaFIenGdJIMLkz9V0VIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038062; c=relaxed/simple;
	bh=bNov/hvird6GkWne9y1j1TAje8MHmHRpOmZDPjjjEWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tPMgqTFtX02sqQKbZ6SsIwpqfFjXGBwCnPtHCJ89LXHohvfXhko1fRrBb7k3E7eQ/N85RIbt/cKL8cu8kXYdSdCPybqUqphQu79irvHzv4qcDNyAb7HvAucxeyRVQbc91OWNHsAygG2XkOE/13B2ix4IllgNm3KKFIxN9RzkVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zi9qqszB; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UCJ7gX000352;
	Fri, 30 Aug 2024 19:14:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	dn5dQsELpWmxinQFESjPspMgz2jixe1Aiq8SsjC0ziM=; b=zi9qqszBsWYtNPTZ
	U/IE9FEOg0WOPHlBwrvHMs5DlYcwoeqdoIGi200KGxMTNjL2W3CBBq2hFAEyyk8R
	eR3kdONLI3+rrigKLxLTAkbXm1bV3MDZ3FRd/4ZEB+5FAXuLB2GMNaOL+b1y3aUk
	ntHa5IbvuBBm0Xs0scUU/tuNcK5HhnLJkYfazvf+e9x6vd1vgFs1Y1jeeknNUWxg
	iuTgIxheM4T2UuSA1l/yrumk3MJfqcXJKCjyWsjGaYcEDlOctIQ1kR2usIOlhu2h
	DebYpxtHvyrNohLYPSi3AYZVM01PobmicEY1q2jmDUU26YWJ88e6tJUR71eGVPP6
	B9+KDw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41b14uku9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 19:13:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 386B840048;
	Fri, 30 Aug 2024 19:13:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0583925E20B;
	Fri, 30 Aug 2024 19:11:52 +0200 (CEST)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 30 Aug
 2024 19:11:51 +0200
Message-ID: <4ae91d0f-e37b-4325-a5aa-8448b95db431@foss.st.com>
Date: Fri, 30 Aug 2024 19:11:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
To: Conor Dooley <conor@kernel.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>
References: <20240828143452.1407532-1-christian.bruel@foss.st.com>
 <20240828143452.1407532-2-christian.bruel@foss.st.com>
 <20240828-handsfree-overarch-cd1af26cb0c5@spud>
 <005a2f7d-ab46-46c8-a0cc-b343685caf7c@foss.st.com>
 <20240829-manifesto-tray-65443d6e7e6e@spud>
 <777a92d9-ed52-4fa1-b235-e3a4a6321634@foss.st.com>
 <20240830-jumbo-wriggly-39c84108371b@spud>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20240830-jumbo-wriggly-39c84108371b@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01


On 8/30/24 16:55, Conor Dooley wrote:
> On Fri, Aug 30, 2024 at 02:53:15PM +0200, Christian Bruel wrote:
>> On 8/29/24 18:44, Conor Dooley wrote:
>>> On Thu, Aug 29, 2024 at 01:06:53PM +0200, Christian Bruel wrote:
>>>> On 8/28/24 18:11, Conor Dooley wrote:
>>>>> On Wed, Aug 28, 2024 at 04:34:48PM +0200, Christian Bruel wrote:
>>>>>> +  st,syscfg:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>>> +    description: Phandle to the SYSCON entry required for configuring PCIe
>>>>>> +      or USB3.
>>>>> Why is a phandle required for this lookup, rather than doing it by
>>>>> compatible?
>>>> the phandle is used to select the sysconf SoC configuration register
>>>> depending on the PCIe/USB3 mode (selected by xlate function), so it's not
>>>> like a lookup here.
>>> If "syscon_regmap_lookup_by_phandle()" is not a lookup, then I do not
>>> know what is. An example justification for it would be that there are
>>> multiple combophys on the same soc, each using a different sysconf
>>> region. Your dts suggests that is not the case though, since you have
>>> st,syscfg = <&syscfg>; in it, rather than st,syscfg = <&syscfg0>;.
>> I didn't get your suggestion earlier to use "syscon_regmap_lookup_by_compatible()".
>>
>> We have several other syscon in the other. That's why we choose a direct syscfg phandle
> In the other what? SoCs?
>
> Way I see it, if you're going to support different socs in the same
> driver, it's almost a certainty that the offsets within a syscon that
> particular features lie at are going to change between socs, so even if
> you have a phandle you're going to need to have the offsets in your
> match data. And if you're going to have offsets in match data, you may
> as well have the compatibles for the syscon in match data too.
> If the layout of the syscon hasn't changed between devices, then you
> should have a fallback compatible for the syscon too, making
> syscon_regmap_lookup_by_compatible() function without changes to the
> driver.
>
> If you do have multiple syscons, but they do different things, they
> should have different compatibles, so having multiple syscons doesn't
> justify using a property for this either in and of itself. If you have
> multiple syscons with the same layout (and therefore the same
> compatible) then a phandle makes sense, but if that's the case then you
> almost certainly have multiple combophys too! Otherwise, if you have one
> syscon, but the controls for more than one combophy are in it, then
> having a phandle _with an offset_ makes sense.
>
> If you know there are other SoCs with more than one combo phy, do they
> use different syscons, or is the same syscon used for more than one
> combophy?

we have other syscon for other subsystem in the same SoC, but I not the same layout

We indeed have a different compatible for the syscfg top (not the COMBOPHY registers), I can use
"syscon_regmap_lookup_by_compatible(st,stm32mp25-syscfg)" effectively

one justification I had in mind for using a phandle is that we can use an argument to the
COMBOPHY registers offset in the syscfg. Having this DT flexibility to adjust the offset
for new SoC revisions using the same driver looked like a nice to have.
For the time being the lookup_by_compatible pointing the syscfg syscon is OK

thanks for the clarification.

Christian


