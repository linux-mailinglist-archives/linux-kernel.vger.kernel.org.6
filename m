Return-Path: <linux-kernel+bounces-445755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612BB9F1B24
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3754E188E967
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDCC1EE00E;
	Fri, 13 Dec 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oVbq75gX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C61EE001
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134164; cv=none; b=a5WIgKn2QPhTm7i8VPpGP36Mh0DodXXH9EFrCp0vKoAVKgBVuM57aN4hv15thVAuyZtgeRRvQ62ZI74glss1mGWYwbHU1MkxXhKW+1IDjbuSwSbE+NUTsELHASrPdtO33AyYeokJKQIYOOPBmBgYz52HnivZivwggtbWbgiOQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134164; c=relaxed/simple;
	bh=eB5hO81qvELqW1QVwzwykvukceZ8/b4PMpblBqb8Ec8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsFsFKtj30TRqMqTskxlMZSNwuksMoq/X1pe7NClat5nN0TwrRploBhEafeoFvgjXg51e6VrmbG3VslEEG6OV6K6reCBMh5J6xJBgQR/f1PBs+leTk0gQ3sfR65R5DA7srP6LOppfzTLsjFmSKEZFKnmKjlqUWydWp2vM12tsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oVbq75gX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDE75Nx017630
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mBfG/0PIjoHp4oAUPd3vdYoV7y4Iyy6FP/GMZ3kUMk0=; b=oVbq75gX0Jdii2f4
	hT+6nR8fNoBzXancBaX8SEhqeAl4EMEkRs6CvwDvUVcWDxPoOT8GUV0d7HiRMr8h
	5W+i6W21IsiTyJVUluDc/xaXKFpi56XDvSLdqdFEyJIPmk1r6P9IgACME/1Gg/82
	yTgC8BCtWbTfw+ZQGU957AnCos6j0gZABaytXAs1Sl2HHRMxyFaIP24Emk+0dlqN
	Wxh9ze0lVUbfCT9Jzd2Lp+4tFvF9y6e1d+KAF6R6QKyBUV4JEI7CwfvUxbK/f3Tr
	eXr6+Teullg45G3mz+03g0c7SO0zXZIaQkEBPWx1ILveCoQHZtUZra2ur+At5Mi+
	SeuyEg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gdkn2rbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:56:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f8762a69so3699946d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734134161; x=1734738961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBfG/0PIjoHp4oAUPd3vdYoV7y4Iyy6FP/GMZ3kUMk0=;
        b=LzpN5cXOGZeDvQs+ZvQr9E45Fy4SMh4Sydmowx82Ryr40N0i/FAfMbLwCD6UgIBK1R
         6rinG3BTIgSy7gLN4e/LLirT92PlMYqhac/H9mKARaB6PAsywam0sp6bvqHB26OLqXXU
         9pm0s7BphUlqxofvXfei4d00LYQKL2icNB62ahcrg8YzxMkKwaIJdJWGcG97xA2r7rWS
         j7e7Zk8M41cmsYBQl3wX7ZmkTdZ8HZDN+sTkcCHdCaf5bGUvQRTwDWm/oJRJf/7olECP
         LkcUNpaev5VK+vHyzV/lTEYnyba3xWmGfzehfB0Rxw6eraS+EyqVEEV03OdDOCEIbp8v
         hCuA==
X-Forwarded-Encrypted: i=1; AJvYcCXMFNVLt185Q8q/aFdZulZqifeU3OXdDwUY4hpi4p/E6Bp+kBYs4TSh+zuksoIYoOoNBM+XB8t12jC07I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwAuwS854mAShmlcZ95JrE75hF01T8l3eDQm4C4Jpo0oRHs1D
	Db9UIpY3TbExq2G+UQoVofY48rDPYQ2r3QcA5UGFMhv5Hf965NEhRGplrarhZ0VXei5tGqq0Pre
	pa1X1Y/inwxvqtMsmspfDDYgyX3bm5A+k71L7Lg5taCVzIGPnW0oOLDCEpaqavEQ=
X-Gm-Gg: ASbGncsineVWUAqrXpAVqBZqaayYzyx7FQjKM4EWbFXa8Lon7cJ2WcYtftN56CzS6/L
	EP6oxuLTf99BrYz8M03sNVgwW0S7S/7GGJlEwXNnI/AgAJXee6Sd7jzATq0iqEUT8bbWIvHfT11
	xuaVcXziC/AyfVLaWnW6ECVRKXbOr8Y1rB7nbjoYQW7Be8IrggvmkladqEcJoz5Ct7lull3HUuu
	vb6D8gWtaLhhTMWtJouZiS2To9zZkaxTatlF0ifi+D2VnfilzgRebD1SIGEluQBWnn8m6te48Hc
	OaexTokTN30Qzz8OxLeESBzGRgEHGEDMmMQ=
X-Received: by 2002:a05:620a:191c:b0:7b6:c597:fb4d with SMTP id af79cd13be357-7b6fbee75e0mr249125885a.5.1734134160891;
        Fri, 13 Dec 2024 15:56:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkQ+V4mTkhQO2bVQpzfTauk0x3WapSTTM9VWOMeUP6/EPzzWU8xSQnJaVWpSSlnYUHGIC8pQ==
X-Received: by 2002:a05:620a:191c:b0:7b6:c597:fb4d with SMTP id af79cd13be357-7b6fbee75e0mr249124285a.5.1734134160575;
        Fri, 13 Dec 2024 15:56:00 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96006c3asm26507266b.19.2024.12.13.15.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:55:59 -0800 (PST)
Message-ID: <a106e659-1ab0-4eeb-bac9-ec882766094a@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 00:55:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/14] arm64: dts: qcom: sdm845-starqltechn: add
 display PMIC
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20241209-starqltechn_integration_upstream-v8-0-ec604481d691@gmail.com>
 <20241209-starqltechn_integration_upstream-v8-10-ec604481d691@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-starqltechn_integration_upstream-v8-10-ec604481d691@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cr8aWawlEJ56iSH1PS54n7JWlAazdl24
X-Proofpoint-ORIG-GUID: cr8aWawlEJ56iSH1PS54n7JWlAazdl24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=785
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130170

On 9.12.2024 1:09 PM, Dzmitry Sankouski wrote:
> Add support for s2dos05 display / touchscreen PMIC
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

