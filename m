Return-Path: <linux-kernel+bounces-531425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEFFA4405B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F24D3B9938
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABD82690D9;
	Tue, 25 Feb 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q7QgPDQg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F38268C40
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489083; cv=none; b=BuJSw8cngGM+7sFKJT7HmSZFwSKFkhv37beLIgf2R9l5ved98p3GEKNF+HN1EDmAxFCPjJqy5AgjRQ8UCBgaq8sviJZzeHLAzNB+fsb2I400jbFhdFymIqMtXQzrQOyCu24vXIdW3se6nFejJ4ffgcK4cS1szhq4o1EhdCZhSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489083; c=relaxed/simple;
	bh=7FuRH89tDCOSNH1jKBMPZKH3DWaM3tBKPCcUh0VE6As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uemScaBpUU2v8HzF06MqjXgqVP/4bdXjYaVgH3ltCVIyZMFCJQfAEkOsZ7ydMLqH8+QtHVmlSzRroP2L/JTFAOJ+hfo+pFi9EkGg6ImPPSR+ueIVE5Z7uKDGXRi1PYb/b70yTKlKmFt24pwodFZul7FUOPk2reTmKazcCjZBBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q7QgPDQg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8TFRX002205
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uuwVfqXUmGXRoU+kSMckG71FjFzg8qfTg24k4ONKjKE=; b=Q7QgPDQgDt0t1CeK
	ncM6P5dXSfVXjSbuTvW5j326SSv+P5RtKcgmfvrWC7mlW+rNYU8oiZMqIhyzCQ1b
	S57rKzVVpRE9S6vUu/vufoSH9/1ar7WOjCP1r87uhhMFOAACB6vm51/Sxdxfzbgn
	S6gE6GjCeacByhW8T85L1FsMHwBadCeruDJMirLF0IseQAzcXpAdqRMnZBXpaaKT
	tSS612lp898nrWFnjLMlIpqKLWvnuJsvNgzait4f4KDVJr/6nbcAnl2rgtTENaJe
	SfcME86DQwJ3qsND+ywAmeutEH8InBpkfZ2uhkNUbRR5kmXwsPONCfhDMq6IWAYQ
	f51syg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7rk0rxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:11:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-471f5a13ba5so6557611cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489079; x=1741093879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuwVfqXUmGXRoU+kSMckG71FjFzg8qfTg24k4ONKjKE=;
        b=JH493MBwogm2bNeQnxHG+uXNIwQFWuYhXTj8D0jjJpx0Z0K18KbPrgfoUWVuTI+Arl
         ijd6o5S2pOpTBwmfXXtwn1eDArAyToY9T9xZ6w13GJ2fwN+C/E2sFF3Sf0fDjh9amN/J
         1VoeX6E2pYM/484CN2pfZidol+LnmIQbGSf+hqmeCMNoQCFUJBuwKc6XVE3O4IDWsIR0
         crlRfoRX2rrIESuJGtGifOBC9X5biRHqZ0aLFCqBv+xVHSfdBKdm9dq8Uae24NYy8s8Z
         54p8dqPivNQz10bnI8Xi6nCY66XipHBkBGJd4KdC17Qgb8qwQTeJj7lW4gkkw62MA/9b
         QJLw==
X-Forwarded-Encrypted: i=1; AJvYcCVPtvYn9RCbXKGjcJ2hsZQCindskz4ypta5E2EbrTFTyskLf9entQgxPISlKWriOq4zF1GSeeUPpBjQiRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWN0/QOoBXob9A04+Jb2F2zXRHYo+3JQ20NN4tWn+oX5sGatb
	BjNAXD+t7RRAhk4DSTFnJorvZ2XlSy6O8JMRdzeRNViVvEcXipCJ/uXPNEn0XAQZR1B1opnzXub
	WiMySAcNR5KDmMsjsiyjJGkdWTXQnNh+7UVLEjGi36qKSQBz7Xbc4by1cesEN1vA=
X-Gm-Gg: ASbGncsXv9b3OQS0m6McpRQIXMV8RTs1FBlfRl8qwvnFqJgpXc8o5Sfvy5TBm9u9B0m
	RB7s93On/VLc4HCxOXh1YOllf1TtljcO3kw+66kO/rBMKpt/b3N7p7PcudYQrRsaeBYAJHxyWHL
	D6XEf3uPDFpSqFsASBbjsuT+69g3B0f6lVsVqLuZVbgkoGcRsi8Kc3A7LycQkZAwmgkeGy69bKN
	6XER8vTBKQOK+w4EanmIIk/Jg85xZ+WF13fIxMTfTzAoCb5bAYG59O1xQFQxoMf/2mC2vcPT5OI
	gxEvTDvFQ5jCXHlDMEVRXQV1IfeBVQAD9AKtK/IR1JSMB3/NYuRgvMlYxOPOBuHvQNoZyw==
X-Received: by 2002:ac8:5a43:0:b0:472:14b8:ee01 with SMTP id d75a77b69052e-472228d7e30mr71677941cf.6.1740489079613;
        Tue, 25 Feb 2025 05:11:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErDUxqjVZVeKivo2X+WzYQGTk3m9wBnXFgnKFF8mPGrQ+En9HUm/GLFcoa+lNQennqXJ70qw==
X-Received: by 2002:ac8:5a43:0:b0:472:14b8:ee01 with SMTP id d75a77b69052e-472228d7e30mr71677541cf.6.1740489079098;
        Tue, 25 Feb 2025 05:11:19 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abee36dddecsm37813166b.61.2025.02.25.05.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:11:18 -0800 (PST)
Message-ID: <3b91b340-2d01-4685-bb73-818924c4ec29@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 14:11:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] arm64: dts: qcom: sa8775p-ride: enable Display
 serial interface
To: Ayushi Makhija <quic_amakhija@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: robdclark@gmail.com, dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_jesszhan@quicinc.com
References: <20250225121824.3869719-1-quic_amakhija@quicinc.com>
 <20250225121824.3869719-9-quic_amakhija@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250225121824.3869719-9-quic_amakhija@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bEUkqdStsDFgUBW4PtlqWpZTG-TJ7hva
X-Proofpoint-ORIG-GUID: bEUkqdStsDFgUBW4PtlqWpZTG-TJ7hva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250091

On 25.02.2025 1:18 PM, Ayushi Makhija wrote:
> Enable both DSI to DP bridge ports on SA8775P Ride plaftrom.
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 66 +++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> index 151f66512303..02d8a9c2c909 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> @@ -128,6 +128,30 @@ dp1_connector_in: endpoint {
>  			};
>  		};
>  	};
> +
> +	dsi0-connector {
> +		compatible = "dp-connector";
> +		label = "DSI0";

DP0

> +		type = "full-size";
> +
> +		port {
> +			dsi0_connector_in: endpoint {
> +				remote-endpoint = <&anx7625_1_out>;
> +			};
> +		};
> +	};
> +
> +	dsi1-connector {
> +		compatible = "dp-connector";
> +		label = "DSI1";

DP1

Konrad

