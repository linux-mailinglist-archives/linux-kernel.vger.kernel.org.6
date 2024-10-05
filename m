Return-Path: <linux-kernel+bounces-351955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1837A991850
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301BA1C20E55
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499D7157495;
	Sat,  5 Oct 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VPXOk3ZP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81B211C
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728145878; cv=none; b=Ucd91Mozsq9Fx1o2b0+bhqbbEDsAdIiAWY2BT+qfPrUoSFnVO6iyA4s/fb6RP3x00g7/KfQ5jySe4WB18QCXCJJQHeB6ipV6XD1p++AmwY/SU564y6AwWBxXTkHM+WGsn1N64rrib+BQ4FUPcvi++61yOEQQqFNyvI8q5jmpYXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728145878; c=relaxed/simple;
	bh=SPLDvAIKA2wal1cbyk5bpbu0Yow0nPLmaGDY1ntAsVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihovEO3wA6Ef6DyZWR2Z3G0h03ltfa9J3+8+7vqnaFQcSAV9eRe4qL5Rdk22APpVdBPcKVaEj63i1o9WQ3IJNOy5JvPDlywgf9jZ9Mrgnxg7a5mQi/eJMzmdYSkWk3TA7bzodjxuNbwT9GcDGwGwIJldl2semSCmuTwCCYpQVko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VPXOk3ZP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495GVGmE027805;
	Sat, 5 Oct 2024 16:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g1DrUfZua4F6fDsbCUaZ1sAuO6WCHxhZhRBSszMS84c=; b=VPXOk3ZPzZzKL5Xu
	x2ArITegt7t/KEzJ7o53fqvESvVYd8hD6WfPZCknFiwD3Uj9hcOKn6Qxmffj2CxG
	Rsax4DHC0DkXUlamSz20UXv1tr/nOoZ6PchIw1WU9uHlXl/4427UHagxFvsnh6yt
	9m38xrE73TW7PmAY12roZ20kM93bZdTIN1HCAZmd6tTWTJtjv/c09R9w/4VLwZNh
	Oc8n1mHE4S28hs1JvoxPh3IzxQBeli0x8yXfng3eg00sHcnjKduZrvAKQHR7KO5Q
	a9i5Bwzl4laVZt+Tvfy9N2QkY8TLuORF8azL3RDpXEllNZ+qfeen80IdEIKpsURX
	ILm7eg==
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xv6rtan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 16:31:16 +0000 (GMT)
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c885ef98a9so616431a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 09:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728145874; x=1728750674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1DrUfZua4F6fDsbCUaZ1sAuO6WCHxhZhRBSszMS84c=;
        b=jhx/Jt4C8MjfTtIEIt5xLR9vo0fweE7TqdV5tB1CN9e5Rq5eE6hK+VXc7HOD/ORflU
         mIs04NZqNk7hDicKOlur0NauqfuMGL+RT87Ecx4JlXB3ZHMjADjnh3p8Icqu5EfRHA37
         cNI1jJ4cw7MEw21MNr45L4E7P59kReTdD1KbOcfv5buZwtnlUikwMA3lHodWGoAfnVOt
         WFYE+n5bucLhAT/v+aHD8tslQNTSK9Vb8QvPvDQ+VrfPT1IKbYaJ7pbNhT4izJS+Ew0i
         GMsnZJHeM3LSLd9VJmbbSYp6gT0cY7cJigEbs7H76zdlj6jN0hbfqfPl432jyHt9RFZF
         lKIw==
X-Forwarded-Encrypted: i=1; AJvYcCVgscOAsEOwh5SSW87qPPMlIL+kOZSFUYKmhRLnBT5ILxcw6kcW53VasMdrmedjJvyNxhQg1U9qwPR2f+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzWMU8jDH6+F4jQENuhTlT2Ls8OcxjF7AWxIWvCFAOpluLvZG
	jyTO9tjXuoKcRhyjaTkrQsP09aWzvDk2Ronx0gCFZODE3jFBn5qQ06Z4Eq2XG4cqAD/8SXOz7tU
	kadq2lXihys0t70KfVWMZShlWsoxnw9eC6Cp0N3YYnhfpcnxqOlJ6BUI2xiNH57w=
X-Received: by 2002:a05:6402:34d0:b0:5c8:8381:c17b with SMTP id 4fb4d7f45d1cf-5c8d2d02685mr2360053a12.2.1728145874129;
        Sat, 05 Oct 2024 09:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDDW6XxiZgpQtH+HswqMKcQG1qf3+CFB/WbtT35s7v9ACQdUKD14uAlsycQAjBffPIhQy/3g==
X-Received: by 2002:a05:6402:34d0:b0:5c8:8381:c17b with SMTP id 4fb4d7f45d1cf-5c8d2d02685mr2360018a12.2.1728145873125;
        Sat, 05 Oct 2024 09:31:13 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb4b9sm1157579a12.75.2024.10.05.09.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 09:31:11 -0700 (PDT)
Message-ID: <ba56c822-cf3d-4d62-86d4-e04551e443c6@oss.qualcomm.com>
Date: Sat, 5 Oct 2024 18:31:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/msm/dsi: improve/fix dsc pclk calculation
To: Jonathan Marek <jonathan@marek.ca>, freedreno@lists.freedesktop.org
Cc: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
 <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "open list:DRM DRIVER for Qualcomm display hardware"
 <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER for Qualcomm display hardware"
 <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20241005143818.2036-1-jonathan@marek.ca>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241005143818.2036-1-jonathan@marek.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: H58XSpVtflMRW31y9Hsva_Ksru0I4on4
X-Proofpoint-GUID: H58XSpVtflMRW31y9Hsva_Ksru0I4on4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=948 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050122

On 5.10.2024 4:38 PM, Jonathan Marek wrote:
> drm_mode_vrefresh() can introduce a large rounding error, avoid it.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 185d7de0bf376..1205aa398e445 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -542,7 +542,7 @@ static unsigned long dsi_adjust_pclk_for_compression(const struct drm_display_mo
>  
>  	int new_htotal = mode->htotal - mode->hdisplay + new_hdisplay;
>  
> -	return new_htotal * mode->vtotal * drm_mode_vrefresh(mode);
> +	return mult_frac(mode->clock * 1000u, new_htotal, mode->htotal);

This seems to ignore mult/div by two on certain mode flags.. is that
intended?

Konrad

