Return-Path: <linux-kernel+bounces-526477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FED4A3FF2E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435B3424EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDC4252903;
	Fri, 21 Feb 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HpvcA3GX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462892512C9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164373; cv=none; b=TFYSWW2/B2IDPNdSTWiez0w/a38TOef/VVRHRHOW9f3xyUbArGCXE1BImFm1gVTaCGkLem0VhWSdsjpiw7s/zm95o94wXbb2gd7p7+QM4qJYwnpWQZbNtdYN/th4uYsVFSEpe5urL2woiqy1Yg4G4kwTZa2JdyUEC1hwaeD/yx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164373; c=relaxed/simple;
	bh=bouC5Nwy+RlowlXK/60T7WNMCMlxshS9jSXH6cFWoVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGL7Yd27TKsnzx3HNWEwnMIgr7drp1RSbbH1hTpYCl87jFKV9YT8PgqdKLAnu8ik2CbsndbpF2i/goBb4/j+fD3ckRhrNdyCQDSqKWe/0QaBXTEV9N8GOAlAQwtzy2+4s3kZWRdE1nK5TBkBcMlNqIp5xVz9PSOGpZQ1tOatPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HpvcA3GX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LFMqfC020007
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bpYhuaG6BS0WUe/aUEKyw24PzywfV0tSN+SL5OU5B18=; b=HpvcA3GXXclkqdjY
	7Yba8FNhybRyClMZBkXj1Y6Za2X1iUByzE0y40tV2Gy1NOojFf6df0h1ec3WZGHt
	LohPp+S4pPBnvxiXxLBM41AovKgBjq35QSlr61XgjTs1QemuXXehIdCmruTMwZna
	z5tlkH4rp1fD0jedbTQH4D76OOhJ/9/tFdWYyL9trnjdu7YAB10+iM7LX7Gk06FC
	521sEDgVktEkFI/RpZ3QyuHpA5ueS2c5SBe/5djSD9D4Wj2DR2lLZ3QeXW7BCEiv
	teI6vpSIQVkK+OiDEZ5GGE7SwxuNesQjoosiILIAPKSiPQWwFZY2909SuhmK0pIb
	UP4SVg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44x06t5mxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:59:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e66c7e5348so2654076d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164369; x=1740769169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpYhuaG6BS0WUe/aUEKyw24PzywfV0tSN+SL5OU5B18=;
        b=v1DBj7ewmcgMreVikQ7R81ZBhBx33rpCkcCilq1rGlNBOA/7rvLw50e5YYF5JV90Pp
         VZ68e03rPhCuEAra1xU1H+IjhRakFWfT2qDC2tlZOG3RuBQ1gfERbARnRgQw1QVmUWxK
         cdLjs3OK3uSrqvVmI942WMOBBlnyfphUYflwxlf86jR0E5j7vMFRR7jjFIga2JxG+xKJ
         +8OzbfaPClYchqWOjZEEasOQPwiGMllLQ8RNxjSfjUxBASnn5bcwqtn0Z2//tO2xZx+Z
         V62g9yQEKplY24GksEiTTP1GV1vbrEhPJNuwR2PD3Mqzqo5Sa4E01+zmsmi4OH4ksxhg
         hAcw==
X-Forwarded-Encrypted: i=1; AJvYcCUcswG5z8LzrXIAZ5G84wcUZypP9jEN1KCFxTWdSLECMs5LhhwZBtg8Y3G8q3aZeOvWExg8YE8U3OZh/pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRyV3wCbtgSwCunmoA4QZzJXnt9UMTK2RVsBrVXDgAOCAKKGK
	QP2Gl/Y1FxTqfaLbk9cSiPJTxqA6J2IhIBPZ1ksG13FGmshd0HBAbVUC/m0R7ixYkDPzxHX1dRm
	Qw1Alf8/qRx+O1mLIlGX+o4EqE5y0BOEgl3P+FWS3nWXaedbGXOZbcXAvIqC0U+s=
X-Gm-Gg: ASbGncsVNufqe/YkFClQUz9mvtMo9NDCDZ9DlU9PqBYqaFlZRPGumN5u9sC8+/EcB3s
	XLNmgyrJ/oMCW5tmucEF6pOB85ONG20vtSqEFoVK+5Cel0cEBYo9iaMlHoakSKWqtS1gpEgFAiI
	FpIHexnjNkG2BmALP842L4KwMpL+oJpzha2HSlzA6A8mGMcfx7qL3nN3C3GNLNqddtUlIx7mfJ6
	s44xhDa0Q597te1XjibBFX82CoaLPsS53ECYX+YFnV17KWu5UloI6zuVgVoi+YcqYL/dHYhPPFU
	sWyEb7MAL8fPZwtCT4ltBOa8Pizm65lPdZHjPjrA1iJOOiEkHcysRmQc1b0XFkL+VjkWiw==
X-Received: by 2002:ad4:5b8d:0:b0:6e6:60f6:56db with SMTP id 6a1803df08f44-6e6ae96757cmr21396566d6.6.1740164369146;
        Fri, 21 Feb 2025 10:59:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEino11aOry+X9myvSrTFE6WwjQqF5PQC/bw4hFvpDYxqJCcY8oQkdzhaYDT3qBz8d5sIVzIQ==
X-Received: by 2002:ad4:5b8d:0:b0:6e6:60f6:56db with SMTP id 6a1803df08f44-6e6ae96757cmr21396336d6.6.1740164368823;
        Fri, 21 Feb 2025 10:59:28 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbd6b57314sm573078466b.93.2025.02.21.10.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:59:28 -0800 (PST)
Message-ID: <3649a87a-59a8-4215-9a2b-b02c25203a25@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 19:59:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sar2130p: add PCIe EP device
 nodes
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-7-61a0fdfb75b4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250221-sar2130p-pci-v3-7-61a0fdfb75b4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zX6rQvB_DKW3M0eDQG1vV67ZO0dpfeIE
X-Proofpoint-GUID: zX6rQvB_DKW3M0eDQG1vV67ZO0dpfeIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxlogscore=804 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210131

On 21.02.2025 4:52 PM, Dmitry Baryshkov wrote:
> On the Qualcomm AR2 Gen1 platform the second PCIe host can be used
> either as an RC or as an EP device. Add device node for the PCIe EP.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

