Return-Path: <linux-kernel+bounces-526524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA8EA3FFCF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B7D7AB501
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA225332F;
	Fri, 21 Feb 2025 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YQpQh9W9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D11FBEB6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166585; cv=none; b=aUFwstpBgbRZ8rWYtuvXChkvWra+lWZjwnx8F4/3yTbIFbvfnPS9OBv93p4lxIhR5PxXwNno3mVbdJOBPdWkSnGzx/6uavNmFGW+9VLXsyKnmRBpZM/xmHwmT1N3QXtpdtUlvzh9Ox1g7nQAq6lAUX7SheuiAa2zx6SAzjD8nIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166585; c=relaxed/simple;
	bh=VdVB66hDBVl67iJZF4nTcE2r+EuL30FAH17OtiXtIuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEA0pJvkwzEC8vVr6op4bMduRCzDwK7Z70SOxZMwvaykIsWzct/e9WTI31BmDs4X665zCiF/lYcwTjluO8oFqwhoZJA1yn3KiOkCErjpbZoHo900fmqoBXUaEW4bM1Pb9UhKc5oOydSpy6iL0B9pjEWYZjdwCrMYtUhO+UYWdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YQpQh9W9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCkS9u015159
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t/mr4PrVDIwwXluXNP4v+QFnjZOHgARzFxn4mteVQJs=; b=YQpQh9W9ywDIA+sd
	+GCwycqtoDpJHNINB3/+UBnaI7f0wUQWoKbTThCqCqJwnfr9VRWnZG5l6bn5zSKp
	m4UB/nOsf/qhb9+R6thvypEvA6J0fZcOFPk8lY8VgCD4SVSbdHDedHPg5n1+tYKp
	iQ4769O+DT0GyIxWws/GMQJCm5euPMuQeyBe2SpFakmWgMQeEoAEVLZjy12Vxl26
	cX5d/uRRsnMH6lnbslXLXeuwgIszO+xFsuvHI8ObjgMqGgVmiEZqt0ScCUYmB3rY
	LrsG+hN2TemAWAptE84nNIzZ9s2HkSBF/lc5HD0KmKeIiwgkJUmFyrQxlv1qgfyZ
	r2RxLA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy4k3ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:36:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c09d598014so25006085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740166582; x=1740771382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/mr4PrVDIwwXluXNP4v+QFnjZOHgARzFxn4mteVQJs=;
        b=RQqi/EfPmBRE8TU7OXIuhYskGrgIbXtzb05yLHsrAo2vVtHCH8/F5ELHmaI+mtK5ue
         RfoR1pjNSIn7YHu9BX1F5cB/IbfmcaJJfQ8kRIBFjGflsjPI0ftSzgEfiww5IF4jepZT
         673Lj0KbsBY2wqNjAoj2ydfrjN82+fuxYhTAO/i6/ZidU5QrpYgtCM4VcTZ1JrCcMEqm
         qbCx0a9CHb2eKIGTmnHwRYBnLrp5XU03Im6WMgygsyn0JKtTyZksYxVXiqa7wvVZhNAo
         ajbFByUq7QJFh6o1r4TLF4MzyQDBWOEu7FsmLKUIhalzNZL1AKuv0CE29Vsk5cJk9E/F
         u9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWtPrtxhJa1r16TAxG7Ib9hIIbWNI3XiCRIeG5QMs33P4XQBXvrR7dT3r9oVgDLh76v52KhffV71uqhTX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/6gLSTFQ9gzRo5TouocUcD5RO+H2mu6gI70ACKnDrZhF6tNy
	ycIsZq0Qrkm3BLil30sRY+OeWUafRU11GiuqymZbwGWyO8aU8mwTcoK5tw8PkXrD17NI3/CVj0x
	jfk7s7gBaZ0KspEhciY3FJgqAol77b1TLAYKiXz+0zXrQhFimdI+TY5QklOLxNRM=
X-Gm-Gg: ASbGnctkJK5/QRziL8x8Kg1/HZiqfKqHWSUN4pIQHD+YIo83xIs0u1f1UD24Yw2WlYR
	hn2q9B0/lCYT+HcJEI4NhDD1av9Vk8XFbt/UTqP+hP01j0Gli57d8/DoE53F3Mni3ui0WSUsV3m
	OlzmtXyvDvt+pvYsZzCnvU7pRXSAczLqu9j6wySb7wH4nfFk/5+PNwdtm2i9WLg0Xk2MUh0x3Qe
	SMET3grN0WTKOpY7PNncR554TaAAOeVbdtKekJ2bFXs8BUzbWl2uv21M5RdRa4N3ta1JaIZMqzP
	SlPOO5nIyZ6ogqvK6J2aulGgQGHFoMVMLVKtvD+h7sV6KT3NZrhTvhAvY44pOmFIXTycZA==
X-Received: by 2002:a05:620a:40ca:b0:7b6:6765:4ca2 with SMTP id af79cd13be357-7c0cef6ad7bmr217822285a.13.1740166582010;
        Fri, 21 Feb 2025 11:36:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd/4DtfPr0jE9DaR2jk57xEV8y1kgd7y2k/1F7JT8h+H/Av4iI+Oo66hZKuS77D8BU7ErgiQ==
X-Received: by 2002:a05:620a:40ca:b0:7b6:6765:4ca2 with SMTP id af79cd13be357-7c0cef6ad7bmr217820385a.13.1740166581641;
        Fri, 21 Feb 2025 11:36:21 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c4483sm14185416a12.25.2025.02.21.11.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:36:20 -0800 (PST)
Message-ID: <b090ac56-e90f-48d5-8d74-fd673adebea2@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 20:36:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: x1e80100: Drop unused passive
 thermal trip points for CPU
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250219-x1e80100-thermal-fixes-v1-0-d110e44ac3f9@linaro.org>
 <20250219-x1e80100-thermal-fixes-v1-4-d110e44ac3f9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250219-x1e80100-thermal-fixes-v1-4-d110e44ac3f9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _4e2Mv-E7xJpx21afWOUuhD8Db-RC6ze
X-Proofpoint-ORIG-GUID: _4e2Mv-E7xJpx21afWOUuhD8Db-RC6ze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=953 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210134

On 19.02.2025 12:36 PM, Stephan Gerhold wrote:
> There are currently two passive trip points defined for the CPU, but no
> cooling devices are attached to the thermal zones. We don't have support
> for cpufreq upstream yet, but actually this is redundant anyway because the
> CPU is throttled automatically when reaching high temperatures.
> 
> Drop the passive trip points and keep just the critical shutdown as safety
> measure in case the throttling fails.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

