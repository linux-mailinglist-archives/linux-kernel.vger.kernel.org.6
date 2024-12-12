Return-Path: <linux-kernel+bounces-444081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCF09F0087
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093AE16B8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5B21DED7C;
	Thu, 12 Dec 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lHiQWMcv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D21DE8AD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734047536; cv=none; b=tkS3RnggAjNnSu0ryMweKqM+AAmlDr3+ttyrvvFqzQc6lxugSQQljB1QZLjQlF4LOAsqZBWrhrCkCI2H6hOMV98JXtft5FLftB76OG+gl2/b7BhcMQMlrRDa8TJJwFfG9l7dBtj0k8T6f7ya4Hp6Y73iEgp3LIpgyV2GZTkBilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734047536; c=relaxed/simple;
	bh=LNdi9+i3sapDxIkqiQa3mSnf4oo9sf/hIcFfrsHH0nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHoByJc+71qZBBLA6q84uIMRTtYQHHWlHM0QNspkFoy/mJY9QH+RJaAtlQuKzgKXnEfEfP3CRnS9JLlYGahpxSjRRpewu+jeibo1w01yfgNCZlTcLyKnL8MS/Z1uHGcJqBIQFC2a0htncKmcWAcaUnuDV0WEmEiaTQQqC7e/aHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lHiQWMcv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGsSgW029986
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AGkFlJEX4RVezVmwonvqY/5h6OHh5UjyAW4O3g0xR9o=; b=lHiQWMcvi19wSwkX
	CviO6mVqJkMVEZ+OVEOWFawKNaDgiMQYe6HnBe9ykrzLf7Pv5S73kWejXUKeudz2
	gwzkw3sVikdvC4Og+s3lV+6455cNAVTkNgAqG3zi9KX8h8hV8H0U3wKWQapAaWrI
	CwKWB6D99v+0uGoPBeKJs+Up0WmZe2GnQTKwjzpSJRuRoCMMTAQvk/yow6YJDm3d
	IPmS7ThIhstvttNFgTrYMsL9Vu2kEQTlkBtCPjB42tGKWk4/kibCcpgrbVUMK/6Z
	ByW8z24VG0jw3n5T+FFKSaBRfX7gMGD3M9RVlvY+7gu7Fd1bBsoO8jUw42AU6YR4
	IcbcNg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw4cx0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:52:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46745a07381so2197761cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734047532; x=1734652332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGkFlJEX4RVezVmwonvqY/5h6OHh5UjyAW4O3g0xR9o=;
        b=DCSXAlezpe8h0FWcDUTeOA/nm20GfGs+U02CJ/rrToK3BF8atZRpME39wChqouZ1vE
         VJ+RbyaOCdfCTJMue2o5+Q5NuFQuRtsGuaQgnD6D826IuqpiaP5jbG2zKxDci51adhZo
         1xgbSsdKNMJaRRo9+lY8Bb16tfEjbeNN0DFx1qyHpvwllr9gcGNe1gPy4A1VjyT8Va45
         nnV+OcFyUjVI/c5kMr1Ax+jW3EZ7czZbKJMxOJHIFmi6WJgoWMIGk8Hk8i7Rj/muOcnB
         sEg7EaA0s6C1q6pJq81eMqP3HTFWWB17F1zEyYeKuMs6fgpppo0blyMhxxYYPA+6I6KJ
         i89Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsIcu76CSGUtHoFYzouRx2T60KLpejT5kRZfc/rYyqBx6JrUbyKH3z8QPx7SQd7e09zHef9KfNTZepr3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLROCGdHngfkKzUwxqddV5dGAW2TAVHW7Ec5L5Z6tEbLxfate
	hnINu5GXCCac/5gwFlV3IwcXCJDDDqU6oO7x0EaDx8ymDVc00tJKB++PTaGJtTm7u0ReGg0c1fs
	W/ooc5G0en0us1ZvL0Bjz3o/qLyz+uEqRPNBw/FrLKlER0rqsgII9EtZZ88YuAyA=
X-Gm-Gg: ASbGncu85UL8KaeJiK4cNJwZNUh8Lo5KS+vcv5/dyy6+i9EL8rsqUBPdZ/jY4v16TSA
	Ylh2URYOgu43+E9Iv9uHAq5k2FNF5xHdODhGM1/+RZtRZf0anD27LPXRiii0BfFPwmynym58EUI
	/+rEoq0v8wBh6U2msiilSWnno0NseAf/aE5EKBNz6m+XSMyFbQl848zrhakqv62MAHW+iwpNXUk
	4WCP38c1H2uDC4nWcCPz0KCufMAqLxuF0TF7h6o7GHzx0O2wLmyb9oLLiW+zOPWMJBdwjmGhEzT
	CYQRoVsyQJqFV3U907mZDXqXFejRDf9WMGWk
X-Received: by 2002:ac8:5dd4:0:b0:463:2d8:180e with SMTP id d75a77b69052e-467a57f681amr3135911cf.12.1734047532266;
        Thu, 12 Dec 2024 15:52:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7HuJwENknc2LAHEFffGTChVf36Oo4sGXXPRWsuiOWay2pPlPdFwwnuK/EdGpzIbJnzJDhyw==
X-Received: by 2002:ac8:5dd4:0:b0:463:2d8:180e with SMTP id d75a77b69052e-467a57f681amr3135751cf.12.1734047531907;
        Thu, 12 Dec 2024 15:52:11 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa692846ac8sm576088366b.168.2024.12.12.15.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 15:52:11 -0800 (PST)
Message-ID: <6f7d8856-e2a7-4deb-8121-b079458e07d9@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 00:52:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] arm64: dts: qcom: Add coresight node for SM8650
To: Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210-sm8650-cs-dt-v1-1-6640ebe0c6cf@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241210-sm8650-cs-dt-v1-1-6640ebe0c6cf@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yLoPXrBFTFuVmYmxIWQUk6XTGN9-qhXa
X-Proofpoint-GUID: yLoPXrBFTFuVmYmxIWQUk6XTGN9-qhXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120172

On 10.12.2024 7:51 AM, Yuanfang Zhang wrote:
> Add coresight components: Funnel, ETE and ETF for SM8650.
> 
> Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 187 +++++++++++++++++++++++++++++++++++
>  1 file changed, 187 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 25e47505adcb790d09f1d2726386438487255824..b3890096085fa09ce36d8199df4aee2b120eff63 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -5654,6 +5654,193 @@ compute-cb@12 {
>  				};
>  			};
>  		};
> +
> +		ete0 {
> +			compatible = "arm,embedded-trace-extension";
> +
> +			cpu = <&cpu0>;
> +			qcom,skip-power-up;
> +
> +			out-ports {
> +				port {
> +					ete0_out_funnel_ete: endpoint {
> +						remote-endpoint = <&funnel_ete_in_ete0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel_ete {

Underscores must not appear in node names, use hyphens instead

Also, nodes without a reg property / unit address don't belong under
the /soc node.

Konrad

