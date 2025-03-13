Return-Path: <linux-kernel+bounces-559727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E69A5F8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9493B17CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C030268C76;
	Thu, 13 Mar 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LOnlQYMV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552982686AE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876611; cv=none; b=FTA02lkHs3WtcJ+xF/Mtr6Zx7Rk+IpQy3pA1101W39icbiNgNf8F2NjITUqM2RPftOPN2fFXZ6509rNV/djgRrnJwrnZABVXTbWHEnWzk3r+NfWeWaQdLPsZUSaZxQBD77vhGDZkHSe93Y5B8yOfi1siHK57X6nfhNcBaLNL0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876611; c=relaxed/simple;
	bh=fcmjexBjqgsbpWuTt8xiQDxio5fQOv40sLnyz2huYyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Olt7G+tP9EorF4fdA4Yd9CD/dn11DzVyCE+dzE4zbFMNHg2SQIizbDuqBePqzLk/JvdZkmLfp/qz9GMRRREm3wDsTPY0mdP8QjBzl6rG/R5OWN9WstOxawS8QhD+vM+WG8y/UquhBWQhKpCwIB9qR0ib7qkbto4nzmNc4SZ56Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LOnlQYMV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DA8eIZ027346
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iayw8L6OX7w5xqy3B7BuifNHp7uwUgTuMGxBekIniRE=; b=LOnlQYMVTahsWjbi
	rVEBFc9qK85ziMo4ChS2xBAlNqXqTBl5SIq81UVC5F66SQg5JmNIWTnQjoFng3gM
	ZGetDtXF4zhKhU/qLbxZIiXV8LU0BDGnpJOsSQ+8W+sZJD1rcklDgPf78nMAJW8Z
	/3UO5ZbbFkCVyqFxiqySACe5RYe1ovHCrzQahNL8qFtvHepAPrgqukq6RdfoZxaF
	9cAf2yZGbbYOvvLySXY0NYZ99kSvh2IwsE99yuhHkN1pREtDxwb1/PHxngxIGCDS
	/p8KyrfW4f007ltqzS49AN4WgakqOpF6vGhlLL+r8q2KUC4N5s3ZmmlmornetAVh
	/FbpEw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2px5v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:36:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8fec7ab4dso2814096d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876608; x=1742481408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iayw8L6OX7w5xqy3B7BuifNHp7uwUgTuMGxBekIniRE=;
        b=BMdpLE3TzHFmf1mWTq3+oEi1nvVULDGj/9p1XGDQG6zLL09FNT5BI4AhJGxsd6EV40
         0izLGaGl8EoBe0SAR5d8VEL8EWYuhiXKtc7ouIeaYUHtL99RsPRF71Bf22f/ngu8/mO+
         TCm7af0hUk2MYaQnbWQ8VNODVjgLFvlzbe7CrNwNPngR56fU8aCm1bbm4FDFCO766vN2
         o7vpz5emMtjicsJzNIMmNXzHWGFY78brMrKVFm16J3zuEB2GMuoujRct6SUYDKLleBAd
         5U+7c1wGbV8Y1q/ZMgihT70FEBdpgPzwECcycZPGGQ4/tGAbTQJmQnR5IDJuB+2/7jV1
         +QtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9hetz1DMOJJTsu9st0Bpls/AZDOidsod4Pg6NMvG+/ZIj6lglZsaz+DRuL0dnzRs2LL0iSTib1uG8yTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwndZPrMJ/yIEGEW2tu0Gg8IqaQNjHRM7LNgB8/VZVgfi3eD+0X
	gF/eOKH9JxMB88mPW9Mv4wC2wbtjU0rKqOOj59Rsa0oG+hWVKKtpI5iNqb0Ar7j6tQD5+WTjAon
	4v5fJi1mNNFrxORchWMSYFj2Iw+GaZbvGb/3agI+dGjhV4Udx2WFqxQNOtAYlXzeUpYETiEM=
X-Gm-Gg: ASbGnct9crXfFwsOmZ6ZFI/0K+NspXWabYIwWKg9JzVgpJxMAXHi0kvy8mLHa0uVCdm
	2yB3H4rn8VcQErw5CQG01SDgXMXznS+ic/VzZnf/Bzu4c2qawDNACoVqcjON8kfnXcxDh04zqrQ
	cm0u34yjD+BziYKjw80bvCPtIioMaMBEqd2HrrgG6A9tntpsRzY1Ao007Qr1wKDPMd1tP6/M6Ww
	WWTDsJS37mFNLwM6HP5d97ugBaKPy6+GNiNvLb+JDAELadNwk4MXAeQyGSHwTfvBlLV6M4xb1fC
	60Wu5C4YIx6Ch/89p1AzG+Yl20fH3AVdrUNs1CVkhg0Khb3iPIA7eLm8oQ6ZdR/dJ3gacg==
X-Received: by 2002:ad4:5c6e:0:b0:6e6:5cad:5ce8 with SMTP id 6a1803df08f44-6e908d5cd3fmr118537716d6.6.1741876607910;
        Thu, 13 Mar 2025 07:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtErHMVXuVhR9/1k6bEnfgqC6qn9DQ6fe884e1yhVTkqGYcXJ5LojlhftI2iNuNv3u6p6Rwg==
X-Received: by 2002:ad4:5c6e:0:b0:6e6:5cad:5ce8 with SMTP id 6a1803df08f44-6e908d5cd3fmr118537536d6.6.1741876607455;
        Thu, 13 Mar 2025 07:36:47 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0df9sm87916766b.99.2025.03.13.07.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 07:36:46 -0700 (PDT)
Message-ID: <2fb1ddf6-0fca-4bf6-9970-728448f893d2@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 15:36:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ARM: dts: qcom: sdx75: Add QPIC NAND support
To: Kaushal Kumar <quic_kaushalk@quicinc.com>, vkoul@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, andersson@kernel.org,
        konradybcio@kernel.org, agross@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
 <20250313130918.4238-5-quic_kaushalk@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250313130918.4238-5-quic_kaushalk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d2ed81 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=ncw13XDXEW9X0_jSTFUA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: BSmO7CQPjTADJ1aAz1h6U2pQo6G8vLHI
X-Proofpoint-ORIG-GUID: BSmO7CQPjTADJ1aAz1h6U2pQo6G8vLHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=845 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130114

On 3/13/25 2:09 PM, Kaushal Kumar wrote:
> Add devicetree node to enable support for QPIC
> NAND controller on Qualcomm SDX75 platform.
> Since there is no "aon" clock in SDX75, a dummy
> clock is provided.

Alter the bindings not to require it then, instead

[...]

>  
> +		qpic_nand: nand-controller@1cc8000 {
> +			compatible = "qcom,sdx75-nand", "qcom,sdx55-nand";
> +			reg = <0x0 0x01cc8000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&rpmhcc RPMH_QPIC_CLK>,
> +				 <&nand_clk_dummy>;
> +			clock-names = "core", "aon";
> +
> +			dmas = <&qpic_bam 0>,
> +			       <&qpic_bam 1>,
> +			       <&qpic_bam 2>;
> +			dma-names = "tx", "rx", "cmd";

Please make dma-names a vertical list, just like dmas

Konrad

