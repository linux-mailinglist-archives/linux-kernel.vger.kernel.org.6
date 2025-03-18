Return-Path: <linux-kernel+bounces-566562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE76A679CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8180D3AD17B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0532519B3CB;
	Tue, 18 Mar 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cm8wQ5cU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D720E306
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315721; cv=none; b=f/9SPOVCM1ZYBc3hwq+S8Kvsntouay6XFx0CPfcOwfgEgDGjSf1IFtyYYzR/O56tBWAQxqb+hgrrHVTuNRPOJqUz6VbrLN9lgIfd3umV3kLE0XHI8Yly1r2/jjjtoI7azAHLjTB3AYDDNxhB/3quya6ZFSgMGouRq2JOSfdwJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315721; c=relaxed/simple;
	bh=RzpJDmIRQrSO4tXR1VavJOgG0rc3UybN/ZHACr7xsrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8MatqkdSk+uPN/HCDpym3yczpTwO1WBijSXRBUeOSkWbZby0hALE48Cqzw7LnBOXIwyek2kEEqBzJKBJ5klgddNSyCbIsV02peGZTITHFdLht0dX9wB1OgO8c3TIoXAmK6kkF6e4+KhHk/XLhPC06rIVV2QryQsLv9zLjs+sl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cm8wQ5cU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IB0R9P010481
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8S8PB0YodJg5Wli563O1SQMXwTT57T9BZM427fm0JCk=; b=Cm8wQ5cUSKHVmqPN
	KIzw/os6kT5H6GUA/4uYhMGTX8mhdipTjERm4idtdVmfZQf2Cz+daXh0mmncXpqn
	Ph+P4q+lN4rFgoWJNDqKJtgcv6pT95H3zWLeaE5K4Jz9tu3B94ByCNoBIAgkRJG+
	uYkVAAEXE8lpResBT9fy9ljEhB3NEB6l5+jvRY/20z3rmW4I41ZSzrvCMJ01yfwK
	7A917H7TS3YMtEDwATCZGv2Q2HtEGuSpl1JIRsH3oIpcp97XgA5c/D0x2OOeXE+6
	BVg3UeGC9nmaaQaJ1UvZmZgDIxwXOqIoa4vrqBHtcHdAVYHsFd1O6BhXrCmCPqvm
	27yKaQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exx32hpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:35:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff78bd3026so5257799a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315714; x=1742920514;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8S8PB0YodJg5Wli563O1SQMXwTT57T9BZM427fm0JCk=;
        b=xMYPEc3Ze4d/UluCjwy/a2qOKYfhTci3/GfVxzdTZVaN5EftIiMWHmr0puji8A3I1I
         VRYwf2Gce5BMI4aRFKpgVpvxcWzSjUUA5GapGqXjXZFyis2tRAg3G0h+ly/njz/slOfJ
         G6ARpJWbO76koXoLXbphp3gHAsusUfe0Ef+IqadxTNtj6o0O6Ts0X2bHrOUBoaleH7dP
         xfL6aGr6N9QX3OZI/JY4ENQ+8zElnYTosgws23RO0hiLxyugNG1gk7Iw+/7zBMo1//cE
         /ESg2hBVoWPfEvxsm1jmDP9LIuPZd2WexOaKTdeGfBM/+1XPpq1PqOnMae36Nu/6K5X1
         dxLg==
X-Forwarded-Encrypted: i=1; AJvYcCWy+L4KDPj2Pk9/SAhHcioO5E1mu+BARABCCUK2gl+qdEiwDjHU/2HFe0sneltn4YtRupCoCVwyRRQYHNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSZOh3mpsjp07NQ2pWgBnjbakt/EOHmXkKrukTEr8qijCQJSn
	oz7OGekLMIjjapWmru+2MPNnM4D43KZRdIbFIh+mQ8lTeVc2FcqILt8MDzf8RuWrZLVvZvRbHeR
	F+Nk+cQt8up/BX2LHL3NsicKaqUiSBYdzApGhJM9vz5TLVo8pXsco11lQeY36rLY=
X-Gm-Gg: ASbGncts7pCRalFkXqr5CwJue8uWmnAlNIW09keCs/ZVXb/oLYAJhtGMQzcPeSLD3gq
	y/q1vdeBGKvgtLuvbsuS+oQidnGaKfDGt/MT8u3a8zVnITHI6reIbEjOotgV31seFLD0SiTYEQe
	2PgwhuSqdPvTPLaOhUhTeipusntk4QkFiebpLM7T49TitSFCocK8l/zxrd2x4E/Xs75RvX13LeJ
	SRh/tyfTUNlbR58GNlOvAyIw5rtUiJSYIr9Nq5D/Zxh9rOk07tcUjGhcaiB0ZeErrCfPmEvZrmG
	eH/LxjeAsvHwbKubKxSh8yybEJEPCnQm7rpXaFNYo3BrvRfxknCbLuPC414VIbnu4U8aWcA=
X-Received: by 2002:a17:90b:1d45:b0:2fe:861b:1ae3 with SMTP id 98e67ed59e1d1-301a5b12641mr4557430a91.8.1742315714190;
        Tue, 18 Mar 2025 09:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNgty9LS3gmI4YtjORFBIqUOxTJsgXkfdaoeeC3oMmoDUzn0KGFmczchekklPmOqjoT0aY4A==
X-Received: by 2002:a17:90b:1d45:b0:2fe:861b:1ae3 with SMTP id 98e67ed59e1d1-301a5b12641mr4557384a91.8.1742315713745;
        Tue, 18 Mar 2025 09:35:13 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301539d3f4bsm8443754a91.5.2025.03.18.09.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 09:35:13 -0700 (PDT)
Message-ID: <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 09:35:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b+uy4sGx c=1 sm=1 tr=0 ts=67d9a0c3 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=QwuQnTktFLmdFS3CTrkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ROAWyguMKVwARP-nVK6Dgxp9dpLjdaOa
X-Proofpoint-GUID: ROAWyguMKVwARP-nVK6Dgxp9dpLjdaOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180122

On 3/3/2025 7:00 AM, Neil Armstrong wrote:
> In commit 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp")
> the line:
> 	ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
> was incorrectly updated to:
> 	ab->single_chip_mlo_supp = false;
> leading to always disabling INTRA_DEVICE_MLO even if the device supports it.
> 
> The firmware "WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1"
> crashes on driver initialization with:
>  ath12k_pci 0000:01:00.0: chip_id 0x2 chip_family 0x4 board_id 0x3d soc_id 0x40170200
>  ath12k_pci 0000:01:00.0: fw_version 0x110f009c fw_build_timestamp 2024-05-30 11:35 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
>  ath12k_pci 0000:01:00.0: ignore reset dev flags 0x200
>  ath12k_pci 0000:01:00.0: failed to receive wmi unified ready event: -110
>  ath12k_pci 0000:01:00.0: failed to start core: -110
>  failed to send QMI message
>  ath12k_pci 0000:01:00.0: qmi failed to send mode request, mode: 4, err = -5
>  ath12k_pci 0000:01:00.0: qmi failed to send wlan mode off
> 
> With ab->single_chip_mlo_supp set to True, firmware loads nominally.
> 
> Fixes: 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Bisect log for reference:
> The bisect leaded to:
> git bisect start 'v6.14-rc4' 'v6.12'
> git bisect good 5757b31666277e2b177b406e48878dc48d587a46
> git bisect bad d78794d4f4dbeac0a39e15d2fbc8e917741b5b7c
> git bisect bad cf33d96f50903214226b379b3f10d1f262dae018
> git bisect good 12e070eb6964b341b41677fd260af5a305316a1f
> git bisect bad 6917d207b469ee81e6dc7f8ccca29c234a16916d
> git bisect good 4fefbc66dfb356145633e571475be2459d73ce16
> git bisect bad a6ac667467b642c94928c24ac2eb40d20110983c
> git bisect bad b05d30c2b6df7e2172b18bf1baee9b202f9c6b53
> git bisect good 56dcbf0b520796e26b2bbe5686bdd305ad924954
> git bisect bad d302ac65ac938516487f57ae20f11e9cf6327606
> git bisect good 8c2143702d0719a0357600bca0236900781ffc78
> git bisect good a5686ae820fa7ab03226a3b0ff529720b7bac599
> git bisect bad 6f245ea0ec6c29b90c8fa4fdf6e178c646125d7e
> git bisect bad 46d16f7e1d1413ad7ff99c1334d8874623717745
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 0606116d6b9c491b6ede401b2e1aedfb619339a8..33aba5fceec946fad5a47a11a4d86b7be96e682e 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1927,7 +1927,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>  	ab->dev = dev;
>  	ab->hif.bus = bus;
>  	ab->qmi.num_radios = U8_MAX;
> -	ab->single_chip_mlo_supp = false;
> +	ab->single_chip_mlo_supp = true;
>  
>  	/* Device index used to identify the devices in a group.
>  	 *
> 
> ---
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> change-id: 20250303-topic-ath12k-fix-crash-49e9055c61a1
> 
> Best regards,

NAK since this will break QCN
There is a series under internal review to address MLO issues for WCN chipsets


