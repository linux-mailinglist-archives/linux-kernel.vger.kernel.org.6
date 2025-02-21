Return-Path: <linux-kernel+bounces-526465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5BCA3FF00
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0D83BE9FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB45252916;
	Fri, 21 Feb 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oginvDNz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A72505D3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163366; cv=none; b=qlzkjigDt5VKdEe+OtRiQm8lrj/IrncBsntjgXLr6jjVtgaxQf+6Aj8/NsGY2wBcXLa9BRn+Ui504d6RVzn3WILNhGFmjh7knIj49V/YB1+Tmyi68gc9vget76COgrbzs1XmMAEyYzjRmqJZmCEHLdNYFUFd6cqAxYMjVWglK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163366; c=relaxed/simple;
	bh=jCTASy+FJp6zTUp8ZNj4ORjvLqlgaxRDC1k4+KLhKtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McVkIiHH+uFvjlYb5A7coBjP6rtKISoQEKZ+BrZatdOI6VhWzHb+OxuciuJyTMj0gGgWq3ueIfaJ6Jj50Tb/VAJQTwHpYUuwTD0L2Ax8Unt/DsjJ3iInki4EwDF4IT7dI2UTJRa90YQJP8khezfX33H8xegQYhUR52+owcHl1wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oginvDNz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LDwYuQ008449
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J8s8TG6f8PYCdNRO/k/pBQmK7AYr/yxFckrYhr81vi4=; b=oginvDNzfVdFmSF9
	aZepPb9iOLa2k+fetto+ZYdXFeySiSxGcDmf36sGtM5WkAuv2hDuj6KAm8knGNZg
	wvSZQqq6f0i/UpUfUFI5koOJFDfWE0Rz0V0HVLJz4jQW6ZmXjy+FPJGp8WHyactF
	gHiJYUMZv56XA68K2/QLrI5YukDjJOnLyr17enkRUFcG8/h6LgJAIQBN5r7R6hgF
	o/Om//uabYgAvbWq355cCBn8eP+5y3LXcxRcwJzowUpFkLDOgvCk6zbfYx5OIisG
	kiv21cOBi1S02aFvMowb5PxzQIRfgwEDLKG1SHZox1TFh1LC3hABmklpStzCvzK3
	ZCetWw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3k020-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:42:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e249d117b7so2410196d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740163362; x=1740768162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8s8TG6f8PYCdNRO/k/pBQmK7AYr/yxFckrYhr81vi4=;
        b=N5jeM1vF7PrGcZM3mbUofTVsfXTivDmXLAmEBBFFaKLb7t/VIrYElTMrDNBmlzLk8x
         4wj5AxU4f7VkPavzMxZspv72/TxNs8vRtxMrkqJD/WS3HjLc6dcgCrWeD0uJWbqPBwKx
         KflhpWY+2rRU63J4CnCRODA3uKp36oq2DKVc0nvgfkGQKPcwmUenTRcSWkt+ZGnK4Ps8
         watD1SgR+QoQTmlezXfyZ1zjMgVdB4sEhGIDCGdFS1pnH8vwzvYM3vOOVXSGb9TKw1nB
         ogwSF7iCoHbDSgL8JUT85uT7C3jf3HZiNLhjjssMKBcb3c24Q+UQBYeQvdLRCv62ivvP
         vkHg==
X-Forwarded-Encrypted: i=1; AJvYcCUvanfq/4il/M+rY9DR1UO6lprpHclOVrzQUESbFM6Sa4j6d0+nfi4cCOkXnNESgaPyB3qmm2fwZfiJmD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybUhjdQsJwErxwsTFfUHZWF/vNvOOL1WUyv23MpmHyPQzY+3qv
	ehYRp64HOXZQlI6fY6jUAFoB3yiwEY3kypCNBLGWsl5KTNsuKvLQz1D40s5Qf5Mz9+iBkScTMRi
	dSaVBu+9poN00Q7Fe09QGJjY+BIk0QJxS1L7Ao5wSGw6l0lymla4CHE7+O3h/rD8=
X-Gm-Gg: ASbGncugNvkcprdI6aFm2vPqsGIaKSNKGA5DlZ40Ct9Nx+NIrrncKEy1mkhruZ5zeeV
	sMeJbxkr5BARGtA1t4ROJKmCdmBbrXRykXczDW+akJk69IQkvG7XbM0GKSbnYCSo25rCwpjuxmo
	uvqM0XIWIMJis61Qe3AiKzV6H7YjbYn0I4t8QjloOIMeQX+XLmWhFVaasr22gjqFNmwnBcWT74L
	epZDlgVjGGyl+bkjJ3dTmSuyu1szBVAGvrrw6XISIbznKa/oUFtbO7VRgEtGiwYVH2e016FOBk9
	A9PQ4ju9dDHWNB20rvTEHIWkXUXw3BTDWmhpPSpcMKC1Y/9k7HBQSEAfeibDlb/qUZu6ww==
X-Received: by 2002:a05:6214:f27:b0:6d8:aa37:fe17 with SMTP id 6a1803df08f44-6e6ae82469cmr20927466d6.5.1740163362653;
        Fri, 21 Feb 2025 10:42:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTjUhOg4rL/3o4rvJi0r05P7QCrVkmHocIAnPserGG+U9PAvwDArPlWUEPfHJ5ND6VKVGR/A==
X-Received: by 2002:a05:6214:f27:b0:6d8:aa37:fe17 with SMTP id 6a1803df08f44-6e6ae82469cmr20927346d6.5.1740163362269;
        Fri, 21 Feb 2025 10:42:42 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbc9ff4fcdsm645841266b.87.2025.02.21.10.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:42:41 -0800 (PST)
Message-ID: <33d0c83e-2858-4308-b224-1c15080b438c@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 19:42:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/3] arm64: dts: qcom: sm8750-mtp: Enable modem
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250221-b4-sm8750-modem-v3-0-462dae7303c7@linaro.org>
 <20250221-b4-sm8750-modem-v3-2-462dae7303c7@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250221-b4-sm8750-modem-v3-2-462dae7303c7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Fq_CU9j8uizrqLJ7jgmYkBaoV9P3L0Ew
X-Proofpoint-GUID: Fq_CU9j8uizrqLJ7jgmYkBaoV9P3L0Ew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=662 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502210129

On 21.02.2025 5:33 PM, Krzysztof Kozlowski wrote:
> Enable the modem (MPSS) on MPT8750 board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

