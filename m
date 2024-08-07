Return-Path: <linux-kernel+bounces-277317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E96949F32
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23472880F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8915192B97;
	Wed,  7 Aug 2024 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XGonyJ6X"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDB1922CD;
	Wed,  7 Aug 2024 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008824; cv=none; b=HKkYHIMs32gLt/cism0IWd5bYjSCY36165xxXIXbkIq2y1dWZNiM1RmIPP4eHyFpUbq/JkF7+VEdhp9enHDT+zHt9fLbSt6JB0Lv/IbMypr54lKWk/bg0M/cOH3nQLm//KfRzqEpcYTUl1+r131/qH8+jKIPn7xl3Ct3JvygNOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008824; c=relaxed/simple;
	bh=8cqCOcubney2ExlB6qalaPiCIXXl+Hi9oZ/IGf2LFH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nh0vawCxtzlNuWwyjx3vbFC1Z0114HkGNjyvgfaLZX6ZP2R8kfbQ2F1KOVaQ0hGfI0t6S9psbtyUXEijERSLA5H0CRXJifGTdPxHxO/UpwT7TNVbr8Zli5doT2i6Gm/YbWUYlkp2VeRF7T6r5cqkg8kPkEgBGGFXO9sUAonG2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XGonyJ6X; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4775XZQp021692;
	Wed, 7 Aug 2024 00:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723008815;
	bh=UqP/Mn+qe0l/Bk4LShUp7zWxlQ3sZIa6pTWZ82c1mxo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XGonyJ6Xoh6EXWge3+DqcXhcqiuCvQU2YZ34so9fbjuQXrVp2h8MPGm01/NWlv5sJ
	 VPJE7Kta9TUG621B4SoGdqynP4aBGzwOd2tSXi91MbcX6mIm8Fel097DoK6Uv9MuLv
	 LZ1BZ2TtxhzdimvKBEkBXNkHaFjfo09iLHrj1MJE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4775XZMP127221
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 00:33:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 00:33:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 00:33:34 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4775XUt2024626;
	Wed, 7 Aug 2024 00:33:30 -0500
Message-ID: <8a910e2f-aaf2-40cd-8131-a1a2531a12c8@ti.com>
Date: Wed, 7 Aug 2024 11:03:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-*
 properties
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>
CC: Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aniket Limaye <a-limaye@ti.com>,
        Udit Kumar
	<u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-1-9bc2eccb6952@ti.com>
 <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
 <20240806150700.uw4xdanjr4ypdvm3@rasping>
 <20240807052628.jclbmw4zs72jm6km@uda0497581>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240807052628.jclbmw4zs72jm6km@uda0497581>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Manorit

On 07/08/24 10:56, Manorit Chawdhry wrote:
> Hi Nishanth,
> 
> On 10:07-20240806, Nishanth Menon wrote:
>> On 09:43-20240806, Andrew Davis wrote:
>>> On 7/30/24 4:53 AM, Manorit Chawdhry wrote:
>>>> Adds bootph-* properties to the leaf nodes to enable U-boot to
>>>> utilise them.
>>>
>>> U-Boot? Let's try to pretend like this is a generic property and
>>> just say "bootloader" :)
>>>> @@ -445,6 +446,7 @@ flash@0 {
>>>>    		cdns,tchsh-ns = <60>;
>>>>    		cdns,tslch-ns = <60>;
>>>>    		cdns,read-delay = <4>;
>>>> +		bootph-all;
>>
>> Here and elsewhere, follow:
>> 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
> 
> Could you tell me what are you seeing wrong? The dts-coding-style that
> you shared doesn't tell a specific location for bootph-* properties so
> using the generic reasoning.
> 
> "1. Most important properties start the node: compatible then bus addressing to
>     match unit address."
> 
> This is the least important property considering Linux and hence the
> reasoning was that it should come in the last. Also, j722s and am62p
> follow the same convention so it was taken from there only.
> 

Not sure if this is what he meant, but bootph-* comes under standard/common 
properties as per my understanding of the coding style. And status needs to be 
at the very end if it's there (in this case it's not but just mentioning).

> Regards,
> Manorit
> 
>>
>>
>>>>    	};
>>>>    };
>>>>
>>
>> -- 
>> Regards,
>> Nishanth Menon
>> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

-- 
Thanking You
Neha Malcom Francis

