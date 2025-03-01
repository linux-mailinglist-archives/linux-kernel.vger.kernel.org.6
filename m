Return-Path: <linux-kernel+bounces-539791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D81DA4A8AF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A157AAA44
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 05:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B541C173C;
	Sat,  1 Mar 2025 05:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GJAqei/e"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1E10FD
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740805761; cv=none; b=IXUByi+DNDkj72cqYvV2cXAGrlO0k/VAf/J2SoS08wm8lQxdSuFITKXYPiaQAW969VWzomHBgpRyq0Y26CllbIQUKyecLzIA+CrwIJCoyqD4USU29RRTIjp6jPgB4xg1l3RMvhEXcLr1UYv8lp+mK61jseWzBK8IoQ8L9rlx9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740805761; c=relaxed/simple;
	bh=tVSYEjvp7xfSqBqeTRApW6xii7D//ggjGpoVG0pjgcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8F9nnhhdOESMNOiZqS/zf3PKBhygN+SHpW+v3reysIQZbJLKS/0QRBe1Y1LFBqBpC4qtYW/Mv3QrT9nlOxrZaMRr8TzYktgUyC+ec4Xt8/0c8JZBnos9NHygpqAI60Hq+P6B8luza7xsifILv9l1p4wz+ADjWMaC0EUQ1lfZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GJAqei/e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213PdaV006219
	for <linux-kernel@vger.kernel.org>; Sat, 1 Mar 2025 05:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TIlk+ajMDuZH7zWgdOUVSBHCH+1wYAtnZW1d/mXvgbc=; b=GJAqei/em8uLud4q
	6x7RQPezu+SEwT3VvtF3gus25OQabyrxMNVjrVi6AvBuVNjFHk6EHFiLS1VGpZvO
	ZLIeCP45+Ad/PwcBXPvecr7t06wEKXsTx9fuWESHUX1cU1uJQULHXNPcmKSe6+7w
	CxoUx8biWWtY/FHliEOa3Bvu8ftKOPtgqCKlQWpbSRq9HimqYByrhKeJSPv8ejkb
	PaEGIFiBDU26lGLgPzEXEp9HQxRyBlCFl6iI9MxwlRWWtvyEyETqiU/HXjfQT4uN
	l8CBJWNVZHwMLTElZUWMVJVFhgLZXg/UCZhJES+nPoh7Mg4Ko7afAL6c+wsvvftv
	6sXhmw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tas84sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 05:09:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fe916ba298so5747884a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740805757; x=1741410557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIlk+ajMDuZH7zWgdOUVSBHCH+1wYAtnZW1d/mXvgbc=;
        b=AEM2B42rYLzC2h27jfghVHcDJhrXy9zuu/WufEaiKoghIrOVUn0SYmJfQV3rWiyDFO
         YEe59bW5dKQtdDyA00dF6KimVz3XsOzr0KnzcD7vW/RszwYAzHRMTSxLxMDZPEQB/KuA
         CHYdYSEUODdP9ArlfXagCM+qWAh/8ltPKPzjKgs0bq7N9G5B2MGIhl4StUo5x13LsEMB
         HJjBh57emGSzxrZZQp/oRcskSkt8POV0PSJ2HSxeqterx8HxCKxunaaC2fV+2zmI64Q5
         swiRQZDx44ODHXfL1M6b3h+G7f+2rx5z7ZExo08bljALNC7fpeZods4yjEqD6QK+eKOT
         9Eng==
X-Forwarded-Encrypted: i=1; AJvYcCXnJkv6QD6zQhcbb/XoFkqEuRWWq/3W91VJ4hD5ZC0mQTJJcOizUYbWq+PqbE4/Gqe4dNQ/lWQiYSggg1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfqggvYlFRYj7hn4eSzrlDpH0MOjXHp2LHBmXn+Cp/la5MIl0
	3p9FNi2HHT62QfMj4FGU0UfasTuAgCma9xty0LMeXOcLNCbBv4wVjyC0f2foxSbxN6MH6/o57cb
	yavPbOTyHjmfmsCbxQ+yE8BSt8uir4vCvdq1Wb8HWMIkI0EcEMH9pfwyyItqN/A8=
X-Gm-Gg: ASbGnctCn1+Qp3fHmWuO4TLpUsgvyXfZGqmN2xjpAQM9x3MHnrhMB/3mPrI80IJF0NR
	QSfuG3sE3on405Ylqvft/JhNB1pyRb0/HsTpdgfYpqbffGO334ms0yeHiduOSFXeq68JcYQrpte
	f3JunJBiwGv48nsutwR/2QReM0c1ltWtRUwXar5T0P0OmVOsS6zxRHDVu0Kkv3iExn9atcAOOOE
	Zl8nv/8TSOHzdyyaqXzFLoB++nER/KuHa0Zc6I1L0pFbQ6VTuO/r1Y85NRz749JnekOJM9J0sEi
	cInzswUG7F++/8ph+fBolTmXJ7QcLoTbOjzQjNb0Fp/p/8QmNwBnklbZQb81QUw=
X-Received: by 2002:a05:6a20:918b:b0:1f2:f20f:67ef with SMTP id adf61e73a8af0-1f2f4cc6306mr10874997637.12.1740805756952;
        Fri, 28 Feb 2025 21:09:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENJiGALApkF6kplPsgtv8JXeWGop0YeyYL3iNVBG+FhHdCgcP7xLV38B79Z64l3r46ha845Q==
X-Received: by 2002:a05:6a20:918b:b0:1f2:f20f:67ef with SMTP id adf61e73a8af0-1f2f4cc6306mr10874973637.12.1740805756581;
        Fri, 28 Feb 2025 21:09:16 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af14cd45d19sm1569783a12.35.2025.02.28.21.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:09:16 -0800 (PST)
Message-ID: <92c2e144-6769-7c32-b04c-04071ac8d6cc@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:39:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 04/13] wifi: ath12k: add ath12k_hw_params for IPQ5332
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
 <20250228184214.337119-5-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-5-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 13FN7kScAd0hegIXWXWdSCnZUlDiWc0H
X-Proofpoint-ORIG-GUID: 13FN7kScAd0hegIXWXWdSCnZUlDiWc0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=751 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010036



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Add ath12k_hw_params for new ath12k AHB based WiFi device IPQ5332.
> Some hardware parameters like hw_ops, wmi_init & hal_ops are same
> between IPQ5332 and QCN9274, hence use these same parameters for
> IPQ5332.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

