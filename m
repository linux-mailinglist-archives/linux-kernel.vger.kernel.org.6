Return-Path: <linux-kernel+bounces-518529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4331AA39081
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 02:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AC53B458C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCA8190661;
	Tue, 18 Feb 2025 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUWJSO1q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1F16A956
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842639; cv=none; b=TqLPIG4ro1kFmrmiAnj9qpTXQicCeZpQxrBv5WUpSbpTJrq26s0280fCGE4VqtmHdV4Vwpo3pOq78TpoGSs/34xdA9gjuS/pN9zH3Vr1Fb1tm1yImWgOrEiPvpTNDCCTUQlSupgMvsDjBH7RgRlwneVktbgHMiyeWEG/GBPT1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842639; c=relaxed/simple;
	bh=cuLdQSQWAtQu7++K1x0gvp6P1Ra67Ctg9F+vEcRx6/o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n3zsRsQcehkXs49wvdiInMqAP/1/tsxnhWo7yY3TroKpLbOa7zw7g8icuKelGVeQJZM2jjFLacw2qog4TdppuaSArUfv6l+HS6JkSKmDUHuua4+YKkGqGcXO51Jl2WJVjToUPBNV3BMGFViR1Oo99MHT3yyjmuF6hlg0sdNyAEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUWJSO1q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739842636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijVuTFzUHZtPo8upH9znQQc2eOXG2svBHZDJ4RmQxR8=;
	b=AUWJSO1qn+wfI0fXdSi/mFblV3M90gyBGne9TZffeRDuiW/i0yARjkAWQst2Xxign2Xep6
	1PQ28Z0BUO7TUyQ7QAecfW1HjGnMuFRpdFlIMIVie01Zn0fEHSo8kzIC6a7V5O09QOt23Y
	XM6S4RMKJSo+0kt5LMbFxl8y/0BeyRY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-TrVENESfMlSIi_pqeZJ1RA-1; Mon, 17 Feb 2025 20:37:14 -0500
X-MC-Unique: TrVENESfMlSIi_pqeZJ1RA-1
X-Mimecast-MFC-AGG-ID: TrVENESfMlSIi_pqeZJ1RA_1739842634
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e66c406bb4so62392006d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 17:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739842634; x=1740447434;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijVuTFzUHZtPo8upH9znQQc2eOXG2svBHZDJ4RmQxR8=;
        b=wpLSqlNASiMQOwOl5+N/WMyQBIMgZTQIsSIlDW9sDDltVaXB2Qs5dgygVTRLFtazMM
         cFicQVfwpo89umG2HZ72k11PeVRMGpTkDLMX05EDsGDsvblMVCCxFrnwiTeQo2lk/0nL
         oLUfCt3j0Z4jfGnx4GB3lVb2WbDcYfUJ9VfhPNFT0bZnXhgRkxWpWW7AOY5t6x9ueBEo
         sMSmdy7sAh+boD00Knsubvo/T4TkW5w0TOqt0KKJGfABozYTbxz8fbGWMaKbHhcvMgXz
         qM8lBG+lK/CVWITkcBqEIdBxnkeJmz7stU9qRMK1f0eXIahxJz3UsWj8vx/hcTHmcHdD
         mmmA==
X-Forwarded-Encrypted: i=1; AJvYcCUyQ3VoiAIjcijcIw+GCIThU8Cf2yz63mEupKOIkkSL80o1KKs00aaJvX9S3YxK+2HYO7kwmK0DaGCUsCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlATwwlK4ZlKsxPEHkUmsuQ2h796lssAhR4Pta1RtzKBAb5rcA
	qWHxl7PD4bN2vr60iTO1fojQ1ShiI9aZC6E4yWlkaj5HxcbODlsyIxuZ5xHUB9qM5CBnTv6cAUN
	LhJHZxtXMGOnEYJjguUdztKwXqDRrSTcknmdIGw6QGk6h0S2VZoN1C7tj7QWGeQ==
X-Gm-Gg: ASbGncuPKxjLHAwcQ2qP2q+6yKgnFzFLcUWDnnUu19XIvVqxmGd8ELyXGuz3MO10GBZ
	CCMWQg6lbq3uv1KNNOaWY8gJmVsiaox6XWOMou9DS8EKdOZPJ9eBNmnyTHUqpNqeVjJrZe0PS4g
	tSMGbgMSZlU1zkTeapZf7zMMiv8hz1eLgsRywKLyEuj6XDKTF5kFmXyh5KwBZZj/jCMqnoisDij
	FEmO+l/eDTFKSuO5SStDl1Dw0QzpysjnGqb+7HWYFGsNdfjEzFMn/W3st5supx3XUZAW9yECN2Y
	YFcy0zeTaz+No+N2jAIUgjdN5USGnpZELJJAixna0O4pzS0d
X-Received: by 2002:a05:6214:2528:b0:6e4:2479:d59b with SMTP id 6a1803df08f44-6e66d03b637mr170356146d6.16.1739842633750;
        Mon, 17 Feb 2025 17:37:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQD+nSBreG53VzxCnaRY9OZ4efdvjEVi6Cd4CZq5zxNmijO5yE9fKnoP7E0mrC9FHHPBKetg==
X-Received: by 2002:a05:6214:2528:b0:6e4:2479:d59b with SMTP id 6a1803df08f44-6e66d03b637mr170355956d6.16.1739842633421;
        Mon, 17 Feb 2025 17:37:13 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d784893sm58781506d6.26.2025.02.17.17.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 17:37:12 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <bc7241fb-2349-48aa-8d77-dca76490673a@redhat.com>
Date: Mon, 17 Feb 2025 20:37:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH v4] cgroup/cpuset: fmeter_getrate() returns 0 when
 memory_pressure disabled
To: Jin Guojie <guojie.jin@gmail.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20250218010316.1950017-1-guojie.jin@gmail.com>
Content-Language: en-US
In-Reply-To: <20250218010316.1950017-1-guojie.jin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/17/25 8:03 PM, Jin Guojie wrote:
> When running LTP's cpuset_memory_pressure program, an error can be
> reproduced by the following steps:
>
> (1) Create a cgroup, enable cpuset subsystem, set memory limit, and
> then set cpuset_memory_pressure to 1
> (2) In this cgroup, create a process to allocate a large amount of
> memory and generate pressure counts
> (3) Set cpuset_memory_pressure to 0
> (4) Check cpuset.memory_pressure: LTP thinks it should be 0, but the
> kernel returns a value of 1, so LTP determines it as FAIL
>
> This patch modifies fmeter_getrate() to determine whether to return 0
> based on cpuset_memory_pressure_enabled.
>
> Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
> Acked-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 25c1d7b77e2f..14564e91e2b3 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -108,7 +108,7 @@ static int fmeter_getrate(struct fmeter *fmp)
>   	fmeter_update(fmp);
>   	val = fmp->val;
>   	spin_unlock(&fmp->lock);
> -	return val;
> +	return cpuset_memory_pressure_enabled ? val : 0;
>   }
>   
>   /*
Acked-by: Waiman Long <longman@redhat.com>


