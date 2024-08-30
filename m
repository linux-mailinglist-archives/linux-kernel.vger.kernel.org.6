Return-Path: <linux-kernel+bounces-309006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4BB966513
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51621281552
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892BE1A4B6C;
	Fri, 30 Aug 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Je/UMUO3"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755414D8AD;
	Fri, 30 Aug 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030967; cv=none; b=GssqGcEwLIEMkUWtNJcnR9feFGPAq26eD+CUdz0Yb0fp9n1XMZZM6GpzkszQrdYMgwiTQaEmUi637WPhrtB0pFnnvbkGaYgwjKAz04iDU9/c6ExLmfw1orOeWX6nD6biQiJg3jSSgZC4aXM0loxrUBRTV8K/XWexaA6HDOf7KV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030967; c=relaxed/simple;
	bh=sJRMMNi5vddokhNOECAwcIr8R9HGz84PzxRZsYhODqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oRs3Z3RtTPwGGecpV9ZuWldtpsHNqFkEJ3Eem7eS7USdPFuomQjkhqRwvI73mdDwi4T8wkK3gRYQ9cUkiLdPF1yRYR8yNDwcB8OV2FPjxZdK3se3GrgqZEU8rNvjew7XINm4qqbHHXwsD5/8fKwNIKmYAaLyYxc4SSgxzKxlw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Je/UMUO3; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UFFugT041417;
	Fri, 30 Aug 2024 10:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725030956;
	bh=V9lc16nTRv8sWHDVPTyvMu8NZ45iDDhmXlHbYEPXSUQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Je/UMUO3qpV4rw1fGNnP/hDRKOPkWVW+iok5ICLfqx4muKkP3GkrTEkU9nUrs6/Nl
	 HENMGOL9cI5O0cKQ4ps4kH3/ZX+Ed3UqwcYTacdbSO+DzG7mcBQ74e5RSHaVHaVst0
	 q8pqD4eXempFqX03rIesFVFfgAylFyxnyVDJ/Xc4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UFFuda030671;
	Fri, 30 Aug 2024 10:15:56 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 10:15:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 10:15:56 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UFFqW1041782;
	Fri, 30 Aug 2024 10:15:53 -0500
Message-ID: <bf111978-a70e-45d4-b36a-4f0126ebad54@ti.com>
Date: Fri, 30 Aug 2024 20:45:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: Update OSPI partitions
 offsets
To: Nishanth Menon <nm@ti.com>, Beleswar Padhi <b-padhi@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p-mantena@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
References: <20240830090702.220402-1-b-padhi@ti.com>
 <20240830092234.veog3e22te7qi3ao@dugout>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240830092234.veog3e22te7qi3ao@dugout>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 8/30/2024 2:52 PM, Nishanth Menon wrote:
> On 14:37-20240830, Beleswar Padhi wrote:
>> OSPI NOR flash was partitioned with a size of 1 MB for the initial
>> bootloader ("ospi.tiboot3"). On the AM69-SK board, boot failures were
>> sometimes observed when the initial bootloader size exceeded 512 KB. To
> Why does the boot fail when > 512MB?
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


If preference to keep same partitions, which are defined once. Then 
let's align u-boot with this.

Thanks to refactor in u-boot , now AM69 and J784S4 can stay at different 
config.

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

