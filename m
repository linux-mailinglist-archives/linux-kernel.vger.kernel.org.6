Return-Path: <linux-kernel+bounces-356321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C28995F8F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC3D1F22C7C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A71428E0;
	Wed,  9 Oct 2024 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QhtEpj+k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981D13B5A0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454554; cv=none; b=uAcDR2hJTUTgijOrIl005qDy1xyqyVyZiJr6zk8LtjkfsHfqE7egQodzx/58SnVFNlFJBTzuRd7gRC6iBHH2GhFNrga5wGykEocRcvsoq5glRgvGkMTF/S4/OJlTjCeYGU7ufNNYkcrk8pqxqTXIgFkqZpmSqwWhRPT/md58jA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454554; c=relaxed/simple;
	bh=7mS4SiUJVzfJXuWYYaZJ2HjbRloY6GzReR3yy5HS2LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MB/pN+0YqeeaXt0joq1MhAhFcWogkQJ9EFv5MQOQUOoMIhse9TMpNAf1z0WPru5qCCYDOVggS0ZCThIjdGpNj0GDhZZnshNchyu051clB87lg0z/lHT3GSREX8Dqj55PkiXDYwEkd+vOZSJvsO+RVyfhQmZXzSh3W2OII8XjCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QhtEpj+k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498FE8t1029481;
	Wed, 9 Oct 2024 06:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BJenFK0HDsT48GOJBsH7QV1crmc86xqqAk8+lqqxkIU=; b=QhtEpj+koPlepHgu
	kXApIc4nEuuFHbywLI+vVLTpSFnGHNmr+65CLrFCCf+p4eh/KImWH2aTtnQJqfmt
	neL5s4zKoln6iZyMICQjBOaNYvnp8qLkTcVahyEQciqcPZKpp4TpV15QeqlifdF4
	32KsfVwOosZO6dtOVhFsuPrqLownmPP4pgKJ7isTiu7sbhR3kubrNlN0BnTbxTZj
	GUCgMwWeD1rcySf7HGjI0VPveOYhhHy8PFGbKZMRxDJ2HwGmmtqBGcrL/+opnboY
	fdRde4BWu3E1iqmK+8+uB09th1Trp4Rvm44SMTLP2VWXlrSZUJ9Y0IVcXTEE5DOe
	366L8A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424yj03h4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 06:15:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4996FcpT013287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Oct 2024 06:15:38 GMT
Received: from [10.216.42.210] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Oct 2024
 23:15:28 -0700
Message-ID: <6cabe8cf-7286-22f8-029f-140b084004e1@quicinc.com>
Date: Wed, 9 Oct 2024 11:45:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND v1] arm64: defconfig: enable WCD937x driver as module
Content-Language: en-US
To: Trilok Soni <quic_tsoni@quicinc.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <kernel@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <krzysztof.kozlowski@linaro.org>
References: <20241007082312.2136358-1-quic_mohs@quicinc.com>
 <9d105bdb-b0d7-44b8-8bab-a5c161759567@quicinc.com>
 <df41b180-d669-4829-8d71-77c9cc575b7d@quicinc.com>
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <df41b180-d669-4829-8d71-77c9cc575b7d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MLz9qvIeE1fRqfACJ5rfLxPWOeaf6vsK
X-Proofpoint-ORIG-GUID: MLz9qvIeE1fRqfACJ5rfLxPWOeaf6vsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=727 mlxscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410090039

On 10/9/2024 2:11 AM, Trilok Soni wrote:
> On 10/8/2024 1:40 PM, Trilok Soni wrote:
>> On 10/7/2024 1:23 AM, Mohammad Rafi Shaik wrote:
>>> Enable the Qualcomm WCD937x codec driver as module as
>>> is now used on the QCM6490 platform.
>>
>> Rephrase this sentence a bit. "Enable Qualcomm WCD937x
>> codec driver as modules since it now used on the QCM6490
> 				^^ it is
> 			
>> platform" ? or better?
>>

Ack, will rephrase the commit msg.

Thanks,
Rafi.
> 


