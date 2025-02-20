Return-Path: <linux-kernel+bounces-523893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3594EA3DCA2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599BB861F85
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D761FCFFE;
	Thu, 20 Feb 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X7Oq9c8x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7E1FBE8D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061154; cv=none; b=J06JUGLpvqyRSsHnxitWNj2abzXukuxcp969NGtUXRylvrXm05hJEiM7q9LpLP1POfDtOpem8DCJnr9tas4cth62dk1I83qsDZiDMvXkz/TVTwtzzyy0KesNVBA5vpjJ2IRlLIVrV4C8ZRIowbPRnaJN2AAz/P3jKgbxw4CvKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061154; c=relaxed/simple;
	bh=EOKvgRMWbNRK5S4FoZ8sqAxDMmYVYMCk/LxtLibO6Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Swq6zZST4nryI0GES+nLgRI7Jo5AMzr/IzpXHf+nciOpw1dSw68+31a9F/dbf1uzHic4u00HiXFF5/8tTiyu28u0AKajicboLAtMkUCjaifZ+ZjMhdqLHgJIDKld6lIyW2E5AYVSGCSGHI+LhU933NgPGD6aKERnARosKm1MgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X7Oq9c8x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KE4RID023289
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZzGpuNpEMvmvsVtbZHCixwxV188CGJ6yTEUyvKSil0I=; b=X7Oq9c8xcZesA4wx
	IxZ3gZCZVPgvDMOOY5hRHipJYxUdD1kO6ByZvqvjWmVttH/RixOKn9yGd+mvnBji
	roaCWYOc0P/NHzuIK/T1zYLqwH6G0s04qEHPQUNO1pBlu0x5Ydzk8q+20t0/aKBo
	3okbRmfStWCawdjOyGQRrOHA1uteA76w1MhoO/y25gCql6zmMh27oVXRWcglr2wH
	yMLS765/jvbW3YrXY14Tu9n0SQhPd0mOKguMrIpWKffxvZI8biwz+jlAVYgELqMS
	VCTQzlfdVZE3oV7zN2O4T7/x2vFCLQhRemEKtulAPl62H606349dwYknDlJTNaFq
	+i66Dg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3pfbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:19:11 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e422f1ceadso2366906d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740061150; x=1740665950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzGpuNpEMvmvsVtbZHCixwxV188CGJ6yTEUyvKSil0I=;
        b=hW1xwZfU0fDtAw0CdhQ9KHtpgQOUx2BSJ6JhU6RX2oVMw9MadIGgGHXeGTe1Zo+y78
         zOd5sIQwzQbxwsWz+lVqV4n4A8n66rk5QtuxcgbJCZp/+G83bCuerO9cSfPVOQB34GnJ
         9umR+OytyGDeMpRFl1np/LT39bbYnFtc6pOZkFvush0n0OwZd8JEnBc135iMnOT6s5WC
         N0Ec/oA39ZrRCTOTgBEvvuSVrYEPV3JOmAtKwpbzA0OxMMs/JmCQxqv6T/LwuRwyGNwk
         cEyNqNl0x+TizlgDyrkjUpUAbzAS89k6ujsAUWsoriwYqLRVGZ+ildGTay1xLD8iKmTq
         +BTw==
X-Forwarded-Encrypted: i=1; AJvYcCVUemFQxW1fdCAPFCoNDNtrkBa1z+r5DvRYcNXJ8co97PlzNGUjEswk0l1wvTBJETyJuOs6QexDyJtp8lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7XYl2EaqNGVfate3fKOhyUYaKwNnKhp1161sBbwvlhr4zW24
	D3VJAXOf/X/IIlF8kII0Cd4gIhWN1nkJd4dJJwVORO5Zziz/eGNXgfcNRHeFCTNdd7T4WpCzZPt
	pOjIm0ZH3DLQcc37q/rh2ydhihWfbgv6gTWlkaDbBa7AcFg0TZOzUGanMFlWLGmggKTmkhRU=
X-Gm-Gg: ASbGnctYg3wATxwBqh/K3Qh45hGQ8cZBp9h/0wLY2+frYUj8oALYs29vOAD0X2NHYaP
	GftQyL0O+40EaYquT++1Vk64YiEJKqPhxVEUiiA0oRkt/rEUcLnnPcx5f8wLGDX8IEkrjN2OdAM
	gW9A1xljFd4nNSJu64IV8Nli/iOnKvtvvsknBMuxX0XTFRaFe8oynMgMGmss/+mhmEwIjvNtMP8
	E4zeUwOPxVT95/xnTqVXTQ+PLua5bEpz5k6H7XQvESQnQV5ToN1MhMDdzuYX5UbWGQRARRwU8ki
	WMKEuxJnrSY8orSMfAK1Cb1kjo8gsUWyGpYAmcJzH8yxreiALleZ1HdoCIc=
X-Received: by 2002:a05:620a:7e8:b0:7c0:b018:5930 with SMTP id af79cd13be357-7c0b0185c4cmr395263385a.15.1740061150204;
        Thu, 20 Feb 2025 06:19:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGplcBIxuc1qJMHH/uMdBHwF3xTcMp0hOINAPPRPBlGB53/bt9zTWLON5PGnGl2kKOLrka9A==
X-Received: by 2002:a05:620a:7e8:b0:7c0:b018:5930 with SMTP id af79cd13be357-7c0b0185c4cmr395260485a.15.1740061149834;
        Thu, 20 Feb 2025 06:19:09 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e03aa0b1f7sm8859956a12.2.2025.02.20.06.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 06:19:08 -0800 (PST)
Message-ID: <00659634-c602-4382-b4a7-ef32f4d27dbf@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 15:19:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/msm/mdp4: move move_valid callback to
 lcdc_encoder
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250220-fd-mdp4-lvds-v2-0-15afe5578a31@linaro.org>
 <20250220-fd-mdp4-lvds-v2-5-15afe5578a31@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250220-fd-mdp4-lvds-v2-5-15afe5578a31@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZEa3RyLmPqGEIo3N6o7NJc4M-jkk5mLx
X-Proofpoint-ORIG-GUID: ZEa3RyLmPqGEIo3N6o7NJc4M-jkk5mLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200103

On 20.02.2025 12:14 PM, Dmitry Baryshkov wrote:
> We can check the LCDC clock directly from the LCDC encoder driver, so
> remove it from the LVDS connector.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h           |  1 -
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c  | 27 ++++++++++++++++------
>  .../gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c    | 21 -----------------
>  3 files changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
> index b8bdc3712c73b14f3547dce3439a895e3d10f193..e0380d3b7e0cee99c4c376bf6369887106f44ede 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
> @@ -191,7 +191,6 @@ struct drm_crtc *mdp4_crtc_init(struct drm_device *dev,
>  long mdp4_dtv_round_pixclk(struct drm_encoder *encoder, unsigned long rate);
>  struct drm_encoder *mdp4_dtv_encoder_init(struct drm_device *dev);
>  
> -long mdp4_lcdc_round_pixclk(struct drm_encoder *encoder, unsigned long rate);
>  struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev,
>  		struct device_node *panel_node);
>  
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> index db93795916cdaa87ac8e61d3b44c2dadac10fd9e..cfcedd8a635cf0297365e845ef415a8f0d553183 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> @@ -348,19 +348,32 @@ static void mdp4_lcdc_encoder_enable(struct drm_encoder *encoder)
>  	mdp4_lcdc_encoder->enabled = true;
>  }
>  
> +static enum drm_mode_status
> +mdp4_lcdc_encoder_mode_valid(struct drm_encoder *encoder,
> +		const struct drm_display_mode *mode)
> +{
> +	struct mdp4_lcdc_encoder *mdp4_lcdc_encoder =
> +			to_mdp4_lcdc_encoder(encoder);

Crazy linebreak

> +	long actual, requested;
> +
> +	requested = 1000 * mode->clock;
> +	actual = clk_round_rate(mdp4_lcdc_encoder->lcdc_clk, requested);
> +
> +	DBG("requested=%ld, actual=%ld", requested, actual);
> +
> +	if (actual != requested)
> +		return MODE_CLOCK_RANGE;
> +
> +	return MODE_OK;
> +}

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

