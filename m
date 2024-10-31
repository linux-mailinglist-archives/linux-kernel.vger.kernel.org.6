Return-Path: <linux-kernel+bounces-391236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC6E9B843A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1C31C21E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75711CB51C;
	Thu, 31 Oct 2024 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MwpUnlik"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9771C9B6F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405818; cv=none; b=k2RUoR47ZtTuYmAaX+q1cZ9nhvQ2MYyKGfrXzZziM3Ayav1zOku1FUdyebt0rJAjoEpxFdt2+jGcAdzZS6EPNRK5+4dffh4BdZssObZ54RkW5mVFTdG+JnaXmlHSu91yj0QNFftIb/68e26rM8aDHPLhXB0EAuikP/0dwL5Bg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405818; c=relaxed/simple;
	bh=aS28fB6UqgGm/4sUAt98ASNcFowCfddJK4hIlz47uOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0J258uhCXlS9KSFQ/S9welgHviZzRYy/E7dcTHb6ZoR/T0tNIIc6ORB9OV8OBJqhT07ZXLP3g5d+mfW2TVIU5+GMuaTgTIGJDFg/dScCedJy+6bnVYw9YFgUslRq04a45yEzdE88B/mj4f1T69VQXgjWBNbJziJ5h5DS7ZhQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MwpUnlik; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VDnY85027398
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ozwR/yWp/h6s0zOrE1a/DisJrfhCASdMf2SpTqS0ZTg=; b=MwpUnlikrR6e40WI
	1XYT+WiOLlj+t75UcW3oS/+LqmwxXcalUAg3qNg6N1eM1nW6ZB4PYz+I3eYawFlH
	qFeM1jSRxdX5IRpLM4wE7Dqp5f6owBsvhVbPWOnAutJH5cyZj/nlQQNVDPTA9Cez
	AR2xzqwtMrgl2QtSqIsfYO+J7m1v52hnVOwhFOx/AnpXwKBJ+SDTlenq1xsfB2nd
	x3fQzaFkvCKrmYFZ3i0UPdtQki0DBthk840pl8iDvOSKSsSLj2Qcen0uWYVJvQ3W
	Z3coMxc/wdx6RMSo5w86c+El6E1ALiZ25OOPSyjMjQnTI+kB4zGq5bIdcFyNreQH
	ToLwqw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42k1p383p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:16:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-460a7a53e1cso3484791cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730405814; x=1731010614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozwR/yWp/h6s0zOrE1a/DisJrfhCASdMf2SpTqS0ZTg=;
        b=jrDmHQ9LD4D1D7EdYHvTh7aulZg5lRc9J6wlOG0oaYxdhYBzKjrbxtEF86swwrGbc/
         qUWn07pAxgvUwFZbgKVqLho/jQL65iM5J2X86eSMRFVnV4qlaF4/ibGsqxRp4UVpoqaI
         Swjguwkof7InbnF5biVPkaTaSzF2QF0P0c2nfOl/gZW2DbFUzd4KBzHwpPWzWqTAbeqc
         XzB+QbEpcRCWQ7uIVTA5N/r3azjdexuECKYx2e7ycDJaZryXBNwttID7sVL5roCNgHZb
         wcQ328ZoS6TYOKSaocN+uv3Ncb+JU9ByxvHrhOjN+hEljQot0+LCl4EK3OQhfHJ3QXu9
         nWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/UtIEF16bOJowIlqOF4lKxxuCDC/mdJTBcKU0zTh74IyNcNyw06zTiDLiRBL8uQIMZyl+KIJg2INpKoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxECCjDrx3szT4dM3ThqaocrvaRv0EJNqxQfkkYNfcZDAAB5bzm
	mWP2eOw9dVEJI3cmZiiRLIxx13Q7lJ2k9BKvRQ+BbnnKD99Tf54NRWa0mtsPnnocA2b22nt3Dt2
	o9a7W1n4M9ml+l/9ho7CpsHJSKfJgIrfzZu74A0kZlmPmLgx3+lGGOIrpb5Pe3BA=
X-Received: by 2002:a05:622a:4c:b0:461:4467:14bb with SMTP id d75a77b69052e-46144672164mr133072901cf.2.1730405814533;
        Thu, 31 Oct 2024 13:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbr/d79LGu/Q7dBQ5alrYSE9+vcKF4974ZZJ7pzngcHbryus/lwYkyb4r9+yAYB5WTq7Xd7Q==
X-Received: by 2002:a05:622a:4c:b0:461:4467:14bb with SMTP id d75a77b69052e-46144672164mr133072631cf.2.1730405814188;
        Thu, 31 Oct 2024 13:16:54 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7e9e65sm853240a12.97.2024.10.31.13.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 13:16:53 -0700 (PDT)
Message-ID: <0097f45d-e4d9-48c1-9f52-a0ffe956946c@oss.qualcomm.com>
Date: Thu, 31 Oct 2024 21:16:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] soc: qcom: llcc: Add LLCC configuration for the
 QCS8300 platform
To: Jingyi Wang <quic_jingyw@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: quic_tengfan@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        20240925-qcs8300_initial_dtsi-v2-0-494c40fa2a42@quicinc.com,
        20241026-sar2130p-llcc-v3-0-2a58fa1b4d12@linaro.org
References: <20241031-qcs8300_llcc-v3-0-bb56952cb83b@quicinc.com>
 <20241031-qcs8300_llcc-v3-2-bb56952cb83b@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241031-qcs8300_llcc-v3-2-bb56952cb83b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UNtjQ_4MMaB7abrkMGku6aPwB42mdbc-
X-Proofpoint-ORIG-GUID: UNtjQ_4MMaB7abrkMGku6aPwB42mdbc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=753 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310153

On 31.10.2024 8:14 AM, Jingyi Wang wrote:
> Add LLCC configuration for the QCS8300 platform. There is an errata on
> LB_CNT information on QCS8300 platform, hardcode num_banks to get the
> correct value.
> 
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

