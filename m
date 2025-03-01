Return-Path: <linux-kernel+bounces-539795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAF0A4A8BA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C4C7AB0C4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 05:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24BB1BE251;
	Sat,  1 Mar 2025 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SC4nHPiE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11DC28E7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 05:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740806081; cv=none; b=GeyAjqqcb0aJEVuYiXG3aGssdLce58NZ5bXdaGFStPxe5uIq0C1swKHLps4dRaPPTCEbKx1RRkiJP/4wAM2lDmmhJ1et7dLQYKPMRTr+BqVNJ/fPVolr7Eg3mNCSzG2mS48R8mMPGLZsQnUQvIjyM/hF3RSr8PZ9BgHnRKWkRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740806081; c=relaxed/simple;
	bh=+M9asrz6Ulkh9VCT3n8mjVH6dI5QBl5eTCf5yiu6Tg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuEaZBQ4DdZV78XVsbJTa7l6XYor7hplldssT6iJ7muora6wffAZ2ZOOdpmF5mUSzScoX6NZy233hriPSrD7VkT3fa/66GhSidlTP6LQHF/5fg6gpTY0vSt/5cUsMkII6fExQQpJE7fNCjaQFWXddFDAmZyb5G3nVGlaC5RQI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SC4nHPiE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214Ct5b028231
	for <linux-kernel@vger.kernel.org>; Sat, 1 Mar 2025 05:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wqXyh11i/d9FgoI4iEyq9N7G01Ko6UG1G0l515btXXk=; b=SC4nHPiEAHXYKM07
	f6fxwC2X9zfCYQtE355d6fxXDZ0ptEwChXOYsLqwegKWwQbdaN3UPR80D6za1ZhM
	M0m3eTYYjbBve5YskyldufHvbGddZjHFa8iRfqQuSq/2OSlkjBqqSrnAMR9jQzqT
	5K3roeofgVJ0PvqtK/AE3Fx9tI+dS1YbXHFk7EVOZQwuyjxoHxuGCL1k70Xo3RYj
	42Ysdzc+r31P9xhFLCVw7kxVP7WuVQg7LwGeuykh21EQxoqInN4K489txgsiRjk+
	HRLy/5TWS51kwK1JkgeqJBhCpQPr2GE28YDGVs8euKpNaNbN2EUNCDOlglJNk+d0
	Pt1StA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d02h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 05:14:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22328fb6cbfso51296745ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740806078; x=1741410878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqXyh11i/d9FgoI4iEyq9N7G01Ko6UG1G0l515btXXk=;
        b=rr5Q6+qlRah2QCQzEQAWcOBhSvfMPkttYrj5maWz2gisQZwff/CCXZAyRn4wBGK5MB
         V8VePfe2ouGKw8BvvYn63mE3Y5pFD3eS3R6jZVS9Y+WTQFeQ+zyKj1gFCjPzN5aaSP9M
         ZiVxs5fbTTTIdnsQuqQGXq7cD524vWiWx8Wq0QcO85byErvp9NQKsKi5SUtk94dGSeOF
         JGzC6HPxr91rV6t5dChll4B6PCi1noSuIn5BOFtwYy/7ukuvVp11dUtxBIz8Q/QZk/0S
         9tAV3nzxXqwwV0KwklLdozcn7n6T/2UisAA/phkipUJT/xFtBnKaNsT4o/IG2hMqIAqn
         O5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVyC9TEbzV9o4juyO+0VE0a+RuhhIaPkr0HBLugvSEDoT/D7KPl+3jLbacqh5SRzs33PEm+VRH2kQAtPrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlw+lZSvnp3m8lLg6dtvIqFGxJuZSeEFmMl/Jog6BxGnBQW0My
	cuMi2G83M9wSYkgDr/yhCoUbErf4mYuGRStCXf4LKAfQ3Sj2EJdAerAt3xMKaa+bKHsb0szW3JB
	Ux919z7SHTL0ewDiqIanjhkZ8bgRJT7LzhEmNQk/lTtX0oCBbyb08tlhwNtnXkb4=
X-Gm-Gg: ASbGncs2iuhbfOLqQsmYjZiEpPnI93dAg6kv1JDHWWYb4nPEMtjRs+euCV596r2Glpm
	4yBots7LTVPIiij3G/U5+cV4mBNeiVNBwxa7JAPX+SO9ODR1f/16091vITbfDDpeYunLEKl9A1o
	MJwIGLX1PKLceMn4rZ+aDE6M9PF2TWhsY9syPXSBLR33/ioskf0btFvYLoX4FhC5vMPT0cSL9+E
	qBsImfNNxgOjTiYKg0ewvuaQuMHCYeYA2w9H/AcweJBfDYaGhngDpt+9uaPQ5YcyMa/KXEgLrLG
	Y5PgBAyH9fo5Rm3a7+bXYIRIYkImvQ6mrZsTMsqES3qNknupuaxGzJ9MrkhdkjU=
X-Received: by 2002:a17:903:f85:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-22368f92419mr88630425ad.17.1740806078036;
        Fri, 28 Feb 2025 21:14:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoz2h4kdT11XEn1qc7/HfnBptJ7ipR5xoJL1yX7WyyTVEQlp/c5aBmXGyfWjaj6RZK1gN6ww==
X-Received: by 2002:a17:903:f85:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-22368f92419mr88630165ad.17.1740806077696;
        Fri, 28 Feb 2025 21:14:37 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c15sm41660315ad.149.2025.02.28.21.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:14:37 -0800 (PST)
Message-ID: <332227ef-2036-c2e7-3ea4-1b37f8afd65b@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:44:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 08/13] wifi: ath12k: add AHB driver support for IPQ5332
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-9-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-9-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _3FHjO1P00jPuOp8693NOJNLMqj3uuRi
X-Proofpoint-GUID: _3FHjO1P00jPuOp8693NOJNLMqj3uuRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=760
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010037



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Add Initial Ath12k AHB driver support for IPQ5332. IPQ5332 is AHB
> based IEEE802.11be 2 GHz 2x2 WiFi device.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

