Return-Path: <linux-kernel+bounces-425703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D155C9DE950
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BF92822EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74393145A17;
	Fri, 29 Nov 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iEYPCr1f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA7140E50
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732893933; cv=none; b=F23r6tZNN28Y6dtlomUBoo41VkT9Jg+wqj9UBbbhzkaZVOOXxY7RtduBcb0ZrArLFa4ZeRF1tzle4xNAkneII+RbaFRPSnzFOQaHgW66XpON0jbTzOD3QTqc9SFOS5YD+EwrZHmSVkPicDv+99rFKJj6yCtzsAmC4DJVHSz3CEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732893933; c=relaxed/simple;
	bh=2TzIZe67IZbgwGZuUBmATd+QeVnYA4iz2/SVCNS8Yn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJlskja0fZAPHEE4XpiHsAjeI0oaw3K3JaeLZM3OkVXBS+9HeXhzLoK3yNgZZAJ5w6KRwOaFTs6LR3ukik2qGz72NhCQ7gqw4XM+1/Lzg+i58ew+MoAPnis1fuHBkXUnERHN8ic2JL7EIPeEXh8FKqLaiwyOX3FInRTGE6agZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iEYPCr1f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATCC8tW023467
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	haQsGWihOdgHm4cv5yvNRsaav8iMlhpfGgWfIpKo4Wc=; b=iEYPCr1fqoQ3Wi5Y
	CXrAggcLVT2euy7mczczoIT0BzQsxw8rkN1cmFsurS0uEC+yOeko5kQKUpyvcrEF
	7k6Ld8NUJmtWq7K0fmxIw3h+rPodR8+ftfSfkCxEHB1KEC829xS7N2rAtMEfvutY
	xiRGE1rxNiWyIEwJ/7nZRxd+Q+B4A9/AZGqOWsMb6NxJXKIKgSZYk7hpyQXikWVF
	ao4yZzZmJCY9Ay+CBUwnccKicPMxIBY7qiHconnbZySQMXs4O7ws3PbhLVRXlUoF
	HMFjDhqmCQHsfCwpdo1ccxoK9Kwue2LhOoyPsPkD+wUH+491eSKWoF7QosQwK6K1
	wK9bVQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 436h2mmm7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:25:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d887d2f283so1409696d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732893930; x=1733498730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=haQsGWihOdgHm4cv5yvNRsaav8iMlhpfGgWfIpKo4Wc=;
        b=TCFw5lTZdlUthdx3ZyXcPIU+9DpQf+xuLz/BjiMRwApdyNnYt8IH9VggLIjKKLKwIR
         IZcp4iIZw6lZ6IjMPaG3oFDmWHGbZLxGPx8Duzgz7Szkd7wUfM2gFxRmRCPIElA4aO0q
         aSoUSaR9RjPRJDh0QQ8Clpz9D4Kqg4wtWCoFZut5PU/27qw+EyKHqzOa77aQ4Mhr1x9p
         3V36p8RYHGX3IzOBam+o9mFEscGYGJ/crwkQThfjSLB5jOlGXKcg/iBZKeWowiaGbmq4
         zcpcKbCkP4rvreQY369/+f5fpC8/qyxvsKNaBfY+5pPF0xNsSZF/OIXJyb+/yA+tbvSn
         OnFw==
X-Forwarded-Encrypted: i=1; AJvYcCWBncS8bb+PyRZWBRbJMt5V6/pnNMJod8byM+bqfGG4+CrmhmGcS+h9IkjDpjfgvYJKxEUKBcyayxRISW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8M4f2fgC6d48Oj3o6BLwig2fU2A9i8lyBdKbL6DoGxkakf3fJ
	QYfA0xbnCIsK5KG/QrcSesNQvCR6oL6zrCzvIrRSSqp6LsMIm8uvrByz8K6piAGXpmaZUtES+Xi
	lXhBTHvpBVGUAJ+eVNIqknzuBkb5/3PTyxorNqDc2GfGJvSnUdI7Yg0cApKRs4pI=
X-Gm-Gg: ASbGncup9o92sN8nQUx689HTtXME3SJoCMEMXTGC/twg2vkgAiVKKnX3Klg4JHqMtCF
	+PwE7yzKpa5qFtxw+qCoqi2FFPfFkNqrxbJVetDkLsJDwuUlkC9/xT5urnHkStUCgj5PgPYXuxZ
	6pChx15pSXpfSPHv3GMR3lnmKi1pazlOeMQ/mfg2m2MVIl5czn/Ti2AyR3hi7OFHKFTRGuqavEm
	3PdALXG/QgO/5dokYW4ju2bhgwTl/MF+6flNn6RDilg8gBJXb5bt6csS7X69uZswQqoibKFzOXS
	k/8T0692sY07hZ0KTnPASBrdN7cit6A=
X-Received: by 2002:a05:620a:3712:b0:7a9:c0f2:75fc with SMTP id af79cd13be357-7b67c44101dmr572685585a.12.1732893929885;
        Fri, 29 Nov 2024 07:25:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFABGScqGObURNhImJC7fBXLYcd5e8zHADeSrSRhflVdSkOsywE+7CtqbmRoBAFkettLxWeug==
X-Received: by 2002:a05:620a:3712:b0:7a9:c0f2:75fc with SMTP id af79cd13be357-7b67c44101dmr572682585a.12.1732893929440;
        Fri, 29 Nov 2024 07:25:29 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997ff0d5sm181758366b.85.2024.11.29.07.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 07:25:29 -0800 (PST)
Message-ID: <5fc71011-7a67-47b9-b372-b5e52ffea757@oss.qualcomm.com>
Date: Fri, 29 Nov 2024 16:25:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] drm/msm: adreno: enable GMU bandwidth for A740 and
 A750
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20241128-topic-sm8x50-gpu-bw-vote-v3-0-81d60c10fb73@linaro.org>
 <20241128-topic-sm8x50-gpu-bw-vote-v3-5-81d60c10fb73@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241128-topic-sm8x50-gpu-bw-vote-v3-5-81d60c10fb73@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3w0lICjuyoarsXeRloxZ5Z2JgtEgcrCx
X-Proofpoint-ORIG-GUID: 3w0lICjuyoarsXeRloxZ5Z2JgtEgcrCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290125

On 28.11.2024 11:25 AM, Neil Armstrong wrote:
> Now all the DDR bandwidth voting via the GPU Management Unit (GMU)
> is in place, declare the Bus Control Modules (BCMs) and the
> corresponding parameters in the GPU info struct and add the
> GMU_BW_VOTE feature bit to enable it.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 0c560e84ad5a53bb4e8a49ba4e153ce9cf33f7ae..edffb7737a97b268bb2986d557969e651988a344 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1388,6 +1388,17 @@ static const struct adreno_info a7xx_gpus[] = {
>  			.pwrup_reglist = &a7xx_pwrup_reglist,
>  			.gmu_chipid = 0x7020100,
>  			.gmu_cgc_mode = 0x00020202,
> +			.bcms = (const struct a6xx_bcm[]) {
> +				{ .name = "SH0", .buswidth = 16 },
> +				{ .name = "MC0", .buswidth = 4 },
> +				{
> +					.name = "ACV",
> +					.fixed = true,
> +					.perfmode = BIT(3),
> +					.perfmode_bw = 16500000,
> +				},
> +				{ /* sentinel */ },
> +			},

This is not going to fly the second there's two SoCs implementing the
same GPU with a difference in bus topology. I think we could add
something like drvdata to ICC nodes and use it for BCMs on icc-rpmh.
Then, we could retrieve it from the interconnect path we get from the
dt node. It would also reduce duplication.

Konrad

