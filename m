Return-Path: <linux-kernel+bounces-394692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2CB9BB2E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D15F282C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31191CB9F3;
	Mon,  4 Nov 2024 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J/R34y8W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB81C232D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718397; cv=none; b=ovSoaErbn179/Qt/L36IHj+KIrhS074gAz0eAm0X4GVm+squi2v2QAP8MPrq1QdGdhjIZJRQh5sGt0xUucOh/nMo/JmG2uRPnR1huaXykudSdViquOs6W6z6I1JmJqMi9ATqnreKvCbM4XhQ1K3Fat4GXCxutKN8bf2XhaskKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718397; c=relaxed/simple;
	bh=YAbHgU11pEKKzz440oMM1ZrwzPP+qMjnbTNc8Wm74yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=go980FNwdIlzfcDsLL0DlvOT+uzFpWZRinxNJ9KDCFaWTAlN8I2O8c6P7Nl2uMAHMmDBaL3Hkn6yiLI2v6yeMHIuIDRdLV7vn5Wof9AWw/QnJ8owK5ugbT6+XZM44rR2+2azxUAEi84JTcOBa8NHPxJg6CwaSjLZbbOSbH0qOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J/R34y8W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3Mq0mv021752
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 11:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xoYGNGv68a0vBcqXh4vhD62xBKv9Pt0hZafHCm2iQmM=; b=J/R34y8W65z+PoS8
	8bRgrYPjq4aK28YHWppjlpCILra8Z3f2+bNUUaDFvx6yIwZtvDosN3UMMuuykrP8
	e1KzlchXqYQncryi6Qchy8PxTFw7QLceF8gcMKblnBFkL/O7y/h+I5jymIjud+aL
	cqu0zX5GsKs4oS7nR4WVwy5h3SdI+oMKghn9vlIsNV1yFmed5mIQ1qcv9z9vomUc
	RrG8wzTi3qg2eke3wF5wEOuA61WYPTHuJpQ7JqAQxK71Lx/juVi+fHmfZN9O+OxK
	CwzvDQaoL7mT7SPV6Zi3iqkSd9n9VTKEMJ972BCpJs4J2w5T0OfSAoJ80Ib9IQNs
	mhYQYw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4yku0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 11:06:34 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d37d9868b8so111076d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718393; x=1731323193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoYGNGv68a0vBcqXh4vhD62xBKv9Pt0hZafHCm2iQmM=;
        b=nosIrmg0y/T1QOcRorvFKbH8EM5M7qzwVY3Ef6L3+SIHek4wjyMSe3A9/OuKtf74vU
         y/NWsvxnyDX0FUqv+2CRj9eKZWtWZjAlb135Wde3zDV9zA2xFRfr9JBxp77AknE11mf+
         DgPHi6OHrbsQLFRhDVfYiwQtg5QJOghHfgHM/me6rpN+BcqiMpzmoQRyf+EMgyez2T+F
         /1cMt4nRC5hMWOzO+s8M4fUbG6LQr0IlGPdGE6t/HmVsyKvI+PkwsqRfbqjWcDnnheJj
         Tqt9vHEaRey544xqsrjDH4UKt3Nlo7UuFxyRdBl3OYJglEGK9lhu3H5u3rsHTG/NoGWI
         Rkdg==
X-Forwarded-Encrypted: i=1; AJvYcCUxza+8mOincEXO6xLj52uu3/9XkthTe9H80ggruIQzVFddpbK3iEZ+LhwKm1C92q6E5NU+QhkC/n+yqRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd6vibtuwImk6TrbkJYeyymMEaxJ7mKToL4uDFgv9GLnVqNWvN
	tCGseCdgUsYcAhbRyOp8CR3tDgLrCghAgfNdY3zBpbWaUq1oGsruGA7n9RCmUMYfhkeDdxCtelm
	pkDf6YK7xjmRXL1ETNBmtzL9GcE4PReejtARFmkbfIaCz3lzmMob/uVGlm+cRKr4=
X-Received: by 2002:a05:6214:19c1:b0:6cb:e7e8:9e88 with SMTP id 6a1803df08f44-6d185885e9fmr229611376d6.10.1730718393024;
        Mon, 04 Nov 2024 03:06:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfkcgKh8sGAPkatz2bYCIHC8CTdYMhUrsG7fYzyuiqa7pGOgucfrhsZiuYCGZ4ulbzCrS3hw==
X-Received: by 2002:a05:6214:19c1:b0:6cb:e7e8:9e88 with SMTP id 6a1803df08f44-6d185885e9fmr229611156d6.10.1730718392659;
        Mon, 04 Nov 2024 03:06:32 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c4f2dsm538456866b.52.2024.11.04.03.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 03:06:32 -0800 (PST)
Message-ID: <c72d0566-20ed-4046-9150-04bb98dfe41f@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 12:06:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: ipq5424: Add
 LLCC/system-cache-controller
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, conor@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241104073840.3686674-1-quic_varada@quicinc.com>
 <20241104073840.3686674-4-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241104073840.3686674-4-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DepIqHZ4WoH2QeI0pP6s513650r4GxAb
X-Proofpoint-ORIG-GUID: DepIqHZ4WoH2QeI0pP6s513650r4GxAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=665
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040098

On 4.11.2024 8:38 AM, Varadarajan Narayanan wrote:
> Add a DT node for Last level cache (aka. system cache) controller
> which provides control over the last level cache present on
> IPQ5424 SoCs.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

