Return-Path: <linux-kernel+bounces-571627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB55FA6BFDF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD53E1896B55
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ED822B8BD;
	Fri, 21 Mar 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZtbrNKnj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0011CF8B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574277; cv=none; b=MErPk3VPnz5dCbKHS1900zIYF3AZLnILPR2Bql57XpLBj8G+lupD3xkzDDAIGB5cSQCGvP0lMYPceOXPeQbjoO2GjRA4SEx+q0KGkCHxgpmj8//Icy4PmnQ3rYL4onVq1Qd6/DIbHnJ3vE1o192XmBv8DJG4h55H2Cq9MHxMeec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574277; c=relaxed/simple;
	bh=KYbavFq5N0PhM5XuZB+lkOkuCFlDPfZyy++Peu9XsOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3yrxbtWV+Tm3k/HjghHlfFwj5uxUw+Jpe153xcDoY01PZaHEOKjv5kjaDf1g0JMLsaB4jbFTGQ+RSVElD+euJ0OvyMOd6XWTByRjVMAWWldrKKz8MzChhmIT2l1ABmASb1m4pmKFEAKCztGxihf6jNYbg7yw2LuVCVBrNmf2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZtbrNKnj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATBlV016546
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ezUvZQcZtwMrgBYlUmzB77M/ia6WCeZ5frQ98fyadU8=; b=ZtbrNKnjtpjQrL4p
	ofV1Qu+ShD8CFFWgmB+lu1aU3ZVNz8K9Sn7/Fabi5p5bphNEkQ0rtdMlR7NMoADQ
	c4fUcprPbP2b2U1uFkOcZQoqMvWgwoFWpCETImYmNMTUQf0OuIijCcaUS6lrO6xC
	AM1v1jlDboyDc/6ffHPUNg7jZpGDWo9yQsP8AXrfkL7f2TSS55YJqB2C/mhnmjy6
	d2vL4iIGUqJWukz6SFeZD/3eMI7Cdr59fB1wbPcrya0VJFyYn/Z7WwYxQ4aHj3SC
	FLYOEkPchfiPNE8nQRLwuHAW/T7lxcrfvXkwD0HLD6W8jtiZckSdbX+4q/IzAdBf
	mL6KVA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45gcd1dejs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:24:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8f9450b19so40201736d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574273; x=1743179073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezUvZQcZtwMrgBYlUmzB77M/ia6WCeZ5frQ98fyadU8=;
        b=nyf6OvtjRsQnNJIGbVEwxiMGKqew+TvNZZDS6IgEe4YtjM+aOIgQyRm4dC/a9EyRBi
         wYK8FUmg+gaHl7E/RpSRoTvgJzWVa2cVEDYDYPH17YzGi1qtrZdt31VnFJF/L3idHWmk
         126Lhx/EciHzhqk1S5a4yjv1+411fHX1tpqKbrL8Lnb58Q2MHKQIq4VdFCJNALIt0kSs
         kxWseCK+H2oeTw0m/PRl5nMe7jTydcP5v7yuzY28ihvyycDF2/JyyXxWYwhwVSPuFsqG
         IhUDccPnFbPS3XVrE+aoBxvMc+pfSrPBuBwHiHC8wiexMlTUG09Zx97UMr0UF/WAmaN0
         9o4A==
X-Forwarded-Encrypted: i=1; AJvYcCXf0g0zkuzfOysYcPTGIbfq0yP0HCvMetlPk9ZkyN3JV6FpnE+0Afz4QjfulS3bXmN0wArVu+sguDxPPSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVeaaBtttOTfOtqGMm6gn8SiwZJWrrsKXjKquXJqcmTplrFIdN
	p+dLr4cg982DHONryigyivQR9EcTDfT//4RR6GwHHoknsiFDtjad8+7FWdC+RFOIKDb+iOHXVNm
	Hcag1kp1r5uysG36PgAYBOpG11zCqqDwICVM9h6HN7m5YakXFGTAgL5pXGypfqH/GYbyh0i8Tjg
	==
X-Gm-Gg: ASbGncuabhUEGioNtnyK4Dql8xhI8+tdkqGwlTO84PqPZsf76VgKUxvnuvqwoTGNYZg
	859e8u0SeBvf1YqUWNa1hSomVgslH/irQfiiNDHv+fcDngNLDdvoCHHntwJipgUp0ME1p9SYW2J
	0Jt0ev+g0S45JnCGFcmaGJ6DP30aO6HNBgL3KLSYsXabtQX/FttLX2OKw3ur07Dw69CbQdTBceb
	PHnidkAWGbei9mRLb1O0n64tk8DlVQOe/Y85sqJwak+iD+kB+srdI2pxX8qnEcou8TqD5DzigCq
	7ilmWKChj1Nkrx8rU9Hz8m5s2Mj3zFYnVZQGuNoe3HGww6dlXSBqXeNDY1yLIczSVBzSQMGYcL/
	Q1i0R/pxEE5RTKPingUEsCMwYgQtzWh1tY1ivettRaV5XKXe7EnajbgWF9023Mde+lYOE
X-Received: by 2002:ad4:5caa:0:b0:6ea:d604:9e4f with SMTP id 6a1803df08f44-6eb34a27d9emr122911866d6.19.1742574273443;
        Fri, 21 Mar 2025 09:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfSGRUC3naAh8M1yxzEOqb0ryoZ43qJS30vtSLWnzr26EwF+jPBOlX+Bn9WciwgRg5g9565g==
X-Received: by 2002:ad4:5caa:0:b0:6ea:d604:9e4f with SMTP id 6a1803df08f44-6eb34a27d9emr122911386d6.19.1742574273001;
        Fri, 21 Mar 2025 09:24:33 -0700 (PDT)
Received: from ?IPV6:2001:14bb:c2:310f:a0b3:1d12:b116:f8e6? (2001-14bb-c2-310f-a0b3-1d12-b116-f8e6.rev.dnainternet.fi. [2001:14bb:c2:310f:a0b3:1d12:b116:f8e6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647b423sm214685e87.64.2025.03.21.09.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 09:24:30 -0700 (PDT)
Message-ID: <8eba44d0-1f4d-44df-a13f-994bd766dd31@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 18:24:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/14] phy: rockchip: samsung-hdptx: Avoid Hz<->hHz
 unit conversion overhead
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
        Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>
References: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
 <20250318-phy-sam-hdptx-bpc-v6-8-8cb1678e7663@collabora.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250318-phy-sam-hdptx-bpc-v6-8-8cb1678e7663@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bfFrUPPB c=1 sm=1 tr=0 ts=67dd92c3 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=_XDy0L4iob18M6GPC-sA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: UXOEznEnzfvXh4aC62Wb_X0805DujI7I
X-Proofpoint-ORIG-GUID: UXOEznEnzfvXh4aC62Wb_X0805DujI7I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210120

On 18/03/2025 14:35, Cristian Ciocaltea wrote:
> The ropll_tmds_cfg table used to identify the configuration params for
> the supported rates expects the search key, i.e. bit_rate member of
> struct ropll_config, to be provided in hHz rather than Hz (1 hHz = 100
> Hz).  This requires multiple conversions between these units being
> performed at runtime.
> 
> Improve implementation clarity and efficiency by consistently using the
> Hz unit throughout driver's internal data structures and functions.
> Also rename the rather misleading struct member.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 79 +++++++++++------------
>   1 file changed, 39 insertions(+), 40 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

