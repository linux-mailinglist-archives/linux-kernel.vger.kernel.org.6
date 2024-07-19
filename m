Return-Path: <linux-kernel+bounces-256865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87374937184
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383C21F21D35
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875C415CB;
	Fri, 19 Jul 2024 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C93XvrLB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C654696;
	Fri, 19 Jul 2024 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721348942; cv=none; b=uR+ECjjEu2Z/U6n+V1HE95UtYgfRjSUH0ye/n8BhBscwgJrNOqGSP1tShxtjeJLyCV3/bf2KOZ7igkOJw4wTdxBb7igfKmWG0FMWZwjmX4D0QD9U2RuiwmnDpSwBUAQ7Ibq1+8VT3vJCjY1biOpCXNksZDKgpG/WS1xWrFeQ5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721348942; c=relaxed/simple;
	bh=no8GmEKJTU1y8iQRm4w5rWTLU8ovq08KNHL05+n1wvQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=PFHvFrCjFaRK7FnjOchenT3vULd2UpFe27paXhqyWAqXy/l5TVLLLHOC6dMBYm6Uu9XaN17yc65B1DUDgTqnBWOJCXOjF8k24ob0OOP7eKhEQ0/sD+87DGjmAtcfrurQIE4cQldr3NB29dDIW76Yd1T1UOeg8v7FxoY2GVQXfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C93XvrLB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IMZRd8002464;
	Fri, 19 Jul 2024 00:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	an2/RsoVYlWrrx9EEIeqTcHjZaOLueSvo4PzAM3K8rU=; b=C93XvrLBhqqG5rZl
	7i+5dpEepE+jGtg/7wX2k7ZSrXHasuhO/9ZfDoBuNHV2/fBP+dYfRabAyDyKFPj8
	7Hs92soIzkEJpWVozqpQHTFxCMMA5JkNqxi+xJnjvtQoa10iKwh7oAlK7LiBNIqi
	gucG1wli862SuOGkicP8lkxHE3JwWLUuj7ddIbeD3fB1zpkk+N+i/+KKOEMz4j+d
	wDJwW3qrNlrhECd8g3S+IuMLDD7Dkg8XjOQ0z2MUCpqS8+SDsxlJIFEtFiwE3GCV
	wPR9e24qhicqqHxZLpUonLJU314mnc1Xqzd356ozUoSTZqqIdGcCTvK7/WC07Aec
	Ixg1dQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfppyt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 00:28:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46J0Sanb023576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 00:28:36 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Jul
 2024 17:28:36 -0700
Message-ID: <b1bec21d-9d60-491e-8808-ebb004b9c2fe@quicinc.com>
Date: Thu, 18 Jul 2024 17:28:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] crypto: X25519 core functions for ppc64le
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Danny Tsen <dtsen@linux.ibm.com>, <linux-crypto@vger.kernel.org>
CC: <herbert@gondor.apana.org.au>, <leitao@debian.org>, <nayna@linux.ibm.com>,
        <appro@cryptogams.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
        <ltcgcw@linux.vnet.ibm.com>, <dtsen@us.ibm.com>
References: <20240516151957.2215-1-dtsen@linux.ibm.com>
 <20240516151957.2215-3-dtsen@linux.ibm.com>
 <e27ccb59-0a3b-4845-bec4-f64830b2492e@quicinc.com>
In-Reply-To: <e27ccb59-0a3b-4845-bec4-f64830b2492e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0sUGBt48Ya962kHJRrxfac6FkMbGNNfl
X-Proofpoint-GUID: 0sUGBt48Ya962kHJRrxfac6FkMbGNNfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_17,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407190002

On 7/18/2024 5:25 PM, Jeff Johnson wrote:
> On 5/16/24 08:19, Danny Tsen wrote:
>> X25519 core functions to handle scalar multiplication for ppc64le.
>>
>> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
>> ---
>>   arch/powerpc/crypto/curve25519-ppc64le-core.c | 299 ++++++++++++++++++
>>   1 file changed, 299 insertions(+)
>>   create mode 100644 arch/powerpc/crypto/curve25519-ppc64le-core.c
> ...
> 
>> +MODULE_ALIAS_CRYPTO("curve25519");
>> +MODULE_ALIAS_CRYPTO("curve25519-ppc64le");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Danny Tsen <dtsen@us.ibm.com>");
> 
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning with make W=1. I'm in the process of building 
> ppc64le with CRYPTO_CURVE25519_PPC64=m to validate my suspicion, but I 
> expect this to generate a warning.
> 
> Can you submit a follow-up patch that adds a MODULE_DESCRIPTION()?
> And since I'm trying to fix all of the existing issues in 6.11, Herbert 
> can you push this to Linus when it lands?

And my build did produce:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/crypto/curve25519-ppc64le.o



