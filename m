Return-Path: <linux-kernel+bounces-515738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720B2A36856
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0C13B1D61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D421FC7F2;
	Fri, 14 Feb 2025 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hWbPBGNw"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C41DE2B4;
	Fri, 14 Feb 2025 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572640; cv=none; b=jf5KmH62rz06yd5v3IC4OpqQpuceO1RObqYDAvvk6gOtby57O/hjHWlwRW2fqQH+EaieIr7sRlZ6aBQ0Zz6Stir8q6+0HZH2XaSm12Hx/tRjbzg4Mff3YKCWOB7TFJtfvAOmoz9Tgfy/K3Htp/mBfO3xG5+hEbPqQyV4XS4hbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572640; c=relaxed/simple;
	bh=r/NYCYjMogkoPU8rkXkhPxSGNwsywVNs1fQ8IZdA0n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vx3uZIgq5f8qh+l7vC9k0TH/PhfN8eVLQhweE1mU0Uars5QFhYm92rOsCIUsZesdgUl5d4sK/dDTyHXGkqaiOk86e+9xHqgTzbQrAuPvO+WiZjJc2Vn+WXk/XPiDDk9AoqvY77qLPkrn+z7GYJ85samrfIljmC3H/dHWP8/td3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hWbPBGNw; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51EMb3Nc1043280
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 14 Feb 2025 16:37:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739572624;
	bh=PSnKZ9pgEEZ6nNIIZ9dM7rFmu3IDFEefyD7U0e7a6so=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hWbPBGNwNNtgiRAJOFdPM4u/GvQuf1BrvUi2N42/b7mUgj0g9ooN1VSt2mPP8O5P0
	 sjbSOkhSp3d/M34ei97ktwEYN9lzC7bFLfFByLT/ZS7g+63VzJpgyVdha3tOfgLT0Y
	 sV76BPCsP8lE+fF9E+uJ/eQmpGzKqV5qX7Z32z60=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51EMb3Zd083376;
	Fri, 14 Feb 2025 16:37:03 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Feb 2025 16:37:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Feb 2025 16:37:03 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51EMb3Ow035234;
	Fri, 14 Feb 2025 16:37:03 -0600
Message-ID: <b3e96184-e20c-4935-b86c-73c95b00b9fc@ti.com>
Date: Fri, 14 Feb 2025 16:37:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: Add alias for RTC
To: Dhruva Gole <d-gole@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <msp@baylibre.com>,
        <khilman@baylibre.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20250212210604.745175-1-k-willis@ti.com>
 <20250214062141.gdmkepuuyqb22xuh@lcpd911>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250214062141.gdmkepuuyqb22xuh@lcpd911>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 2/14/25 00:21, Dhruva Gole wrote:
> On Feb 12, 2025 at 15:06:04 -0600, Kendall Willis wrote:
>> From: Vibhore Vardhan <vibhore@ti.com>
>>
>> Adds alias for SoC RTC so that it gets assigned rtc0. PMIC node is
>> assisgned rtc1 so that PMIC RTC gets probed as rtc1. This makes it
> 
> Nit: Fix the spelling of assigned please.
> 
>> consistent for testing rtcwake with other AM62 devices where rtc0
>> is SoC RTC.
>>
>> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
>> [k-willis@ti.com: Reworded commit message]
>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>> ---
>> Tested with rtcwake on AM62A.
> 
> Any test logs you can provide would be great!
> 
>>
>> Original patch for AM62A existed in the TI Vendor tree with Vibhore's
>> authorship:
>> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-6.6.y&id=f745d9063212d1088dcfb068ecb4b16648b96487
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>> index a6f0d87a50d8..51ea961f166e 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>> @@ -22,6 +22,8 @@ aliases {
>>   		serial3 = &main_uart1;
>>   		mmc0 = &sdhci0;
>>   		mmc1 = &sdhci1;
>> +		rtc0 = &wkup_rtc0;
>> +		rtc1 = &tps659312;
>>   	};
>>   
>>   	chosen {
>>
>> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> 
> It's nice that you've mentioned this, but it seems to be from Feb2.
> Can you please base it on latest linux-next when you send in future?
> This will avoid any merge conflicts in advance.
> 
> For this though, you may get away with it because nobody else may have
> touched this file so far...
> 
> If you do send a v2, feel free to pick:
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> 

Hi Dhruva,

Thanks for the feedback and the review. I will be adding the changes 
mentioned by you in v2 :)

Best,
Kendall Willis

