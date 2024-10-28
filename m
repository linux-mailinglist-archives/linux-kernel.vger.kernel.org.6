Return-Path: <linux-kernel+bounces-384828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2369B2EED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAAC5B211B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671B1D2785;
	Mon, 28 Oct 2024 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O48pUA0f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55842A82
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115119; cv=none; b=nAmWZxAU0n68P7EeeM+FmPMpCklZj9h66wZukS6k7tOj3czzq5hYv4zltYtI43xd/ZOAI4Xy8MRRpIS1vk78HGxt9RmuajRHO3HFmpIiRUj9vPMSaHuUJk5NOA3re8Rm9+4sGiRxOY2l0zt+tdr0qexaH8KTn3Jqfk8qd8k4HOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115119; c=relaxed/simple;
	bh=PDN9vXO/dZI0+lgwYlek32a4uiMHBlWo7Nb6O/Pgn7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpnonA6LnFVJlkjKxd4S0AdJTgjvf2fw3pivEOur2TO3MUBvIj3PzJqrTkhupraI+QpE0ucEYp2DWJR6+5RrGuXFuuITzvrqIcbZAdIz9aq8krUQy19cPOmjRZZmZaIdFJAQCjN0O+RlONAkgGDIRObwz6EtVEKrAID8TMBeeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O48pUA0f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBFCiQ010456
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fay1WfqSR5ZfNix8IeEA2i6PepY/ruW4Izlv+/bHV0A=; b=O48pUA0fHbAHs9On
	A0j2qJbEO+quqEysLo8jMe9xmB1AaO39EC43zjrhqCmbo+KwkaN03bDuY/4kEHj5
	0q56AdsX/T8s6epYeDPU/w1QshWLaoFh5Tj9XO1n1ExjjEjL/8kpNGXiq8GbR2HB
	vdC/Vrm+fvtqSBU1Nw37m14wASTPpKznP2Gr+863Td8RFDg9e/nEmSzbbgxxJOWW
	epA+v79Fl4OgWSfPr3h1HNAW8+qwLBV0gcEkCPqLVS/7gyZThC/Hhkd5F8HCs9fo
	PyVuYOUu9lrL9w3gozkW61DQ8CmJTBRfkUFOGwVaIz5L5smg33kYxy23LyCLk0YE
	fADK7A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gr0x4nk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:31:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbe40565feso13296866d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115115; x=1730719915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fay1WfqSR5ZfNix8IeEA2i6PepY/ruW4Izlv+/bHV0A=;
        b=Nsqn/oT98xpjBkejMWZaPm0P99IR9CCl5olUxQVt0Btja37NGeyn2pbDKqjlaiqWSI
         dENZa0TbGQZJ49E+IRMn9YH+GbHMZKz/rqg75GI+jQo8ylYa/wXPeieSVBtuE7OgZmNC
         QoNM/MJv/sBjrGJuPpFds26EPYgqvpDEr8oFw1ePMiU73tAYQt8vGSnA4xPzH2hRtBl4
         3KuxpINIjrqqCjyP8uTqeQ5Ybm8YyC4ZsYMftnojyVWdXs8xRkPK/XQLQYcD6e+vKW9C
         3rR5IpySSRI+8FzD65hw0ZMXdIncV98yNGH/kxfDGMWuUBjdTHhE1XRIvc3BNl/TiGXA
         3zEg==
X-Forwarded-Encrypted: i=1; AJvYcCUij/th/Dn2gX7v7zkAmLipcH5F16bgLjRLa9LhmqnbheDgpaICeyFec+VsSFeHuEAmKvDbdjJ5qRZYlsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk402l+Jt1eLvem4xwovc5ISolJ4VH5kLYmKbT+8rwUePexAWZ
	Zn+a1OPxtjdqvpwnokXYQY38p+MZtp/PioiPdppNKQjs/aikGVQ6Oe7bu3yXBWhZS1/qVQ7mm8/
	fJZef05BNepI3ovcL61P5dxXEYdG5FhOQEr9duyi/pZ4RLwxEpkMC7CIjqfA4Iko=
X-Received: by 2002:a05:6214:2583:b0:6c5:3338:45d6 with SMTP id 6a1803df08f44-6d18583be81mr55405636d6.11.1730115114828;
        Mon, 28 Oct 2024 04:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkvgYqxpo2ACrB5DdSvsn7yzDd4MDBFRzTXO/ZPMds196WuLyzCIGXKaPWm/X4ux6U8JcyOw==
X-Received: by 2002:a05:6214:2583:b0:6c5:3338:45d6 with SMTP id 6a1803df08f44-6d18583be81mr55405456d6.11.1730115114488;
        Mon, 28 Oct 2024 04:31:54 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e0b232dsm366494766b.26.2024.10.28.04.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 04:31:54 -0700 (PDT)
Message-ID: <27bea27a-9aa3-42f5-9b0a-df5744276966@oss.qualcomm.com>
Date: Mon, 28 Oct 2024 12:31:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: Fix excessive stack usage
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Arnd Bergmann <arnd@kernel.org>
References: <20241027-stack-size-fix-v1-1-764e2e3566cb@quicinc.com>
 <j2qapo66f64y7ddqlu63dqvog2fdbhnaq3t24wp2srvdt4v7xl@fyqu4ry4wmts>
 <6fea85fc-ccdc-46ec-b612-3712e9431301@quicinc.com>
 <CAA8EJpodjP3rY0Twe9sP37LWwk5ppP36dyLC9WKD6CTDOtmwzA@mail.gmail.com>
 <b7f72f38-2758-405b-abc7-60b73448d8bb@oss.qualcomm.com>
 <vtj3yahojkozge4bvq66ax2c2idbw27c3hs7l6cy3e7ucz4jqb@qge2nckj3mr4>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <vtj3yahojkozge4bvq66ax2c2idbw27c3hs7l6cy3e7ucz4jqb@qge2nckj3mr4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DH0bWKDU5K8kYHiA5laLGacTOmLtLq9t
X-Proofpoint-GUID: DH0bWKDU5K8kYHiA5laLGacTOmLtLq9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280093

On 28.10.2024 11:52 AM, Dmitry Baryshkov wrote:
> On Mon, Oct 28, 2024 at 11:36:15AM +0100, Konrad Dybcio wrote:
>> On 28.10.2024 11:27 AM, Dmitry Baryshkov wrote:
>>> On Mon, 28 Oct 2024 at 12:08, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>>>
>>>> On 10/28/2024 1:56 PM, Dmitry Baryshkov wrote:
>>>>> On Sun, Oct 27, 2024 at 11:35:47PM +0530, Akhil P Oommen wrote:
>>>>>> Clang-19 and above sometimes end up with multiple copies of the large
>>>>>> a6xx_hfi_msg_bw_table structure on the stack. The problem is that
>>>>>> a6xx_hfi_send_bw_table() calls a number of device specific functions to
>>>>>> fill the structure, but these create another copy of the structure on
>>>>>> the stack which gets copied to the first.
>>>>>>
>>>>>> If the functions get inlined, that busts the warning limit:
>>>>>>
>>>>>> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:631:12: error: stack frame size (1032) exceeds limit (1024) in 'a6xx_hfi_send_bw_table' [-Werror,-Wframe-larger-than]
>>>>>>
>>>>>> Fix this by kmalloc-ating struct a6xx_hfi_msg_bw_table instead of using
>>>>>> the stack. Also, use this opportunity to skip re-initializing this table
>>>>>> to optimize gpu wake up latency.
>>>>>>
>>>>>> Cc: Arnd Bergmann <arnd@kernel.org>
>>>>>>
>>>>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 34 ++++++++++++++++++++++------------
>>>>>>  2 files changed, 23 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>>>>> index 94b6c5cab6f4..b4a79f88ccf4 100644
>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>>>>> @@ -99,6 +99,7 @@ struct a6xx_gmu {
>>>>>>      struct completion pd_gate;
>>>>>>
>>>>>>      struct qmp *qmp;
>>>>>> +    struct a6xx_hfi_msg_bw_table *bw_table;
>>>>>>  };
>>>>>>
>>>>>>  static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>>>>>> index cdb3f6e74d3e..55e51c81be1f 100644
>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>>>>>> @@ -630,32 +630,42 @@ static void a6xx_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>>>>>>
>>>>>>  static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
>>>>>>  {
>>>>>> -    struct a6xx_hfi_msg_bw_table msg = { 0 };
>>>>>> +    struct a6xx_hfi_msg_bw_table *msg;
>>>>>>      struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
>>>>>>      struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>>>>>>
>>>>>> +    if (gmu->bw_table)
>>>>>> +            goto send;
>>>>>> +
>>>>>> +    msg = devm_kzalloc(gmu->dev, sizeof(*msg), GFP_KERNEL);
>>>>>
>>>>> Is it necessary after being sent? Isn't it better to just kzalloc() it
>>>>> and then kfree() it at the end of the function?
>>>>
>>>> Keeping it around will help to cut down unnecessary work during
>>>> subsequent gpu wake ups.
>>>
>>> Then, I'd say, it is better to make it a part of the a6xx_gpu struct.
>>
>> I think a6xx_gmu makes more logical sense here.
>>
>> FWIW, the driver allocates both _gmu and _gpu for all GPUs regardless
> 
> Hmm, are we expected to handle / perform BW requests in case of GMU-less
> devices?

opp-table does that for us

In case of no gmu ("gmu wrapper"), Linux is the only entity that controls
things

Konrad

