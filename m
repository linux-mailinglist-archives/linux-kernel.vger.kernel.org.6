Return-Path: <linux-kernel+bounces-444812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A59F0CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512FF283354
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7123D1DFE29;
	Fri, 13 Dec 2024 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoIAO7Fk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC81B6D14
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094832; cv=none; b=AF4W0tx9EgXcCXsenZqtrGFG5WU+e9srjUZS0W+iAypIDaYNNbbaoVn/r6edaY3zJKeaCy6tpD0kucKG1xtd+xyWukjYZWvLmoU7pKaTzGVPzF7NHpWKYgR6z7BVNvIgcOZ0n1GXpXTka8YKqFqvxWuy1EPV1jn+smweYcfa8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094832; c=relaxed/simple;
	bh=Rp869uM2wZxe0HaIZrypFYM5KLLKtGoqut7udBsBhuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eA4CsBOK61aoopCCe2YNsqLk7MhMbfZdYX9s5A37id1rLm+37h45E2H/TASVmICwb6gXImVh1/cSc5Gli7SAVcSwES04mRTNbR1kEgryB53tUOEEvfIV3GSrU4MINUsXyijV1h6yOxVyRTDqRHRRfqZXRNWfknVulr8W6XeRMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoIAO7Fk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9p3kK018424
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c70qU7EUPr6CxztC+tT3aMDxIFjQHDuqKZeXLpbD8RU=; b=UoIAO7FkD8+GE6Uk
	BpQc8+BxpYopxFdhFehCFZ6Ige8V4uTYmav75jSu/mjUOWPURmh+rclc7EMC8pW2
	EwI5N15Nd8Hnjd7DbeTet6jj4VJijrLpn13QFvjXL2fvq6T5d1kqLsDEgF2usvZa
	fw1bY7tcSfKLtIPXKZtRnC2sleXIUnW1h46P9nri7DKtnndNg/6aDtbG7d7oFRb6
	jQkYM2zPPmCagEW3lPJPMhy9i4OZwAZjzyWT8vt3nqM3t4N1cZQnJFQORlP/ehK+
	uesTGOxbaUFaj7VU8FIWdpAh51Xy01pGPqDX+wCs+sY/wrJ3ujQpOEf+zABUz44h
	ymxavQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjnb0hhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:00:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8e7016630so4203356d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094828; x=1734699628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c70qU7EUPr6CxztC+tT3aMDxIFjQHDuqKZeXLpbD8RU=;
        b=AfDmbWVeBzO3cMrwgtzalAYwi92KI1Jj/fZrlwlcRoRApCz+8rnWj327Sg7TBH7Lj9
         cuDQNkbskOa6KtUtrCttnXz6F1T3TcuvrfQ8RMHp7GUUjhbdfx0+cWgQ4bKn/YFgqlz8
         zU54WuyAmFZT4zKp5V7hfUhYaZxg9sy53OlGiFL4ayL24nuk0FJs1BrqVDR0x+9g8oAW
         dwl/ne93kytOPAAi9PCH/tYP8rJ1M+rkLzjeUgUttmhrcG4oyaZbEBoZdPKDJFFMT88g
         2DF9PeyxXTB1iKZmGc+6ArogGy5Mmp/Y5RiyUuMGaMpZ7OpKLTOUKzc7qZ7o1npUVj/J
         bvhA==
X-Forwarded-Encrypted: i=1; AJvYcCXqp1c1yvp1gWEZDc5atYCDXVHUfhsSwNsXVJBfkeeYvNZOo0xXfiYONk7BX/4f01VLTe7UU6fsXiR4uvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzseoxautw86NXW6MWpqxw0k4Ul30cf0xOvqOQTvIf/yseYPjQR
	NfngtUX9UQt/iVGi7a1buAO1t+QsK56Ug7W0GXavZNFLlzfswaNZwsR0eXOwaU2TiTF9Y6+F5M1
	Clgj8EWPnbqq3FBriHMkQONFCQKKDGeYt81z2Jg7Fy4dBoEU4fVnB0d45Q3nj/Yk=
X-Gm-Gg: ASbGncsY8JRuALnW/3OcFy++lDzowQO3NdE/DuohXV1OYY9zyW3fnaLZR8ENndWa+4e
	PXR6NfHubVRKkwpeGi5vgsM65K4jqZDVck3Q05c+dCe7kXWHg5SxTwIelvtBy2V7MLiQxEdWsxF
	gv6mqUBkQTf4DOOXGuoUGw9RKauloWW4qmAbRzVPcoAk/+6uWYYR3selT7jjcrGW6gmF+N116EO
	5LHNCxQX1Z8uSwO+7ZXh9f+gV97C4Z7WBVHPhlgilF56/uWuyF+t8doASy4Q8d6Nl4S09gev/Ws
	M/7KLDDzyuSP1nia4RkoL7Box/AX7RjMSdZM
X-Received: by 2002:a05:620a:4410:b0:7b6:dc4f:8874 with SMTP id af79cd13be357-7b6fbf3d252mr144629485a.12.1734094827934;
        Fri, 13 Dec 2024 05:00:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZUVTG6mWDzKnkSxU64HjjbSeNBnC0N5zoqV3vUFu36laHgptTxc2lr/u1XTriE9GzIfrFqw==
X-Received: by 2002:a05:620a:4410:b0:7b6:dc4f:8874 with SMTP id af79cd13be357-7b6fbf3d252mr144626885a.12.1734094827487;
        Fri, 13 Dec 2024 05:00:27 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67af72f6esm789011566b.148.2024.12.13.05.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 05:00:26 -0800 (PST)
Message-ID: <f3fd235d-7306-44bb-8b7f-7eeb63f34481@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 14:00:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/7] arm64: dts: qcom: ipq5424: Add tsens node
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
 <20241125050728.3699241-7-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241125050728.3699241-7-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Q0SHGXRAOjA9dwYGoBUS-k-MaAffmfH4
X-Proofpoint-GUID: Q0SHGXRAOjA9dwYGoBUS-k-MaAffmfH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=741 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412130091

On 25.11.2024 6:07 AM, Manikanta Mylavarapu wrote:
> IPQ5424 has tsens v2.3.3 peripheral. This patch adds the tsens
> node with nvmem cells for calibration data.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

[...]

> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,ipq5424-tsens";
> +			reg = <0 0x004a9000 0 0x1000>,
> +			      <0 0x004a8000 0 0x1000>;
> +			nvmem-cells = <&tsens_mode>,
> +				      <&tsens_base0>,
> +				      <&tsens_base1>,
> +				      <&tsens_sens9_off>,
> +				      <&tsens_sens10_off>,
> +				      <&tsens_sens11_off>,
> +				      <&tsens_sens12_off>,
> +				      <&tsens_sens13_off>,
> +				      <&tsens_sens14_off>,
> +				      <&tsens_sens15_off>;
> +			nvmem-cell-names = "mode",
> +					   "base0",
> +					   "base1",
> +					   "tsens_sens9_off",
> +					   "tsens_sens10_off",
> +					   "tsens_sens11_off",
> +					   "tsens_sens12_off",
> +					   "tsens_sens13_off",
> +					   "tsens_sens14_off",
> +					   "tsens_sens15_off";
> +			interrupts = <GIC_SPI 105 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "combined";
> +			#qcom,sensors = <7>;
> +			#thermal-sensor-cells = <1>;
> +		};

Please move interrupts properties above nvmem

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

