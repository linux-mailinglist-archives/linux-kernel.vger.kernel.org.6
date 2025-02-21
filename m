Return-Path: <linux-kernel+bounces-526485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C794AA3FF48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D20188896F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FB81EE006;
	Fri, 21 Feb 2025 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QmkvTkO4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39371250C1F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164614; cv=none; b=C2h44QdnWO1lNzjqT4ByYFg8T/6bZDA363qN8aRXfscQ5RilUEb5Hnbm0jTDwc41WwUDoRMVJPZoXtrE7FB88rK1P0QDxPnc/dDnXvg0Xg3mU3ofk9bNxj7MGiufA5Oii8KwRZxh3Cw3vCAyON/eTJS5WzXjJ0Bs1TVmF5pr8SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164614; c=relaxed/simple;
	bh=HqPF4+t0U3+VICuHr2MMMkWIevGm+5cDUFST1b+1S6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7XbGICBZgGhR3SmvkIsTEoSQWfqScqyFNM7DuXikiidt/fyEQ9LyBzrBMjfXHjXPcr2lSMod8CdE0HBG0hYu+gJA0mU4mUKak2CAIQCtEhpgQ0mEHK26UdHpyAyJCe9cWXWs83WFAsIP0WkTOef5KVmuRR3BkZzWLrZETdSVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QmkvTkO4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LINOb5026008
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	874MfgMIlUvgyTuHZ9EhHcv3WgxH2uNjqVh1gBPjDWI=; b=QmkvTkO4FpTd9bqv
	2gOY+mSY5cOmDVOwaQ4AsSnSqyHbNyHZZBtUt1lvsbHP/XrFMFKMsue57y0p7FXH
	/pVPUe88UpICfYGQiP6p3mCuQUyou9rxNFpxrmUmLekrhBAPfHRZA1iQIajKlaBe
	oRyuo59kD5+ERG6Lf8CDs4tC5v04MUV3Fs7CynnPFdCGRzlV5UUE1cV9ArFSwm0i
	g9MOXTvG17UrBCxnau/awN10inZjFrt2Gq6sTdy1sLSPgyszkWQpW6YDe59ZfXUV
	6Sn/clhMlXh1t9t2NmehzJSfXJEqMfJZs/PZ35n0McThNYLAWSnHxHiqkkwArIZr
	d0OEKg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44x2r3w6c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:03:32 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e422f1ceadso4557586d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164611; x=1740769411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=874MfgMIlUvgyTuHZ9EhHcv3WgxH2uNjqVh1gBPjDWI=;
        b=KLWHCcTYFvDBWn9y/dxyNqR44eiSt+GK+/Gb3ioKS/I7kdV+Nyuh57V+E+Pa3Ruimc
         JAgDeNJMFKPkTnyaVTGuiut8d8Qaj7Lgjre/r3ATJBex07RFyQ+KFLRWjMz8e+/1d9iY
         d95robGDYdUQaVITeEVI4TCAVsrdfgl5c2hgytP/NN+D3qM3mL3uscRtDrTb8KHN6K97
         iMyrgdp9XdHS54vFoatM4iRdU5lf5EYrqbPCqX5eCHM7fZfuGbwHpqLjPXJOXHnoR+iJ
         mweAgWsqJKEYAzB4sYxdiPyZ7s5t54c4tNlgsT4X85MZZm9POoyImCtUm+6Wz/xOR9d6
         2e8w==
X-Forwarded-Encrypted: i=1; AJvYcCUmevxIEFgrolEYLIc6G3Bd6/k/nZk6URR0iQtESt2ORoQ/zfuVHnbjSAy1w0uS/MV/2nrXwS2iBwpnYqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfqcarDIfJ8bYmpd8CwdoWnkKblVJUoJ/Ua1obHSpVF2B0rEX
	dZf2Fu2VQVuY6i4ZieaPBq+RGrn5L45kK6mizm/I/k0w4vDIx41w+2Sz0I8LvigzqsqL3ZbLmLJ
	S/t7tk8+u/20ghigGlhi8/4rVQ6wYi350h/aiZijm/bY8d0Joknp0tDzJTxN/aOY=
X-Gm-Gg: ASbGncu/hnCs8NJCHwB4UPKDhEIteDIeEIQY+HBY8vtFocm9WkGPWhA2YnbgljE7dBQ
	jrQ+ZiTHNL/VGYqXRa3bMs3TUOp9ZVNf1aicSThYvEVcwGd9FoF+JtpGJmcHZVA8U/L0yirgvlp
	tk/WrZWlivXmJdrjEQ9jPF1RTwRkb9APfiUTXpJqEK54a4Qwl3Ui9rSuNuR/YWkFIM5J10qk1tU
	OvvDGGB/ELgaIZBTWcEa/mYCzoyNdh1B1XGQbGlQ2+TSv4N+ewLtgNRFq+0whJM2zBTVjazsmHW
	gwOtDvoRPxeffwFMsvVZrPmjFo0GU5hIOifqDAjlKjk0KTJUWefbFr/j81H3mx9dml50ZA==
X-Received: by 2002:a05:6214:4005:b0:6e4:4f27:7754 with SMTP id 6a1803df08f44-6e6ae8019b7mr19814746d6.4.1740164611167;
        Fri, 21 Feb 2025 11:03:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSAKEMe6WySvB0jR3beWBB9DVJckgwZ0pCEh51Yko1mA5B0fTJzLtYCqsZejAHtIgYg0qOuA==
X-Received: by 2002:a05:6214:4005:b0:6e4:4f27:7754 with SMTP id 6a1803df08f44-6e6ae8019b7mr19814516d6.4.1740164610746;
        Fri, 21 Feb 2025 11:03:30 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9da9f0desm1009014566b.105.2025.02.21.11.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:03:30 -0800 (PST)
Message-ID: <e03f3e0b-5e1b-41e0-a42a-5cae0becf7c7@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 20:03:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 3/4] arm64: dts: qcom: x1e80100-t14s: Describe
 the Parade PS8830 retimers
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-0-380a3e0e7edc@linaro.org>
 <20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-3-380a3e0e7edc@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-3-380a3e0e7edc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0ep9B5nGJZO59VjqQYLIvd2CdMpODl3m
X-Proofpoint-GUID: 0ep9B5nGJZO59VjqQYLIvd2CdMpODl3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 phishscore=0 mlxlogscore=973 suspectscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502210131

On 20.02.2025 6:42 PM, Abel Vesa wrote:
> The Lenovo ThinkPad T14s Gen6 laptop comes with 3 Parade PS8830 retimers,
> one for each Type-C port. These handle the orientation and altmode
> switching and are controlled over I2C. In the connection chain, they sit
> between the USB/DisplayPort combo PHY and the Type-C connector.
> 
> Describe the retimers and all gpio controlled voltage regulators used by
> each retimer. Also, modify the pmic glink graph to include the retimers in
> between the SuperSpeed/Sideband in endpoints and the QMP PHY out
> endpoints.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

