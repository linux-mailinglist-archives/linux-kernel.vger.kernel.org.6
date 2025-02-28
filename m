Return-Path: <linux-kernel+bounces-538609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 011CDA49AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40B21745CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A043F9D5;
	Fri, 28 Feb 2025 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UXkX3BIf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397533E7
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750355; cv=none; b=Jp3LTWBqnW0NjN4cKZqBDNeLn+M8zGVau64tthUQ3HW1M/Bvchi4lAZJQZp9ymhKiSRp83cn8D17eITw/wPQkAPHcNByJf0lJJ7cDeRaugZaZFkwbrmPY4F0Q3PpzlrVgYBzYmdqZnZLya1Mr8YWcHIfl+UVLxgta7N9vqVJDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750355; c=relaxed/simple;
	bh=dTbZgFe87nLGvj2GUp/LJFrA/XIiOhzoKmnS6B8fmNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgcB593CoDX6df6yVrHeQMdVWU2UbPnu5riXbqcQcw0+4/cNN9Rgd6bnLbolws5ResaJVMytWe2qgxz2E4yI4alTOtoMMVpNd/qvvDpTOrrLxT+gi5lDe7Z0nRDJRddRyVNXEGu+e8Hr7+MgWjpDk70BUOe6PbmAZndfauWhgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UXkX3BIf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXGJj022067
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ElMZp3aj8XCvzAukLCtSsmNgNkzLrnbLNXvaEBzIL4g=; b=UXkX3BIfY/8M396a
	UjCat4hwQmhGG02/WSx8S+HWbe4kRMf4khRfSnMsd4Fq5yu7g32oYs60fGFhDZNW
	DDx0fix8cntcU7/vxKYpaliQblncMDiwdZjs03hXXdYwQ60t4BAv5UdCbvm9tU7f
	IqjHLJd2Y1XziwX9z1Zo1Gk3THuxtoBVUT9APaTEpBx7bop6IXvFrxzVtmHbbcT2
	fWbq8WSVUAyfRPSS5Km+KC3onj9zrfMBH+encQAd1pRLSELGiGcVu0YPYNgDuo6F
	gqrQYwsK1ziqnjVhDR0FqVbeF51BfdMTkyhWCIkxegLrbNUzp/O+o3ZKXs4IysLc
	0zy03A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451pu9hn2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:45:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e89698ae63so3015586d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750352; x=1741355152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElMZp3aj8XCvzAukLCtSsmNgNkzLrnbLNXvaEBzIL4g=;
        b=K5E43DxzewizTm/kxDmaDxaFfEkzZb79zCtx9Cq5EIiI3CqZbbLFtbF/c6rZeSUUUy
         KJfIhTb56JlM3PZg5O8910xgm5CUYMMSC0nhiPAWL3kCBPYTW1RMqDfdP1P/zW0Xh9+9
         k6WntLqaDwWh0qwO4HPVuxxZWlAifY86Sw7geh0WtYMcLwEP/BY9bODt9LmUpQSaKkkh
         eA4qaWOE+tYoFHC6lBqx2RaasAeOh8IlJUwAcTBVEWisFQGP5Z7aK6ByUlFMr+DRi9hv
         vSxhLgOgfJsawR0Lh3NrCYnmLpclS1d16Vc30PDJVeFnWajm9Gyv95NGyxOoGqyv57Ap
         pjEA==
X-Forwarded-Encrypted: i=1; AJvYcCWSWesdF7jLOQAnHZfCtcwuOiIhLQvcqjNC73npb6SmcetMWRDvFxD5IwpE/Fh0vZW6HPAeHhyT8S8lkQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjvDAJPig5yJihUuFqTVqWz3cFj+5g4nLxtrmF7SX/Ta/cI8Sq
	PjGduMzMGtvtRtHC38/2lzyVavDEMU2eS81euvXUGr2SWx0AdayWC6k4TomgS+vqIH5jMS4tcGT
	u6TfdlW68Jc1t+lJLoOj4QbeJm4mniz3k9geRKcw3BlEz/1qCg7sOK++LzXMmRlg=
X-Gm-Gg: ASbGnct7G2GQLRp6Uc9Eykd8WssYG91sKO3g8qpRzpkgICnBs+SfY5jwjWioxElQYvm
	tO1pMdHP+EqXCwWeLGcqV+OUBG79rbT2Q2SAFQyoUmbwQps4XW/zWkFM0CXrAe8WG56wRotzPuw
	5GYwvfWESYTbLbrvjBQ94WPrQePk2GlUKVcDQp8VRdG45GHTk+/DD4SQrCYA88fOENfjMgjPyXD
	xE0tFAXIU8h6EU59+dT2a47HeGk2UdUssPKfshoGTCLnAok1VPjKZNBkDNezr0RvTrHYeauHHhp
	tgy0jy03P2uNbtpqz3gs3A3xENo5NMzRHs6rVoanjJ8F5YaG99WRMTOFyPUB7Me2f849Bw==
X-Received: by 2002:ad4:5f87:0:b0:6d9:2fe3:bf0c with SMTP id 6a1803df08f44-6e8a0d390bdmr16624686d6.4.1740750352301;
        Fri, 28 Feb 2025 05:45:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/oCApv/Y5ObRZE/KFXdLu0bmSyua0FoUMda3K2Tbcj+Kjc3wCxjh+pxAlMy7QurbrRXWsqw==
X-Received: by 2002:ad4:5f87:0:b0:6d9:2fe3:bf0c with SMTP id 6a1803df08f44-6e8a0d390bdmr16624436d6.4.1740750351841;
        Fri, 28 Feb 2025 05:45:51 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6d702sm2484342a12.17.2025.02.28.05.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 05:45:51 -0800 (PST)
Message-ID: <602c58bd-ae4b-4af9-acd1-ef4f1bde5f70@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 14:45:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 SDM630
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250228-dpu-fix-catalog-v1-0-b05d22fbc2b4@linaro.org>
 <20250228-dpu-fix-catalog-v1-4-b05d22fbc2b4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250228-dpu-fix-catalog-v1-4-b05d22fbc2b4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Us7cbf3hTjw4-cl_8GmcwDRPSgU83hKg
X-Proofpoint-ORIG-GUID: Us7cbf3hTjw4-cl_8GmcwDRPSgU83hKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280100

On 28.02.2025 3:40 AM, Dmitry Baryshkov wrote:
> The MSM8937 platform doesn't have DSC blocks nor does have it DSC
> registers in the PINGPONG block. Drop the DPU_PINGPONG_DSC feature bit
> from the PINGPONG's feature mask, replacing PINGPONG_SDM845_MASK and
> PINGPONG_SDM845_TE2_MASK with proper bitmasks.
> 
> Fixes: 7204df5e7e68 ("drm/msm/dpu: add support for SDM660 and SDM630 platforms")
> Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
> index df01227fc36468f4945c03e767e1409ea4fc0896..4fdc9c19a74a0c52ae502b77fb8697a53bef0f97 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
> @@ -115,14 +115,15 @@ static const struct dpu_pingpong_cfg sdm630_pp[] = {
>  	{
>  		.name = "pingpong_0", .id = PINGPONG_0,
>  		.base = 0x70000, .len = 0xd4,
> -		.features = PINGPONG_SDM845_TE2_MASK,
> +		.features = BIT(DPU_PINGPONG_DITHER) |
> +			    BIT(DPU_PINGPONG_TE2),

Neither are advertised downstream

Konrad

