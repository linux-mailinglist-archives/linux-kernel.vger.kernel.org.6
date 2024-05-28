Return-Path: <linux-kernel+bounces-193014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A84A8D2599
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB252837B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078C1327E5;
	Tue, 28 May 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UDgGz4cm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFDB2FB2;
	Tue, 28 May 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927383; cv=none; b=Prh3HzzDn2R8aDz7BN53U74SjQZ5uF8Fh2k3/D89tnYmWkIGMTnOVn9FP/cXreBFqXQrOm2aNZ5W6VVSz8LZS3c9hKDeU6jgNtY2DLtLtmcYQX8hik+j6KXr+LI2NxxGtxEGNYsAaklyVakprzG6Q/lzucQXlD0oAfsCMjY2n0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927383; c=relaxed/simple;
	bh=SDM3T88aKtVS+Ug/fU9kGhfpCs3h4GTd1KHJIR+20Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SPb76G8xeXvYdEBj5xpEfM2VGsmunw8AKaC0ge4a63xMjijvcpVPIP8Ahi9yQKlr0qJnmHr1X5a6txJEVEIAofi6vSlhvUQaTYsaBSBj7KFkSf7X8us1Z6NAgRRXz0p7DIJUvmdAnELtag4U0uiD+5aKY5gKUKELpLsQQZXgfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UDgGz4cm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SBNawN025892;
	Tue, 28 May 2024 20:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aAxBwMD0lZhhNbg0upNk5vseG8fs7A2eLML6WG5ZKxM=; b=UDgGz4cmCE0OGa76
	lUSM8a7Ft9KsCD46Gw7KTpBVsyTX/OAy98fwKbQaQaTy+FwdjqKa0R9HMir8rrta
	L3YHuJiL6NKPN/0Wssto6xy+8LsSxlyr+G8qpVcSYca24qe10PGa9SqSLQAnPDXx
	jbLqe01zeYUcB5lIpqVcXEbar7tdoZdXH92gLgm0Ll51QQaegkxUGUuKDMSpXXLh
	t398zMGAyKz0kGDtUhgaB2IjjeRzyXWoIChj0dIc92U4Fc0pdGVYw42qlfeF8V5Q
	Tjfr4BdszBqAkJCknZ5PFwUVPTLnp4jtrtj+tYXcY98m6QdfpufTOhE7eDkt22Ju
	oQN77Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0x76hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 20:16:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SKGCgP016550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 20:16:12 GMT
Received: from [10.110.122.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 13:16:11 -0700
Message-ID: <1d256e7d-2b39-42ce-ab19-94b8a48b90cc@quicinc.com>
Date: Tue, 28 May 2024 13:16:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/ww_mutex/test: add MODULE_DESCRIPTION()
Content-Language: en-US
To: Boqun Feng <boqun.feng@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240524-md-test-ww_mutex-v1-1-4fb8c106fe21@quicinc.com>
 <ZlYbst1xppRKBxwm@boqun-archlinux>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZlYbst1xppRKBxwm@boqun-archlinux>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4dyoSxBmA7tYAMpall_vAwoI1VprRk-8
X-Proofpoint-ORIG-GUID: 4dyoSxBmA7tYAMpall_vAwoI1VprRk-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405280151

On 5/28/2024 11:00 AM, Boqun Feng wrote:
> On Fri, May 24, 2024 at 05:18:11PM -0700, Jeff Johnson wrote:
>> Fix the 'make W=1' warning:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>  kernel/locking/test-ww_mutex.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
>> index 78719e1ef1b1..0fab96137ddb 100644
>> --- a/kernel/locking/test-ww_mutex.c
>> +++ b/kernel/locking/test-ww_mutex.c
>> @@ -695,5 +695,6 @@ static void __exit test_ww_mutex_exit(void)
>>  module_init(test_ww_mutex_init);
>>  module_exit(test_ww_mutex_exit);
>>  
>> +MODULE_DESCRIPTION("API test facility for ww_mutexes");
> 
> 
> This looks good to me, but seems to me MODULE_DESCRIPTION() is usually
> placed after MODULE_AUTHOR(), could you reorder it a bit? Thanks!

Sure, no problem. v2 coming up.

(I had automated placing an empty MODULE_DESCRIPTION() before MODULE_LICENSE()
since every module has a license but not all have authors).

/jeff

