Return-Path: <linux-kernel+bounces-370535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3916B9A2E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45F81F22697
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400227E101;
	Thu, 17 Oct 2024 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U83eDifG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7F17BB32
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195363; cv=none; b=ChHjw6UniqftSa7YkNMwQidekxKLFKa0NX6yggeANaCsKvEJXEXGwPVYWpclK/5lKq+zXyjT4AbUOj6VkFVTcHeMNuPlQwgtweALKJR3OdClpmHmJ85ZsKnyf/D0aC4Wy4kk1P+b7abFnWcGMqjuzXPJwmNYjKY9OWJGqluM+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195363; c=relaxed/simple;
	bh=Kg3QRPbmeNJtHXlXfZaFf+HLIHFd5G/Sac3guGxhy94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNpq6ZSkUTcTM0tWincRjnWjnycd2GqRO5ZGbmb6sJIBQbSGe67hb3zeQXt9ezSmDznbmdCkutGbeIGumQ5rT1FjT7dzM7Amij39AP0sPan9G0KGp91ClTKVJiFRwsBczkJyavpIR6BCG7RWC1KxZZpYhfbKUQMX+Pl9AkGTu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U83eDifG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJRsgj006561
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tBBYLBpMSbZIu3oYpFqjCl5s6XZNZ0gWSSPmXYNa/Rw=; b=U83eDifGyUJlKgg7
	qnacO8zF4QiTmXyMMa5rtLTh6Fl5wYTjefofUcxnuAWnX6HcLll7Kh8a8CSTOskC
	X9Bx82GaEHeibsSKseuLVHU+gb5h38uSfp0LVkSl/LMBxOITctqTkTUdxlal66Y1
	fEu5EmD8H0oIFxJ6fdvdOrY8rDpe+GoVag0ZfLTOudhHgwnmWGXccB+9y7SBzdUv
	PkW3Z3cIKiDKdP82WwZDwHI9Hn5zBygeEil00zDV6KQRvmvTsR0HDTdL24diiS3N
	5tr5SUXSAi9O+XcsXBOznkOliCcVkIHVBoU7M74KOaya583WgvAeJoSsAztybwcn
	OcQKUA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42b8rr025j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:02:37 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-718071a2128so216906a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729195356; x=1729800156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBBYLBpMSbZIu3oYpFqjCl5s6XZNZ0gWSSPmXYNa/Rw=;
        b=B17hczi8G/ToMqJqvfWdRLS+dqVHwYGXnIcHF9q3TpS4YbZ/t8L7cj7xJdPYBOAg2g
         mTie6iQVRq2Jiu27Ul7XP1J7AHRoIA/CKpcK3OxHkjittsav/P/MV+ZaN9WpcP6Wt2bg
         qTRlFfpvvsOHsPQHbsRVCQkguGbHNpVIimZf8NoaJKxwsGrg+KjFbTca3N8WK+d2es8q
         /CdKdod+1IzGwGPB/SlCCiGHysYUl3r3TIyWAw2eATD+YwZFKH+sF+Ju+OGeIkaSHR9M
         6S7VZapIALnqhBeUxlLjTQ+DcpngOQUten6Ftalx6uk3gtpELc4/fHdHZrJ/m4b2E4HG
         8ttw==
X-Forwarded-Encrypted: i=1; AJvYcCV1orkBdPmIJQrZpnP6VFCMYjOkSnKoW3qSGko5U8Zy+3qQLg42E6sia1kFwAlTJ8z3NMUQLhyTuvls3YA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ePB0E5RFNu53at1QczFcmwe1Urj5OXho8cLFubUhRrRPGXV8
	oLz3Hmw6z+dPWhezSU+RdnXrJzwjvSwDJO6Pq73PHO51sL+59pKizvgduPjvCldH5dEKkPOb8Wn
	cTwiyypekyJwAfsAJ17MIf+zrAVWja35oQpYgWr7tkcqDdeBwDjwB0oCtB0g5ly/7ctZ6Ltk=
X-Received: by 2002:a05:6830:6f4c:b0:717:fe19:1b94 with SMTP id 46e09a7af769-7180e985a3amr1133105a34.0.1729195356302;
        Thu, 17 Oct 2024 13:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMTn/UXyxPfIv+t6hw3F7DQQNUMxaL0gQ1Bb/kMvL77T94npKId332moX9F3DQ2jAqDtakzg==
X-Received: by 2002:a05:6830:6f4c:b0:717:fe19:1b94 with SMTP id 46e09a7af769-7180e985a3amr1133094a34.0.1729195355931;
        Thu, 17 Oct 2024 13:02:35 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68b14b2csm7271866b.95.2024.10.17.13.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 13:02:34 -0700 (PDT)
Message-ID: <d69ae60d-c4ec-4c79-8131-b4abebc7fef1@oss.qualcomm.com>
Date: Thu, 17 Oct 2024 22:02:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] soc: qcom: socinfo: fix revision check in
 qcom_socinfo_probe()
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, hanchunchao@inspur.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241016144852.2888679-1-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241016144852.2888679-1-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: U55288aWBABZXmuudYvZtZ3pB-HpbH3d
X-Proofpoint-ORIG-GUID: U55288aWBABZXmuudYvZtZ3pB-HpbH3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=898 clxscore=1011
 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170134

On 16.10.2024 4:48 PM, Manikanta Mylavarapu wrote:
> In success case, the revision holds a non-null pointer. The current
> logic incorrectly returns an error for a non-null pointer, whereas
> it should return an error for a null pointer.
> 
> The socinfo driver for IPQ9574 and IPQ5332 is currently broken,
> resulting in the following error message
> qcom-socinfo qcom-socinfo: probe with driver qcom-socinfo failed with
> error -12
> 
> Add a null check for the revision to ensure it returns an error only in
> failure case (null pointer).
> 
> Fixes: e694d2b5c58b ("soc: qcom: Add check devm_kasprintf() returned value")
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

