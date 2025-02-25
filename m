Return-Path: <linux-kernel+bounces-531454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B21A440AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F01919C7D38
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865AC269895;
	Tue, 25 Feb 2025 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fd9Qrxgk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2828C26981A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489711; cv=none; b=bZjZUQBeehGpWPFwVbQdf3uvaeT7gPqyuoQm12agAQ3PKreO3lzspVA3dbeP0kJADBtRtypZzVMs7uVqPMPtA4QFjue1FgQIeQD7WNse+X3P0Rzv+XoBGS9H5ba9MDwNTXN2cNwNP9ChV7w7IZMgP16jL5E7Pgr1/QSdecvbEoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489711; c=relaxed/simple;
	bh=OpbzeKkRseA7inZVXOnlUwbCIzsHXlbkxgmG5l4Zwig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMnkMLVqbZ4QJjMZgjzugINrN3aTZJJPymXVajQqCEmrOjc6cBxS3ASd15/IUD1dDhY5EHxAZgjSprBuF5NuYmo/3Su8D5y6bWGBFyGzn6ngk4AIoCxzRbPabHP4/VfBadVEFWxxblkrvQamPz8qncdAKm6l1mcxIfmOrdsJ0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fd9Qrxgk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8e10v009176
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QHtRyNjcOSVP/X/SiQO9BwjBFj2Ol265XSaU4JsAGS4=; b=fd9QrxgkIXPu0joi
	ufsVtuT41EQz+S4oUzFwaBrP2XXiUQucdBdOdpO4Gip0g6kMGe0Xkjk86ZbhCSUC
	6zVxanSN11+/NYFGTw5HpWzDldgxtgX57C4WHkWqujZNTygJOZZK3cZYdyeGQ6zj
	Oh3o8AWhbfyAlWQyk6mUgODOZIhPBulQBL15HkO86WdkKvNjNm8O2zNIi/i3rE2a
	PhUj1qSqEraZRCRySqOul3phEIR/DNrQgKHuH6MUR44mo4AJK7YCWGWAfQj/FvK+
	kBEZHLoBPA+B7SFdcmlaSXgaHaK1UI15//38Dt/EEuhOIkcckAnU9eUbSIeSYKBm
	Tec9lg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y6y6ry2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:21:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e4546f8c47so12435846d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489708; x=1741094508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHtRyNjcOSVP/X/SiQO9BwjBFj2Ol265XSaU4JsAGS4=;
        b=mczCYa9uXDKgy1hZ6OFO/WiOYJGIV21L6bJJF6hwbCZKn22tF+6KqtTsUxiEBCBgs2
         TtUqc5IfGdyqsQ4OC3W/ZD/U7wtOCeE4ovFEVAmp7gxtHEoY7PHDHt4M7CtqFExKEcLb
         vchlDztiPlAYK94ylv6BgEeW7hIIkp1vkDshoHUGcgUHmz626XxEkUKMrmeXsLJzSE9Q
         FqyTRlBKqcdKjtXYkJ/J/OYssQOGzYYIn/rjVj5NtLSiH174VlYPP37Bf5YyiiWpF/97
         QpR0c3+YEdyuOnIsUMnDKVmfQ5dTz4p0/0/JGMa50e8htI2rkwWtCOvfGtNF3P0xRBTM
         LzLg==
X-Forwarded-Encrypted: i=1; AJvYcCVGcUwnqtUeUAwiTRqdLbQdfHK/efIdCR52IiBWzS4VQxEiru9+J3eVYavzvpD3cfosmtVwaUZNzjb7DNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQ7n27bg8AocnCgAstoVC21I8wUSPvigndK0HFycOHCTD5EPl
	On8Ko5YT0lzPJxI2OwpUr7+Ew9Qx4faOkq1PhAfSeN8rVsUPZfd3M4nWikNQXvdxZR1r8eU+8Lo
	qsJb1WKyI8+s2hXLR4jUMfYR7w4OdQAj6wz85ckXSZEkm5oPnpyUI1mzH3sWoLO2YW02rE/Q=
X-Gm-Gg: ASbGncvSLZU+M5n3qitrSK3FvEkmhp8kXyLPgzWmpieydsXU95+uXUFGFWETf6bTR2O
	T/5l6IQuy7cdagK0EGce5JMn/qF9vRRnI5ZUtK5pQBAHXroo50O9wOXsb5Zj09lp6RNH/Qmf1E8
	0bghLUj8cGPU1cgHsESdi1s1XsGheX5lqRA16SIA650ThduhDihaYTIL2evYg5G2decqPO2V9y5
	O0p2JBwYMgGIX35afAdTYgmdnlZVKR+i++i38ST5CcddUs87JZTEX3hnNPJo5rZvaKfdvFeop7a
	LQAS+AGtOqy4J1/ETPUEYSt2SO1Ycy4+q94Wdaobh56sAtQzN4nvy2q8Z9g5KJe5pgPh7Q==
X-Received: by 2002:a05:6214:e64:b0:6d8:b169:dcd1 with SMTP id 6a1803df08f44-6e6ae9ffd9bmr79440186d6.11.1740489708172;
        Tue, 25 Feb 2025 05:21:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGrIYl5tf/TCu42Wwk/SIStx0cn1EJs1IKMD2u2nNw8qNKzZ1EcWUmCmlg+83ihivsS6EQzQ==
X-Received: by 2002:a05:6214:e64:b0:6d8:b169:dcd1 with SMTP id 6a1803df08f44-6e6ae9ffd9bmr79439996d6.11.1740489707762;
        Tue, 25 Feb 2025 05:21:47 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdbf55sm142080666b.15.2025.02.25.05.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:21:47 -0800 (PST)
Message-ID: <bb447c8e-e64a-44bd-8b45-f161199397ae@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 14:21:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: Add support for Lenovo
 Xiaoxin Pad Pro 2021
To: David Wronek <david@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org
References: <20250217-lenovo-j716f-v1-0-b749cf4f6cd7@mainlining.org>
 <20250217-lenovo-j716f-v1-2-b749cf4f6cd7@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250217-lenovo-j716f-v1-2-b749cf4f6cd7@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iWOkbi3JPehz0rSklRbgGnhHdz5BmZ5y
X-Proofpoint-GUID: iWOkbi3JPehz0rSklRbgGnhHdz5BmZ5y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250091

On 17.02.2025 12:32 PM, David Wronek wrote:
> Add the initial devicetree for the Lenovo Xiaoxin Pad Pro 2021 Android
> tablet with the following features:
> 
> - Wi-Fi and Bluetooth (QCA6390)
> - Detachable keyboard & touchpad accessory (Connected to an MCU)
> - Fuel gauge (TI BQ27541)
> - USB
> - UFS
> - Buttons
> - Remoteprocs
> - simple-framebuffer
> 
> Signed-off-by: David Wronek <david@mainlining.org>
> ---

[...]

> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&volume_up_n>;

property-n
property-names

please (file-wide)

[...]

> +&i2c1 {
> +	clock-frequency = <1000000>;
> +	status = "okay";

Please add a newline before status (file-wide)
> +
> +	touchpad@60 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x60>;
> +
> +		vdd-supply = <&vreg_l16a_3p3>;
> +		vddl-supply = <&vreg_l8c_1p8>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;

interrupts-extended

also please align the property order with x1e80100-crd.dtsi

[...]

> +&i2c4 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* onsemi NB7VPQ904M USB redriver @ 19 */
> +	/* CS35L41 audio amp @ 40 */
> +	/* CS35L41 audio amp @ 41 */
> +	/* CS35L41 audio amp @ 42 */
> +	/* CS35L41 audio amp @ 43 */

All of them have a driver nowadays, should be trivial to hook up :)

[...]

> +&i2c15 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* SMB1390 charger @ 10 */
> +	/* ES7210 audio ADC @ 40 */
> +	/* FSA4480 USB audio switch @ 43 */

FSA4480 also has a driver

Konrad

