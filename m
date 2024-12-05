Return-Path: <linux-kernel+bounces-434011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAFA9E6020
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E53B16645B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E641CCEED;
	Thu,  5 Dec 2024 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iHr2z5Hd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE01ADFF8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434249; cv=none; b=CS7lAr7t0ZkSpLd94Ys79M4vAZvM5Fv6JkF5XP07q5/r3weBKC8XNDDScxAZ9CXvzfMHnwb+vjpyHH5ZWWJNksJ3ifYl+7IVnGyOoi5oGjnKviKj3b3UWWUAOTz5+cwutUQrOKvAH9uvwYAG07BnU7u/K5LNNnmZPbFFG+z8jKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434249; c=relaxed/simple;
	bh=Dk1ZS+GRTSpcu51g1k28hBgaIdDpbhkym/Q7g2lSf9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKh/1Apiv3bmvJ1nxMED8NzdPhVhvsLqg6t6rYOWRbm2Qz8pVOno3QM7nPth11yj4PkEbg1jGJZZ7qSUzOk/PI+vBd1HmLiGSx2FeIC1Ugj6cjinLIzBluUXLu/W6iAyQHuij7X6L+1dJzNvjzR6FkeRscAY8eUpQLbVIqKl/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iHr2z5Hd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HaJ3O003759
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 21:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nd0u8LVE49Zsjorynlz+VwADLKhOL7qlzALMovLJgII=; b=iHr2z5HdE2me8fgm
	TL6ycqT1czvB6Pg9shfhkMjiCLVf9dJqf4r56C0k5t8c/OMoIDaz8brl7wxiqg9o
	x9FLVphPQThNWibpvizaYEBNQ86yfWXIp/TxfwIg9s5ZGWOpAQqv6aAuonwYos8W
	eP6HmLb2+G+EhaNgPXTFpcSlN1cXUyF+PD1GtM2I2hxzruPIsrSUa7oxV7z+UHhi
	U7Jm4npZGOErxL+j7tBWZTIKha68iJonJ5Sgg1eGHlkh4IBeaKBQFPgLFzVTTogm
	ROkwBugG1AUTAr8gXpGPOi6i/S2VCNbzYKKYGLjgOvb7frbeGCHEe56X1Tb0nfDo
	61ykcA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ba0khsdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 21:30:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d3b1d1d8c1so3198276d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 13:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434245; x=1734039045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nd0u8LVE49Zsjorynlz+VwADLKhOL7qlzALMovLJgII=;
        b=ApPJgKd7IpAunLHLo/swCImH6holoGseH0aY8Fm8d6+rgJ9TR8NRUUDIriPBW+sCM6
         OLMQ+oUBgozeZ+zH+VPRSz2jKXv+T9nSV0RHNgKeyGuuqFDzksmafqXFQ+QQYURSxhGH
         AiSrteSNWtgkVzPDhryWUGuZYt6rNbSLeUHl/c3Yv4wplt8/8oYyk18HWA/RboEUxbHz
         qNc/N4SkVLi87TZWUQ8NhjzZ4ZVaCJBVnfx/Si9YSX2MHX+7hby4NmDLYHtXA+cjYcQw
         8okONrHj6y9rZa2MHQ/9l9iubUiNRW2gf0YTQu7qsR6zeXcVOyYfwLXHiQywhHv0clK6
         JKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjoH7Idy/SFZGDOoNWCORU9LQNhML6yEXpkYCLhTj0gvIabWhBE4g6qN196EcFprPoeVFvTFPjbHxQDHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv8rsE2xZa81wuAkqoApbE3OTqXHmono1hmYqjy4sfwherV3v2
	vXlCDqfNCPm3yRYw04ThVc48UNh1NGoquOGMWiks1qKRMY2/UVzTgzSvSfGgXsZr+OEFcnuM9l8
	OAYCLN4RiebFRfXSVpyJ4eSWRfZDYAxhJHb9Hu8KPUAWAVC6rDCanSIhggBE+t54=
X-Gm-Gg: ASbGncsRHfwuk5OARrWtFNrRkbI2nt/g1ifR2PPaLfb8bAFVV6otaiNLBNkl/oNVC0F
	eUQeI0Qv0eGCZ3V/SAxARzolOi2ebTUH1/g6MJgJHwzCO+JfgOTyEZIsR3sx4WS2YIESbb+i81k
	BkBp4sqKtrCXZER9eXkxHUYy+1GUAJzZJrRgR1gEyyxGIHiQ00Tac22qCSOal0v5e+S1X1d3Ro3
	BkCLRXNq99DwNAU7TkN6NqRm2YVKTJ3Eop7ZH8d7Kx75dga6AmXVpeXk7Xpo2yguVxvAIL7G+Ow
	XAd1N6Ai3Rx+h8vs/xaJ7IW1w1X2UzU=
X-Received: by 2002:a05:620a:462b:b0:7a9:c0f2:75fc with SMTP id af79cd13be357-7b6bcb4e3fdmr48657585a.12.1733434245243;
        Thu, 05 Dec 2024 13:30:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxeKWkaQPCpadeF0rPd3t9rOnnOYAGLyEXBvPD4ZBjOIHDTBFU6PJHKs5xFnhBgeH5nnsgHQ==
X-Received: by 2002:a05:620a:462b:b0:7a9:c0f2:75fc with SMTP id af79cd13be357-7b6bcb4e3fdmr48655585a.12.1733434244915;
        Thu, 05 Dec 2024 13:30:44 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dc8asm143185966b.35.2024.12.05.13.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 13:30:44 -0800 (PST)
Message-ID: <af0f6e79-cc98-4f95-91df-b940b5471149@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 22:30:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: qcs8300: add the first 2.5G
 ethernet
To: Yijie Yang <quic_yijiyang@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20241123-dts_qcs8300-v4-0-b10b8ac634a9@quicinc.com>
 <20241123-dts_qcs8300-v4-1-b10b8ac634a9@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241123-dts_qcs8300-v4-1-b10b8ac634a9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oBWIH5QKFCv7X9VET9QlYHiVf7x-Ejy7
X-Proofpoint-GUID: oBWIH5QKFCv7X9VET9QlYHiVf7x-Ejy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050159

On 23.11.2024 9:51 AM, Yijie Yang wrote:
> Add the node for the first ethernet interface on qcs8300 platform.
> Add the internal SGMII/SerDes PHY node as well.
> 
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 43 +++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index 2c35f96c3f289d5e2e57e0e30ef5e17cd1286188..718c2756400be884bd28a63c1eac5e8efe1c932d 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -772,6 +772,15 @@ lpass_ag_noc: interconnect@3c40000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		serdes0: phy@8909000 {
> +			compatible = "qcom,qcs8300-dwmac-sgmii-phy", "qcom,sa8775p-dwmac-sgmii-phy";
> +			reg = <0x0 0x8909000 0x0 0xe10>;

Nit: we pad address parts to 8 hex digits with leading zeroes, maybe
Bjorn could fix this up while applying

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

