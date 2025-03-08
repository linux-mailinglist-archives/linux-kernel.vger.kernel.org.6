Return-Path: <linux-kernel+bounces-552671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F12EA57CA8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B691892FAA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D41B0434;
	Sat,  8 Mar 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yi+fIxYa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9B1E8330
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741457714; cv=none; b=t/AzqAo5pqROIRQbczG4zJYqtF1aHLUIrAt96DwRuz9gqvdYrZG+H4BquQbCGIPbSRo3ncyUebm6Vq2joo7w5nxIsdiTPtkEcykIMVgK0HceKJ40rkVRj1JoTkVY283/NQICE9Yz+g3HfQm3l80jKj7xWgCZAZ8QhdSAajIS1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741457714; c=relaxed/simple;
	bh=YasUI7eo6rzu0KP0RdsLeKIWeZp+g4SwWBK7Bb3jdzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4eXhVcasFeDlNZoPbj8GnYgR12gfTn/mORf9uPCKmp8Lag7CaP2QrpCbzCB2xqrao2u6ZmaWlg7zLNZX7hjIU/cTZ82oQkJzXlVEWNF8Jh7M0T2EAjuyJeeGIsQWupY0JSiOPneKvXX5TFr8UhPervvM36WLG7T1dXZoK4XJl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yi+fIxYa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528Gwkjj022694
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 18:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zP0cIH8IXd4ECeHaQ2piBoXegEjDr1q+VWstaDqq8zw=; b=Yi+fIxYaEXprQGgG
	VN/UyU+lK3tVBENdNAJK+J4fNsjWi7F4FW05IsDTh/cKDibBghzOnxnk3z9tjMrf
	6pYaKg77D1X3fU3wNbxYj/q4ZfQvsnB0RRxfD6RDjytqksYEUN90UrvAmo/XX5u2
	UW2UNSxZxe8Bpj8Egk8JWioBzbs+lwZOLISG0M7GVsU+6IWgXuUsqwR01EbUImcC
	HfOjTqEHRVPNfaHMYQ2OzRY383DAV3p6HWCRctN9XVKplXyP0W5U13Lipe/PofzJ
	r/7zmDzlfBPzPcJeEj/eD1IqFYJNOUx19aMb6NMw+FiNDsuIKnuaYjCnwAaDZoUX
	oRSdgQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyt0xu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 18:15:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4766ce9a08cso569801cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 10:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741457710; x=1742062510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zP0cIH8IXd4ECeHaQ2piBoXegEjDr1q+VWstaDqq8zw=;
        b=vQ1ekMS99/IAT5L+TiZxRpOnW/5uwuF0jo0QQmS8r95prZXxwYNfcz3mAJJ6YRwNng
         drOGjXKTehyedeCH5QT6fSh33NB54q2Ng9mSEGph87GPZ9KZSmGfQiqtGkHeNmDBkrlT
         qD2LuxdSWh7L88Ej/28Gg3y/tBBVgWq9j3uTL+BRNr6TZT9Aq9F48xmYBsd6iAe5fgVw
         qpP4pyg2s3Lpq0PDMwnXFjFw817/y9MzcSZ9OHLB9RWRqQZ1zesrtsGFQGfmtykopDRG
         7kEOWMSxn8EK6XZuy1cb0WTSY1q6rs8jGnqiU06cNRboS42SyO7u5JMo/TkNr6oHhebH
         vcXA==
X-Forwarded-Encrypted: i=1; AJvYcCVeO324lKUoq3w8boXzg89Xevh/dR/biVZmOkdRlHKL84XXUQpXhJ4kc3CWlzjsYqC+j6NjskRhF9ZLv/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDJmQyQ13kWQsRdtk3ltT6OHAi4170SkuVEbCmxXLU6ozkN+6
	4RXqZAe44AQCcaMY/REiNIWZi6TtWOv0D6b5riwQgNeGMjfeYKo7oU2vZ52zYJMdZ/pcHm9Bq89
	dDAruKOVgc9WyfjjuZ6PziE0wJ3FocV5+h2P307ZdLE8Jaep0Bpix91ZLD2e/nKQ=
X-Gm-Gg: ASbGnctxi4ULFb09i8cqTOYLyVAhcUAH1xXXNDXio5szky/A8Lvf3J8e3ahbAurlimk
	MLGGZMaA2YdSHXpqlek4HC9MOx102zKAuxprjQWW5K3Nl793PCw2FqfEHsREjgBVrftwJJ1J+w5
	6sgyHZZ3X3XoC9GSmu67TUM9jz9/V3OXikDljLYBx/RwluT9iHi6sWZTk5gk6C//Gz9cueD3WOX
	4C5rdbQ81bhvMh2v37FmmpGLAvizJGT5bajOiantqAWWxJM5uPZVypIYi8hn4gTvHAF/jBzwXj3
	S2RfbmxeRWz2/kdUqEpxD3B71Go0mLFM93BynkvcvNR42r5YoE7efljRUP+tHuIAlmn4OQ==
X-Received: by 2002:a05:620a:1d03:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7c53e065222mr230801085a.6.1741457710417;
        Sat, 08 Mar 2025 10:15:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGne6xG5DU1bp+SuDI9vkw910TDxmiQikAQdubeuCx8ETOWW5ViWZDdFGXPUz6RsEI6/1CkEg==
X-Received: by 2002:a05:620a:1d03:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7c53e065222mr230798285a.6.1741457709923;
        Sat, 08 Mar 2025 10:15:09 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac287653e64sm30659166b.136.2025.03.08.10.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 10:15:09 -0800 (PST)
Message-ID: <d2640b21-41f7-4bb4-a616-42b6bd9cab0b@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 19:15:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: sm8750: Add BWMONs
To: Melody Olvera <quic_molvera@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>
References: <20250304-sm8750_bwmon_master-v3-1-01a5cb330dd9@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250304-sm8750_bwmon_master-v3-1-01a5cb330dd9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oyX54Y5svaOcuX3DPmfh70DuR8-tDAjT
X-Authority-Analysis: v=2.4 cv=CupFcm4D c=1 sm=1 tr=0 ts=67cc892f cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KFxGp1uTjiazv6v418gA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: oyX54Y5svaOcuX3DPmfh70DuR8-tDAjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080140

On 5.03.2025 1:33 AM, Melody Olvera wrote:
> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> 
> Add the CPU BWMONs for SM8750 SoCs.
> 
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
> Changes in v3:
> - Change cluster 1 destination interconnect to tag active only from tag
>   always
> - Link to v2: https://lore.kernel.org/r/20250304-sm8750_bwmon_master-v2-1-ead16909397d@quicinc.com
> 
> Changes in v2:
> - Change destination interconnect to tag active only from tag always
> - Link to v1: https://lore.kernel.org/r/20250113-sm8750_bwmon_master-v1-0-f082da3a3308@quicinc.com
> ---

This looks good, but I found that this platform may require some more
changes for bwmon, we're investigating that

Konrad

