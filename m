Return-Path: <linux-kernel+bounces-570688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E104A6B388
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F364669FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29061E5B9B;
	Fri, 21 Mar 2025 04:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QyYjGOmL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2F1ADC93
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529783; cv=none; b=UivakARt4J2fUrCgpXxqg+JF8ZR8EZ6NZaVPoQ8Xv84SLGvQn9yYEKtcsbhxGDN5eD85sMutYMKm0PMtJupS61hrpub6ZrYwlGPA7Z3HSVkfQQgE5vzrIgzXDk0ktSmUOdE8j5YDMc6xNKsZ0JTjbgymO5+4NOO+LgKCHbS1ZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529783; c=relaxed/simple;
	bh=8jgC6O5Rf5wrPIndxOK3S+gqzhuYxuqoOEjq38oFdKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLSNFTDX1O6v0R949C7RMKzt1ezYJu4LnDBUw/e4az8OVp2e5g4loCbdc6pBrT3BlQdkdUtSk0hs3qrKGEDAZ5cVdDyix1ut2vh7Fp4kt9SFG9g/0+BQGNdp3QLFl4AFLxd3UQO6PORA1ubzuU80hj6whPCTpexykzvGn+UK1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QyYjGOmL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L1WihM030931
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yWfO2BcPvIMHXrjWEJOrynRVKuEBJtq4aHvLkmmDT70=; b=QyYjGOmLUpxclaAK
	dDWaouWtz19mMXVHiiBtHFF7Ox5e4xP5Is3hMPKf9opGpXUpy5H7xPAZH6aQ8JgR
	OkvR4z4sJTLj8HjaKMPByG2akwKsCI25J0Cleo3wlhaX1fGbmKOigHN9W1viKlPE
	vkEg38tSWf36Egc4sy28/6dKcYSUK3Sk7/ZP9ak1j4700OwBurVWOSQzcytX6S5+
	HbnfvwI4tmOBqAe5W9HK7Lud69c9LfZJyoA8NxbQajo+0CY1PVftr2XdR4XAcmAE
	RaIQZi1h1jDWlONlFAfcXFsGThsx6oWpiJ7SRH4NsiHD9XyT0a4JQAtcle+QBSPc
	06ka2A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45gcd1bgu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:03:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff6943febeso2092176a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742529779; x=1743134579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWfO2BcPvIMHXrjWEJOrynRVKuEBJtq4aHvLkmmDT70=;
        b=oMgFCANJ3Iz1KzA1J/29icQLmRjdvZtunKOVuHgmccEfWvENNmLtZablYn55jXHItP
         fg9P+knJKP6fwCvVgQAzvS8Cq7WrIyk6qvnijrk6WQHmpHaqZGIzlLRxzt8wZvF0SnkJ
         xcYwJ80cKAzJvS/Wcl2Pn2KionugFjeV5rtEXpmNf6+MNsBdrtnfMM6S3yFV/A0a3Y1w
         4uG1Lw8GoBuWVLLKUF366He++mGErkd1VPy8V8le+GSDeldzIZeTvAaruaJ0z2/iEoT6
         QV3pbNb7iNEs3j3rC2h1MmxiZIhPL9sa598mKoCnKyj7d/2Krq7BpjOMOeE810v0XBtR
         v8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeJqm75iRX8N6zN19P2JW4Hk7PU3mucBNp9KVe+hH2jG2Sq+jpua5ApYVBjyxqQpokLFIt6tcfYNx7ooQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUTLOt1taWR0GVYkqdrMApF5ye+EdjT0IGsddVNT/IbNJTShw
	pkUDhxwq9olihT6iDPHqKCFYE2WfjVf7LAMyifAks9qm/7QcWBB+1X7e+Y/K808qOk1sO7xHwEF
	EB5To+AXeZuMRfYsWICwL6DaP/yOpPNN0QYDQpBud2jXA8kngPtKcoAeWOc5SVX8=
X-Gm-Gg: ASbGnct9ny9IbXDk7hD3qTZ71PIi7jn6S58axl4p4fUsZvxg/U86WQtOvVqn+uV/QXv
	TI2kMybKGZG9XB8Xeo3NAkQr2MtvJxSwImKUyI+nXRvpA/cBu4N3l2wNJAUhdOJ4PE8pTy6VzVs
	l1dUt/p1+7/1puBza0hydF5HtPFUlNVIkbngk2+lS5tVxbuXHzv4MH7ytjjUT7sskfTOIYnj65u
	lLSP9OaVclMj5eioqTDPR92NElyIRZs7K3O0lvUNNznEcJe1228CanPrvbEgh2QaId71Ro0Yq26
	R7e45z0IleVI4s60NmovVfPzGvi6e0xl+g7U4W8yuM8gGp3tkQ6l4Qbd3Uc8O9Ly
X-Received: by 2002:a17:90b:3943:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-301d43c9272mr9424158a91.15.1742529779079;
        Thu, 20 Mar 2025 21:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwEfWS1L0HjIr9WqT5+3VKK9Z3whZ1PxEMMo079UfL+36e8bxMvOO2G+eNOx5jd6ObvadbLA==
X-Received: by 2002:a17:90b:3943:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-301d43c9272mr9424116a91.15.1742529778596;
        Thu, 20 Mar 2025 21:02:58 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.201.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf58b02csm4865226a91.17.2025.03.20.21.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 21:02:58 -0700 (PDT)
Message-ID: <df8149da-beb8-b06c-949a-025a29f9f84f@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 09:32:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: don't put ieee80211_chanctx_conf
 struct in ath12k_link_vif
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bfFrUPPB c=1 sm=1 tr=0 ts=67dce4f4 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=13kUIL9uG/hLjppKjZ3b/g==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=uvMg_fejPkrpZwH_nmEA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: H7Y7fo4CETXVv1oFvsfIT80qRUcUQsbo
X-Proofpoint-ORIG-GUID: H7Y7fo4CETXVv1oFvsfIT80qRUcUQsbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_01,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=758
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210026



On 3/21/2025 7:15 AM, Baochen Qiang wrote:
> ieee80211_chanctx_conf struct is not put at the end of ath12k_link_vif.
> Note ieee80211_chanctx_conf has flexible array member inside it, causing
> below warning with GCC-14:
> 
> drivers/net/wireless/ath/ath12k/core.h:298:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Although there is no issue for now since the array is not getting used,
> this should be fixed to avoid any potential data corruption issue in the
> future.
> 
> Remove this struct from ath12k_link_vif, fetch it from ieee80211_bss_conf
> instead when needed.
> 
> This change only applies to WCN7850, and should has no impact on other
> chipsets.
> 
> This is an alternative to the solution proposed in [1].
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Link: https://msgid.link/Z8-Snz86Xfwdlyd7@kspp # [1]
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

