Return-Path: <linux-kernel+bounces-383077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05EA9B171D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF271C21A06
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1A1D2F6A;
	Sat, 26 Oct 2024 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kmsiajyW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98521D095C
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729938979; cv=none; b=BiSG6L5lFc7vAn9qzjqOpJC/g+uromy1XYur4cFeruTTMweU/ls446W1L3KOl32rgGR83Ym4e8BtirPgGe8EwdEt5YxuYtU1GktxKmb+j7UXNVj/7n8vUjI2yurcN3AAfoAhNd7kf1313jjoWcdRnmmKx3VEnTORi5XS6u7uyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729938979; c=relaxed/simple;
	bh=CO7kfa6WbUq/EgIsG9xmlv3qEhvWNJL7uDvse+Um1Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGOMRdJ7zEDYFCksxEQy/3LjUq/LipLvV9CSuS1T2GoTYwMhxrzm0XV8m55Hee0cBIF0mErgbu7r9QA/FCZafHw9PD6YYyy4sNVPIsAV6I+3rrGepiFkTqZeflxkNi1miR8y+l+vCpBRHuW5PO7wbVpfc0lkwZsloYynvbiSKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kmsiajyW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q4F2w2015411
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vK1OYVjGeLw0mJ+uvwkmfKmrZoRBUC2JQg41IF9bQIo=; b=kmsiajyWsJrCRFQI
	ySNfNR7F1naHjtYiNbrr1X0o7+np/zNst8uF52r5ONLWCWjN281odfUm3+UvPwt1
	WaWuQZq88sif1UsTpDSGER0u6S0sQL+7Vl31v3PPc+NJIJNeN5csCSltahhzzvEr
	iYW61QqNQi7B5g8SYpUvUwZzOAleKLq9aU9RdF5STN1bmu9vm7KPxDA1lmpNEE8l
	XU9qMGjI8sfb+xuqiXaAwAqYG1IIrohPE93snQVdhAylxyhlyK6XufRA2vqDPdpO
	Btb8TLiOJU7ubiXXIllRNJ9BskjDt8YMT6qg0UkMaMRLnvl/6wWz4EMzC1VNzvDV
	GGKNOA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grn4rqqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:36:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbe944435fso5323996d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729938975; x=1730543775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vK1OYVjGeLw0mJ+uvwkmfKmrZoRBUC2JQg41IF9bQIo=;
        b=ItaeYBcx408DLxbaOGbVzCfOzyDKxxJagRUqi+JI9dESAIGMliaEJxTE0rWN4RYrti
         lS189NYoigA6S5+216dPwmZlZPDUsrus2LChOEfLD6I3oYqTZfxxJoc8AtYgfeVaFXYf
         6rSGztACAtrEkDeZtyTvn/Y1hp3bAaY5GD5JXdypGgSG+kTeCNByc1mgJUL6SAnmCeDG
         uwaqK6duQogNa5lz9R8cTAOY37+lJniAjgSlBwyhQh7RmMimO6CIs9zuJ0LF8Ujts1tQ
         iOxzE/+rv62ZWOSGu82Xht3POFt6MFOK3OStkFh+Ckb+X9K6hhOq+67LC/C9YXfk5yKX
         RU/g==
X-Forwarded-Encrypted: i=1; AJvYcCW+fhdde61046+7DKkIHi7boFJx4VkP39EjHRFzAlh82mTmQji2qOPLLLBhQaygJwfFsjeXkcsmWuGD6Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsDsOruDVcNTqbn8Kpu1KrkDnilYEcFZp7lS4/r71GN1tya36
	sKzjsQPkydBslHWjTjfMnX0JNt+yyJcy65oLTbf+usBGJ/EQkQeqTZ+1oyNPA17yh/DwntJLOwc
	STFVhD2j8w4tYoC8wqSP3bXl+4SigJOEWHq0SF2qcJngLGJtep7vIuRtXqs/VngU=
X-Received: by 2002:a05:6214:416:b0:6cc:2ed7:5436 with SMTP id 6a1803df08f44-6d18581fb4emr17861856d6.9.1729938974799;
        Sat, 26 Oct 2024 03:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkxWZp/qXi6fHf5BJvHQahl66ZSK2uQll4C1Bvno5fCGgJNEtVoppwVBMRTWAJQYCuSni5Hw==
X-Received: by 2002:a05:6214:416:b0:6cc:2ed7:5436 with SMTP id 6a1803df08f44-6d18581fb4emr17861706d6.9.1729938974489;
        Sat, 26 Oct 2024 03:36:14 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631b5a5sm1419117a12.61.2024.10.26.03.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:36:13 -0700 (PDT)
Message-ID: <dc1322d4-8312-47a4-929f-086b417d4ae8@oss.qualcomm.com>
Date: Sat, 26 Oct 2024 12:36:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/12] arm64: dts: qcom: sdm845-starqltechn: add
 max77705 PMIC
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241008-starqltechn_integration_upstream-v6-0-5445365d3052@gmail.com>
 <20241008-starqltechn_integration_upstream-v6-7-5445365d3052@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241008-starqltechn_integration_upstream-v6-7-5445365d3052@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aYx2kDnGAmfUk6JD26qQan-xn-DDz2CO
X-Proofpoint-ORIG-GUID: aYx2kDnGAmfUk6JD26qQan-xn-DDz2CO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=852
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410260089

On 8.10.2024 6:51 PM, Dzmitry Sankouski wrote:
> Add support for max77705 MFD device. Supported sub-devices:
>  charger, fuelgauge, haptic, led
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

[...]

> +	vib_regulator: gpio-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "haptic";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio = <&pm8998_gpios 18 GPIO_ACTIVE_HIGH>;
> +	};

Please try to match the property order in the newest DTs, e.g.
vreg_wwan in x1e80100-crd.dts

> +
> +	vib_pwm: pwm {
> +		compatible = "clk-pwm";
> +		#pwm-cells = <2>;
> +		assigned-clock-parents = <&rpmhcc RPMH_CXO_CLK>;

Don't you want to set assigned-clock-rates instead?

> +		assigned-clocks = <&gcc GCC_GP1_CLK_SRC>;
> +		clocks = <&gcc GCC_GP1_CLK>;
> +		pinctrl-0 = <&motor_pwm_default_state>;
> +		pinctrl-1 = <&motor_pwm_suspend_state>;
> +		pinctrl-names = "default", "suspend";
> +	};
>  };

Looks good otherwise

Konrad

