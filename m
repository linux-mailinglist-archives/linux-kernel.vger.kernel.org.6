Return-Path: <linux-kernel+bounces-188392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82DB8CE175
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1417B2155F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C75312883C;
	Fri, 24 May 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wrFkMSil"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113FF38FA0;
	Fri, 24 May 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716535151; cv=none; b=Z6M2FSmBP2dGSMBZebnslicqKKtF30+encU/H85927vR3a9difVpm5I0wFQ8NWdPn5nDPb1ezRx/w3nHKz8OhQQDQwwIxJDjSfiOXpAjBDGHHNDamv/H+dwvpMmEAYL9HpJ+/kVNr58RQbI1p/o7Fc95d6on/8M/ABXZH/jOJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716535151; c=relaxed/simple;
	bh=3NFPZbOa4vLOs7iKJg9qDUPO1qYFwxkgx3qbSt/47Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wwg90MqP2cZ7BRhT1K76jG4FmmUOUyJdNn16aijf/pq5DfIbxjyqd9ix1yM7puuyIKXCHOtQeyghmJciX7Kn1HJFsVKUyCQxgbK1gcWaQLjPehrR9pT1MfF1urt1SStmsRi1pjwmV3LXs/jN26ZGhybXJeRSqKklSuDqG+dR+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wrFkMSil; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O7J1vV128228;
	Fri, 24 May 2024 02:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716535141;
	bh=ncPP31mWhfYzqRIAPmbHp+WUQhAJy3jptBcSDg8ch8Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wrFkMSilr+MHgqqjLnkjfv4o02MlUwNxlPuhe7R8pHcnZUBbgOaBoTjwEYud3ZENA
	 VkpNBZxPm4AKqNYTrgD1eEga+xEb6PyyjdfgZ5+pNVk+Uubn9q9sNZwds6y8K1L5Wm
	 lChvwHlynLM4WXeV3MY3Qe/aJgca0s66qMD5UERw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O7J1FQ009042
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 02:19:01 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 02:19:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 02:19:00 -0500
Received: from [10.24.68.216] (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O7Ivmm083673;
	Fri, 24 May 2024 02:18:58 -0500
Message-ID: <607db056-1208-4353-a666-fe0d52a6b286@ti.com>
Date: Fri, 24 May 2024 12:48:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Mark eMMC as non removable
Content-Language: en-US
To: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <jm@ti.com>, <nm@ti.com>
References: <20240522083631.1015198-1-b-kapoor@ti.com>
 <24d0579a-1c8d-42ea-afa5-dcd0ab3fa193@ti.com>
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <24d0579a-1c8d-42ea-afa5-dcd0ab3fa193@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 23/05/24 3:24 pm, Vignesh Raghavendra wrote:
>
> On 22/05/24 14:06, Bhavya Kapoor wrote:
>> Mark the eMMC module on J722S as non removable since it
>> is always present on the evm.
> Nit s/evm/EVM
This definately demands a v2
>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>> ---
> This needs a Fixes tag?

Hi Vignesh, we are just adding up a property so i assume we should not 
need a fixes tag.

We can take reference from how its done in this patch: 
https://patchwork.kernel.org/project/linux-samsung-soc/patch/1444927873-15140-7-git-send-email-javier@osg.samsung.com/

>
>>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> index bf3c246d13d1..fe810e32cb7a 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> @@ -369,6 +369,7 @@ partition@3fc0000 {
>>   &sdhci0 {
>>   	disable-wp;
>>   	bootph-all;
>> +	non-removable;
>>   	ti,driver-strength-ohm = <50>;
>>   	status = "okay";
>>   };
>

