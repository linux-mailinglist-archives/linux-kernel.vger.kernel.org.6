Return-Path: <linux-kernel+bounces-566476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D80A67884
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4FA168FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59A20E313;
	Tue, 18 Mar 2025 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WW1Rw35d"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511620E6E0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313461; cv=none; b=V1ir0jucKkZBJEBD47R6oo30N9Jds7akfbsD2T5NjtAJYRRCHL94RhtGJnRZj0EZPlD1M1UTjQ5pJrXiojD0fQaKU5ynRwe+BdjgEgKpHLXBWEbWeGJdlwfWEqgkwywyUzEhlI6JQ13cbfSWJKgONYdcXYvmifxAa4nN4kLW3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313461; c=relaxed/simple;
	bh=DCJk0vDnkiwGs/YFeXYK7NVY9JSOcS3tfIJ4EY3c6bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUsPfsCiY/cvQdC7FNxGQ7oSKU0OWTVtCV4W4rnhrMbfLRmRZTi3YcQO/0VeB4JXiXxUl7XtXyW5H34wrNXnmohrneug/0W1wcFDKOQxrBepBbMC1VJhCwwuyqlskx4XMRIKy+Kk8fXnyKUpXv6gEyHliuW6wEKt9DjFvV4+HAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WW1Rw35d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I9RiqC029211
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FeHJEhC0iU+He1qad6Ja5YF9BG+A4eapl/2jYPrTqCk=; b=WW1Rw35d4u8RTEhr
	jDSggKqe1/vzABSj51PY3e/yoa0nzWmEAuxa4UoGcK2l9Flr358UOGgqka/ohqnC
	j08BBRjKV3AePSj+wr3dBfc8kDw2fWOXBeciBDH3RpUplhZT33ufpnH74lU2e1dn
	hoMMGzjCCgqRA2cimEvIwJOcaXwYQaxPaslb6WnulWfcAg3jMBMNuDQVuY8nommR
	r6v5ybt5/9RTel1CSF9rjiPXotY78ZNdkP8jCS2jU2nyv5/hF/XPOr2V71ADZFtQ
	lRU/T8M8pwMGDGUI3J3m9P9nhI5oLqyX2dyPT1AOCfKpk8c2TIvMN9vzcsZDx9BX
	V/OA8g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1x80v25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:57:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7be6f20f0a4so59142685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313457; x=1742918257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeHJEhC0iU+He1qad6Ja5YF9BG+A4eapl/2jYPrTqCk=;
        b=CfvX5JmalYIeMkzyVL4zj7a6Yant0oA9JZxb0HQtq1fUDE8n7Sw/iacNfBjUzOEm6E
         TXkYY+bElN4e/vSb+KV9M2o9+MNzpvAPx8Y2P8y8+JBiI/RWbjrO4xat22vXO4/VquIv
         MSxVyBnG11o2lKooNzaWwSVMlDJeaCWjqGBctwFlgwu5LkQdfjr0coFWwwas8YWcnFma
         obBExf9vnXNL1+tc6Wsp7y3HzFrtEDUDZl/mrQ9h5ndNij/3jFixJbbe+JLDbAlJBMyT
         K3ArObSJV8ARf08eokcm6P5IXIOX3ANgTT7gWbU3/xo8NzpXjacRqGzHNOKJIyVcspvo
         SlUw==
X-Forwarded-Encrypted: i=1; AJvYcCUc1wD/KnyRBqM4lcvlTvG+0Vk5O+brr/NiCY+jIjo2PnB/YNG6ZDCDuJShK2At8ZWQb1I/GWKXIy1SPZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkEOECmAz2377UIGxZeOs5Ac9kRfupppPHkoASm1seQIeOlEw
	s1zv33KWlmpncz4ZvxSN9EpO8gmX7606OsxobV0B9ecFtgtRP5vE5lsBFROk0ShDj8T9ojP3yjq
	vHSwVdv8F3yrEs/mg3w0Kg9BZGtBzpGZvEFNos8rY8VkRYuVoGxOkG5ckyjf1iEwyaQ2WOXM=
X-Gm-Gg: ASbGncvMLjsf57Li39hO2JwBucWDgiMz5PTyhRGTsM7+vUwm77u5eB6HPOaHeI609F5
	lsuj8dU6qru7li4xrxKPm5ytne89SuHaYhxT0KNi/C2OSZnKh446rKpNYc7CznX0YRlTEeAEB18
	Rh/qNw5y2exx6KMHwA0Ct5t86ROCl+DZlxeK3FnRIk4lJQY6CLbIJOvzzlUkL6Nx3sn/0wRP4Uq
	GcD/k20EJpeoVFbrdGa9x5EITnl6ZaCKnzGRpQiXcAQyVaUCQ0ZmatCONz+YATrd3MvMcQgTSRD
	Mc+vyITJfzadpQvAr74qWNjYert4I1qikwRZut2loJQJejLb6KBUIowyjpF5ySvIA64Zog==
X-Received: by 2002:ac8:5d51:0:b0:474:bc4a:edc8 with SMTP id d75a77b69052e-476c802e949mr102101021cf.0.1742313457538;
        Tue, 18 Mar 2025 08:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrg6Me9RJqrQL6OlFw5UaljHV1F1lZL86EsHOvErE3FXJgcBWNqdW6vNoLgdq+29YE/UNF4Q==
X-Received: by 2002:ac8:5d51:0:b0:474:bc4a:edc8 with SMTP id d75a77b69052e-476c802e949mr102100921cf.0.1742313457210;
        Tue, 18 Mar 2025 08:57:37 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149ce8efsm869552766b.102.2025.03.18.08.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 08:57:36 -0700 (PDT)
Message-ID: <66049cc8-3e4d-4d5e-8ff9-67b408e5b1a1@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 16:57:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add device tree for TUXEDO Elite 14
 Gen1
To: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wse@tuxedocomputers.com, cs@tuxedocomputers.com
References: <57589859-fec1-4875-9127-d1f99e40a827@tuxedocomputers.com>
 <5e72992c-170c-48b9-8df4-2caf31c4ae44@oss.qualcomm.com>
 <5hvghahezqms6x4pi3acgaujyhiql6mzl2xhzph5phhki2yiyq@oi3xjatj7r64>
 <129bf442-2505-41c8-9254-ad7cacefab89@tuxedocomputers.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <129bf442-2505-41c8-9254-ad7cacefab89@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: T412vGO06ic60WIOEvQNntP0cFaeoMPd
X-Proofpoint-ORIG-GUID: T412vGO06ic60WIOEvQNntP0cFaeoMPd
X-Authority-Analysis: v=2.4 cv=Jem8rVKV c=1 sm=1 tr=0 ts=67d997f2 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=prfVWYIJzO_NFut4FmcA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180117

On 3/18/25 4:24 PM, Georg Gottleuber wrote:
> Am 07.03.25 um 07:45 schrieb Dmitry Baryshkov:
> [...]
>>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
>>>> new file mode 100644
>>>> index 000000000000..86bdec4a2dd8
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
>>>
>>>> +&gpu {
>>>> +       status = "okay";
>>>> +
>>>> +       zap-shader {
>>>> +               firmware-name = "qcom/a740_zap.mbn";
>>>
>>> Are the laptop's OEM key/security fuses not blown?
>>
>> Can this laptop use "qcom/x1e80100/gen70500_zap.mbn" which is already a
>> part of linux-firmware?
> 
> It seems so.
> 
> Because there were no logs about loading zap.mbn, I activated dyndbg
> (dyndbg="file drivers/base/firmware_loader/main.c +fmp"). See attachment
> for dmesg output. But GUI freezes after sddm login.

Okay, have you updated mesa to something recent? Try the current state of
main branch

Konrad

