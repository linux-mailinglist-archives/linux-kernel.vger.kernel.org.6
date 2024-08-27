Return-Path: <linux-kernel+bounces-302557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6355A960043
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200BD283463
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291744AEDA;
	Tue, 27 Aug 2024 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q9qOEh7x"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9523BB;
	Tue, 27 Aug 2024 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724732751; cv=none; b=G7+tEyINJBuw96BOTdzM+TtLJcYVGpetlsz5fVx05u2P5+a3cjHcZ4vULeS3eFQFxNQAKe7HLd9aRFlf0IUE8nuBTnaXwMh87ktRbY7OEB0GH0TCdGG37oJ2JBpYgelK68gHy/9P5qJVuUcxyFGo2bGrHbPCmEo/wZzqqK6LYMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724732751; c=relaxed/simple;
	bh=D4WpegS0Kt3UGTzJCdyG8yasvdAQaFeTBZ7aZHOagA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GYH1rRWdnMWF105ZiFAbv3J/awBPG4BJVYyVNNFOmCCs6N1ldFiBrUiMP24rullsPZYUbGC/WVkyaIXU8xjmPXgoxol/k0SPQxHM7pc6yTdTDGuZ6v6KZAOpwhMlNHNs/ZQeagln4bmDDIzIX0v1Z94eowfTnP8u+DgmOL9IjGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q9qOEh7x; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47R4PeNr004738;
	Mon, 26 Aug 2024 23:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724732740;
	bh=6e9SfThhYRrN7KG1HncGujBpniySH9ne5vmCciFzMy0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Q9qOEh7xOAfTbaofQA2gs/BFM6RkXj8oEzp42RJ3l0tXiW50Ii/4HRcJEmBEfLf6b
	 eLiN51XKS953rXiTVaurb0arMdr9y/n2PZTaPcgI2RiHZTVGpUKmlM6k+1SkbykM8c
	 HbMBBn0XlMphmSk+xBgkGoIJdqr/sjuTmo7T07z0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47R4Peal114153
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 23:25:40 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 23:25:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 23:25:40 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47R4Pben007236;
	Mon, 26 Aug 2024 23:25:37 -0500
Message-ID: <571daac8-a5a4-4cc6-b95c-68cd7e0eb924@ti.com>
Date: Tue, 27 Aug 2024 09:55:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: ti: k3-am62p: add opp frequencies
To: Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240823-opp-v2-0-e2f67b37c299@ti.com>
 <20240823-opp-v2-3-e2f67b37c299@ti.com>
 <20240826132311.igliqicrydtifp2s@lcpd911>
 <20240826161149.2hnfpjslsdyezn72@bryanbrattlof.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240826161149.2hnfpjslsdyezn72@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 26/08/24 21:41, Bryan Brattlof wrote:
> On August 26, 2024 thus sayeth Dhruva Gole:
>> Hi Bryan,
>>
>> On Aug 23, 2024 at 16:54:30 -0500, Bryan Brattlof wrote:
>>> ONe power management technique available to the Cortex-A53s is their
>>
>> s/ONe/One
>>
>>> ability to dynamically scale their frequency across the device's
>>> Operating Performance Points (OPP)
>>>
>>> The OPPs available for the Cortex-A53s on the AM62Px can vary based on
>>> the silicon variant used. The SoC variant is encoded into the
>>> WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register which is used to limit
>>> the OPP entries the SoC supports. A table of all these variants can be
>>> found in its data sheet[0] for the AM62Px processor family.
>>
>> Error 404! Not found [0] ;)
>>
> 
> Oops. I'll fix these up
> 
>>>
>>> Add the OPP table into the SoC's ftdi file along with the syscon node to
>>
>> What is ftdi?
> 
> FTDI is a chip, what I tried to type out was fdti or Flattened Device 
> Tree Includes :)
> 
>>
>>> describe the WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register to detect
>>> the SoC variant.
>>>
>>> Signed-off-by: Bryan Brattlof <bb@ti.com>
>>> ---
>>>  .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 +++
>>>  arch/arm64/boot/dts/ti/k3-am62p5.dtsi              | 47 ++++++++++++++++++++++
>>>  2 files changed, 52 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
>>> index 315d0092e7366..6f32135f00a55 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
>>> @@ -20,6 +20,11 @@ chipid: chipid@14 {
>>>  			bootph-all;
>>>  		};
>>>  
>>> +		opp_efuse_table: syscon@18 {
>>> +			compatible = "ti,am62-opp-efuse-table", "syscon";
>>
>> Huh, curious why I don't see this particular compatible in am62 itself..
>> Also, I am still not clear where this discussion got left off: (If it's
>> related)
>> https://lore.kernel.org/all/5chxjwybmsxq73pagtlw4zr2asbtxov7ezrpn5j37cr77bmepa@fejdlxomfgae/
>>
>> In AM625, I see
>> k3-am625.dtsi:111: col 14: syscon = <&wkup_conf>;
>>
>> But the approach you've used here seems different. Is there a
>> justification given on which one should be used/why somewhere that I can
>> refer?
> 
> Labeling the entire &wkup_conf as a syscon node is kinda abusing what 
> the syscon node is used for. There are a lot of things inside that 
> WKUP_CTRL_MMR that do not belong under the miscellaneous registers 
> category. For the 62A and 62P we've chosen to label &wkup_conf as a bus 
> with little syscon sub-nodes inside of it.  
> 
> I don't think the discussion[0] ever finalized but we started going that 
> direction with new SoCs, looks like the older SoCs never received the 
> cleanup.

This patch seems to be in the right direction. Marking entire wkup_conf
as "syscon", "simple-mfd" is wrong and needs to be addressed in
k3-am62-wakeup.dtsi similar to how other child-nodes in wkup_conf are
implemented in same file.

[...]

-- 
Regards
Vignesh

