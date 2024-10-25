Return-Path: <linux-kernel+bounces-382385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BB79B0D11
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FF51F23E16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F179A1FB899;
	Fri, 25 Oct 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8nCrUmU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4418BC0E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880512; cv=none; b=VbumEW080mRPRcU4951NT/a9LMFzGeOedrWwICh8SCl7dPPdTrNujUdov8WzFJA8ZG3oYLuADNje7c9HLdCJz6aF+7O1epWtFg5K6HM4uSJJGE0cWIHP5oWrvg1XwyjxNRTisIkeqm6ZPvZd8+O5XCv1DxymKv/1eKSwzH0ESAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880512; c=relaxed/simple;
	bh=WzxkF5Pf2GgXdOv2NsMN74o4H+ZLyM0sRqeVFm/4TDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWFryJBQ9hAjR22iwJ4BKn7/LXkoHggb/uYCmco6xAOBMIdh5JPO5qLjLOcB7KZi9U2UuizFKKP7ayhsfsG6dM3xP2RNdBnbkoVGlOt0JhhDE+1BCH19+Zur7vk/2S1as2EHX1h7gDTAwYOzFbnayPqGDse9Mp9e7v65wbGFBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8nCrUmU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBUHxx029391
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vma5hQAGnlL8WuEcR2i/409KbAY9l34Zk+QQ2K058yA=; b=C8nCrUmUimX/Rca8
	8KmzI9b1BIgEQMolLm+CTYKLZ1MQwBdaOGDiB+6CCFGXQfjVurmTQZxhH0autkTe
	dxc/+uF4eN1EcYxL5eEcQ38lgke1Zt9fJggfna7+ktGM3N+OVIEa9ZZKGuTGsqMv
	XB0ZD8xD8gFNz5IhhnvCaWAhYKSfjZMzunMADfpAXVMiXlQDPPsvEuyW7yX7/Cts
	ZI20glEHB0Xwio4eCN3qOZNQpM43oy7bVBWx5t89kWk9xx2GVP/fZwIqu4mWQwJ/
	Wn8AYBXrJHgXpSJ6fuDUs7G2z2EuIA6MWg2wmcxXLgEBosWI2yqi2u32LrDLKKTG
	jaahUA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3wa30k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:21:49 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbe5e8658fso4638386d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880508; x=1730485308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vma5hQAGnlL8WuEcR2i/409KbAY9l34Zk+QQ2K058yA=;
        b=Ba5t7jaQf17Td3KIqQvkqW8w5LFjKxip3BxJYQFNv02fueTiocsVofFItb/yfh9atI
         CRijliXFReRqp/LeYPzkWJnz8blFLLWEwBvOSFLHLdU8uHrwf5U9M93RtQiOhgFiYFvO
         yF1qCxlyxvjKd26ICd3oLR9QLDiCk56aciyyw7Abd2fIyCjYxBaTWOEXMmoMw3tNr9xl
         1RsJpZylxoevTHS+/fc/GvXG0gutuNM90yVl48bk69kA7JZd0URVBNntCzqhySoLBnb6
         bZlNaKoL9ypERTvHJEkLnv8v6Z/ukjc/HSwRo04ZedZvfTqDsfdmsUzgmAifk2pEgn9I
         3VOg==
X-Forwarded-Encrypted: i=1; AJvYcCVwFZZ5i/QerT4XFY/3rDFq8HkF9gmwIJhWdOX5HroIlvGsuCA0XfOVs1jNMBnOV7m69V7V5Cg8tPYnTmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9/lmpGdZDbODU2ccqiqxCMv304nYpG7BvbCEEyonB/NZsUf0
	kotNug2KfNbfW/VykgKu5e4E0+8i2rEdgXuNsdS/qgaHxkeLpLe6iIRc6d1RDmyfdRUBQE3umsf
	/l4PMO2VVfFIEsCPJHNtA3q6QtR5hvLMi17e5uCIrodAKECLQSvMqfRJ2qHPwVJE=
X-Received: by 2002:a05:6214:21e3:b0:6cb:f5d6:3f9d with SMTP id 6a1803df08f44-6d18584a56cmr2412026d6.8.1729880508088;
        Fri, 25 Oct 2024 11:21:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOieIrabKwACHOCPSD2dHV1t3BbZrjgf26iovU0+nwuQEpZiSR3ox0ODrmXmVGXSrDrY9V1Q==
X-Received: by 2002:a05:6214:21e3:b0:6cb:f5d6:3f9d with SMTP id 6a1803df08f44-6d18584a56cmr2411886d6.8.1729880507776;
        Fri, 25 Oct 2024 11:21:47 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm857671a12.21.2024.10.25.11.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:21:47 -0700 (PDT)
Message-ID: <d3431f6c-4fcf-4a8f-a33c-ac7e2994c6d9@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:21:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e78100-t14s: add sound support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20241025153901.156891-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241025153901.156891-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: harMY29ebTHWAdktBpGxed0p8oztJgIX
X-Proofpoint-GUID: harMY29ebTHWAdktBpGxed0p8oztJgIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=954
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250140

On 25.10.2024 5:39 PM, Krzysztof Kozlowski wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Add support for audio on Lenovo T14s laptop, coming with two speakers,
> audio jack and two digital microphones.
> 
> This is very early work, not yet complete:
> 1. 2x speakers: work OK.
> 2. 2x digital microphones: work OK.
> 3. Headset (audio jack) recording: does not work.

Very weird, works for me on SL7 (also with 2 speakers). Does it work on
Windows?

[...]
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
> index d078c76c6da5..7bc3756803d2 100644
> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
> @@ -19,6 +19,32 @@ / {
>  	compatible = "lenovo,thinkpad-t14s", "qcom,x1e78100", "qcom,x1e80100";
>  	chassis-type = "laptop";
>  
> +	wcd938x: audio-codec {
> +		compatible = "qcom,wcd9385-codec";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wcd_default>;

flip

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

