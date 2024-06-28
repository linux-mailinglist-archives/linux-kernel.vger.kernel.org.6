Return-Path: <linux-kernel+bounces-234301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A30C391C4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1F61F22543
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F071CCCC6;
	Fri, 28 Jun 2024 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="INcBLqV6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80F132115;
	Fri, 28 Jun 2024 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595922; cv=none; b=tgvkIIwCv2m5kSePNRg9MHgOqGunY8TdaXffgrHeXm6WqnBHrVXx+WmM8pswbFUIiOLBc3671CYC3pdwHtjtaZfhGyV/7RIfkwqh7dONeBHoqiL2IalgSGw08WoLCfQ6N40uYMndwsMdKhHu7fIHXkKGcYyPT8mwhyk+dwntPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595922; c=relaxed/simple;
	bh=sMDrPManA39S6BH7iLriAXF4pNl69kfIn0uvArERw2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMGLYfSwDG2zVwg5odC9ixwlrtcgZdPLKMxtdeCTmKk+zxURI5/z6ZPiReaNKT7gXutZGav5cdZ+XlFvZJiEJSMtHjMtw1oJKqfxuDzvOONPCSK7LlcSwLlJeC1o/FJBjNhjf88ltcZ3ceuT4hOyOwQKZtlcoWEs6DBIm7z5Znw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=INcBLqV6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SCPgqK027707;
	Fri, 28 Jun 2024 17:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vQsq95T5PXFOUm6FcZhW0EyM
	ZkZbXS/vatzrf4JXue0=; b=INcBLqV6ORUKFdKOzReLHI6cmVx+RAk/e9okIE8y
	jZuDRzdsfNjC5QqR2/iwhbJ6TURsV/uNgWzJ9kluFgO/lzblnjucy2+NP2H3sV4p
	Aqaqkidf429Jp8tNF3a4h2IY4cmpQbFA5fiIiX8xuhkXn+BDlr/1G6JWiO+12W7w
	s7+QTZNHVypbj1+WCYXwUfTu2qvXAdUkSlE9cWKY9bXdc6nOS7iIdpY/iPukZ6fB
	uOLtsT70hVbWV/m7soAQUPk1bjMo9II06m9GXkZi9gbZxkNefQo+jICzkN4IOlfP
	FIe+2ddUtUbWQ+Lef2pHqRhzxrtmrL2lxjyl8ufNxQwkEg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 401pm32dm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 17:31:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SHVowd011573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 17:31:50 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 10:31:50 -0700
Date: Fri, 28 Jun 2024 10:31:49 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Abhinav
 Kumar" <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] drm/msm/adreno: Implement SMEM-based speed bin
Message-ID: <20240628102726231-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240625-topic-smem_speedbin-v4-0-f6f8493ab814@linaro.org>
 <20240625-topic-smem_speedbin-v4-1-f6f8493ab814@linaro.org>
 <20240628101549127-0700.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240628101549127-0700.eberman@hu-eberman-lv.qualcomm.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GfTz67h86_1W1SU4GSH6-oKas-Rjse-E
X-Proofpoint-GUID: GfTz67h86_1W1SU4GSH6-oKas-Rjse-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280130

On Fri, Jun 28, 2024 at 10:24:52AM -0700, Elliot Berman wrote:
> On Tue, Jun 25, 2024 at 08:28:06PM +0200, Konrad Dybcio wrote:
> > On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
> > abstracted through SMEM, instead of being directly available in a fuse.
> > 
> > Add support for SMEM-based speed binning, which includes getting
> > "feature code" and "product code" from said source and parsing them
> > to form something that lets us match OPPs against.
> > 
> > Due to the product code being ignored in the context of Adreno on
> > production parts (as of SM8650), hardcode it to SOCINFO_PC_UNKNOWN.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  8 +++---
> >  drivers/gpu/drm/msm/adreno/adreno_device.c |  2 ++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 41 +++++++++++++++++++++++++++---
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  7 ++++-
> >  4 files changed, 50 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > index c98cdb1e9326..8ace096bb68c 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -2124,13 +2124,15 @@ static u32 fuse_to_supp_hw(const struct adreno_info *info, u32 fuse)
> >  	return UINT_MAX;
> >  }
> >  
> > -static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *info)
> > +static int a6xx_set_supported_hw(struct adreno_gpu *adreno_gpu,
> > +				 struct device *dev,
> > +				 const struct adreno_info *info)
> >  {
> >  	u32 supp_hw;
> >  	u32 speedbin;
> >  	int ret;
> >  
> > -	ret = adreno_read_speedbin(dev, &speedbin);
> > +	ret = adreno_read_speedbin(adreno_gpu, dev, &speedbin);
> >  	/*
> >  	 * -ENOENT means that the platform doesn't support speedbin which is
> >  	 * fine
> > @@ -2290,7 +2292,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
> >  
> >  	a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
> >  
> > -	ret = a6xx_set_supported_hw(&pdev->dev, config->info);
> > +	ret = a6xx_set_supported_hw(adreno_gpu, &pdev->dev, config->info);
> >  	if (ret) {
> >  		a6xx_llc_slices_destroy(a6xx_gpu);
> >  		kfree(a6xx_gpu);
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > index 1e789ff6945e..e514346088f9 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -6,6 +6,8 @@
> >   * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
> >   */
> >  
> > +#include <linux/soc/qcom/socinfo.h>
> > +
> >  #include "adreno_gpu.h"
> >  
> >  bool hang_debug = false;
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index 1c6626747b98..6ffd02f38499 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -21,6 +21,9 @@
> >  #include "msm_gem.h"
> >  #include "msm_mmu.h"
> >  
> > +#include <linux/soc/qcom/smem.h>
> > +#include <linux/soc/qcom/socinfo.h>
> > +
> >  static u64 address_space_size = 0;
> >  MODULE_PARM_DESC(address_space_size, "Override for size of processes private GPU address space");
> >  module_param(address_space_size, ullong, 0600);
> > @@ -1061,9 +1064,39 @@ void adreno_gpu_ocmem_cleanup(struct adreno_ocmem *adreno_ocmem)
> >  			   adreno_ocmem->hdl);
> >  }
> >  
> > -int adreno_read_speedbin(struct device *dev, u32 *speedbin)
> > +int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
> > +			 struct device *dev, u32 *fuse)
> >  {
> > -	return nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
> > +	u32 fcode;
> > +	int ret;
> > +
> > +	/*
> > +	 * Try reading the speedbin via a nvmem cell first
> > +	 * -ENOENT means "no nvmem-cells" and essentially means "old DT" or
> > +	 * "nvmem fuse is irrelevant", simply assume it's fine.
> > +	 */
> > +	ret = nvmem_cell_read_variable_le_u32(dev, "speed_bin", fuse);
> > +	if (!ret)
> > +		return 0;
> > +	else if (ret != -ENOENT)
> > +		return dev_err_probe(dev, ret, "Couldn't read the speed bin fuse value\n");
> > +
> > +#ifdef CONFIG_QCOM_SMEM
> > +	/*
> > +	 * Only check the feature code - the product code only matters for
> > +	 * proto SoCs unavailable outside Qualcomm labs, as far as GPU bin
> > +	 * matching is concerned.
> > +	 *
> > +	 * Ignore EOPNOTSUPP, as not all SoCs expose this info through SMEM.
> > +	 */
> > +	ret = qcom_smem_get_feature_code(&fcode);
> > +	if (!ret)
> > +		*fuse = ADRENO_SKU_ID(fcode);
> > +	else if (ret != -EOPNOTSUPP)
> > +		return dev_err_probe(dev, ret, "Couldn't get feature code from SMEM\n");
> 
> Probably want to update a6xx_set_supported_hw() error handling to ignore
> -EOPNOTSUPP or do:
> 
> 	else /* ret == -EOPNOTSUPP */
> 		return -ENOENT;
> 
> 
> 
> > +#endif
> > +
> > +	return 0;
> 
> I noticed that if SMEM isn't enabled and nvmem returns -ENOENT, we still
> return 0. That could lead to uninitialized access of speedbin in both
> users of adreno_read_speedbin(). Maybe:
> 
> 	return ret;
> 

Ah, I see patch 4 in the series now, but I wonder if we can do something
better so that this patch works without relying on later patch in
series?

> >  }
> >  
> >  int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
> > @@ -1102,9 +1135,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
> >  			devm_pm_opp_set_clkname(dev, "core");
> >  	}
> >  
> > -	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
> > +	if (adreno_read_speedbin(adreno_gpu, dev, &speedbin) || !speedbin)
> >  		speedbin = 0xffff;
> > -	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
> > +	adreno_gpu->speedbin = speedbin;
> >  
> >  	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
> >  			ADRENO_CHIPID_ARGS(config->chip_id));
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > index cff8ce541d2c..563c08b44624 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > @@ -79,6 +79,10 @@ struct adreno_reglist {
> >  
> >  struct adreno_speedbin {
> >  	uint16_t fuse;
> > +/* As of SM8650, PCODE on production SoCs is meaningless wrt the GPU bin */
> > +#define ADRENO_SKU_ID_FCODE		GENMASK(15, 0)
> > +#define ADRENO_SKU_ID(fcode)	(fcode)
> > +
> >  	uint16_t speedbin;
> >  };
> >  
> > @@ -545,7 +549,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
> >  			 struct adreno_smmu_fault_info *info, const char *block,
> >  			 u32 scratch[4]);
> >  
> > -int adreno_read_speedbin(struct device *dev, u32 *speedbin);
> > +int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
> > +			 struct device *dev, u32 *speedbin);
> >  
> >  /*
> >   * For a5xx and a6xx targets load the zap shader that is used to pull the GPU
> > 
> > -- 
> > 2.45.2
> > 
> > 
> 

