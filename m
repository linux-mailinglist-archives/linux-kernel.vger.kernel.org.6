Return-Path: <linux-kernel+bounces-443857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9B99EFCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF1E16A575
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B761A0AFB;
	Thu, 12 Dec 2024 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzlgFAK9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BDB189BBB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033323; cv=none; b=ATO/LEZPB99DTdwSIq4GEf9KfxJh/tuTUxVixDXuzo3SIIu0pEaIp5wbFTbVVUXXdE6HOndDs1sThdv4f8Vfg0Zqc+CJ+5LtTyMM43y+sToWAx9byrsJTTyE7EFKlnh2eTz5/A6yeyrtcJQAxtGSpEUS1Ahs/C9hEEMhRBnuw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033323; c=relaxed/simple;
	bh=4Xk0iuSuUcACy1SkPzsDgJfFobNYaYnbcTp17a02bNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaYYjoEo64bnNP7tUrnruJDNzcAfmg2eLOQ+rNFPNa926m0NSMAyzNeb3NkNEyVvCbiGT7kMsquG/Gc26opp6lNZpAyNSHohkuuizqBLSBOmCUgDpzVnOj0n/5Q/sYMl0D6TfLVPFfqB70v6PNU7tu9/htKToaqsKXpwT1c1KIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OzlgFAK9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGT9QC026852
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FhgiumrxiM7n/En/vNa/ikofuwRr79X7+UFWSDfUsGI=; b=OzlgFAK90iTRsPl3
	1EIm/Bw2dZW2JEfcXYGB82FHlB0eTIlv5uEoHQ83G0Go+d5HNpcpsiIgeKMyYQt1
	KgRicLNBO/SxKC4z6fdwgxYIE/DeBDfYVa50g1DouqhxlMQJB/NmB8+vfaAZ11As
	mkthpASPywnF3kDeh2RMdUufizXIvSyOGGhiW4FR+m69Mq1PxWlyUU2AaU6uNxwU
	YDWvfIEWi8PXjVD1EG13pDsqOoBN9ph0ejJWzjr0gRwK/9xNQo+DzHMWqufA1waX
	D7jD5AQ7aRBMgn0ohboOWPILpIWgmN70JWy7f/Knk810501zQntq7weHTbEhBVnb
	Ieuz2Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40m421-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:55:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8f8762a69so2033566d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734033313; x=1734638113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhgiumrxiM7n/En/vNa/ikofuwRr79X7+UFWSDfUsGI=;
        b=qIT1s9mBh7CJE2bTjSW0Ky9wH7kzUVgFRoKGtPvwdisupGxIZae7PHou6ZJkieYgI7
         tmltkQ4GPUNhaNznHFhDG0ZprQS8bkQGdAcj3sYaHaYyBIfQIhhxpd+97h6YgR6D+Smh
         vude8xXlqEMtiusPLJbj6Ro81vyatI+bEAXNs9Hq1IhcoPLjcBN/7pBfr9LGjHDhqw4m
         Dg/mzeTU9gQPncZokp+qM9Mlwbyw0gbSIo3MYQURb2Ekg1t9e7deaq2GSzZrwj8i+at/
         QhGtV/EtWyxLgDqnJCtfcdzKFqoheyIPDR4xS5QjYIF9lVmdpfwjH8PnAkFDWlje33/n
         reJA==
X-Forwarded-Encrypted: i=1; AJvYcCVIxpxRmkK4rl+Ac7IETDj83Sib62csSUBPM+SxCbAAyKogTRUpy5lvkkwgY/FHtVhPBagfraskM7krb50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1CON/xhBF3ExDMgMufnhMOhT7obko2nPwYl0lhseve/EwgKH
	vACK/hPQuXo+2PTLOx4CyTSgq9UxPNUGdG0rOqgCxZdCFESPJllFq0NCnoWQMzU7xPfYVYkmy0I
	iLoQ1a+QZD5cbBT/NjRV8MBg+zd88Z6mqauYEEqWdWTU+W/rn9dT7yeeGGasOb4I=
X-Gm-Gg: ASbGncvyivwEZmQx4+j3kBkVu1tePAvSMDPIGFMt3Jrd3/yVrQTxZDVcUsk3ylHPpaN
	YKhfh4ImEwmFAjSqCdF1bMhC/XUkJ6eCsL9PKW4URy0Dmjhd+hLeS8oOSB3KLh0e1K6jrKu4YAL
	2qOf5u+xzkun9hL9LvP+1AuvX5NKSgH3DyUjns7X3EOr37lAxBiMVxt1Kg9edPZrBMpzmI+54fh
	3/ALVvdn/nfRZ5KE4tEZ0Ru2tbpeMl5z9QAgeBUZiiCg9qjOO2/TP8ifg66VnnXT/JeIWD+qk9m
	Lg4rIpqazujfCmXY6gWDHcK5OEV432UqwYAYDg==
X-Received: by 2002:a05:6214:2527:b0:6d8:f750:b2f1 with SMTP id 6a1803df08f44-6db0f833ae5mr8033296d6.11.1734033313176;
        Thu, 12 Dec 2024 11:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjTsRrIxl4jM8Aw3TRdwR13Fi0Jt/svjVNrvUPTFZaAFCRmzkg7Yfxtsyp/ej45ehVuNN9Xg==
X-Received: by 2002:a05:6214:2527:b0:6d8:f750:b2f1 with SMTP id 6a1803df08f44-6db0f833ae5mr8033156d6.11.1734033312773;
        Thu, 12 Dec 2024 11:55:12 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69448304asm550614466b.45.2024.12.12.11.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 11:55:12 -0800 (PST)
Message-ID: <3aad9de3-76a5-4106-a513-4707b3e39e7a@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 20:55:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] drm/msm: adreno: add plumbing to generate
 bandwidth vote table for GMU
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
References: <20241211-topic-sm8x50-gpu-bw-vote-v5-0-6112f9f785ec@linaro.org>
 <20241211-topic-sm8x50-gpu-bw-vote-v5-2-6112f9f785ec@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241211-topic-sm8x50-gpu-bw-vote-v5-2-6112f9f785ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yfxcHZQhNIZK5EoHmva-uR_hyGeXYdFm
X-Proofpoint-ORIG-GUID: yfxcHZQhNIZK5EoHmva-uR_hyGeXYdFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120144

On 11.12.2024 9:29 AM, Neil Armstrong wrote:
> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth along
> the Frequency and Power Domain level, but by default we leave the
> OPP core scale the interconnect ddr path.
> 
> While scaling via the interconnect path was sufficient, newer GPUs
> like the A750 requires specific vote paremeters and bandwidth to
> achieve full functionality.
> 
> In order to calculate vote values used by the GPU Management
> Unit (GMU), we need to parse all the possible OPP Bandwidths and
> create a vote value to be sent to the appropriate Bus Control
> Modules (BCMs) declared in the GPU info struct.
> 
> This vote value is called IB, while on the other side the GMU also
> takes another vote called AB which is a 16bit quantized value
> of the floor bandwidth against the maximum supported bandwidth.
> The AB vote will be calculated later when setting the frequency.
> 
> The vote array will then be used to dynamically generate the GMU
> bw_table sent during the GMU power-up.
> 
> Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 144 ++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  13 +++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h |   1 +
>  3 files changed, 158 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 14db7376c712d19446b38152e480bd5a1e0a5198..36696d372a42a27b26a018b19e73bc6d8a4a5235 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -9,6 +9,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
>  #include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/tcs.h>
>  #include <drm/drm_gem.h>
>  
>  #include "a6xx_gpu.h"
> @@ -1287,6 +1288,101 @@ static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
>  	return 0;
>  }
>  
> +/**
> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager (BCM)
> + * @unit: divisor used to convert bytes/sec bw value to an RPMh msg
> + * @width: multiplier used to convert bytes/sec bw value to an RPMh msg
> + * @vcd: virtual clock domain that this bcm belongs to
> + * @reserved: reserved field
> + */
> +struct bcm_db {
> +	__le32 unit;
> +	__le16 width;
> +	u8 vcd;
> +	u8 reserved;
> +};

No. This is a direct copypasta of drivers/interconnect/qcom/icc-rpmh.h
You cannot just randomly duplicate things..

Move it out to a shared header in include/ (and remove the duplicate from
clk-rpmh.c while at it)


I'd also really prefer if you took

drivers/interconnect/qcom/bcm-voter.c : tcs_list_gen()

and abstracted it to operate on struct bcm_db with any additional
required parameters passed as arguments.. Still left some comments
on this version if you decide to go with it

> +
> +static int a6xx_gmu_rpmh_bw_votes_init(const struct a6xx_info *info,
> +				       struct a6xx_gmu *gmu)
> +{
> +	const struct bcm_db *bcm_data[GMU_MAX_BCMS] = { 0 };
> +	unsigned int bcm_index, bw_index, bcm_count = 0;
> +
> +	if (!info->bcms)
> +		return 0;

You already checked that from the caller

> +
> +	/* Retrieve BCM data from cmd-db */
> +	for (bcm_index = 0; bcm_index < GMU_MAX_BCMS; bcm_index++) {
> +		size_t count;
> +
> +		/* Stop at first unconfigured bcm */
> +		if (!info->bcms[bcm_index].name)
> +			break;

Unconfigured doesn't really fit here.. Maybe just mention the list is NULL
-terminated

> +
> +		bcm_data[bcm_index] = cmd_db_read_aux_data(
> +						info->bcms[bcm_index].name,
> +						&count);
> +		if (IS_ERR(bcm_data[bcm_index]))
> +			return PTR_ERR(bcm_data[bcm_index]);
> +
> +		if (!count)
> +			return -EINVAL;

If this condition ever happens, it'll be impossible to track down,
please add an err message

> +
> +		++bcm_count;

I've heard somewhere that prefixed increments are discouraged for
"reasons" and my OCD would like to support that

> +	}
> +
> +	/* Generate BCM votes values for each bandwidth & BCM */
> +	for (bw_index = 0; bw_index < gmu->nr_gpu_bws; bw_index++) {
> +		u32 *data = gmu->gpu_ib_votes[bw_index];
> +		u32 bw = gmu->gpu_bw_table[bw_index];
> +
> +		/* Calculations loosely copied from bcm_aggregate() & tcs_cmd_gen() */
> +		for (bcm_index = 0; bcm_index < bcm_count; bcm_index++) {
> +			bool commit = false;
> +			u64 peak;
> +			u32 vote;
> +
> +			/* Skip unconfigured BCM */
> +			if (!bcm_data[bcm_index])
> +				continue;

I don't see how this is useful here

> +
> +			if (bcm_index == bcm_count - 1 ||
> +			    (bcm_data[bcm_index + 1] &&
> +			     bcm_data[bcm_index]->vcd != bcm_data[bcm_index + 1]->vcd))
> +				commit = true;
> +
> +			if (!bw) {
> +				data[bcm_index] = BCM_TCS_CMD(commit, false, 0, 0);
> +				continue;
> +			}
> +
> +			if (info->bcms[bcm_index].fixed) {

You may want to take a pointer to info->bcms[bcm_index]

> +				u32 perfmode = 0;
> +
> +				if (bw >= info->bcms[bcm_index].perfmode_bw)
> +					perfmode = info->bcms[bcm_index].perfmode;
> +
> +				data[bcm_index] = BCM_TCS_CMD(commit, true, 0, perfmode);
> +				continue;
> +			}
> +
> +			/* Multiply the bandwidth by the width of the connection */
> +			peak = (u64)bw * le16_to_cpu(bcm_data[bcm_index]->width);
> +			do_div(peak, info->bcms[bcm_index].buswidth);
> +
> +			/* Input bandwidth value is in KBps, scale the value to BCM unit */
> +			peak *= 1000ULL;

I don't think this needs to be ULL since the other argument is an u64

> +			do_div(peak, le32_to_cpu(bcm_data[bcm_index]->unit));
> +
> +			vote = clamp(peak, 1, BCM_TCS_CMD_VOTE_MASK);
> +
> +			data[bcm_index] = BCM_TCS_CMD(commit, true, vote, vote);

x is the avg vote, y is the peak vote

Just noting down for my future self I guess, a6xx sets ab=0,
a7xx sets ab=ib like you did here

Konrad

