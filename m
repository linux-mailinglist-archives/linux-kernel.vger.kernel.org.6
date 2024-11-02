Return-Path: <linux-kernel+bounces-393243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84D09B9E2F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385BF1F21A3B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B6A14B94F;
	Sat,  2 Nov 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UP/DPhS+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5574C14
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730539827; cv=none; b=M3zxFUzfZmkvzbPuY4wX4Rvtjp3fET5CuizD/DQIDKprFaYJKtkoChGriResG6XM9chGXJtpKTa4X6DpE5bfDvyMaYZhrNvcjV+z+KnoYVDYFwCOOZhmYhjQ4qzPUo46OWnuYZZDNCAoAMYOnVVwsnC94FlVLk9PXyZb8HrM/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730539827; c=relaxed/simple;
	bh=KguoIWYcyHjI/KTVd2RGJJ5CuHRqYCPvOiQw9hWn1/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRfYr0/M8Y7vQS6SvksuZ8StohXUJ+501DsfzchzOubucrcEB/hdDV+35aAQtpLWkPCgBZEb7v5lu8ygimPX1pgtAMqSGPss10HcIoeEp5MTU4fKRZoKPuuGJ1biYPSBw7J01Uq/eXzlKJomauWlorR23BXV4rQdbisXWCjxTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UP/DPhS+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A24e2qh029416
	for <linux-kernel@vger.kernel.org>; Sat, 2 Nov 2024 09:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BkeD2HeLP970ElEG5FogJPdESKQj6KjvxZECpLrGFKk=; b=UP/DPhS+hN4UnU8g
	ja5FeCMt3i4ucwlir98n0a38a929N4aZrmnNupnPPGDVOR1DbNCFo7AEH4zpIBq0
	VXQD4quYSFFaRMn5kQ79ugSI4VroWKgtH9JcLK+Oftbl8cHCnDVDwqFIcn1qcqRS
	aT/EDRGptbt3e3plC31abpiO4qStldL3O9RKHfe6CNszfSBKbkharimssONpqE9i
	q58mB+fiBPHSzbRI2yIKQIVVDtIF+G00ViotW2xbuuXMmAS2jf5+ci0Uba3AOZe/
	/tZdVAOE7NkRucPDvomc+mQ0kuohpwaPPxlW47sKOK73k7KP2j4Lr0GOAcQi+GV/
	rVf/gw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd8h8cp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 09:30:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b1441d231bso32525985a.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 02:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730539824; x=1731144624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkeD2HeLP970ElEG5FogJPdESKQj6KjvxZECpLrGFKk=;
        b=uy9aa3nZBcZX3ILDzOpfUW4P8Eomv17xAP0x2cTxXZ/08nYaGPkfqvl1dhXJ+L3Gmn
         14IIBTzOofHRIbjWyiiyNKozfsgxUa6el38s3as9bBob90wEGsRcnam14QOaOLvctuj3
         fp0YHDEG4OWEMT/HePwRBU9V25skh2Jqpip6Ukv5AXSLIxpuvOqOv2FjNEiAVf2v/o/1
         CEtAcZwqYh0TsOqwBcmDCYY/J6O4TVbexUZaiEJChRb+Nj3H08+oXQChMAOTqn/+vc8o
         OXkVc3vc85ug2aXIvAggKhKGE+6bpIIGKmjceQjyEg9P/CZb5kUVo39mG3I9Igt9PU5q
         CcFw==
X-Forwarded-Encrypted: i=1; AJvYcCXN1P36SUYyR4IC4uYMS1/V2nNI7vH3XlJRZPMRzuLU3Pd0yydxtMo7UP2T/ioL4DDvMp4RoGsD77gESHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWXfdkqWNQ9fxhdCwXbJwgBLBrIz+tnBOIrzjXZ2Fp79Q/QeY
	qugiWRMxulv0BZR8gik5IwluK4tFt32p0Q+B/7/j/4IP3XnMzAOppNttvx/fQWHVwPCP+YqsYKb
	EoyUrafIXg6atFa40vnnkStlHSwQt0J7sVuKRc90EPt+WpaWOYQREIQLSEiul0CQ=
X-Received: by 2002:a05:620a:4687:b0:7b1:45be:2e93 with SMTP id af79cd13be357-7b193ed1cc6mr1776340185a.2.1730539824120;
        Sat, 02 Nov 2024 02:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTn+cmJ+8XggYZPxMks84hd5eMzE9GVnlaPbjGcGjUXNk5B311VxjwpRp3dbrLk5HLSAW3Dg==
X-Received: by 2002:a05:620a:4687:b0:7b1:45be:2e93 with SMTP id af79cd13be357-7b193ed1cc6mr1776339185a.2.1730539823722;
        Sat, 02 Nov 2024 02:30:23 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566447a1sm292887066b.176.2024.11.02.02.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 02:30:23 -0700 (PDT)
Message-ID: <8078589d-d724-422e-a5f0-f5b6c67deafe@oss.qualcomm.com>
Date: Sat, 2 Nov 2024 10:30:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/10] arm64: dts: qcom: qrb4210-rb2: enable wsa881x
 amplifier
To: Alexey Klimov <alexey.klimov@linaro.org>, broonie@kernel.org,
        konradybcio@kernel.org, konrad.dybcio@oss.qualcomm.com,
        andersson@kernel.org, srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241101053154.497550-1-alexey.klimov@linaro.org>
 <20241101053154.497550-9-alexey.klimov@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241101053154.497550-9-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ych1NpKMOUFoZnUUsnRa4cWd_cMAgnHL
X-Proofpoint-GUID: Ych1NpKMOUFoZnUUsnRa4cWd_cMAgnHL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=859 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411020084

On 1.11.2024 6:31 AM, Alexey Klimov wrote:
> One WSA881X amplifier is connected on QRB4210 RB2 board
> hence only mono speaker is supported. This amplifier is set
> to work in analog mode only. Also add required powerdown
> pins/gpios.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 45 ++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> index fc71f5930688..76b9ae1b0ebc 100644
> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -63,6 +63,16 @@ hdmi_con: endpoint {
>  		};
>  	};
>  
> +	i2c0_gpio: i2c0 {
> +		compatible = "i2c-gpio";
> +
> +		sda-gpios = <&tlmm 4 GPIO_ACTIVE_HIGH>;
> +		scl-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";

Does it not work with &i2c1?

Konrad

