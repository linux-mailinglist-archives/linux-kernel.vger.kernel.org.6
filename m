Return-Path: <linux-kernel+bounces-521211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62392A3B86D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C671888A65
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0B01DEFE9;
	Wed, 19 Feb 2025 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JwQ3U3eD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC491DEFD6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956481; cv=none; b=ivQMRHm759Vx7CLxjMhd7s1nL9WZXcTgsiCTsdQs7GzVB7+ixtmG71ZquxvEDuGdD3hAODf8jF5aVHjvlazwYNQfTzYniHpyto5Teu97Q1q+x9KvgFOOTk9PmI80QAQyq6dmXbdUbrR8iqXlQ990445vSbEiTlEuzy/O8g23lTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956481; c=relaxed/simple;
	bh=vt4rT9YHovWLbL5WKB4RhLCxhRaR2niAMxbUVN7VX5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o7OWcLdxHyBoWGraFrdRxOCMMXlw/3QH1hbRzmHiaThM3XF9qrhVKOHwQlg9O8BXPQw72vj/Sc1Ol4vHTuI5mJMwwZwJZ631wfrdYaPEwaYSFyAoPbdbK2TaqIhbe8Y88KKbUoe0BAuNZAfHWlsrcmdi9pYbvNunPct1lbdxf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JwQ3U3eD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J8LKPp031904
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IeqopofIxMoJ0SF0tmrZIswJs053GwoXuq3tHJKY+ag=; b=JwQ3U3eDjS18rFdu
	QD8RMrO2cnblEPf0uJyUTzJoKimPTv23FaeuItxIakKDUgjlgS25zrmeqRQzjSl5
	wAuPbsRkf1kwzcTVqOFP4kPgR8/gFzjvp24dxGUQvSc8u55+obvKzpTSXbFiIvo5
	zNUKZJ0gQ9KpYwxmP9amgW/L2WmZmQy2to7zY9wqB/tEmzfR+BGlQBEn60ryYKNv
	Z5i3YMnna4PZYKxtFK5fQEIOh+2R3oG1xpPhwBoBXe0WQnFabnBaQhcWVrzjYoz/
	Lq6joAKV4UvwP3pon9UyfuX8V8R2z+3Wb7lx+RtDETStSDW4FwLRTaQr/Q3xHQNH
	7mWAjg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy59wj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:14:37 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e66b3359f7so6797266d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956477; x=1740561277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeqopofIxMoJ0SF0tmrZIswJs053GwoXuq3tHJKY+ag=;
        b=bFHCDGgBx8+QmJzGjbt90Hym3mRHsLv2/zuKka7SFoBk9kAhxoV6lWHbNUrTybndio
         9NdxH0KU4W2pphAMrnsqiQF+6e5rvKgLDwUTiDRCqP6zle1JiDan2W/+IhPZy3PmF0hK
         8AC/HBoI0rYNPF5nWKqH3rB79xa86W59MvCbAi9bXSKn4pJFOTwugK/O8rJBl6GDCQds
         JHo5loyNMyElYrIKGkSTglJP6fUQauuGmZPfQOW4b4M512AkBmMZ9G7sr7Ul8Z9rigNU
         R/PFnkSl46tWbcLJnFcZgaCrTdlQrhT/whqKqjuUjGqX3u7bizeYA0MHdLoSYlBR2tWH
         64uw==
X-Forwarded-Encrypted: i=1; AJvYcCWve395VXdO4UeaCHGnQRPVDLdtxHyXOnI5KfmDM5k5crvmChDtQqlUIkGfc5ot+6t6PrsT6AgywjF3hvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe519/XDB0d5C+zJFvDzG8yNMvY9fyYiYSny3LWm7IPrV+hsW/
	alWe3iyiwFVPbn9oIgVaYowuVFywlP5dhJ9qlwAdAviHbrr/6h0utoPM1Gis0hiNZ3WyE2SwYrk
	lXNEael0WRVae4rdh645zhe1rYxRas8V18wFQDvDXZehP6dhGhhF8BnBqUX3utO4=
X-Gm-Gg: ASbGncuh/QaUXuzwip7nwjJ3W1WS5JuxlMQnMAjmYSBq93p3g787B8K83u4bYLXORy7
	wc67mzJZQug5sJpWH7LaTgvJoOqEU5sUsX4Ka/68sq2pHu/MCbZxRFXhDA/Pv4rfC8PFBcV3iyk
	kTAtk2LbX4HHB/LLesyx77+xRvXHv2gYzXUP8FPegmH+czf8ehVkFKwMGK2nLcLSOi/cMYG/piO
	ItCcw7dsCTzuJsgY3IcDAHugAuk225g0O60Za9/SDaizYWimA3GiPzq53AoWT0QbhSrHLXAY/fz
	J2UtNd+ftut3jGI19KatajUD+Q6vUEVhxdhm63WjbUqqiec9JajtVcGZLMw=
X-Received: by 2002:a05:6214:2a48:b0:6d8:99b2:63c7 with SMTP id 6a1803df08f44-6e66cd0341dmr83145046d6.9.1739956476889;
        Wed, 19 Feb 2025 01:14:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/zkeorXc646BRrW5otRU2e8zonUuyZQUghLAIsYLF3ZC3687CPfBC9GiCGPZQsJgcV+PUmg==
X-Received: by 2002:a05:6214:2a48:b0:6d8:99b2:63c7 with SMTP id 6a1803df08f44-6e66cd0341dmr83144916d6.9.1739956476552;
        Wed, 19 Feb 2025 01:14:36 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb916db37bsm628608366b.165.2025.02.19.01.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 01:14:36 -0800 (PST)
Message-ID: <3c16c6a5-7c1a-4ae9-b865-7ea3c12767e0@oss.qualcomm.com>
Date: Wed, 19 Feb 2025 10:14:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Corret white-space style
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250219090751.124267-1-krzysztof.kozlowski@linaro.org>
 <20250219090751.124267-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250219090751.124267-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SCBgLINUHpOKJc9crBVtPeA1gxzKrXy6
X-Proofpoint-GUID: SCBgLINUHpOKJc9crBVtPeA1gxzKrXy6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=863 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190073

On 19.02.2025 10:07 AM, Krzysztof Kozlowski wrote:
> There should be exactly one space before and after '=', and one space
> before '{'.  No functional impact.  Verified with comparing decompiled
> DTB (dtx_diff and fdtdump+diff).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index abb92c81c76b..f81a3c3ae334 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -990,7 +990,7 @@ uart14: serial@898000 {
>  				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
>  				clock-names = "se";
>  
> -				interconnects =	<&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS

for those wondering, there's a \t after '=' that becomes a space

Konrad

