Return-Path: <linux-kernel+bounces-573130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5547CA6D358
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAF77A6CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A934635961;
	Mon, 24 Mar 2025 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FcbDiuQC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BBC10E9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742787022; cv=none; b=p16bwwbeGJmaQQ8dThcP32IheICm2XHrSl+oeKz61UQWQD8ZNdepWi820wx/gLgnnMUDqY3ZxxkSEGq+Ha91O/MdyiUjac9BbBJc+4W7Xv6i/Fj7iN5O+b5IVw14X5W05IjhppdVEpyXGi3vHOysNMSCvcT9ezhUhrZzVyeIKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742787022; c=relaxed/simple;
	bh=4Q9prhqXxXGXdIQbUpXE/rX0oKrlTii2IPkEI/l6OiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WWDNAJl+FrQxEy57xpHTBKR/zqnsLz7hAwwuc/9XR05UhWacqkpm8sGVW9/vI3wSNE2cRNeiundpftOZBKB50/Vh0D72MsYCdOs7ivFm9g6THhqHA4BlnGzIryYvxNtIzbPKElp72s8KAzb6Wz615qnKUY04o3tnwQB9vFfvAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FcbDiuQC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NNqNKF006744;
	Mon, 24 Mar 2025 03:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DeM2teFBDukpsdT3J0uEteEoCtUF/zVuNYUt2FmtAUk=; b=FcbDiuQCUdscXjoR
	iSAtpkJFcdjXeQi09aCwP+heFowpO7owbEPkxTvGjx7yM20LFZuIVJJXNY2PRgvu
	t66QE5FF8H/KU+uonKC2tr7H9ruf+tYzSGRg00oL3kKzsiqqCPFtwdzgM+4Uti1M
	EkkANsdd2ml2M14lFSdw7OE0ykfVVaT2H6NGKUfi53tNzFc6nb1DQ4B81ANsyyNP
	V28Uqnxow38VpILW8tzav6HbIYvb+OFdvJKeddwU4XAwa7Zi5KCxrC/iJmS68tpX
	ThF+UkqoJYAazC4D/P/U8eAibZuKIO7qO+Yo13ikbZWhoiVHfJG8yo71m2fnCeC4
	R7AXOA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hn9waxyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 03:29:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52O3TnWl004587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 03:29:49 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 23 Mar
 2025 20:29:47 -0700
Message-ID: <90a764d0-c230-43bb-b7e5-189544839f8d@quicinc.com>
Date: Mon, 24 Mar 2025 11:29:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff: firmware
 crashed!
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Johnson <jjohnson@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, <ath10k@lists.infradead.org>,
        LKML
	<linux-kernel@vger.kernel.org>, <jamie@stimulussoft.com>
References: <5aa2dae4-94ba-45cb-b138-bb40c89a85eb@molgen.mpg.de>
 <486e9f27-3b03-4317-a1fc-1bd92235db1c@molgen.mpg.de>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <486e9f27-3b03-4317-a1fc-1bd92235db1c@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PEVQpumqkp-2T46wai9YAKzWS2zA37s4
X-Proofpoint-ORIG-GUID: PEVQpumqkp-2T46wai9YAKzWS2zA37s4
X-Authority-Analysis: v=2.4 cv=CPoqXQrD c=1 sm=1 tr=0 ts=67e0d1ae cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=XgL6m6CVAAAA:8 a=vRpnevWEl1IJU3O6x9AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=0UletBSDd9R_kuu03CwM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_02,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240024



On 3/23/2025 7:41 PM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Am 08.12.24 um 23:21 schrieb Paul Menzel:
> 
>> Today the Wi-Fi connection stopped working, and the logs contained:
>>
>>      [44177.000699] ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>> 1b4a40c5-4495-4c5b-9df9-b7395848239c)
>>      [44177.000720] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id
>> 0x00340aff sub 1a56:1535
>>      [44177.000731] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0
>> testmode 0
>>      [44177.002450] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00309- api 6
>> features wowlan,ignore-otp,mfp crc32 0793bcf2
>>      [44177.004168] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
>>      [44177.004176] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt- op 3 cal otp
>> max-sta 32 raw 0 hwcrypto 1
>>      [44177.014494] ath10k_pci 0000:3a:00.0: failed to get memcpy hi address for
>> firmware address 4: -16
>>      [44177.014498] ath10k_pci 0000:3a:00.0: failed to read firmware dump area: -16
>>      [44177.014500] ath10k_pci 0000:3a:00.0: Copy Engine register dump:
>>      [44177.014508] ath10k_pci 0000:3a:00.0: [00]: 0x00034400  12  12 3   3
>>      [44177.014517] ath10k_pci 0000:3a:00.0: [01]: 0x00034800  19  19 64  65
>>      [44177.014525] ath10k_pci 0000:3a:00.0: [02]: 0x00034c00  39  37 36  37
>>      [44177.014532] ath10k_pci 0000:3a:00.0: [03]: 0x00035000  20  20 22  20
>>      [44177.014540] ath10k_pci 0000:3a:00.0: [04]: 0x00035400 6457 6457 222 158
>>      [44177.014548] ath10k_pci 0000:3a:00.0: [05]: 0x00035800   0   0 64   0
>>      [44177.014556] ath10k_pci 0000:3a:00.0: [06]: 0x00035c00  29  29 0   0
>>      [44177.014563] ath10k_pci 0000:3a:00.0: [07]: 0x00036000   1   0 1   0
>>      [44177.109219] ieee80211 phy0: Hardware restart was requested
>>      [44177.429445] ath10k_pci 0000:3a:00.0: device successfully recovered
>>
>> Please find the output of `dmesg` with two firmware crashes attached. Looking through my
>> logs since September 20th with Linux 6.11-rcX, this is not the first firmware crash. The
>> `guid` value differs pairwaise between each of them.
> 
> Since my message in December I found two more crashes in the logs:
> 
>     Jan 20 13:11:11 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
> 0290afa9-63d2-4d66-b355-de2e12f96f4b)
> 
>     Feb 02 20:34:20 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
> 4c1fb23a-8d0e-4c03-8dfb-a5fa9ad3d2bc)
> 
> I am now in a WLAN with Cisco access points, and get a few crashes:
> 
>     Mär 21 14:01:36 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
> bc05fa56-0033-4fca-bfc0-660568f560fd)
>     Mär 23 11:54:24 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
> b6eb8244-0e48-4785-8247-901e833ed59a)
> 
>     [42307.272046] ath10k_pci 0000:3a:00.0: firmware crashed! (guid bc05fa56-0033-4fca-
> bfc0-660568f560fd)
>     [42307.272078] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id
> 0x00340aff sub 1a56:1535
>     [42307.272094] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0
> testmode 0
>     [42307.272452] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00309- api 6
> features wowlan,ignore-otp,mfp crc32 0793bcf2
>     [42307.272825] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
>     [42307.272834] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta
> 32 raw 0 hwcrypto 1
>     [42307.283011] ath10k_pci 0000:3a:00.0: failed to get memcpy hi address for firmware
> address 4: -16
>     [42307.283024] ath10k_pci 0000:3a:00.0: failed to read firmware dump area: -16
>     [42307.283034] ath10k_pci 0000:3a:00.0: Copy Engine register dump:
>     [42307.283050] ath10k_pci 0000:3a:00.0: [00]: 0x00034400  12  12 3   3
>     [42307.283070] ath10k_pci 0000:3a:00.0: [01]: 0x00034800   5   5 82  83
>     [42307.283088] ath10k_pci 0000:3a:00.0: [02]: 0x00034c00  53  47 45  46
>     [42307.283104] ath10k_pci 0000:3a:00.0: [03]: 0x00035000  13  13 14  12
>     [42307.283120] ath10k_pci 0000:3a:00.0: [04]: 0x00035400  67  67 98  34
>     [42307.283135] ath10k_pci 0000:3a:00.0: [05]: 0x00035800   0   0 64   0
>     [42307.283151] ath10k_pci 0000:3a:00.0: [06]: 0x00035c00  22  22 24  24
>     [42307.283167] ath10k_pci 0000:3a:00.0: [07]: 0x00036000   1   1 1   0
>     [42307.371777] ieee80211 phy0: Hardware restart was requested
>     [42309.383940] ath10k_pci 0000:3a:00.0: timed out waiting peer stats info
>     [42309.690205] ath10k_pci 0000:3a:00.0: device successfully recovered
>     [43924.050746] wlp58s0: deauthenticating from 48:2f:6b:7a:61:54 by local choice
> (Reason: 3=DEAUTH_LEAVING)
> 
> Baochen, do you have an idea? Also how to fix the dump errors?

could you share AP model? and any specific test steps you hit it?

regarding the dump error, I think it is due to unresponsive firmware since it crashes.
We'd better focus on the crash first.


> 
> Jamie (Cc:) also reported this this January 2025 *Ath10k firmware crash* [1].
> 
> 
> Kind regards,
> 
> Paul
> 
> 
>> PS: Other times:
>>
>> -- Boot caea92a03f6d4776926f451f8281ea31 --
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>> 6eb9dc57-1295-4a53-b71d-a8aeba7281a1)
>> Sep 26 12:32:58 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>> c4a6c6a2-3cf4-445e-b16b-2baa35d547f3)
>> Sep 26 12:46:02 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>> b8c8a5f0-7ff7-45c3-8ecb-7ba8074ba6f7)
>>
>> -- Boot 26e7175e65254625bf58276e9532773e --
>> Okt 23 12:11:20 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>> 1b3f438c-339c-4ad1-9d82-92a96a07c3c2)
>>
>> Earliest crash:
>>
>> Sep 26 10:41:36 abreu kernel: Linux version 6.11.0-07273-g1e7530883cd2
>> (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 14.2.0-5) 14.2.0, GNU ld (GNU
>> Binutils for Debian) 2.43.1) #12 SMP PREEMPT_DYNAMIC Sun Sep 22 09:57:36 CEST 2024
>> […]
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>> 6eb9dc57-1295-4a53-b71d-a8aeba7281a1)
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000
>> chip_id 0x00340aff sub 1a56:1535
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing
>> 0 dfs 0 testmode 0
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00309-
>> api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32
>> d2863f91
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3
>> cal otp max-sta 32 raw 0 hwcrypto 1
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: failed to get memcpy hi address
>> for firmware address 4: -16
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: failed to read firmware dump
>> area: -16
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: Copy Engine register dump:
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [00]: 0x00034400 12  12   3   3
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [01]: 0x00034800 28  28 265 266
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [02]: 0x00034c00 29  27  90  91
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [03]: 0x00035000 15  15  17  15
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [04]: 0x00035400 3887 3887 217 153
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [05]: 0x00035800   0   0  64   0
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [06]: 0x00035c00 20  20  16  16
>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [07]: 0x00036000   1   0   1   0
> 
> 
> [1]: https://lore.kernel.org/all/a5b15899-b214-403b-a1b2-84a948e776ef@stimulussoft.com/


