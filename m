Return-Path: <linux-kernel+bounces-512065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DF0A33399
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4503A4F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA78261587;
	Wed, 12 Feb 2025 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="asUuZJlJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0557261580
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403753; cv=none; b=ZT1w2mDWsrVROQmJTPvu6AhaXDTTEqY2NJX+bDv91XTp/SH3djrX0FpCnhd6oS0GJoSwutaOFieAvd1jeS66evZ5XNrc7XKnYR4GwJSjGt0xV0shgld4+B6E18rK6TSK8AgQbJm2CqMgxGtPAwcdYoeZT0UvY9L22IjLTM7ET5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403753; c=relaxed/simple;
	bh=4xJ/+2gfdWNob7RP6rwE58FMEWZdjuuYQeURDwUT5vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTvyqUlp4cVQHcEeVOz1p7tkWK0wR3650BnuSREJcPRWCGHBlGU92xVCyQUf+0+V+1L5Kcsl0g70BJtsTBpXakB5qysSK9XLXWIwmjIKtGam3s7d5ACnO2keaXRInOFFyvP2aTKwgGx2qqUk81hMwBWGXUz8FTRPeI8o2yDvSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=asUuZJlJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CJcnjw012698
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xgGpedKTGpzNZfyzdIjm1VKTHgp+XOgbBRSIPKpy4pk=; b=asUuZJlJFet1EeGW
	GecB5BXf8QVZ7D/yvNDhlgkiJeJMFtI8ptYHfs9L5Hkpc2WTWep75Q/cz3+g111d
	bmdSk2tmtyu04Sy0Sv3kkfhyEBTftxuYK7gdWUGjgdxpgcwZQkKVZvOxNEpxpWtx
	91xPNhhIj/HCDmDRZr8F+/rui6PWcPBOatJk89anTMJGiGKlWQ00fAieEMvUD4if
	VTBWnCXfrLwsqYuMrpevmCmFLkv8LqIaUsoQLwlKQoakVubsPr8UHHYA942FEqeU
	UJO5f9JiWR217dRWR5Epik7mw+jeddQJQ2YiC6a7pILTuV851TdSSVUFmN5ko8Ku
	kjSt3A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44s1yngduf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:42:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c07771cd7fso3735185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739403750; x=1740008550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgGpedKTGpzNZfyzdIjm1VKTHgp+XOgbBRSIPKpy4pk=;
        b=cySkGlMgMhLBOF68VZ2uIRW/SrIxxRS0g9UQ/CgmYhqS+PnS+heJI+2lN0qXNmpUss
         lVdFN92itfTmnzIAbscvRuGTVqMPBKp4qA1mRk11fq20qOCFOK//Xoq600Oc9F178Rmu
         o5MFILW2OG4H+a9XbsBwscKvE+OKrbNDLB9JPMxEZ7I50t6pdDEq3JaUXuIhSyZMu2Ii
         oiqVA9H/K8jS154VMHP7OKcqFA/slbSO5+7pkQdPnIZ+pRJU7mWX8TJ3QW3Dk5Wlx8dT
         Ma3T1Ec56f2SnKFAioUjKNcXxlNAlZeRYYj48F5P4Te5hvAA2lfkOBK4vnNUQWFXIri8
         Mfmg==
X-Forwarded-Encrypted: i=1; AJvYcCWo4PSPXnOeebRgVmAqdFdv/0MqKAEtxC8DNB3/Lf0byQgsbXMMZBbtpucvnmUQJUu+cVEGBTl2GoaQBgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQK3GasbAUYnwOlDAGCxo7CHp2AbFgSF4ixPnQ1m94yWKhCOX
	9SnUB/KHlK5a2XdHrLhX5s9l2HztbpC/wib4uMFbqn6HhZ0ARq1Z6qYC9mK8yPjz28TX8VERM6b
	ZdcGIQiEZoYUB8r3ZsjFH731Lb0GLCpmTFurkckRlwmeK4rbKv+5V4A9bRFiCslk=
X-Gm-Gg: ASbGncu9sW28syYXqLgYjYBZmaQaBo2O6ShuO92cu7ZNPkZK8gvMC5Q5j7chIhPYPYN
	zl2I362o3jZy6CrANsM9ANJrUv1Z4+e69J0g5nBLJwt+SJ5jXYSwExLG1Bh3t4akkLL7us3qybj
	j8P0yqcYyWxxakEXmWiQzZbag483SIkTiLlnI+zAfiPS1O3KcVaRkruEhkjom5+hP7OzGM6rDSU
	Kd6t7b89FXaR7XZcJ1SC9bRBlBUSrp0gAeCEBd/qmOEEQbzu2g9ZS7BJmugviWJdwHjeSxNEwoO
	oWG/jJgw66qGayGdFN3DUPQMO39gvlLCnIcCfg2GXZLDZoJaALc5MMIdrMU=
X-Received: by 2002:a05:620a:46a9:b0:7b1:e77b:26dc with SMTP id af79cd13be357-7c06fcc6989mr319510385a.10.1739403749876;
        Wed, 12 Feb 2025 15:42:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWgKCUEyrSFH/f5Wf1948BY9eXMfVEWSMHJfsB3GcAHOuXYsbdtTrfSIh5vcVxv1/Rh2F8cw==
X-Received: by 2002:a05:620a:46a9:b0:7b1:e77b:26dc with SMTP id af79cd13be357-7c06fcc6989mr319508185a.10.1739403749511;
        Wed, 12 Feb 2025 15:42:29 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4debsm182858a12.15.2025.02.12.15.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 15:42:28 -0800 (PST)
Message-ID: <ee113bc0-e8f9-48a4-8c31-20a5e2670ef1@oss.qualcomm.com>
Date: Thu, 13 Feb 2025 00:42:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64: dts: qcs6490-rb3gen2: Add vadc and adc-tm
 channels
To: Rakesh Kota <quic_kotarake@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com
Cc: quic_kamalw@quicinc.com, quic_jprakash@quicinc.com
References: <20250212113342.873086-1-quic_kotarake@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250212113342.873086-1-quic_kotarake@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: do0goKq6NGrm4E_USxXxJ0PnLfDfZVSS
X-Proofpoint-GUID: do0goKq6NGrm4E_USxXxJ0PnLfDfZVSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=719
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120167

On 12.02.2025 12:33 PM, Rakesh Kota wrote:
> Add support for vadc and adc-tm channels which are used for
> monitoring thermistors present on the platform.
> 
> - Add the necessary includes for qcom,spmi-adc7-pm7325 and
>   qcom,spmi-adc7-pmk8350.
> - Add thermal zones for quiet-thermal, sdm-skin-thermal, and
>   xo-thermal, and define their polling delays and thermal sensors.
> - Configure the pm7325_temp_alarm node to use the pmk8350_vadc
>   channel for thermal monitoring.
> - Configure the pmk8350_adc_tm node to enable its thermal sensors
>   and define their registers and settings.
> - Configure the pmk8350_vadc node to define its channels and settings
> 
> Signed-off-by: Rakesh Kota <quic_kotarake@quicinc.com>
> ---
> Changes from V2:
>  - As per Konrad Dybcio’s suggestion, removed all default polling values.
> Changes from V1:
>  - Update the Die temp name to Channel as per Documentation.
>  - As per Konrad Dybcio’s suggestion, I have sorted the pmk8350_adc_tm
>    channels by unit address instead of alphabetically.
> --- 

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

