Return-Path: <linux-kernel+bounces-409511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0518C9C8DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2E01F24641
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E28166F25;
	Thu, 14 Nov 2024 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dBpPpixa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14014F136
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597726; cv=none; b=OGnAj4OOjpyvdGyMJ8pLTWDc5fLzcOmWQO07gxiuhisjalCxa5emVIfjL1vJaUPk/ff1nPyfduw6ZKj9gpKfexhksCJRRNZkttW0eor4Bnwpd6pXYEb+WhfG1gb1XcICldJIuVcuJlOwmVfYsNSh5/3ltGCqwxuEFnY4TK1FQks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597726; c=relaxed/simple;
	bh=VOeL1LHJj4CvlcHfJAl3EqutCbGarb1Yfp1+RrNPg2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVbdHlHASaJQysI30cf6wfcAdFukWPvA73pJvuML/j7/adyVJbutYbBUXKHco1/eP/5vq6Qx2uqMbe1zHEDJ3tX6IQAiS6vGF2FBZEe/PGuRcdZLHwkSuW/L9y3gRhIXIZXuWJVX3U3EHsfU6jrxYPF1IxwbjMI7KacoXhbs6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dBpPpixa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEE8lmF014879
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YxIxF5hLq4iWtxlLGn/AClHN0cke6/bTjCz83ShCJhM=; b=dBpPpixaORjHXdne
	FhM/5LByOOD48ay/NrzQnuZz1NTmI9HXNMn9QQRbQlmGvyRvJsDmhXvLM6g8RBFm
	PIWIpEo3Xm10Rq/jKOM+Mgiio+6p9iZ+GY9/TSCGy9fGzYJs096Mj4g0Ec/AxJkm
	4gcdwXUZlxbd5RyXbZOncclyHwBdee9x+UpidfyPLayRoIUqUcaYo7/Sbx3zJhpH
	SdXVpRvkNZkETLHuol1dl3GAtcL6ZOrhOdqqb+4OHbwCzwryIXDYxMrQN6UjfMw8
	Zzw1qu8LteVxfjDtNBUKTfETax3KNZYzAG+O7CiF4qgEnEXTl3T5P1tikTfBQ+be
	rSChpw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wjqag5q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:22:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460f924d8bcso1313801cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731597723; x=1732202523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxIxF5hLq4iWtxlLGn/AClHN0cke6/bTjCz83ShCJhM=;
        b=m7+wOEB4yzo7j/YXeCRvKOXvKzIhdrb6jFd//dGtpVS1LFoKVG2tU2fNyURIqFWRTZ
         MSTBOZPHRLrA7UjM/xbDxBlXxRc294uDRw0LZmGviwbLSTTsjjlOjmKBompH1gfHQLig
         fRVXgmxckAAPJZezQa5Ji+CJ0ISHjvLNzQf/C4BmQRukEFYzPZaqJ+WqWIBGRCflp4Vu
         iMfLx0s1O/r55istFysA7yX+HuhVSfIXLh9RqqXiDFMDYwqMxDdCftR79UaUB7hNI6K6
         PlKjBPTElVOxlSjHNmc42bXoiRAaDk7lw3iaeA6f3GrneOzrkYdHg0q04maxVMc1b0bt
         ir2g==
X-Forwarded-Encrypted: i=1; AJvYcCXv8ELTaAjoTOsL9C8dP2gZeV1kNKLO1YEESrM6kWktLsNg9k21iayROSJNuXBhPcS29Anl4mvgek7FxiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz29XT+LKF9X/WmrL8Par8B+CJXSQTsY4qeb/2KOsG8fOAFLVsk
	r7ZkZZE+Z+6cB7+dv3jLo8Z/1K82kexmBzCTOXOj15IZkFL88eWMQ3FArEVP5oUFMqmSWzRGfzw
	JVCcDXR/GqSZrjhpi4wPunD52AGODY4g9a5cfjL4t58yL8uxRRYl1OfKD923hWcQ=
X-Gm-Gg: ASbGncscRF+5L4Orl6AZTItYjUtNdwe0k5SQJWVZSG+4QGCKPGNBDzbsk06TgOgldRS
	zqfxkDzk096qoFDZwWjVewFHsn15MgVM6/2dFcc/1dwDngSRG/EzRNqp9jfbVQCK96iK/vEFAwo
	ZKR+8Y8M3YpxhBv6FCcKBiKBVQ29cuyk1fA0aWG6VpakFwk0tHgYqnfPLhEsEeJC6Dx84qsX+ay
	1IUryFiPc5Ze2dpb0v3Ogj0zL77ydt0kmP0weJ6TP8RMwUhyNc1sJgfesJnfgjuLXJFMASHd8FJ
	IKg2STWuuM8AtKrJNo88C4GvJ+LQ098=
X-Received: by 2002:a05:622a:1183:b0:460:787f:f51f with SMTP id d75a77b69052e-4630941ab7fmr141068351cf.13.1731597723551;
        Thu, 14 Nov 2024 07:22:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9U14TALS4SGOL99dlTJ9kdKVasrprn7rCmbpPBy5qi53TR2NVmA6bM59U5xTlcuiHukHjsQ==
X-Received: by 2002:a05:622a:1183:b0:460:787f:f51f with SMTP id d75a77b69052e-4630941ab7fmr141068101cf.13.1731597723213;
        Thu, 14 Nov 2024 07:22:03 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e045385sm73577866b.144.2024.11.14.07.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:22:02 -0800 (PST)
Message-ID: <0344465e-89b9-4867-85fa-670060fa1761@oss.qualcomm.com>
Date: Thu, 14 Nov 2024 16:22:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs8300: add QCrypto nodes
To: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241113055830.2918347-1-quic_yrangana@quicinc.com>
 <20241113055830.2918347-3-quic_yrangana@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241113055830.2918347-3-quic_yrangana@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iUF6RV_ojEDo4aI5iXqarbNlwQu2igCA
X-Proofpoint-ORIG-GUID: iUF6RV_ojEDo4aI5iXqarbNlwQu2igCA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 mlxlogscore=909 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140120

On 13.11.2024 6:58 AM, Yuvaraj Ranganathan wrote:
> Add the QCE and Crypto BAM DMA nodes.
> 
> Signed-off-by: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index 2c35f96c3f28..d7007e175c15 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -710,6 +710,30 @@ ufs_mem_phy: phy@1d87000 {
>  			status = "disabled";
>  		};
>  
> +		cryptobam: dma-controller@1dc4000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0x0 0x01dc4000 0x0 0x28000>;
> +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;
> +			num-channels = <20>;
> +			qcom,num-ees = <4>;
> +			iommus = <&apps_smmu 0x480 0x00>,
> +				 <&apps_smmu 0x481 0x00>;
> +		};
> +
> +		crypto: crypto@1dfa000 {
> +			compatible = "qcom,qcs8300-qce", "qcom,qce";
> +			reg = <0x0 0x01dfa000 0x0 0x6000>;
> +			dmas = <&cryptobam 4>, <&cryptobam 5>;
> +			dma-names = "rx", "tx";
> +			iommus = <&apps_smmu 0x480 0x00>,
> +				 <&apps_smmu 0x481 0x00>;
> +			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE0 0 &mc_virt SLAVE_EBI1 0>;

QCOM_ICC_TAG_ALWAYS

Konrad

