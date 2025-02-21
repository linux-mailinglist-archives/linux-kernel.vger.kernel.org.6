Return-Path: <linux-kernel+bounces-526520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813EBA3FFC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D678217AEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D61FF1A9;
	Fri, 21 Feb 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mhclx1gV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342001D5AA7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166456; cv=none; b=d036KrM947d6dGv3vYqpLMUXYFltTew8LnYOQFLMILgJLvTomO549TX7kthpkYhy+i8P43YiEn2qTookS6IlbebtnU6hLL/hJNkD2IstiI8oftVwejG7ZwTZnlZwqSBQt/P0L0U096j75fY8JfDQwp9N3VMCHjrV1M0MmpOH9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166456; c=relaxed/simple;
	bh=u6TaScNZ/DU4r4jwpXk2osYnJ17lzPB8FM3VjxjHDuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6LSNTqPQo95Zffp7Z/5vcjXUFOtjWhQZ9+wyp1ZUBqLZjpQBNro4ASj11cFCT11rsYo+U3uXiP/ZL8B0EGYSvRC9z/h1hwdJN4zdcJvFPJ6mpXAseCQ8734IQgXKd9a9BSLOaFub1OThs0A8J5ZN8GKRNKYT7gLs2YEG5On18M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mhclx1gV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LDhO0M018511
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pHtrFdX4sDiVFBmCYWlwT5oKJhWKWB+bSduK5G48vLE=; b=Mhclx1gVMAt/xjj2
	/2YSTJcRCyjP6bRzINGYRfjwmDsZcFyqmM8IHxMCaZq+LlibMpDTJlbQIyCm4RPy
	NUqKwQoQCLjr/DKSHKIYxAWMWM9p2OCMwsoWbwbtZ34mKtHvRjcMTIlPFNMxupvy
	bFPKSBx3YD96vLB7n0MdXfBtGYGnspIviVEWjSaMNUE/braRdnrne0Q4JBpBV51L
	NZEb9dWAijWzvX1htHCOIt3CSptBQuuWtACLHUs3AEtuIE9PEZP64w1BIO94soa0
	QwzF0L1itJvA8jVkZ70siueiHa3cG9oJAGKK5+T2Ls+NQPFTkPj+uLdLE3Oc9yRK
	Z4qjCQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44xm3rjbfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:34:12 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e1b2251f36so4150536d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740166452; x=1740771252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHtrFdX4sDiVFBmCYWlwT5oKJhWKWB+bSduK5G48vLE=;
        b=UTOFdBoLBqhdw67SHZ4bpEnrE5X7TozEj79KU8MbQdrT300ZsWTkuUry63Sfy2+rY+
         LfmS4tC6soeDdhG/wPbTCCRsw0MwszsOk2EJ1oXbV9rjVNrQ5zVYUpNDqzidIiGUCkme
         Zn3ccwrqoAjhHO6jqJWR+ZYtrwENyVo7SzQwvwZ6CSbuh9/UELbGP5dEhbk9x3rSU8QX
         +KmWtcbMCPCODN2CLIu8jCBZP0rdK2w9UJ/QfK+cQk/T//njpPbi2lyAS5LdGDFQ2cs+
         W23Wavf/s5mEQgrHFOlZRGwpJuoPJIGq+of6h0j/XkrlVbSpzI5tJzTMxAbUqEKWnwzD
         AjLA==
X-Forwarded-Encrypted: i=1; AJvYcCXf/VwAzYbx619x8R+uNIU71wtDJYwOjhJZz/O94krfOZKCPRB1UbAvxP6c4iXnQe2Xzpl768RO4D15JeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5KouEoVU1k1URmPoM7yqBWk72YV2WTZw4RSTizw4YapTMBlQT
	306FRgf9ZJQIVnFqsIuVqTBV/95ZGCueY+2WxHuO0dO33ytUU4FZxD+jiVhVaC+p5Oq+/96m+yy
	M4/27AHY7fD8oA9Xkz6VpF2V7LwcBxuDvEQvSM9S+YbZuqKcK9eJJk7TkiTf7Q2Q=
X-Gm-Gg: ASbGncv2pF5RzIFqV1iyhiDrFG7G+8EMe9UlFZ8NUnIJ0DUyh8lvGP8w8aFBP5Xl8ZI
	zWACSCtHRjumzke7afgtQzBeVjsUToUE5ISNLjLNbfLICnqEDkcHM+deMt6l5ajgnlP8qOKs1tT
	YIsUvUVmwD+J/dSJMdlyROeD+U9UHgGxWLnkDeKUXDoA9EohUHwNrHw2NQ0x5ViMw4BJZmdS88n
	sNhLSmbPr3M9HS2/o5Ap5xVLbxNpv/7AuRQYD7g9hRwLajmaJw+xbCtIsj7ANNtWV9QSG3Gg5Eu
	iTi5CveLkg/+9+acSM6H3NysP+q7WnUdNoOhk+a5ekGLTNMdVeQOO/NsydW1BHcqSBjLdA==
X-Received: by 2002:a05:6214:4005:b0:6e4:4f27:7754 with SMTP id 6a1803df08f44-6e6ae8019b7mr20340956d6.4.1740166451805;
        Fri, 21 Feb 2025 11:34:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMRtFP8L9pwSmUTIIxeADi+goeh9v8A2IJATffBawES3MorlO92k2n4DJ2B9zsNBuYEj7soA==
X-Received: by 2002:a05:6214:4005:b0:6e4:4f27:7754 with SMTP id 6a1803df08f44-6e6ae8019b7mr20340816d6.4.1740166451399;
        Fri, 21 Feb 2025 11:34:11 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb93874686sm1091861166b.0.2025.02.21.11.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:34:10 -0800 (PST)
Message-ID: <9d330824-58b4-4c19-b778-9b000eb4d20a@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 20:34:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: rgb: leds-qcom-lpg: Fix pwm resolution for Hi-Res
 PWMs
To: Abel Vesa <abel.vesa@linaro.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Cc: Kamal Wadhwa <quic_kamalw@quicinc.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2yhdKrPm0YCBYhEod6b0XhU080J6icaZ
X-Proofpoint-GUID: 2yhdKrPm0YCBYhEod6b0XhU080J6icaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=884 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210134

On 20.02.2025 11:31 AM, Abel Vesa wrote:
> Currently, for the high resolution PWMs, the resolution, clock,
> pre-divider and exponent are being selected based on period. Basically,
> the implementation loops over each one of these and tries to find the
> closest (higher) period based on the following formula:
> 
>                           period * refclk
> prediv_exp = log2 -------------------------------------
>                     NSEC_PER_SEC * pre_div * resolution
> 
> Since the resolution is power of 2, the actual period resulting is
> usually higher than what the resolution allows. That's why the duty
> cycle requested needs to be capped to the maximum value allowed by the
> resolution (known as PWM size).
> 
> Here is an example of how this can happen:
> 
> For a requested period of 5000000, the best clock is 19.2MHz, the best
> prediv is 5, the best exponent is 6 and the best resolution is 256.
> 
> Then, the pwm value is determined based on requested period and duty
> cycle, best prediv, best exponent and best clock, using the following
> formula:
> 
>                             duty * refclk
> pwm_value = ----------------------------------------------
>                 NSEC_PER_SEC * prediv * (1 << prediv_exp)
> 
> So in this specific scenario:
> 
> (5000000 * 19200000) / (1000000000 * 5 * (1 << 64)) = 300
> 
> With a resolution of 8 bits, this pwm value obviously goes over.
> 
> Therefore, the max pwm value allowed needs to be 255.
> 
> If not, the PMIC internal logic will only value that is under the set PWM
> size, resulting in a wrapped around PWM value.
> 
> This has been observed on Lenovo Thinkpad T14s Gen6 (LCD panel version)
> which uses one of the PMK8550 to control the LCD backlight.
> 
> Fix the value of the PWM by capping to a max based on the chosen
> resolution (PWM size).
> 
> Cc: stable@vger.kernel.org    # 6.4
> Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Maybe Anjelique would know better, but the computer tells me PMK8550 has
a 1*4*(not 15)-bit PWM controller.. I don't know if it's related, but
something to keep in mind

Konrad

