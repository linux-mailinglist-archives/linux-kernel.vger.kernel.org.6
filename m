Return-Path: <linux-kernel+bounces-443551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59C69EF6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD8C177E71
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6BD223313;
	Thu, 12 Dec 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W/riB0kA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C35222D5E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023640; cv=none; b=KVzHI4nkDM1Ixb+1Am5kXd19JkkyBC69gPpTDq9GjhqX9l+pL3fdyCTnHwglrUCd61qZKpWcqb0DtCd+V2bFCG4DOq5u7d8XQUHEimQBIhyKIbZloW2J8wXk67bWoN4QYJsirRrtnU67hm9EWztvk1vtiPnETS+bTp3O02wdlAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023640; c=relaxed/simple;
	bh=W0LUSqX308BwBxT8TRJsnUAJTHx07QDNGNUrQe/gmhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwVQPV9di6ATx7dKwMNDkE1xSO81+nnFq8DVk6PflSmJ3wJWYpQhbAIcFcaSUseZYA2kFFQ7NuvVi0lMMxZMIt3iE2kAObJPUgJh/1TQwANYTaKPtrV+cqN+r1uTBR3+PPr9wSwMPh/dp+BQQgkJwXG3xKXTUAuNtWLZmwONMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W/riB0kA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGHZIT015003
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cuh45z2TdlFDNIhWgxGy/jJNcB9fIJPtD1vTetbFoNY=; b=W/riB0kArYFzhAaq
	N3yeiXaHG5X519cA7pgL5jusCLtC58NRao88qOphP6DEYfRWulzTCTFWnCvQ+Cx8
	Xtm0SZdj/o9bWqivjZzf0QaL7SVw+/u3U9AHo5n36gGUvDOFt27q6SGg8vXUAul7
	IB9fAB/O4FGB+4fK8Q1ZAlZz/CTDCN7w0tUwiaR95cNOhBki9qsmiQ6zXFgNIUaA
	CD2qOQkgLaRKnZrpkeDE6VLDpHtELnPs6oc/yduRK2Ul5Tz+iWKZmIHSz9uEe/V3
	qW/tcfhrzgr+SDiAJ2SCL9yEfiAgtH46FEKCSW6g9L+KIJ2fTDccuxGlCHDfXMjp
	UTxdgQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f7dpn047-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:13:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e5c3a933so5804285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734023636; x=1734628436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cuh45z2TdlFDNIhWgxGy/jJNcB9fIJPtD1vTetbFoNY=;
        b=HmQbWDhDWtyUOTvBU4BkLwI3UQ3Zgxr2a6a/MctMdvSAlKekS+9irkowcVVzrr1rCJ
         5VdDQRVuxx6vSl+0CzKw4gXN7udWEx1U4+e9bLHsYvlivWvF3ubQRfJ7cC1sG6F42E6v
         gBv+aQLwF1TioVIc4IMBEkkBc//TPPBbvQGcDkW8iazD57U9Bt054q7eECL2y5usskiT
         B3XaOVVGJ19kglxhhGaJQfbYgHagXW66QrVpBO9NVdJn1Hqt7gPrXZ5emiCjjlxY8ZyC
         bjnZ99mQtFhwqZ0wImwJeb4Oon6s3I8fh6lbj27yWhT8ZYG9ffrdIMuAcgStGAfmxIfZ
         qPHg==
X-Forwarded-Encrypted: i=1; AJvYcCXOdoBxl73a+imCS+MfoPVdsSRRPDQZ2IWKhq55wt/UjhhHsZLKD69uWR8TiDc2jCn5f8GQ6OB9e8CVicA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwClmhC+m/hrEkGkRLUWnIx6cd0V8x+H85O5pzTKbhJYMF36QlS
	ST+6FUkREq+sxdyGB95DfHy5PpoN3mBblt64ZxZIN5lMOebAtE/BbGdkUkgA59Rd2NJ2g5TH0dr
	f4vYpUzKaxNBZLpzsRJqi7SsYeV6RLbqkGn3yXOV893axcoiA0+G4FtKX9exeWOA=
X-Gm-Gg: ASbGnctZ57gpgDUIlU2rWQtjZD4AmbkwFWzGj2S1F1lBg0+eKGVjJOvFdYgmv98/pgI
	Zs4MQXXIW3wfT6PfdFCXunytAwqKi5Uxg2hZb7cQEElJNdGB6zCSnXpbAz5bxbcvkgUQVP8suTk
	gH1H7+AOidByzKzLX4gNgt5CSDTnKfCkP+DF81lepzpI0bYRHTC4QWzD2/doHvUUD0syBzStlO+
	lm1C54ZQNNGXrRgKpm1wpVzBLwPPxd8qdyiPi6t0Ut4gw2ScLkkWAr3v0tRRd674jLJFcpubMTS
	CKK/YN3oJIfGH2cCQaecPpqVS0DeyeY04gp6pg==
X-Received: by 2002:a05:620a:46a4:b0:7b6:c597:fb4d with SMTP id af79cd13be357-7b6f8905259mr68063485a.5.1734023636278;
        Thu, 12 Dec 2024 09:13:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4wsjDzWR7bxAHL0XxqOmES4gHtGRgiZ+/uv4KzkmRM74SCycMZbDe1RMwwIP1e3MzyS0aog==
X-Received: by 2002:a05:620a:46a4:b0:7b6:c597:fb4d with SMTP id af79cd13be357-7b6f8905259mr68056585a.5.1734023634090;
        Thu, 12 Dec 2024 09:13:54 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69448304asm537489366b.45.2024.12.12.09.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 09:13:53 -0800 (PST)
Message-ID: <d5813d64-0cb2-4a87-9d98-cebbfd45a8c0@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 18:13:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add Huawei Matebook E Go
 (sc8280xp)
To: Pengyu Luo <mitltlatltl@gmail.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gty0622@gmail.com, chenxuecong2009@outlook.com
References: <20241211153754.356476-1-mitltlatltl@gmail.com>
 <20241211153754.356476-4-mitltlatltl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241211153754.356476-4-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: w7RBi3r0A1EbNgpsOiuHvCVwxll-2v-C
X-Proofpoint-ORIG-GUID: w7RBi3r0A1EbNgpsOiuHvCVwxll-2v-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120123

On 11.12.2024 4:37 PM, Pengyu Luo wrote:
> Add an initial devicetree for the Huawei Matebook E Go, which is based on
> sc8280xp.
> 
> There are 3 variants, Huawei released first 2 at the same time.
> Huawei Matebook E Go LTE(sc8180x), codename should be gaokun2.
> Huawei Matebook E Go(sc8280xp@3.0GHz), codename is gaokun3.
> Huawei Matebook E Go 2023(sc8280xp@2.69GHz).
> 
> We add support for the latter two variants.
> 
> This work started by Tianyu Gao and Xuecong Chen, they made the
> devicetree based on existing work(i.e. the Lenovo X13s and the
> Qualcomm CRD), it can boot with framebuffer.
> 
> Original work: https://github.com/matalama80td3l/matebook-e-go-boot-works/blob/main/dts/sc8280xp-huawei-matebook-e-go.dts
> 
> Later, I got my device, I continue their work.
> 
> Supported features:
> - adsp
> - bluetooth (connect issue)
> - charge (with a lower power)
> - framebuffer
> - gpu
> - keyboard (via internal USB)
> - pcie devices (wifi and nvme, no modem)
> - speakers and microphones
> - tablet mode switch
> - touchscreen
> - usb
> - volume key and power key
> 
> Some key features not supported yet:
> - battery and charger information report (EC driver required)
> - built-in display (cannot enable backlight yet)
> - charging thresholds control (EC driver required)
> - camera
> - LID switch detection (EC driver required)
> - USB Type-C altmode (EC driver required)
> - USB Type-C PD (EC driver required)

Does qcom_battmgr / pmic_glink not work?
> 
> I have finished the EC driver, once this series are upstreamed,
> I will submit a series of patches to enable EC support.
> 
> Signed-off-by: Tianyu Gao <gty0622@gmail.com>
> Signed-off-by: Xuecong Chen <chenxuecong2009@outlook.com>

Your commit message suggests Co-developed-by: tags would also be
fitting here

[...]

> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@c6200000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0x0 0xC6200000 0x0 0x02400000>;
> +			width = <1600>;
> +			height = <2560>;
> +			stride = <(1600 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};

This should be redundant, as you should have efifb

[...]

> +
> +	wcd938x: audio-codec {
> +		compatible = "qcom,wcd9380-codec";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wcd_default>;

Please follow this order throughout the file:

property-n
property-names

[...]

> +
> +		reset-gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
> +
> +		vdd-buck-supply = <&vreg_s10b>;
> +		vdd-rxtx-supply = <&vreg_s10b>;
> +		vdd-io-supply = <&vreg_s10b>;
> +		vdd-mic-bias-supply = <&vreg_bob>;
> +
> +		qcom,micbias1-microvolt = <1800000>;
> +		qcom,micbias2-microvolt = <1800000>;
> +		qcom,micbias3-microvolt = <1800000>;
> +		qcom,micbias4-microvolt = <1800000>;
> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +		qcom,rx-device = <&wcd_rx>;
> +		qcom,tx-device = <&wcd_tx>;
> +
> +		#sound-dai-cells = <1>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mode_pin_active>, <&vol_up_n>;
> +
> +		switch-mode {
> +			gpios = <&tlmm 26 GPIO_ACTIVE_HIGH>;

This could use a label too - "Tablet Mode Switch", perhaps?

> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_TABLET_MODE>;
> +			debounce-interval = <10>;
> +			wakeup-source;
> +		};
> +
> +		key-vol-up {

Please place this node above the switch-mode one to preserve alphabetical
ordering (see [1])
> +			label = "Volume Up";
> +			gpios = <&pmc8280_1_gpios 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +

Stray newline

[...]

> +
> +		/* s2c, s3c */

Please remove such comments

[...]

> +
> +		/* /lib/firmware/ath11k/WCN6855/hw2.1/board-2.bin
> +		 * there is no calibrate data for huawei,
> +		 * but they have the same subsystem-device id
> +		 */
> +		qcom,ath11k-calibration-variant = "LE_X13S";

Oh, this can be taken care of! See [2], [3].

[...]
> +
> +&sound {
> +	compatible = "qcom,sc8280xp-sndcard";
> +	model = "SC8280XP-HUAWEI-MATEBOOKEGO";
> +	audio-routing =
> +		"SpkrLeft IN", "WSA_SPK1 OUT",

Please remove the line break and

> +		"SpkrRight IN", "WSA_SPK2 OUT",
> +		"IN1_HPHL", "HPHL_OUT",
> +		"IN2_HPHR", "HPHR_OUT",
> +		"AMIC2", "MIC BIAS2",
> +		"VA DMIC0", "MIC BIAS1",
> +		"VA DMIC1", "MIC BIAS1",
> +		"VA DMIC2", "MIC BIAS3",
> +		"VA DMIC0", "VA MIC BIAS1",
> +		"VA DMIC1", "VA MIC BIAS1",
> +		"VA DMIC2", "VA MIC BIAS3",
> +		"TX SWR_ADC1", "ADC2_OUTPUT";
> +
> +	wcd-playback-dai-link {
> +		link-name = "WCD Playback";
> +		cpu {

Please insert a newline between the last property and subnodes.

Otherwise looks fairly good!

Konrad

[1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
[2] https://lore.kernel.org/ath11k/ZwR1hu-B0bGe4zG7@localhost.localdomain/
[3] https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware

