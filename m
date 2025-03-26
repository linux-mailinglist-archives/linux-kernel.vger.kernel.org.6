Return-Path: <linux-kernel+bounces-577445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9D6A71D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5543016E0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75442219A7C;
	Wed, 26 Mar 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="deIMP7iv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF8219306
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010090; cv=none; b=RTpS8ok6xNQX1ffLTpMk7WXzxAurhwPQgsSN+xlxUNxCgsd08EJhLqBTmE0OYJn8Fn0eg995h6yYzWup6LgFVRZmmm8Tlb+JpCvNjCzHbOvCv+EFaa7p1gvE55fPWASAFPW4/qfTb08UzdIGfuibr083c/F6X31Gac+OOKuBORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010090; c=relaxed/simple;
	bh=VHUxls8VIPB+bwgE0jcP6Wo7v6VkMcBSBygTBg1uTyw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtQ2x9jALSYB3fhUHLuU1ShfFja3JYFmuE3iy5egWxuYRkwnPDFvETEEf1SdnOHHuY+RYPzvalVeatWJmIH9zz/UE6EoBh053CnKUHZV09JqLSO2Rw1rpvHOb/W1Gi1MjZxy0Bf6UtEh0mm+pkKnrOwGk32ZIiBEvVWtH35G0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=deIMP7iv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QFKtdW029945
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0S3hgXPJr+8ikf9pw45un5xz
	S+GPSbI/uN9U7waQCZs=; b=deIMP7ivGz6i3cG/Bje38eWjgxEtT9oTt0J7Ggv4
	GQyVBqps3VDxYlfitR6NEw1ZctTEtALdS9N0tf7OHmxRhErEkFaGhwcg41JAffj4
	ZfdsZ7nq5YLDa/LxDDvSkdWMva6nOB1NJ07ox3Y2Iba8iKrgep0cAAeFp5WNUSwt
	8160x2RHu9iOK96MuboheVkWGB1dtleXILCIXvEJ+kW/joj8QquImgGrlH4lUqEV
	lf+oN7XLPB88JMHVMYewaTgxvjYkrqmKjwqaxbNgJG5bgogxmv7q+4jYIGp1e9l3
	nlLv3aSU9EkU2aAhQafeBa1s8K15/5souLKqbSFya0v5Sg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ktencmme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:28:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c59ac9781fso22090085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010087; x=1743614887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S3hgXPJr+8ikf9pw45un5xzS+GPSbI/uN9U7waQCZs=;
        b=CbYAv/PnIpmzfD7FK8nsHUb+adg+h7kOrGkS4tEVNqcqXTGTi96Mi03bd1BfOoJSOY
         tlP4zuo4PF9PNVinuXMFkdC4mYiZ+7xmzVKmDbCTM8QqaqEkcnx+Pno9gfYpxcUnMVol
         gAD0zf0gcZwPImBb5kh71yaGdbnNtvjL2V7t6rathZnzuN0LbVHYQGlRuvIRNRaySsNW
         BFzPEEBWCnFiBbCdRuubtoOUOYJzRZQoya/aUa+hwQ9IVU+it9/U+hGm8oCfrVjc6/gl
         GdRl3YSG5raGCntkobZAggbfHQHypPyZ4yUfdd+3B6Hof1EkAQHh2V3/8+R9oZnTKfCq
         523Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9Jl3WDPKSWNNCx+cyvp8s5towgEPy0te4nsESnKMwJaZIPaXEzjwN+gsiSoGBWZKy/t6qgh8+H86Sr+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqc2wJPrz+CHyBaJde5N91jl7VX+O0AH5U4GWpUtLfHxDZRl+5
	RYt8Qa/DU7nYsCslbBQN+SzyimVoP8clokwGML9egOFJ8WI039ZBbBR1vnXlVqTZgNKesHB9iQf
	zw0xJJL55o89paM3ZdfY6tSfB5k7htAY/Dw7dKEa3AC5uoFNLwpLr8mOa1zeOcHE=
X-Gm-Gg: ASbGncu2DgHL+GKtAYFY0GkX5TIyuTB11GSEK5D4qYLlzoL3f9/5PEIuqsDITIPUgfU
	NoJ4ojpJ6KitZRu02oHd9lWaRMRjPkjzYabm8AlkmFRXUfHDwFL/D8uMK5OfEW6u7LrKShwrFAq
	IdTl3zr2PGne6fDLYy+nloj6Y1ugiFiFWlOvDNhS/NNO/ocmQgR7Zl1psZtSM7R2zEQa7+Kv/o1
	P7ZhDjR7ejg3pNl4ZXxxR8oxd2WFMysRMwqk4iO0yacC2ZnYOQme4FO4OvzSePwUdrVm5dML5ah
	ZOI1MN2gZUTBtSBODLS0pt3XObHg9NJeFduRmlP7X4CQtCzmV+E=
X-Received: by 2002:a05:620a:6193:b0:7b6:cb3c:cb81 with SMTP id af79cd13be357-7c5e49344bbmr753060685a.18.1743010086576;
        Wed, 26 Mar 2025 10:28:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiNZ2bjssGBqVdwGizyv1ZkwRj4Svqzyb5jA/H7jjsZneLjonq8dH3M8N6XH64FI8vKcNGzQ==
X-Received: by 2002:a05:620a:6193:b0:7b6:cb3c:cb81 with SMTP id af79cd13be357-7c5e49344bbmr753055385a.18.1743010086060;
        Wed, 26 Mar 2025 10:28:06 -0700 (PDT)
Received: from trex (144.red-79-144-186.dynamicip.rima-tde.net. [79.144.186.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dedea3sm10144635e9.3.2025.03.26.10.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:28:05 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 26 Mar 2025 18:28:00 +0100
To: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com, Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: Re: [PATCH v1 4/8] arm64: dts: qcom: qcs6490-rb3gen2: add WSA8830
 speakers amplifier
Message-ID: <Z+Q5IM0Qj8J5xZUm@trex>
References: <20250317054151.6095-1-quic_pkumpatl@quicinc.com>
 <20250317054151.6095-5-quic_pkumpatl@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317054151.6095-5-quic_pkumpatl@quicinc.com>
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e43927 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=LfYPmjDHqwmh8J85qtw9fw==:17 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=hICUP55FaW_hIgXUPesA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: IuAifI5LVxD77r6CmzU9M44KVkkAgXZK
X-Proofpoint-ORIG-GUID: IuAifI5LVxD77r6CmzU9M44KVkkAgXZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=807
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260107

On 17/03/25 11:11:47, Prasad Kumpatla wrote:
> From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> 
> Add nodes for WSA8830 speakers amplifier on qcs6490-rb3gen2 board.
> 
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 27 ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 23dea375c213..a1a3df77ad57 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -870,6 +870,33 @@ &sdhc_2 {
>  	status = "okay";
>  };
>  
> +&swr2 {
> +	qcom,din-ports = <0>;
> +	qcom,dout-ports = <8>;

are these number of ports correct? from my unit tests, 8 seems to be out
of bounds (soundwire probe error)

> +
> +	left_spkr: speaker@0,1 {
> +		compatible = "sdw10217020200";
> +		reg = <0 1>;
> +		powerdown-gpios = <&tlmm 158 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "SpkrLeft";
> +		#thermal-sensor-cells = <0>;
> +		vdd-supply = <&vreg_l18b_1p8>;
> +		qcom,port-mapping = <1 2 3 7>;
> +	};
> +
> +	right_spkr: speaker@0,2 {
> +		compatible = "sdw10217020200";
> +		reg = <0 2>;
> +		powerdown-gpios = <&tlmm 158 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "SpkrRight";
> +		#thermal-sensor-cells = <0>;
> +		vdd-supply = <&vreg_l18b_1p8>;
> +		qcom,port-mapping = <4 5 6 8>;
> +	};
> +};
> +

also, should we enable the soundwire controller?

>  &tlmm {
>  	gpio-reserved-ranges = <32 2>, /* ADSP */
>  			       <48 4>; /* NFC */
> -- 
> 2.34.1
> 

