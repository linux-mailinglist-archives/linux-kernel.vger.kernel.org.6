Return-Path: <linux-kernel+bounces-296187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7919195A6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8401F233D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CB017A582;
	Wed, 21 Aug 2024 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBIEtTn+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189291779BC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276382; cv=none; b=dII65mnW/jPMvhbDprLun6QBi1nUqwe0AZPj3Y46rxPDupjCGcM9L1JN6z0CQj2g4uhetdFy1yBkthhndKhzFQmV9SUkEDT/moNnxOaGmHJpbd81cQfzYQ+PqmYPfYl+27Pe7f9n0S2HvM0TBG4RHcXYcI7wnVLH2nMrK5CnW0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276382; c=relaxed/simple;
	bh=5jYc4gWZWeQZ8hXTQsk6MGUVHBGbg/RxvaakdcRqZp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgsUdzJFb3eEtewQsV9qO6WXNZvAgh6c561BL9i3y41XwHbFGdW79HHZ0lGmgivH9VwCSSBBdIswiMqaEhE5+q8JPJUzGfiZaDbXfsDm82xcriqxKnXThypJ7El1pZNvzk4+NVCslDLU1jjBLsSrBpUQPgr3TACqSO+BvvKrhFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBIEtTn+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724276380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VUO213Ze5zszhXHHYWUdqCWuIzvUfpaBvszkr8PmtFU=;
	b=NBIEtTn+wxzKrjHVAK+8BR+eajy8h9VmZbFoMj/W8PW4S+L5Bz9F4lykeFHendAYzvQGaM
	OoaLrTRw3fx0EQSAzN+ZtSDtKmNLSFJn6VFWz6lm/M0YmoapIyD58rmWYWyWhhNqLmCLi1
	CA+ELpMAGypLZwdy/wv0vIdWlbV3WMw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-DOTTxIrkNPuwIvB-eFccFg-1; Wed, 21 Aug 2024 17:39:38 -0400
X-MC-Unique: DOTTxIrkNPuwIvB-eFccFg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3718c0b4905so25435f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724276377; x=1724881177;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VUO213Ze5zszhXHHYWUdqCWuIzvUfpaBvszkr8PmtFU=;
        b=PgE6MJ3TUzZXgSuZ62BQEjSdgT+KuD/plnSXlGpMJdvg1DoJjoJkasiTRfyNE59G6L
         d+ToVE9sJG/BH+Cgd6Ijhka/NpvUPHP/5fThvvWms9QLpa/AVbO7cSjxsPlHm3vaK3Uh
         AiHs5vbTWhu8ZvGyxJZK5QVaLQFL9P0VnOV1+sHyarm1PsfapgaYTbF5HF+NvhNUpiOS
         X4lJOU9M65a9CFceMSnaFQkqZJHfqVFr814hnZXQEjxXxmAoYJCLaGgi54RThYL6VKCv
         K4Rq8WWKEunHLUYXCQ8Q3/9MzTeUiYY40wg0KXWWlBYwzEB/pSCr2cYnvEEFx/YPeLrT
         vljA==
X-Forwarded-Encrypted: i=1; AJvYcCXqSVVoAtD0bNwYWHxFEzblv6thO66lRVkrb6bL/1OIo08pI8fMeeZIuu4j3NLECzsGlCzv7qGYK7fIErA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3GCaxKQp3NKni0EE7oxKlseGy7hTcu8k338ru6AG2e7vSEyF0
	A5Zpy484hjVG5f25QoTM+fsjBNJ5bFMSMtEUZwv75IwojZINq1450JGVDQxis3I3odPG1BH1z7h
	MQmAQkaSLJPcOxlEkjh1PxiJkGQ06mCjAq6/pc8Js+FO4keV6LZc1Hb/59i200A==
X-Received: by 2002:adf:fdcf:0:b0:36b:c66a:b9fd with SMTP id ffacd0b85a97d-372fd576d35mr2270442f8f.6.1724276377501;
        Wed, 21 Aug 2024 14:39:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm0c6X/sX7cfnudili3E3oMoccOZ+YYBaOn+Go6JfP9o466U/5drSHtDyL85+aorgkfGNEgw==
X-Received: by 2002:adf:fdcf:0:b0:36b:c66a:b9fd with SMTP id ffacd0b85a97d-372fd576d35mr2270425f8f.6.1724276376667;
        Wed, 21 Aug 2024 14:39:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:4300:16d5:c5b:8388:a734? (p200300cbc705430016d50c5b8388a734.dip0.t-ipconnect.de. [2003:cb:c705:4300:16d5:c5b:8388:a734])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813ce6fsm34539f8f.30.2024.08.21.14.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 14:39:36 -0700 (PDT)
Message-ID: <6c01b794-7c51-4d90-a215-210ac21401d2@redhat.com>
Date: Wed, 21 Aug 2024 23:39:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: collect the number of anon large folios on
 split_deferred list
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 ziy@nvidia.com, yuanshuai@oppo.com, Usama Arif <usamaarif642@gmail.com>
References: <20240811224940.39876-1-21cnbao@gmail.com>
 <20240811224940.39876-3-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240811224940.39876-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.24 00:49, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When an mTHP is added to the deferred_list, its partial pages
> are unused, leading to wasted memory and potentially increasing
> memory reclamation pressure.
> 
> Detailing the specifics of how unmapping occurs is quite difficult
> and not that useful, so we adopt a simple approach: each time an
> mTHP enters the deferred_list, we increment the count by 1; whenever
> it leaves for any reason, we decrement the count by 1.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst | 5 +++++
>   include/linux/huge_mm.h                    | 1 +
>   mm/huge_memory.c                           | 6 ++++++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 9fdfb46e4560..7072469de8a8 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -532,6 +532,11 @@ nr_anon
>          These huge pages could be entirely mapped or have partially
>          unmapped/unused subpages.
>   
> +nr_split_deferred
> +       the number of anon huge pages which have been partially unmapped
> +       and put onto split queue. Those unmapped subpages are also unused
> +       and temporarily wasting memory.

The name suggests something else ... like a counter of how many have 
been deferred split :)

Would "nr_anon_partially_mapped" "nr_anon_split_pending" (or something 
less mouthful) be clearer?

(likely "anon" really should be part of the name in any case)

The name we chose (and the implied semantics) will likely have 
implications on the handling of Usamas series.

-- 
Cheers,

David / dhildenb


