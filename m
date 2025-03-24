Return-Path: <linux-kernel+bounces-573530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EFDA6D8B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B41887CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1650325DD07;
	Mon, 24 Mar 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pxAL2vnt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01325DCE5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813809; cv=none; b=sfzn4GLxungUs6lW7rHH4TY0CNMtrsm9LLDV8G5UGohE3l0aKsUig1IPO73UuivADB8ZQzcDV1YhM31JEx1lX81T0ICZ68UB94jBQApoBE+ZsAsRRWMQ7awzCUb+IoCuu+cV4FojN6Sav7juKsBEHZcLGWu8H9QF0bE+hBx3ang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813809; c=relaxed/simple;
	bh=kPYx8cgyNK+kHSQtkC7ctNP4NXMxSAtiBwiPNiHZre4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l91xw5yKJ1aTSYXeJTTNFxe44m5izEBW1k1UsPvzSNl4KGXH0EleKdzE8mf5v8IcWXeIbSZqBLlR4h16EP0W6WEiHqwUHzTc2v6+ymqZn01hiaIQ5hhFWZOfLCA2/++HopNjSSlvYPXfypgqvw36kUyC1F+MFsUVoEjhmE9V0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pxAL2vnt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PSqr015777
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XDqyeQYxCMC6oQIBhg40FWZB
	5CKH/Iz5ri1KriEvBUk=; b=pxAL2vntZ2ENa/lRMqDeJIm5Ivg5QAmnxGSio22r
	5sOGbVMTzcqXFdhF512KImGQx03mXpemZRkiF+80QRdW1IEcRGhpBosjhyNbSOz6
	noIV2sKbm5pFbdJ8p4KeWXupsbn0LF7n8DZiTvJQzVybinFlL8RvrWsTH/8WhCNO
	tVXvQlyZTutDGpgwPhN9x08XHjWoUDI0PkyH4ghZGyNtTpBgu64VKw2cKnuQYC7Y
	Tchli7YC3VzAmZfTCyF3mFUHGWn2TX018/Y/EAVCDzSJBppZf7BUm83DrNfLtjxG
	3CGSzw1FwB39OZxiqKV2b1R8QpuRdbQrdoJmIbbENRpkyQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hn9wc306-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:56:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7bb849aa5fbso1091799285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813804; x=1743418604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDqyeQYxCMC6oQIBhg40FWZB5CKH/Iz5ri1KriEvBUk=;
        b=rt5ojomstZk2s5kRI14mzfKEmfkRz7CUZm/zycrc+U0w1DUnO6XyJgFCnx+PZuNx+5
         PEn/BUVeetGHdPePPh+fD1th+bTd/z15D+hlVVD3C7iDmtWLJREC2mh0DOBuIlIwg/JJ
         N+IbK39Gxm2mLX9viFvJxSFFfmxgOcXsf5MdwXXrNwZqgneZGVhPAZ1uZZWvNlrEEP1E
         jua6rMGhGdZrzWrZwJgUdANM0rFE4xRZAheuj/J6i+3fKVyCGn9U0MAmlo8uouq4wG+f
         /i1py4w9Yi4h1kidY2GkPwZH7MCYmGzRhvSEH2swFTdUsbaaFOUH4mz8pmnDX6IExa3G
         ZVIw==
X-Forwarded-Encrypted: i=1; AJvYcCWBIL89Jva0dfeYvHFX5DkJ+E4AfpLnHvh6Uox+yNKTckgp0fzqsJ3ge6DUdi8yXCzwpz4s2gHp2ZIsnLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr2wQQ8qdskKP/iN4TuK6Kr7u3IWTYQiwjEVr1GxzRInCoJt0k
	ZmMeSr1Xp0yUeL07nF9tN4GOdJBPvIT906yyT7xsby5R+M87DxtBUjsLbJ77I03kDoq9LlfWXU0
	8K2Dk62EfB6bQgSnHqixdf/poDEx6sEWDu7qt0ViP4AxZxyHfHD4kluD7f/HIOfo=
X-Gm-Gg: ASbGncs7+uyGc4Xu6C9D3j6hEPSgLOlHAMAMIKrnFNJE3Xu3oWZ0Pg0DwoPiKaeyp58
	cdzYXOkwlZLy2Ah78VPtE0p2QLfZbyHGVn9LB3NV7DiC43MH7kmZoYzehy51xo6h9k6afDS9L2y
	nNerYnKyXfH18zx07dKOU8JmYCA/pl4RTaEITrWwP0DkwPhuKAxkgEtuLVK16mP25iftCxIMoca
	cTqCBGWqd2n+gaW3tRFvhknglNrjHYTyWQl2HkhgErTSMxJr+eLYl6uApb7W5Usmt+mcjVWQWfO
	MZR4Cu3+EJIH7R+68BtPZV54qhr0BzMciBY4cbP7Eo6o+ZUZRXtGD0snaDQw3VRMHJbRbCYYgJc
	/bUE=
X-Received: by 2002:a05:620a:269a:b0:7c5:3c0a:ab78 with SMTP id af79cd13be357-7c5ba14428dmr1425654285a.14.1742813804455;
        Mon, 24 Mar 2025 03:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr0zZwwEN0C3pwdFAW2oW4ST3woWsczcIVhfpohhK/s4eaR0iSzFfgzBbIorwxbfn/58dsFA==
X-Received: by 2002:a05:620a:269a:b0:7c5:3c0a:ab78 with SMTP id af79cd13be357-7c5ba14428dmr1425651885a.14.1742813804016;
        Mon, 24 Mar 2025 03:56:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad651243bsm1078937e87.249.2025.03.24.03.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:56:41 -0700 (PDT)
Date: Mon, 24 Mar 2025 12:56:39 +0200
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
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm6350: Add video clock
 controller
Message-ID: <2dt3oescrflodyud7mnnji5enj66slgte3cynrqp5bbmnie2vl@sjb2fv73xbnv>
References: <20250324-sm6350-videocc-v2-0-cc22386433f4@fairphone.com>
 <20250324-sm6350-videocc-v2-4-cc22386433f4@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-sm6350-videocc-v2-4-cc22386433f4@fairphone.com>
X-Proofpoint-GUID: -9bMWx6UbH4BZ42SIYPVAwbxslMePuNl
X-Proofpoint-ORIG-GUID: -9bMWx6UbH4BZ42SIYPVAwbxslMePuNl
X-Authority-Analysis: v=2.4 cv=CPoqXQrD c=1 sm=1 tr=0 ts=67e13a6d cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=1crZ-aHStTAuZ86CvOAA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=911
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240079

On Mon, Mar 24, 2025 at 09:41:04AM +0100, Luca Weiss wrote:
> Add a node for the videocc found on the SM6350 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

