Return-Path: <linux-kernel+bounces-298790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C2B95CB88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8EF286D79
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9122718756A;
	Fri, 23 Aug 2024 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX5+k9Mb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2A14C584
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724413043; cv=none; b=FCRwyaTjTfUXSKdIFVpUZ2NBYXf1bew1YZOVd/dXPoAv9oCfKRl0/CB6jrP4g6WoW/Et1mSS+i/P8qWuO2SQv06InvC16zb8L6KRCfnPAPA1f2ZYaBB1PIS3WlmSVDcMX/9U0HOJX/zqM/PGkFMnUZihq/Dxu1vp6+w4mxZ9zsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724413043; c=relaxed/simple;
	bh=GPl8uY77bUzh4iZhu/CaDl6cICSLMEKTAWAHx5mEOk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGBlNsX8rGfMZ/kLxznLHtNSsq1SNUiTai8JChASBinEKri3wxGdWoDuLqcvnVE7eyYmAyZ1qxA87lWFAAs7LvzvJMlx/3akMivRHsMX+rp+Ss5NWzypEfGR231qYgCTmw/xO+tRgyCs2OZ1i9fRpCZT3kFW6/po5r4hqJofRyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VX5+k9Mb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724413041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rYxyG+LXyDi5NNZGE+0jwJ8qGmN5atS7yO0cGkZ4oB4=;
	b=VX5+k9Mb+S2w1tKSG9yCaeuktQJqsaVxQvkCyOrynnkoHCe4WtdT5+bNlECoihzbT5rpbx
	k29VHGclUDEbvXKAvwBS3yMg8Rlb+1t/E4UJCHu+65u1/yDKW/RWXzkrfmZ7FlAWGihbpi
	hciKNRaD2UOZE3lXLia5+uTwhHRK6D8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-Z7V-tbtLOtSyjUiST5KLfQ-1; Fri, 23 Aug 2024 07:37:19 -0400
X-MC-Unique: Z7V-tbtLOtSyjUiST5KLfQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280ec5200cso15998455e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 04:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724413038; x=1725017838;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rYxyG+LXyDi5NNZGE+0jwJ8qGmN5atS7yO0cGkZ4oB4=;
        b=FFAuw1uL3bRRzH06hsOxpe1ukzA58HQiPV9KGri89pC4oSxWpAt72niFH2KWg4+RmQ
         jwUN36J0AngvIvyX34G546ah6kOp9NPyZ8P6vup/sQpEz7jJRFCL5HAqSPvPGhTuVOoW
         ot+NEkcmeOQq44+dR2RwAFwjoVR50tk3ZTBZ4R70J6ilL+DiZcqRJAoUy+0SRve/VG8z
         O5SsT6NqWb8irX7bElDpqSED8dUbV1UqQP2+CMyLqaxike16ZR5xjoLM3wPa/KpLriN1
         n2M9Nyir6G46zkmk5yJ1TU9w1b/czNc378tzgY6da0OI7c9UePkG6/iJs9hekAJgbqCu
         6sqA==
X-Forwarded-Encrypted: i=1; AJvYcCUOzwm8pGUBMFM3TkodcPADllOKs3uvLZnanIvcx5ib7gxX18dau1LiOWJTBX/yiogtvqIuuZ/kK4CCuOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykgINi/wgnErHqTrzuy/XKyLeW0Eg4YUZZpDKJKX2UbqCBsXQF
	EIBj7FmpjmBJyb08bZfyw1/4V43Dp+9x2S4QAGZoBxvSmNWFCGkmmnTqwL2GZeUdlEcCfu8M+lX
	FjPjGWKfEZfYTSeh0DOaUh9VLwEdhcOQszHMr93XVFEKCJScqMA9G9rUwM3JgEA==
X-Received: by 2002:a05:600c:3152:b0:426:6667:bbbe with SMTP id 5b1f17b1804b1-42acc8d4aeemr15125085e9.9.1724413038046;
        Fri, 23 Aug 2024 04:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHil0t2f3EMdSI6qrKMgdpWCJIFjHzMiB8xAlM2QsdOsx5e7i8Ic05lZ/M8dbxDK8+LBvFGpg==
X-Received: by 2002:a05:600c:3152:b0:426:6667:bbbe with SMTP id 5b1f17b1804b1-42acc8d4aeemr15124805e9.9.1724413037001;
        Fri, 23 Aug 2024 04:37:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:e00:d307:70b6:92e9:1425? (p200300cbc71a0e00d30770b692e91425.dip0.t-ipconnect.de. [2003:cb:c71a:e00:d307:70b6:92e9:1425])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c520sm3924922f8f.39.2024.08.23.04.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 04:37:16 -0700 (PDT)
Message-ID: <23b3d29f-b285-4cc0-947e-49a555042ade@redhat.com>
Date: Fri, 23 Aug 2024 13:37:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: collect the number of anon large folios
 partially mapped
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 yuanshuai@oppo.com, ziy@nvidia.com, usamaarif642@gmail.com
References: <20240822224015.93186-1-21cnbao@gmail.com>
 <20240822224015.93186-3-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240822224015.93186-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.08.24 00:40, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When an mTHP is added to the deferred_list due to partially mapped,
> its partial pages are unused, leading to wasted memory and potentially
> increasing memory reclamation pressure.
> 
> Detailing the specifics of how unmapping occurs is quite difficult
> and not that useful, so we adopt a simple approach: each time an
> mTHP enters the deferred_list, we increment the count by 1; whenever
> it leaves for any reason, we decrement the count by 1.

:) And here you only talk about mTHP but not in the subject.

> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst | 5 +++++
>   include/linux/huge_mm.h                    | 1 +
>   mm/huge_memory.c                           | 6 ++++++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index b78f2148b242..b1c948c7de9d 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -556,6 +556,11 @@ nr_anon
>          These huge pages could be entirely mapped or have partially
>          unmapped/unused subpages.
>   
> +nr_anon_partially_mapped
> +       the number of transparent anon huge pages which have been partially
> +       unmapped and put onto split queue. Those unmapped subpages are
> +       also unused and temporarily wasting memory.

It's a bit more tricky I believe:

"the number of anonymous THP which are likely partially mapped, possibly 
wasting memory, and have been queued for deferred memory reclamation. 
Note that in corner some cases (e.g., failed migration), we might detect 
an anonymous THP as "partially mapped" and count it here, even though it 
is not actually partially mapped anymore."

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


