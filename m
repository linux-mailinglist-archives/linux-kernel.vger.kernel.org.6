Return-Path: <linux-kernel+bounces-531945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7639DA446FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5747AF133
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0EE195B1A;
	Tue, 25 Feb 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kzWYpvpT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7018DB0C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501904; cv=none; b=IY9vOO9NHsbXxCH1ktrI3Q1XIUQnW3S0mjQaRjmgSEaqwdxtMqboVB0V8pIsGPRAZb6ASOMLBZH4k0iy6Gx5IjS/SoSolOsHYxL7hCUZVbVpkOtzMsbHDtFolnxKZRi8naHmfs3fVjxhn2kRnmX5o5pU2CiKBLYmE+o8/euPJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501904; c=relaxed/simple;
	bh=L2FmnGukcA0y4f65aXO6bVtDOK+71WB4L3u56d6qH0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRyD4ysxfhd10IQC8nOl0dPNAKTM/9epOsyoG9ORdZXBhNcVVJF9AXMI+2ay9UdGL5SdEY9hShUkOjVYcZ+Mz1bBLezMLmjCvQBfDfA0cyOv1HRspTRnj29ZSx3vUTocqsg+eZIfPbvtU4+0k3nO9ruJ6YekxXTvNaI+5Ph0ZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kzWYpvpT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P86qE3013314
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ULUpptJwI6ThaUvM4CSWgxzRITrdZBlHcTREM3kcByM=; b=kzWYpvpTjBl8zND8
	95vNpAKACM6V2TErk2q+N3/vSaSJ+UrON9VohH9ngZ6Y0VELEmspHxdnS88TtOV7
	s08ike/9NvKa1Ht+g1W7U/qbYuNFpcPonMBAVgsZzhVlpPg+hUdJQI/d4GFTExjY
	FhcMx5uHcGxO4KpTbqE3GwRw+jMVnH/ro4r30x6U2cAmayCi71rokVL4iP1MrHyQ
	3pWtQwZy/cYw5RwcFv+RsvhldVozHYbNKDGZwUN6wNAQUFNOfG42FHcHkuED751j
	LZQO4rZwHpE+rkbgS60lchf9n+wTY7WoVDEFo/dPJfvsur37++hi6lNjdlto7Wqd
	wFlKWA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5wgskn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:45:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc0bc05afdso12754459a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501900; x=1741106700;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULUpptJwI6ThaUvM4CSWgxzRITrdZBlHcTREM3kcByM=;
        b=HIpUb3uxEptKut5/eyE+OOQtmk7V6M9u0UKu5huoWyLSiHiOjIDcvhSzs/aajJV75I
         hMAzMvG8ihpGO8S3BMF630rTAYJCGnGRMJI7LcOcAXI2Z5GwcYp0eOyNGAdag0BUoPHM
         37rXcHOHVGWTynm35oddkaos+ATnBxi/ziiZJizTkeAzZB8uP1toV1gYTZR90eG4Adux
         /R9uXfYp0v3CrxU7dguxdNdaruiNI8/60Pt35Pt9FP4oBr/NKREG8zgZFTFkuk5Mn1RT
         /KdWGTsfVU08DGuqWVyahHKgUDkeeT2VgT6ZvdWKDLCt0kNRdK+x5uVokD572SsHetT1
         8MCw==
X-Forwarded-Encrypted: i=1; AJvYcCWL0xAVe6Xcp6HzmzjcsBkHGFBY6dVlguuAewLgtxfgRdRF3+igUJ18EQAIhwHeVqO5nhzcpOvvkEC/n08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+v01PAFfP0SHAsSOScizNw+2KW1K+4XL4usCtfbNsFX4yq2L/
	dtD4G5ATK5vQDL90PqMXt1m2vW/O6CXfgTedwoclFeSdRR1n3dfv5cK7jlX4DyVC4HsqVBkuO05
	Sgsu1Inl+sT/SitfxCPZ8Ydz1K5RHUHuQoUrN4V2eZFYQY8NHWruKS8T/kRZQYX0=
X-Gm-Gg: ASbGnctGTxg1c3vjKL910MpKUUmdOQXecGq93M162qNeIXlXwdLUiJ68wohOhpR1Q/w
	zVTtobnT17BrH/+0mpS1FZDScR0IOotBh5uI1h2gCl+OEXPC8f9QNZ/l6LqB4L8AcShANrKAuwf
	Hwd6FmN/NsPOQ2YbFN+w9hC7qrFw1FinmT5S9f/Ztb24S4wKZATcH5jZ1ZP19NMpGhdtWbyMCLu
	qdOWfp0BsagsZMbO4eGtOBoH2cCXFaQoUgBTi8rFW8dmL3tomwW9AIXFwPKr9dx+prtPt71ErVo
	jt7QTDMqta+TD2mg8ZVFf0sY8c8t7UVIcKRrl5HbJFoJ8vRDkxdfbr2wwoWP5aeN9+f529Y=
X-Received: by 2002:a05:6a21:7a93:b0:1ee:e785:a08a with SMTP id adf61e73a8af0-1f0fc781da5mr7421842637.29.1740501900063;
        Tue, 25 Feb 2025 08:45:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzhySqJhghGiZsMKmpZdjhwmssEsTGd4irosiubrI41LuqK1kzfshthHtszlA7LkJtnyROAA==
X-Received: by 2002:a05:6a21:7a93:b0:1ee:e785:a08a with SMTP id adf61e73a8af0-1f0fc781da5mr7421800637.29.1740501899691;
        Tue, 25 Feb 2025 08:44:59 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f8258sm1727164b3a.112.2025.02.25.08.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:44:59 -0800 (PST)
Message-ID: <21ad3381-4d65-4c68-892d-9f485bf13735@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 08:44:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-slim7x: Drop incorrect
 qcom,ath12k-calibration-variant
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org
References: <20250225093051.58406-1-krzysztof.kozlowski@linaro.org>
 <sfhcmlz3x254fdowufeeuh4uiwxfgkphm4ch4laceivbrs3zir@qvqk6jxi6zhf>
 <7b54e965-3395-4349-8ae7-51a28c759235@linaro.org>
 <kce6gzso22fp3ze2wp43fvy4tv6yqkaijm72kh5qk34jwijk2l@3ifaiz5tgjvl>
 <d93789c6-61d9-4761-98f5-aa3dbec14d82@linaro.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d93789c6-61d9-4761-98f5-aa3dbec14d82@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 72cgApr7rLCkgqkd4Tyy-COnpUymVznK
X-Proofpoint-ORIG-GUID: 72cgApr7rLCkgqkd4Tyy-COnpUymVznK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=820 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250107

On 2/25/2025 4:14 AM, Krzysztof Kozlowski wrote:
> On 25/02/2025 12:45, Dmitry Baryshkov wrote:
>> On Tue, Feb 25, 2025 at 11:22:25AM +0100, Krzysztof Kozlowski wrote:
>>> On 25/02/2025 10:50, Dmitry Baryshkov wrote:
>>>> On Tue, Feb 25, 2025 at 10:30:51AM +0100, Krzysztof Kozlowski wrote:
>>>>> There is no such property as qcom,ath12k-calibration-variant: neither in
>>>>> the bindings nor in the driver.  See dtbs_check:
>>>>>
>>>>>   x1e80100-lenovo-yoga-slim7x.dtb: wifi@0: 'qcom,ath12k-calibration-variant' does not match any of the regexes: 'pinctrl-[0-9]+'
>>>>>
>>>>
>>>> Adding Jeff and ath12k@ to the cc list. Is the driver able to find the
>>>> calibration variant in case it is not running on the ACPI system? I see
>>>> that it uses dmi_walk. Does it work in the non-ACPI case?
>>>
>>>
>>> But nothing parses such string as 'qcom,ath12k-calibration-variant' (see
>>> git grep), so how would driver use it?
>>
>> That's what I'm asking: is the property redundant or is it correct and
>> it is a driver that needs to be fixed?
> 
> I assume driver will need something like that property, but that's not a
> reason to accept incorrect one in DTS. One cannot add properties to DTS
> without bindings, so bypassing bindings review, and then claim "but my
> driver needs them". Send proper patches for driver first which will get
> a review.

We definitely need a calibration variant entry.
I've pinged the development team to get the driver patch.

I'm also verifying internally that there are no issues with your renaming
proposal: qcom,ath1*k-calibration-variant => qcom,calibration-variant
https://msgid.link/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org

/jeff

