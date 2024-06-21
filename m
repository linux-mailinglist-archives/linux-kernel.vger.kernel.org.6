Return-Path: <linux-kernel+bounces-225049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA623912B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CA6286641
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82115FA9C;
	Fri, 21 Jun 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="klLoX33H"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00A15FA6C;
	Fri, 21 Jun 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986496; cv=none; b=H9oJG0yAczKh4VMzjfJLdc6FGWfdPnw6ehpwL+6Mma2q4Zt64QjDSIvP/BTTvuSWySOYRwc/XHBT5GyEqs+kbhpZb3IjXmd45tbQwUvKsYNVi30hpE+/SOUcDXD1Ps/kgl1YM6bFnWs5+3rNDQX3Ipz9JF0xE9cI93LolJLB3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986496; c=relaxed/simple;
	bh=b7MpNwrhbxp7wFiXQH5J0bM5Ti2raMUUWEzZOd/dU6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bCS3AjdLPUzLLEB8SKPwjAYeoiqx4u31eSxULB5tAQNXt6PZfk/d92IuHbZPaaVHz7WUlc4Tm7l8hcY0YNArou3wDQR+7JEexKcCngf+D2O2E3NpkWcxuOfn3Argir0rQawwd7Ysk1du6jggjoqmEzXmx11ar7NAOm2ZbAbh9aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=klLoX33H; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LGEkxN046341;
	Fri, 21 Jun 2024 11:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718986486;
	bh=syTK7l/prnGj+f5oxRzOtqn+SH670xlXIdLII55WPVw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=klLoX33HmwBOOEZdcwadE6NQFnxPna1YpjQz7h+9mkO8WOt+xAEXYD1yhvZcPkM2v
	 R2TGwl5o5jKMGvmFjTavcFqatek3pJQF7LjXgE34ifUPXfs1wHerYIn26m8kP5wV1p
	 pexLHQmpUPhQGcbcyuzXW/WKpmfwRpuxWtSRWFtM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LGEk7N007182
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 11:14:46 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 11:14:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 11:14:46 -0500
Received: from [10.249.130.181] ([10.249.130.181])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LGEX7T021157;
	Fri, 21 Jun 2024 11:14:34 -0500
Message-ID: <1b5e3175-c9b7-4fb5-b405-e46373a6a469@ti.com>
Date: Fri, 21 Jun 2024 21:44:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of
 global CMA
To: Brandon Brnich <b-brnich@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <praneeth@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>
References: <20240613150902.2173582-1-devarsht@ti.com>
 <20240613150902.2173582-4-devarsht@ti.com>
 <20240614170409.zu4vaatdac4o6w2o@udba0500997>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240614170409.zu4vaatdac4o6w2o@udba0500997>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vignesh,

On 14/06/24 22:34, Brandon Brnich wrote:
[..]

>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> index fb980d46e304..5ef74d9f8eea 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> @@ -48,6 +48,13 @@ reserved-memory {
>>  		#size-cells = <2>;
>>  		ranges;
>>  
>> +		linux,cma {
>> +			compatible = "shared-dma-pool";
>> +			reusable;
>> +			size = <0x00 0x24000000>;
>> +			linux,cma-default;
>> +		};
> 
> Since AM62p has 8gb memory, this allocation can come from upper portion.
> Doing so breaks Wave5 encoding/decoding as the driver can not yet handle
> 48 bit addressing. 48bit support is scheduled to be upstreamed, but unsure of
> when this will actually make it in.  
> 
> Could we force this into lower 32bits using same
> alloc-ranges as done in your AM62a patch[0]?
> 


I would like to take a look at this separately, is it possible for you
to drop this patch [3/3] from series due to above comments and take the
rest two from the series ?

Regards
Devarsh

