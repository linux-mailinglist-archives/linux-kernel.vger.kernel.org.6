Return-Path: <linux-kernel+bounces-521795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1286DA3C265
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DD57A5AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E971EB195;
	Wed, 19 Feb 2025 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CRjEBzTr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459CF1DF962
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976166; cv=none; b=tiJQYX2i7tPj7z4phJU/Bu11f1N8YuslC5RdgwPd71+xQtjLrifUvTB4I5sOtu7Fkh8s6JbapilTQck9BSJcBsfK7VBkJx4glw3Cy/TucMVsJzoAmRLasKI1Omgz/Cd02nOzXDQ0KUpnjyOj1cnt3uFBx0EicDB/4RVRaX8i+hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976166; c=relaxed/simple;
	bh=2/cg0CLMQpDd2SRP2VcBmhFX4ih79DdQEz7YxZKjcJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rV6gRT4r/cBgOKf8f12JBlNag/Z2K8yINqcnvnIEIS/g3eWSM7LDlqbhv+ezVpkb6nW1CNhOLvx47/yHkuOYPOJoOXbqzCaYdOcexJWLDzeOhnpV1rNJDFqldxWRkIeqA04xENnO9zsQXZooFSdKy9zuCoqfWfWTxH4WBlwz7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CRjEBzTr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J8kYTn011610
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KbthUQGiUHpb4rkYFXNHNn9fqm2ZNwMaGsqaUP4qiQY=; b=CRjEBzTrz5k8SYYq
	0xOYDKKjueZkThTzSi3YeUbnytbBserM5tfB9qCNLpBplVrctkkaSwq0r2yEdK3U
	SgEtv6vrcuq3BR9KQ998F8irEV3+UB0rnf+KioptzeUfZ4bSh0G4zLQgCsbD94Xz
	71fHAqQM/s32iwqFzK27wDZGCLVU8yzjGHZDJrU6rnFZIJz1mxy+I6H5eBJfa/k0
	Tu1for1IDNaTnGS0fxcg5QkFA4VzcCngBhRV8vZ75NTmuWxfWIS80r5oG6OWGV/X
	bb1G2cNK2uPymKBKIk/oSTwJlFyY5ql3lYFymVQIXLZ/gC5vWvzaAdqCMDFojlLT
	nSBN5w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3jybv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:42:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e65862f4e0so8351946d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976148; x=1740580948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbthUQGiUHpb4rkYFXNHNn9fqm2ZNwMaGsqaUP4qiQY=;
        b=Ak64uNIPQE5HnaO3u4CWmh74tGT/wveWkAJCfjpC0XULkkdR4KOVtXuDbz7eacFNdy
         M2e+5jk26iCXzyNdcAB3j6+DGrcD1I6Ed/kjkI7nm9PQ+kaX/14NIU2Lt3ZVm7Jgp8Vi
         1pK+9N0yoe9Opcg6lYpxQ4KezHrG24zBgOvzThLNP7o3xaHzFsLxRIAM/cXgRbLMXSL7
         zL+6Rk/056WLcuX/ThsgXA0nx/xC1ZzdSUcQQmdrbAw6JUvtKh3r5zvUp8kkX5ph4VMk
         XzV4q8eROt9xCafz981RECkZUF9c1Sbic5KwXeMX3GHVv/a4a72bEi8cJxKD90SuLm8b
         ToJA==
X-Forwarded-Encrypted: i=1; AJvYcCVBEzw0QUJbURqqr/wj5Qz3xu+hKesjtl0ON86hEtB5EJNvEBslazY4sBIeINulnuyHwmKt6pOaRj6nCuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRiRZQ/kVn0BCGG/ZvlqawJEfwRvVcz2ikj8ZYDilsaL7yF5iH
	nSKZfI3rk4WGzo4cqhGkWexrq5DFfJ4E4rAb4T0U/bvfbvvWCHF9MWXyXlvgBzwxPtoF4EtQ/iq
	6pnr0to9c/auFVKr3EiOqEzET2GTJ+xmD+RZHqQGSGtwVB8mL0d+1TC2tiwitit8=
X-Gm-Gg: ASbGncuHBE9ErjH+bze0NRqBp59Ox6cG7eKIaciBSPSQ7sK4THPuGLxr0imPIOAef8z
	94ZrDWI6MGcpfxloQ2D8XRvd8/Jq9oxABYBxtHHAYV63ksefXytjt7KV+tjOBe9RYZAzTcVJ2LO
	aWSvivg1PJnCH6DIZ1vj8I2dj/gJtbIgahWNSUK9AZgjSz3LkIwvQJNq1CXWI25QputZzI6iLc9
	55JDMf0LC6O7NAK88AuJWyc49HCC9yh+IjTJGFabAzjULe56b+L0BJ/Ju1jo1DOG6jrs4m4rCY/
	litk42UhS7OCDtZ1p4Y6GaqFuxslb9Zzp30p0GGWhuZhPpuWK3+Z93h0iH8=
X-Received: by 2002:ad4:5766:0:b0:6d8:8283:445c with SMTP id 6a1803df08f44-6e66ccc47d9mr88788086d6.4.1739976148121;
        Wed, 19 Feb 2025 06:42:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpAj+Xqw9qSXsdwXUvLSdDHBpi+ry1U1ggEwkzdRQ/MVC50YQowsUTy3N3zJnQoanhNQNYfw==
X-Received: by 2002:ad4:5766:0:b0:6d8:8283:445c with SMTP id 6a1803df08f44-6e66ccc47d9mr88787916d6.4.1739976147828;
        Wed, 19 Feb 2025 06:42:27 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9654a6b2sm652600366b.135.2025.02.19.06.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:42:27 -0800 (PST)
Message-ID: <27a0f921-437d-4744-ae99-d1f5020fd55d@oss.qualcomm.com>
Date: Wed, 19 Feb 2025 15:42:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Drop `tx-sched-sp` property
To: Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250218125157.412701-1-prabhakar.csengg@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250218125157.412701-1-prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BKXHZV7OAlS_HtrlmVpPlK-eKQicA87e
X-Proofpoint-GUID: BKXHZV7OAlS_HtrlmVpPlK-eKQicA87e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502190117

On 18.02.2025 1:51 PM, Lad Prabhakar wrote:
> The `tx-sched-sp` property was removed in commit aed6864035b1 ("net:
> stmmac: platform: Delete a redundant condition branch").
> 
> Therefore, it can be safely removed from the device tree.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.csengg@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

