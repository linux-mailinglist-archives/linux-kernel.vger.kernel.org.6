Return-Path: <linux-kernel+bounces-539799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CD4A4A8C7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07BC16D92B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 05:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD8A1BF33F;
	Sat,  1 Mar 2025 05:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hYndMg9Z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575AA199FBA
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 05:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740806355; cv=none; b=K2iLm96yapzj1QYsBPesXdFIfpKutAsSEPd2ToM3SyjcCgDx4y4Qy129yq1VwMNZxNRb8yR5hmZ/1ejZorj98fU2c1+TVR/wpDrvmf/3uZ3/0L/2ouP2d3oCunuoQ1cO1npiOD2ZvuP52/WutL0BakXxSa8vGq7PziS3ekuaEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740806355; c=relaxed/simple;
	bh=tu6Sm0hCdUZksAy8vutcJzdANnD13tljjz4kIw1SKbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FenK0fQk6vXWclQ31ANQg5qdhQd7ok5eCY/ZuHmMXBclk6w+aMyqpdhBGD0noRNaT3GfRyefuGpykuc5YT1oWDhLJzAlaZqdqrEgEF9zgZHzWJbeacgvSiNqRlEecgR8VS/q/3/GdGlczkL6GpPIC24YkXYyIYRD4X46XSU7E7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hYndMg9Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213Z2hP031426
	for <linux-kernel@vger.kernel.org>; Sat, 1 Mar 2025 05:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fItfMe60bL3KBr33oQ76T2mDSO4Mwd15Hpg9wQXBud0=; b=hYndMg9Ze+m08WSz
	4NKTdcptpWjT7ezxu4EUah+SHYRFgVxoVWUVCmFOfnvAqxVZJEzaTUZ5+EbRqBMe
	RUkYdiPkNIE1E49Ns5wapD4FTakrU/aeyomSAXz3EbngxkQZkJuJQqVYnmb2NqT7
	zbf2wGuwYEw6y+irXUJCStH5R7ecaAruOABJcpcqTDJ6GcdPMgunynAOXMIGzFQF
	tmYIfigeXN8QN0tMWlTJ8NSAy5kLqixp3WghnvawaHztdbwCce8h3v4Iki1Q5sWj
	eR0goC/TFYLs1hVYikzguN1rG0o+6ZOSFoYzS3MKvGQ3o2Th5fV0dvNoRo57KsY6
	ZdJTZg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tf0g4xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 05:19:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2235a1f8aadso40478575ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740806352; x=1741411152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fItfMe60bL3KBr33oQ76T2mDSO4Mwd15Hpg9wQXBud0=;
        b=fm451K8MhOMXtx/agYLb88bjSk6eVgRh9MaA1bskQpZC7irUMdiLBg/8jGvB3vA9AH
         4uHCQrVykLyA0b5v7s1l1n/rDWg/FaQiBNy3Y/yon6LC2PTxnsvi1MPOII0IRpptvRFj
         N1FTSqsuWfN+NpvfS+WuuRTZLJsxjZzGM3A6BwcuxUlGu4WYETIylys0oMqTuOZXg1F1
         VKQtYnjF+SKVZ696wEy/vSy8RmII1CVZpiQhZLWrV/zqB91fEzA53yX+x8/Ju4nPpqQ6
         ToJK3ZrhpPV27ca31mzPVHQznkuoLF8BwE6YtI8T2e2KgfXjefrHU+6A+UJcFqYnkUSC
         WfFw==
X-Forwarded-Encrypted: i=1; AJvYcCWmkV4KHNqh8WU1Cb961rxuxw+zoI0FWvrA6QqwBKTe4PvzApE5aUHtAK1VlYX25jSPZwcMYWnNEAFPnEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxebHwo5Ix7+oOTwwgWjhYZIM7NKZsKz+8qSuE+BhUt8sjA8lZ+
	AeScv+loQx24XmESSK/Z5HOhTQUvASW1SPK8CRxyc/ui83HQJEEi30Y2HeX0oO3d7M3TB4utDQ/
	eCAlBgYsMfa0z9kZgtAe64Y46JQqgPjnvOWBS4K8R9teIxdXB/ea+vKNc0bLQbyo=
X-Gm-Gg: ASbGnctbPMbZ+XkvPIT3/Uku5DyLV+fSEnEex4ZssVK5ifDtJSFNsdlR5HotFHnmIiA
	WXCEmi2FtHypd+uJbpGAaWp6iK5WaQ5V4kIAkFeAT5arqluA5nSkb7u0R+yG9RfSEow0SOwEzbd
	D299UzBhldeG+PV5CBmn0NCn4GC+iBATqjFFh21dO1DZcbrZaZmNsY0udLhRvQrGhBSFR1XiC8h
	Z5xyEjGs62kvR8WWMaYzUWzdc/fSQ/+fbFpLBai8sBX/hHrdWyspEZvvEcIaN0U9VFa68iYpjj2
	AQtqtRuAfNFnaE3KK8Rk2Ic6h+NA6rIDhIsqH0m5zgljg2xSO3FjMl1/2eVJ78M=
X-Received: by 2002:a05:6a00:2d8e:b0:732:5276:4ac9 with SMTP id d2e1a72fcca58-734ac35cce9mr9750327b3a.9.1740806352534;
        Fri, 28 Feb 2025 21:19:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEir5MRosoUYpbeb1u+Qi3ok691SR2Z4tKIzWpFn9/rNRTWboX60CDNLHbz04mtMwAbblyS+g==
X-Received: by 2002:a05:6a00:2d8e:b0:732:5276:4ac9 with SMTP id d2e1a72fcca58-734ac35cce9mr9750299b3a.9.1740806352169;
        Fri, 28 Feb 2025 21:19:12 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a00400absm4673454b3a.151.2025.02.28.21.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:19:11 -0800 (PST)
Message-ID: <fa72ddab-b2be-3481-8e33-e0dd30e3e8a7@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:49:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 12/13] wifi: ath12k: Power down userPD
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-13-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-13-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6VQ6W11cwO3g2p24uFu4yhVF41k8nZ5L
X-Proofpoint-ORIG-GUID: 6VQ6W11cwO3g2p24uFu4yhVF41k8nZ5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=768
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010038



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> 
> Set the stop bit in SMEM to power down the userPD. Wait for stop-ack IRQ
> to indicate power down completion. Release the userPD firmware using its
> peripheral ID.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

