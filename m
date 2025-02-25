Return-Path: <linux-kernel+bounces-532643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39713A4504B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82D03AD5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BAE21B1A0;
	Tue, 25 Feb 2025 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1+GbYQZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650C0218AD7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522645; cv=none; b=SQ9KO4gtVEuO3swn2ypbkvZ6zsIHt11rOXqnUfQdR/h6/+GicHiNx8rEhNY9n5/gmAheuhgRXCE48vAHZHk0Ku0JlOqLqdese3NW035YBuGRHI3m8YRV7VBYdYFRAhNwgxlciec6xW6AYhcKt2EhdhfNqqYjYRUkW67c3MZLIY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522645; c=relaxed/simple;
	bh=fFPPERKTfi8mGUGm779neSrurhFuM8MdmclAeibEHHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0c20FK0GYtOUx1IPwE1ToV47gJNqn0zMCZ/gD8QH8f8aXtyrM3bQPdlCkVZy0qhhzexXIRdK2lF4+HOUyG+K0XBN19U56XQihxKpvbcLKkolqent/O3u6OXX4CCBrts9PKDiVK2V+CYJzenHlH4zPzFbG8vT7l95r8NyoUpi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1+GbYQZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJVc13YBLYcQhhBors+jGa91VWfcFb50JYNpdknUXOk=;
	b=J1+GbYQZRR2XZy9Mked917Rb/cZv6v9vzaN/oF35ypC1El1X6BilCHNOBE1ijUpYW13i+g
	l0nalFr2Oxuol37ObZdtOAbfSg4xv3PoTcLTVdc4r5sidGaNYhYr7iS7KOy3AT2Jt9n+ec
	A5+Oi/lJiZOS1rTdyF2sMag8Nz0JUcA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-_n9_DebHNSaDvGVbA2lZLQ-1; Tue, 25 Feb 2025 17:30:40 -0500
X-MC-Unique: _n9_DebHNSaDvGVbA2lZLQ-1
X-Mimecast-MFC-AGG-ID: _n9_DebHNSaDvGVbA2lZLQ_1740522640
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc0bc05c00so20016849a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522639; x=1741127439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJVc13YBLYcQhhBors+jGa91VWfcFb50JYNpdknUXOk=;
        b=ZxWmxrHMBwl9/EKii55xiUXZNXWjRdFpIMX1POp9ip4qFk3B6wu9iqDMOyCqwLnRwa
         QcNOAo8R2ZP8ipVxp5WHvBvp6YsrNSpzNPYLNcMzzjYwE7twUhO9I9VlHZHj/SUjMu+z
         JtP9+0OrtIOAAjj1vhk1NfZRN9ML8vmhmfttLn6oqjZXnMWED7JWAAESs1GeQbkSSzuP
         hhG/hhCZj692Vs6QBu+3DzNsydkfarFMn+Llw2c7g0fBKv9rr1inVKmmaYjmT+hxbpoP
         E5miVaCIrAy7b0yOIGMwB3GBxxQWm1kLq/oeNYs02wti/ltBs1roOXk8DkZD7q7M/l9n
         h7BA==
X-Forwarded-Encrypted: i=1; AJvYcCUomNlGJUppjiwfkIa37V2IDTIgtfQ9Rrq3gcVKEUCrNIoUSnJ8EWBp2WeefGGBFmO6HkpO9tunfa5E7Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqSg9uq1gWeHPl2DDy+IAIqxLXM4mFLBlTg8xZ3KoNRupYSqx
	yzuJ4NUrRnw1MXhsXbKbyLnXN3FYQDum3rnWFVLuzEEv0iYIFwJBEOZPzGiAIXdYaq08rFOjtO8
	p0kkG9ZO8M61QhNtgegeuZNkR1HfMvnSH9wQm0agOLz4NnlowN9d+7U8XmFvYRugoavnu6g==
X-Gm-Gg: ASbGncssn4iOacGxdDEeQaCLY/4IvFIyNG7gH7VD70MWCnBU657WqW6HV0+3Ow26vAN
	GtxC3McSTSQ7PSfBnXooHCVapYrIS0YZCDarE6xRy3q2GBnixYzuBqTbMyMuBfXUkPkw1/eOIoS
	6GuofNnBEEY/0JLxeRmg3EU76iQBrBVrk+/oaS1RkDSviQhoHLm+FILNoOQikejgnRXgfx9x/nb
	UbutJSJ4Gc0yl1eLHbCZsNZDA3TDhzHYdiwM7rW8XE2WTbTsVlt218hvQJNGvVcTJCQMI7bVmaD
	aZwjPpkNjEpPSA81rsOodI938FCaInOGgUdJuc/JsJA7CRuZMdRW0+D8Uy86QOBXGPW/GldzNl8
	0
X-Received: by 2002:a17:90b:254e:b0:2f4:434d:c7ed with SMTP id 98e67ed59e1d1-2fe68ae6bcamr8995179a91.16.1740522639403;
        Tue, 25 Feb 2025 14:30:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdseTczjLi48aVnqTQW4mRSbV3I8Ul1bJsKhnAUZxMdDYgMS6GSgqMt3SxEmjkNTk/UFX4NA==
X-Received: by 2002:a17:90b:254e:b0:2f4:434d:c7ed with SMTP id 98e67ed59e1d1-2fe68ae6bcamr8995142a91.16.1740522639074;
        Tue, 25 Feb 2025 14:30:39 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-16-70-52-24-57.dsl.bell.ca. [70.52.24.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a95c5sm92883a91.1.2025.02.25.14.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 14:30:38 -0800 (PST)
Message-ID: <68e82e87-606e-4443-99d3-7de6f665ce05@redhat.com>
Date: Tue, 25 Feb 2025 17:30:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: page_owner: use new iteration API
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1740434344.git.luizcap@redhat.com>
 <badc717329c288c58b7abf7513603aa3042c008c.1740434344.git.luizcap@redhat.com>
 <a196d780-c775-4f77-96f2-df3fe61af32f@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <a196d780-c775-4f77-96f2-df3fe61af32f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-25 11:44, David Hildenbrand wrote:
> On 24.02.25 22:59, Luiz Capitulino wrote:
>> The page_ext_next() function assumes that page extension objects for a
>> page order allocation always reside in the same memory section, which
>> may not be true and could lead to crashes. Use the new page_ext
>> iteration API instead.
>>
>> Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>> ---
>>   mm/page_owner.c | 61 +++++++++++++++++++++++--------------------------
>>   1 file changed, 29 insertions(+), 32 deletions(-)
>>
> 
> [...]
> 
>>   void __reset_page_owner(struct page *page, unsigned short order)
>> @@ -293,11 +297,11 @@ void __reset_page_owner(struct page *page, unsigned short order)
>>       page_owner = get_page_owner(page_ext);
>>       alloc_handle = page_owner->handle;
>> +    page_ext_put(page_ext);
>>       handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
>> -    __update_page_owner_free_handle(page_ext, handle, order, current->pid,
>> +    __update_page_owner_free_handle(page, handle, order, current->pid,
>>                       current->tgid, free_ts_nsec);
>> -    page_ext_put(page_ext);
> 
> I assume moving that is fine ...
> 
> but I'll not that ...
> 
>> -    for (i = 0; i < (1 << new_page_owner->order); i++) {
>> +    rcu_read_lock();
>> +    for_each_page_ext(&old->page, 1 << new_page_owner->order, page_ext, iter) {
>> +        old_page_owner = get_page_owner(page_ext);
>>           old_page_owner->handle = migrate_handle;
>> -        old_ext = page_ext_next(old_ext);
>> -        old_page_owner = get_page_owner(old_ext);
>>       }
>> +    rcu_read_unlock();
>>       page_ext_put(new_ext);
>>       page_ext_put(old_ext);
> 
> ... here you are not moving it?
> 
> 
> In general, LGTM, only the remaining page_ext_put() are a bit confusing.

Which part you found confusing: the fact that I'm not moving them up or that
we still make use of them?

For this hunk, I decided to keep them where they are because 'new_page_owner',
which is a page extension from 'next_ext', is still used in the last loop. So
I decided to free them all at the end for simplicity.

The other part is, page_ext_get() and page_ext_put() are still valid functions
for getting specific page extensions outside of loops and the usage in
__folio_copy_owner() (and a few other cases) seems valid to me.


