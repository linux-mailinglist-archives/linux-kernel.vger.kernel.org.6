Return-Path: <linux-kernel+bounces-533815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58909A45EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDCFB7ABA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EAA219E8D;
	Wed, 26 Feb 2025 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k8RTRBU1"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB76219308
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572551; cv=none; b=ouTcYiYQQJxXoFuBTTD2O28NUrkaSbqJeBP/YWBYB5CP9LyWkzBU7Prav9GTNVphyy7Th055YiHG7ivfhQM8cgw8AI882ye4Fy4BbpaFUU77y40QNkgmurToBoXvcKzeR75uvznPObkyBCQdSi5CMsjYN7fX+G9g0JLyGxXiFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572551; c=relaxed/simple;
	bh=0/ySfyJv7kyqLsG5HsLti4ApDszsDW8eAqzzCdqKc8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H+RhpMIUajHqjArTJHJNmHILr7Y4yeawruqYU5IIpiWdQMGUDNDzfVF9bsuG9VJJj5teUslXFRL+0aZOuh+jDVuWJPudH2JsudJS/LIcc3RSLg6VlyZlLbZ8r3u+jVoy+ooIHClsId/JRLlyLzZIH+JcFzzFDsl3G8ff1jhom1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k8RTRBU1; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QBsKws2071608
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Feb 2025 05:54:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740570860;
	bh=aLCG74LOhJQiX3HM0JiZUURKZFlNy9nvIZeBF7qaR40=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=k8RTRBU1v9VJO8Ld2qJAQak4jAsE52QApdA93KCknRKu349aHgduUBXs59kL48uoj
	 YUjdVrqxgJLIcbDU17BvzC42NTyvNvahd8eT6ZtMKWdcHizpdMo/ENkknMcKE00HU3
	 kZZq4oj6EiWLFcteIWElmof3m5zuGBIE/ytK0jP4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QBsKW0025757;
	Wed, 26 Feb 2025 05:54:20 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 05:54:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 05:54:19 -0600
Received: from [172.24.18.117] (lt9560gk3.dhcp.ti.com [172.24.18.117])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QBsGrn129011;
	Wed, 26 Feb 2025 05:54:17 -0600
Message-ID: <1982291f-4a02-4ed2-b4bf-778a2fe0ad9e@ti.com>
Date: Wed, 26 Feb 2025 17:24:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: defconfig: Enable HSR driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann
	<arnd@arndb.de>
CC: <quic_bjorande@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        "Anwar, Md Danish"
	<danishanwar@ti.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>
References: <20240419060013.14909-1-r-gunasekaran@ti.com>
 <686f583d-6bf4-4486-b9e4-20c1e268eda6@ti.com>
 <d4954e5e-e51f-41c0-bca5-6e14b4640022@linaro.org>
 <0d33dea6-c021-4f2a-bb3f-92efd6eebd18@ti.com>
 <6081917c-9c20-48fc-baaf-7ac9a9679a72@linaro.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <6081917c-9c20-48fc-baaf-7ac9a9679a72@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

On 2/26/2025 4:18 PM, Krzysztof Kozlowski wrote:
> On 26/02/2025 11: 44, Malladi, Meghana wrote: > > > On 2/26/2025 1: 35 
> PM, Krzysztof Kozlowski wrote: >> On 26/02/2025 07: 18, Malladi, Meghana 
> wrote: > Hi all, > > Apologies in >> case you are receiving this email
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> updq3RaPV007wGXFFrPD30z5a3GGYjpJweyhUcIfUTTaUs-8q0QpC4Yk9azBiFp7cBAf2Knk6fnVs4Fs-zRjTMEn8kmpiGo$>
> ZjQcmQRYFpfptBannerEnd
> 
> On 26/02/2025 11:44, Malladi, Meghana wrote:
>> 
>> 
>> On 2/26/2025 1:35 PM, Krzysztof Kozlowski wrote:
>>> On 26/02/2025 07: 18, Malladi, Meghana wrote: > Hi all, > > Apologies in 
>>> case you are receiving this email for the second time. > Any reason why 
>>> this patch hasn't been merged yet. Other than re-basing > this to the 
>>> tip, anything
>>> ZjQcmQRYFpfptBannerStart
>>> This message was sent from outside of Texas Instruments.
>>> Do not click links or open attachments unless you recognize the source 
>>> of this email and know the content is safe.
>>> Report Suspicious
>>> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
>>> updgnZav1ue7gKXOnHOpH5hg8gLmw9Osqsqh- 
>>> KTLRTnBEurV_VetrG7mzU898vB_5xFrYgbRkkuuFMBobM-uhFAmUgccRSk$>
>>> ZjQcmQRYFpfptBannerEnd
>>>
>>> On 26/02/2025 07:18, Malladi, Meghana wrote:
>>>> Hi all,
>>>>
>>>> Apologies in case you are receiving this email for the second time.
> 
> BTW, Arnd when responded with Ack described the process.
> 

Yes, I wanted to re-confirm before posting it again (just in case).

>>>> Any reason why this patch hasn't been merged yet. Other than re-basing 
>>>> this to the tip, anything else which needs to be addressed to get this 
>>>> merged?
>>>
>>> I don't think you sent it to your platform maintainers, so no one would
>>> apply it. Usually people ignore emails they did not receive, although I
>>> am here an exception tracking missing-DT-patchwork things... :)
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> 
>> Hello Arnd/Krzysztof,
>> 
>> Thank you for the replies :)
>> Was having ambiguity since this is not TI specific change. Wanted to 
>> confirm before re-posting. Will post v2 patch including TI platform 
>> maintainers.
> 
> It is not TI specific? Then which upstream boards benefit from this if
> not TI?
> 

This change enables generic HSR protocol support in the kernel which is 
required for HSR driver support in TI boards. When I said "not TI 
specific" - I meant this change is not internal to TI driver. Hope this 
clarifies the miscommunication from my earlier mail.

Best Regards,
Meghana

> 
> 
> Best regards,
> Krzysztof
> 


