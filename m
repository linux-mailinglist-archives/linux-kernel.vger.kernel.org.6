Return-Path: <linux-kernel+bounces-533351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE8A458E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7746167A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD7224223;
	Wed, 26 Feb 2025 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GQmWXoI2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6504258CC2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559892; cv=none; b=F70FW9rr4r0AjcubDNMCIkQhgnLvl/KS8SuJFkiUap/2zBb61Ff3zA/sj10Uj3LBO4rfTiYPa4wjKRcbcyH/S3pymAaDe008NPZkr2YfPrD2AW3gpCOBYje1ovjI6NBz/05j+8dTMdhjGPLqpRa8HzEEZyi51hWUcS9UgwI7w9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559892; c=relaxed/simple;
	bh=7+mRjbFyGkkwleiZgQV2NLhfIkvCmnoAupYlD+d5k0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjTYnW1z8GO4hAmt+6r7oktXT+5Z2QabD/R8gRYYjFJT9Z80wAS8UkBnAJxg42AvsbjlxAy/CQvfquDX5qVrgvHOlUh6fH+NidtFsTqrXuH4cc8eA/T41LRPp3mwMTAdwymSXGZCHKcJnxgNXBzFJ1x085R449R3D9oSlWnc/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GQmWXoI2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMXKVF017866
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4VjD1sYyFXT8PlD76ASHg9J8NL6hi2pojwmwarL05W8=; b=GQmWXoI2IixbtGY8
	zaR2J/cz98+uAzqiEWqyP/XRpyLdcNmQ0/TocjXj8LWULwVt6ZVpvpI1wtzI0eCj
	JRE3GjzOcmvu2OLaIiQ1qMYia71rGty3FwjRBCNz3MjggXzTlEY9TCSRq5TWCYwr
	KMk69p6NHv8jUbrox4ke6xGVpJ/Kl0wziC+Odivo9Vn1C94XjvGiaAgbTKUvd1V6
	hgSUhZv1ij7og/m36lxCBHVOCO/K1r5Jf8Kc8cVm/yPkFkicy0WxIjXeo5H4522P
	bGTyy/jumwS/ND/oZCqvH+Y04szuMPpBm5//3VOmRrWvQbtWkiuIFqbgoEzOdJLM
	OojtCg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prn1bgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:51:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2233b154004so860205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559888; x=1741164688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VjD1sYyFXT8PlD76ASHg9J8NL6hi2pojwmwarL05W8=;
        b=gONnkMSPAoytNVvzhbcq336XHs8tbfyD5kMDbPa6j7V3KoeAnh9tve/0ajxN84Ppr8
         GirW91FXJktr5h1c73N3Tx70nhfl0Bg2GJIG8c+z1uNWm1Yxj0olENhIKjuZnL1lfdHj
         EMwLjTDDvupKFZw/AyAl0TfuqcJ9Jt44DZFLpzz/1de2Oh4o3TexX22Qmj4lZtUWdv/K
         kAK4XOtr9pgCpn9ebLF0pgfxNIV+4skiU+EddIZiep5W3whr9JJj3kp8ZBq+VE8exyud
         G87NWz4f9r8NrsrfD7U4g9Uuh0tFK7PxJBNO1SsnZKU864ZS2uVh3zEiHFm8bUPcKO49
         w/6g==
X-Forwarded-Encrypted: i=1; AJvYcCX5tPeFWTY6bo/YSy5mqWoxvliUliXhWK8z3O/HP99kZjPV1f6T9NbJ6h+hXZRfXdIkbZyWvQ2Nu9MQY6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfzrGu3OVgdoBCivqdQHo2VvXf79HnawpOorvzwH/eva1NtGZ
	1up4jiewPHhrrCnT6WhC1E+aRykcFlykJ9PtlCnxL9UQMuDiseiZc6UAzJc1tJwAuchvDSXA7Ba
	LZnA3CO65Oove+SPZJCrMg+mdOgyr9LeInJhOQox5lhjpFeCrZmp4FsOi27R3Ju8=
X-Gm-Gg: ASbGncum6ikCKLSPppRQnX8DoQSDns3qbIRZ32QmYpyK9WwWVuY3s2uLYLbaD37vl3d
	RMzWqgY8BEYEKFqgmGskkLsYkLYx2pzoOHyZt1OXalENwcFx+0MV/6LCeXFfDR16EnkyjSCt2FE
	ancYY8bBYIleAP/eRl8vndKI63u9OpLxifs/eIidyyGDbP4gyJqgmKjGrvJiYp06xvkN1OSm/l7
	GKnqqenV39ZftTfM05yd6M+9pxoQYNfa7sw52U3efB6hq2FuZuTctiaBYj99mDWxHdTsDT+gyZk
	dAga91a2deKJk6xMjFMYZspAZq0JZYPMPVywsHTHzv3T
X-Received: by 2002:a05:6a00:188d:b0:730:8a0a:9f06 with SMTP id d2e1a72fcca58-7348be46522mr3841033b3a.16.1740559888156;
        Wed, 26 Feb 2025 00:51:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyOKbTj63fRQ3DOeiJ/Br05cS3kX5z5jN+WYxVkMhS0rQZSOJ82JrbY+gclE5cbOxV4EvLxA==
X-Received: by 2002:a05:6a00:188d:b0:730:8a0a:9f06 with SMTP id d2e1a72fcca58-7348be46522mr3840996b3a.16.1740559887775;
        Wed, 26 Feb 2025 00:51:27 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aeda7e84cc8sm2693368a12.25.2025.02.26.00.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 00:51:27 -0800 (PST)
Message-ID: <8e1df0dd-d92c-4355-888e-12d7568a083d@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 14:21:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
        lars@metafoo.de, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_skakitap@quicinc.com,
        neil.armstrong@linaro.org
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-4-jishnu.prakash@oss.qualcomm.com>
 <20250201113358.565de2e1@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250201113358.565de2e1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: agVF9qwaUmv-pKWs8TYUIr1n3_wu06QA
X-Proofpoint-GUID: agVF9qwaUmv-pKWs8TYUIr1n3_wu06QA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_01,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=607
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260070

Hi Jonathan,

On 2/1/2025 5:03 PM, Jonathan Cameron wrote:
> On Sat,  1 Feb 2025 00:02:40 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>
>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>> going through PBS(Programmable Boot Sequence) firmware through a single
>> register interface. This interface is implemented on SDAM (Shared
>> Direct Access Memory) peripherals on the master PMIC PMK8550 rather
>> than a dedicated ADC peripheral.
>>
>> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
>> channels and virtual channels (combination of ADC channel number and
>> PMIC SID number) per PMIC, to be used by clients of this device.
> 
> A few really minor comments inline given you are going to be doing a v6
> for the build errors Rob's bot found.  I guess this is racing
> with some other changes.
> 

I'll address all your comments in the next patch series.

Thanks,
Jishnu

>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---


