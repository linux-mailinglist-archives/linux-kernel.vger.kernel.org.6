Return-Path: <linux-kernel+bounces-382434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE99B0D99
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3221C22644
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A073F20BB35;
	Fri, 25 Oct 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kx8P3c1w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23B18BC0E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881780; cv=none; b=AKoHJ6LoPPu5aSkD9qMaZLg/Jw2Ign2+3z1l3s5V2a5xS8BjETROOE/nrV+GovminVcwBtWET3JNe79yrtH3imXnbKslo0gVlskuwFXVTjC9eVrnLuTfv+7ZbI5yReQOShZiMMHhKSZIQGiTyQSEI35Sz2NY1aSRHRtX8hNMCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881780; c=relaxed/simple;
	bh=sXpVGo1H7dGGXwCO8hvCponjq9q0Fo312durYrLhaJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGel4lDfkh3NnGC5Zg+zqVtFCfRCrbF6iRAiJ1wgLXEAchncCMv7p+JMjU8Ihsy4VAGfpxA/FLzklaIFJMebVhqJXJy5mVXmJTdjqcn8koCvYNdCM3T5r2c3Echq1yP7CrxLv/TD4EhHalnl7nedbg6c8//DA7SgcP70Yp0p0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kx8P3c1w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFqi9P031742
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CftwoMsXWNDvdSWjKSB8oIIniikESu+F6kHXU+lmiTE=; b=kx8P3c1wxhhCFCeU
	0VCAPF+87wcNkF5nuNJT7QZ4sBx8FPeCU4Y2W/BkjzWdC6NtwzngCeBriCRqc1CF
	Uz4zB6lflWm0y2NpNLkRkC3aAhlzSg2lpbro/z5lGQhImCnzn3HhSYe/w0h6a9dt
	G4Hv6mwy6I2FYMK+jfzcYB9gGQ0xh85N57QV08bknX7p+En9ilFX9zBQRx3yyuF8
	NucwgyMUOFvmAVGaJ7P4+uWz1tnxqntxYVADZr7FRMntJDaYx3dKvVy6ZRMlSoq+
	qPWa9iW66tJ9UcAdmA8HPFXtDnkcPWdHOundEgF90m8l9AAQPVkF3X5kbynngTCK
	SQThgQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3wj5nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:42:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-20c926885easo2779515ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881766; x=1730486566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CftwoMsXWNDvdSWjKSB8oIIniikESu+F6kHXU+lmiTE=;
        b=jnblX3lQT8mufvWF+vAYO03D5rqLIMBKENTQosgAS3+wH7LReL52gMM7ORAYut2iHp
         jIQs42BwcLeUfxZvphukKJlm+wHsqOI4jvDneabei/94l3//400tAH4EkQA/uidntYSQ
         jbZIcWXwYSDb9xLVk/XmA/rJRGBa2w0Yebto+nBjZHZw/5XWpGsaaRT5w4kT9vnpcG/S
         LQKVLuVBx/Qf/NZpGrMnBQORIpI2MgHsaoF1SpqTHNQ9z0RJ/0kKePtzLa3TpIVk/84i
         2hC0GP2Woj6/3kXyPuazwbA42ciEft1F6qXJJTXFwnRJNlbDv5vi8vOccNWNudqYntBa
         +wjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZqrZdnBxXairZ/aL26vZ8NpCxO/AJGE7fVOyUhkK8G67s2Op0Ke7Y/xDAL+UToS8/ojONP0CSJWKsIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyd+30VStsrYKrlsKD7pxewpFFjy1cBvJookHEh7GCvVjjXwDb
	SXJSDDqW9vUL0+8BnkX4K2oDSmdqoDLjTSmUlorv9npjYyUHhnNMGSsePxOTzJskGB/hvsrodGL
	M7orY5gsTDWopUWpUXFpB9SlUa/zGhftxgplKGJeqlUUU6LTzIhofdF7pghQ2wbM=
X-Received: by 2002:a17:903:244b:b0:20c:a97d:cc6d with SMTP id d9443c01a7336-210c6d2da27mr402885ad.14.1729881766646;
        Fri, 25 Oct 2024 11:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWkKLr4ZwAHpej1ExoPooP2vHAOpOPuW/UAfIFlsj7x1W8eddwvRzMSNmaPvr3Dqx1X2lzAw==
X-Received: by 2002:a17:903:244b:b0:20c:a97d:cc6d with SMTP id d9443c01a7336-210c6d2da27mr402635ad.14.1729881766328;
        Fri, 25 Oct 2024 11:42:46 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a08a70fsm96210266b.224.2024.10.25.11.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:42:45 -0700 (PDT)
Message-ID: <9e0f200b-53dd-4dbf-8b0d-1a2f576d3e3f@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:42:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: sa8775p: Add support for clock
 controllers
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_imrashai@quicinc.com,
        quic_jkona@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20241025-sa8775p-mm-v4-resend-patches-v6-0-329a2cac09ae@quicinc.com>
 <20241025-sa8775p-mm-v4-resend-patches-v6-2-329a2cac09ae@quicinc.com>
 <e810ab3d-a225-4c85-a755-3aa18c311cc5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e810ab3d-a225-4c85-a755-3aa18c311cc5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0DERqudjZ-CciwCFyk-HbUfS7Rdzc_Cp
X-Proofpoint-ORIG-GUID: 0DERqudjZ-CciwCFyk-HbUfS7Rdzc_Cp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=673 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250143

On 25.10.2024 8:42 PM, Konrad Dybcio wrote:
> On 25.10.2024 10:52 AM, Taniya Das wrote:
>> Add support for video, camera, display0 and display1 clock controllers
>> on SA8775P. The dispcc1 will be enabled based on board requirements.

Actually, why would that be? CCF should park it gracefully with
unused cleanup

Konrad

>>
>> Reviewed-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

