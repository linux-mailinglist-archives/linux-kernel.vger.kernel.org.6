Return-Path: <linux-kernel+bounces-309001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823FA966501
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BE11C233E8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E11B3B37;
	Fri, 30 Aug 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uhlHyz73"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A21DA26;
	Fri, 30 Aug 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030537; cv=none; b=iSOV77PRqvgifXHy6zOG0GgNKFVG5c7xVYOVeMqPHEa0oT46vevdGWMf8pDTI3pO76kT2kcHa8LzoiK38ydxOIWCCsshE1La9M1MKVL4OzDUEe1BqsvWxRvI8xBDuTtwxqWN3HDzhsDkQcKyOO9lEz/JfSVajQeh8MJyPaEYFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030537; c=relaxed/simple;
	bh=dRTn44tqlK43XG4GNPrp/ZBSsVdPkPESatr6n0q8fAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JhMUCfo1KPmicscfahzh+PhTwz8ghtlNZVolSQODH6rboRHtxYXr7SPcqPJ9fV8p+n1hTQj8PEq6t989/NqpV7cMW+dyNIG0qhU1zBojDqVN39w7eLxIVjrZ5wrdGvCNrisLYZ/Atod2CXg3QXCHjgF+Co9iWHeEN5YFxE34GdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uhlHyz73; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UF8mI7038731;
	Fri, 30 Aug 2024 10:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725030528;
	bh=4h8MQU0Zt+0s2wbizjkuI4pJr2b6Rtl49Ga6qg7LuKc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uhlHyz73nkYGuQpqcKClj8obNe0Oa2WSflleiwdF3OhQB3SudeVMBM7LnoiBooY2T
	 s6vTy9oy/wiMq6sdzTsA7UCXhgyUwCci3AhgHpP6rujIKPeL7sO8fZNRxI3Kh0dZPe
	 bfmuEOAqYph7pKRd/qJXA2xNOL/o6g+z0osjKn4s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UF8mC1026740;
	Fri, 30 Aug 2024 10:08:48 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 10:08:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 10:08:47 -0500
Received: from [10.249.130.61] ([10.249.130.61])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UF8eOJ023313;
	Fri, 30 Aug 2024 10:08:41 -0500
Message-ID: <451abe2a-7568-43c7-8483-242a9919684d@ti.com>
Date: Fri, 30 Aug 2024 20:38:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: Update OSPI partitions
 offsets
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <u-kumar1@ti.com>,
        <p-mantena@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240830090702.220402-1-b-padhi@ti.com>
 <20240830092234.veog3e22te7qi3ao@dugout>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20240830092234.veog3e22te7qi3ao@dugout>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 30-08-2024 14:52, Nishanth Menon wrote:
> On 14:37-20240830, Beleswar Padhi wrote:
>> OSPI NOR flash was partitioned with a size of 1 MB for the initial
>> bootloader ("ospi.tiboot3"). On the AM69-SK board, boot failures were
>> sometimes observed when the initial bootloader size exceeded 512 KB. To
> Why does the boot fail when > 512MB?


It is a limitation by BOOT ROM where it can not bring up the initial 
bootloader when its size exceeds 512 KB in the DFU boot mode.

>
>> address this, the initial bootloader image has been optimized to be
>> smaller than 512 KB.
>>
>> Therefore, limit the first OSPI partition size to 512 KB and adjust the
>> remaining size across the subsequent partitions.
> I am NOT a fan of redoing flash partition organization of platforms that
> are already in production - all kinds of ecosystem messes happen as a
> result. Alternatively - give the 512K to u-boot tispl partition and
> leave all others as is - this will at least allow people's current env
> to be retained.


This sounds good to me. I will let Prasanth comment over this.

>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> index 1e36965a1403..641236918379 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> @@ -1241,27 +1241,27 @@ partitions {
>>   
>>   			partition@0 {
>>   				label = "ospi.tiboot3";
>> -				reg = <0x0 0x100000>;
>> +				reg = <0x0 0x80000>;
>>   			};
>>   
>> -			partition@100000 {
>> +			partition@80000 {
>>   				label = "ospi.tispl";
>> -				reg = <0x100000 0x200000>;
>> +				reg = <0x80000 0x200000>;
>>   			};
>>   
>> -			partition@300000 {
>> +			partition@280000 {
>>   				label = "ospi.u-boot";
>> -				reg = <0x300000 0x400000>;
>> +				reg = <0x280000 0x400000>;
>>   			};
>>   
>> -			partition@700000 {
>> +			partition@680000 {
>>   				label = "ospi.env";
>> -				reg = <0x700000 0x40000>;
>> +				reg = <0x680000 0x40000>;
>>   			};
>>   
>> -			partition@740000 {
>> +			partition@6c0000 {
>>   				label = "ospi.env.backup";
>> -				reg = <0x740000 0x40000>;
>> +				reg = <0x6c0000 0x40000>;
>>   			};
>>   
>>   			partition@800000 {
>> -- 
>> 2.34.1
>>

