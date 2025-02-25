Return-Path: <linux-kernel+bounces-531508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C083A4415D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D611896310
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4D26A0A5;
	Tue, 25 Feb 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CW4QPMex"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03D26A1BD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491564; cv=none; b=Gv5cz8+w4pLhUKPOCE3+89U6UWpe5ftIx2xaMxNQlYntKsvyqhFCPkzcg0FI+ux8mkeOiU6mLGXKFf+K1GiMp5hxxC53PCJfvw9pTzhxqRVJ5caajO5DXV+Oj/PGroJf0k2JExOZWUbjrKq2CHHoC4ZR1f2onwyKzVKQWDQOCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491564; c=relaxed/simple;
	bh=SG8DHOJCeuSEggx0B2RENp3Asd1fFAb7tSeGnSgTABc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQXP4Dx3WSazIfy7IjrGYNN2udp//pbPKZTQn+J31+SBFVaHPRqmJUcRrgkjqFUJQGIuW7pKbBtIdU8psZjrWu6tqEkW87UuBxehst97JAtRVyOZQS5vf/6nYIdU+1z96ebYgzFUaNnPE4uLbNnXiwg7hDKiaPJAbS3oEBKq0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CW4QPMex; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8KS0i001958
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pkYjMjlyL9qlFVDtlQSmo2wWruGUfEQTSoc87Y2iaD4=; b=CW4QPMexAWZvghEj
	3WTQxc9O/RPIZZWd24Z7nil+ysQswwuuWnSt0x2M90WkQB40r/kH6c3r32811qvZ
	AbKGEPwqBWdt0HPVTMTqdjRh2Gzu58zif7h6U2tDaFVlJ5j8JRTK8HupbDvUhWYB
	WjbdY4T3RCM0S+NdB3Lc/TaueuWuM5sERtdPnLLoQpVs8JXbA4jO3R+ZV6vHE+9w
	Tpewj+sh2SyBLUZRjMZwofd4VhLNjghvUe36FiXuxA5chZoJE4GzI+4ucrrRLwJa
	R9CwW/IsmfZak71eTCz8GonzQo/yB55hZP1xJsUhdf/gzonA784jCj6a4ZGNNou4
	Aa91fQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7rk0v47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:52:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e665343a70so10037936d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491560; x=1741096360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkYjMjlyL9qlFVDtlQSmo2wWruGUfEQTSoc87Y2iaD4=;
        b=OGQXj0hQRoS8LATTtZZCzXhvtckEgoXJ58bjEzT1MN2DTdwTXB9rUwfj4dAY3nJ4/f
         QC7DbqpSfbWMfxnupHxVUbfM80xZLIqeQl+DVz0Izk2qlL0D4+Y7SxmGmVbVlqRngseg
         EM/7IYlv/5YVfAsFlh7dJ4UkkGb6aJJD/za4FXAzolJbt3KyNCKiGc0lk96+CdI2PP/V
         H6o70lmODCXvpBzWQNXuAaWrttt5qct5vJgkZ1+BoUpzAxVT8DY7ar/eBrOpaMLCIkg9
         pFikNBMz05/JgRdUQRtTbxwdcr799bV7/iW3zq5LIpbCVa2q/UWmwubRrD4vCDsFRUXm
         ss2A==
X-Forwarded-Encrypted: i=1; AJvYcCUEoWGi6/Kjw7IGJHB+piErn6UfFBJS8FwYO2y8eMz1R6bqRLmQUyCxsGGSXhCiXjivmYdHRrjMSursTPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlIXIvcAY/kAzvBX17mZEKD27s60RNtbSBRNeRol/W+UxruiM
	ecKcjsu2vXHrdAy2L83+v+mnRgR67pdfeBSrp0QRrV3oM8q99V9V1CYeR9tkB49aC/SxfSzJjti
	FoqWbr3EcyR17lSitj5CQ1SJeEdrnhbJeYn6gcWO8oJJ495OP2c2+Vf6OJeiK4Rk=
X-Gm-Gg: ASbGncs29Z5LqTUJFkhOzAcaSRVXY0Ixdl68yo4ksK+Tu+TF0pAwWJTAlpfLYJibNF4
	CQKesx2ckbLfCUs92jEg/zI3x+y6KQnVXw1tM8fV9GmA6H8F4xfKHjVPj9LC8oCA+zN1ATNbT1j
	HwxgASH4v0RQUfndX5iBwv0DxV5eUZltk5MgLZ7qVpOR8WILE0s1E4XoftA/y234EImg9RVUvWY
	yqhuBY5PVJ2ecaA9USNIpHz2U7zra8i/eoFxnKqeqIM/JELMYtVRk2gcwRR4fHeJbu+SloYhGWD
	kFMAVUVklalUZNI5NhSCEC+nrsKQr6So8/5QhqiUwx18H6JpSuVhwzngEOb7/Ffy1tGgmQ==
X-Received: by 2002:ad4:594d:0:b0:6e6:5d69:ec2f with SMTP id 6a1803df08f44-6e6ae9d2e05mr76539496d6.8.1740491559827;
        Tue, 25 Feb 2025 05:52:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdG6abw6+5nJUhZinHf+B2SwaAbatR9WjVdL2aV+/rZoPV2zlBUW+WrC4fHzaGB/EILXLE/Q==
X-Received: by 2002:ad4:594d:0:b0:6e6:5d69:ec2f with SMTP id 6a1803df08f44-6e6ae9d2e05mr76539306d6.8.1740491559491;
        Tue, 25 Feb 2025 05:52:39 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b6cfbsm144913566b.175.2025.02.25.05.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:52:39 -0800 (PST)
Message-ID: <ac161039-af36-4e6c-90ea-ef858ea31e86@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 14:52:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs615: add QCrypto nodes
To: Abhinaba Rakshit <quic_arakshit@quicinc.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250224-enable-qce-for-qcs615-v1-0-e7c665347eef@quicinc.com>
 <20250224-enable-qce-for-qcs615-v1-2-e7c665347eef@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250224-enable-qce-for-qcs615-v1-2-e7c665347eef@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3RhAPAOAWSkdyRlf5IvgBJwW2pkQ-iof
X-Proofpoint-ORIG-GUID: 3RhAPAOAWSkdyRlf5IvgBJwW2pkQ-iof
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=977 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250095

On 24.02.2025 11:04 AM, Abhinaba Rakshit wrote:
> Add the QCE and Crypto BAM DMA nodes.
> 
> Signed-off-by: Abhinaba Rakshit <quic_arakshit@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index f4abfad474ea62dea13d05eb874530947e1e8d3e..25e98d20ec1d941f0b45cc3d94f298065c9a5566 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -1114,6 +1114,31 @@ ufs_mem_phy: phy@1d87000 {
>  			status = "disabled";
>  		};
>  
> +		cryptobam: dma-controller@1dc4000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0x0 0x01dc4000 0x0 0x24000>;
> +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;
> +			num-channels = <16>;
> +			qcom,num-ees = <4>;
> +			iommus = <&apps_smmu 0x0104 0x0011>,
> +				 <&apps_smmu 0x0114 0x0011>;

(0x0114 & ~ 0x0011) == (0x0104 & ~0x0011), try dropping the second entry
here and below and see if things still work

> +		};
> +
> +		crypto: crypto@1dfa000 {
> +			compatible = "qcom,qcs615-qce", "qcom,sm8150-qce", "qcom,qce";
> +			reg = <0x0 0x01dfa000 0x0 0x6000>;
> +			dmas = <&cryptobam 4>, <&cryptobam 5>;
> +			dma-names = "rx", "tx";
> +			iommus = <&apps_smmu 0x0104 0x0011>,
> +				 <&apps_smmu 0x0114 0x0011>;
> +			interconnects = <&aggre1_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
> +					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;

Please align the '&'s

Konrad

