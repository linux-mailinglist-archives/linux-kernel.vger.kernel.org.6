Return-Path: <linux-kernel+bounces-246611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22F692C44D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F6283CA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4204182A7D;
	Tue,  9 Jul 2024 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hx0COoAK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A217B02B;
	Tue,  9 Jul 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555469; cv=none; b=gzCv6zfHv/74BAvPJWQ3UTaEo1JNiHow9d517XThpNLZpfrZO0f9Aytup9K+BESf9Lb/tUrfmLAOzGwVo+ESlx/byypIEoHQaOxKsRcs63lmCd884XyDtTHGcH7pd9IyEX7YRVCA4mdZgALMQTtS5lzehKy9CYHLHXvxZXfCPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555469; c=relaxed/simple;
	bh=D4zeBVkSTJsc9ZQVQLrCii8k8P+vz8t5b0v7IX40Q6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BhBT3gOcRhl1dgrtZgpDqlIvZ8sZLoMxpBBwRmZQI5e/CBDoue6HEGqILEdB1jItf/bxO/mWB1cZd76+PKnRdK9cRoC3HNej+swbe9BhNFIN0SUM/HU8QkLMuyCGK4D7TZfzIshWNZwfVadLDMSRsIdFAICP3uMRlAMAfeISER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hx0COoAK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469AaFTD003666;
	Tue, 9 Jul 2024 20:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zP7sQqPEBj92a4s3LSeDCL3HKNLXBrQAZfBTvIb5o6s=; b=hx0COoAKiItsHlpc
	XI/O/g8KBt2jauxtDXKJOuHVgImEjzpKR6OhhewHd2vpIa0sOoY5r2IQzd7F1Yiq
	jXxfjWy5CoQCZWznc8kkvMEu/uxW0uAcKwHClRCzPV1+ZFdfl4D8j2S4xnOnKlmg
	nkCI8iCcw8UARzTFoi+7JesepVHUC/w03rQJFAfAjXdm2S9dj4K8eRKTxvDLhJuE
	MUQsVMspnx4LRMwBKg0pjVKP7rHxkRfeEsImXanJRhdzDuItDNGM4uX1dIkS2h3B
	37AoHIjB75ncL8giYg66+mZVBMyLuKq6gtksOROyKGgAUP/74DFbzsBzVVW9OG0Z
	9uTs0g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwqfbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 20:03:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469K3gGn030620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 20:03:42 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 13:03:42 -0700
Message-ID: <1f167dbf-9744-433c-aa5c-a35b66b79dde@quicinc.com>
Date: Tue, 9 Jul 2024 13:03:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsi: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Eddie James <eajames@linux.ibm.com>, Jeremy Kerr <jk@ozlabs.org>,
        Joel
 Stanley <joel@jms.id.au>, Alistar Popple <alistair@popple.id.au>,
        Andrew
 Jeffery <andrew@codeconstruct.com.au>
CC: <linux-fsi@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <kernel-janitors@vger.kernel.org>
References: <20240605-md-drivers-fsi-v1-1-fefc82d81b12@quicinc.com>
 <4d1276a3-ef4a-4c84-8d09-d1613f311a28@quicinc.com>
 <3edca7a4-361b-4381-8b13-70584a30e2b1@linux.ibm.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <3edca7a4-361b-4381-8b13-70584a30e2b1@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VMiwqcJLZgNeAMQCjEju4tHyS8x4Kkr2
X-Proofpoint-ORIG-GUID: VMiwqcJLZgNeAMQCjEju4tHyS8x4Kkr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_08,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=939 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090135

On 7/1/2024 8:00 AM, Eddie James wrote:
> 
> On 6/26/24 00:15, Jeff Johnson wrote:
>> On 6/5/2024 3:39 PM, Jeff Johnson wrote:
>>> make allmodconfig && make W=1 C=1 reports:
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o
>>>
>>> Add the missing invocations of the MODULE_DESCRIPTION() macro, and fix the
>>> copy/paste of the module description comment in fsi-master-ast-cf.c.
> 
> 
> Thanks!
> 
> Reviewed-by: Eddie James <eajames@linux.ibm.com>

I still don't see this in linux-next yet so following up again to see if
anything else is needed to get this merged.



