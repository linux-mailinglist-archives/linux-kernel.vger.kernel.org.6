Return-Path: <linux-kernel+bounces-555872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D0FA5BDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A50176498
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B04234984;
	Tue, 11 Mar 2025 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TunRKVYG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCA231A42
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688408; cv=none; b=YJZ7d97+Q0bvObb9do8PG1oSoDRGH43ZTIFQcSdN50o50lCPfw3RFKKzmc1F7Zt71Bl5f0gyRllA+RZdfPnqgHfeNQuKzJA1Vm4mUmezlaBrQbFA1xW3WJSY32dbDAPk0RFUHaOrXUr/i2gzHUK5Igwx3H0cec2ZdVsZh6H8l5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688408; c=relaxed/simple;
	bh=/LhwAatIrYhSKz3Hn3nUzj4oY/T6QI4BOBJtK2+GS6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xotcv6DihOG2HKDkKT5e+vw6iPfHCTeDChOcirnZMDs+eN6+d+TJl9dXEe1b+GdKU0ed+PZWW70f59/SCuKuLJE6OjmdoFe7DIWG8+bu25UHBx2o6Vzhc01h9CCe5homq5mhEaDZWTpGtoFfN+KG/dZJyaonTCmxwuitq78pi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TunRKVYG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7BpMI009408
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hvpU8cNRRyE3NYbYhBrTn7HxH5bd5zCkr2AnBxiZ2/E=; b=TunRKVYG8BYyiIAq
	J+t+DI4eSfSh3xb37pDaolOhuEA5qHtJQYdb+sDY4Dganr3yXUIxyPpFoVNureok
	kTV7mEwuRzqR6+xI55extt2pZ7m1L0lUEnP0RYnt+UR9eRr4yND4rucc4mbUkLGA
	Lnm6B2gr6Bv9h9Ia/0gtnYWpkXbeXssNcCEqQP3kbU6/YJm0BYGO+wT0/kgNck91
	jpyZAxKDa+AF0XGjll36u9c1Zm12xSwHRZVZ9TClwI7XlDk+C6FcgCniZib3BCFq
	Q4Bd1CzjTJcQgC8TFd2b5Pu19c6ODX2uZoqWwH2qjCQmXrIIG7eiiE/gyAyoD8Fa
	jFe99Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewk83bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:20:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-476a4a83106so539531cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741688403; x=1742293203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvpU8cNRRyE3NYbYhBrTn7HxH5bd5zCkr2AnBxiZ2/E=;
        b=RTshZd3y29Cd36ECFb6dFkNtkSIu9R21uNG/DOhdjJ7oGtaim1jZRdJJOjDTGyoIpE
         agtgQML2/bbtaUOP6aymHK6i18mEnrbck8gWBahMT42s2LJkrLfWYJi9dkGVRxuC5WOI
         LKKYro0sQdcq+tes8+swCBhNHO4UlRRZHbnAewbu6v8nx6OvTZeELUVXJlMdOrTzban/
         wq0jFSeRCYkfdwq9Hl9wJeub2VendwWF7x+jC8fAOPJLZmqVuFRMf9cpBLFjKt4IHtYs
         pnEwefkZ2Ph8z1xZnKwzqi5YM7HRhl7nrhyaExPkj0HHzTEOQt2RtVaDUAwg+/XXxT3u
         Griw==
X-Forwarded-Encrypted: i=1; AJvYcCXKsOnKp5ze8I74/GyOb4pS0kfZmdr47NookRCx9NhzGo3TYUT4eH/3aoQYVvwLE5tdBDzGWoFOajpbhiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJGExNl7Gqlt4IsrSOb2kQJc9qWL++qX71VC9COCSZzOxHGLq
	+uWRnbbPEhDdw1eCVXWjG56Dl0LWH49FgYptHrWXN+S58qWDnHCVS7JRSqdciHjiJlJWkebrUDp
	KBp1M/Sndk+eldNY0DAApiXchxhe9nQd6IeXVH/776slljRBwj/0kIYWGp1g45b4=
X-Gm-Gg: ASbGncvCRFlUUe4462eHceoJuGEj7T/jLbjIKXRfLHXZ3p93K+qIEW5Iw+GsQlI9USQ
	zwQ80FlQcesjvvqnxV0oe62A79NonCNZ8XiIqAvJegz3KCNTZyP9UPMKcbAISQEAzvJ6mzS4thW
	HXaQNvOEDf4o/5vr4/gZYQMOiVbf0qN5Z4GMSsUEYyp1zkwDYih7m/V3vNBCo+x8wVtJqrp2/Ve
	AUKR3hwa3Z51kClAkoDxGB3RW6Awei5Pr/aV+sQA6K+VnmgcAiysk3jTXEJxxVX7CE4aTHRpu83
	xUvIa0Z1TE5qA0rdp/aSBctg5KWwz49TMvk8u0M868HGde/2etLbVxcXUjddtJYn51vdiw==
X-Received: by 2002:a05:620a:458e:b0:7c3:dd4c:df72 with SMTP id af79cd13be357-7c53e1d8a09mr587921585a.12.1741688403405;
        Tue, 11 Mar 2025 03:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW14GWzzafpI/ZRpdjigJAXfL/a9aWGOu+pEKCihxcSDZYjxrGZ1Np3hPVMmw+svw9Ztt3wQ==
X-Received: by 2002:a05:620a:458e:b0:7c3:dd4c:df72 with SMTP id af79cd13be357-7c53e1d8a09mr587919785a.12.1741688403073;
        Tue, 11 Mar 2025 03:20:03 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768f995sm8055087a12.73.2025.03.11.03.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:20:02 -0700 (PDT)
Message-ID: <69680418-5a34-4b6b-966f-bb22f0ca53aa@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 11:20:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm8750: Add LLCC node
To: Melody Olvera <quic_molvera@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250304-sm8750_llcc_master-v2-0-ae4e1949546e@quicinc.com>
 <20250304-sm8750_llcc_master-v2-4-ae4e1949546e@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250304-sm8750_llcc_master-v2-4-ae4e1949546e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Tr8chCXh c=1 sm=1 tr=0 ts=67d00e54 cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=oA5OGs6Rxt_rxKO5FVQA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: R9xaeiGFSottShcQq5088voqG2Nzfibl
X-Proofpoint-ORIG-GUID: R9xaeiGFSottShcQq5088voqG2Nzfibl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=983 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110068

On 3/4/25 11:24 PM, Melody Olvera wrote:
> Add LLCC node for SM8750 SoC.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..a3f9595c496f6f6fcdf430d44fdd465dda4bd39e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -2888,6 +2888,24 @@ gem_noc: interconnect@24100000 {
>  			#interconnect-cells = <2>;
>  		};
>  
> +		system-cache-controller@24800000 {
> +			compatible = "qcom,sm8750-llcc";
> +			reg = <0x0 0x24800000 0x0 0x200000>,
> +				  <0x0 0x25800000 0x0 0x200000>,
> +				  <0x0 0x24c00000 0x0 0x200000>,
> +				  <0x0 0x25c00000 0x0 0x200000>,
> +				  <0x0 0x26800000 0x0 0x200000>,
> +				  <0x0 0x26c00000 0x0 0x200000>;

Please align the <-s and "s, the data looks good

Konrad

