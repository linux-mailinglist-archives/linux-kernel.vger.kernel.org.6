Return-Path: <linux-kernel+bounces-434987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452039E6DF7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182EC166E34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A6201033;
	Fri,  6 Dec 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eoHDjxEa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0351D516B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487626; cv=none; b=i+Tx2WaSTaqK/zSxgyK2+9ApeQeXDyxoJ5aRpPU66kNOylwZO5J7cHISlDL0DKwmUXe0Ls539FuPaZBaqg2myg+UZAF9zieFbi9IXWEQBqLP6ayobzlpgFYtfYjL8qlBIvFXNo6g/E2TbvAd0n7eNaAyEiYY4Os5G9iRZUO2Mnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487626; c=relaxed/simple;
	bh=1lDabRe7v8hzNNeM2BJUg19w6htUe29NSOeCwC/ydLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMAtfx8arOvMW2Fnd7zwdEJy1eQpR7lz+y4+tdZyPJ5AOMyZRamKQvBlJvxFZPrumfojPwvbS08ZV+bVqNWcIR6LOlEqaKdrHPdedsncSSyCiRQKf1agUj6PH6dczRTgkZFBuBRyc40l2Bg5WUq2ly52MeZsrQyGRrj6KWE3ClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eoHDjxEa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B68a6iM018434
	for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2024 12:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9E3Q5V18pzVm0efIN2Z36r5MoCfL8CYX45xyLjaUZPo=; b=eoHDjxEay15UJjR6
	IwX7o44jEaiQbMhdt5dcw6lLE6+/89AUfsd8ka4uEkuIOkjIOe3BTWVxheOVCCSs
	yIZJc05bJ+Rm7FhKHG3sbiS90CAvrv2TNAlBs/LIuSdffIGx91XFAMZqxEQT5Uz0
	3QegG+MjAZyHHGXX9ys6M5CC+dZU3ct4BabykCfgej9n3b/5b+hIhOuZ0hY/qI/L
	X+p+7rVKrp/HkgTV123zb6rbunTRrn3l6yVbQHXXmTsc4DU9zEwkKf3S0aVO4fKB
	f1ZwqxV+oUPj+ECEsMsY/SLIt87EBwbInIVFu5ZZLJjof9+H78mdzzU4fTq2MRQ1
	v0tulA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bjk8t9b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 12:20:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4669114c62dso5209721cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 04:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733487623; x=1734092423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9E3Q5V18pzVm0efIN2Z36r5MoCfL8CYX45xyLjaUZPo=;
        b=msy5bYg3w0JxuF9OTHi4Q96HeAwCOsI7mmuGUKjjOgugbZE6R0DqrIQYDjgi7e0ujp
         bIZWjPA+pY5n+wz4fWVa4VgyvmWLB5YIZZ65mgJMuzC1/TA5Q4xtwDfsKlsQfeYGeQIn
         TgyvkjyworjOAKPGcEV12lkJ+39mTbasoAmCJhu2P3MtFjt8NAa5ciXZe5VEfOPpZAB/
         bmzgf2OVGe7GX1WeDCh7ZPegJelgAvzq9aAp9piNehraesYqJ9b83qydsPjOPcVFsfsc
         Hen0GPUXyyHhwDCuIu2+b9NRs/3emoy2oSuLybxgu1RMZA4ZyaF4KE1ueNMvt6FnzOlP
         nfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTc0Qx03cTt2s54Pq+SRhUqnT/mFpJnOl/2KNxq3zmJgF4Gsrwx9EFdRpee3MaFTE9AEO0AlLuVZ2ek4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzJCjUvmVJ5Bswl+9QKyT82sNiQgfDk/K6Xb1ChDPSSH+g5TH
	UPy9LQdBTCrsgUr3qW1x/4JFQM1iSouGRK0KXGJC9TsZx3B/WBBAAl7KzKfKnGiWsz0P60WJM0Z
	8yP8hVU2vbHVoY68oWuku82G4NTYIpWTEepo3EXHM8pRXrkmzSsv4YYuhw6XfLv8=
X-Gm-Gg: ASbGnctyEvAq3QamUbjrJGzoQxnCmNpaNy4EPZtYwsSFU54e6ev82zEVARg1mOKTpmG
	Aau4QvW/yc71pzeu3eB32Jn3MSgPg27TuvVRTv3E4JiG/1RGO3SIFVYBTGpHYGaMGNRO6uOO6XR
	UDO56lTyuWMuUcq0L4+O/bWr5jWeirjus7FdpcCw5rWakN5JlcXj9tO3VxE22wRBVikkS9yyQyt
	z8FIpndu84CtDJbaGFDkqQZs56207Dq6X42g1zvZ5Y8ynfP66GyHgbGRHxcu3HjI3qRYu9Fb1ui
	Ndrd+BRl+aQX54Z8A0RpSqmDrPjITj4=
X-Received: by 2002:a05:622a:606:b0:464:9faf:664b with SMTP id d75a77b69052e-46734c8f531mr18002181cf.2.1733487622871;
        Fri, 06 Dec 2024 04:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaYjuLbGBmcbEVFGiae/eyDl8MSbUHvTvfg7816ggOQFX2Cej3+/3TS1KDf5HZCvflpH7buQ==
X-Received: by 2002:a05:622a:606:b0:464:9faf:664b with SMTP id d75a77b69052e-46734c8f531mr18002011cf.2.1733487622527;
        Fri, 06 Dec 2024 04:20:22 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a25924sm2113819a12.17.2024.12.06.04.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 04:20:22 -0800 (PST)
Message-ID: <d83ebaa2-1da8-4f85-9034-670e525b457b@oss.qualcomm.com>
Date: Fri, 6 Dec 2024 13:20:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 44/45] arm64: dts: qcom: add mst support for pixel stream
 clk for DP0
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>,
        Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-44-f8618d42a99a@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241205-dp_mst-v1-44-f8618d42a99a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NVqS8H-VSmzOlxA_7D56pigoWWkJfXG8
X-Proofpoint-GUID: NVqS8H-VSmzOlxA_7D56pigoWWkJfXG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=879
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412060092

On 6.12.2024 5:32 AM, Abhinav Kumar wrote:
> From: Yongxing Mou <quic_yongmou@quicinc.com>
> 
> Populate the pixel clock for stream 1 for DP0 for sa8775p DP controller.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 0dbaa17e5e3f06c61b2aa777e45b73a48e50e66b..0150ce27b98e9894fa9ee6cccd020528d716f543 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -3944,16 +3944,20 @@ mdss0_dp0: displayport-controller@af54000 {
>  					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
>  					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK>,
>  					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> -					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> +					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
> +					 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK>;

dispcc also defines PIXEL2/3 clocks.

>  				clock-names = "core_iface",
>  					      "core_aux",
>  					      "ctrl_link",
>  					      "ctrl_link_iface",
> -					      "stream_pixel";
> +					      "stream_pixel",
> +					      "stream_1_pixel";
>  				assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> -						  <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> -				assigned-clock-parents = <&mdss0_dp0_phy 0>, <&mdss0_dp0_phy 1>;
> +						  <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
> +						  <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>;
> +				assigned-clock-parents = <&mdss0_dp0_phy 0>, <&mdss0_dp0_phy 1>, <&mdss0_dp0_phy 1>;

Please turn this into a vertical list

Konrad

