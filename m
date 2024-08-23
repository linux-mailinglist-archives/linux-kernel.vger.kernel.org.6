Return-Path: <linux-kernel+bounces-298773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7871295CB63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826991C20BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35465187337;
	Fri, 23 Aug 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKVtKYau"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E570149019
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412726; cv=none; b=PvRpHcZGAJMz+w6Rp5909+YB8uJdy9yKfKxmYNDGIRvlJj6md/6NgzzjnjJUFqWW9Q6MWF5JZknOlk4BUv4uZs0woLGF4S6o30L7SgDoI7R/vH5SWiW2JPPPnQRA/03rvUqn2Fco9RP//VGmv+pPm6W5BiL8/dJa2gw4g9ErYmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412726; c=relaxed/simple;
	bh=6ylDRBPyZOnw+uOVsLNeQznFpHfsjDjKilu47FAG20s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIaVYCfB3JOAVzAA4JSBPMZGuW4vYG4ZSU/bUtdS21SV/dc+J7ULlHXfTi5e2FqHX5E8gCa9wKI2GwsObIVly6jX3EWlvDHIU6T8zaC6Bkv9V6BOUvpOdWlFo9fBrnm+3EkHkirpYQt4UnCM1tV64ZzYkiDGdKFPUSTFsIcRCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKVtKYau; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724412721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oE6pe+6QT+1Gq/RF50Dlh13MqvD/a+/D/8DxHAeBm28=;
	b=ZKVtKYauVUjahAPQLUayADdbi848U6HPkV4MfPgnNfe9W7Y63oS8SiEcsJeTa/2ixGtyeF
	WC9Vk1vpC5w2h9Qr4RwBhsCTXtihmQ7CBAHhEc2nJCZ2oTf+3kyGvccsmMCBt64w/lbpNF
	SqEpKUBaQVZ2HXc8aGr3bl6xx8160dA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-_A4BoA63OQ23X97y5zbE4A-1; Fri, 23 Aug 2024 07:32:00 -0400
X-MC-Unique: _A4BoA63OQ23X97y5zbE4A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42817980766so16592015e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 04:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724412719; x=1725017519;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oE6pe+6QT+1Gq/RF50Dlh13MqvD/a+/D/8DxHAeBm28=;
        b=DifjQA+vtz95EFtdWQSXsRyqNd855kNddjTzW0+bga4L90+6e+wkhsbK3TtNazR06+
         M9fwCm+AHJSk0XuDhnURM/8f5cHRy9pzk8CJ7HmPzDk3PBz1D8W7YM05AqC36wByxP9e
         voMB4IIM7/RBHT7GUtb2wZCZZR5+yhz8QsWPH/Ldhyaa9ObxTEP3UjLqpODN7LpfxQz3
         UKYV8aHDcRLmkA95JIgPuAPUdKUOuULUYTzLZbDvEAymPhIE9R6wRolpVQ5k2fp+O0NJ
         cguUjLE39zTZM/DrQ7tpzoTd+X7Hn9MxXd1pWU0mfDJIZKotaIFL986OunPx+ZB/p0oN
         wHcw==
X-Forwarded-Encrypted: i=1; AJvYcCUva7JFrVSLw4k+2JRMPTAqdlx+UfY1NKDuHToFOXHB0r/KiJpjIXKzrUfufFZwbn4VQuNskr+bjaY3Ay8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzkegxLL8w5af1iYna4lxKT0HY2CFLtJPiE+QTaiImn8m3B4D9
	wU9u/J9r6iA0tDTb0A3dfxd4usykR9hgPAnnVzTuimWo868ijvsrQYvasr4QSTC5oZbk5EK35Wh
	ClE17vsnfab79hCr2JyOGnRDTRdoSghxGMXNq1U+R7HWq0cVbpRyruQIA2Gq6Gw==
X-Received: by 2002:adf:f24d:0:b0:371:876a:a98a with SMTP id ffacd0b85a97d-3731186510dmr1334627f8f.14.1724412718959;
        Fri, 23 Aug 2024 04:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy4MK6YnZIonvTpWrtZuEzfAs4emdoIEAG/oY96cOZgEmqfEeOgmXXZsoFEd8W5p6jQ9tAqg==
X-Received: by 2002:adf:f24d:0:b0:371:876a:a98a with SMTP id ffacd0b85a97d-3731186510dmr1334544f8f.14.1724412717892;
        Fri, 23 Aug 2024 04:31:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:e00:d307:70b6:92e9:1425? (p200300cbc71a0e00d30770b692e91425.dip0.t-ipconnect.de. [2003:cb:c71a:e00:d307:70b6:92e9:1425])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308264e09sm3918347f8f.103.2024.08.23.04.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 04:31:57 -0700 (PDT)
Message-ID: <7f9e6bf8-ec58-4525-ace6-98ba58de3172@redhat.com>
Date: Fri, 23 Aug 2024 13:31:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: collect the number of anon large folios
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 yuanshuai@oppo.com, ziy@nvidia.com, usamaarif642@gmail.com
References: <20240822224015.93186-1-21cnbao@gmail.com>
 <20240822224015.93186-2-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240822224015.93186-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.08.24 00:40, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 

Nit: "anon large folios" come in two flavors: THP and hugetlb.

I suggest to just call it "anon THP" in the context of both patches 
subjects/descriptions (sorry, I should have realized that earlier) to 
make it clearer.

This patch I would call

"mm: count the number of anonymous THPs per size"


Here I would start with:

'
Let's track for each anonymous THP size, how many of them are currently 
allocated. We'll track the complete lifespan of an anon THP, starting 
when it becomes an anon THP ("large anon folio") (->mapping gets set), 
until it gets freed (->mapping gets cleared).

Introduce a new "nr_anon" counter per THP size and adjust the 
corresponding counter in the following cases:
* We allocate a new THP and call folio_add_new_anon_rmap() to map
   it the first time and turn it into an anon THP.
* We split an anon THP into multiple smaller ones.
* We migrate an anon THP, when we prepare the destination.
* We free an anon THP back to the buddy.
'

> Anon large folios come from three places:
> 1. new allocated large folios in page faults, they will call
>     folio_add_new_anon_rmap() for rmap;
> 2. a large folio is split into multiple lower-order large folios;
> 3. a large folio is migrated to a new large folio.
> 
> In all above three counts, we increase nr_anon by 1;
> 
> Anon large folios might go either because of be split or be put
> to free, in these cases, we reduce the count by 1.
> 
> Folios added to the swap cache without an anonymous mapping won't
> be counted. This aligns with the AnonPages statistics in /proc/meminfo.
> However, folios that have been fully unmapped but not yet freed are
> counted. Unlike AnonPages, this can help identify anonymous memory
> leaks, such as when an anon folio is still pinned after being unmapped.

I would just mention here:

"Note that AnonPages in /proc/meminfo currently tracks the total number 
of *mapped* anonymous *pages*, and therefore has slightly different 
semantics. In the future, we might also want to track "nr_anon_mapped" 
for each THP size, which might be helpful when comparing it to the 
number of allocated anon THPs (long-term pinning, stuck in swapcache, 
memory leaks, ...)."

Further note that for now, we only track anon THPs after they got their 
->mapping set, for example via folio_add_new_anon_rmap(). If we would 
allocate some in the swapcache, they will only show up in the statistics 
for now after they have been mapped to user space the first time, where 
we call folio_add_new_anon_rmap().
"



> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst |  5 +++++
>   include/linux/huge_mm.h                    | 15 +++++++++++++--
>   mm/huge_memory.c                           | 13 ++++++++++---
>   mm/migrate.c                               |  4 ++++
>   mm/page_alloc.c                            |  5 ++++-
>   mm/rmap.c                                  |  1 +
>   6 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 79435c537e21..b78f2148b242 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -551,6 +551,11 @@ split_deferred
>           it would free up some memory. Pages on split queue are going to
>           be split under memory pressure, if splitting is possible.
>   
> +nr_anon
> +       the number of transparent anon huge pages we have in the whole system.
> +       These huge pages could be entirely mapped or have partially
> +       unmapped/unused subpages.

To be clearer "This includes THPs that might or might not be currently 
mapped to user space".

-- 
Cheers,

David / dhildenb


