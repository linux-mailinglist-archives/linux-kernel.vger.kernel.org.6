Return-Path: <linux-kernel+bounces-437872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EF89E99F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28ED416561B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9691B041F;
	Mon,  9 Dec 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jSFrKtRI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3181798F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756618; cv=none; b=sik7OqxS+GkXfrdWy06BrLncsKE3N+zmvNtjt9QFlOyNQKye+IM81WHL3KWJEBWpZp5h3/59IjFG8guubFzaCbaCCcj/J23O4tHcV7k000Jb8baAtmUYeyrlOLy9Ygbq1yySuUbnkIpC6vl2pi+h+An2iDCLoG8vQVN9id63E4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756618; c=relaxed/simple;
	bh=ZSQrnKkfmxrTvqvhEa/4dkTEy+IJtxHFyOGLF9TsANw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EV7+iczSGFCYUyZmUHQpZewNXAkqiPfObNwtB8dHWXtHHBVqAOrdkc8hDAuyoYtNHyduTTLOww6TtB/aCnIrOkWkS7qSwUeDI4t3po6l6LlrB/nw4vD9QdKxcZRB88yn9QEQssfmaraDEU5fJHNqi5PCOdUFuES2q/entqEk7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jSFrKtRI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AWqhT002489
	for <linux-kernel@vger.kernel.org>; Mon, 9 Dec 2024 15:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O1NX/w+RRXRMNKqZKOVFD80ajURS0nT9KzUnQ2eXmK8=; b=jSFrKtRIpp/uh1HI
	1ZSMggM2zktXcxYeEg12mY5F5vZhV6xdyJWwngeTJFfhhvO7OjURTjDRlx5i8T7C
	QaNYPvfsEYVxy7MjWd1m+EL5J/r2ycVkakFH8xA8BHBK15Rhsm0sh03/hGNSSqS9
	6gFkhhN9OsgRXeCUejhs/vTxNlh3UVqQwsX2Vs9HPJxoBFS66+ie//XrPKbu0iIQ
	pS6bz6sfNjJMLtlkY5SlNyfLCPavVO5ALJtvbVFFxPaoscIH1WEBTSWUuFktmuc4
	oAUqopvQgikVlUkEhtOI9G079DqLTQ7It5ufNv5IKzMB9gMOFwqX03Lrtr9f0vqj
	MfSAQg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw40xm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:03:33 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d88a5bb5e6so14867226d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756612; x=1734361412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1NX/w+RRXRMNKqZKOVFD80ajURS0nT9KzUnQ2eXmK8=;
        b=NTX9ecp6GULRxr77EMrjBItElnKsbfAscaKhyC5pn0HMbpz1+8FY7hRJZ8CpeeFVbV
         08o9z95RWR6P7pKQfs+XeFT6ZqmfEiQ7ONro059rotJbktkcrZE3JyI1GieHCrakxaTG
         ZFyI/wPAp87uGvF8dqJ78G69s6v2nrlxHCPDXcBaQwPm66G+eRoHKDD1aLnSmx1p9sAf
         vAUuCJPXMeHIfXLRkKlYgHBmazvKr3aJPP/YJqeTBZnIm2r6dzi6/MaRrrP9uYbPcB9B
         7HY2g/w9kjk8+c1V70RFXFqnt3lJLUkRU7bdDuiJC4yt8g0AFjR6C4jwGUKK3/UhclOc
         v8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVOGv7QXBqts9ZmHoz0CfATF+3VRM/Z7CvARBM4pgzZLmvZMVfJ8Ds1d0OrmhqoDb6QYX2M8IkugtzdAhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaqN6pV3HkJsgxoU7nuJ+F54ykYs1NrCpMtHDU7D1FbrjsPsbo
	sW5y8gg5zU9S0BiXepDaGLFwXU4Xrlf7/lfdmoXUnnoLMbkpRaIKUlMUsf7ZPf4U1i6TI4S8RHV
	b6x6s/US73Q+2bP/mddjdcZCtolHHIQwS4U2ovh1YuqovFi6ZU72u3Tott7cipX4=
X-Gm-Gg: ASbGncv66/aOujsr6rXq2sHzW/cjK8kk0gY82aMU5NxvhwULfOSOn0VZsdzSl3Usb16
	dyrzFV7ob1I0rJNlO0gIHgvx+3cW4CSRQuQkHNbkiVzTbKhMf7JnUaRWATvBF35RzSatld1fG0m
	57us0Gc18Pr/fB8TE+BUnIqUhhGdfCwIvhvMlMyPWEVtxvvSQbycrH4VgKPp7i06BZyLkdFqtDf
	s2gof4wFpxdTRyBnkhsCRxXbvsUoOB4PPjlyDUG5aVz57txFK5uiOXqa09tF01O3Fgwxwx04xIB
	Lt/UfQ6eto51WjNec9veqC6ckA5BcTQ=
X-Received: by 2002:a05:620a:2909:b0:7ac:b95b:7079 with SMTP id af79cd13be357-7b6bcb32067mr860495785a.10.1733756612382;
        Mon, 09 Dec 2024 07:03:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP91iP55Oeu6qjVs4Q6wCz7SyJ+UWO9ki0Vk/JiuqKFG8xeOAuOXTb1bf9EcxOg8/+s23jtw==
X-Received: by 2002:a05:620a:2909:b0:7ac:b95b:7079 with SMTP id af79cd13be357-7b6bcb32067mr860493285a.10.1733756611833;
        Mon, 09 Dec 2024 07:03:31 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa698e922dasm64701866b.84.2024.12.09.07.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 07:03:31 -0800 (PST)
Message-ID: <08440076-3c04-4bb1-b339-071b82d638d2@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 16:03:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: Skip gpu secure fw load in EL2 mode
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20241209-drm-msm-kvm-support-v1-1-1c983a8a8087@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-drm-msm-kvm-support-v1-1-1c983a8a8087@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: M-SHl1tBR_dTKhQ2cw53J7RwD9FyPr8g
X-Proofpoint-GUID: M-SHl1tBR_dTKhQ2cw53J7RwD9FyPr8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=938
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090118

On 9.12.2024 9:19 AM, Akhil P Oommen wrote:
> When kernel is booted in EL2, SECVID registers are accessible to the
> KMD. So we can use that to switch GPU's secure mode to avoid dependency
> on Zap firmware. Also, we can't load a secure firmware without a
> hypervisor that supports it.
> 
> Tested following configurations on sa8775p chipset (Adreno 663 gpu):
> 
> 1. Gunyah (No KVM) - Loads zap shader based on DT
> 2. KVM in VHE - Skips zap shader load and programs SECVID register
> 3. KVM in nVHE - Loads zap shader based on DT
> 4. Kernel in EL2 with CONFIG_KVM=n - Skips zap shader load and
> 	programs SECVID register
> 
> For (1) and (3) configuration, this patch doesn't have any impact.
> Driver loads secure firmware based on other existing hints.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---

[...]

> +
> +#ifdef CONFIG_ARM64
> +	/*
> +	 * We can access SECVID_TRUST_CNTL register when kernel is booted in EL2 mode. So, use it
> +	 * to switch the secure mode to avoid the dependency on zap shader.
> +	 */
> +	if (is_kernel_in_hyp_mode())
> +		goto direct_switch;

So I suppose this would ideally be like hv_is_hyperv_initialized()
but for QHEE/Gunyah, which is not going to happen, as we have
millions of devices with old unupstreamable-ABI-Gunyah running..

This looks like the next best things then, so no objections, but..

[...]

> +	ret = a6xx_switch_secure_mode(gpu);
> +	if (!ret)

this should definitely be a if (ret)

Konrad

