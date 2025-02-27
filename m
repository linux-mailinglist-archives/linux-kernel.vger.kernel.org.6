Return-Path: <linux-kernel+bounces-535856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C62A47828
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A64D188C8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C5F226173;
	Thu, 27 Feb 2025 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nGd7diGk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF442065
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646034; cv=none; b=RE7D21ROADUVXM6ryehnXsMpqqd/yeHu/wDZMT8jPoX55U9sub0ptmVUYGGiYr08ZImQVpfCdwOAR+yu2yV6AyFRO6JnbxLF9DT/a8GzlHN3eQrAGZLWYUh2FQ9oYLLdcQ3hBlarA5PPRrGaGd7c8a6ukEcSqzyuPUgzegbX1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646034; c=relaxed/simple;
	bh=i3wWe6ahx0nNYsdmrz7shy89KbnD0dzmfCNsWOogpJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYRUUvQzgDpot9AUkDUgrLiGbN3kShBdys9aJXz+zWbi+8RqA/yJYM9c0uoGVNd4WvkNNHpWMv0aGAThyi5uloB7pp6ScRdXXvwcNMr3c++XyIM57mp5Y4QxhYkZ70EcK+sjN9pNol70SGiRs/OaaXoWJfHz0JKvKPp3254I3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nGd7diGk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R8NMw6015362
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PGYRnAFE9J8dyYPOqeyvQzfEJJ9gyHSuD8SyRueTGg8=; b=nGd7diGk1xJ/htB0
	zj9Zr4uaejn3D7Zphm/PyT4W5qjLBDLcPTRhYuTTzZDpXkUN2qEKdV8bWWqGLyMJ
	j2KD0WGbEihd9sCACAFnq0/U9qh5OhevSo0sb9G6Gh3mx39V/V9SIKfzyARzzn01
	6AF1ruj0qCs3QgYYKfaqickJJJkSyh9a5SDHkt3ubcZdOVh28HrtIO+yjIb28mds
	e7FpV6LWvk7Ou0hXqVE94MbSyihDeYvvHrXT1DWq3sTQ9VKZVdLSqHi6aLm5Kd5W
	uPgKqOg8y2CaTIM2kJ+QKRNTFscV8dZUQUfb2EhIP+Pu9auOOKu560xPo8d8gB8z
	ADh7hA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnmyp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:47:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e88eea1af5so838836d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646031; x=1741250831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGYRnAFE9J8dyYPOqeyvQzfEJJ9gyHSuD8SyRueTGg8=;
        b=keNYxUqDeHD2Ldkks+P0UN98jlOUbifjkqMhrxDedIqbIg9spgKlhgwHl6/e0031E7
         Wf3IT2r4gjpjSIrQ2jgkElywUeXlpB1UfVeN+dY7BzNoqLW3ON0qHbvzwKkBkVdyUrBt
         PYy4KVO8KaEaRqfNbAdlqhcOui73qs3yN3NTRfNJlp7d/gdSzLa0HTRwVEB6YZVu9cxE
         +UkLl+ZJmeeSDghAd/A2CLzL2z6Kk0tXPfmZVPLVEarTDX1ZVxr23w5RWDdq0K/ObfYV
         rFNDiluVhiu/GieictxIp2+zprj53t0p0ZyMaml1Q3SqsACAA+uzAyogTIa49FcgsRZv
         kALg==
X-Forwarded-Encrypted: i=1; AJvYcCWiLv4cEO2XTDJilklogNNUIDqMt6eJULgAvoPU00BPdrJLrlBe5Ys/gOjmOvF+UJwql5yKNcTveSw7QLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3nNwCguvgMGmZEiulaIsWEmQpkGg79CBA7Js8SW0bHc704P0
	01Lrv7d2q6zlAqBlJv9OyxMcOoPJ52rfpX06quNOvWS7ksXHfOXi0BxIvIlZNQub8Z/cUwyMWr8
	/LYeVHdqTdODA/KabNP3q89+L+7LDOsMBNyOXZOAuBZ+cU8zWSsXHXCJcxG0TkgI=
X-Gm-Gg: ASbGncuyUit6U3NUmoIuC2BkWj5JrEp/bCTkY8T7G5K6QXKO/r9V4mqv9WljbTLd2Ug
	6iMQc90cw0MQwk81YH+lz+bAultfDc46zoktrH7dz/4yM8jn/TWxw2muqmoHnl/km41lrRsxLW+
	vMdKX+fizBD7iTCeNGnP3k9k5OFId+I1f0fnXlqW9X54OCpjoa6+TMF8Ln0VSp7GMRD4Ld674fk
	7u+gdpalO2OG8ja5l3qBL+48IroTjw9VztyY/qjM9FaWhdKUnw3eVPUewlrJ0z7+OIXapJ1jHj3
	ZFX4iqGvbuJ3Yeh5Hg1XRwsdDmm1bE48sy6aO66a58iQDAUEfbINzW6D0Jlv/SMW3it8WQ==
X-Received: by 2002:a05:6214:c4b:b0:6e4:2975:ce54 with SMTP id 6a1803df08f44-6e6ae801b44mr120716866d6.3.1740646031042;
        Thu, 27 Feb 2025 00:47:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0uwkvN3dQcNmsMayKyx9UNJCNrrJEsLWlyloN8IblvOCXpSDG2vOuKjzhx+1mVPUZjcAY8Q==
X-Received: by 2002:a05:6214:c4b:b0:6e4:2975:ce54 with SMTP id 6a1803df08f44-6e6ae801b44mr120716696d6.3.1740646030711;
        Thu, 27 Feb 2025 00:47:10 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c7624desm85850566b.158.2025.02.27.00.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 00:47:10 -0800 (PST)
Message-ID: <9a7db212-5cb0-40dc-8a59-96561dbac725@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 09:47:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] arm64: dts: qcom: x1e80100-hp-x14: Enable HBR3 on
 external DPs
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, laurentiu.tudor1@dell.com,
        abel.vesa@linaro.org
References: <20250226231436.16138-1-alex.vinarskis@gmail.com>
 <20250226231436.16138-4-alex.vinarskis@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226231436.16138-4-alex.vinarskis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nVkAjH74AIXCLBqpIXfZDgTeEwfWofaO
X-Proofpoint-ORIG-GUID: nVkAjH74AIXCLBqpIXfZDgTeEwfWofaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=816 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270066

On 27.02.2025 12:12 AM, Aleksandrs Vinarskis wrote:
> When no link frequencies are set, msm/dp driver defaults to HBR2 speed.
> Explicitly list supported frequencies including HBR3/8.1Gbps for all
> external DisplayPort(s).
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

