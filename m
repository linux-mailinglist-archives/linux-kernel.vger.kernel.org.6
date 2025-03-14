Return-Path: <linux-kernel+bounces-561831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA7A616FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D304F3BB125
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380B720127E;
	Fri, 14 Mar 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gjrhRMkp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093E282F0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741971664; cv=none; b=brK+MACquwzlbM+A7whxR4QuNxaCaVuDdmuSGt+l0iX84Mhb4TyFvoOF7SKM6Pkom2UxxNBLOnm5NizGzf7/8b55Bu6NaDo1Qn7dLB8JTOqcPKyAuKhWh1bAr/YVBYZ7CJSQQGnfmBXqS+QVNED46PWv2Oyx/if/TUZ6Sqood9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741971664; c=relaxed/simple;
	bh=2QXPnUe9GLVtbWmmtYMb9nsF5q0waW4YXO1n6P3kWYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mc2ZDOrcxOHQQ2HQWTGJx/CmuAgVIA8AJEJHttXBHXBRnswHkial32PTekRp9oYrwA69dSEte/sfBBukDDGilPQHrwIZlrPu1H/xzitjuriiWZ+sKoocjIDCygkTFIs0LEvmaMmRXWjwNXCIUooPWTo1ah+J0G2Wjco42qzXmBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gjrhRMkp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EAPBag019879
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iZxIc4fXmTh7BmZPiGBzFz5sN8PXR72zH6C4vE4Nqcw=; b=gjrhRMkplGuVsQs9
	DJhFeCrCGcvtiTB/AuOtPcKHM+XYs2NjAmt1N+LV3NOOmzu+FKFLZvnd66OgPO6l
	our+icURRo0c3jm+ikJibDnsUObQ1lUjXjrwvurZoRWQxqiK/NLHzI42+49OcGY5
	y8PT45hp00XR6GRfWPkSG4CKBhMB7fbOaMQ1ukOF/smeEJHxsoLlFJqLsNXUkVFO
	kFDWN4Jie4rpUc/PEyI+xkS+41U7ikM63Jie5p+wW7809koXEfpjU7hr2vAiEF6T
	ccidCVmBHEWBbilRidFoBLuS1tEY8WhwR/Ps7TuL1iD1bln/DUPNUwzWJhaRhv1k
	dMYSEA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45cjph0yaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:01:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-300fefb8e05so3910043a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741971661; x=1742576461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZxIc4fXmTh7BmZPiGBzFz5sN8PXR72zH6C4vE4Nqcw=;
        b=n6mkSCj1RnglDT4amdAEgc6HmHGcmiFa5Z44bvl4AmM/d15+xKYr0/0zdao4a24bMR
         0RRlgKv1sgcoBunEpT1HrGhntCiUUIqUxxyuPlyo4izNNYQW/J+DsevampGWQxTKpDb9
         dLilqlyAdgVXhT6C7aaIRSE81FCMPqyo+7wEWFdkfVVKlFkE1PRoNlMqsMNdFr1ZpFLk
         xr72H4w3sESQ7Bjrkl4kfSBzlac3pTCSLX2Q3Z29wfar/bbOfqfANsEPiAIVFqCg4Zk9
         nJAE5V08lsEgKKIDAO80snszw/mPdm/gP4yYq8i4oGUFrY2Iz0gOeH/M1g3pRWobtqW2
         JtJg==
X-Forwarded-Encrypted: i=1; AJvYcCVVqBFddj0h462IVDy1+2DHaV+6FAxRu1z/fdmLiQYR5ctKgnHzV9/4CN26z48NKVc8zo/friyPI3HIBAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDbCmFalJrm6cb9kQzvhl6aEWQ0AVHaWahmLus92p0x5DvM85k
	kU+CsNr3XbWLKfzAhQHvGVZ80NvkTU0pl9cxSaE3p58PG2AipRimJKwB3RJ6LK3DWNRXwr7XRZF
	x5ccyHYhif33Dtz755BUw/wpsPgNZ+BdlRpmVY3eZc4hNhclG8Qkwg8mJYO8JIYs=
X-Gm-Gg: ASbGncsmQwWSYHyjMdJPcOsjCluz6epxF7YKZki9Qos7EqFLOkGMMimYO2hjX/YZeWk
	MOQf99CGHMI4YsQx8tmQcMDCeLIR3sqXNnSI+LXvacX1g/Mhghxu5uzJ32GbKjWraN6drCx1e0d
	fDGIeO28A3fQt09RnL7aPPCzShD4kmY6/yJ9MjEK9RTx7cEEkV+RGkT0pKV/g/22v2IakAvXBmS
	IUC0Bu9C6C2efqsuYng+ggq7sZH2IKCrBtLg9RWaRZhKnvbL1dP5j/vhovUpmKI5Ro3cfnJEdd9
	fldSHZ9ujQHTWQO+mm5+bW8CeQerJFIoiLWaiGVxD9UUtll4ojPi87ZujZGsbqVrWg==
X-Received: by 2002:a17:90b:1d4d:b0:2fe:8902:9ecd with SMTP id 98e67ed59e1d1-30151c9a224mr3857588a91.1.1741971660612;
        Fri, 14 Mar 2025 10:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7BkWC19VSzRPfQ+JLJt7WQkj0MaPieUPKAMlO8qGoLHk7FT7I8XtR55RY0QuJlSCC0mYjpg==
X-Received: by 2002:a17:90b:1d4d:b0:2fe:8902:9ecd with SMTP id 98e67ed59e1d1-30151c9a224mr3857559a91.1.1741971660259;
        Fri, 14 Mar 2025 10:01:00 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015363278bsm1240065a91.31.2025.03.14.10.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 10:00:59 -0700 (PDT)
Message-ID: <64370d2b-88c5-4663-8746-28bf36c6bdef@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 11:00:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Remove redundant 'flush_workqueue()' calls
To: Chen Ni <nichen@iscas.ac.cn>, quic_carlv@quicinc.com, ogabbay@kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250312073404.1429992-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250312073404.1429992-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a7sw9VSF c=1 sm=1 tr=0 ts=67d460cd cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=jdnOPd7pnXj7N3RGrIQA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: uVrH70HPX8P7o1SJjZwx31S2y_kq3J98
X-Proofpoint-ORIG-GUID: uVrH70HPX8P7o1SJjZwx31S2y_kq3J98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0
 mlxlogscore=871 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140132

On 3/12/2025 1:34 AM, Chen Ni wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> @@
> expression E;
> @@
> - flush_workqueue(E);
>    destroy_workqueue(E);
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Pushed to drm-misc-next

-Jeff

