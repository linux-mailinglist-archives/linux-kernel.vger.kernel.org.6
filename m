Return-Path: <linux-kernel+bounces-425049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB5F9DBCDC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C69164881
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722D71C2457;
	Thu, 28 Nov 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jugbajX1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36EF142624
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825532; cv=none; b=AgTtDxxLoKPG6Un/CRLcqKUbQD59VKCUnIbQEJfJvTxew8qq7hHLTqL/CAGo3MEl184/x/zr8c24oqnb6EUcdkIzmnpDrte7M2401lkoVi9K4g7+hxBnzS3BO+J3UpuMHychrHRNrtdgO1QC42ftpKsNsnKvbSBzkp+DNhKvlMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825532; c=relaxed/simple;
	bh=ozTQLpJy8PhSwcTQDFUMnO/dPjCHluLZ/fr08jPDrko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SE/AFCIsU/701Fw2cuyeDwhEXlrtp4enAShh8/R7Y8wcEA6ZD0aCocmAiZk7Lolxn6GyhQn94lik+0egSe0bpxFsFY/mrrAkZV6emYOYMPxockNp38mFwly4qG4xr5WAOpq2gqlualqxazpwA2QLvrdMgx2dXs2FyvVI5tNpTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jugbajX1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS9IDxB012280
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u+/C016dQKRw6wON/psnCJnEPdDDBTHE5HmTLOJ9gug=; b=jugbajX1B/2Jj3Ku
	0QSOTutgliMrmFAi1B92tklKm6h3lFY+m1QSmTfUdPRy35wTvpVLHkQAI2q1y8mr
	TFVPZHWVcpRBJO+Fn3rpcExMa1IwMaRtepVOlEfOf0bsSqrE5qEOKZabuOMV/QNZ
	K/a+jCp0skVY1NswNrtwqrSjPY5bKYr/iLO4FXzd6T14nt81UDu+wy7mhfeoQTEW
	sXKneeGaCjJ3QdmYCMaJNBdSToaHjb0YMRuRLAKRgM958k9I7fa8UbAmzaIM9x6b
	kDZn0IwJ4PGZLMX6Ta0XDHmQ06zZhFVKUyhqKy0SiQwVQepbsKkmUwd64IbN8xIF
	8vKs4A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xy3mc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:25:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4668a6d41a5so772931cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732825529; x=1733430329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+/C016dQKRw6wON/psnCJnEPdDDBTHE5HmTLOJ9gug=;
        b=hrIlxmi00fSxASoM43yUQIJEBMIGiDxHEI3o17mzNwmAxIS5rP2kpRhOKyoAGHNt57
         A2xs0mDpHAt9yLXyEMvh5bZN4ZgWjlzUjaZu+jQ6eCTPHkV8jsSopC8sKJLhMBbEjAHg
         mxM9Lb/ec+DSvNLV78YiORhHIT18+Ca7MkA/USrABBT/RjZ5jKv64tGQFQ/yfd1vOF3g
         LzG+xTTbEEyPNVDDejydJkDFfVmV3AaLXifuzqq0qb091Do8EnWHkE9PYhirlFLciVGR
         5SC3Outm3al46ZmjkMWxlWJ6+qjdBuNLUPsjiMGPcT7X2kGfz3YceOkM1SXwG4Xd33SA
         3CXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJEWadd0ElRbLCbIr5cmXlmpH5vTQXbQCgLBKt42QtNkvGqXVWwPQRQlACV47CH+h809+OPxEth2yEN7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBgz+q4nLjNw58vAqSxpu5uKKGRccNli4x6fpRpGV8lr3Wtx3
	9/MWCD6PENiXsHVEJJNt4w0fB+CaXxoLtk1biluWflJO3OpqI820YC0YsQQ1VmNOoDnWliRMIp/
	G3KZvbmDdYRIsNIX6AcO6GNbqW53BqulogmYuOiKJpnhJ3fd4/L+LMoI0MhZFEo8=
X-Gm-Gg: ASbGncuyvhetJB4WInI/AGK/imwO8BIKG4gGITS7Qbit7xNytRAv7tRU7oNa54JAoIi
	FIMtE4PKWmD2WoWNfqL3xmREooPqb3lnAxLPF5NEwRxsdsKAHkzkmfTgStziBE+d6AVlS+CMd0l
	vp+HBUmUGW+NWUwpW3lZ0shu62AiZQKDsgMQNEw+2TIzeO876P+x4wRSrOmE1Z1BwxuotWI/l2n
	NUspaEGSaZRHKcfJ5Dg+g783Zk1nZOtXER/lFYbs3tfgvri8k39cmenHVRn4y52pI3wnr+qjlIl
	wkQHu92QeZ4E1qzrGZxFRC53kZtAAuc=
X-Received: by 2002:a05:620a:4004:b0:7af:cb6d:69ec with SMTP id af79cd13be357-7b67c43f8b4mr453076885a.11.1732825528670;
        Thu, 28 Nov 2024 12:25:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeaf+9swg21gKgqEDGWSWEktchK+K+w8IqUCRHEdedVyVFvudM/0HRi3nCDHujYsn2pHSgrQ==
X-Received: by 2002:a05:620a:4004:b0:7af:cb6d:69ec with SMTP id af79cd13be357-7b67c43f8b4mr453074385a.11.1732825528164;
        Thu, 28 Nov 2024 12:25:28 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e63b8sm99872266b.123.2024.11.28.12.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 12:25:27 -0800 (PST)
Message-ID: <503df6db-8937-4e1c-9c0e-0cc093681a8b@oss.qualcomm.com>
Date: Thu, 28 Nov 2024 21:25:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 4/6] firmware: qcom: scm: Cleanup global '__scm'
 on probe failures
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Ojha
 <quic_mojha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Kuldeep Singh <quic_kuldsing@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>,
        Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
 <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-4-7056127007a7@linaro.org>
 <3bfd6343-de4a-4cf5-a4b8-55a3531eb41e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3bfd6343-de4a-4cf5-a4b8-55a3531eb41e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: m1KIgHpH1BJdNtev5oWJ8_M7A06vHAq5
X-Proofpoint-ORIG-GUID: m1KIgHpH1BJdNtev5oWJ8_M7A06vHAq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411280162

On 19.11.2024 8:37 PM, Krzysztof Kozlowski wrote:
> On 19/11/2024 19:33, Krzysztof Kozlowski wrote:
>>  	/*
>>  	 * Initialize the QSEECOM interface.
>> @@ -2094,6 +2104,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>>  
>>  	return 0;
>> +
>> +err:
>> +	/* Paired with smp_load_acquire() in qcom_scm_is_available(). */
>> +	smp_store_release(&__scm, 0);
> Heh, I should store there NULL, obviously.

Candidate for a new scoped __free, perhaps?

Konrad

