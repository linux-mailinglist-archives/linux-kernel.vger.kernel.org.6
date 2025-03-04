Return-Path: <linux-kernel+bounces-545123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B2A4EB7D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B818E250A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88114292F9C;
	Tue,  4 Mar 2025 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eDSLBcOd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89411292F8A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108059; cv=none; b=bFIqtKdW4+lIWp4OEJms0NIOWYZ/bd45KDYQEhpJBy3Mw0BiW4ERVbhi9Y9xGr3o5NcjwzUsD72CVbp96R0qQblACiZUS+sdhnux6X3vQK+btr1Z+TB0xyfL3GDFvptpTkeSxcq8KQV1t+ldMFP6AwJdnoC2bPb6yJnu50Fs9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108059; c=relaxed/simple;
	bh=F6vBJ46C8KHBrc2nlBww1FKwxrACcBrJIPlpSKujlac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZr3znBNIfZxkBpxESD+3pSaTXfV68aLwZOU7ybHi23mR942dJID7bfKs2d/O1NRoXU7ODHnOvW2CMa/EYfRnN1o7ZeeBUibwXVcEVCt7kniPGTMRfjTJa7owJwvTZjAJsYcOXfr/LkBldl9mhhiiUjij6dvH1YapkegSt8crYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eDSLBcOd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524AUteS019738
	for <linux-kernel@vger.kernel.org>; Tue, 4 Mar 2025 17:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TZjKJb1JOrr8sTlUj8cLvVtyiRSkt4t6v6lKPN6/FuY=; b=eDSLBcOdxsMG0hUJ
	ghhBPgeoPlnvTrAabKcrj0E41z4EPKUjm9DToA8aA2OcVvWCjXQ/uKywRyewbAE1
	c/8kPzIDOpwLTujKF8AwW/2AbpL/4bOmjWaj2y4dwiE4UgdgLHIPbkB1Be8/C6ZH
	7HUfb1mkOOMunn++PgOQR2vBlPrIyZ/F/etkcFBrFigZWsUuPKLPelcr4tEAyuuQ
	vKUHaThpr0lB76UaOY4GKpIg8Y5Ru8wvmSJp4cAQNaOYFpM7RJmONYBsnAV7HO+Y
	eGTOqJjaUGov8Rv3kLz0wVhYjB39fJy4Kvc/iA+b2x7bOCdw4W53VzlfXS2JBNiN
	jp8LSg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t2kaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 17:07:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3c4d6244eso40409085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108056; x=1741712856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZjKJb1JOrr8sTlUj8cLvVtyiRSkt4t6v6lKPN6/FuY=;
        b=DTORGdN6rdmlC6uB9iWAB//PyLI2GE+xlgMtL1AYskOiYmH/Sjs0q2NmEe8dqjN3K6
         FpPreQIodzbJ1ekQP6Pxb4YydY5zlanfBR1xWIPanvXuojF41jJpDoMCIrElFPpRaG04
         TZh/kWfWJf3qhKyKEDYxAbe9o5UIo8DsDBXGTl60mHazzVXMiEK+QVlHfWhNvHzyaAjX
         97QW4x5PRyRfekrHvnzBwaFtoG1rZ8K7qDzLjijtsZbTqCSquRyFKqMxE1e8/AKgjzI4
         y5qmK9ZFYZ8xn1FGwDr7WQxOTp+g8i697qN1azLM2I84wQDkm7PM29PHKZ7tw0Y6qiUX
         VfXw==
X-Forwarded-Encrypted: i=1; AJvYcCXmymi7wDrAMOfWXqGJtQ0ALFpgM4e9GeXS6xYvIX5wyzQv6QK+cK/LcLwYslgOr4wWvzt+31uJD44ow5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4bhxMrs6k9mbyPrS1CsmFFIRQzh+Q87qaU9fBlu++L52G1k+c
	2FlMP4D3w3gQeNJyrjiw0mh/Xdal6Lc3vqH5ALcMA4xIicek610Wa3zdbuaL1ZpHUfuawW4Shj8
	JV4LlwpCYLzac9/1FtkycZRFZcfW+NfbJaH7RazaEOxKMMrCc0NuQLD8eFxkkYyU=
X-Gm-Gg: ASbGncukU25lr31SjYti+nEUoQ5dJLmxiMlKinhu53NtZ8NXmVIsRh+G4Ysfc6Aw45E
	A2MiFi/ZBvLFdx+z2+gDUJ6nzTa+yychuon49F+a1REjaiQhSrS6I3pp3HFfb/Q/2wuGl08r5Ys
	f49Derydr8AUEMbEKn0HlXytaMJPfJcaHVmAczlB0eUGJmvMZhWiMljZAdPtLxyOYJ98IreEjnB
	GJgEEtRA9f6+q/fgeCkTmFxY8d/dwWwD5tQxmyNg6TP3evXCMWXt/V7p4uXYkV098ER7hKHYJot
	lvPp1KVZhqLCrxxIEVEOU59niMJVa2DsFMGIqpo1MGBgyVBJIV+LQhZOp+mAXqS8D5Aopw==
X-Received: by 2002:a05:620a:24cf:b0:7c0:9f12:2b85 with SMTP id af79cd13be357-7c3d8e11286mr2259585a.1.1741108056260;
        Tue, 04 Mar 2025 09:07:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGycWLrT/C2q6turqjkv0iq3pJCNvysSEJz7MN9YLMLfaYp65ERr5z75S8aZId7mJvpsQy2CQ==
X-Received: by 2002:a05:620a:24cf:b0:7c0:9f12:2b85 with SMTP id af79cd13be357-7c3d8e11286mr2251985a.1.1741108054387;
        Tue, 04 Mar 2025 09:07:34 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5992d29e3sm486357a12.31.2025.03.04.09.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:07:33 -0800 (PST)
Message-ID: <e6dc86bb-1dd1-486e-8e3e-18974da6cf86@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 18:07:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] arm64: dts: qcom: x1e: mark l12b and l15b always-on
To: Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250227081357.25971-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250227081357.25971-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MBxpW1rDNGOJh1Ih11EjoOrAiGS4pbQF
X-Authority-Analysis: v=2.4 cv=KfMosRYD c=1 sm=1 tr=0 ts=67c73359 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=Gm5MeFswuaCjAzcAFrcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: MBxpW1rDNGOJh1Ih11EjoOrAiGS4pbQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=708 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

On 27.02.2025 9:13 AM, Johan Hovold wrote:
> The l12b and l15b supplies are used by components that are not (fully)
> described (and some never will be) and must never be disabled.
> 
> Mark the regulators as always-on to prevent them from being disabled,
> for example, when consumers probe defer or suspend.
> 
> Note that there are likely votes from other processors for these rpmh
> regulators (at least for l15b) but the OS should not rely on that in any
> case.
> 
> Included is also a patch that adds the missing HID supplies for the
> T14s. It was a corresponding change for the CRD that made me look into
> this to make sure these supplies were not disabled during suspend or on
> probe deferrals.
> 
> Johan

This looks good, too bad SL7 was left out :( I'll take care of that
myself

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

