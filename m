Return-Path: <linux-kernel+bounces-576284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609B0A70D56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619E6167C88
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFDC26A0B0;
	Tue, 25 Mar 2025 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A6999KLI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832C269CE5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943526; cv=none; b=GLZ/Ctcc4dDs4QVVjbCVa5CCEt32TjGCydezfXYA+nla39XbtRqxdpO9EapVnPlcH+0ew2vbwbIV18jluivv4lBubgJWug1x3EJRcXirGwwl31ABzQfzuSt06y7DX3uU+4BVoQt2+Jxsn51OjVYDJZzI5SAjNg/qCVo1hmSvelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943526; c=relaxed/simple;
	bh=Z/y6mJiLJp8HFySWM1EYtA+bwRhHRXWpZhYEF2TQ6WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCgUsLohVreYbnZLIdu2G6EcalUYgNvQY00O9I57x0wbWImjKMBoI9LsrfKYRjWNBcg4LMTTiFa+WFFUp08e3xJcgAdASFfp6La4e/dsTiQi63yedKKnSCsP5eTc05kwpdbpzmGLWe6wPyUEhfJBSf32paHgxTUuYyiUh3yuFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A6999KLI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGai4O004833
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j7cASkMJs9s2On5tUArhdk6ea7g1dAT8ajgqhRmsXi8=; b=A6999KLIQuhUfagj
	zVOaeZT3dEIs9v23e4X3+Hw8FMnorG94jymU+F9ImEMlsG9oXt9kCXo9j6uZ0ZLe
	TQ5I5puG0HECyQLY8e13dfRiUM9xJoyGQOy1dTW1iRchX9xelZrRHaPAx2ufHgbU
	ZJtcmv92b4P1/Q05wYhPAj5ul9xVrkpY/Cj9fpmTwNoOO3RPdwqzsEdrzJYuLg9n
	SqqV4xLpOc+iSa311mf0jj7mCoPRLHZEEU2sAr59kkRKmgPecLlm76BeANUv5973
	ou7ehhOk9Fbzv3r5A66rYMDtEeMhO7JPiLO2o/+2ELGVFa5rTKjR7iJWU29FcDKN
	t3x0Rw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyps8w6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:58:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c3c8f8ab79so879245185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742943522; x=1743548322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7cASkMJs9s2On5tUArhdk6ea7g1dAT8ajgqhRmsXi8=;
        b=Q80IOfJVpULdesfNXeTqHdXuEXvtv7g9e+rA2N7DTo+FHNmFRyENayqgbSmkLYmKMp
         ucx/mbNWZVPZwLa1kIqPyaOI7rwCQ8LRr0NCNlCmlTr76oyEV+LsWReKg3N4lorW+9Rj
         7lKxOLDXl7tmughrjnbE5CVSRix2OYPukn5X9DkN3WyJ/SexkXY//dF3DFNfa8v7zPP1
         MkuXdZZK3lmhMGKiE5AcUGA5nybdFgLb38MBUpE0XnXX9wEMiqM7jPYPZoBdZgDxgcxb
         jFwfEvzZNJR4edvIy7dwbWUjMRL+Co3AkO83smF5bUO/ejYAbUtKW2zNVkALmiuKEkI4
         r9lw==
X-Forwarded-Encrypted: i=1; AJvYcCUSrUAPmYiz2QKb4yVVM/y4PhiXTKUNY0O2sI/rArp9WnUyk7OxlW96HUJt6lDImenuPtAD3lux3Y+fipw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlT/V5VoAefjjMXpUcXGIB7LRWeAoQTDBIHTVBvacec5LXrhVh
	4FsxG9aDM0+IwAbYeFZK09eV9gqywCsOlAHV9zNIbz4NLn2olE8+J9kP/MR/0PSCEcU79sb0RQm
	Hlqx3V4E8SSl3NdCJSO7cvvxsYBHmAiod4v8ZmxggWDpbL7rOrfW4zsuxeZWkqhM=
X-Gm-Gg: ASbGncvCqlZqCtT7MAvAJVmmRIn62ZIr/0bVSPKq6FdOQr6O4X9IqwQw2FhdtG/amPr
	O9tCdJNN1tOE3J1yG7EFHQrIY2ZMrpyLCTQKGG5T0kqmaoino3WcbkcI5h9shxkY9Q/j9O/aiMM
	FDk3NOGBNVE/edCVMm/bcQZNV0pZCZUwHt+rh7y388kN6l3GVN1PNLeFhXs0Pa77z0baNWEgcW9
	vL5qfBfAJTdIC5RRiqVSLDtg4jpQI4z0JKxUwwj9aYlKvG51N3my5iEJe+MAxLy91ZNjXiuCSoB
	3heQ9bux1/2893Jw6vQQqmNPNKWz3y8u7r1HQABWF4k5x7dfCBS3jJZgJAutGu760nq+u9juJ5O
	sQwOFYrtyB8F546FH6l23xLHqzY4FSo0aypOXoMnniSg7ljkAscC2KqA5e+CTZFGPlpWIquTg
X-Received: by 2002:a05:620a:29c6:b0:7c5:3e22:6167 with SMTP id af79cd13be357-7c5ba18485amr2798803185a.23.1742943522232;
        Tue, 25 Mar 2025 15:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdhqOT+2PpPpIz2kYCxa+wKuV1xSTgF0K8M8p6Vt0yMIoOuFSU0fElZGTZMSysHiTifnZv9A==
X-Received: by 2002:a05:620a:29c6:b0:7c5:3e22:6167 with SMTP id af79cd13be357-7c5ba18485amr2798799785a.23.1742943521700;
        Tue, 25 Mar 2025 15:58:41 -0700 (PDT)
Received: from ?IPV6:2001:14bb:112:599c:156e:7946:30e2:6502? (2001-14bb-112-599c-156e-7946-30e2-6502.rev.dnainternet.fi. [2001:14bb:112:599c:156e:7946:30e2:6502])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7c1c17sm19276581fa.21.2025.03.25.15.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:58:39 -0700 (PDT)
Message-ID: <366202bb-2087-495d-8bcf-9fe05a9c7767@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 00:58:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: x1e78100-t14s-oled: add eDP
 panel
To: Christopher Obbard <christopher.obbard@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>, devicetree@vger.kernel.org
References: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-0-e9bc7c9d30cc@linaro.org>
 <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-3-e9bc7c9d30cc@linaro.org>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-3-e9bc7c9d30cc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2G4Pm2gwx_ULT_NBEjH1L6UOvyTLGCmz
X-Authority-Analysis: v=2.4 cv=fIA53Yae c=1 sm=1 tr=0 ts=67e33523 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=Lw57bTjF4WcXWk72GT8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2G4Pm2gwx_ULT_NBEjH1L6UOvyTLGCmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250152

On 25/03/2025 21:21, Christopher Obbard wrote:
> Add the Samsung ATNA40YK20 eDP panel to the device tree for the
> Snapdragon T14s OLED model.
> 
> Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
> ---
>   .../arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts
> index be65fafafa736a0401a5872c40f69cb20cfbbd90..753add73df41050565e71b9faafee62bb2031b75 100644
> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts
> @@ -10,3 +10,13 @@ / {
>   	compatible = "lenovo,thinkpad-t14s-oled", "lenovo,thinkpad-t14s",
>   		     "qcom,x1e78100", "qcom,x1e80100";
>   };
> +
> +&panel {
> +	compatible = "samsung,atna40yk20", "samsung,atna33xc20";
> +	enable-gpios = <&pmc8380_3_gpios 4 GPIO_ACTIVE_HIGH>;
> +	hpd-gpios = <&tlmm 119 GPIO_ACTIVE_HIGH>;
> +	power-supply = <&vreg_edp_3p3>;

Why do you need to repeat hpd-gpios and power-supply properties?

> +
> +	pinctrl-0 = <&edp_bl_en>, <&edp_hpd_n_default>;
> +	pinctrl-names = "default";
> +};
> 


-- 
With best wishes
Dmitry

