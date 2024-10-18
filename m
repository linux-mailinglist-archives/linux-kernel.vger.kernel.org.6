Return-Path: <linux-kernel+bounces-371853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C889A4157
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F4D286985
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11521F4266;
	Fri, 18 Oct 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnybuBjw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85C768E1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262311; cv=none; b=B7IgBiU6GrMbWQC+t1a7MmM0nnuvq60XXrkWh6bZW+9onYjc2MBHbkk+Q7TNLEYHmS4ifKjw3o6ooC0mYqQmBc4mVV3hfRp3RudihKjUbztl0BPuyujmjIyt5WCGDNZwxEvV5sTwYrewNViR9NvzzY4HXB4qMB0/PBKdpbVhnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262311; c=relaxed/simple;
	bh=3vtVzJDjO4hhGtzY7mL/ysZwoOF4XCQVmDf4LPXOHAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qs2hhgiwVgJLs6bpa4PrTillOxis0t9xlXgefUNqRcUn56BVP7tr+jCiYIDbgrTyNzULdsK6kwl8YDEYJqTC3vM9tsQisCW3E5jDYN07KpjglCcFN7yEQ10TWR8Cw/q/jvFZFVVTgAHc75W4WzWyTRGqsx20LmsAWnxoeOM7bPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nnybuBjw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9UDhC005924
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qLLf6NBGqq57X8m+i8aTVP2VFdyUUpFIAyF4cHswm/s=; b=nnybuBjwv6PesV2r
	ttOjpQG47aob8EaaNHYvR0hi6DK+m5MzrmkQ3KthMpFi36kSqye8Da1np0sAzrq4
	u20XVp5rh8BCaW6mz8uTvJIQ5a2SqrdIAOkkR15TZTSoO6Cd1qDu32bynXfxajV6
	HnruP0rIaZW82gjgz16qGGMucQadYOjGkphjFjAF1Xeaw7Fc6npNrWzPcSbLBtTO
	zG1Z14KzKiBcffkcQhSKTdhsVBO3rb9iaxLLvBaT4Ne85gJuK3f3qPgf5fPhFKNt
	5YwoB19V4VNLyW+lL0sTeJl3oPrX5bFD/N6vcbengy2UWD5ByQwLLjZFtpKt9mUX
	coVZ8w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ajm5egfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:38:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e2bd98f155so446931a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262308; x=1729867108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLLf6NBGqq57X8m+i8aTVP2VFdyUUpFIAyF4cHswm/s=;
        b=uwlvlorxvNZSpJH0ScTZKOXuLtBsB2IJMMYijLnAtox8MluOxSJ36u0gSNiwmSuadi
         HtVmq6Y8tmkVQh0EYgNkAi8L3mNMUH2QEWxuaQ7YrpjRZWV9P9mush3q3XkAHBiaaTd7
         RoC5bnb3kKvv8AMTZ/y5ugymmzUWN/5GVGul2u8gRGlqWZjHYtF4r1A7wduOdLfREBsg
         mmRR3m00Iw651QrulW3fbfxqm3byS87d3ZwPAwcxFfzqCQDLLhqGN6haHwHZnknVrxO0
         S8MXgqdcsDMBKdnN3zw8TFKHUNqTnkZAB5xpIiFds9651B2BxkYH16/rKO5AX4EKETuJ
         MFpg==
X-Forwarded-Encrypted: i=1; AJvYcCUoQBzPNsbB9Nosdb15cBMvBl45R8MAYmjBBk3r3x5gevk5uEgcSHKElLQNo491UgiA8cQfAhJj9QhJY30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhhyxs3P1cBs61/PVwoVr22/deNcFYHuz0I3X85k/KJ+uAP5Yd
	+sY6LlcD43WuJsl8zGAtoDNStHnzi3FATyL11yMKLTPLumFU6LD5rB41nLxDDXYkbQrDUWjJfzO
	avh3D1wfLLcVrjuektJJ4EwEt3byWHTkkBQs4xtE6e06gHr/ih9lkNTxJfnhL3kg=
X-Received: by 2002:a17:902:c94b:b0:20c:e250:d4e with SMTP id d9443c01a7336-20e5a8bbf62mr15901535ad.9.1729262307735;
        Fri, 18 Oct 2024 07:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtifDhaDED4RcVW01Nkn3eRd9bKSd8dRYBQzz9k9SKeOMPmgHYQZ6ZEBgh3vVDhHuUSr9LcA==
X-Received: by 2002:a17:902:c94b:b0:20c:e250:d4e with SMTP id d9443c01a7336-20e5a8bbf62mr15901395ad.9.1729262307361;
        Fri, 18 Oct 2024 07:38:27 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b076fe5sm835268a12.1.2024.10.18.07.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 07:38:26 -0700 (PDT)
Message-ID: <f4dcebea-e2a7-41bb-bbd4-58e34bedee01@oss.qualcomm.com>
Date: Fri, 18 Oct 2024 16:38:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sc8280xp-blackrock: dt
 definition for WDK2023
To: jens.glathe@oldschoolsolutions.biz,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Merck Hung <merckhung@gmail.com>
References: <20241013-jg-blackrock-for-upstream-v3-0-839d3483a8e7@oldschoolsolutions.biz>
 <20241013-jg-blackrock-for-upstream-v3-3-839d3483a8e7@oldschoolsolutions.biz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241013-jg-blackrock-for-upstream-v3-3-839d3483a8e7@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: etBYivsS6eYk-Xe2JNRGFG_mU0qfEALg
X-Proofpoint-ORIG-GUID: etBYivsS6eYk-Xe2JNRGFG_mU0qfEALg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180093

On 13.10.2024 1:54 PM, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Device tree for the Microsoft Windows Dev Kit 2023. This work
> is based on the initial work of Merck Hung <merckhung@gmail.com>.
> 
> The Windows Dev Kit 2023 is a nice little desktop based on sc8280xp.
> Link: https://learn.microsoft.com/en-us/windows/arm/dev-kit/

[...]

> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wcd_default>;

property-n
property-names

(all throughout the file)

[...]

> +	pmic-glink {
> +		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		orientation-gpios = <&tlmm 166 GPIO_ACTIVE_HIGH>,
> +				    <&tlmm 49 GPIO_ACTIVE_HIGH>;
> +
> +		connector@0 {

Could you add a comment describing which connector is which (see e.g.
x1e80100-microsoft-romulus.dtsi)

[...]

> +&gpu {
> +	status = "okay";
> +
> +	zap-shader {
> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/sc8280xp/MICROSOFT/blackrock/qcdxkmsuc8280.mbn";

"microsoft" lowercase would be consistent with other DTs in arm64/qcom

[...]

> +&sound {
> +	compatible = "qcom,sc8280xp-sndcard";
> +	model = "MICROSOFT/blackrock";
> +	audio-routing =
> +		"SpkrLeft IN", "WSA_SPK1 OUT",
> +		"SpkrRight IN", "WSA_SPK2 OUT",
> +		"IN1_HPHL", "HPHL_OUT",
> +		"IN2_HPHR", "HPHR_OUT",
> +		"AMIC2", "MIC BIAS2",
> +		"VA DMIC0", "MIC BIAS1",
> +		"VA DMIC1", "MIC BIAS1",
> +		"VA DMIC2", "MIC BIAS3",
> +		"VA DMIC0", "VA MIC BIAS1",
> +		"VA DMIC1", "VA MIC BIAS1",
> +		"VA DMIC2", "VA MIC BIAS3",
> +		"TX SWR_ADC1", "ADC2_OUTPUT";
> +
> +	wcd-playback-dai-link {
> +		link-name = "WCD Playback";
> +		cpu {

Please add a newline between the property and the subnodes

Konrad

