Return-Path: <linux-kernel+bounces-433818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA539E5D7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3A0167364
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C651022579D;
	Thu,  5 Dec 2024 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YGBKQq3i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9377224AEA
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420497; cv=none; b=BvW+pL/X4g6t+jVVPPdisGskt2w8mzfi7qE3upJVvUgdmk3jkC/HLo9lBHK2TWk78TzI0xgWBrtCejonV6l39VDr2cxnow8m/OaGbQdmhFPCwm/Qe0TlAi7Jp1FrV6Iv2gSAHS9cOVveUrH7zJgjhDrWr+qngmF1qz3jF/EdhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420497; c=relaxed/simple;
	bh=6FzNAE6m2dYGEz1uwmeGhq25mZHNGBGIpgBDnJuHusc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDL9p7R5J7CjyES6pzW8dIn49eNscW+lRYX+aN85Yu+zviWkREdAIn0iEl/l2mz9JNd4SFneb0nGQy5IyqK2D0sDsPeTx246UQqqnxKdSam7EUpZO9mx2BN4b8BME4PDGEB8CObJ/2tqMc310Mivb6XKe8cg0ZkL47B4JeQUTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YGBKQq3i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HaFcS003715
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 17:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SXzRRGsyc/c2BUi8PcPVnuNR/0fJO0GE8qnSNFeaoZc=; b=YGBKQq3ixqo2vJNe
	8jq1scLTuRD8CCWNa/HeKAiG7hb72nhoipa+Ejo8ai9knqUZmlCAs+hbP7VesZea
	gMc1WUN64LZjb/ifCCZpw5hw8ryfR6kPaoqB8a4qYDPQZhkvlohZY6ZESTH22TA8
	knDKsigj7GsqigXLaiEpQorq9CKoRSSajiEKARohZpc7hbqy1RoqUlZhQscIeXpR
	clMa7Ylb4sSyRq8cAdNthFWhrITs1aqtKe+rApPMFV+GTRAld3bvBL67OWqfQ0Ah
	pJhBPw17seOWdYuwxb9wFUeH5mA9mM9pzh4zhgvyY3eEw2L3E5SLnCKxFgHnNUCz
	SxOUFg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ba0kh980-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 17:41:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4667cab5e1bso2960691cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733420493; x=1734025293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXzRRGsyc/c2BUi8PcPVnuNR/0fJO0GE8qnSNFeaoZc=;
        b=veJot+6LxCw5R/g0Yb0P4hskoJnbQMOptCwZXjOZQ9jfF9rWLUS+pxxHDt32/5wakA
         UOUM9Q/k+mWHv5rC4cxBNakQozCXLK6x78w50Mk9oXLdGjbJmxbflYyOwE4F8UHznvOE
         kbtdScJNQDbkLJ72gtE7HKbURHU3SRJpET88Td01RhgmjjDD/6pX+GkgnPcJ+C9SBxcF
         bBODn++IREUO/eoumzejBa8j/mErkbrENSNRyh4diUlfxknsRQJkCCQneGpD1U/c3FR4
         paPg1HVMFIM9atnRD6KxKnHmMlHCwGz2Ac42M2h2iMFKYrTewpqZAF3lsz9agvDsi88T
         b+AA==
X-Forwarded-Encrypted: i=1; AJvYcCXlaiNmPvmIqS8fxSqhAU5SpJGqTCKGzUUf2WCAC0FwpmeEs5kkIaT66Ecx4KKyYIa3LABNBF8GEAAAQDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxR/bh7gdKqbIcd6Q25Rb8p1/oDmENfVhJjGj4j7fiuJXD7p2o
	UN1zxbkbkKInvTd4tuGek5cNkL7F+dQD6OX4KAIL8Va+T8zfwvQ8fwT9lG4cEWgzuVJ/Sbh8Gzb
	bImpZHsKuhwkzwPVSCRmFBCsNHWJyJJIMsYzCMitFQF4qmxthmhnjmKprE8pJO9c=
X-Gm-Gg: ASbGncvpjQMR6j7gY7EKQWr2tzHDK50A0bKaZyvHmrt+BCcDFYTEGEH/46BiXtc6rVH
	u6hXM2PfwU9cqLzLqcH94qFIRNiEzAVJNeP5a4juTmZ1VX7Zaq9F6ekdyoyihnrsOTBxdpv1lcr
	eG26GLnOpb37oEIxFuyj4gpESlrTFIj2xq6QenJdYcTgr0/YH4T7z6iYOotJFDuLNDzsPqXk+uD
	F7UuBTeG9AkqvZCsv/JBbzd4wO813E3knmN3fC+f8xC61otp9h2RN2n5yGQYDexUOoPM2Gwmbbr
	+xQYaa3QEXzs/bgM9r1YiCZ37C2Mzvg=
X-Received: by 2002:a05:622a:1b0f:b0:460:e4e3:457 with SMTP id d75a77b69052e-46734eeed1emr69511cf.11.1733420493599;
        Thu, 05 Dec 2024 09:41:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4nDHz+0THtItB3ZVRkcOhOY37nBmuqywfPU8W/DhGboRjz3vQnXgf1jXoqkNHIizg2v5WdQ==
X-Received: by 2002:a05:622a:1b0f:b0:460:e4e3:457 with SMTP id d75a77b69052e-46734eeed1emr69151cf.11.1733420493160;
        Thu, 05 Dec 2024 09:41:33 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260ebaefsm119579666b.197.2024.12.05.09.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:41:32 -0800 (PST)
Message-ID: <bccb09b9-e139-439f-9a1d-2d17265edee6@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 18:41:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: qcs8300: enable pcie1 for
 qcs8300 platform
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com,
        lpieralisi@kernel.org, quic_qianyu@quicinc.com, conor+dt@kernel.org,
        neil.armstrong@linaro.org, andersson@kernel.org,
        konradybcio@kernel.org
Cc: quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20241128081056.1361739-1-quic_ziyuzhan@quicinc.com>
 <20241128081056.1361739-9-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241128081056.1361739-9-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: O6s2OaxyqXCb2F5KpIr_a9qvUlweu77h
X-Proofpoint-GUID: O6s2OaxyqXCb2F5KpIr_a9qvUlweu77h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=884 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050130

On 28.11.2024 9:10 AM, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe1, board related gpios,
> PMIC regulators, etc.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 42 ++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> index 7f97f771c44a..a83faba0252e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -214,7 +214,7 @@ &gcc {
>  	clocks = <&rpmhcc RPMH_CXO_CLK>,
>  		 <&sleep_clk>,
>  		 <&pcie0_phy>,
> -		 <0>,
> +		 <&pcie1_phy>,
>  		 <0>,
>  		 <0>,
>  		 <0>,

This should be in the previous patch

Otherwise lgtm

Konrad

