Return-Path: <linux-kernel+bounces-571569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538CAA6BEE3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694D23AA930
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BDD214A98;
	Fri, 21 Mar 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="paawdqxI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883B227E90
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572562; cv=none; b=Ij6zZO2tphLFvhZG0Q2z4s5PUZnPPy+zE3YLLs3pPjaC0EWlJWQhN/rk65JGe63e55da9382Cvh9qztjBOh8u0UG0kcLfFkXYl65LGydUIxzIIfvffF5BTUWd+0CKl+iQ/xetCocvMjn3dLfk1H3e9q6YJjezu4wYQudkjJxlyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572562; c=relaxed/simple;
	bh=Jq89ASxO+RlQoZ0gTVY7HIGXZ3XESEER/rt4tTQsbOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eorZTKAak45km8BfIoFUpOAkPq2NRXbedNrAwhI5i7vc63uE6m2QPe6bUdXNKbKuZKyYLSJ/M7MRxv1r8CkGol3lY7cTe4T5mtfGM/+GmBk8ljmX21aKac0OLpRrvzCDDt5vOe1rAOfiYSxYJlX/ftQttBzsuysBh7VTNdiSUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=paawdqxI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATLf2012847
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=04I2GyzdKmUJhCQaYtdGLGSe
	ZPL6vjPt7nnOQuXCnAc=; b=paawdqxI0c2X/qEkfKLkv8o2JkWb8utkyFdpIKoX
	e+QU9xFk0jb7j4zUIMf5Ks/YlxvUK3b12oF07grUJcoqT9vOfQlQtl6QKopesiDE
	spp5neDhNK9gldpZrsRpeLafeIO6xfTMz1awA/H+7czQW8mcZhcxNHa5K25jaFQc
	g9da/dvwdZeluENvmV8d2Sg63NL5Kmnk8rxZn1R9QKtprzi9UzXEuSBhoLSP5lA+
	pe9DZRuc/2oUcq6GJgRLzDmtBb17U62CwKV9ankW9VAK85oPP+dsDfose1I1D1Dz
	G30NVTqMFg20O2tWEHCrEEu/Yxy3XgcullJRmmW5b/T6Hg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g4t46ct8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:56:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4769273691dso40465541cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572559; x=1743177359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04I2GyzdKmUJhCQaYtdGLGSeZPL6vjPt7nnOQuXCnAc=;
        b=V2zH9GNQXalxkcIG5zc3mTxOhQ14IZzMnJrdeRTqr/MLuljuyN3Y7dLU+Zc/P0Ui/9
         Iii7P6HZl1EumPXaOggOjY1lJb35XEHorp/MIk3wVNIpTiSn7RGttneh2UCPoImEhkQY
         FcxQf8hlVuwDDIq1a2UwdYpdXGwHCEYWmCSFYahkDacw/0vplzrgM8LtggTV2nDac0GF
         T3AC3SfCatqbejNI3vHczJAB6dXtTrMmPOS4PKf78PQKKBVLegk+vSOh6uxxb5zdw8Bc
         jHW//676jqbBaOj6IW7ugpzegTVbLzLdqBg4j3VMLVOydY2zbcbNQ7JoMdL8FriTGigq
         mRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVSp1lN/E72QZQo9SSErWyWGgAMT40isGwgvnh9Z/928WgjURRyxXfNt6XWFPrRvZv0Me+PeAXM8mxZ+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE/wiCzskdmvE4Z3q86yB4psKCZVnpyvKRKb6227IhmZJZD4gm
	uDWOpKDEBp+UA8B6IBVu2WWL0CHdeGWjsprP9m9G69WiXzSj39fyk1Yst+RmivfRtGAyMYF1f5T
	jc77Ijq4hMuzWi2B7FD4VbGGidQdM6crxzfQbQsNjYUQwullzkzpC7Hu9K4NtL+M=
X-Gm-Gg: ASbGncuCOe6Lv9N8progUSYHpJr1nY7puAUqa1sraQFz7nxorSNqc1ZmA8T+JBNgYVd
	NR5BrJENr2zNGFE9Nt7zffP4+YGvjk8aKg9i08GSmIFCPNZ0jrPDMRS4sE3/ZIO7QPhsQSqopgf
	C3u1H2whpdCgSBdYeRdxq2Hp5/NTaGAN56Y5F/MLEykKy49hdMz4a2a9g0xweRo5q6aXOnHbV/1
	XJx2h1A5LZtjdyLIkf9GssRmyKeeSKc8gV5G31qTKERUEWRFLBcLChBANGHQZlfOb4BG69oIT91
	epX+BwFskqPeCQrWt9lVYCyY28w8iYEg7TrWhU164R5L9hVzdHbRF2OYhtNI/y36oDSIjWSCHhn
	ctqo=
X-Received: by 2002:a05:622a:4188:b0:474:fe6c:be44 with SMTP id d75a77b69052e-4771dd79997mr61852241cf.14.1742572558625;
        Fri, 21 Mar 2025 08:55:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF07+SUkMs8VSdxuN5uNzjGJeTfpHG0ykEhaRVsi5AnxzE/ifh8qn7JCa0nZawf12AcsfFBAQ==
X-Received: by 2002:a05:622a:4188:b0:474:fe6c:be44 with SMTP id d75a77b69052e-4771dd79997mr61851351cf.14.1742572557858;
        Fri, 21 Mar 2025 08:55:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6512aeesm207340e87.244.2025.03.21.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:55:56 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:55:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: qcom: Add video clock controller driver for
 SM6350
Message-ID: <pzevgib37fgdupythk3mawmeuki6dflpw5bze4ujb6jcjvj7ar@jmjuzeabvq7y>
References: <20250321-sm6350-videocc-v1-0-c5ce1f1483ee@fairphone.com>
 <20250321-sm6350-videocc-v1-2-c5ce1f1483ee@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-sm6350-videocc-v1-2-c5ce1f1483ee@fairphone.com>
X-Authority-Analysis: v=2.4 cv=HMPDFptv c=1 sm=1 tr=0 ts=67dd8c10 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=qohHCxWBmeq9gVc9HfwA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: UBIYf689tsKcwDZYY4gaV08dgEiM4dgl
X-Proofpoint-ORIG-GUID: UBIYf689tsKcwDZYY4gaV08dgEiM4dgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503210117

On Fri, Mar 21, 2025 at 03:45:00PM +0100, Luca Weiss wrote:
> From: Konrad Dybcio <konradybcio@kernel.org>
> 
> Add support for the video clock controller found on SM6350 based
> devices.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/clk/qcom/Kconfig          |   9 +
>  drivers/clk/qcom/Makefile         |   1 +
>  drivers/clk/qcom/videocc-sm6350.c | 355 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 365 insertions(+)
> 
> +
> +/* 600 MHz */
> +static const struct alpha_pll_config video_pll0_config = {
> +	.l = 0x1F,

Nit: lowercase hex please. No need to repost just for the sake of this
single line.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> +	.alpha = 0x4000,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00002067,
> +	.test_ctl_val = 0x40000000,
> +	.test_ctl_hi_val = 0x00000002,
> +	.user_ctl_val = 0x00000101,
> +	.user_ctl_hi_val = 0x00004005,
> +};
> +
> 

-- 
With best wishes
Dmitry

