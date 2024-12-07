Return-Path: <linux-kernel+bounces-436004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6B49E7FC1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 12:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D45A167094
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAF3142624;
	Sat,  7 Dec 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lsjcO5Jg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82813D244
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733572760; cv=none; b=cPAiJrNYf2claYK5SKwom6yZnSABlX4dnf7o45Obm5JbmuyMF4wyGMC6gZUv+dseuzQpwNirou1vUaVahjOqCSkZyJ9INxmt34FQax9cAY3iPB4coWzWWJSdkiCK3XHiqaRlQTifVgL0Tj7oQ/JOcY9FsIJON+zZPWxpmN9hpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733572760; c=relaxed/simple;
	bh=mGZn0CG4Ny68vFgd1+6X3q26cRYW734PaY3Qehg7YCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNFupuFHhuUNeGdlLNAoMHpVwGfDb0Y4ghjfLItrcxIenJ/nn/C+0/W0DnBfSQazgVs2s2XSQA66HddB6zXDU1VfIdv2V4tui9K0rtqu4P9px3cyzsqvWxmnelFvVrwVhqvi8rZjNv7t+MhU+nX0bw9i/T1c0/1V0bOYJ993XYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lsjcO5Jg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B7BxB74028700;
	Sat, 7 Dec 2024 11:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VGXhR18Fq97qh7TbUSa0kKhL/ZByCAhy9VcD/gJL5ME=; b=lsjcO5JgY9n/l930
	dD5YoEleoZmmaNmxtMyiIQbAl6lMueD0jtsqgwWixSfoa7rqEOUgV6NhrYKz3d9J
	S4Ok3T/JQn+JFXBxw9HXCxHmIZ5Kl38SMgUD+7dMiTAWaqBwLJnzUnoZLQAAHKGg
	Hjv71GKm9lThlvPa5cKpfW3B7RJgzG76JRXrLLrWxRT9j614zUS6GJyMU3kenEgi
	oKCUKxxD1ZTwd2iyoOl5YD74POtXmVq2hMb0eE2N6h0KcnqugC4LKaCgpHCnKVcv
	MFr5Fg6BTP7catpxvb2GjGyYP9f26lQmf7RFEEp21wzO3Sye+1X00AfU9rYVOs7D
	s18E2A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cc2e8sxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 11:59:11 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d3b1d1d8c1so7443706d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 03:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733572750; x=1734177550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGXhR18Fq97qh7TbUSa0kKhL/ZByCAhy9VcD/gJL5ME=;
        b=EGg3XE6NKTbxcHjXo+ivmniNTfd+eXDKPJ0h5d16RBCed9RSXQcGqKZCZFWaJBF4EB
         Tfj5EtDpNpP/JUkmqV0Orqk3sIoV9RjwthiVNPtxBvHY2IkLqnAk8knm4X14JY3sk9VD
         JUkxeF4vAxnSPGGxDzWncBwUYfGOlAXhBAUTzCNjvZw/xijMmRV+nSYBttJCrG7wNCBm
         N0OBcAUaB3vqJlpsahTneOsCGGE8x0Oik9zX8Z+kIrDXGvfSiV5c8YPjPDHPEH7WpN7q
         mpYzuWKPXFKfGggasxjcxX0IgQF2kG0iD4sXUAVd98z9cAqGERyJSyS5fpdSa1rNgfNz
         jl6g==
X-Forwarded-Encrypted: i=1; AJvYcCXWS8kFPuc2iFf6MwngwiRFFQl+Sc3EImN/IaKu0dT0rY2zYtFsV4JsScpby3dGxkfhKq8M7PYV8sdjT6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoCsCJ/DQmYV0zTckVHGJHpezu2CZGcSSQqTQANi0RBMoRno/f
	t0Qt2VmC3gzXevVD766zAuX9ZYkVAlnGyn9UMG0ruFUayn08IGdkawI+6OSag44Ab69JmphVC4P
	nSpvJc0gbvCjN4uuogOpzcyznlgeTNTKmCR0PO8NaRM0zxwWBMTChZjHVI98p7Xk=
X-Gm-Gg: ASbGncsRDnAYkb1RQCBDv52Uuj+3fNtTLDvK66UTxaDjscFZdIRrCvalF/uyIEFI1FS
	SFKn4+jvno4NApooUPeygumsRI0z9iTEJw//vNBBpk3DpCJGq/2sQu0nRkmvwZFhRMTPfT49yM1
	66rzg1vLLfDm3JCeIGaYcGOlZYgH5w0RL3gqQ9RT9iwHp3MXRss83RlitAjAAj4fbQ1NUCjK+TF
	VBvURUxbVU7naag3wSZ0pa7FKOAg36Z7TLZAHw3P89kRyIyLpsWZ3Em5/83oXzzlPvpzXBkgz54
	ygex6s+na6YW3sRjIxWK82RJKH2OeJ0=
X-Received: by 2002:ac8:578d:0:b0:463:5391:de49 with SMTP id d75a77b69052e-46734fa37b7mr39903291cf.11.1733572749706;
        Sat, 07 Dec 2024 03:59:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPlffbEBpmwwLn07e4NjXlSpPb++V4AbkGPE+RE6e5rhThB9Z+v/f84NfUnlbSCUlfPWRp0Q==
X-Received: by 2002:ac8:578d:0:b0:463:5391:de49 with SMTP id d75a77b69052e-46734fa37b7mr39903151cf.11.1733572749290;
        Sat, 07 Dec 2024 03:59:09 -0800 (PST)
Received: from [192.168.212.163] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e96aabsm381402266b.63.2024.12.07.03.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 03:59:08 -0800 (PST)
Message-ID: <b5400627-6359-4dfc-abb2-2c142217a28b@oss.qualcomm.com>
Date: Sat, 7 Dec 2024 12:59:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: x1e80100: Add CCI definitions
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-clk@vger.kernel.org
References: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org>
 <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-5-54075d75f654@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-5-54075d75f654@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BlYPhSl6aF4Cw9OU4FBtfxPxoPyEbsGu
X-Proofpoint-GUID: BlYPhSl6aF4Cw9OU4FBtfxPxoPyEbsGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412070100

On 19.11.2024 2:10 PM, Bryan O'Donoghue wrote:
> Add in 2 CCI busses. One bus has two CCI bus master pinouts:
> cci_i2c_scl0 = gpio101
> cci_i2c_sda0 = gpio102
> cci_i2c_scl1 = gpio103
> cci_i2c_sda1 = gpio104
> 
> A second bus has a single CCI bus master pinout:
> cci_i2c_scl2 = gpio105
> cci_i2c_sda2 = gpio106
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 162 +++++++++++++++++++++++++++++++++
>  1 file changed, 162 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 5119cf64b461eb517e9306869ad0ec1b2cae629e..c19754fdc7e0fa4f674ce19f813db77fe2615cf3 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -4648,6 +4648,88 @@ usb_1_ss1_dwc3_ss: endpoint {
>  			};
>  		};
>  
> +		cci0: cci@ac15000 {

[...]

> +			cci0_default: cci0-default-state {
> +				cci0_i2c0_default: cci0-i2c0-default-pins {
> +					/* cci_i2c_sda0, cci_i2c_scl0 */
> +					pins = "gpio101", "gpio102";
> +					function = "cci_i2c";
> +
> +					bias-pull-up;
> +					drive-strength = <2>; /* 2 mA */
> +				};

Please match the style of other nodes (flip drive-strength and bias, remove
the newline and remove the mA comment)

Otherwise looks good and I can attest to this working, as the sensor on the
SL7 happily talks back

Konrad

