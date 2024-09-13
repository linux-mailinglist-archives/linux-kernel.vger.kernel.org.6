Return-Path: <linux-kernel+bounces-327608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92B977846
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3509AB248B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5126C154C04;
	Fri, 13 Sep 2024 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EFfSehS+"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EBD4A07;
	Fri, 13 Sep 2024 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205102; cv=none; b=d/NcgRXzy7BHxFeE1HLujRTWotdORBsKymEMolkf8Ulr4o5mRACdbbhT1HVZ6ePjrw1LVDq5xAu5DjVw8fwEGu9bPkNfAUR5Z+2YU6hMQwYM/Rr3jAzbdCXX4RHt9H3ATCKOcsuIu/HJ7rern7uvIXnak0tellNa9EnwK1nljVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205102; c=relaxed/simple;
	bh=WoKkcQipE4/xHR/NdwPS6Bjm/Dw9I6bu2ZnHts3E368=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VW9udRsMlMCNm3mq9+Wh+75mqdimOhYchHA2E31frIBRLzN4S4uAquqwPB5qqkfysEHq4IkN6OUU17GEPuEznngcFSNKPJfWuDDo3SBen3qDCcevDEMcTXvcNXwk5GnBZoLvTFJG/PtX7CGxOuusLoHteIbRp2XUdSy70CZ2wwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EFfSehS+; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48D5Ohl9024794;
	Fri, 13 Sep 2024 00:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726205083;
	bh=Us8Z9SWqyaxfXS8Zp2weS07AoL27IDikUkpVOPXuHTE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EFfSehS+PqnwHfsaBB4exofR/nd8KNBX1Utkh+/7HyTo4ufhQqOqMXnYNPTPixyOG
	 XS7Soxc1zil5YnYIsjRxIIjmHkPH1j7RFfXM70YxHhTRvkvGrdCPHAKEptPPXnkL/O
	 vYJddGgHwrv6c3RyQnh7ddajAz0qYnfy57T2XmsQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48D5OhKG009215
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Sep 2024 00:24:43 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Sep 2024 00:24:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Sep 2024 00:24:42 -0500
Received: from [172.24.19.92] (lt5cd2489kgj.dhcp.ti.com [172.24.19.92])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48D5OcJP128907;
	Fri, 13 Sep 2024 00:24:38 -0500
Message-ID: <1a9b4de5-93f5-47ad-be5d-733668b3adba@ti.com>
Date: Fri, 13 Sep 2024 10:54:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-j784s4: Mark tps659413
 regulators as bootph-all
To: Andrew Halaney <ahalaney@redhat.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
        Eric
 Chanudet <echanude@redhat.com>,
        Enric Balletbo <eballetb@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com>
 <lnrcosn7e7x6v5kerll3sqyy7r3qup5nmqi4m3puzjfcvpoljv@6lfmyprzwseu>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <lnrcosn7e7x6v5kerll3sqyy7r3qup5nmqi4m3puzjfcvpoljv@6lfmyprzwseu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 9/12/2024 9:32 PM, Andrew Halaney wrote:
> On Wed, Sep 11, 2024 at 12:19:01PM GMT, Andrew Halaney wrote:
>> This series marks tps659413's regulators as bootph-all in order for
>> the nodes (and parent nodes) to be accessible during MCU's u-boot SPL.
>>
>> This in turn is desired since the tps659413 needs its MCU ESM
>> state machine setup in order for the watchdog to reset the board.
>>
>> This took me a little while to track down, as enabling the ESM, TPS6594,
>> etc in u-boot would result in the below boot failure:
>>
>>      U-Boot SPL 2024.10-rc4-00007-g44b12cbcd1b3-dirty (Sep 06 2024 - 14:25:52 -0500)
>>      SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.4--v09.02.04 (Kool Koala)')
>>      Initialized 4 DRAM controllers
>>      SPL initial stack usage: 13408 bytes
>>      ### ERROR ### Please RESET the board ###
>>
>> Which turns out to actually have failed far earlier in spl_early_init(),
>> due to these nodes not being accessible in u-boot. That's hard to tell
>> though since console isn't setup until later (and for that reason I
>> think spl_early_init()'s return value in j784s4_init.c isn't
>> evaluated since a panic() at that point would leave a user with *no*
>> information at all).
>>
>> I've tested this in conjunction with a u-boot series which I'll link in
>> a follow-up response on the k3-j784s4-evm. I'd appreciate someone testing
>> on the k3-am69-sk at a minimum, as it should suffer the same fate if things
>> aren't setup appropriately.
>>
>> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> Link to the u-boot series: https://lore.kernel.org/all/3bf2177d-178f-46bf-abfe-6f00a52c623b@ti.com/#t
>
> Udit, it seems you tested the am69-sk patch from this series in the above
> u-boot link, thanks! If that's correct mind adding your Tested-by on
> the patch here then as well?


Yes, Please use for this series on both platforms

Tested-by: Udit Kumar <u-kumar1@ti.com>


>
> Thanks,
> Andrew
>
>> ---
>> Changes in v2:
>> - Only mark the regulator nodes as bootph-all since parents are implied
>> - Link to v1: https://lore.kernel.org/r/20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com
>>
>> ---
>> Andrew Halaney (2):
>>        arm64: dts: ti: k3-j784s4-evm: Mark tps659413 regulators as bootph-all
>>        arm64: dts: ti: k3-am69-sk:  Mark tps659413 regulators as bootph-all
>>
>>   arch/arm64/boot/dts/ti/k3-am69-sk.dts    | 8 ++++++++
>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 8 ++++++++
>>   2 files changed, 16 insertions(+)
>> ---
>> base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
>> change-id: 20240906-j784s4-tps6594-bootph-19d3f00fb98a
>>
>> Best regards,
>> -- 
>> Andrew Halaney <ahalaney@redhat.com>
>>

