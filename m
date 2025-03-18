Return-Path: <linux-kernel+bounces-566944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7ECA67EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D45219C69FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A1F1C6FF4;
	Tue, 18 Mar 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o0dFYN26"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5717A304
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333527; cv=none; b=aY2jsXBGlEyw1VC/DG3oe5aJRTQjSqLcxm+XvunAGJRkI13vfFZylWNIlpeOg/ec6etURD2+RRgX5SxmBMf4tcdU/zqj+Jfw0+wjp1MBXjKmtf5CYhImoXhH5xEtaz4W3NzYP9p7dvUlVg+CsNomupSGVNx7RcjBxxIcRTDsFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333527; c=relaxed/simple;
	bh=kGuYSW+3XPJhd4vYQ1Lm44snj6bCPoVrhsU9b4LTokE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts+msV1YcM1jjS51Vvru++UDF3vGtOwceTJdRwXEy5CDLwr/V+0XiYuKY9mvVM9ZSOLvrWD+ant8/XOnlb6K7XA0+Q8FnW6mCoLrlwwKT0ap+z2Mum0MW++ViWjbQplPn1t1IiTVOzF9345+Iup3fe2VW3xsoGpm9vmBtk8AVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o0dFYN26; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IGgxHS004751
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WyVK8yzJedmPXU0A2TA1oQaf
	q8gfB61z8bpGow7HKmY=; b=o0dFYN26lJHyEA1HimNzT1jqueP7/OPEpM2Ug5wu
	Q/3JFEX6giFl+vVgAt6de6F4bwhwosG9h14roPpHVNDaeYq76s7XknrLewh/0kbJ
	ex9SqYTS5uVYR5KzV7RWG/mZcPyIykOEnWESpyVU15JrWlrXyHKWT4pTilxpP5ud
	oOnOIYqYqavKw2HxwYBSis1jHtP9eI3l3otalSpzYkdl7bfOut+9O3RelhVg5+UW
	lNCVTTXIi/Wl+75cqccfqYlOO5AHZOn+aZXhe9m+60ObBm6+NGqmTL6Lk2m62O7S
	sOw96A6tagplNH+HH96Y/fXaQD5mIvXATbxhMiQ1TBcQ+Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45etmbuut9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:32:04 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8a04e1f91so171337036d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742333524; x=1742938324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyVK8yzJedmPXU0A2TA1oQafq8gfB61z8bpGow7HKmY=;
        b=ly2ZWnmjiQxnCaXFWi/2+eIOoGpPEFR1JDztuDLg7JFWRebvptJsLdpcSZ+m8QDw2p
         vmCgYYZM5VLdauAeKsZyHpv8XeHvxCwtMeB4n9u0dleABCSJbCszisK6DZNpPdPOncbP
         /oW10d7D++eAiZqqbYekTje36uZyS4pWh6zD0oSvE03HtEv3ghprqFnhaa4AfYMVPAi2
         HVhlTTMl05nMx58yRIBSZpXZ+efXesjNkIMMRgGOZ3vx/bz/H4VX9kfjbrF/m3l9H0lj
         IlkzZMsatpl7vgwbwAVpWwukb4i2hbMShWiflHB5IAi6b2JdM2qrl2UkAhxzf6Xk1AgA
         B9iA==
X-Forwarded-Encrypted: i=1; AJvYcCV4U/vCrH4C708l4Z5D//TWNjSaPWwP8ffHpQ5+A5WeF0r9pbXWwy/3urUeLivXvbtEP4chf4+1bpdNvDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzne1zwDivImm1d+fglDYdS4urMqEJSO6J3B37MTV9z3BwcGhqk
	V6S8uLwnUbTfwrSSDFbl2kOmgW710xLAGAbSPD2wb3M9kSXMbMS9HhmMM/PAqVWGESN++OE4wpl
	Ejf33SOGoh7HSfcqSnAMttI76XUwXHiIUY8IhYRy/tiak+WV5ngJIafIoj1vBszw=
X-Gm-Gg: ASbGnct1s4e9b5WMvvyRyfJJJgL0+6DabajyjSDX+/ROfjXWzszhlVevBNx+2MOBJWo
	6dC3xA9WLmDkh22VOzukHfK1vWGq9uQ4hg8kowbDXsG/xkXH/Vt0b4tlA1P0ctzrbxMImb1H0+x
	q2oR3kamrfUsFSEOrJD4s7YpmppLgFBbN7jxtFiCY5TjC+hrDvkO9tCq5kEPEnrJFKwTvsP1lhP
	hkU4r6qhezU/mxycb3asKn2Tyg+c8lNq5uzj4a8qVSL1INy3RYYcEJNPAFwmy18vBpw4wfZpDcc
	twaWjfxnipNjHvLiKG980vJ7G8uFuGDla5tGjXoR6h1Hbz7gxYHsd7y1fHacnUOUaMGyZXPTvuO
	fLRo=
X-Received: by 2002:a05:6214:c21:b0:6d4:1680:612d with SMTP id 6a1803df08f44-6eb28f47655mr8339996d6.0.1742333523889;
        Tue, 18 Mar 2025 14:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMUA1WDQvLma7EkbZSoTSIwuzcR3M76DR5dvfs3yKtMB6Y2b1tguSSi0KaGYpe62U401wbxQ==
X-Received: by 2002:a05:6214:c21:b0:6d4:1680:612d with SMTP id 6a1803df08f44-6eb28f47655mr8339656d6.0.1742333523618;
        Tue, 18 Mar 2025 14:32:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1170dbsm20535821fa.64.2025.03.18.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:32:02 -0700 (PDT)
Date: Tue, 18 Mar 2025 23:32:00 +0200
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
Message-ID: <obuvhml3u66gclv3dsyb5vfbl7mjcpp4i72bsk4tpaxclqkxrh@f4dcscea6gwa>
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
X-Proofpoint-ORIG-GUID: JTxxiyz2MEkcQey4wTTMTYX_ovXeFKZS
X-Proofpoint-GUID: JTxxiyz2MEkcQey4wTTMTYX_ovXeFKZS
X-Authority-Analysis: v=2.4 cv=aMLwqa9m c=1 sm=1 tr=0 ts=67d9e654 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=LD27zDrQdNAlnWmNbq8A:9 a=CjuIK1q_8ugA:10 a=grGYL8wM4DUmEeUJhF6G:22
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=935 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180155

On Tue, Mar 18, 2025 at 07:35:16PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> SDM845 comes in a couple firmware flavors, some of which don't support
> PSCI in OSI mode. That prevents the power domain exepcted by the RSC
> node from providing useful information on system power collapse.

I think this quirk should be limited to those platforms only. Generic
SDM845 platforms should be able to provide this kind of info.

> 
> Use the platform-specific compatible to allow not passing one.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 2968a5c541dc0a6c1c28e32160c4c40a8f332497..4466c08a8bb08075d71835e04733ff4dbf6f190b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -5264,8 +5264,8 @@ apss_shared: mailbox@17990000 {
>  		};
>  
>  		apps_rsc: rsc@179c0000 {
> +			compatible = "qcom,sdm845-rpmh-apps-rsc", "qcom,rpmh-rsc";
>  			label = "apps_rsc";
> -			compatible = "qcom,rpmh-rsc";
>  			reg = <0 0x179c0000 0 0x10000>,
>  			      <0 0x179d0000 0 0x10000>,
>  			      <0 0x179e0000 0 0x10000>;
> 
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry

