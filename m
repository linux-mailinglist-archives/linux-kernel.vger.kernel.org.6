Return-Path: <linux-kernel+bounces-277331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5EC949F5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC785B21017
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE764197A97;
	Wed,  7 Aug 2024 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V7yuAw9q"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E1190694;
	Wed,  7 Aug 2024 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009716; cv=none; b=If/yZwrdPdopYCXM2EE6TBzOIDhTM69ejE7fsnBhH4RIBuFXJ5vy01cSzDpOMDJFvT8ajYOSpDyvxzwGM1kvcKdnDe7KpapZzqcenLQFP6944Ub51mhDidtbidMpdXwHGqwDwdSntHKVCIWPfNWmXHzfqC9/TYF2hFLnTLVOocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009716; c=relaxed/simple;
	bh=Lme3h3V4nz7h8Lv9TQzwhuctctrKEEQvirQRzNGSHBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WfZ62jJW2uqyLYtIVcsbHiwq/hsqzoFyNMoEMEZdI+P+fPQA4vU9a+mda/hwxFt8+itkMefVtAuvvKq11oBgqS/YkVK0iDlNyooGT8U7csuignpqc3pq6n4Zixe8kiZ4Y57RgwpvaZaiDVyOVNs4idgbZP4ZyQyIROJBTm8ORP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V7yuAw9q; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4775mScO115415;
	Wed, 7 Aug 2024 00:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723009708;
	bh=EN+C7VUG79TmgtUXkbb02Zjw5u8BCVWVVZrzM3q+R2M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=V7yuAw9qNtH+EhOGazAxcKUBULRfbo/N91RQuWZe1DMT4hX+8uWPrXMVunUPO84ih
	 pWkII+maO+w+tp3+oTstmdWn7bjOkVgVw/hLv2Y2X5ypORuEdfCO8UvxlGGYzgNQNG
	 PHO3y5xPPdaFu5JfKvPAGu7CbY5n26RP3L61ozkY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4775mSht023926
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 00:48:28 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 00:48:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 00:48:27 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4775mNl3047372;
	Wed, 7 Aug 2024 00:48:23 -0500
Message-ID: <99da73bf-87a1-4402-9008-3d9076074d14@ti.com>
Date: Wed, 7 Aug 2024 11:18:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-*
 properties
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aniket Limaye
	<a-limaye@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-1-9bc2eccb6952@ti.com>
 <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
 <20240806150700.uw4xdanjr4ypdvm3@rasping>
 <20240807052628.jclbmw4zs72jm6km@uda0497581>
 <8a910e2f-aaf2-40cd-8131-a1a2531a12c8@ti.com>
 <20240807054243.pvfgexgusahe7d4x@uda0497581>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240807054243.pvfgexgusahe7d4x@uda0497581>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 07/08/24 11:12, Manorit Chawdhry wrote:
> Hi Neha,
> 
> On 11:03-20240807, Neha Malcom Francis wrote:
>> Hi Manorit
>>
>> On 07/08/24 10:56, Manorit Chawdhry wrote:
>>> Hi Nishanth,
>>>
>>> On 10:07-20240806, Nishanth Menon wrote:
>>>> On 09:43-20240806, Andrew Davis wrote:
>>>>> On 7/30/24 4:53 AM, Manorit Chawdhry wrote:
>>>>>> Adds bootph-* properties to the leaf nodes to enable U-boot to
>>>>>> utilise them.
>>>>>
>>>>> U-Boot? Let's try to pretend like this is a generic property and
>>>>> just say "bootloader" :)
>>>>>> @@ -445,6 +446,7 @@ flash@0 {
>>>>>>     		cdns,tchsh-ns = <60>;
>>>>>>     		cdns,tslch-ns = <60>;
>>>>>>     		cdns,read-delay = <4>;
>>>>>> +		bootph-all;
>>>>
>>>> Here and elsewhere, follow:
>>>> 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
>>>
>>> Could you tell me what are you seeing wrong? The dts-coding-style that
>>> you shared doesn't tell a specific location for bootph-* properties so
>>> using the generic reasoning.
>>>
>>> "1. Most important properties start the node: compatible then bus addressing to
>>>      match unit address."
>>>
>>> This is the least important property considering Linux and hence the
>>> reasoning was that it should come in the last. Also, j722s and am62p
>>> follow the same convention so it was taken from there only.
>>>
>>
>> Not sure if this is what he meant, but bootph-* comes under standard/common
>> properties as per my understanding of the coding style. And status needs to
>> be at the very end if it's there (in this case it's not but just
>> mentioning).
> 
> I see status property being at the top of many nodes so I don't think
> it's even followed right now, with that reasoning, I don't think I can
> use that point for ordering the dt nodes. If it's under common nodes
> then also I think it's in the appropriate location considering that even
> in those properties it is the least important and should be coming in
> the last. If you see any problem with this node then please let me know
> in the ordering.
> 

Aren't cdns,-* vendor specific properties?

Also I understand that most DTS aren't following majority of the rules, but 
considering it was a review comment I assume they want a check on what goes in 
at least so I've mentioned what I think they're asking for.

> Regards,
> Manorit
> 
>>
>>> Regards,
>>> Manorit
>>>
>>>>
>>>>
>>>>>>     	};
>>>>>>     };
>>>>>>
>>>>
>>>> -- 
>>>> Regards,
>>>> Nishanth Menon
>>>> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
>>
>> -- 
>> Thanking You
>> Neha Malcom Francis

-- 
Thanking You
Neha Malcom Francis

