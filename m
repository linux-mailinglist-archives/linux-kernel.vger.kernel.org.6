Return-Path: <linux-kernel+bounces-382183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618E9B0A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7881F217C3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5237B17BEC7;
	Fri, 25 Oct 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FIyjcyfN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD89021A4BF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875788; cv=none; b=TbP985HspV98J51wfjWi2su+pNxonzjXN9h3oPdqXs5gu64NvP0QKuAK3x9QCQwvb3DGYj3CfJg6oGNsHyPz96bfJyxr+Q9GMocuigbB7Bj4xK1v7IRisCnO6nigcoNpeqDOqO1Q2g5NRVp3JVCqO+Os/wWa3koZFebCmqESl8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875788; c=relaxed/simple;
	bh=WPGGcqaGiVoPmUoLM39b0KmLkesOa7TEdpIDHgfpP54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6Bxybn0TlG4/meXd++RQJb8y9e2TXjUeNAhuVjQX//O251pOZWjGeJZU6kBR5lCq8yQaGG5TXMcF6BNcCykTCUXX4J661kDxGevahoc2EHGPbONQ6Yr2eyKa2vCazPXpI+3qt8oc98uCpKA5PeG8R+jR1rpS56+Kl2eqnwsKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FIyjcyfN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFqi3u031742
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vcTKvOKbWn/IHq1qmbozjkGUKSKdBdJRZlsqwxZRKHk=; b=FIyjcyfNZM2gA28+
	/9+xiEfvFxJtXtxdG+VY/dCz8RhUszFCmuYtr4Srb26vFA3Kz7RxRAj7Tqc0ZBzf
	BBIskolE9HHpucIjVPt8bjj03KGFjPF2n0M0DMjlJMTOzfUGM2JPgCfALDdurNwP
	yiRhgWvgAJPzRzTSS8vnK/ZDE1jQj9K1laOvHxCf8frvoVbzIYfgYDUR+Xt9EOIX
	ROGTQGWfYUlG8oFrJ7q/6jnerBBKIBhzFHrtbDcZUJl3z3TiXg3J+HiLp/rA0fGG
	uuOaSVRe+86i0H+j3t480M3iY1Y+q+BDEW1QXsscTcJJa1DmqVUrcL4tuhEBLhYW
	egc9wQ==
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3whxy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:03:05 +0000 (GMT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83aaad1b050so34760839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729875783; x=1730480583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcTKvOKbWn/IHq1qmbozjkGUKSKdBdJRZlsqwxZRKHk=;
        b=Sd1+DUMSLupTp1hAe9dby/2zqNKGQcl/VJ5h8AvKDLTMpJIiJA7gviGrKHacbgvrta
         eWjnPTk8vkejUUa5Hu5vjQUTUsMwcg8Th+LnmrOykk5wo7SGmoDOvXQmtj9Dl6WyFNjA
         8EPOg0fV77XQ3tEhzT09gc9IMRvw1BLBJAVRz4uIYheOfywVywdP/185nKsFHmF83c9c
         YCdC5bF97zcUCHhJUSSRdF9RV5fwaEUd0bAXQYxuPEVsPwwKpnO9SPJwHR9x1P7Fivqk
         rVKz0ZZN+a2o8kn0c+OpxpKHqPTkZuSl0zqw/7hhe9Obtzr2NCKVJGXzvYXJuhsOzfzJ
         cdpg==
X-Forwarded-Encrypted: i=1; AJvYcCVZkgFK7+8j2jK0sflNVPBXv+phtwpJJMc0zBCo6XlOu+BHkjWpg6NCp7D/epazkRXF/GLJkUyWYircEFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ld6/+BHYYPZb5ncTC7A8KkYMWrzuPLEaAhhKLkgFuQ+j1plx
	kxn6e1oS9zY19ZxFvN4TrX7s0ReZaoyCSAXf39HYaxJvPQYCjLWmdbSdCapB6tWqil2+CWkYtk7
	Hq/DZqQawQXWY58CI7r/j+y+Mrzmm5Zrx0Y68WnmL0G+GR6j8PtbJNjhS5M7eiI4mQPWnfFk=
X-Received: by 2002:a92:c56f:0:b0:39a:f126:9d86 with SMTP id e9e14a558f8ab-3a4e806d563mr4396615ab.0.1729875783518;
        Fri, 25 Oct 2024 10:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFSKWdgG6048ZgDp7DafsAW3/5cONZNPlZ3U7SrY42s9TAXMiE0WlKFoU+kd/+YC5PraD7sA==
X-Received: by 2002:a92:c56f:0:b0:39a:f126:9d86 with SMTP id e9e14a558f8ab-3a4e806d563mr4396375ab.0.1729875783022;
        Fri, 25 Oct 2024 10:03:03 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec81a1sm90067866b.25.2024.10.25.10.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 10:03:02 -0700 (PDT)
Message-ID: <6852b25f-94a4-4e04-adc5-5c79eb1f17ca@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 19:03:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: Rework BCM_TCS_CMD macro
To: Eugen Hristev <eugen.hristev@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20241025084823.475199-1-eugen.hristev@linaro.org>
 <c1d4c2b6-85a0-467a-930c-ac2797c72699@oss.qualcomm.com>
 <a4c44b88-d106-4365-b405-ced561b9e526@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a4c44b88-d106-4365-b405-ced561b9e526@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 90ywRAnGgDd578rw5qyLVMQjECW0Sjlo
X-Proofpoint-ORIG-GUID: 90ywRAnGgDd578rw5qyLVMQjECW0Sjlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250131

On 25.10.2024 2:06 PM, Eugen Hristev wrote:
> 
> 
> On 10/25/24 12:03, Konrad Dybcio wrote:
>> On 25.10.2024 10:48 AM, Eugen Hristev wrote:
>>> Reworked BCM_TCS_CMD macro in order to fix warnings from sparse:
>>>
>>> drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer
>>> drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer
>>>
>>> While at it, used u32_encode_bits which made the code easier to
>>> follow and removed unnecessary shift definitions.
>>>
>>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>>> ---
>>>   include/soc/qcom/tcs.h | 19 ++++++++-----------
>>>   1 file changed, 8 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
>>> index 3acca067c72b..130ed2582f37 100644
>>> --- a/include/soc/qcom/tcs.h
>>> +++ b/include/soc/qcom/tcs.h
>>> @@ -60,22 +60,19 @@ struct tcs_request {
>>>       struct tcs_cmd *cmds;
>>>   };
>>>   -#define BCM_TCS_CMD_COMMIT_SHFT        30
>>>   #define BCM_TCS_CMD_COMMIT_MASK        0x40000000
>>> -#define BCM_TCS_CMD_VALID_SHFT        29
>>>   #define BCM_TCS_CMD_VALID_MASK        0x20000000
>>> -#define BCM_TCS_CMD_VOTE_X_SHFT        14
>>>   #define BCM_TCS_CMD_VOTE_MASK        0x3fff
>>> -#define BCM_TCS_CMD_VOTE_Y_SHFT        0
>>> -#define BCM_TCS_CMD_VOTE_Y_MASK        0xfffc000
>>> +#define BCM_TCS_CMD_VOTE_Y_MASK        0x3fff
>>> +#define BCM_TCS_CMD_VOTE_X_MASK        0xfffc000
>>>     /* Construct a Bus Clock Manager (BCM) specific TCS command */
>>>   #define BCM_TCS_CMD(commit, valid, vote_x, vote_y)        \
>>> -    (((commit) << BCM_TCS_CMD_COMMIT_SHFT) |        \
>>> -    ((valid) << BCM_TCS_CMD_VALID_SHFT) |            \
>>> -    ((cpu_to_le32(vote_x) &                    \
>>> -    BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |    \
>>> -    ((cpu_to_le32(vote_y) &                    \
>>> -    BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
>>> +    (u32_encode_bits(commit, BCM_TCS_CMD_COMMIT_MASK) |    \
>>> +    u32_encode_bits(valid, BCM_TCS_CMD_VALID_MASK) |    \
>>> +    u32_encode_bits((__force u32)cpu_to_le32(vote_x),    \
>>> +            BCM_TCS_CMD_VOTE_X_MASK) |        \
>>> +    u32_encode_bits((__force u32)cpu_to_le32(vote_y),    \
>>> +            BCM_TCS_CMD_VOTE_Y_MASK))
>>
>> FIELD_PREP/GET?
>>
>> Konrad
> 
> What would be the difference/advantage in using FIELD_PREP/GET instead of u32_encode_bits ?

Probably none. I thought it was a function and not another magic macro,
as it's lowercase..

Doesn't le32_encode_bits do what you need then?

Konrad

