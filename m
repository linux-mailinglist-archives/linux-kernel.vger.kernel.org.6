Return-Path: <linux-kernel+bounces-513867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91877A34FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C1A16AF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C0266B5F;
	Thu, 13 Feb 2025 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qz71s5t/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8F221720
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479397; cv=none; b=UBQO91oRWBTFG76REYAu/oudWzYuVucGoM/rRhEsucSHkPJQYhqHrNmLMU5EXWOhXZMHZGYFqkKuvJPWWhP2KNlGrLBP6DwQ63UlU2DmofKH9dTp3T4yha1pBsMRgYuCdhlvmHVDO5Eqz3Fnay/e9TdIQpkfZF+JDZY/4BJhnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479397; c=relaxed/simple;
	bh=WiBletC+NiNFsqmtrCg8eDB6LgIxSryVCtxHFdD/nWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utVoCkBVzLAbokO13TP72i2dltoyxaPw3TyQBfGKPkoGttm3M/552+KvJ14fcro5txnyJReNM1hCYCgQrhIzpCkSJSM3E+c7XVJ1CHUpQSH6Og7+g1zP+M9P2I8AkRmaidUNspxJrbIKTGzhF5AKuFQ0AQ+D1zD8RYE4t4UFPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qz71s5t/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DA75Wp000947
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bz2r04m4kWn3VX27WbdcYvPpU6RebAFsusUlr8Tu+1U=; b=Qz71s5t/JyZM1XqA
	955HMXFuAC9MNF49UetlRm88X8pdfSvmDrpJBr0DCgs1YQQz4djkvW9jbVHmsSnw
	0A/udbKGsjM7QGEVWoBvLR6hA8kOBktdbEn2Svt+XbGX2xO81SrdY1OgN0uNg944
	DeKk6lv9AiNEQ4ptKIcue24WiSda51jgpCLRyn9/va29SngBeCT5HrInTd5UqieL
	+o/kJQVdERn6czElQbCD4VAzub1YaHxoXn5V2QNR4rbHecFWbwWYvoCKaJw3TH2+
	7wiaNzIP6m2eKRTXrKI6oOGFmUowYpVA+0/1ViuuIYHhdrZx+k56BWCpJUQdEmXP
	wIfnzQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44seq01j63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:43:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e45cd4145bso3375476d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739479394; x=1740084194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz2r04m4kWn3VX27WbdcYvPpU6RebAFsusUlr8Tu+1U=;
        b=Luc193wE5LCYSq2ZYkyCiFzHoYXPWFC6nu0gls4kdb3vxzNkYLIhgNJ860oSEiPSR4
         T28Pv6vN4UeN38mRGVmLypFNVSyrjuFQuPGYtx5khXiroBAtHOLVO8MmW6bJi7GUmbFi
         5hVvfIZVoDXZHludmy0cqy6JZjojm4NbjYDDHhknFbRp1T1MxHQFhYWqdo76ZEmaGJWl
         gTMUxfi8icbcTBIkFp4VR246O4deJ5sIqnpeOEO9tcPbis/HTUug4B8Qp8GmOQBuOE6l
         lC1HwNtuBlzBO3vSuQGnnzx3io34gx+TZOW3zifVtWq/X7CIgtachRyg0la06CL3buWs
         nc3A==
X-Forwarded-Encrypted: i=1; AJvYcCXIWJaaQ9yM9cP8Pa8VtOrow0rzHAbSYTGHPhF0e9cR0bf5SXarQqmc5ft02ya8x2UfLsCBC8Eb8q6owRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwIZpOfCqXyxUBV2bonZXrabC7UK1fmEmXXls7SFZwmLRkgka
	v569cIuSK9nqSUxZLQCIF4xwFWcNCyUR/FeHr6E+kS3E+gz/NniANOFK7c+fPeBNGGAlnXKecrB
	7TJBze2OlRjLR+T2urv+wCspLzYbLmqpoKqY2PbgYMacA6hGIeVuIBd/jD07C3PY=
X-Gm-Gg: ASbGncsgteadmudqEUbB1VmGK9q8nh6/swIBJ7IsVwDMOtj0NPnes2AOZnYTtN66dqk
	/eG311esh6toGyszLw6vIPTp2HyMNVgqClpSNUcWgS1hFqZ7l3JgBTNsWgPL9CTN+iXJJpbI/Ee
	Z+lqjuHTPvcmUJ1l8shNCicp5+KFVFqT0Y6Y7Lu8htXna+oPrXs5QJGJNalzZ8WCnCJzMEE6Quw
	w3YoHgv5UeIFlq3MgAaPk+tCgNEZjr6xmGNkjmMD/fmcGU84ySIOjOxCKNyu3wa7yVK5mvSnmv9
	qddj973IkkU3vWyyAo7uIPwdik7pNxpwiVvCTlS7osKKjrfXVJaniUSCOpE=
X-Received: by 2002:a05:6214:509e:b0:6e4:4034:5ae8 with SMTP id 6a1803df08f44-6e665191646mr2097536d6.5.1739479394085;
        Thu, 13 Feb 2025 12:43:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+X4L2atIc1ejv/4MkKqLGB1bWWF18lelzFgw1/WdffsckmQCjOSwKqdJAIJqhaOly9cD/wA==
X-Received: by 2002:a05:6214:509e:b0:6e4:4034:5ae8 with SMTP id 6a1803df08f44-6e665191646mr2097426d6.5.1739479393797;
        Thu, 13 Feb 2025 12:43:13 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bce23sm195258766b.161.2025.02.13.12.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 12:43:13 -0800 (PST)
Message-ID: <5501041d-750a-465a-9558-203188758e90@oss.qualcomm.com>
Date: Thu, 13 Feb 2025 21:43:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: pm8937: Add LPG PWM driver
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Daniil Titov <daniilt971@gmail.com>
References: <20250213-pm8937-pwm-v2-0-49ea59801a33@mainlining.org>
 <20250213-pm8937-pwm-v2-2-49ea59801a33@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250213-pm8937-pwm-v2-2-49ea59801a33@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Z16_EgfoeH076HEVJo_dspWg8stM6kSr
X-Proofpoint-ORIG-GUID: Z16_EgfoeH076HEVJo_dspWg8stM6kSr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=655 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130145

On 13.02.2025 8:54 PM, Barnabás Czémán wrote:
> From: Daniil Titov <daniilt971@gmail.com>
> 
> Add PWM/LPG node to the PM8937 dtsi so devices
> which use this block can enable them.
> 
> Signed-off-by: Daniil Titov <daniilt971@gmail.com>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

