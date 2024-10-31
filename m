Return-Path: <linux-kernel+bounces-391293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BD99B84D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82EA281795
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B7B1CCEF0;
	Thu, 31 Oct 2024 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OqRzQIFa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7669183CAA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408433; cv=none; b=KuAfvlw+iGgUmyYdH48XXLeffK1HheqvXaRQYGMcyTQguRZWEthwaibUAwh+ToiuPylLMPqdQMYkbR1jN+rHAcUD8BLazqiTBXnZy9m71RHH1RxEnUkiCuWz3Fha3GIrYuJAlB5ldwPBHB9TqNwisoXvvh/gUd7I3ZdmCKWB1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408433; c=relaxed/simple;
	bh=9p2L/gsUOtDAw0oVvraU/aabiEdBTQXQnBMzEvVuzpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yxb4+OutAh72PMdtyjjgadSlvKreLlP44gfMI8ukuXZlckXM752xiAVUmpSo87jIzVv3kpsJZp7RfrRexSIfGUZo65yv9/y0g6lkYqwhOviSyFsOJXCt8Bzv9YAvHIOcno3P4Jvq0JywWjr3UNf3EeP+dEEUrmxU0LYkr4RPEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OqRzQIFa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VCgKFO026712
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cQXYDYwMp5w/UPDufraPkZVemoBNsCrL5WS+2fWGtzI=; b=OqRzQIFasekmk0bc
	Qr98VHXL1g4GLDFS12CKQ6aGI+NuaA6ZWBLeCvJw2yTr2S/gC/1a7twRR8NcCDDq
	68J9z3yNluVj1eEORquAkEqY3nEhCoYHiqLGNK156VGalNvF3qAtDwqrqKUBsGdM
	IH0SoGwZ0lAnz3PAyUbxZVlAYzV728VulNOXHbGN0ocp+NlelBsTkTc+ptXnrsL6
	E0EzDOevLfEGYJ/nPzwxvNjmgtsYP3S11673quQLB1MaMhg9bXkgewHJ/hg/bdug
	rf+vVhS39+qfJjoT3wF63z0MgY0k0+LuT5WjOaX0dGaSPgRzvqc2mQKVheF+VNsI
	vnvLsA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42k1p386ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:00:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b1b20170c0so13354685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408425; x=1731013225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQXYDYwMp5w/UPDufraPkZVemoBNsCrL5WS+2fWGtzI=;
        b=groE9dfNG28TPWd9GlMEvkMmiaW8AlkuZmznWekd0ljOZ7hTBwRhvwOyTTmG34Xnbm
         so7D82AoBHjwF9CgUKB/er8x1ryHnQfAiMHEqZEp7PpLK7kZbiv/KItXVJKctbLH97Vo
         BwGNE5WeU/Fzd3WNx2lxhhBUPh3whFBE0gln8xWqiuMEGFUvwd6zwvYr+H1q4AXs/BnJ
         D1BEPJuCPBT9fgRrw7/6npL/9T2fbwCHk86iQ8393JcB/cXQToYudSywyOFsOb6DuUJ5
         fjZZX+gMSKuBjGMcU1eHK/HTM9eVHDMq4tnfFzXXsoFfkDBoKwlCEkHUJPw3tx2SZb/e
         yUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzCZkh23It8LTorRiJ9BxwSywXXZoGfzR0eSEsEdXRqY1clR3mcRfGnlUUZqp8X1v9aycOPQ/mthRJPCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVjA84DwTB9pGllUGQLemU+nGltWjqTCrwlO7AsTvk+Dizsim
	LCFzjNS44k8L2NSaIF2cohmFMs05iPiMTZUHAKRPz7EqMGvT4lT7h/oIlpiEEWPJb69pRA3pa/e
	eo6588RCSBPQCqSWBC2ZHX3CPLYna6HkoNDLlWM8iBHmbZsODPKz7xbDdEOtrs9M=
X-Received: by 2002:a05:620a:4244:b0:7ac:bb36:599a with SMTP id af79cd13be357-7b193f68d9dmr1396483285a.13.1730408423701;
        Thu, 31 Oct 2024 14:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7X3DXyUEHB5jUA7SsCpLG6ODedxFLxLwr5aSO7qvzGjyUq4xOk1NXhSiKUvlHHhYkltCg/g==
X-Received: by 2002:a05:620a:4244:b0:7ac:bb36:599a with SMTP id af79cd13be357-7b193f68d9dmr1396480785a.13.1730408423177;
        Thu, 31 Oct 2024 14:00:23 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c4f2dsm103158466b.52.2024.10.31.14.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 14:00:22 -0700 (PDT)
Message-ID: <304b909d-bf2d-446c-acc9-e65b94627468@oss.qualcomm.com>
Date: Thu, 31 Oct 2024 22:00:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: x1e80100-crd: describe HID supplies
To: Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241029075258.19642-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241029075258.19642-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: u4fal6slEeWdz3IeasmlMYbo9xildQeW
X-Proofpoint-ORIG-GUID: u4fal6slEeWdz3IeasmlMYbo9xildQeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=824 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310159

On 29.10.2024 8:52 AM, Johan Hovold wrote:
> Add the missing HID supplies to avoid relying on other consumers to keep
> them on.
> 
> This also avoids the following warnings on boot:
> 
> 	i2c_hid_of 0-0010: supply vdd not found, using dummy regulator
> 	i2c_hid_of 0-0010: supply vddl not found, using dummy regulator
> 	i2c_hid_of 1-0015: supply vdd not found, using dummy regulator
> 	i2c_hid_of 1-0015: supply vddl not found, using dummy regulator
> 	i2c_hid_of 1-003a: supply vdd not found, using dummy regulator
> 	i2c_hid_of 1-003a: supply vddl not found, using dummy regulator
> 
> Note that VREG_MISC_3P3 is also used for things like the fingerprint
> reader which are not yet fully described so mark the regulator as always
> on for now.
> 
> Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

[...]

>  
> +	vreg_misc_3p3: regulator-misc-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_MISC_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pm8550ve_8_gpios 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&misc_3p3_reg_en>;

property-n
property-names

for consistency, please

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

