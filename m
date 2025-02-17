Return-Path: <linux-kernel+bounces-513570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66035A34BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695AE1621A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9B528A2D6;
	Thu, 13 Feb 2025 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5eq3HP+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCD2222AE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467352; cv=none; b=DH3jWDVWAquhWnrEEMIfT04GC0yf39Xztda3VhR7IU01JdBEtfpn+8XuuFut5Z8zJjgE2bWhvDibW+oKZRXltjxLX2RJWHS3t4cXqTwsNJW6vPXIgxAL9RpRmm4pUPK6//KcF0gQIMQK1KRN5sBFZ37d+8GHm5sOjHawDDIQ4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467352; c=relaxed/simple;
	bh=G7hQBfdHAo9mM29YIVfHNMeDDe5T3j3p8DniWSYRb28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHU84B2wkDqxzYMjFOILKGh73jt6s0KXlENLOr4hYfyRrtmaVm/boflzEjvsmCGlX9zBEG7odod3Vl6Ay0270fnca2xfr1UscE5E6kbHYcHNNp67UbmCnzoQciwLZRnDpckF0F/Kh3p3eVqbCEhSevGTbGzij258Pq90uKO4JJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D5eq3HP+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DA2T3H002672
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X7/PUjGwCmpWRxWUtK4W2sPA0ZnQnvaVucugb62nb9E=; b=D5eq3HP+tMC8gmJu
	c8Ku3aXF7snUBfQSsjWuI0RLwtym21RBWvGLwPDc/m1xQu9BqX/Hnw565FBcaU/z
	fHkOSGnp5BOYKlpdS0EymHWjDcaCWxowMy7Z4K0+lpI74ucKMzY5oRlyVIAzCs6R
	sEeRNInfaRvqo/V+UDhispc/rtLNNZSYZ8iyRYLkLO4Fy5GCfftvjcwyNt5lIEId
	n0JCHpDoJhSDE7PICdAvA/G53E6nnTVfJEuAy1LmH9MFNxoqMkSxybzjDdalxtJr
	kKrUrdUc7KCHht+u5uktdwnj5+McC0Th/QF8M/qdZh1zggPZjXC8VrisMXT+TDPn
	+0j3+Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44semp94p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:22:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e19bfc2025so3112436d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739467349; x=1740072149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7/PUjGwCmpWRxWUtK4W2sPA0ZnQnvaVucugb62nb9E=;
        b=hDMHBr5H8OP8e1hT4H6YnvH1iZMYm+REQCmN2RHQD63GLKIz2vsiyRAJrRvvqmT7d8
         HaBdchWD5R39XaV0TPguAFFhLyeVtXd6G2y7lfcWqwXxyEEnGAR/vgIHiRa0sv8YTUQH
         ZIWXg6aKS0OTf20vk3Pvxp8fxdNw6sGCZYWkWEFtCQzstzlWkpsTur/HcFPpL7LfyN1J
         EJKqCAAWfqB6szGpDW4ZtxB27GDe4nGBW3fbSIi0fBetSMOvRhgkfz4XtmLwG6RFCIfz
         Uqu9aY7sz6DgFfWN4MBYLWeDP4pyzFfgJZTxT48mpvOfxydkdEnF6WhLAdsXom8sUyhV
         0p6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdzEShsuMqiEjuKyFx2O5l1unx87zGfJLHbESl9QBZx5VcBsMrnjOVTM/viKdJaxUSwSkfehuYejT0cro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw165Zc8EiKGH0R6IxIZ2fIa+WHbo+nwV4o4dWWOpJURUhO/pqr
	17ZT5FM9XwKDdzmyYbcG5Sw7P7K5jDTgimbJEa6Ic1RKN639paQ4zyuxHMbrUyyCmKWcLCc8m+I
	pYIPinJ5pQ7vyM4NuV+oP2dPwiG1OriCxj87J+6zpzaToAZQYIn4+uKN2pq/6Jdw=
X-Gm-Gg: ASbGncuIW4jIh0qj31OrdamDRJz6hnGBKtgRX4fkooMp1FVZN+n2YG7M18zxINU9LBt
	l3L5tv8gHd3IFMJeb5WtOOQ/KIRElw93YYwWVY2iWVjRzHf2s7C+z8lgIUCqEHYa1n1za3mwfn5
	B3oSYkeJjPM5aBFMfWqZw3QVZz/TMzhbhVQvawK1Mmjs32EdEZiWrQ2plg1HLkzf++B8izsFgO5
	1VNuzVufivRbqG6ZXS7T1ZAoNGsUvNUoqb2YF+ZrP24elnLA76dR0HgkaIDQr0LMP/Zf+6zbA2h
	Zfbj5wfOF6yhPTJQYZQ0NIE013pYf+xmUmr/MWfP9x9epF/WforIBxUh/DY=
X-Received: by 2002:a05:6214:1cc9:b0:6d8:a150:3eee with SMTP id 6a1803df08f44-6e46f8d9580mr36939426d6.9.1739467348684;
        Thu, 13 Feb 2025 09:22:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmfP2aHbNd1c/gB4XKIkYhnCqiIT8aj9i7HRo2I1/gnzLpGgVGu1VWam9QZaenn/3b5fmEyQ==
X-Received: by 2002:a05:6214:1cc9:b0:6d8:a150:3eee with SMTP id 6a1803df08f44-6e46f8d9580mr36939206d6.9.1739467348348;
        Thu, 13 Feb 2025 09:22:28 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322f1sm170303766b.19.2025.02.13.09.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 09:22:27 -0800 (PST)
Message-ID: <0c753d83-d49d-43b4-b871-301b8a93797e@oss.qualcomm.com>
Date: Thu, 13 Feb 2025 18:22:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/msm/a6xx: Fix gpucc register block for A621
To: Rob Clark <robdclark@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>,
        Rob Clark <robdclark@chromium.org>
References: <20250213-a623-gpu-support-v1-0-993c65c39fd2@quicinc.com>
 <20250213-a623-gpu-support-v1-1-993c65c39fd2@quicinc.com>
 <2bfaa1ce-0233-456d-ba2e-5b14533f3812@oss.qualcomm.com>
 <CAF6AEGv6q59dpktR-zR7+4nuz05HMrY7givk8-E4rwCyJ0zNjQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAF6AEGv6q59dpktR-zR7+4nuz05HMrY7givk8-E4rwCyJ0zNjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: J_n6DV1ZQ0r0EC9hi6VQQeZZyJorjcpQ
X-Proofpoint-GUID: J_n6DV1ZQ0r0EC9hi6VQQeZZyJorjcpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=955 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130124

On 13.02.2025 6:19 PM, Rob Clark wrote:
> On Thu, Feb 13, 2025 at 8:36 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 13.02.2025 5:10 PM, Akhil P Oommen wrote:
>>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>>
>>> Adreno 621 has a different memory map for GPUCC block. So update
>>> a6xx_gpu_state code to dump the correct set of gpucc registers.
>>>
>>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>> ---
>>
>> So GPU_CC is outside what we consider GPU register region upstream..
>>
>> And I've heard voices (+Caleb) lately that we should get some clock register
>> dumping infrastructure..
>>
>> So while I'm not against this patch fixing a bug, perhaps we can get rid of
>> dumping GPU_CC here in the near future
> 
> but we'd still want this to end up in the gpu devcoredump...

I suppose if the clock dump is implemented as sysfs, we can export that
func and call it from gpu dump code

Konrad

