Return-Path: <linux-kernel+bounces-236369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4D91E13F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED33C286886
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66415ECD9;
	Mon,  1 Jul 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MV7rCaNH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF267152E0A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841876; cv=none; b=W9/0+ehwYsuxqJn/DNgiXHW4gyGeAzXjuYnH3ayj6P5vAm8cz8kmr+4XKn1By09ZeshOvOebZgIhOchHpOoBX4YZ8A9NSBSl+kBF10dokGxVYLL968u8iegkMd/aao185PfBJnrsS9FWxlOz97nvGFPH/GxJYz01f5YBM71uXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841876; c=relaxed/simple;
	bh=qZlUAJG7LQ0EB8UmllTEWUFe6vF6+16bqu7qE1q+Ylo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kf3NiuCI7mlIrY7bOGLYo50F25A1XbTjIje4yN0VypXP3HSY3jcQQL5QdN5njgp29IpUg1hm4wp72AkjCnH3/pvzGiynWLqjhj0td7NTC3GQ1kzJf44C6HNEVXYrAFcfB5PMI7Lxwm6iXo00ZxO9thRumz4OayIkxbVyEdLwnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MV7rCaNH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461AN4X7026803;
	Mon, 1 Jul 2024 13:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wkwol188JKz1B5rW/B2G6vVOO1OrwlFykqlmh5zqw50=; b=MV7rCaNHpn+PXDsa
	3Xl7feCm29yqBcWJ8LmecGxdkD9et+XGl+uKsA0aTwJmwPEatQeRSoXoB5SPDNj2
	L498AAA92W+79pPhwk4gvpN5G4+uypZXazXWmSbEZ1cJkFa/DrkhD3PIJa23j2Pz
	zDx4WQNBqCuvjtcnaipainxpIxqahNtq1ZSYTUobeIPw8k4rS8RXRlz/slR1JDhD
	j1cfH8g3D+JvZBloke7BvGZkYY1JDEcwxa5L/Q9i3Qz963NXxOt2y+rKbDySAxfJ
	axAZtxYZmPXeCHYIRABnVM7g7yzcFaX/Gh2xqCGckb/IQjm8KwlmlSVu+phZVNSX
	PlNmxw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027yf4n8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:51:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461Dp6vd032388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 13:51:06 GMT
Received: from [10.214.66.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 06:51:04 -0700
Message-ID: <bf0d9278-2b57-079e-cca5-21163e187ea3@quicinc.com>
Date: Mon, 1 Jul 2024 19:20:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm: Prevent derefencing NULL ptr in pfn_section_valid()
To: Waiman Long <longman@redhat.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240626001639.1350646-1-longman@redhat.com>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20240626001639.1350646-1-longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AwV5igHBQTKOIQMPkCqXNOuxXVHgNfL2
X-Proofpoint-ORIG-GUID: AwV5igHBQTKOIQMPkCqXNOuxXVHgNfL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=657 phishscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010107


Hi Waiman,

On 6/26/2024 5:46 AM, Waiman Long wrote:
> Commit 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
> memory_section->usage") changed pfn_section_valid() to add a READ_ONCE()
> call around "ms->usage" to fix a race with section_deactivate() where
> ms->usage can be cleared.  The READ_ONCE() call, by itself, is not enough
> to prevent NULL pointer dereference.  We need to check its value before
> dereferencing it.

I am unable to see a scenario where ms->usage will be NULL when
pfn_section_valid() is called:

1) In pfn_valid, valid_section() check ensures that pfn_section_valid()
is not called as the section is marked as invalid.

2) In pfn_to_online_page, online_section() check ensures that
pfn_section_valid() is not called.

and in the update path, we do:
     kfree_rcu(ms->usage, rcu);
     WRITE_ONCE(ms->usage, NULL);

Could you help me in understanding about what I am missing here, please?

> 
> Fixes: 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing memory_section->usage")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/mmzone.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8f9c9590a42c..b1dcf6ddb406 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1980,8 +1980,9 @@ static inline int subsection_map_index(unsigned long pfn)
>  static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>  {
>  	int idx = subsection_map_index(pfn);
> +	struct mem_section_usage *usage = READ_ONCE(ms->usage);
>  
> -	return test_bit(idx, READ_ONCE(ms->usage)->subsection_map);
> +	return usage ? test_bit(idx, usage->subsection_map) : 0;
>  }
>  #else
>  static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)

