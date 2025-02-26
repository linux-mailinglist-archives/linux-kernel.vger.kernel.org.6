Return-Path: <linux-kernel+bounces-534546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867FA46857
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA48018862A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AB6225415;
	Wed, 26 Feb 2025 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TLbvm671"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F078721CFE2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591869; cv=none; b=D8cpWQMVcTiZVH2Rsmj6y7nCWvSPfcjS/peMkVNV/bo7L5+A6KFulKmr+fABCGt3VGzBcIORs/TWioJ+y5gFZcEJYEtKEI72dZeLl0cnuhAm8W9j0scIWqU+RyvkC02z7iq2cFpRpFpV8TfNlYKvc2gZhnMR2aZSY2mZBwTcUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591869; c=relaxed/simple;
	bh=5NPd0gbJaBQc5ty19IyjXQmXjry0M1PwaEWw3OtxkGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/52yqMmsAVt3uNDaEJB+qBnL7i7IC5N8f9IDb7JhDafA9QliAG6dl7Ydrq+wCzCY6ti3FfqDNEdu/Qx+IL3pRsM7gxugCgec+gstrp6cOWJbSNCM9XR211y0eUxl4ZliNfPO0Wqe4xtEKQWZnFJ8VoTjJQWn+c9Tn4opJ0RO7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TLbvm671; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q9QvGx023836
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AbH7yWgbIowaWWXxQHvQvo6O2OCV/d94NfzAPzL6qDc=; b=TLbvm671Jtj1A+q6
	Il/9LTSPqyEqUrlEmyzLFwAa1LNN7EOlvlCn9/C463bm9/BUFYc6tIolYQayKLp0
	neR8NbsciArk+tzGtfeqH/NhYFI06Tzx3ZMVo36eiDsvyNYQzbOg+rzD7K5ArLzd
	4+AIPDNf/jb1FWrd0qfOZw7TcE7GPebv1b85Ptk4epGGFQb0v6KghsK5eYxNYAOZ
	qj4tRPGUbaRXMsTzaorjx/AKgegB9NlF9IXP99Rg619l5Aam/jgjgVmhyH+vZsWW
	murj9rbVATNWuDIHl8/VwP9IT63uMLh90FW8d7N3EGxfjK0j2CwGEtaE8gKuC5lL
	VN+fDA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prmjtus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:44:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-471f691c847so117521cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740591866; x=1741196666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbH7yWgbIowaWWXxQHvQvo6O2OCV/d94NfzAPzL6qDc=;
        b=eqqw6TwoJG9dfXjNn/F9W0JltPM5e8TiN+g/n3IgFzpkEgQlY/AIQVvGzsINplJP2/
         5k3GoTW9yg4PKTePrbVg3Khhntz1aoH8BdcyF79xYYY3nxFvImrfrkiSSZdyIJ9w3M/K
         JOGCtN19L4yG58L2m5WPxdZd0alvW1ZCCuagm7Vvv2UGxyg8XKnFR+R83YrftLdh2uF0
         N/8f02m+TKCchshFka34iW8Z+T7uRBcFBnmfTDY2zRuxZboOHb99PbDXJxoDmFFlSGFG
         uymn256AQSpcn1FyMFsUGvw+fweZZ/Lk8+IZpLG++395kuZgbxTeuyC86vuCmdYQJsTy
         eCQg==
X-Forwarded-Encrypted: i=1; AJvYcCU8CjaqyPIIARcExwEy8Edq+ZUsYlWcUr6TFVbAkQhEH1LRWT+ujseFFWtGYKbP21rUaJuRuRxjHYM5dBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFm4wcxQpDaMJRSlsxMOFioo7XTk7On3OOQcHfdC9ZlmsVcPN
	zBPkqv5KmcQUtX9L6IarZ23nov4giXMkmyzrEgToYSLe/qHbxtU2fG56tCuKqGo0pNQBPI5B0Z3
	6vqM0zgB273Imw7ris2oIQydKgdtwpTIgEoIPVVkC0yTC+3fMzOIwfkDKYMsXD48=
X-Gm-Gg: ASbGnctM0ftmdsG+KhlSWOkIrmQrXh9vOvtGLHnjaNkbiunY406LiYG9JtEdfBMn1UX
	DutLWcdeS0FQoszyivOSmxjqN5hXwbM9yjVNNU5CCuzX8Gdq3ttnR0GqmjZf1NMjl/2DD5yKA/6
	CoMLTjKlisPZQUJgNSglJrXdUdhes0WA09MTZRCSG++qHc4b6eTSC4y8wRPGoDcNOWucgNaAHQH
	GLMjeRKQKo1aOV/6SRbMcEV/cXw/67ZYyKZrpzOdxF45ijZK4AK/IK6Vu8lv7hWXgsDRa5atmrI
	r8KX9IBjyMoTrrPta1PUHRlzR3AHx8dn0CKr6Q8H5EvgFABnTxoMjHayZFl6MTTaD9T2Gw==
X-Received: by 2002:ac8:598b:0:b0:471:ff9d:534a with SMTP id d75a77b69052e-472228c8ec2mr101971501cf.5.1740591866019;
        Wed, 26 Feb 2025 09:44:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/O3a/VpZbfBSlaHDZYEoYwOjmXTezONBfqe6Qiso0mtqJK7hBFXsx/b08QY2n0LikBSg0+w==
X-Received: by 2002:ac8:598b:0:b0:471:ff9d:534a with SMTP id d75a77b69052e-472228c8ec2mr101971241cf.5.1740591865617;
        Wed, 26 Feb 2025 09:44:25 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd63a5sm361489566b.25.2025.02.26.09.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 09:44:25 -0800 (PST)
Message-ID: <e5290e59-0022-4eba-abce-a11928d76d3a@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 18:44:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fairphone 5 DisplayPort over USB-C support
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250226-fp5-pmic-glink-dp-v1-0-e6661d38652c@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226-fp5-pmic-glink-dp-v1-0-e6661d38652c@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZyYtxQwaL9sx4S7j2pUgN2AWEkuTt2D0
X-Proofpoint-ORIG-GUID: ZyYtxQwaL9sx4S7j2pUgN2AWEkuTt2D0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=672
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502260140

On 26.02.2025 3:10 PM, Luca Weiss wrote:
> This series adds all the necessary bits to enable DisplayPort-out over
> USB-C on Fairphone 5.
> 
> There's currently a dt validation error with this, not quite sure how to
> resolve this:
> 
>   arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb: typec-mux@42: port:endpoint: Unevaluated properties are not allowed ('data-lanes' was unexpected)
>           from schema $id: http://devicetree.org/schemas/usb/fcs,fsa4480.yaml#
> 
> See also this mail plus replies:
> * https://lore.kernel.org/linux-arm-msm/D0H3VE6RLM2I.MK2NT1P9N02O@fairphone.com/
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Luca Weiss (3):
>       arm64: dts: qcom: qcm6490-fairphone-fp5: Add PTN36502 redriver
>       arm64: dts: qcom: qcm6490-fairphone-fp5: Add OCP96011 audio switch
>       arm64: dts: qcom: qcm6490-fairphone-fp5: Hook up DisplayPort over USB-C
> 
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 110 ++++++++++++++++++++-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +
>  2 files changed, 108 insertions(+), 4 deletions(-)
> ---
> base-commit: 417c2d4ed67b729abea7dc73d7fb2153b7154d31

I don't see this commit in -next, master, or qcom/, this series fails
to apply atop next-20250225

Konrad

