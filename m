Return-Path: <linux-kernel+bounces-443795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425A69EFBE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C8E16EA16
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A9E1C07FC;
	Thu, 12 Dec 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lZvVOaLQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB61C07EF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029694; cv=none; b=BrnSwHG8DkFX4krGw1c80B7S6bKw5irpu36trYF9jxaa+uuhutgueOjnz6CIBuo6pLgTTL1E5Q1q6e4kREhIuVWkEiFTt0lQ4iXKNSdE1ppInRGPf7b4sAYzVCEy2IcRoEPkArnovrM9h0e+xRk+3PemmonXzEt4AZ4l8AqjEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029694; c=relaxed/simple;
	bh=LrveoL8g/ujhNKvecgG+7pucC8BMTST7o+KrjrTSzdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7jWbSOLBtBUiUtj8CUZJV547dqrk93IX91N3Wks9e6HH95AkrhKv0vFStEIr0rGuY6zOxX7/G2JzCKgiHjtoDJaG/o9kUUE0if788m6o76laBMXpod6g4kGyw13MYYnY0qBxeMmLxg0Ah+VTxlgZnCVwqHVPaIPofr/IqtWlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lZvVOaLQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCHFe8h029009
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vXdNLBhBAmvQxWu8QcJvXLwwI1Ytu1PWcmsQsQacaT8=; b=lZvVOaLQVK1C4y/+
	daCiJvDoQeXevcdAuKXOX5hNmv2Ttk+czHDjnK4m2Hxm/hR0HbP5ulNCwCTfDgLE
	XssbN/uf38DhIMptYHAB0o1HAMm8WUJQB3A9xB6Tq5Voe2UkKKz/1TzHlE1UqRaX
	Ld+U1QIHhsWzETkZfc1C3uLlSrLAu0etuDDBc46MryK808tuTHY3XV7s7+niixqf
	BfFdfUpWVObC6hpkCY0ItIRtyExhOjyvd0qvBWo/2edHagDxEz/FG91mNdVrJpyO
	HgYxTlYwBBK3vtoJqgrxZbYU9vOXzPgeOVz74aT0y5yJlmO0NabEKoQfM0jxd9WL
	qwC3uA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd4xuy6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:54:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4679fb949e8so1183801cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029691; x=1734634491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXdNLBhBAmvQxWu8QcJvXLwwI1Ytu1PWcmsQsQacaT8=;
        b=LeVDfDD7nD8/lKzHcYGZxp7vIcWPGPakZN2QyT18RCQnBlthfow1AZPVtLzLeI4IV6
         u7SHoH+/QzcYXEl279MYYHn5hy2qHjCbRlSyNBz8zygN0wwssjRX9rJ0qWBAIsyi5PZ2
         mtKUdYLVwC7wMXKtL+UvDwMcPaWwy/3QJtojgHQY4l3WjLGQlDoVeA7bLT6J0fMrcgS9
         WrIbUbWjeVKXK+tRj3UIApuhlFX4f+0l7CWmO6IlmYxkwuwU21fVOhiIw9GyzRxBcfIB
         Oi5JeP4lAGrXaXf/sw22KmaiHxfHqDDmQuR8fQDtFRM03tK4MC92lXu6cI2b9J6vempJ
         hfqg==
X-Forwarded-Encrypted: i=1; AJvYcCWVlFL0tGlgkR6K7JqbqFRcfgdhTQ8wtlFuOksYKhUMk26rwS46yDO85rpZ7iOTUnHW64T8xOy3HEAWzh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvphWJO337zDtwBrNfywnHj3y24/lWGC7KDXvBzdPc5604Gnzh
	9dps5GTKQJdC+iS3qerCJPqLA3ZeU+T7XAzNQpmYUhE01Qzv3enMtdmOWclWLNVkHKnZ0gbVov9
	p3qg+PtyaF65oWBKKQzxTHtIPkQypkK52BHHxD/EIZgQze+Ix4XlfzGn0CbcqPiMQgIoXh9Y=
X-Gm-Gg: ASbGncsBHij/Lp3PlTAX+iCHMCzmvhrUX4jlFHLM36f+NVjgP7RqWpe2Xky3h+xpVqW
	OVearkDGS5A+OScxTHw5IPdf+ls182HZkac1jChjFu55mgxuTeODh6e+dZzaCr9ntfSWUC7XMkt
	kzqtbkmZeHBxGP9FQfyoeIM1mq0LAHE//4xI4/Ff4uvuWoCRBMc/ef0FRbYAhwm1238d5Mr3X6J
	e65+t5Kq7ksH+LxjABv9zuwuPj4rjzLFd5oE/KUu3EIFqzcZ9XpfkxaPhoZ1C4irPksjixaG+lf
	AN+wnE8IZLB2z3pZ+k6YSbUOBTxxMK02rCPJxg==
X-Received: by 2002:ac8:5748:0:b0:466:88ba:2026 with SMTP id d75a77b69052e-467a16def05mr8354031cf.14.1734029690922;
        Thu, 12 Dec 2024 10:54:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz4flDSEtbP7pii8hALbKnqKvgw0ujhil5TTckoyWmKpGS934NSSIKGQcUKXSeGCdYPL78ng==
X-Received: by 2002:ac8:5748:0:b0:466:88ba:2026 with SMTP id d75a77b69052e-467a16def05mr8353501cf.14.1734029689144;
        Thu, 12 Dec 2024 10:54:49 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3cda23bb7sm9120494a12.60.2024.12.12.10.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:54:48 -0800 (PST)
Message-ID: <d92eba50-2df8-474a-a91c-d5fbb3dc55e9@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:54:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/19] arm64: dts: qcom: x1e80100: Fix CDSP memory
 length
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa
 <abel.vesa@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
 <20241209-dts-qcom-cdsp-mpss-base-address-v2-14-d85a3bd5cced@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-14-d85a3bd5cced@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 01kwcjBfG9bFWdvWpP9vQjrYMOkbKD7d
X-Proofpoint-GUID: 01kwcjBfG9bFWdvWpP9vQjrYMOkbKD7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=834 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120136

On 9.12.2024 12:02 PM, Krzysztof Kozlowski wrote:
> The address space in CDSP PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
> copied from older DTS, but it does not look accurate at all.
> 
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.
> 
> Fixes: 5f2a9cd4b104 ("arm64: dts: qcom: x1e80100: Add ADSP/CDSP remoteproc nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

