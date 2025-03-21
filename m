Return-Path: <linux-kernel+bounces-571403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ADAA6BCB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C832D3ACC03
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB7A1991CB;
	Fri, 21 Mar 2025 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iJTOldNn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BE155333
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566541; cv=none; b=lWJFTbP0KjgA0YiFyXRANdWY7+09NL8kurUgibjhRTwBJclJaUrnkISxGrzZ4Nxzn5qs1iCjCe6ofJIM4FjEBRFbfKzheHB3KGdWJZMEEsfriWZJr9ijqxSY/pOp9hcAdxz/Ewm5zumS76K5/ZM+olDmRMLiq33hbyhiNgl7QP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566541; c=relaxed/simple;
	bh=QqIcu4sARdCLr3zrpBsteLaFTv3e4KDGIf+jbp3Xn9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxnDG+je/QpICZIl5baDU80uEIqmEFRubUgzfZE2FXHHSm6D9B4CZzca4/7RDoF+aeaaLZh+Zxqe2PuGV0l+fvdnOkaKVvbjlqKRjGqS837N/mVGXDLdNmxD8KWt7YYAaXmHkQ3zmfkLDiUssrB4ZIomN+taPhiLYy5htatqmeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iJTOldNn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LCShdm010560
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IygKvUSovqJjIcgBHkL5I8fd
	pvAkZ2upGcSD5Jix+nc=; b=iJTOldNn2Hujp/0G059Gy26ug4FclmrYmd8es9cq
	8K6TWDVA5odygD4qey/epN6oVcaw5LFZiG9lbyj0bRdmxwWsgOSeeSL7kplhRhBX
	jOre/1U3+4O7xg4IVT0uQWXP/Dt8UF0e+/MtlllSOi7fjeA4RnZHp2pcb5DmGZQF
	hQPzFT8IVuoPREIiX5PMrVsL/1hy6CtdpWbxbeM/r2B3/N/Zgg3amQUAyi0lCGEg
	MMrDVIfeFDHtkJkGSQVGOzuT4wJH6eb/Zdf/EP5Kkk2mq4mheGy1Cy0FQ69FpTKV
	Rt4BiyLLU0eGNCn/zPes5yN9OKWDeouak3r/qqi4UqJvkQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h85e09bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:15:39 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8feffbe08so45348656d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566537; x=1743171337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IygKvUSovqJjIcgBHkL5I8fdpvAkZ2upGcSD5Jix+nc=;
        b=TKXLmFEoNZH+iEnZHuyGDMpbhBzp1UR4ht7qzccE2RxTS2cKyFzuMBgee8sHFvVthH
         fcmBhgDxUbqOlO8ZCGP6NFpAi5xyf9ar58pwCKmVzB3RlM0B4TiygujdAfHck6UaRIAc
         7ufDx34NVRnmXsVDhRqqHxDTsAfxL+R2C45aj1kkGO9MxDSI86xizbA+dxo0UOFOXtJC
         dUN5lhB/4Yq32Q75kYsNVye+Q+c1tPFA5MEGgIwgg9GRuhzdFporBMtahCOGR0MNsGad
         AKkim0zKvwNyuAyB+TYkBYdC2920Cpht53lpLWZyyxyszq/EfaC0o0qoQQlMsGb+fMK8
         qgeA==
X-Forwarded-Encrypted: i=1; AJvYcCUwHUD8z5tUp1wls1Km5DEelpwUC/gaIidlj/H3BcDBu/2J66rWTJd8XwqoNejcr0yWL+K6yzrpjwHSBks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CKZ9Wj7w+XBo9NrGvQ4AOqZFxs7TTzl+d7CVYvGC5rxgxOfd
	5gzAzqEFEGfiy2bLsZCmpnUka3KN+RS8qZQVmAjCCRV2eE6VOpthGKc/G1ekK1hsarXJYvyz2mD
	A/7C9bp8eSU8XiNhlcs3Waxy1hMWKHqYftq/6RiwN6Bd4QKsEMqPMBOWX5/NNBL4=
X-Gm-Gg: ASbGncubvFZP8nBiuzjVSR23nBdk7CjJt4SDP5SvalOO6CNawWPTWAhcX6G1MZ+CZpz
	bN3kIcETQg2r6Ajr89ZASHGHvSeGDmBtuaFtgQROvqxb2VdjNiybjjn41PFs9tvrBXHO6sFV4Xd
	+VWfc3vqTPycvNVyut5JMacIZGsAQ8O49A+YKMS6oUQ7PoIvpjpPxgljCzllNnU3/fg8aCQI/98
	sf/fSgXOrnHoi2v0675kVTD1Bw0dFcGzSCgcND7wsZdFvRpGJtI6vBBB87wcv2CECaBcXDgT71j
	HRCKteSkpe5cziJ/StV3g7xFLGjrnAPSjnXoZQeIrn18re7l8nkdRuLCTz0PpNEtDTiugSt9+qT
	XVHQ=
X-Received: by 2002:ad4:5d6e:0:b0:6e8:fb92:dffa with SMTP id 6a1803df08f44-6eb3f2f5960mr61025026d6.25.1742566537077;
        Fri, 21 Mar 2025 07:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFN/n1Ojxb+W+fnWe4TwdIO9ZmKkhfBLlVD64bA7J5vncM0McnA+X9BWkDQCQmyd0kZxS+AA==
X-Received: by 2002:ad4:5d6e:0:b0:6e8:fb92:dffa with SMTP id 6a1803df08f44-6eb3f2f5960mr61024326d6.25.1742566536504;
        Fri, 21 Mar 2025 07:15:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d8f3c93sm2661681fa.82.2025.03.21.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:15:35 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:15:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 03/10] phy: move phy-qcom-snps-eusb2 out of its vendor
 sub-directory
Message-ID: <vzlylhf5r5xy4ip4hkcolt3iye4stiabzxc4jwdzenbhll45ct@hx5gwpzrd33y>
References: <20250321135854.1431375-1-ivo.ivanov.ivanov1@gmail.com>
 <20250321135854.1431375-4-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321135854.1431375-4-ivo.ivanov.ivanov1@gmail.com>
X-Proofpoint-GUID: SKP_YWVrQF83FKOPUdDJZaXg0BmxY_Yd
X-Proofpoint-ORIG-GUID: SKP_YWVrQF83FKOPUdDJZaXg0BmxY_Yd
X-Authority-Analysis: v=2.4 cv=LKpmQIW9 c=1 sm=1 tr=0 ts=67dd748b cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=N56nwJYzXhOJYq9YhE8A:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210104

On Fri, Mar 21, 2025 at 03:58:47PM +0200, Ivaylo Ivanov wrote:
> As not only Qualcomm, but also Samsung is using the Synopsys eUSB2 IP
> (albeit with a different register layout) in their newer SoCs, move the
> driver out of its vendor sub-directory and rename it to phy-snps-eusb2.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Please fix the order of the tags. SoB should come after Suggested-by
(and usually it is the last one).

> ---
>  drivers/phy/Kconfig                                      | 8 ++++++++
>  drivers/phy/Makefile                                     | 1 +
>  .../{qualcomm/phy-qcom-snps-eusb2.c => phy-snps-eusb2.c} | 0
>  drivers/phy/qualcomm/Kconfig                             | 9 ---------
>  drivers/phy/qualcomm/Makefile                            | 1 -
>  5 files changed, 9 insertions(+), 10 deletions(-)
>  rename drivers/phy/{qualcomm/phy-qcom-snps-eusb2.c => phy-snps-eusb2.c} (100%)

With that fixed:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

