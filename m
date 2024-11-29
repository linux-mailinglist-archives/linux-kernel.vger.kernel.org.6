Return-Path: <linux-kernel+bounces-425819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 975B89DEB58
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09545B21671
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F519884C;
	Fri, 29 Nov 2024 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SRjC66XG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D914A0A3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899387; cv=none; b=NQbQo0pBmpS/OCW8CntUMiii6nCIAr5frVvAMQqiRPI3HOwOpgNPQwzENdEBqeDlY9nHm6/DluDL32ATxPexGCvXWevSkLUX73TR2X1mfKM/1K/8jA9EGzWY20LJ0mC38vv8Rh9lFh3R/N4sDlThQM9orqVBhCuqUsd6PuNh+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899387; c=relaxed/simple;
	bh=lQwbTwapAcxU9HUYx7ZhzBw2LZBa1rj3PgCAZS97aqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqcRRtdltqbnW4qlANksRJsLrJz+c1KDK3Dgp182TaQ2BZ4n8uU204oZKvTWLDGY4HF+xp5cgzE563Lwq/Oj/N4Tydr9yr9Y/oMpD6w8/0+AhkWLJf/l7nDTkaScTGcaiabdbtYg7UuXThSAcBU3xaDA5HNBJ204O/knzoPSPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SRjC66XG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATDKjra005357
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9N9+0StuwjFo78qzxGpA7gT4M9KWRW0S+SLyWV8Ydm4=; b=SRjC66XG6ukxUnql
	QAhvEXXLmYdoqEywLif+5a3pD/fEzyeJuaE0KBFTyGuG1X+ROPeAHW7006tzhx1l
	f9udFt63+k7gOJuAr+Mc+zVUSZ5f7NBfzvExm443ilGKpTkSSu5TN8LIpnPYZ6O1
	osmCx1REcNLc9/9SBWPmRVHX6kDBmL/zXwY1HMimUH4Qc7vWmGcsA9cYqrMH7dZa
	TbYxQN9uEe479CJDCsHoWQtAU4/t2f8V/LOJ70kMhqyjlKHMzIhAolRiTrXwibC2
	9UKh85kPXc/1SwY7hg49nqJDvgzXwmHTulsifK4301kz1u7eKafttQGiiyPIOk1G
	H0dyRg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 436h2mmtde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:56:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-466d3ec228bso595941cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732899373; x=1733504173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9N9+0StuwjFo78qzxGpA7gT4M9KWRW0S+SLyWV8Ydm4=;
        b=UBPJ9o3HYz8RpYSav5RX+Y6GPue/noZdBa94sR9a9XN5BV94J0a44VmKuNKq2HjJzt
         pbLZebgoYlaaZb/SLe+hSiCLlpwzgpVml8bRxg4D8aY3TIYD8n9rYL+Ygn3PbpdHKgAM
         nub2T5QFOh/RotnEfQ/bN26eYrVK2AmGbuJ8/H7pwooYN5L7m10B9omgyunlWjZoIzjt
         UGsj1wCVDqeonZmqxS8NopnN/kemGN2JUSK7scIEv0Pn70DVsYfbWXfo9HzV4fRLVSA/
         n9M3EQGYPjteRUvy9NtpUSwkdebB8jtx83SAQO5wNXosOk/QF7qudv8VLgAWrdlMywJ9
         hmvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOv+qhbgWlP2aL9uAvpFrZBitF5QcEa58T5Lt1jxbmpkh09X4C5lAy9T0OLaVJ/a9PVKIFZHYNVBzmmAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXRk2xNB0NyaOOKGzggmIwIp4QQSFVi7DmugrofI/YCx/THlOm
	uHdG1ITRycmCNoH0Qy1DlZcOIw7DDTT4gYfoh7RMaAHnu7yXooZa68QOqz8GD1j/wm9um3qaC+b
	M9ve+/Jl07xYgcf0uW1pmoulAxv3vtQBIR/VgbccCSkhwyc3K2+NNIEjOwG4/gRw=
X-Gm-Gg: ASbGncvqFu2ATFAXylkboF00d1R7EaruigJLEaubEd0cNx1hT13JaTWj1W7Upcsuhyr
	Y69u1hErgOJJuMT62j/oFFBbDiO4oulVaPFLk9vYNnyivrAHElZk0ODTQMC4IdOXUJ2EIZMU5ce
	ys/VM9wZjvsUxKsuPksSzvhbTXVRnTTBMJ06uFvWnDgX4OkBXfYAegb8L8PbyHzBx3CWy8xOqAT
	PgnRLT3rsaxCnXAlAYNtrlqFwdWv0vCrOshw0cSDwHXzaP3PXSJfSIohUHzME+JP3zb+/6umZxg
	2c3jstSkRS70gZLhh7zOeLBSnDI7nek=
X-Received: by 2002:a05:622a:389:b0:462:fb65:cbb5 with SMTP id d75a77b69052e-466b36886b8mr76651481cf.16.1732899372960;
        Fri, 29 Nov 2024 08:56:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVQSLO78wLDzRLA3VpDJ6fBlRPS9lgHqu+R15VZlArJvaDZj5w/JO/kqnnSs0mQp12UhVnIQ==
X-Received: by 2002:a05:622a:389:b0:462:fb65:cbb5 with SMTP id d75a77b69052e-466b36886b8mr76651111cf.16.1732899372416;
        Fri, 29 Nov 2024 08:56:12 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e64c4sm190708566b.97.2024.11.29.08.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 08:56:11 -0800 (PST)
Message-ID: <00941d91-7366-4836-9d3a-7e505528a4e8@oss.qualcomm.com>
Date: Fri, 29 Nov 2024 17:56:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] drm/msm: adreno: dynamically generate GMU bw table
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
 <20241128-topic-sm8x50-gpu-bw-vote-v3-3-81d60c10fb73@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241128-topic-sm8x50-gpu-bw-vote-v3-3-81d60c10fb73@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7-Iar61IlidALfJDHTF0AXT9HO-nXjPy
X-Proofpoint-ORIG-GUID: 7-Iar61IlidALfJDHTF0AXT9HO-nXjPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290137

On 28.11.2024 11:25 AM, Neil Armstrong wrote:
> The Adreno GPU Management Unit (GMU) can also scale the ddr
> bandwidth along the frequency and power domain level, but for
> now we statically fill the bw_table with values from the
> downstream driver.
> 
> Only the first entry is used, which is a disable vote, so we
> currently rely on scaling via the linux interconnect paths.
> 
> Let's dynamically generate the bw_table with the vote values
> previously calculated from the OPPs.
> 
> Those entried will then be used by the GMU when passing the

entries

> appropriate bandwidth level while voting for a gpu frequency.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

[...]

>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 39 ++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index cb8844ed46b29c4569d05eb7a24f7b27e173190f..fe1946650425b749bad483dad1e630bc8be83abc 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -621,6 +621,35 @@ static void a740_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>  	msg->cnoc_cmds_data[1][0] = 0x60000001;
>  }
>  
> +static void a740_generate_bw_table(const struct a6xx_info *info, struct a6xx_gmu *gmu,
> +				   struct a6xx_hfi_msg_bw_table *msg)

This should work for all targets

> +{
> +	unsigned int i, j;
> +
> +	msg->ddr_wait_bitmask = 0x7;

GENMASK; also should be generated based on BCM data dynamically, there's
logic for it in bcm-voter.c : tcs_list_gen()

> +
> +	for (i = 0; i < GMU_MAX_BCMS; i++) {
> +		if (!info->bcms[i].name)
> +			break;
> +		msg->ddr_cmds_addrs[i] = cmd_db_read_addr(info->bcms[i].name);

A7xx share a common list of BCMs, the buswidth may differ per soc and it's
something already stored in ICC drivers

> +	}
> +	msg->ddr_cmds_num = i;
> +
> +	for (i = 0; i < gmu->nr_gpu_bws; ++i)
> +		for (j = 0; j < msg->ddr_cmds_num; j++)
> +			msg->ddr_cmds_data[i][j] = gmu->gpu_ib_votes[i][j];
> +	msg->bw_level_num = gmu->nr_gpu_bws;
> +
> +	/* TODO also generate CNOC commands */

We only do on/off (0/100 units - kbps?), it seems

> +
> +	msg->cnoc_cmds_num = 1;
> +	msg->cnoc_wait_bitmask = 0x1;
> +
> +	msg->cnoc_cmds_addrs[0] = cmd_db_read_addr("CN0");
> +	msg->cnoc_cmds_data[0][0] = 0x40000000;
> +	msg->cnoc_cmds_data[1][0] = 0x60000001;
> +}
> +
>  static void a6xx_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>  {
>  	/* Send a single "off" entry since the 630 GMU doesn't do bus scaling */
> @@ -664,6 +693,7 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
>  	struct a6xx_hfi_msg_bw_table *msg;
>  	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
>  	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +	const struct a6xx_info *info = adreno_gpu->info->a6xx;
>  
>  	if (gmu->bw_table)
>  		goto send;
> @@ -690,9 +720,12 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
>  		a690_build_bw_table(msg);
>  	else if (adreno_is_a730(adreno_gpu))
>  		a730_build_bw_table(msg);
> -	else if (adreno_is_a740_family(adreno_gpu))
> -		a740_build_bw_table(msg);
> -	else
> +	else if (adreno_is_a740_family(adreno_gpu)) {
> +		if (info->bcms && gmu->nr_gpu_bws > 1)
> +			a740_generate_bw_table(info, gmu, msg);

This if should come before the hardcoded if-else chain, as it
applies to all platforms

Konrad

