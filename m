Return-Path: <linux-kernel+bounces-406725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3C09C62CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8809628268A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02680219E3B;
	Tue, 12 Nov 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L11buY95"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB35E18BBA2;
	Tue, 12 Nov 2024 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731444409; cv=none; b=eQwzPitTRTDXq6D1BWDxwZlTEb3/SfZoPjWDQ2tuv6DseymV3yHWmXal4+tnNzQlN4wbxagMX7f9cx+g+KCeGT752mnYU/3lR1rGh5449jEYLMo3pw4O99dsKHlUlznN9guW36Z7B6M5owJlNs0HBHj4Zuhi8xsfotGPdp9OtGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731444409; c=relaxed/simple;
	bh=+f3YFdCuoxk91H5n50mrNb1K7Ch8HlIIuIwfNYO4IoY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i3I5eIqccAHg2wSmrlwNp5CbGpA3hDo43tbF5shAPTE+p69P0akZX5NBSCz0tcIupE5BEplCFls02LLLnMMpbh/Dsr6FY36h+/m0kYzgywVbUvtQUprbWmvBk/0YzLj5ASRZW1ffnZ4fNmv/mmsw7eLydd/lz/KNpko2DvBGGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L11buY95; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACJeR8S019160;
	Tue, 12 Nov 2024 20:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RvdgDI
	NoXFhK8K3r+lG+Sv1e/KZonox43PzTJbkP32c=; b=L11buY95J1U3Tt0QuPgC5J
	tfEVY9YcmRJPO2JIIV4DLXhFcCiF1CMgQzaGw12Hmg/592HDCq7SX490EeMUXC0+
	IFcJgiH3RTxmnDzoQIrgt9lVhEi/06D3IfxmyyazFn0GMXr5TWJ926TBdoEWWrrP
	np5bRquGCqqUFtAtp28+vkkDUOs574loFyJhP12GcM832E19QXofyoZdSw5Qa428
	tBEzW/7nCmTlCEbuXDPo3CWV1q30UWV4cZB2eJnPFkZxpQQcp85QQvZOKml6keM+
	zvPlDryZn7DubkEOWVkiaiWnlWGhF1x55kQiZBbC1tVl2iLPqS+LR+fvq4VmnHAQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vdcer6tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 20:46:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACJKwxV026315;
	Tue, 12 Nov 2024 20:46:27 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tms14uas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 20:46:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ACKkQsL26804752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 20:46:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61D4358052;
	Tue, 12 Nov 2024 20:46:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F09A58056;
	Tue, 12 Nov 2024 20:46:26 +0000 (GMT)
Received: from [9.61.176.224] (unknown [9.61.176.224])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2024 20:46:26 +0000 (GMT)
Message-ID: <01099631-a08a-46cc-a2fa-7ba5b44af0cb@linux.ibm.com>
Date: Tue, 12 Nov 2024 14:46:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: aspeed: Blueridge and Rainer: Add VRM presence
 GPIOs
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-aspeed@lists.ozlabs.org
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241108145822.1365072-1-eajames@linux.ibm.com>
 <d4196567fc62a24922794b02adad1b6c47750760.camel@codeconstruct.com.au>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <d4196567fc62a24922794b02adad1b6c47750760.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hKveIcO7WnRc1dvlNG5J8SxPsuEmwEPZ
X-Proofpoint-ORIG-GUID: hKveIcO7WnRc1dvlNG5J8SxPsuEmwEPZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=415
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120166


On 11/10/24 17:45, Andrew Jeffery wrote:
> On Fri, 2024-11-08 at 08:58 -0600, Eddie James wrote:
>> Add GPIO line names to the GPIO expander to describe DCM and
>> VRM presence detection lines.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts | 4 ++--
>>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts   | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
>> b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
>> index 5f9a46c2abb8..d504ae84db89 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
>> @@ -1232,8 +1232,8 @@ led-controller@60 {
>>                  #gpio-cells = <2>;
>>   
>>                  gpio-line-names =
>> -                       "", "", "", "", "", "", "", "",
>> -                       "", "", "", "", "", "", "power-config-full-
>> load", "";
>> +                       "", "", "", "", "", "", "P10_DCM0_PRES",
>> "P10_DCM1_PRES",
>> +                       "", "", "", "", "PRESENT_VRM_DCM0_N",
>> "PRESENT_VRM_DCM1_N", "power-config-full-load", "";
>>          };
> This ends up generating checkpatch warnings about long lines when I
> apply it.
>
> I did a quick, incomplete and random survey of some other devicetrees,
> and perhaps exploding out like in [1] might help.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d85b2ad35a2ab


Oh, oops, sure thing.

Thanks,

Eddie


>
>>   
>>          led-controller@61 {
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
>> b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
>> index a4aec3010456..eefc69d0d032 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
>> @@ -1280,8 +1280,8 @@ pca_pres3: pca9552@60 {
>>                  #gpio-cells = <2>;
>>   
>>                  gpio-line-names =
>> -                       "", "", "", "", "", "", "", "",
>> -                       "", "", "", "", "", "", "power-config-full-
>> load", "";
>> +                       "", "", "", "", "", "", "P10_DCM0_PRES",
>> "P10_DCM1_PRES",
>> +                       "", "", "", "", "PRESENT_VRM_DCM0_N",
>> "PRESENT_VRM_DCM1_N", "power-config-full-load", "";
> Similarly here.
>
> Andrew

