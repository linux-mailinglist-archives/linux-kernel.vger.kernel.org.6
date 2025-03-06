Return-Path: <linux-kernel+bounces-548943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E09A54B34
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E14C172102
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E8A1F03D2;
	Thu,  6 Mar 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="icMrSTub"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F25201005
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265463; cv=none; b=r8LIxGTBHhlvYWq0ZlrrFiIe/gM336MUAnhzcyfvDrpER5sMi2CwLMgJdkzkVA8S8TnRs43+YSElSc3+a/8RUeXobjcuwnCPfgoZoPv8WSVtS9h+539nmyJpf8EHO/nCftCJIl6+ncK8Eusr4gNDViSxs+qwzs9hwlGUCOQ03Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265463; c=relaxed/simple;
	bh=njxf6y5pyhmeInfBHOslV7CsXmJ8ztcHfHOXm07MRa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gt3424sgHGnjZpUnbtGW3g93EgzilCr9ei5N3/W8CkVzHJOIv61R0/+4HNTTSSZI4jMBGhA9fR5sgUGJpmjQ3nb8EI5otcd0r1euzuFjJRRHrPsXQJI+7gwrLkXi8w84AlKnIc3SwWLvfmN8E5e5Lg+uLnJeoRLTA/t8pNdJMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=icMrSTub; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526952Cn020153
	for <linux-kernel@vger.kernel.org>; Thu, 6 Mar 2025 12:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rR7talaNqtIpgG6BnMXQyYngWs9JqhRdQCma/K1hsFk=; b=icMrSTubB9SZAon0
	2lJr/BDocNqY3ulT0ybde+gZuGMWe14o5JD3jNuQoj1Y736/zZVqbZoeKX46ulE/
	wnvGi0zwiUxOnKPDqgX24Txszlk3XMnou9L51HOrmd5gznmkphiBKPCEFeKPmIEF
	GKyAT9sGu2V+sBE0bKjzYY0xHdyJIFGqXWHTs0ugL7nNQ8ui6opf+V0sosJeCGVe
	ER9Onww4ji8wKjL6+8vQUhKfpx4Y+LfzcnXUM4e694FYlvty5CvAdxRnyTgPgwF/
	SOW02fceiYlagUiBQeDsb6QrxAR939R9ydBjSTrZxCsS0M1rhdce03WwlFMcqJHf
	SXbQYA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 456xcuj9jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:51:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3c5833b58so18453285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741265459; x=1741870259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rR7talaNqtIpgG6BnMXQyYngWs9JqhRdQCma/K1hsFk=;
        b=ejTQx5BzFUAjb88/UMv5ao9rhVgsTBszR+bCx2Nin+cs8IWKxlUTJos3ArjA1QfygJ
         3wdgY5G1kkEBPIFmIDBpxKpxSqP6ewi/mdzeb/UHnawAzbNsjcTkR9Yj3Xd9LaF/4Sub
         bejawhfqQGeMxRnJ2Xmmjrc7qezgy6RPg7iC7k5jxSTSw4QeVzwzr9q3rjVNC+rbt7eG
         M52DcxUo/70o1LvGKyA7lsGrM1v9YGOQL39U2WCfpWO7HTmRBnG28I4m77FhAG6uO6ov
         fgWgXalg+O72o6JjS9DRuHErjrWWuZLG5o7Ufuac/RlWOyH7taq54U4X3X6CkehyrBZQ
         ls3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQZ6URvSVgtiGuUMHOJGa3tuFcyXsGpIOy9FUzGfKmh5jnQgz7yG27Je1tXMhDmhDvPlg8bwJemL9vtiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1iWTAouDh1QWuoCkrZSb0Vx6/meivGJG0MC45kMLhlZ/7MEs
	F5hW8ITjIQz/rqQ62aU4p4JYuer/bIwzWHdyJGvSIB6qV+gru+uSGO6e5vKSpbnSsZ3lAt98rmD
	irxh1Ics3ylefvMhEFctxoZiVC+myYIv21HsJfPK3yrzJWPvexrHgjlnm/nktTRiZtmnqzsg=
X-Gm-Gg: ASbGncvw5EU2+s22x41Q4q5CVOv05YKbdSnIN0Lw20f59P/NmqGpVSrLN1vgJmDvY56
	CbtdTguVLnfslTAhXe7DD+GJDnXSvmnhwH9YPKQWingaYvjIlF0pNJsGb6VnwdJJN/89rrqAMuv
	QgzijDZIFHrC0izBDMH3AawyLTKB9u8yuRMlAaOAW8KnVEc41akCR5kVIlqRVNGqLzLaRWGB/N7
	A1eEVyG3n3LQKIkJBs806wyQ6oDaD3qqnBv3K3OxlYaSE6ELBAdTGA28BoVvebspvgQpOUnKyWQ
	EmFDzQGxpljCVBXNmAUR/ODtTnZsvOcGj6d26+d3U1ar3/xZbzzxTfqcPUbxkk7awknNWQ==
X-Received: by 2002:a05:620a:45a5:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7c3d8eb1d1amr362886385a.11.1741265459249;
        Thu, 06 Mar 2025 04:50:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGFeZzV5Gmz2xjrjPxgVHagGLQpB8t4BoOY66hcYV5oNZhHazGLh/6he83HV2x8pZLW82bwQ==
X-Received: by 2002:a05:620a:45a5:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7c3d8eb1d1amr362885285a.11.1741265458827;
        Thu, 06 Mar 2025 04:50:58 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745d5cfsm908598a12.19.2025.03.06.04.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 04:50:58 -0800 (PST)
Message-ID: <5e72992c-170c-48b9-8df4-2caf31c4ae44@oss.qualcomm.com>
Date: Thu, 6 Mar 2025 13:50:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add device tree for TUXEDO Elite 14
 Gen1
To: Georg Gottleuber <ggo@tuxedocomputers.com>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wse@tuxedocomputers.com,
        cs@tuxedocomputers.com
References: <57589859-fec1-4875-9127-d1f99e40a827@tuxedocomputers.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <57589859-fec1-4875-9127-d1f99e40a827@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jmvtFFoDCVcM9NSBi02q4ZK_wDzwIs6N
X-Proofpoint-GUID: jmvtFFoDCVcM9NSBi02q4ZK_wDzwIs6N
X-Authority-Analysis: v=2.4 cv=eeXHf6EH c=1 sm=1 tr=0 ts=67c99a34 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=yDUiu3_GAAAA:8 a=n7UT6Et6nPPvcfnAv1EA:9 a=QEXdDO2ut3YA:10 a=RVmHIydaz68A:10
 a=DbJdjrQMpfET-33fQHBk:22 a=PEH46H7Ffwr30OY-TuGO:22 a=gafEeHOdjwYkg5oUpzAY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060097

On 6.03.2025 1:25 PM, Georg Gottleuber wrote:
> Initial support for TUXEDO Elite 14 Gen1 based on Qualcomm Snapdragon X
> Elite SoC (X1E78100).
> 
> Working:
> * Touchpad
> * Keyboard
> * eDP (no brightness control yet)

in case your panel as a PWM backlight, you will need to set the PWM
output pin function explicitly, see x1e80100-microsoft-romulus.dtsi

> * NVMe
> * USB Type-C port
> * WiFi (WiFi 7 untested)
> * GPU (software rendering)
> 
> Not working:
> * GPU (WIP: firmware loading but output is jerky)

Please tell us more

> * USB Type-A (WIP)
> * Suspend with substantial energy saving
> * Audio, Speakers, Microphones
> * Camera
> * Fingerprint Reader

If it's connected to the multiport controller, you should be able to
just enable it, like on the T14s, similarly to the Type-A port

[...]

> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../qcom/x1e80100-tuxedo-elite-14-gen1.dts    | 798 ++++++++++++++++++
>  2 files changed, 799 insertions(+)
>  create mode 100644
> arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 140b0b2abfb5..f0a9d677d957 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -298,3 +298,4 @@ dtb-$(CONFIG_ARCH_QCOM)     += x1e80100-lenovo-yoga-slim7x.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-microsoft-romulus13.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-microsoft-romulus15.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-qcp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-tuxedo-elite-14-gen1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
> new file mode 100644
> index 000000000000..86bdec4a2dd8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
> @@ -0,0 +1,798 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2025 TUXEDO Computers GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "x1e80100.dtsi"
> +#include "x1e80100-pmics.dtsi"
> +
> +/ {
> +       model = "TUXEDO Elite 14 Gen1";

Please use 8-wide tabs instead of spaces

> +       compatible = "tuxedo,elite14gen1", "qcom,x1e80100";

You'll need to define a new vendor in:

Documentation/devicetree/bindings/vendor-prefixes.yaml

[...]

> +       vreg_edp_3p3: regulator-edp-3p3 {
> +               compatible = "regulator-fixed";
> +
> +               regulator-name = "VREG_EDP_3P3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               // EDP_VDD_EN_GPIO54

C-style (/* foo */) comments are preferred, but these ones can be
removed, as they repeat what the code says

[...]

> +&gpu {
> +       status = "okay";
> +
> +       zap-shader {
> +               firmware-name = "qcom/a740_zap.mbn";

Are the laptop's OEM key/security fuses not blown?

Konrad

