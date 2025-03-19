Return-Path: <linux-kernel+bounces-568592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC30A69816
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8060D3AA9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3912E209F54;
	Wed, 19 Mar 2025 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="boMvUTr+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF21DE3A9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409174; cv=none; b=gOlXqzTYJQlotictrt3nTasFW9Em/wKFMVBp66ISOmN8tv155R/XP5hIpIl7h8XD3iIGxQ8xJvKnC0c+YPX06E78nyPJZTvMnDI1ZLwTkQCtbbPFTx+SXuASXWSRMFtrQwyJLEEoVbEZIHjL0EsrBNEh1ZnogodrX7tWcpIUBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409174; c=relaxed/simple;
	bh=znAvZ1m5fb9Fv+Y+O6o+dy2qNhj5RxVbzICq/W7KwPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEKvDene3yubNYyPoFVWWGbOGEJnIRRlklN6l0tCgm9iZi0ggQlu9NanbXFQ0X2wadbOtN/qwxlWCL2PF51v4I8x9tUlu71Y6oDm8vGeUcYaPN2d6ewZJmMCk5JEdkeR7qSmLJ7Kg2EgA39MkOfWUnPwg8vhp1jnxg+wXf3iAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=boMvUTr+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JF6e0V015921
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6mIeomPLPedDRzmXiIuauhMKXkTwEh7EaY68qsi9Cqc=; b=boMvUTr+dwrK0kJ/
	CJ7DtB9DBjlL4nMgK+gGgSaXIZArWimf+vDP7HbTW5vuJZqzKx5gDU1NxLq/ENra
	Pq/Je0cpGd0X5AUsi6N/a/Z30/YggwWW7MKjq8oz6COA+Nj9quuMP6IErudDiCES
	syxVYygKonntqDmOPUrYO/Pj7k6UM9qEql5q3j6BSZHO+oQttQeIGO++avOtOMFP
	JPZPzeHDqBScCaSupGg9M+z6Y7pmwY07oodhWv7sxcpci0Prkvgpg6EHP4bKh1Up
	RUV2RhdM7s7GuKoxrjiKxMujMLM2THf3lSZMlV+l+kvsk90c/LojtYqrr24I7+tJ
	Rp/zOg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g09f0j30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:32:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2254e500a73so94265845ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409171; x=1743013971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mIeomPLPedDRzmXiIuauhMKXkTwEh7EaY68qsi9Cqc=;
        b=UoKaQ4cTgtlmUvMjKBGWW6uTGhZVKZhP6nxkN0cYKAw9/NmRdn7gZmDf2/Ex5YXung
         MBJORqd+pYGZaNwvea9XL3DPp2VfWYEQ1sAyG7U2tTKnv0tu5Fa0f4Lnw5mFlPNexhUg
         piNiijxoiVW7gXB8/5dKXd7cC8yjPmpog1mA5Hvrp81svNwr8YyuHmP9F6I5lW/r/oLR
         i564ERFGub/DW0AaazYYKDZQD9yQIxPWEQrsTla0kh89eUt8klkFpmIvEaQqek49jyas
         eCrJ7C2pW0EnsVrPDfhRle2CSeVnU6yK2WuI64BkSQiClorxWdBjxvUTnfgUW4FBmunl
         5rgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqf5GFrDCjNuhGtSHTg3hjosKeW9NEVlIqhWAcu0osH5jGTHuiLntijgqnkmnq8E5doROLbvNplH54GDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyd06HGTch+cL6Ko7AyXMqNLcGqwt37ngQ1sEFIqI5y3EbRzK
	GLlaURziFJQ+O4JVjV8utYyNY0SzKOEHQza0DsVjAH4YOcLzU7DvoIlyVZgVrK0xZA7kOGZP5bc
	arMAhTY9metHVnI1S0Ony0TD1IZrmZtFQMhE5IxwehZl8M81rOVeAtpZHXxYm4+Y=
X-Gm-Gg: ASbGncsh1uag67DCIBv6V3irs8wFwf6xZFC2OjvN8O7K+rLMwHlAs+2lFZhxhwujD74
	q5BNPJP1NMKRh20ho+ibpNmVq2yExiwTob+5ztPa4K96VipWCou03j4aN40V9ZZ3yXMZLCho/Ln
	86zqARuIEFTc83YdZHXC3IEQaFDFs0m2eI+mpJdj0lR7MAbkMnMTCe1WUqU2JVTDgluvpkxp302
	7B/WEHuDI5JPjtODwpfKArPoxnjp0XtMK9vkue0CO3BHH7KP1duznmxwPl2jyOSr8Y8QeC49AID
	Wi3S8Qtgw9sv5TkYKeCoE+UPvV5U6XqfcXCLOG98Y8kevF34C8onnt/Q70lW3HwG6mfBayg=
X-Received: by 2002:a17:902:ea07:b0:223:26da:4b8e with SMTP id d9443c01a7336-2264981b58fmr71235805ad.4.1742409170993;
        Wed, 19 Mar 2025 11:32:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGazHPV9+2UyMKutqyNnaqlMLBrR+fcmmqZeYlBjWXfurgn8y0zm40TDXmtXT1NFf0ZNxc+8w==
X-Received: by 2002:a17:902:ea07:b0:223:26da:4b8e with SMTP id d9443c01a7336-2264981b58fmr71235405ad.4.1742409170628;
        Wed, 19 Mar 2025 11:32:50 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe890sm117378585ad.188.2025.03.19.11.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 11:32:50 -0700 (PDT)
Message-ID: <770daf27-ae9c-4ed5-87d0-aadcc3b74bbd@oss.qualcomm.com>
Date: Wed, 19 Mar 2025 11:32:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        neil.armstrong@linaro.org, Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
 <8b05760b-db99-4b43-8444-d655b18d3699@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8b05760b-db99-4b43-8444-d655b18d3699@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BvKdwZX5 c=1 sm=1 tr=0 ts=67db0dd3 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=xnwWoSdEmYegiN_xJ5oA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: WAHa4N7fWhhi453GVb5opX6di0fo9mUZ
X-Proofpoint-GUID: WAHa4N7fWhhi453GVb5opX6di0fo9mUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190125

On 3/19/2025 3:27 AM, Krzysztof Kozlowski wrote:
> On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
>>>>> ---
>>>>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
>>>>> change-id: 20250303-topic-ath12k-fix-crash-49e9055c61a1
>>>>>
>>>>> Best regards,
>>>>
>>>> NAK since this will break QCN
>>>> There is a series under internal review to address MLO issues for WCN chipsets
>>>
>>> ???
>>>
>>> The original commit is wrong, this fixes the conversion, nothing else.
>>
>> Nope. Driver changes to enable MLO with WCN chipset are not there yet.
>> Setting the mlo capability flag without having required driver changes
>> for WCN chipset will likely result in firmware crash. So the recommendation
>> is to enable MLO (in WCN) only when all the necessary driver changes
>> (in development, public posting in near future) are in place.
> Really, these are your answers? There is regression and first reply is
> upstream should wait for whatever you do internally. Second answer is
> the same - public posting in near future?
> 
> Can you start working with the upstream instead?

There is a lot going on in this thread. I want to address the big picture. It
is no secret that Qualcomm has historically focused on downstream drivers, and
upstream was mostly an afterthought. But that mindset has changed. Qualcomm is
fully embracing upstream kernel development, and has actively recruited (and
is still recruiting!) experienced upstream Linux Kernel engineers. And in
places where there are shortcoming, Qualcomm has partnered with companies like
Linaro to bring in needed support. So Qualcomm is very much "working with the
upstream." We may not be working well sometimes, but many of us are still
inexperienced with working with the upstream. We are coming up to speed.
Specifically for Wi-Fi, we have a large number of engineers who have primarily
worked on downstream code who are now working on upstream (including me!). And
we still have the issue that many of the products we are shipping now still
have a lot of downstream DNA, especially when it comes to firmware interfaces.
So please bear with us as we learn and evolve.

Please keep the constructive feedback coming. And remember, the more detailed
the feedback, the easier it is to incorporate the feedback.

Thanks!
/jeff


