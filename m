Return-Path: <linux-kernel+bounces-236502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA7491E31D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31771F21CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C516C850;
	Mon,  1 Jul 2024 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BS/NLp8b"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7A14BF8F;
	Mon,  1 Jul 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846061; cv=none; b=kVaupCwvT4eOdBxwQn8iOKL2g6VW47+rY8KTcZoMoR5kgoH38V1XMsSl/U7qxMaNIoOmlYErUmrYC3S9yUU4Ob/cJ4kGmRxXt537Xj7sEB5VD1xbYMyBqXY4+F7GlJrLu2rut0shseQ2E0dY1yyVupapsNuWQzDgRtrObOMYSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846061; c=relaxed/simple;
	bh=mGHXnnIy+vo9CjwQtqX9et7DK7X7d1x/W/dfS+sxmRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCAlgy4HvmI44EDcq6Yid0lZIkgeiKdLV6TSvczj19QYtljgCdvC00VtDFsy6xGy7UUvirTcx5OeaUcKJyNyLeB6lHYQierfRcQ5v4tTaRbYhY6qlOdML4blipOBLlxrvcXN0O6BzSsTXNh2Vc8HSF4z5ZFNhuFS78C1Ef/7HsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BS/NLp8b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461EwWBF013066;
	Mon, 1 Jul 2024 15:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=K
	86+MIQbIn8fE3VtbjZL3wu6X44jpkcz72UYBATe06M=; b=BS/NLp8bXtxqKmKXJ
	z1P5ryj6JYcUgX81fGufjLQ9bglJvBtF5EC0EY+RdHz7L3HCgy++osZacCAukHpO
	QY0Qfs/fbDMKJaR0hzBWcYGPmXlXKvNCa9Y+/R3cCrUYD4GtE31Gb7wP1o4bEuUv
	2Zux/t2iT3i5JuMSkozur0G3qJrEM5cz6leRo+rdtR+a7DfS/gYTp5hO91ZrbmNN
	Iq7nmS1/7ARom4ZPDFrJj8p7BCliA+GI1KuXc+LaLwTZtivYlfiWM/7pdg2MMRM9
	I9mo0W9UgODeb4Wfq2p3OiOzd2FW7c+y6w1xdANXI9Y91Tb8u1cn/rootjTUilxl
	POm9g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403xpf804u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 15:00:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461Eh4So009152;
	Mon, 1 Jul 2024 15:00:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402w00g017-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 15:00:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461F0Vkf24314464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 15:00:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0A365807A;
	Mon,  1 Jul 2024 15:00:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B51F58053;
	Mon,  1 Jul 2024 15:00:30 +0000 (GMT)
Received: from [9.61.77.123] (unknown [9.61.77.123])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 15:00:30 +0000 (GMT)
Message-ID: <3edca7a4-361b-4381-8b13-70584a30e2b1@linux.ibm.com>
Date: Mon, 1 Jul 2024 10:00:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsi: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Jeremy Kerr <jk@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, Alistar Popple <alistair@popple.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        kernel-janitors@vger.kernel.org
References: <20240605-md-drivers-fsi-v1-1-fefc82d81b12@quicinc.com>
 <4d1276a3-ef4a-4c84-8d09-d1613f311a28@quicinc.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <4d1276a3-ef4a-4c84-8d09-d1613f311a28@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iLyGY9PA4NMKIN9u4jz9L6lLDrE3Fe_3
X-Proofpoint-ORIG-GUID: iLyGY9PA4NMKIN9u4jz9L6lLDrE3Fe_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010115


On 6/26/24 00:15, Jeff Johnson wrote:
> On 6/5/2024 3:39 PM, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro, and fix the
>> copy/paste of the module description comment in fsi-master-ast-cf.c.


Thanks!

Reviewed-by: Eddie James <eajames@linux.ibm.com>


>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>   drivers/fsi/fsi-core.c          | 1 +
>>   drivers/fsi/fsi-master-aspeed.c | 1 +
>>   drivers/fsi/fsi-master-ast-cf.c | 3 ++-
>>   drivers/fsi/fsi-master-gpio.c   | 1 +
>>   drivers/fsi/fsi-master-hub.c    | 1 +
>>   drivers/fsi/fsi-scom.c          | 1 +
>>   6 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
>> index 097d5a780264..716a924269ee 100644
>> --- a/drivers/fsi/fsi-core.c
>> +++ b/drivers/fsi/fsi-core.c
>> @@ -1444,5 +1444,6 @@ static void fsi_exit(void)
>>   }
>>   module_exit(fsi_exit);
>>   module_param(discard_errors, int, 0664);
>> +MODULE_DESCRIPTION("FSI core driver");
>>   MODULE_LICENSE("GPL");
>>   MODULE_PARM_DESC(discard_errors, "Don't invoke error handling on bus accesses");
>> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
>> index f0a19cd451a0..b454587790a2 100644
>> --- a/drivers/fsi/fsi-master-aspeed.c
>> +++ b/drivers/fsi/fsi-master-aspeed.c
>> @@ -672,4 +672,5 @@ static struct platform_driver fsi_master_aspeed_driver = {
>>   };
>>   
>>   module_platform_driver(fsi_master_aspeed_driver);
>> +MODULE_DESCRIPTION("FSI master driver for AST2600");
>>   MODULE_LICENSE("GPL");
>> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
>> index 812dfa9a9140..85096559dda3 100644
>> --- a/drivers/fsi/fsi-master-ast-cf.c
>> +++ b/drivers/fsi/fsi-master-ast-cf.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0+
>>   // Copyright 2018 IBM Corp
>>   /*
>> - * A FSI master controller, using a simple GPIO bit-banging interface
>> + * A FSI master based on Aspeed ColdFire coprocessor
>>    */
>>   
>>   #include <linux/crc4.h>
>> @@ -1440,5 +1440,6 @@ static struct platform_driver fsi_master_acf = {
>>   };
>>   
>>   module_platform_driver(fsi_master_acf);
>> +MODULE_DESCRIPTION("A FSI master based on Aspeed ColdFire coprocessor");
>>   MODULE_LICENSE("GPL");
>>   MODULE_FIRMWARE(FW_FILE_NAME);
>> diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
>> index ed03da4f2447..d32dcc98e85b 100644
>> --- a/drivers/fsi/fsi-master-gpio.c
>> +++ b/drivers/fsi/fsi-master-gpio.c
>> @@ -894,4 +894,5 @@ static struct platform_driver fsi_master_gpio_driver = {
>>   };
>>   
>>   module_platform_driver(fsi_master_gpio_driver);
>> +MODULE_DESCRIPTION("A FSI master controller, using a simple GPIO bit-banging interface");
>>   MODULE_LICENSE("GPL");
>> diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
>> index 6d8b6e8854e5..6568fed7db3c 100644
>> --- a/drivers/fsi/fsi-master-hub.c
>> +++ b/drivers/fsi/fsi-master-hub.c
>> @@ -295,4 +295,5 @@ static struct fsi_driver hub_master_driver = {
>>   };
>>   
>>   module_fsi_driver(hub_master_driver);
>> +MODULE_DESCRIPTION("FSI hub master driver");
>>   MODULE_LICENSE("GPL");
>> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
>> index 61dbda9dbe2b..411ddc018cd8 100644
>> --- a/drivers/fsi/fsi-scom.c
>> +++ b/drivers/fsi/fsi-scom.c
>> @@ -625,4 +625,5 @@ static void scom_exit(void)
>>   
>>   module_init(scom_init);
>>   module_exit(scom_exit);
>> +MODULE_DESCRIPTION("SCOM FSI Client device driver");
>>   MODULE_LICENSE("GPL");
>>
>> ---
>> base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
>> change-id: 20240605-md-drivers-fsi-0a34d82a85da
>>
> Following up to see if anything else is needed from me.
> Hoping to see this in linux-next :)
>
> /jeff

