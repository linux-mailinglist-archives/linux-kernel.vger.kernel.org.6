Return-Path: <linux-kernel+bounces-443534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B6E9EF428
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D0D2912A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86284225A5E;
	Thu, 12 Dec 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CNomjwdY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E8176AA1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023054; cv=none; b=joI8YYyGnZW+6/inier9kX2Y05UGKqtpO32Y1kS7w+NFgxiUztHjMRWZMv3uml3ndnsThrALHkVwDcwP8EsgIUYfAqHD5tLLrmXQGFSMujBQ9rGrOxJ3KG/JRW0u/4AGFiN9Acws2/TiZOcUQTAfSeqNbX7ZSkZmKgEHY7gRQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023054; c=relaxed/simple;
	bh=rBjwzO53CbAB9t5GEYSOjc+7gazVend8nDzOa2WOHHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqe4gAVuhQapRenbU0BtPWBNbeE/82I0ABzhCXeu+/Ukl257URZB3a9ljkg5Tu+KS2IpZvatprfkgVOl1VmOYBFl1r/5dDz5bXwruSVjj74cwZahmMLoB+YkSpNiJFQN+I0tgQHEWeVLLusOK7b7PVAMuLyO8oucQ6nGMJUXvR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CNomjwdY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGT97p026852
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fNew4i/yxHEuenMoncvUi+FNwXBhAQ4xpLpoY8gs/d0=; b=CNomjwdYP/mLl0vy
	SxQHxGb2CceC7C1jcS9jfXNg08Sk1xrxhj4KqbjntBJ97uxztDiJnPkoXL2Dk0Gz
	CUjSAz02PXqbEcaHiHdSxir4BWu96neFQhYkiB9F+Z++INm8VgYUt1O49Jz7GTYL
	AhXbhOBudN2rLZrCPE6oxkZjIJ26eQVYxXxabqeSbQLT+D98Gp3eEStO3xM4NXF0
	ULT6WRCm2Z5AXm/A0DtD3XpY9b9ujOSZJjXE1O9mlrAsc2EVahBSCf3ILniX2u8t
	2oL4oDt3MFLrQ5mGBG6CZgHBhBg2iNR1YxMkSr6tKp5ijJ6i/IQlP3IO5CHhnYXf
	cJumEQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40kptd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:04:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4679af4d6b7so1808881cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734023050; x=1734627850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNew4i/yxHEuenMoncvUi+FNwXBhAQ4xpLpoY8gs/d0=;
        b=qpAqS+RPgBD11kcX1WXeeOcD2bMP91gJTTqe/60CJw3B+pjh8Y0bFA5wf/ouF+EjWh
         ZHZ6pTb87/LTKFnGSee9FBjpTwNUHxrkzx5o8a+hqzb09WjUOx/UpfgAjI9GEMxQQRdn
         mWxFSzzJFFPn2+fo0nYplXo8kEUANv1ue/79bWnpdPPvJrAzHll8hzbEUxotDcImQ11p
         Mx3pIgy/X5mowncjJfiqWuzlkHKDzEnCfuM4sZlS0CjlYM/hVeLhSzgQwiJO4OK3Fya7
         53f5NOqQnHEU9uVuGWig5T+EeksHDRF410NecJBR/Jznd08znN2Zh77omH1SaBqtZuPb
         AG0A==
X-Forwarded-Encrypted: i=1; AJvYcCVwQOnIFcSorpcc9SospjeGEMaMo8ZiV8zusp5gOyi8iCDGIJU7u2xcyi1IcRigCjLvtWe1/Bu/e2foB/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHAwXtBx6jg6bz72/5YAIu+9JA7sJ4NQ6F977cZDPz0mlV/dDs
	vPPmvkjfxT2o7TxwVkoyOg3Aor506Dzmmxz8CIOGcV44l0pL8vkKlPkGrGmwgxxEFzDVpg3daJI
	lSK1VuWtyl/WWsy8jzJvL9LhZpR06+yfisAFTO3IDcXV6Ci70ff7FqeG9ZFvugCYb0GubGeM=
X-Gm-Gg: ASbGncsV7uT9JGXc5tmZTFX7Qq4fytkvW+JwtHK8rGhHB1tO0i9YdW7h8sGF56+maXQ
	ZKTUWFgqjIpdr2A7QbIDqBJCII/LxtIZFY5w/qtbrdl9ty5OQhUNjYGDUue8IbL6BJbmmxyvLcp
	7u6IDnn3bvPPgkef+Tc21wGu8pz0p+kUTleeZ/BWn5MY0bREomYa/VpQNYn590OsnHEGcrQavtk
	7gNhtYt+s6ITD1PCwC+r5Ftkvlb2HqHK8bycpCcPt6/v/4wHTkI1FcsL/FB+gyTv/+Hqt95zQ6p
	jm4ZQ739GfmqzrcggdnDnxTwMx3Rh5f5SEeDnw==
X-Received: by 2002:ac8:5748:0:b0:466:88ba:2026 with SMTP id d75a77b69052e-467a16def05mr6096981cf.14.1734023049809;
        Thu, 12 Dec 2024 09:04:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8vgfWWK+oQ5exWPFkUHGzlUOH1BmQ8/OxS0NIBoRvTTZC3B/uHCd1ekuzkScTL2816D1C4Q==
X-Received: by 2002:ac8:5748:0:b0:466:88ba:2026 with SMTP id d75a77b69052e-467a16def05mr6096841cf.14.1734023049283;
        Thu, 12 Dec 2024 09:04:09 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6810027c6sm662648366b.104.2024.12.12.09.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 09:04:08 -0800 (PST)
Message-ID: <d41df236-48b1-40fb-a19b-5d7024884186@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 18:04:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: Add coresight node for SM8650
To: Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210-sm8650-cs-dt-v2-1-cf24c6c9bddc@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241210-sm8650-cs-dt-v2-1-cf24c6c9bddc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DwI7l5Olcp8HCPCndtOmXC7c434J7ugA
X-Proofpoint-ORIG-GUID: DwI7l5Olcp8HCPCndtOmXC7c434J7ugA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120122

On 10.12.2024 9:23 AM, Yuanfang Zhang wrote:
> Add coresight components: Funnel, ETE and ETF for SM8650.
> 
> Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
> ---
> Changes in v2:
> - Update compatible for funnel and etf.
> - remove unnecessary property: reg-names and arm,primecell-periphid.
> - Link to v1: https://lore.kernel.org/r/20241210-sm8650-cs-dt-v1-1-269693451584@quicinc.com
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 165 +++++++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 25e47505adcb790d09f1d2726386438487255824..76620d478e872a2b725693dc32364e2a183572b7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -5654,6 +5654,171 @@ compute-cb@12 {
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

Node names must not contain underscores, use '-' instead

Also, nodes without a reg property/unit address don't belong under /soc

Konrad

