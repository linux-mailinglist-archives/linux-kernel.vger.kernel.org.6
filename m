Return-Path: <linux-kernel+bounces-545553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DEFA4EE7B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36A93A4CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D542324EABD;
	Tue,  4 Mar 2025 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VZ6O9x86"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA41FECB4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120511; cv=none; b=KeELBwh7DtUhA0muLeOlcFcWCkTzr9OLDUhyyOf37eWCIz7YDec6O4WCFVjS/o0rXp5/gjWlUs9ArGbcHfpsNmcsz4hfBKA3gwIGg6JPUXGSghGeTgLq8X/8u8blQhBpHf2sleGUfW2SPANBMK2PJKA0AlxKgzlNd802JSw7Chk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120511; c=relaxed/simple;
	bh=5CATaT+vuXFneRrXovUb/F8vmYFOLFALDZsrIyHu084=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=A1U4Ctpd45KiLD7KQxS64npUKYltExPCjjokR3xfA9JwgW4Zy5IncCfC106D+NZtCaQ8ATuznesEfDGi/EC2/9nljZF3gEAbCBjxW/LD1/OtyzdgSPZdEByeKJtkZKIoLfDJUZilvgeC/Kevg/CwzRCA8rinbdxu79RiWPV349s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VZ6O9x86; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524Aa9BN016174
	for <linux-kernel@vger.kernel.org>; Tue, 4 Mar 2025 20:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lyZ9KZcmAozLbf98x2GQOc
	SaLEpjLWxAVW305JA8sSA=; b=VZ6O9x86dhpapq58oisVwF+VX8EnWerCBDuG7M
	iY4rYC9V4EoLi+TsBbjqN6IvFlEpBDoo6xWP5yhplL9yzXvtrl8DQyxYE6Wo6LcR
	jEM7KsGJsjevNtBhn8iFO0uQoZcB5eqsZT/E09N3LIxB6GIHCmUWqBFicLBHdDOD
	RB+WsHb2juvqGeoUfIQgXe8cgx3oLgYgkRpaWBeF6BgNs/yPU2qyWUehD10Yih6I
	TgfH8fcDX0gAt358/EC82ld9yGHJmVligUcDibF37NJ4KZd7a5BCEtzUzvSULxFB
	aTRaWtNUrDHQR1wIndrTTkVcAhAwWWS0jwpe2/4JQC9l8rQQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t3504-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 20:35:08 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8add20c70so3791526d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741120507; x=1741725307;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lyZ9KZcmAozLbf98x2GQOcSaLEpjLWxAVW305JA8sSA=;
        b=Apy+s7r5DxcZUyLhqNILXWqAEof/aLFZaHkRdtTtKVCXKUEUM86KR1mriZKVSKUkAK
         iaShjRRM5xQoSvLn0FdDv6jI509qZhN6AaffL9vLH+RcDutEN9Osz4pOwpGSeDWH3CTV
         Mw5ib1L5RCwA4CWcEWCu2RtmSz+sY3UsLIlOZh5HNqH6838YWDpPvK5zmH4i9+j6YOXG
         gyQ2dPMG8ToZmPWpIObjx1y0zKqpsinUSReJu/YknX+R/txDz4fKH4c1hDUOCs2JtnI7
         RC9fjoTU7Jkr51QK83McA9pJMQicI8drlv5I0HfuSVb6cjLK9I8YmtuOUaK67fHlYOJg
         GeAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYwz/f5yZNXKlkHYn1/WH9zrtGvRtpZQFN3uE3Wq1Gb/gTz/rmQZ/ObuZRL2KoSTOtCOWuDURljwMIdO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYey3ToWKgrqj2K7xu5WO1wOEWVb7Gk7YnUPiwUB7MWWtYcMgN
	jfHtB9Acykb/SO1N5OwiZIIb07Wf0s3z3osMgqRuTcPgUY3jJ18UWTd+Ay6PvdlyhRYOFIxdpnb
	QPP/lwjHvHVpFDB2B7QXTpy1e7Wt9pqSF2TalRirb6zFcyjFLxOdkxnFPxLtlyJ8=
X-Gm-Gg: ASbGncv15NDJHML8EgvtoOzkkfdozmgwpKrluaxewSGpLw33Qjkrss6Z4OKx+XD/JkB
	J4vTpxkz/veyJZ5oCOeQXxM+86TKsYteXA/j5v9RS3rLhydJnrCJ3cDKD/dIeu8hlrcnQThjrFp
	H11iY3sSwmjf+w+6Id7xWLymgHKYlL80lvNNsJHftBEJs5GU2rsH0R8zv1mTdu7pCNw7bvjs2Iu
	ZrMkDi1pQb3LdPFXzTGLT+3iX5BdAVbap9PjRSw6m+Ch9XHxMDsDGwauRZVUjmj9LR5ZJP71B9G
	JXYMIgfF9mWp/hE6/ro449bJj3BgpCeqK8QId+9nHDajBBzGHbv+g/6ucda+T1w5mN7qPg==
X-Received: by 2002:a05:6214:2508:b0:6e1:a79c:4cb8 with SMTP id 6a1803df08f44-6e8e6cfee62mr3885506d6.2.1741120507041;
        Tue, 04 Mar 2025 12:35:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm28h1xllMq2tXJKOJVS15ihtJCh/TUXmjO3xAQyRHvzHPVSZ3k9O4oOnfXIB7q9n+dowrqA==
X-Received: by 2002:a05:6214:2508:b0:6e1:a79c:4cb8 with SMTP id 6a1803df08f44-6e8e6cfee62mr3885386d6.2.1741120506736;
        Tue, 04 Mar 2025 12:35:06 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf45b506a0sm722319166b.30.2025.03.04.12.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:35:06 -0800 (PST)
Message-ID: <81fa7a0d-ed4b-44cd-b2e1-779a42401cbe@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 21:35:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Next Mailing List <linux-next@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: next-20250304 build failure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9HtwBIQPKATMH_MHwyKVRJ_3oFcL4jhi
X-Authority-Analysis: v=2.4 cv=KfMosRYD c=1 sm=1 tr=0 ts=67c763fc cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=6OJpePoKIdf77JAHNpUA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 9HtwBIQPKATMH_MHwyKVRJ_3oFcL4jhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_08,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=463 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040165

Hi, I'm getting this build failure:

mm/page_alloc.c:424:3: error: call to undeclared function 'in_mem_hotplug'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  424 |                 in_mem_hotplug() ||


building next-20250304 on arm64

Caused by 

b4cfcc26f507 ("mm/page_alloc: add lockdep assertion for pageblock type change")

Konrad

