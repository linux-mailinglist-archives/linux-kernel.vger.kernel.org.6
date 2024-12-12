Return-Path: <linux-kernel+bounces-443783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458909EFBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F180E28D266
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC71DD871;
	Thu, 12 Dec 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hFS00Xd9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633A1DC74A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029560; cv=none; b=SEsfrP02qLvlB7yKsKYOTvCUxrdShDjPxHjGVvBKZRRVsNB9zBLGafxPoBWG96R84jsmd/YLU7yjJQcBoXbmsLcD5CPlsn1DuxzYSH9knJCrTSCRNVzsQssDyT6acZpp3s+FwwL6gYzy/cahZTzrUUL+eKqeEOwKqEyH8G1GCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029560; c=relaxed/simple;
	bh=wpqYRHLY9Q3i1AL8BGhF97syV72LViqIEk0cqGJv8Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUEPuL9FDSPpAbO9lMUGJ3+igsOtTQQZCETCVkXHuxjEbjnoe67EhfBudQ8oEx8I4BizzZIg9C86jEEkAA8J+yKEq1Nvnk7z/R1GGO2AWPOsuLVrcZLOWYI0aI7ME5rtF01DVUtZulbSnX2jqVv3l8ezCsmkrjCnLuy/ftVvH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hFS00Xd9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCHemcZ002016
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SHVnPiu0fXT5G9r0E8kvgJAmJO6G4iQt+5iBGL0kKQg=; b=hFS00Xd9GkhgNGDz
	+G/Uod11VWTNUmooW2m6jnkz5AudeBjVKBSt9v+/si3KF26jJr1LegZX6UFhZN7U
	xLNfAR8aSCB4iDj4Qd5KmJbu2NlBIDAemaMqXkYokSJ93Eyc94WxzU+WNJapnI3R
	nOARjh331Y93l+cq4sDElqwMVyuySpJJ6jtaLexILjfSfZPSMi7TV5wPhVsJNUSL
	8fkh3eFR8MOHVmU+mCaGlbcvflvEC1aoy/8Kl4r70z2vJuOOIgGlqSknu9+WJ2B2
	bqdmHLg9Pwum/4Qy4efWkiOqnSntdbTvfQcv0JfxVtMWa8OliDmQiriqEo+u3138
	iXNDMg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eyg66fsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:52:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-466a20c8e57so2024191cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029556; x=1734634356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHVnPiu0fXT5G9r0E8kvgJAmJO6G4iQt+5iBGL0kKQg=;
        b=NswTJ7NPEhH+fcM08/SsphTj9Ougu/f5iRnklie/Cn/6Yt51sQ/twoR50ErGCS8i+y
         8TwSeqab4/DqDXOi+HtzhiW2fNh88g3eMm2SzL8Yan7tLBn5tSiCO3RYjS/NX/f8BsKf
         Pnsws2BxOpJdLMC/8KrgMSrCgGUBXWFSG1LMBp+fNMevNR+3A3K+8S7uGMmzrORAT1hf
         wES50WptZXid+eCG0qDKVWOT3G8dLGrCbpjGWNnr5wzUan5btCNb6GUyQ3dJPYVIdHkU
         Ubm7esSXHKvgXEdQcVQVF8SWKs7rKDvStA/OceMJ618nVak4/Oz+i/LhRG1c2wJr/EU9
         OPLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW8F8cMXtz1YLHamQ6xCVsV3jiudastoHmqhlLROu41u1kQO+O13Jh49hXpR3Y8NzlZDkL/yvzI8IwA/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTGORScM4Kme9a5emFCLlHHQBNuuzUFEY/8s52mCjqIBP2vKst
	r9DJSN54lDeisysN9KVBx2mXb+SFcP3Y0bhPuXs+3XK3miI0Wjwbzh/11VwPLkrVIgZ/TWeIM9V
	P4af2ifApVFvgd4658ltL6s9pUW7B5rVgF9PvvnDTYyRVT5XAADxFdoYraKAbxOM=
X-Gm-Gg: ASbGnct+LHKem7V3d9AkAPTxc2TWbLDgm782QtFsc/O+diO1htfQzD8sywYq7LA1Zv0
	/X4SiSe97yt/luy7rykWRqrNO6qxoZ60+T6hHgF9cUaz8wryx0WE3Z4m4GmChwkYMsO0v2zTT8B
	RRBWtpN/fm17DjOPfe59xpoeb8n4HcM+wYlX458B54nGTDUKgQu2eEf0CRtkQwT0mrNobVxwu/E
	UMgfMuprK/D9KFuAua9jdrysiF4nLUmcKY7hPr745VjVJhmivGAVY6+mazcj2DkOMA28t+5rNyE
	6o4Ie83m1ImGL7HF55tyX2qBthdOO/iK25RMbg==
X-Received: by 2002:a05:622a:c9:b0:467:6379:8d2f with SMTP id d75a77b69052e-467a169186amr8478191cf.15.1734029556535;
        Thu, 12 Dec 2024 10:52:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7/MNbUv3xFdwlcuOQKfP0KGnVgHCuYubECnvOzq2ZduK7+n1HlMtVjJI0EFu2TjMW4OtvEA==
X-Received: by 2002:a05:622a:c9:b0:467:6379:8d2f with SMTP id d75a77b69052e-467a169186amr8477891cf.15.1734029556196;
        Thu, 12 Dec 2024 10:52:36 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3f1323f99sm6819723a12.34.2024.12.12.10.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:52:35 -0800 (PST)
Message-ID: <004a2231-992b-4657-8f5b-5edf96a1f5ab@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:52:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/19] arm64: dts: qcom: sm8550: Fix MPSS memory length
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa
 <abel.vesa@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
 <20241209-dts-qcom-cdsp-mpss-base-address-v2-9-d85a3bd5cced@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-9-d85a3bd5cced@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n6VwxvfsGD8vYpDVXWWD_Ao8Kgpq8dfT
X-Proofpoint-ORIG-GUID: n6VwxvfsGD8vYpDVXWWD_Ao8Kgpq8dfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=897 phishscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120136

On 9.12.2024 12:02 PM, Krzysztof Kozlowski wrote:
> The address space in MPSS/Modem PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
> copied from older DTS, but it grew since then.
> 
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.
> 
> Fixes: d0c061e366ed ("arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes")
> Cc: stable@vger.kernel.org
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

