Return-Path: <linux-kernel+bounces-446216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19D39F213C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF421887CD0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB4C1B4F09;
	Sat, 14 Dec 2024 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ufr9PJ6x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16561B0F19
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734215164; cv=none; b=KqLAgwvXh1+zgL9sC61omYiOgfXL8DDlN+Gj+BUHPI/sq8TwlVhD50tsWE3Wnr1RggfxtcHtEXg0TzEouc4dgYbYK4BKA7CbQp78LLhyp+PjC/MbL3nLdWPYs8/JT6PihfbWuZ8He+2LeAOEOf8f0UBKzcM3dWkIeVDyQmgpgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734215164; c=relaxed/simple;
	bh=8gpA1dHw2n8NArQXqHK+4y2LvNdeJ3FMqOgEQItAtik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNMPCCC4IgCPbpk3c169003GqbIq3+8vaj0zBuKTpOhZW6mxnIasXalVfVCqR3+vQsJfkuz+bgKf1M7S6mihoczaP6v+vhRxPtpRPm3Gsme0h22DJuzaELjUigJPS2tXv4qOKFGtnA4mqlIbLDwot/yvn0pTW9yZsiBqeVtVfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ufr9PJ6x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEMAYbR006061
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4cYf+fIp6O0tYi333GxKT8sngxhGUwjhZfc52mhhGiU=; b=Ufr9PJ6xTKSHV3Sc
	Fqaqf8oDU04FYQDH6mv4oLKe0Ai9SZoFhkqZtdnfshmtjYRpnsN3xv8fgzz+1KJu
	Ts/0leJRSYtAJcPNGAvjE7O3c2x9pzCFkHh8PIm3e2zwG+e0hIuBAOf2kJA3lNBz
	+dRYm5bjMmDJPh3NUS5OgqX0cB9a2kHmMwJYRE+cmlHJUpI/7LvXepDf3sJX2RE0
	dF22vREdA9swUW5AFiK8j99Uhy2EdfBLdwd1J357UoQiI+vtpS7N9FUvmASvTLTB
	RtTKgnIaMy0aPHehUX2/EY87NJ09t1XsR7nfSISJ15r2SiV97yJYByk3PiCsC76s
	lj+xeA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43hfm2g62q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:26:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467a437e5feso5671161cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 14:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734215160; x=1734819960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cYf+fIp6O0tYi333GxKT8sngxhGUwjhZfc52mhhGiU=;
        b=kmLpC/yRtcSKNGTtDGKHwYe9CKhkhsSWrYymu4vzbHqxui0z65Jki1A5cNaThp+mnL
         XSVY6b/kQWda+ZqP4Fok17MXlved40YbNT/pZaLElMLshN6XMZlbymJx6sYz+JQPedJ9
         zFrrd/XAgjVfp1D0LajdCZMdc3S1cztZxGq3KPWWnMUSKoqi1d0dVCFLM1m9ug8lhwuu
         Hg+IAmaaWkXPTgp7TamJiKX0WRu868ai/8pc+MTdF5Z16mgpqZDT4OL76YlzHkimFkb+
         odxoA5czldioAuiZ0eMUyVz7aStHHAkbj71mY+RrSjOISRqijVaXmITtcrGpuKBit1gE
         WKMA==
X-Forwarded-Encrypted: i=1; AJvYcCUnJY6dev5PF+nmMznqEUXieIRmaG/lXL6EjIUGls12PkCjwm2ZXsJQJPNmt2q4AXWbQ93OoYIllHlN2cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlyCh2pPBO8h/3JMjnrgu/6FwQWtMne4+NdNKPj+d2c4IGVptA
	FiAT2pyo1NUVzMLSRoLYLaal388qk/q0UUQrhA+fWPej/JCvvoCEyIFBUT/JHXlIdvssq2VFVyZ
	ZLBF7WeZG/7S7Q1kAzhBHh/PVijPiIcaUrUO9hGlLurIV+BHzauieWef302x15T8=
X-Gm-Gg: ASbGnct1TdHZT56JV0UQHxDUorGGgKzpjHEopb29rIuuo/XnoCso61e4KfOCKjLtOO3
	CcWZ0vteGHtOVeNemTOmNrCos65Pdd98uBCRoCzfsQvAfsXMhN09i6l/UcrMwN0xO3CweiRYYvB
	jEwkMTlVgg97CW4GzIEr3SwDp59JGkvys4dw+bADujTlVpecVWX+QjvSECL7+YMJzSNzspziAKh
	gpdYHnWsdKui3YdzRAd6+T81Sy1bL6ARLLmMwk6xVjjfXVjH6R8QuBFqYV/o7PBjWzXYf61SjKP
	hdpaHIW6JYv95hMxx6ziFnspQvzvm3eE19A=
X-Received: by 2002:a05:622a:606:b0:460:9026:6861 with SMTP id d75a77b69052e-467a578e2cemr51182041cf.9.1734215159706;
        Sat, 14 Dec 2024 14:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy3CQjGTQldVtLkouHU5cCLTpoXg+9TRQXEIp9dtfbaLJ0YpWV2irQdO65sKCWWIcHWP2RfQ==
X-Received: by 2002:a05:622a:606:b0:460:9026:6861 with SMTP id d75a77b69052e-467a578e2cemr51181841cf.9.1734215159274;
        Sat, 14 Dec 2024 14:25:59 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ac49sm139824566b.144.2024.12.14.14.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 14:25:58 -0800 (PST)
Message-ID: <3fa6e136-b59f-47d2-9ebd-9040f422d25f@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 23:25:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] arm64: dts: qcom: Add initial support for MSM8917
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
References: <20241211-msm8917-v8-0-197acc042036@mainlining.org>
 <20241211-msm8917-v8-6-197acc042036@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241211-msm8917-v8-6-197acc042036@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: W8IYIpk04B7ThmDvhD1h3rEIeb1c4CjR
X-Proofpoint-ORIG-GUID: W8IYIpk04B7ThmDvhD1h3rEIeb1c4CjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412140185

On 11.12.2024 6:59 PM, Barnabás Czémán wrote:
> From: Otto Pflüger <otto.pflueger@abscue.de>
> 
> Add initial support for MSM8917 SoC.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> [reword commit, rebase, fix schema errors]
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---


> +
> +		cpu0: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x100>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +			clocks = <&apcs>;
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +			power-domains = <&cpu_pd0>;
> +			power-domain-names = "psci";
> +		};
> +
> +		l2_0: l2-cache {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
> +		};

By "under CPU node", I meant as a subnode ;)

See sm8650.dtsi for reference

[...]

> +
> +			sdc1_default: sdc1-default-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					bias-disable;
> +					drive-strength = <16>;
> +				};
> +				cmd-pins {

Please separate these subnodes with a newline

[...]
> +
> +		apps_iommu: iommu@1e20000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#iommu-cells = <1>;
> +			compatible = "qcom,msm8917-iommu", "qcom,msm-iommu-v1";
> +			ranges = <0 0x01e20000 0x20000>;

'compatible' should come first

[...]

> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			reg = <0x0b000000 0x1000>,
> +			      <0x0b002000 0x1000>;
> +		};

and 'reg' just after it

Otherwise looking fairly good!

Konrad

