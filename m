Return-Path: <linux-kernel+bounces-571409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F4FA6BCD0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EEE3AE122
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5061D5166;
	Fri, 21 Mar 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mbWFbcVs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF419C54B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566652; cv=none; b=G9YHCcD+bOeLrZ9nVYIF7GhCycjhqwLusNuIbb3bQvTyyWGDDJHOBC0e8M18V/LbZv0hQlJawMGnkea2M6bDi4dRsnwrZmJrYa0FaXLl36fJB4iafbyF23ZUfHKiDE1iliBpCUs/Xe3o0xz4czpl4ByuPd8LfndEl3bVrsrmgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566652; c=relaxed/simple;
	bh=GCY3r8rAAbKxWBoKNPFtSuyFe2XkAq3Gsfr1HfzAxdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLYtansiz46Y1GOmU2zDV9EukeRiF2iUk1k9GNfhsCeLgZANENrJ9sNWqOhIMMPFecprVsWJDGPuHszbqHt/8zsJCw/upkm2XUvffHUrf+WvvETyhynScwnzAakEUEMd6Vaa/8SVSJcSMu7Fo/1mcrB6gtKtJWfFNU/Y3WGbjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mbWFbcVs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LCSgcK010551
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=O8rDG6mc90cpVD8APsXbzuEd
	d44KuoOwLvpTV3Smtis=; b=mbWFbcVsxJyNDBSxrw4EZss8r0tIgahU/BASCYmS
	XN7WM4ujs2W1Ev2+dp/h2z8q5FwVs5p51c2TZf2tUp3y+yFtw2BZuCC4Ub97itct
	p5IZIsAlWbCYLlV0s0N4dIcEjGoca1zWVCrrpCoiYaUFSagwmCB9ZyNWSCH4R03t
	x0rw78T00jCOW4UQtDHjy6yQHb46rA2mQGXyiRA4sNuut1BckZV9VQIt4iLJeCIN
	oWz/OHDhp85banjVwEcH5xiYsmffG/vphQqCvqGcmTxT6N0MqwYDvSk7XckD2gGb
	UXUQyAwBRCkU4gUz8f4JlFZ7tlOB1R+BV42QufwL+UhUAA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h85e09n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:17:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c59ac9781fso363823285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566649; x=1743171449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8rDG6mc90cpVD8APsXbzuEdd44KuoOwLvpTV3Smtis=;
        b=Y9o9WHTaAMq1Gwnv+nzjtkaWFwtsvCfCEH9tKxh9oC+Ukb4WVKbHbFdG5nNiraRKrY
         J62JIRkzxLlDvGabWp2qGXEYxW125VmqcPf+/7Zjhg32MwwicslfchNvl+x2GcU5ctZF
         PEb2HL9t3xK35pxw3bKEvItcxmPv+10Qv5y6Vjjx/kT8lt/DIu+7elmr7GBPYdP9boPq
         BrXJpeN1IF+rGwJjwrnsE+gTupTkgDlopmhYNFS98iG28OxlyZpH+GTa2+CC7dKON6rU
         VQ5GJ/NN6Bu6oyLHvZgROA3lkeOK1G8+DaN5vi4mjWZh9XT2DUvS04gW9w20j3AzYNXG
         qoaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPnMxp/Wx5ItDqNHjOchmYNMb53GFu5vJbs5+xsVxaQP0202boi20Peb42cbiGhNBlfDGxOL+jTae8IUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLH1IDSs7ba0eduNqEvZo/UIapvbXJxptURXnhGVMCfToVqCvz
	wEaLF4mMPA4lCPV010nKRRaTczGUUZzm30yS9OXc8Z9EZL/8GzlYexN3XzPnyN4iWVquh505lCb
	kEms2f6zHU4toWO0Q5av7gStBwyMRxEHUQRGekCgULjRNw7QnQaytBwtKPsSnxrY=
X-Gm-Gg: ASbGncvBZavEfu/yH1Xo/RXym7kwh7jBiDSThV3j4garSsauIfAi1Jty8/ISmT/qLLR
	6Ra1V3EzEU5hkRbyMHx7Ks917gIJsd1ViCHIQuE1HrIIFliIbpQ4H7uRUoaa+9NlZ4kxlBCDlSK
	Vrg25XFIn67gI7gB7Qy5cDNcenZ60+aaFVIU7V2BqO8I6dbFThe1bLkZQSOaVbAtAW/VGUxAYHj
	NjCFJ2dZAI05rADnO8fzOSJHIJsKhp1mQf0Ww6joIXnma21zqxhLGmtu/YFanTN4M56xGOjGChF
	3ZniOC9LZRmEIAffnbw+jdM4O3pjXBHbjUHIA968mES9771p0r875YYYC4FoEYdlt3w5gv9skwh
	J0HQ=
X-Received: by 2002:a05:620a:3948:b0:7c5:6b46:e1f6 with SMTP id af79cd13be357-7c5b04e1a47mr1057150285a.1.1742566648727;
        Fri, 21 Mar 2025 07:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvRRIcP4NEyB+cyjpZHS6ssbbMaBbZ4WSFsTnEbRxypn2SHDAJVW5qIbAY4WpbAbHbZm7Rbw==
X-Received: by 2002:a05:620a:3948:b0:7c5:6b46:e1f6 with SMTP id af79cd13be357-7c5b04e1a47mr1057143885a.1.1742566648233;
        Fri, 21 Mar 2025 07:17:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6468766sm200353e87.35.2025.03.21.07.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:17:26 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:17:23 +0200
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
Subject: Re: [PATCH v3 04/10] phy: phy-snps-eusb2: refactor constructs names
Message-ID: <ftscdayi4uegv4bfzckytfrg44vi6f5wlvlhjqsh5nmgumrjx4@ur6rgxj5ixsj>
References: <20250321135854.1431375-1-ivo.ivanov.ivanov1@gmail.com>
 <20250321135854.1431375-5-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321135854.1431375-5-ivo.ivanov.ivanov1@gmail.com>
X-Proofpoint-GUID: K2BYZHGvN7GPVwcZiLNsuS_p14h6tzLN
X-Proofpoint-ORIG-GUID: K2BYZHGvN7GPVwcZiLNsuS_p14h6tzLN
X-Authority-Analysis: v=2.4 cv=LKpmQIW9 c=1 sm=1 tr=0 ts=67dd74f9 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=bmNeyW_Q0om-5_paTGoA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=888 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210104

On Fri, Mar 21, 2025 at 03:58:48PM +0200, Ivaylo Ivanov wrote:
> As the driver now resides outside the phy subdirectory under a different
> name, refactor all definitions, structures and functions to explicitly
> specify what code is Qualcomm-specific and what is not.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  drivers/phy/phy-snps-eusb2.c | 256 +++++++++++++++++------------------
>  1 file changed, 128 insertions(+), 128 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


>  
> -module_platform_driver(qcom_snps_eusb2_hsphy_driver);
> -MODULE_DESCRIPTION("Qualcomm SNPS eUSB2 HS PHY driver");
> +module_platform_driver(snps_eusb2_hsphy_driver);
> +MODULE_DESCRIPTION("SNPS eUSB2 HS PHY driver");

Nit: Synopsys

>  MODULE_LICENSE("GPL");
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

