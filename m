Return-Path: <linux-kernel+bounces-433621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9892C9E5AB6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F591882F13
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0178321CA1E;
	Thu,  5 Dec 2024 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hwivEnYF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0858A1D515B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414782; cv=none; b=XK76YfOEJvZm3/Z4qBAd9Lk9cBzNttt0MCR1vObppLQPgENPYTDqVqpsLypK/+VAGnRpF6MI24tzc4n0YwxE7ctShMn0Q44xtBg038lQmEghaTVIVeMBanZVGwLybjPkUJMud7oBKwJH5k5S7ArVQssTtKpr1Q6l0BBle4AqOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414782; c=relaxed/simple;
	bh=dTGTozDvl5r2bsdVhzhgEBTX3U3UFXR9QdyYJI+jplc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCHqtJfkZTg75BdzP34S5YCaRtX8WnnUum1bcUEEsb7kpILWdfNLk9idEuTDAOscijf0G82+HYKDvubFKDaf+9tXeWWrraRPtC//7tFOICic0xZPCL2iaXKkSyOBBewb5XhiwyP2dPJGhj5jgQzgLNaY2NIChvjh51iTqx0Cmi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hwivEnYF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5FEuRm003962
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 16:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xBfiocvIunnaNdZDDLqDWW4sOXy+djzBwH8MF4PUINQ=; b=hwivEnYFXmdrGs4v
	MBK7TzXbl65XrV89nzqUUFt+MgNVfhrv8mMWc/ZmftpyxLdS3BYx1jPgMPBNKcOF
	XRYyDZZPm06o61Dzxwi+mWNkI79vbZxW/PXjTgzYV4CS17czWFiXDd0fZBGPDm0L
	HMUdl72fFjGuNbxPgXN33ws+K7zYKKPBJnYBDNmFAvIIa6sYbE2HmpngUy/Gn6XK
	dKAMIhfMy4NeCsVbkcJOvVfp1p3TSPdO4kdHaB14mkT4tNn3a16yVxjg+4BxP/A8
	qprbVThfdQfsfcc1GCLQ59q+COiu12VhipMuMULbtLBTHQI5UXHIZ28vU9lyBqjs
	iOHzyA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ben885nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:06:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46699075dd4so2787001cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733414763; x=1734019563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBfiocvIunnaNdZDDLqDWW4sOXy+djzBwH8MF4PUINQ=;
        b=h40d4v3jnfRyNx1ojsX9f0j5+X2YcFCmbjdV/kIKqHEr6SphQYKzgu1BrFWesOMR0j
         fjyx57cx8BT8J3zD+rKG9Geg69DEWeBQsPpxgu8hRX7WR5wJtK4CTpJUJgnTOtOiPwcg
         hTNO5o8Vnt0xx5E09rOHPI0OnNq+7jFDvhWlLbvdECgKY4OBRn8rhjePEFinHo9YyImZ
         Kb4lAC7ZATJIUbm8Ou9SdHlj+BqWRtkhQAMC2kON/L8xX7+qFbRsuH79dToYNIAITR46
         qvIIElKWwGXqjs9xnyJArqtK8vRGk4DTOQW1yR4F7Zhi2ebNfv8bUDNTE42++xbayZ30
         5YIg==
X-Forwarded-Encrypted: i=1; AJvYcCUcz2atZ9gc6+zyNHBqI3oNPADOU1Sb2s4Xw8SgfS6TPYZRZjpxtAvLsHDcnxZcGXlkOYq2NoJiE7ADDRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBP+3xfeXT6aYEh693HzjdRuK7qPV4nzZ2gWaxfKsDX3YUXAZz
	w7OvBXFe8iZu2dNmG+Dk2iO7tg9bnCFS43qksXBMq3vlgDZ3Qt0t52i5darlHY5jzkfwEWzg2F/
	m2RIMaNfBJ0N2srg/H9DwuhK9biXRTEnOvARoyksbhPdhxbwbiEZfpGagtB/1cRw=
X-Gm-Gg: ASbGnctnlqv+it+hKVNQbodI7qMwsHQ6Ek+isKG6U/6bGOL1IKV7wYQ+PTqer1quZ3p
	LED+IJ9btgxBWD1iaw9L5jMf5CxmGROOd61wtk69z+2k4qi+C6N8xWH0umQjlInVxm/ZiJf/IWV
	Gqs0Jocdbz3bGyDwhalu/FSq89Q1SSra5Kpg82sY3SeQA7gS3sfTd9XyWXxs4B+ymRR3+OLWzDo
	DhluQ9QIMq13wKj/Z7JqrDRf2FXwTwVQHh4OAn+j8FNNEWZf0JYMFnbp1OKp405kezFzJbj2VY8
	jLWlRCOB1WXeEA5z5Xs5troIH4SbvPA=
X-Received: by 2002:a05:622a:14cc:b0:464:9463:7b32 with SMTP id d75a77b69052e-4670c0c1266mr65695251cf.7.1733414762893;
        Thu, 05 Dec 2024 08:06:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrCtcaE45feNNHFxkzDlmaVr36CClapjNu62lWnE1/SccytLaUZvqDSxyCoV/RvKzynTQGcw==
X-Received: by 2002:a05:622a:14cc:b0:464:9463:7b32 with SMTP id d75a77b69052e-4670c0c1266mr65694961cf.7.1733414762471;
        Thu, 05 Dec 2024 08:06:02 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dbf3sm110912566b.12.2024.12.05.08.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:06:01 -0800 (PST)
Message-ID: <54e9582b-8570-4272-9d08-6a89a1548bd9@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 17:05:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: Add base SM8750 dtsi
To: Melody Olvera <quic_molvera@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
References: <20241204-sm8750_master_dt-v3-0-4d5a8269950b@quicinc.com>
 <20241204-sm8750_master_dt-v3-4-4d5a8269950b@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241204-sm8750_master_dt-v3-4-4d5a8269950b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nZozmsVpNfSMt2AMtaXR5g2kRfs796vu
X-Proofpoint-GUID: nZozmsVpNfSMt2AMtaXR5g2kRfs796vu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=698 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050117

On 5.12.2024 12:18 AM, Melody Olvera wrote:
> Add the base dtsi for the SM8750 SoC describing the CPUs, GCC and
> RPMHCC clock controllers, geni UART, interrupt controller, TLMM,
> reserved memory, interconnects, and SMMU.
> 
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Co-developed-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> Co-developed-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

