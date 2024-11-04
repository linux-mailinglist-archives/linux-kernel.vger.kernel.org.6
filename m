Return-Path: <linux-kernel+bounces-394970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7259C9BB6AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3429A280E6C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1E42AB1;
	Mon,  4 Nov 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SItzWc9U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC68BEE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728276; cv=none; b=bk6lPWGKcEjmEe7IaZyNOepyghdzIR3y9HHqDTIlP/EQmLe5Xr6AxlQAm/eR0BqX3BoNOFQucS9J4yoTX6DxgcmXOJRT01XC+aHjJiNHmOfiKVTrkVI69UNn+QjOZAPei8ME+9TycGm1ONc0vNlgkYH1fWup63SXIHpu0MW9/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728276; c=relaxed/simple;
	bh=yHsIXd5nkO+LMf5xN/UBFpUESu98mQJHpMkCwWTphDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxZRHD2yyO8DIAAPGs7pahdCgq8c79ouqKgwbK1lFvNQOpC6qpYLwDSZQJhlaXffA36Ywwuj882bm0YGiL3NhqUJHpZyQ9CaJ0FecQtCNIUMNxljTe8hb2WAaH0uDrh+yRIXxAL7c5QFKbJdyH+C+1L2El1beyTiHRaNH0C2SfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SItzWc9U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BtcH9000871
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 13:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+7hgCYK899f0FJbEY/vMXn0wJqm6OxSk7/yIGdwDuI=; b=SItzWc9U8yLNkDxI
	41AHDteGPUMg5kJiTHxOiwF52+0ODUyOkQD1EY3zzchBjfTNvm3HlF2sv9wwLks5
	xpz0TQ7MCPzm7igp+R4EMwQH6OTgXlyOKlnRenO2NbpGZjWAxTtCNGmbBURZfUXI
	W4AjIwPhLD+nZ7ioIO6DcwEMYBsYwxxVTURjICL9SHvilaEUrAzvnTi5yG58hI91
	Pdijc6SOJCoAZorwEyaODy+j1K+oZy1NlZNkwQoqdxl3xXypsQ6M3BrCpLEd9MSc
	k07aJyd+3x+KEvva60hsW8f5sJhcZlXPpac8aJox5Ob28w8IZ2r6Gep9h8ZuwBlz
	e2JCJw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42p5ye2hx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:51:13 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-71810cd2d0eso262483a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730728271; x=1731333071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+7hgCYK899f0FJbEY/vMXn0wJqm6OxSk7/yIGdwDuI=;
        b=ENS+O34QjEqesKpLE/Fa3y+N0XNH6O4fzi945ZsMsn9skrdD7MjVZV4Guih2rEn7Un
         yHt9QJB1hu3dIuHO9FZD+ani1yyr+0TFoVjQu0oQZTVN5cEJf1EgJCh1uzM5AwqblbrL
         oPbjPYJbdirLf2Dm9TJoe00/JUFgP+kjFXV/Z+n86I8+D5+w06ibtNxCAaEh7x5lwbDY
         A+zSi7hzJb7PVw+ZHLT3998JEFFTBg8JMGQ+sqGzJJnjXbv6EbcIvOCrQ/8Xe8HDamZa
         ScBswbE95uuW2B8kg1nP2mff4Gb5/CY0+kTb8eHvNfDvS4W5lXWCeXkb5D8A/6kRaWP5
         bJhg==
X-Forwarded-Encrypted: i=1; AJvYcCXrI0AlfdDiAZLiNA5rjA+OEHQ42ubEzlL+y8yyfNc4CJg+1k2S90E7Jnp72ixjiOqlmIcF5w2ckzQJ1pU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21y0dwk08uwh2wZXqdQ66vhJcSCdzg7SX7wZENDrFN2teQDff
	eSG6E99a8qXKO6JuTT65iuSxd5IwYdVwGwVCQYVfshwKP/FP7bhzEu8OoYYcfhdUVlJ++L4qogS
	OEO9fiGxlYigKvMZT0IP7idJyd62L8YYWKmqHqH0kb6hMC9j+10ewQYtVIFbf+YI=
X-Received: by 2002:a05:6808:2111:b0:3e6:49e0:f16b with SMTP id 5614622812f47-3e649e0fb7bmr6547836b6e.1.1730728271366;
        Mon, 04 Nov 2024 05:51:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4cnc3xqY8a6NcTMGPZ60dRJUOHzCgUzfXFzm9uWLTFW4bfNOfHKp4a3z7OM+82mgUNhac/Q==
X-Received: by 2002:a05:6808:2111:b0:3e6:49e0:f16b with SMTP id 5614622812f47-3e649e0fb7bmr6547824b6e.1.1730728270940;
        Mon, 04 Nov 2024 05:51:10 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564941f7sm554474766b.20.2024.11.04.05.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 05:51:09 -0800 (PST)
Message-ID: <91ea0f03-9bbe-491d-9056-ebd9fdc73bfa@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 14:51:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] arm64: dts: qcom: ipq5424: Add thermal zone nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-8-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241104124413.2012794-8-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gfg0DFa1u7Rv9jdJw6gXsyvwFkghrsr4
X-Proofpoint-GUID: gfg0DFa1u7Rv9jdJw6gXsyvwFkghrsr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=706
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040121

On 4.11.2024 1:44 PM, Manikanta Mylavarapu wrote:
> Add thermal zone nodes for sensors present in IPQ5424.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
[...]

> +
> +		cpu3-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 13>;
> +
> +			trips {
> +				cpu-critical {
> +					temperature = <120000>;
> +					hysteresis = <9000>;
> +					type = "critical";
> +				};
> +
> +				cpu-passive {
> +					temperature = <110000>;
> +					hysteresis = <9000>;
> +					type = "passive";

You have a passive trip point without passive polling

> +				};
> +			};
> +		};
> +
> +		wcss-tile2-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;

These are the defaults

> +			thermal-sensors = <&tsens 9>;
> +
> +			trips {
> +				wcss_tile2-critical {

Node names must not contain underscores

Konrad

