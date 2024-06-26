Return-Path: <linux-kernel+bounces-230232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F3917A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8922CB21CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D5315DBBA;
	Wed, 26 Jun 2024 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HRHSgW8g"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846113AA3C;
	Wed, 26 Jun 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388302; cv=none; b=B+ftmXyHwxPR1kLuX3fN69+38nuUxpWQgfC6Qg7BpmXukEb7OepLX9UFI9CN0d+Z2f5uGA8g1Z4T4LNEll5AWv4JLBuR7WUUtxDxiPTAn4gRgfb8EPqzP3Bhe93xF2tXeAnVXnSPYyWMwEwdw8b6Ocj6GvJAIaHqDJzpORjPnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388302; c=relaxed/simple;
	bh=rd24936/CmK49NU1GvvRE+KnPw11pfhA3GcC+UHgA6w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jx7LkQunHNngVALcaUuYjn5M/HUKjhvWlq2vrHwbQTOk6OwkD68ELK5D1HeMuXX//Ajh7Tnf9AKyvI2o1qHPTZ/QPXMKKnOep4aSNCa25MinMu48AUuVtvBVdu2nIJkohKAU1BkNtR1JAbyzZuvQqMObiGInE0jmT4IZC0XAHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HRHSgW8g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PNXfM1013485;
	Wed, 26 Jun 2024 07:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ma1fANXXjcdWDrg3VU1yzT/C
	t3AzbyMCwYD5MOJADsc=; b=HRHSgW8g3jUWzUtsOLKjwig5TJAk033x0KiDtDja
	ds/hFbnKHhzVbtgOEATKvbNswYnDb2qwBX/UVCbJz8Tzef/uUXPMOHdpVWoB+/aN
	M5mzseRJsgqXyIhHaBK45KivrFdxSLHuayRQN/TUETEcYFOqTRF1oJ0cJLdu56JH
	TK+Ri/UYoNMP3sx168e8makRQSz0OO3sFosn9A/few+g6cbr2W5qbfZO5uuzHePz
	7y8+Em5vEC/+VwqZxyGJlhIoGlCmbRf/yYl4ZZhlIDymIkD8GBKQ0yasLggoJJtc
	i+adEddAND702VzqablBiQdjhxHStaSHQKEgV0j+LdnOtA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnxh0jpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 07:51:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q7pUTC016195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 07:51:30 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 00:51:25 -0700
Date: Wed, 26 Jun 2024 13:21:21 +0530
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark
	<robdclark@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>, David Airlie
	<airlied@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] drm/msm/adreno: Add support for X185 GPU
Message-ID: <20240626075121.2qxnjvbhzjg7dyog@hu-akhilpo-hyd.qualcomm.com>
References: <20240623110753.141400-1-quic_akhilpo@quicinc.com>
 <20240623110753.141400-3-quic_akhilpo@quicinc.com>
 <6pfetzw2my2wf465wsgg5cqhmkuqooi6fipm3huntl5gwthgyd@qukafeyyftvx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6pfetzw2my2wf465wsgg5cqhmkuqooi6fipm3huntl5gwthgyd@qukafeyyftvx>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kYw4vVrW70F4FVYFe4nkR3pCBbib-sWS
X-Proofpoint-ORIG-GUID: kYw4vVrW70F4FVYFe4nkR3pCBbib-sWS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=761 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260058

On Mon, Jun 24, 2024 at 12:21:30AM +0300, Dmitry Baryshkov wrote:
> On Sun, Jun 23, 2024 at 04:36:29PM GMT, Akhil P Oommen wrote:
> > Add support in drm/msm driver for the Adreno X185 gpu found in
> > Snapdragon X1 Elite chipset.
> > 
> > Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> > ---
> > 
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 19 +++++++++++++++----
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  6 ++----
> >  drivers/gpu/drm/msm/adreno/adreno_device.c | 14 ++++++++++++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  5 +++++
> >  4 files changed, 36 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > index 0e3dfd4c2bc8..168a4bddfaf2 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > @@ -830,8 +830,10 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
> >  	 */
> >  	gmu_write(gmu, REG_A6XX_GMU_CM3_CFG, 0x4052);
> >  
> > +	if (adreno_is_x185(adreno_gpu)) {
> > +		chipid = 0x7050001;
> >  	/* NOTE: A730 may also fall in this if-condition with a future GMU fw update. */
> > -	if (adreno_is_a7xx(adreno_gpu) && !adreno_is_a730(adreno_gpu)) {
> > +	} else if (adreno_is_a7xx(adreno_gpu) && !adreno_is_a730(adreno_gpu)) {
> >  		/* A7xx GPUs have obfuscated chip IDs. Use constant maj = 7 */
> >  		chipid = FIELD_PREP(GENMASK(31, 24), 0x7);
> >  
> > @@ -1329,9 +1331,18 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
> >  	if (!pri_count)
> >  		return -EINVAL;
> >  
> > -	sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
> > -	if (IS_ERR(sec))
> > -		return PTR_ERR(sec);
> > +	/*
> > +	 * Some targets have a separate gfx mxc rail. So try to read that first and then fall back
> > +	 * to regular mx rail if it is missing
> 
> Can we use compatibles / flags to detect this?

I prefer the current approach so that we don't need to keep adding
checks here for future targets. If gmxc is prefer, we have to use that
in all targets.

> 
> > +	 */
> > +	sec = cmd_db_read_aux_data("gmxc.lvl", &sec_count);
> > +	if (PTR_ERR_OR_ZERO(sec) == -EPROBE_DEFER) {
> > +		return -EPROBE_DEFER;
> > +	} else if (IS_ERR(sec)) {
> > +		sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
> > +		if (IS_ERR(sec))
> > +			return PTR_ERR(sec);
> > +	}
> 
> The following code might be slightly more idiomatic:
> 
> 	sec = cmd_db_read_aux_data("gmxc.lvl", &sec_count);
> 	if (IS_ERR(sec) && sec != ERR_PTR(-EPROBE_DEFER))
> 		sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
> 	if (IS_ERR(sec))
> 		return PTR_ERR(sec);
>
Ack. This is neater!

> 
> >  
> >  	sec_count >>= 1;
> >  	if (!sec_count)
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > index 973872ad0474..97837f7f2a40 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -1319,9 +1319,7 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
> >  		count = ARRAY_SIZE(a660_protect);
> >  		count_max = 48;
> >  		BUILD_BUG_ON(ARRAY_SIZE(a660_protect) > 48);
> > -	} else if (adreno_is_a730(adreno_gpu) ||
> > -		   adreno_is_a740(adreno_gpu) ||
> > -		   adreno_is_a750(adreno_gpu)) {
> > +	} else if (adreno_is_a7xx(adreno_gpu)) {
> >  		regs = a730_protect;
> >  		count = ARRAY_SIZE(a730_protect);
> >  		count_max = 48;
> > @@ -1891,7 +1889,7 @@ static int hw_init(struct msm_gpu *gpu)
> >  	gpu_write(gpu, REG_A6XX_UCHE_CLIENT_PF, BIT(7) | 0x1);
> >  
> >  	/* Set weights for bicubic filtering */
> > -	if (adreno_is_a650_family(adreno_gpu)) {
> > +	if (adreno_is_a650_family(adreno_gpu) || adreno_is_x185(adreno_gpu)) {
> >  		gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_0, 0);
> >  		gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_1,
> >  			0x3fe05ff4);
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > index c3703a51287b..139c7d828749 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -568,6 +568,20 @@ static const struct adreno_info gpulist[] = {
> >  		.zapfw = "a740_zap.mdt",
> >  		.hwcg = a740_hwcg,
> >  		.address_space_size = SZ_16G,
> > +	}, {
> > +		.chip_ids = ADRENO_CHIP_IDS(0x43050c01), /* "C512v2" */
> > +		.family = ADRENO_7XX_GEN2,
> > +		.fw = {
> > +			[ADRENO_FW_SQE] = "gen70500_sqe.fw",
> > +			[ADRENO_FW_GMU] = "gen70500_gmu.bin",
> > +		},
> > +		.gmem = 3 * SZ_1M,
> > +		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> > +		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> > +			  ADRENO_QUIRK_HAS_HW_APRIV,
> > +		.init = a6xx_gpu_init,
> > +		.hwcg = a740_hwcg,
> > +		.address_space_size = SZ_16G,
> 
> Please rebase on top of https://lore.kernel.org/dri-devel/20240618164303.66615-1-robdclark@gmail.com/

Ack.

-Akhil.

> 
> >  	}, {
> >  		.chip_ids = ADRENO_CHIP_IDS(0x43051401), /* "C520v2" */
> >  		.family = ADRENO_7XX_GEN3,
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > index 77526892eb8c..d9ea8e0f6ad5 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > @@ -448,6 +448,11 @@ static inline int adreno_is_a750(struct adreno_gpu *gpu)
> >  	return gpu->info->chip_ids[0] == 0x43051401;
> >  }
> >  
> > +static inline int adreno_is_x185(struct adreno_gpu *gpu)
> > +{
> > +	return gpu->info->chip_ids[0] == 0x43050c01;
> > +}
> > +
> >  static inline int adreno_is_a740_family(struct adreno_gpu *gpu)
> >  {
> >  	if (WARN_ON_ONCE(!gpu->info))
> > -- 
> > 2.45.1
> > 
> 
> -- 
> With best wishes
> Dmitry

