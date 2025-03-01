Return-Path: <linux-kernel+bounces-539798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A14A4A8C5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B429E7A62F6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 05:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E561C1F02;
	Sat,  1 Mar 2025 05:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="apClJgks"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F984204E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740806305; cv=none; b=crSIgWDrWRwY247GxOvQLjsUzGbN0DV6ulJGFVxtNwHOJpUjdAl8op4PBltz3s1FdbXBaJWQHcTpRk/ipXBnqWHZ5LgTWvEnnj5e/FGMWMFP4uOS+Yx16wWihA0qOBcX7xlKivJNbzWtWLzE/zNrmnOIA+frDgmW2ZauyOXX+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740806305; c=relaxed/simple;
	bh=wjIbfwuFNuPgizneQ79Zky8dP6tJE06v3/SoYtWbVik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKKUEiHDf0hbTINgPhzFUfpf8ZxgLXB4hGRbYQNhfriJsrOctrQNDi6BQut3Ozdxu62X9oQjRGHeAMhdDT5aQQk48z+okkuc2tIwz1xhR4rAzvFitT40pNyL3QAQyeTpzkFTQHvXrsc+7gAaE9NkkhXocnNS1ppwwJIxOPyI6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=apClJgks; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214wTv2029530
	for <linux-kernel@vger.kernel.org>; Sat, 1 Mar 2025 05:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eUHlZ4aWNrlCR37bnX9mIzuNVen1FLow500YvX1CeH0=; b=apClJgksW6hnfqGa
	zzQj94fwF8J5zsE1jMhViLFuE2Ai4RMDS8SnecxbzTEUiFhp3yTkx2gzz+huG+n/
	QkZh7mtEe+LH20wpy9iifabY4uqzknmdl/cGJKkfWkFupNdOtNQkZTmpxGjFsPly
	hZPDxfdCG32qoes4rljUGJ7nLqGn77KGsqAqxEHJyHDXRa/suuBDZdlUcb5s7BIs
	6D2MhQWIe/kxVht7abyRbt0QlQ3xAfQgpXGvJc6ncaZPWYnKEoDGAMe24vzhG7HX
	+VlqXPUZbmTWRvVt4czlJ+kDcsFXBqDiu2NA4aJk2zjj6H0yfu1O9i/S3aFCFWag
	TqMUoQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tas857s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 05:18:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22379af38e0so14377155ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740806302; x=1741411102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUHlZ4aWNrlCR37bnX9mIzuNVen1FLow500YvX1CeH0=;
        b=i/HimUYV5VUC8eyuk90kuBLiH77IEcQQyKCNWEiQdXe3qfwSBXoYFAa5ZvDZIY67U2
         f49JPWWSD3s9m/1b9coahRFxwhEPnze4NWONXxtBB+cvANZ0tUsXt7hg/naTfjJPYFI+
         YRd+deoRoLXt6GgkCKH48xzMtzFznM1zT9weqWvKWLpDky+DLe5CgkhzW/oD8RZ8vuDV
         yIcEMWVYBR61NLI7gDTYJ5rmbuZSuXIPxq/0VBpYLX40qtkci+SMRpR9XCLKJYdHbZX6
         TJYlu+UcbyesvXomu9I8lYKlP4reeTVeFKfMsoYaHVnyqUyJmPVGuJpv1cDCl7OpKWXT
         zF/w==
X-Forwarded-Encrypted: i=1; AJvYcCUSKV6r3b8Wlz/gYeXYsCSha9CH3aDpIaWivZpiris8a2Obm05VKYAzbeHPMFjwOW3Js2LI7SWzr5o3hHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySXe5MvNFW+YqMieNjqLeVIWVM1gqZspVj8DHb6cb6MI70ZIK2
	eteywVkKvFGmWBftUUTyCly0L4ESKlilxt066H/HmnJgBWA/88+ZKL2vRXLlrZCExSUO5EbHYzF
	vMxjCtxOUN3lJLRpBDWYRSAQ3eKCvHWxDe55VS2OI0U8O6G5r4kzwW2q+AEoLt1A=
X-Gm-Gg: ASbGncv1Loj5eVpMo2FKhAPv4zZnomX2lwqTSZ1KtyYBvmJrrm1oEcmz0tdHHKi25Jo
	Ro/Z+iXxVYPzV1270CIL41C4AGKXa4EwyOySqzD/66MhOMj30+5HWGLopIVrdLveMzd2pQOB4ZZ
	aM0BFetWzfZYSYbaLTN8qjiDd1T0DP79sbwMWE26W7x/hAvSQ2ogPKUknMxqeCqtt1Hquqy2e9e
	Uh/xjw3DxgeE7zqIhdGS696T2+6tuTx5eYMOSw0NVTETgMRySQ82+sO7aN2s5hISsZhRONeH3TN
	HcVklapXc73OKOCvjQnFHZv9SYq5QgoGBI57XQdy622oM6VxQf3MacfmgXH8zaw=
X-Received: by 2002:a17:903:198e:b0:223:4537:65b1 with SMTP id d9443c01a7336-22369255638mr96102125ad.36.1740806301767;
        Fri, 28 Feb 2025 21:18:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGB5dZuFhGRTIRMtkKt300um01cZR3OsgAUXHswvI1dGw4+Q9X4LegsPD55S273PcAvlGdfaQ==
X-Received: by 2002:a17:903:198e:b0:223:4537:65b1 with SMTP id d9443c01a7336-22369255638mr96101945ad.36.1740806301448;
        Fri, 28 Feb 2025 21:18:21 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm41195385ad.193.2025.02.28.21.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:18:21 -0800 (PST)
Message-ID: <eac47640-5ed3-693f-04c5-6e2945268d22@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:48:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 11/13] wifi: ath12k: Power up userPD
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
 <20250228184214.337119-12-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-12-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: l1LnmU0mfxr6o_ObA9mbjw-kDe_b4tOL
X-Proofpoint-ORIG-GUID: l1LnmU0mfxr6o_ObA9mbjw-kDe_b4tOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=702 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010038



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> 
> UserPD firmware image is loaded and booted by ath12k driver. Get the userPD
> memory region from DTS and load the firmware for userPD from pre-defined
> path into io-remapped address of this region. Authenticate this image
> using pasid which is a peripheral ID. Set the spawn bit to instruct Q6
> to spawn userPD thread. Wait for userPD to spawn which is indicated by
> spawn interrupt. Ready interrupt is triggered once the userPD is powered
> up completely.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

