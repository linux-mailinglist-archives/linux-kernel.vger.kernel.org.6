Return-Path: <linux-kernel+bounces-526455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23036A3FEDD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06564422D22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743B2512F8;
	Fri, 21 Feb 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JKPOhH0a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4A1F755B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162726; cv=none; b=WCYHrtuKrz9k8y2wPGMQF+8Zlw92ADKbjVxJdSzor7qQPXRpP2MYKA8pcnr5yNj7sRaQvxMsLx1OQlKlY5exi5mG/1x/WBsdj0UY4OsAo/gjYPU9bYKR709ZcbPYP0/xF6knIT859dDeOLebu53P8gg305HlqAPkoz85WME0Sq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162726; c=relaxed/simple;
	bh=0JXu8xC+o3WRG0/ovetoaqq1qinilGdOO9j3DG5iDU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XjqbEGf/GgykXJOs6haGqa42OVPQxdbXNFwX2I3ajkyYJPnU5vHq4QRl5pqc5k+M2rAVH6bInuND865Sgki9ngoRCj/39+Qp/aYm1umTfHC5hYQX4J2nXVb02H3/XfBnsOEyMFvAR2pb8dw/saZ6OT6cCPwmd8f6GU/JkObvvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JKPOhH0a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LDSLwd031809
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rhC3bwMh1zSJjESMPaEPiau2/0hZQf2QwnREzFhtQhA=; b=JKPOhH0acMgfA8uu
	xIMHOO3r2bgQvTpdwnuHVBJVd0JnX4DpWj8xKRn2lPSK0wkhoNMTIEoDT3hvdtAi
	028irxGp5ouqyMeusdMhlE9A6r3FvsSLcJn0auVLzURJxIDno471/kFsVHiUD3bv
	APGkTWUw/UqgIAdoMkifl0pAY23Wbh875g/V/Uf2jffsRty8ctiEnKKTUqYuUMVz
	Ldm4LPSEHhV6xCQRifgUtjv8y/KMsmH3oSrAE9TORgskuTKThAbplKK0aqdhJgx4
	D2gRkV2U6GUM1CWqfyG0jc47rxX7MvxpmNKcWX6l1H48byuIDWHJMys/19kkL9yc
	SQ4c/Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy5jujc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:32:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc4fc93262so5342860a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162721; x=1740767521;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhC3bwMh1zSJjESMPaEPiau2/0hZQf2QwnREzFhtQhA=;
        b=cYuMMoCXkCIq7CFFTvBZ7SYAx91ex0x2WltzyotG+08loYtzHdhKVobWLY6/ScYNTK
         GtuoYwVp+gQpyFRBvZ2uecIu0CkrZ8rDUdVxnPeccFT/biF4r/VjssnsBEU4XWJ+LvqG
         Gwif5/H83YDr8JPnGtyQFRTEe3wbyZoP5qbb0CfPnmIaCFykKV192MgtJYytdjucUKwm
         c4lLdFAoxWB+7lFecrKqcaWtPwC4a8AY67W9seWFqJQLtrholzKBIRiC/fFA6bWEswSy
         oBF8c8tFxOrS2S4XEfdadWI8iiA2khFN4mm/XjDq1u9pmbB1+hObUue1gsPU5Ilrv5HS
         T0Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUodMx8wvfwbQJNuVRwQ9/O7FIWfJoO0A0CgGSEZaTyb6jA6XRHzGxBNpacQ414wvUtCYZ/fk4Q6h+qrgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6mmFKE0lOhFl/kilSSNurIjdIfhGFYZxMAxHqBtrV9Yicf3aH
	hN9Uni6GcPXQNuohnR4qTokvbaWtPm9QoLIOXfVoyx3pzFVN7/ewG61psNte6fMq/w/eIQ4fXej
	DCJA/UixkiH4s8AP1OLaoaL3GVYz0Qzo6ty8J0JVbGmbFUZaJhpC2wCgD5K0/epU=
X-Gm-Gg: ASbGncvxiX9IRrj0Uc2kr/NNWG9UV0a097NZmFG/i0s/y0fJaWXuajjLXR0gPpukms5
	TrriMsnRwhFvo3aW5RO83T7vPINTWegBKnTktkEywGWOI6S+ysuF3qHGkbJEXtizqTueq1WyQIg
	CiXbqQ8b4UR1nv1sugcbw0nyd2mEBqinLenVhMXLCwhA9ksgGuSu+QEhnlMoUldrc+qLwL97Hht
	Xbgei+12t5GxkBe2yZoIUZiA441k9/3KO55GaxpIWxkOSm7XWDFv+jwkqQMLuHDxAFBujftwZ32
	7QEY7VBc1xguqI3aGboXbpI5BUH469/zHTSe8/w0SMW7aCvfUnt4LzQLiJjm5raEQeajTbV/3DS
	vXQP3c4vm
X-Received: by 2002:a05:6a00:17a2:b0:732:24ad:8e08 with SMTP id d2e1a72fcca58-73426c8555cmr6050358b3a.1.1740162721381;
        Fri, 21 Feb 2025 10:32:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf5f09al3rVnKIctUkaNJwh9uBNopYGAdJw5I3zqswOJYkgGrLDlJasRb3swANLFbBEi51Kw==
X-Received: by 2002:a05:6a00:17a2:b0:732:24ad:8e08 with SMTP id d2e1a72fcca58-73426c8555cmr6050323b3a.1.1740162720927;
        Fri, 21 Feb 2025 10:32:00 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324275bd28sm15883247b3a.122.2025.02.21.10.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:32:00 -0800 (PST)
Message-ID: <2e55eb5b-9df3-48e2-8e93-511249672b05@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 10:31:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "open list:802.11 (including CFG80211/NL80211)"
 <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250219203240.141272-1-eahariha@linux.microsoft.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250219203240.141272-1-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: m6v0JKLpiALQIK3T2kqdtF-PF4DnxJir
X-Proofpoint-GUID: m6v0JKLpiALQIK3T2kqdtF-PF4DnxJir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210128

On 2/19/2025 12:32 PM, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies(E * 1000)
> +secs_to_jiffies(E)
> 
> -msecs_to_jiffies(E * MSEC_PER_SEC)
> +secs_to_jiffies(E)
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  net/wireless/scan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index cd2124329521..1de25e9763cb 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -1365,7 +1365,7 @@ void cfg80211_bss_age(struct cfg80211_registered_device *rdev,
>                        unsigned long age_secs)
>  {
>  	struct cfg80211_internal_bss *bss;
> -	unsigned long age_jiffies = msecs_to_jiffies(age_secs * MSEC_PER_SEC);
> +	unsigned long age_jiffies = secs_to_jiffies(age_secs);
>  
>  	spin_lock_bh(&rdev->bss_lock);
>  	list_for_each_entry(bss, &rdev->bss_list, list)

Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


