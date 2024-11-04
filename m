Return-Path: <linux-kernel+bounces-394550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DCD9BB104
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3882F1C216B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C501AF4EF;
	Mon,  4 Nov 2024 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MEHdljP9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A81ABEBD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715897; cv=none; b=X+rc6x4OFLLDDClJB1E+I7EqI6XJNp6cbRKGYoeh12qzwS4hHckr7LbUO8qE6HQMmU/42hnefgGVT71bPB4zCMoK8lvueL/xXC6fqdgaU8P6bVnql5x2zdPkhlOP+gbNywp61BqzqWtYoJI7Am5v5QlbdU1boNyOHXhvBu3xajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715897; c=relaxed/simple;
	bh=neOwlgAmDjdd9JB07s8sV/anEzMf8n44yhyjK/5FkJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUPAVxKPtLEWb305WDcmDXFDvzhcOpsNsTH0YMa2+1AODmaCdIhW4i/nCzI00J2tqpmWT2FGNTzhsWrXNn2tfXIdDX4tsrFiFhqKj4hxNzaxcMnsjxF3tYcCdTs42LVixzA+sO9prUVMVElM0+g3TUiB7GeAzc2Rg6eZJwnTk3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MEHdljP9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3Nlq4J027378
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 10:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	14N8KBf1u26bmeVNCJGFmppsaMPBOux6kP+dUcgR0Po=; b=MEHdljP9jKFt1lW9
	RnAaj2PFcfzL6eaw+v9sw4oiaXsl5Qt/9cGA+UjdPW6J0Rmm9tdyBOu1+znDKQBS
	N4u5Fvon/GQ3MBcNY+O+5xJwYYfSRfuBdFKYuAUSPEvdgncytSqGRG1MLkMd+Fn0
	xAz/vHqrWkh7JzLWzDI32q4r9o13BoJwW5CXgg1vCFYMaXKqo+Cre2y/hFgdwOko
	LWqu7TQqKSm+ki7uid6oKg5JU0PwiqCG11ujqSDGYL8WP5jfGK2csWVuSrEK8art
	XoXtm8Loa1vftO3UF1x82j4JTUlkURtNFcBpg4sX1Vfs5Xz5YuHOgd8IGXiOFeuu
	a4LxSQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ncyxutkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 10:24:54 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7180917b56dso430005a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730715894; x=1731320694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14N8KBf1u26bmeVNCJGFmppsaMPBOux6kP+dUcgR0Po=;
        b=An6XEsvS/MWeUh1gli+IxfGh/l21oK3Txt48u7DZ3Y7cqegk5NGZwAE+DuhyFZUT0C
         zcEvygwSXRxV7PiXjlpzG/uP5PZL1Q5fmTnHpc+CFk0szMLTDIL8X2l9p9KU6jTWVHGQ
         3/649Lkera9zxU5Ida+u4a/6WBAhKGjIHvxhnG5Fs9X8cJfiXTD1aPFY9pXOFCyPmCWK
         czOADr89Y7YVnRur7BuYNx9r7VlWN84i7T/xi6oH2as4t/zJTJWIsuAiW7eJMXcxz5La
         D66LTypMN+s/9dezbqlWz9HAFFWj9YrIqZBNVnXJFXYQ51qm6VkVSq2b+YEh5kcvmXJw
         SuOg==
X-Forwarded-Encrypted: i=1; AJvYcCVc2obO2jAk0PITi3I4T/QH30QGfZhvwIwospVFIsB1PKTSPsajhix3SuFGE83uM3//P6PPdD3y6Vcd+wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpdF0xcKd356U8jujv1yR/FYlrxL3TgOzyxPMLuYiQu+OOgOA
	iHL8ENevBgY+RVWYcfunvH4DVIRwiyPQ+hQBjpDPqr/1IJ6enY+zqWXpmXvvynWYYcUlmLnNwoG
	iZsS415NH3y6s5TkG3m4Llb6/SyY0I9OSfvW6F5v48gJCJBerGaZM1uNpGVQhJRk=
X-Received: by 2002:a05:6870:8a07:b0:27b:9f8b:277b with SMTP id 586e51a60fabf-29051dd5067mr6199549fac.14.1730715893737;
        Mon, 04 Nov 2024 02:24:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhQM8hd98D0U32vPf+b4FFMEFXYKxCKvHKBZQ3R89HcMCulRi8LEhSSN9eeCUQJwHA5tmbQA==
X-Received: by 2002:a05:6870:8a07:b0:27b:9f8b:277b with SMTP id 586e51a60fabf-29051dd5067mr6199541fac.14.1730715893442;
        Mon, 04 Nov 2024 02:24:53 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566435c0sm529917566b.162.2024.11.04.02.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 02:24:52 -0800 (PST)
Message-ID: <c83247da-a2c8-4dd7-ba85-5db17ac7ec79@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 11:24:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: Add support for Adreno 612
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jie Zhang <quic_jiezh@quicinc.com>
References: <20241101-a612-gpu-support-v1-1-bdfe8f6d9306@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241101-a612-gpu-support-v1-1-bdfe8f6d9306@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6aVxGCfcRJncFnfRwQ5tQ7QkQRLtyytb
X-Proofpoint-GUID: 6aVxGCfcRJncFnfRwQ5tQ7QkQRLtyytb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040092

On 1.11.2024 4:10 PM, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Add support for Adreno 612 GPU found in SM6150/QCS615 chipsets.
> A612 falls under ADRENO_6XX_GEN1 family and is a cut down version
> of A615 GPU.
> 
> A612 has a new IP called Reduced Graphics Management Unit or RGMU
> which is a small state machine which helps to toggle GX GDSC
> (connected to CX rail) to implement IFPC feature. It doesn't support
> any other features of a full fledged GMU like clock control, resource
> voting to rpmh etc. So we need linux clock driver support like other
> gmu-wrapper implementations to control gpu core clock and gpu GX gdsc.
> Since there is no benefit with enabling RGMU at the moment, RGMU is
> entirely skipped in this patch.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
> Mesa support is already available for A612. Verified Glmark2 with
> weston.
> 
> Some dependencies for the devicetree change are not yet available
> in the mailing lists. I will send it out as a separate patch later.
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

[...]

> -	return adreno_is_a610(gpu) || adreno_is_a702(gpu);
> +	return adreno_is_a610(gpu) ||
> +	       adreno_is_a702(gpu) ||
> +	       adreno_is_a612(gpu);
>  }

Nit: it would be nice if these were sorted but that's minor

