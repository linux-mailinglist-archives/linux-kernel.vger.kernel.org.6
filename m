Return-Path: <linux-kernel+bounces-301317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC5695EEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12188286A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5E14D6ED;
	Mon, 26 Aug 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QRbSoPt/"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A917A5BC;
	Mon, 26 Aug 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669441; cv=none; b=Lema8xBWr2yxM0/0nJ3Uir/cj8yfbsT94nkf3QsylLim68LvOYs4Trcn1bRQfiQPmsHl5iUsRWd4FTzg3GJPXrCfJQx/r/mQ3goJ8tDeRCz4uI0S+dGFAdYoO9ozpHSrtEjSpPClfVAbpcArCIGqhsGKN+py8plKLpsteEaxJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669441; c=relaxed/simple;
	bh=LnwKXD6mmbWMYKyCnfvJwFw1FmPTX62wiCdpPimhi10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X7469ODTHz7ajWreJrdkOagL4m7wbW5ahxmB6pCn3h3JVcvx2i9eQl8V5BWSsc9Kt9jV+CM+MKQO4eEhz+e9VTAa5VoW/ypxHjq4BmWoXBAXlTuPvldur85gLjeVZUOCamMPLCxtUyZ3oH43+OsZLwupLwhF9F0cNWq0cQqj4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QRbSoPt/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAoKmu066017;
	Mon, 26 Aug 2024 05:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724669420;
	bh=MqXoC24ZZoTa7ybkdKqE5+uzdqNim1BTNniVM4zOzPU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QRbSoPt/4oYfWFcHLpu+2Mkua6kEaeCHizacRvBYCO9NkxeLFbEassmnIeyQU1mvB
	 lU+BP3kYwduDLOJwr0YSkzyPZ66YEfxaA+s3jLllNC0KoMQraAie7HCujYUAxsFC2r
	 184ITITD42KTBv+kEU+iLpqRtWWHlPPtATTogk8M=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAoKLw030536
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 05:50:20 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:50:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:50:20 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAoFHI064287;
	Mon, 26 Aug 2024 05:50:16 -0500
Message-ID: <d682f87e-be8e-4679-9b6b-b37b3f897d9b@ti.com>
Date: Mon, 26 Aug 2024 16:20:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Reserve Timer Nodes to avoid clash with Remoteproc
 firmware
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <u-kumar1@ti.com>,
        <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>, <afd@ti.com>,
        <hnagalla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240816073908.2343650-1-b-padhi@ti.com>
 <20240824180356.quv4zdrtnskrnuo5@diagram>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20240824180356.quv4zdrtnskrnuo5@diagram>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 24/08/24 23:33, Nishanth Menon wrote:
> On 13:09-20240816, Beleswar Padhi wrote:
>> The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
>> use timers. At the same time, if Linux probes the timers, some
>> instability is observed while booting remote cores. Therefore, change
>> the status of the timer nodes to "reserved" to avoid any clash.
>>
>> v3: Changelog:
>> * Udit
>> 1) j7200: Updated commit message description to remove DSPs as the SoC does not
>> have one.
>> 2) j722s: Updated the correct commit for "Fixes:" tag which introduced the bug.
>> 3) For entire series, removed comment about timer usage by R5fs in the MCU
>> voltage domain as those are used by Device Manager firmware to get SoC
>> functional.
>>
>> Link to v2:
>> https://lore.kernel.org/all/20240814104151.2038457-1-b-padhi@ti.com/
>>
>> v2: Changelog:
>> - Split the changes into individual patches for each SoC to tag the
>>    correct offending commit for "Fixes:" tag.
>>
>> * Udit
>> 1) Add the correct clashing timer nodes for J7200 SoC.
>> 2) Port these changes to board level dts files instead of SoC level dtsi files.
>>
>> Link to v1:
>> https://lore.kernel.org/all/20240607105559.771080-1-b-padhi@ti.com/
>>
>> Beleswar Padhi (5):
>>    arm64: dts: ti: k3-j7200: Change timer nodes status to reserved
>>    arm64: dts: ti: k3-j721e: Change timer nodes status to reserved
>>    arm64: dts: ti: k3-j721s2: Change timer nodes status to reserved
>>    arm64: dts: ti: k3-j784s4: Change timer nodes status to reserved
>>    arm64: dts: ti: k3-j722s: Change timer nodes status to reserved
> All patches: please fix your $subject. it looked initially like
Thanks for pointing out, fixed this in v4 revision.
> you were fixing the default SoC behavior, but later I realized
> you are fixing the evm solution.
>
> Also while at this make sure the corresponding SK behaviors are in sync
Thanks for catching this. I have included timer changes for SK boards in 
the v4 revision.
> correctly as well. if you think they do not need to be fixed, address
> that comment in the cover-letter.
>
>>   .../dts/ti/k3-j7200-common-proc-board.dts     | 13 ++++++
>>   .../dts/ti/k3-j721e-common-proc-board.dts     | 29 +++++++++++++
>>   .../dts/ti/k3-j721s2-common-proc-board.dts    | 25 +++++++++++
>>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts       | 13 ++++++
>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 41 +++++++++++++++++++
>>   5 files changed, 121 insertions(+)
>>
>> -- 
>> 2.34.1
>>

