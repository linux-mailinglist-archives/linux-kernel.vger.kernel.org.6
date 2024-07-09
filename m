Return-Path: <linux-kernel+bounces-246754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908EB92C638
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51945281ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53440187850;
	Tue,  9 Jul 2024 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WTWu2BrU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA21B86D6;
	Tue,  9 Jul 2024 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563679; cv=none; b=STlCi+6NfyGEFKDJOcJhrOjEtdW52c97Lw9Rr4VgwY1/GzqgUo/vdeiMPoygbU6PBaNqZ4z078qfoUEBxqapWbTaCm8ao7sNtgSBsR84eEXJanIYh6094e7M0/LZVyY5jZi2Gk0YSX3/l+/pkEF2k1FP4R2huZcKoAY+v1OVJL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563679; c=relaxed/simple;
	bh=9gaSeNUGH1VCLqShpXICFsXzHMbgGtzVUujwaEGJm0g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=BH56Vtzr/EUF0IwgMReEjG9REAxc76ITooPQ4DeblVCeVbFlPtD1brP6J1r9yf5VqmQfQ6swIFafQBDfoLpIk3FjjMB9GmQBedentP9/ZhxWrizQSgCG1rQYWEesLl3qpnK7HdZGszgLswtvyZjZhfowyeHYV/XguCnP9LNmnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WTWu2BrU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469BpAAL006130;
	Tue, 9 Jul 2024 22:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7cXGCJaq7ngKE4UbVN3trEDyMU4pTQMGrKOzBhBaP6c=; b=WTWu2BrUpRDV5XwA
	HIAEF8awhhdssUX4bLSdySDhUV/FoqVZ9fptWLsDDAHxMSjJt6UU8RK/zd8+cLlf
	tg8Z8drUqdlAoOcgyXGpqYvydDfE/vS5x4SkJ5s6ZwSlmZdt40dfsWSWiH7YDoqm
	Gf4PF0QqdZY/IORnieP16ovFPVJvx98BLrSDjJAaVcjdQf9CgrdHEILAyg5aN761
	WvpK+jP+QUVfHiYtGl4jLsUl7POO2DAC7gbmulkeqp+npkKYUiD17SXUo/FEZde4
	IXh5J8y48HT4JVyETT233EGXCdIlLVGrfBDf5muc93R9CSPGmtmLPOynLqhjOV7g
	1sxJxQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa67k7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 22:21:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469ML2BT003454
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 22:21:02 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 15:21:00 -0700
Message-ID: <04bd39d0-9ed7-4c09-9e21-a0a61a0fc6ea@quicinc.com>
Date: Tue, 9 Jul 2024 15:20:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] samples: configfs: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240601-md-samples-configfs-v1-1-83ef2d3c0088@quicinc.com>
 <1d5dc2bb-773c-4877-9660-fff5517c2df3@quicinc.com>
In-Reply-To: <1d5dc2bb-773c-4877-9660-fff5517c2df3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PcCgLvHyaGbEdl87YOYUVeuL5WgpbYoA
X-Proofpoint-ORIG-GUID: PcCgLvHyaGbEdl87YOYUVeuL5WgpbYoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_10,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1011 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090152

On 6/20/2024 9:46 AM, Jeff Johnson wrote:
> On 6/1/2024 5:12 PM, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/configfs/configfs_sample.o
>>
>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>  samples/configfs/configfs_sample.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
>> index 37a657b25d58..fd5d163828c5 100644
>> --- a/samples/configfs/configfs_sample.c
>> +++ b/samples/configfs/configfs_sample.c
>> @@ -364,4 +364,5 @@ static void __exit configfs_example_exit(void)
>>  
>>  module_init(configfs_example_init);
>>  module_exit(configfs_example_exit);
>> +MODULE_DESCRIPTION("Sample configfs module");
>>  MODULE_LICENSE("GPL");
>>
>> ---
>> base-commit: b050496579632f86ee1ef7e7501906db579f3457
>> change-id: 20240601-md-samples-configfs-946b278a9d47
>>
> 
> I don't see this in linux-next yet so following up to see if anything else is
> needed to get this merged.

I still don't see this in linux-next so adding Andrew & Greg to see if this
should go through one of their misc trees. Hoping to have these cleaned up
tree-wide in 6.11.

/jeff


