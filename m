Return-Path: <linux-kernel+bounces-523736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E676AA3DA82
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289083BC8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D11F6679;
	Thu, 20 Feb 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EnBk9UNn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B391F561B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056122; cv=none; b=F7qSxRFkyfOCGNxEz7tFTWVZe8cdd83DeVUKCmPPSk2wg1L9+yg7mpUtmF6jx3fSnXwp2GiDPT3AuCdM8ri40HOSpibmV90amSgtlOfIDoh3ED8fnRvbuxV+Bt0sr/aBmT0gLQ+zmiexYxcW5LMFvMSzqC/85wEP6h13Lye5nEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056122; c=relaxed/simple;
	bh=EbKQHVN6oqgGEPf9FAfCApk/KurNujl89PUvcnXOba4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SALY/eHiKRjR94rj/hUGd+FCPqAeLpFXDW39Rz0y1NHl/6wg8zwdsqLohVbbUxH3LRZIOkllssNdf8WDD1+H1Fl3695Kudk2eeSRbOOnI1ogIT+Zq2+H8IHbiDnJcq+oSKoO9b9iOOiwpqYmdsNjj5S5D3oCt+F2KaPk4W30Vb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EnBk9UNn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7XhR3031356
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GNhc2GfFkA5G5m28sQKj/yG3aqunIu5PTbHW/iVqw70=; b=EnBk9UNn4IcfPy8L
	UTg7XZRzk2Kfd8N05llR1kh5xrh41l580AwTl9OwC4+p+KxePAycVPS97hXnGYYh
	RHD955I5ju8P1f81JKUGLfGRJu5pDh2hcwZsAfyagj6izM305a6o/ZUdyIJx1NZV
	jf6sJcMN2zWu9877ksQ8ld5ywpTeodAzXYuDoRlEk7i6TYUhEQxYdGJdm2lhagWY
	ACCDcjH1XZkObzALJKElWN23jWEqZdC6/jP4663AEEdsgKDKbqDKvMT8TFGIpWom
	yXzEhplWZ+bIDAy5IA5J/yrPIXxV9APlsSVTsFv0ud6T546HIUzaBF1Jcc6JRvtx
	DuBGwg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy5e52h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:55:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7be6f20f0a4so19292685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056118; x=1740660918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNhc2GfFkA5G5m28sQKj/yG3aqunIu5PTbHW/iVqw70=;
        b=pj/HHK0jpo8mJ5UT+X/3hWWBVUmIhgBouBqFAGfzjFQej4/jDBi7/vInXT93KxImzH
         Ka+bmCMlCYrEv9QBWPoyWpYpGYhZqzn0QmM8s4relzXceyGlo0YdCgvpHAAcpL3G+QGA
         83TZjt3AGZ99Va0GwPma5wZu6rlIY3cXvwIySzA9wXRiDv/KdJjZ+U3fTTdugiDAIyle
         1zL2uKGkqaeZWwMgcIFKw14suQevp17SKYAd/ht68Fm2Lfvw5JCyAwx3wm1DLFRsXAWk
         VuBFftGl9bX4juP/SPe/tTbS4K4h2Bb24cGXeagn8gM1DKPYGEGaS9cuZ9Fyc2ij2IxB
         s4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWJPG1YbryqaBy/y92CUsnlw0V0DZkGNDMCJLGHPvRPEU5/tWhSYvhTfuxmyIkgr97BHYY8XPtE8fD4pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoO9IgYebUPMrmZcnh8RFmlj0Q3+YsA3g+RMrk5N3TLgycCbnR
	SOZ/tSwD2KUrhX73YBXKGNHCV+6yL7NFxh1rKVMzVatho/X1+Ug/XbI3gtufZ0xV0dM/fdNwtC+
	z5sUfKGvhsE6+CoJhUPRD/bzu9P0bDnOf2iUV8Xjf8NM8HI+PhR1vzoSpte1BDVY=
X-Gm-Gg: ASbGncu6f27cruv6gdwnQerwD2t2Lj9aNFkfC3jMxAtn3AO6FQI+bsKYXi72DaY7HPy
	xM+JCpROewe/ByCj5rdXhyqblZn6Dp6lGTV58Rx/YdErtOoocxiDh4hw6Gapsczi2cMBEitq2tY
	bzT3Rr4XZB9i91A5aLPFEYU/zYSAW2umR+glY7+ziDz2u8cUc5Y1kj68hJW+y5H76j0lBMYNw//
	XFgBRaBqvBEq1Q6P9ep3B9vSlcnxYqxaudGACOkOUFset3ysZ9IauGhs8EPYuCd1rqTT4X5+TPJ
	lXdAyO89ZD8o7tjX68NZRWTMKlrWVhz6wys8+2AZ1PYY7jScHnZFLkimgYE=
X-Received: by 2002:a05:620a:c43:b0:7c0:8786:d538 with SMTP id af79cd13be357-7c08aa79fb1mr1144491485a.14.1740056118415;
        Thu, 20 Feb 2025 04:55:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP6GaZrJbFArjMHLjuje1C+cb4fAwXFftytGq/49s+mRWX+kFjF6e1BU0c5BZw2Yh4URqaZQ==
X-Received: by 2002:a05:620a:c43:b0:7c0:8786:d538 with SMTP id af79cd13be357-7c08aa79fb1mr1144487985a.14.1740056117697;
        Thu, 20 Feb 2025 04:55:17 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2867a1sm11941017a12.66.2025.02.20.04.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 04:55:17 -0800 (PST)
Message-ID: <258bad12-38bc-48fb-8b74-9e87928b235c@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 13:55:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: x1e80100: Apply consistent critical
 thermal shutdown
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
 <20250219-x1e80100-thermal-fixes-v1-2-d110e44ac3f9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250219-x1e80100-thermal-fixes-v1-2-d110e44ac3f9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HIKa7jk0lNsCZVGbEmITX6DzE4KeeL0Y
X-Proofpoint-GUID: HIKa7jk0lNsCZVGbEmITX6DzE4KeeL0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200094

On 19.02.2025 12:36 PM, Stephan Gerhold wrote:
> The firmware configures the TSENS controller with a maximum temperature of
> 120°C. When reaching that temperature, the hardware automatically triggers
> a reset of the entire platform. Some of the thermal zones in x1e80100.dtsi
> use a critical trip point of 125°C. It's impossible to reach those.
> 
> It's preferable to shut down the system cleanly before reaching the
> hardware trip point. Make the critical temperature trip points consistent
> by setting all of them to 115°C and apply a consistent hysteresis.
> The ACPI tables also specify 115°C as critical shutdown temperature.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4e915987ff5b ("arm64: dts: qcom: x1e80100: Enable tsens and thermal zone nodes")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

