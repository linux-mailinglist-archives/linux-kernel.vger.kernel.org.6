Return-Path: <linux-kernel+bounces-568615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADCA6986E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5469548106C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35C120C480;
	Wed, 19 Mar 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UlzCD9vX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943120AF62
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410346; cv=none; b=uOOuESGxo0EY+QGB6Iz61NzrMSoh3lR16K1MFysDewpk2GcIlbkvUqH9RqGG9tt8DfLk+wD18r4fszVqNVcOoKyrrkSheuQAMcGJlCvCefOupC7KupPxJAVkeGsUiwv6pc7olLXx3o6h24GL6FCcUgnIJ+JfzMByaANa2CdfTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410346; c=relaxed/simple;
	bh=0M6YQDs72gfV+jsPgaj46ufU7WjDlWBfzX2AhI4YCFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRbtgeGUnTX2cpH6FbAuLTIx8NP+fWXhEY6YC91OLdJZBE+7qHdUhDLQpl9XYtBqtlChZYbJu1CrzqSTJVxHScJbzr0wjlNyFEWrdju3gmzqA87IdgHp8du2Ijv9teWOemk5T0oGs2f6TZnd9XlzUxvyzHAfrIc385c4R6eLMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UlzCD9vX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JE5tUh028999
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o2JrlZxInygffkbnIxhe0MWZ
	Qd5M4umD0iQoB70ylfs=; b=UlzCD9vXBnImeJSObQDo6GexmUB7rfazi4TGHiQ+
	cSIgSGWbCUEhdYeuAPj9ed+AohmMi7ZImUHff8kduA/LZ9q3AgvIplGvbW96g83u
	BQyGg6CehrPXm8rT8Pydvnu2yRiSm2TWsaWnXEodAbrr9nJxwWqkhOivk7FCnbbw
	Y5PAhypdTSXyE5T6BRjmvJTgxTLUIGoH7D7+wWlwhrOSDG5zGqyLvTFbtT91+bga
	Sk22YEmg3PNGk2m1UXQPRUs7Witoo5kDFcR50ztBZXZE3n8ecALaMiTA7fa3x8ru
	3HXW4l4nqRonLjppn91kbuNLHyR5rvEuAQfJb8k0IVesnA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f91t4jha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:52:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8f4367446so84808786d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742410342; x=1743015142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2JrlZxInygffkbnIxhe0MWZQd5M4umD0iQoB70ylfs=;
        b=cP+ik5UntkgIBMqwbL4YtAjet4SCBl9/GQH+dHam08DGxPd+rjtoJLV/RBZwz6Vvc0
         6Nks85c/fmJwh2KWcVJS+r/6Xy4xE/vWc6EklccaMgwnzrnlQEOcAam4lVtHVxRfC6uf
         H3MxHTjxH92Hj6dXavVs5OvW/gMle4sw2VEtD0GaZptVEK6FX9mf27EbU7AZ7hS7Vccp
         /ciaitSmB5CG21EZfRrP21jAnX7Egq74ZBbDXRp+vkl/IuCqHwF6YHTUWipnZLuK4KWq
         2RqcDPTiBX6Vg6o2cScF0gdPxpSGl6EM9iNnnJemsKqcy+uhpLXPfrVp1HY5DhSYC/HJ
         aZTw==
X-Forwarded-Encrypted: i=1; AJvYcCUVIn9jzgC3XM7gmPM/oMpb5b2ozThSDQQcHOGiI1BgsRKI5Xps0UBH1wktFrlWK3wOJUWs3/agL5zW4o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGlAPRSKN9sWBSTf0dz7LQRQbucAKy2Fg4x5VFZ8J7HdqtVgfV
	srIKXCAvo4zXsouOYSHlfy0GC1UUUy1QGXKM4kkeq+xEXHJoHLLj45rqD19ABqqk7BrVdBBV5dJ
	/FOc9p/uoASGFs/QEehfLTm0vGujke5ib0Yj50AODwKFZ/efOL8uUekIrLS44a4E=
X-Gm-Gg: ASbGncvOtQZBJsN/9NiD26qE4yBw6XwOYeS1Q5iO7kHYG7pz/FFMXJVaWhVo8eesUqN
	kXWFTOQMrcfgz9GJmMhBnomRj1SXMkGTKOg/E2YD3OiXEM+X7KCIesm9AehaDgQVws8hRi+wptb
	AVx83bjYAIF4VO3+SJZ+DNcWY/kJiU5hGxUETyR/8TaNkqSVgYKryjzPUS1ZrOqigt9svDjXWLt
	vSeo/T37Jy//5oQcIXzK0pcYPopQ7IxqQqZZzclP0yK9e5jKyxlgv/5sWL3092zzJdWZUsYvEcV
	JJNKgaLoA2Qla/+P/xfpcp4N5Ygb9sCnkQvSeLVrfKtX2Dd2KvhyhfgTRhUOEWecve6WYH040M9
	l3J0=
X-Received: by 2002:a05:6214:19c2:b0:6e8:f60b:9bf8 with SMTP id 6a1803df08f44-6eb35329e00mr2748676d6.33.1742410342235;
        Wed, 19 Mar 2025 11:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyZio9qkdx621sRV5r0hgdNA5GgHPEN2TxpyMUdo1RgpYx/nbTusOZVvGhm+AJZBFm/raHsw==
X-Received: by 2002:a05:6214:19c2:b0:6e8:f60b:9bf8 with SMTP id 6a1803df08f44-6eb35329e00mr2748356d6.33.1742410341934;
        Wed, 19 Mar 2025 11:52:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864febsm2034961e87.134.2025.03.19.11.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:52:19 -0700 (PDT)
Date: Wed, 19 Mar 2025 20:52:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        Dmitry Baryshkov <lumag@kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 3/8] arm64: dts: qcom: sdm845: Add specific APPS RSC
 compatible
Message-ID: <vvygjk2bq7vpvcthkboypucbpcr7t4yzngincrpza2quew6jm6@bjyao4usc2lh>
References: <20250318-topic-more_dt_bindings_fixes-v1-0-cb36882ea9cc@oss.qualcomm.com>
 <20250318-topic-more_dt_bindings_fixes-v1-3-cb36882ea9cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-topic-more_dt_bindings_fixes-v1-3-cb36882ea9cc@oss.qualcomm.com>
X-Proofpoint-GUID: hmXHSWC5a3gLBrp7emUwosjfUxzk-VF4
X-Authority-Analysis: v=2.4 cv=Xrz6OUF9 c=1 sm=1 tr=0 ts=67db1267 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=8V4trvCbKhewGEgX0-gA:9 a=CjuIK1q_8ugA:10 a=PkAOt9_mmfBkvtOLxIEI:22
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: hmXHSWC5a3gLBrp7emUwosjfUxzk-VF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=705 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190126

On Tue, Mar 18, 2025 at 07:35:16PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> SDM845 comes in a couple firmware flavors, some of which don't support
> PSCI in OSI mode. That prevents the power domain exepcted by the RSC
> node from providing useful information on system power collapse.
> 
> Use the platform-specific compatible to allow not passing one.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

