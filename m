Return-Path: <linux-kernel+bounces-566771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0C9A67C47
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E20B3B75BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD21DD88D;
	Tue, 18 Mar 2025 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MlkrNYcy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA020F065
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324005; cv=none; b=Cnnc4iYQXDWlbgmOOALpo9kLa3sEft+j3KrAw4EJYSTOCvDNgcblV1pX0b9Pt5YkKG++prEdp5yH8wtXDl6nwyI7AXaGminh40upkGby/in757uHyAOZoEvNxv0FbDBd8XkOmbAokT2BfkvVDLFnXxAdcJNJwsT8/uvlOyx8c2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324005; c=relaxed/simple;
	bh=wAcLtNQ9o/zh9L9fmBOLmPpVjd28dTosIHtkS8e7msk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfqvJ5vo7zrw+IWA7mmRfIrt3vZqwDoCBvzL0z0Ipu3oRcsjB+B+bsqXOhdef4GljUBSJtHlQzs0umW3vDwFHehx1LigQbG5emwHz7uK/Hhv1xJ5tYfKqUsX7uSpll3sa1UQqOm8ul35iXYejfldd2HGkxx2cOM8gjBurPetiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MlkrNYcy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ICeDQK029975
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FzUJl3WHjhcEBJ0bAL4awWr4SphxOz4pTp92LYZRfvY=; b=MlkrNYcyX6P+NZu7
	S/IjSNcNXHDT1ZgF9dfbIUM7ZscfiVHKGBdlEEubNoQWMRqQbG4VGEAb8z4EPQGo
	TvYsEAJv251E0GKevM+62pMfPGk3rlJlidDoLJ0R/VLNATL94Y5BP94b7XNGeKK5
	oDSG19Qc1Q9NeBnGxdYMTWAaZT0hAxtVhMqxq1h1MYe6/6ln9x5s/AX6oxifMfSt
	+TNyNuxexf1kpW1/GCqngTiA6qqL022eG5dp4FzJYFbUWNBlwO+wInTcKn6iSuVJ
	FVYqDbPxrPqeezT3bu6ph7hT+2uqP87aDPjzMl0oZ1pzqhEdKHnkNiVkd8/jxo4b
	wpxN9Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f91t12jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:53:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22406ee0243so72334835ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742324002; x=1742928802;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzUJl3WHjhcEBJ0bAL4awWr4SphxOz4pTp92LYZRfvY=;
        b=FZcButLsx8+zDxhRkQ4LSY3XOqHMgC5e551eWt2K6032VzMtYZycMY6wbCw7yN/G2x
         XynEDLu1I5Eo7LmgsQeXVlw64X9gVSHtZORypdF3VBj+lEeW9NDG2vCsltiHU/ezis2k
         HtTdab+Ap4E8eVpFjXUdUD9FxwFF3PKL7K8iJL+c44ybkQuD77vo7gF4I3WNCydtN5Hm
         0U3Xxh/BpywefSiifgoyo5GnBSflBMiRLLMZoxxRoHPlHikKo1PcqyNPYfqwQVnOqlAC
         tFo4Hbrcf/e/2DUh3Llsd5ojnpuOWvEIYKOWJzl4HlLslT/QvTuk/LF/juHD6SMqSPa2
         bcXg==
X-Forwarded-Encrypted: i=1; AJvYcCVfX3m35wv85O0kHE4xwI8GqHFzac/dNPnSGgX7VqOag7/yiyvLHIZIYGhg3J7fG4N3IthRzsSFLepwPX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylfWZh81B9trm6C3b4DxzLGzgT+Cq/H291G/aSlsgCCq3QWxH2
	A4Vv4/kZabdrotJtWAKnnRRvwpWBgN10EfmO4ALnVlCROsjZji0H2ZWAshKY1SL1liPapxHXESP
	tnEftyu/DfnR3ta9TlASzsrJERSxaqsaolPnbHo/4+/CWyuN/JztAhKKNxlSHOks=
X-Gm-Gg: ASbGncvqxXwr75gtWkH8sh56zQ1WTTYjjfkp/0u7yUEE6VuORgmRShVm9/+kitnWWGg
	3TNvqS6wL76Ge6KolApS8PK/oGICFdNBKKi63qqiUvyN900USu4Ys9cutIvi5COV89iXJT2iPeC
	f/zhl24HZVUMEgIhJEkhXRQphhgUwpUUxUOQ74SfdRLK6R1fTXPS33QYnRKru6G6I6xBFKZO9YS
	SPXQ50YYs2nKNXexAR4rM9PUH3VMHw8LMK+lmCs+R4BNV3a1VnrE2vVscXv5Vvm4Co4zx20v6ox
	T+aP1ZH3pG4RWL1+sPXW6tNKrbFMG/svFgCmJ9nhuGWKYCYq7txSFwcXIPiWkcjwa+Ox/34=
X-Received: by 2002:a17:902:d491:b0:21f:61a9:be7d with SMTP id d9443c01a7336-226483de49cmr1686275ad.49.1742324002092;
        Tue, 18 Mar 2025 11:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRFs/PZj/vX5LmwWSynJGPcDMBE/XufCjD2tu+h93eucTtabPbXuyusrAdyiZO2jXqnhWxsg==
X-Received: by 2002:a17:902:d491:b0:21f:61a9:be7d with SMTP id d9443c01a7336-226483de49cmr1685885ad.49.1742324001687;
        Tue, 18 Mar 2025 11:53:21 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd7bb4sm98124335ad.237.2025.03.18.11.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 11:53:21 -0700 (PDT)
Message-ID: <8e5b0ae1-ea1b-4dfa-84dc-c53edd2afc42@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 11:53:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v11 08/13] wifi: ath12k: add AHB driver support
 for IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
 <20250317204639.1864742-9-quic_rajkbhag@quicinc.com>
 <683b16dd-a3e9-4cc3-836a-95f3747d3c0a@oss.qualcomm.com>
 <0da16aae-2fa3-49a4-bdd3-f08a7655365f@kernel.org>
 <f35a6080-8dbd-45ca-8fb4-d6b01a5bb007@oss.qualcomm.com>
 <332db13c-81db-42ad-afcf-3a4262344bf2@kernel.org>
 <31b4ca9c-892a-4ba5-b006-95deed6deceb@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <31b4ca9c-892a-4ba5-b006-95deed6deceb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oJKeunN3IJjrFahhlsgxOr_dZMEu7Csv
X-Authority-Analysis: v=2.4 cv=Xrz6OUF9 c=1 sm=1 tr=0 ts=67d9c123 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=fXXGRLuD1ZcmTYMWEx4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: oJKeunN3IJjrFahhlsgxOr_dZMEu7Csv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180137

On 3/18/2025 11:19 AM, Krzysztof Kozlowski wrote:
> On 18/03/2025 19:16, Krzysztof Kozlowski wrote:
>> On 18/03/2025 18:55, Jeff Johnson wrote:
>>> On 3/18/2025 8:50 AM, Krzysztof Kozlowski wrote:
>>>> On 18/03/2025 16:44, Jeff Johnson wrote:
>>>>> On 3/17/2025 1:46 PM, Raj Kumar Bhagat wrote:
>>>>>> +	hw_rev = (enum ath12k_hw_rev)of_device_get_match_data(&pdev->dev);
>>>>>
>>>>> kernel test robot warns:
>>>>> cast to smaller integer type 'enum ath12k_hw_rev' from 'const void *'
>>>>>
>>>>> looks like others have fixed this by first casting to (uintptr_t)
>>>>> a few examples:
>>>>>
>>>> Cast via (kernel_ulong_t)
>>>>
>>>> But another point is that this patch at stage v11 should not have
>>>> compiler warnings and it's not our tools who should point it out. Except
>>>> W=1, all standard static analyzers (sparse, smatch and coccinelle) are
>>>> expected to be run.
>>>
>>> I ran what I thought was a reasonable cross-section of builds and did not see
>>> this issue. Seems this issue is only flagged with config: um-allmodconfig ??
>>>
>>> Guess I need to add that configuration to my builds...
>>
>> This should be visible on every build on 32 bit archs.

Yes, I'm seeing it now on my i386 builds

> Patchset does not apply neither on next nor on on mainline, so cannot
> verify... Probably another problem to solve here - some sort of dependency?

T:      git git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git

The series should apply cleanly on ath.git ath-next branch

/jeff

