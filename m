Return-Path: <linux-kernel+bounces-536469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4621A47FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543851895897
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E2823024C;
	Thu, 27 Feb 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L73WJyHK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBF22E3F0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664220; cv=none; b=HDrGzjB0ZBj8+2ldtSl32bPY4GDOT2jZSriQozgSV786S+szGwKYe6L4ncHh7s28fgIMEIctfLBRAdbEy0T5b1zGcVxz6MeXCRNP+KdjnmdHtsDXQMi/9mHmtM0OAiVssYWkupmeZOtqJ8aAROsphoglvTXLhxkKTuhCw6tMIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664220; c=relaxed/simple;
	bh=O+HLrSr3mw2WW7dkMD/XghoxRaiHA9U2wcZBFkN2dWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FD4gZtd2k88CSMrZFnW0t/9Du7ITQ8PtEkVmrySe8vBy99hd8J+P3v4GCkANg3eXz7a+u1sNt3c+EX+/BKF1+Gl+cWR3iO7vFpG1Q6AuPgZPvMFRsiugfiRBZuJ9zQYmlw+b/tEnCRxt1MtBLQ1WqLPg9RItRTs8X1WcorXCLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L73WJyHK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740664217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z+0mMTWvFfhObQmaUis+jpAH7Ga0Cg8ZVC/JyN+ukyQ=;
	b=L73WJyHKykzlEZz8LZQHZSRwZgpyeFQ6BJQJghI+HB7mKdMxytvXeyrpiOA7dPuAPDhluP
	vTOc+skgRex2Eovb4sVe0za8STXyHK6fi469AXiKmvil8pbWis+V2wxxgeoYhz9MCOy7w7
	e7xvakK3CqHKAkz1Yudj35seqLLWoxE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Vftt1SDGMiaq4hcMleaG1A-1; Thu, 27 Feb 2025 08:50:16 -0500
X-MC-Unique: Vftt1SDGMiaq4hcMleaG1A-1
X-Mimecast-MFC-AGG-ID: Vftt1SDGMiaq4hcMleaG1A_1740664215
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-439a0e28cfaso5307365e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740664215; x=1741269015;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z+0mMTWvFfhObQmaUis+jpAH7Ga0Cg8ZVC/JyN+ukyQ=;
        b=HweH4q6AAr1rEhZDIr63aFLhl0DWXP3a6JD9zcmD4URyFUteZMviMU/CWp84hu4r4Y
         fO5fInjYlu/YraGfwSh0yPuIpKMmCtImsZw3yKZYxmJh/K5m5X/vX5Ev4tLXXntiwFKq
         a8LEkbn+9STsFCqcdVOBfr4vEcwNA3M1AxVu+3hMyOHRAiVArU33dO9TBkxSfrei7Mlt
         e/kCKyzuLWkAIWYVuDqJHCsGNjf0aTi4KZT2Nr6RaUrgCz2BtuHiHCsE2/7+1aEMGWEb
         CTBhywGe7n5JtnW0sGB4VMfmPAW0vVDu1VodmoFpLpYoXgjaRyHMCajwRWRkNixdwUc5
         m14Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVnkUUGGvFoRRHaGI/klSzwatOxycnXOFNT/AxYMGHnTkqtQHgdjUSpcs6daP3RXjRVoR2SyxFh3N107E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLA4RMBb6uiJfcclEL5z1sGOmyNH4WfA7mv1YgE0+Kg34exGig
	SDe93+2RkYISm2yNA2lS1L3IOOv17nIPie9xVvVVMwu9hpWgHOkcUsAJDUALMwfB59gC3TjINaH
	NDl1Gy8xd1zD8WEBcYmnTeNACpwIehtbZMUcVrVI3xRiWTaI/0G6HPoRr2NHl/Q==
X-Gm-Gg: ASbGncvCArkmxfDSDPGtFzOhev5q4B/y6JV04o/a/qN+QjstNwEsBXFZscwRw0cDUF1
	7SAITM9Kf2WUv3TMqnNUNZWzBkTKtcAqzNTYFsnatl589QFsYjQs4Njra43qUjAvJA6aKLq/uQg
	o2oWdlFfVoKmeZIMA/J61FMWJcEPBwHPLqv7Tj63VcU26lDbUocFCfH4U5Kx25pGoglkKd5ySc6
	/ChyYo0TSX/ANeQJuOyuJ6M1WsR4qm1/j3c1YayWWdS9v8i43EnKG2aH7/Xp8aYcDoQSkYpipz0
	dPk6FO0T7Eo3gRyCUE8M7kNaxOjg+Er+27wzy5MjPwhoErCH7IJkqqvFcfIfNQKhm0rVqAjlFWB
	In43vfP3IhsuITUJmDmaBmAfk6kCCYzYe7QK9XGmKOK0=
X-Received: by 2002:a05:600c:a03:b0:439:9386:ef6c with SMTP id 5b1f17b1804b1-43ab0f288c5mr101706285e9.2.1740664214750;
        Thu, 27 Feb 2025 05:50:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDUduqEbY2LCvGsjox/vge+fk04lpDMe0qzFuRuRtNztKhwZ/8DQpv3nQapkpurpd0JlzfBQ==
X-Received: by 2002:a05:600c:a03:b0:439:9386:ef6c with SMTP id 5b1f17b1804b1-43ab0f288c5mr101706075e9.2.1740664214350;
        Thu, 27 Feb 2025 05:50:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c74f:b800:58e5:8355:5366:573d? (p200300cbc74fb80058e583555366573d.dip0.t-ipconnect.de. [2003:cb:c74f:b800:58e5:8355:5366:573d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5711fcsm58296895e9.28.2025.02.27.05.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 05:50:13 -0800 (PST)
Message-ID: <5bb20271-a92a-454e-90e7-8812fd01d31d@redhat.com>
Date: Thu, 27 Feb 2025 14:50:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: page_owner: use new iteration API
To: Luiz Capitulino <luizcap@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1740434344.git.luizcap@redhat.com>
 <badc717329c288c58b7abf7513603aa3042c008c.1740434344.git.luizcap@redhat.com>
 <a196d780-c775-4f77-96f2-df3fe61af32f@redhat.com>
 <68e82e87-606e-4443-99d3-7de6f665ce05@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <68e82e87-606e-4443-99d3-7de6f665ce05@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.02.25 23:30, Luiz Capitulino wrote:
> On 2025-02-25 11:44, David Hildenbrand wrote:
>> On 24.02.25 22:59, Luiz Capitulino wrote:
>>> The page_ext_next() function assumes that page extension objects for a
>>> page order allocation always reside in the same memory section, which
>>> may not be true and could lead to crashes. Use the new page_ext
>>> iteration API instead.
>>>
>>> Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
>>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>>> ---
>>>    mm/page_owner.c | 61 +++++++++++++++++++++++--------------------------
>>>    1 file changed, 29 insertions(+), 32 deletions(-)
>>>
>>
>> [...]
>>
>>>    void __reset_page_owner(struct page *page, unsigned short order)
>>> @@ -293,11 +297,11 @@ void __reset_page_owner(struct page *page, unsigned short order)
>>>        page_owner = get_page_owner(page_ext);
>>>        alloc_handle = page_owner->handle;
>>> +    page_ext_put(page_ext);
>>>        handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
>>> -    __update_page_owner_free_handle(page_ext, handle, order, current->pid,
>>> +    __update_page_owner_free_handle(page, handle, order, current->pid,
>>>                        current->tgid, free_ts_nsec);
>>> -    page_ext_put(page_ext);
>>
>> I assume moving that is fine ...
>>
>> but I'll not that ...
>>
>>> -    for (i = 0; i < (1 << new_page_owner->order); i++) {
>>> +    rcu_read_lock();
>>> +    for_each_page_ext(&old->page, 1 << new_page_owner->order, page_ext, iter) {
>>> +        old_page_owner = get_page_owner(page_ext);
>>>            old_page_owner->handle = migrate_handle;
>>> -        old_ext = page_ext_next(old_ext);
>>> -        old_page_owner = get_page_owner(old_ext);
>>>        }
>>> +    rcu_read_unlock();
>>>        page_ext_put(new_ext);
>>>        page_ext_put(old_ext);
>>
>> ... here you are not moving it?
>>
>>
>> In general, LGTM, only the remaining page_ext_put() are a bit confusing.
> 
> Which part you found confusing: the fact that I'm not moving them up or that
> we still make use of them?

How we are deferring page_ext_put() when not actually working on these
values anymore. The page_owner itself should not go away here unless we
have a serious bug.

To be precise, can't we simply do the following on top?

diff --git a/mm/page_owner.c b/mm/page_owner.c
index c9d2c688eb981..12044340adf89 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -356,26 +356,24 @@ void __split_page_owner(struct page *page, int old_order, int new_order)
  
  void __folio_copy_owner(struct folio *newfolio, struct folio *old)
  {
-       struct page_ext *old_ext;
-       struct page_ext *new_ext;
         struct page_ext *page_ext;
         struct page_ext_iter iter;
         struct page_owner *old_page_owner;
         struct page_owner *new_page_owner;
         depot_stack_handle_t migrate_handle;
  
-       old_ext = page_ext_get(&old->page);
-       if (unlikely(!old_ext))
+       page_ext = page_ext_get(&old->page);
+       if (unlikely(!page_ext))
                 return;
+       old_page_owner = get_page_owner(page_ext);
+       page_ext_put(page_ext);
  
-       new_ext = page_ext_get(&newfolio->page);
-       if (unlikely(!new_ext)) {
-               page_ext_put(old_ext);
+       page_ext = page_ext_get(&newfolio->page);
+       if (unlikely(!page_ext))
                 return;
-       }
+       new_page_owner = get_page_owner(page_ext);
+       page_ext_put(page_ext);
  
-       old_page_owner = get_page_owner(old_ext);
-       new_page_owner = get_page_owner(new_ext);
         migrate_handle = new_page_owner->handle;
         __update_page_owner_handle(&newfolio->page, old_page_owner->handle,
                                    old_page_owner->order, old_page_owner->gfp_mask,
@@ -402,9 +400,6 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
                 old_page_owner->handle = migrate_handle;
         }
         rcu_read_unlock();
-
-       page_ext_put(new_ext);
-       page_ext_put(old_ext);
  }
  
  void pagetypeinfo_showmixedcount_print(struct seq_file *m,


-- 
Cheers,

David / dhildenb


