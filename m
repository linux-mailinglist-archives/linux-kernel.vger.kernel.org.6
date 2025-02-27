Return-Path: <linux-kernel+bounces-537294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F3A48A24
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39F33A7FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D520F26F465;
	Thu, 27 Feb 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPVFcCbG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB21AF0C9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689475; cv=none; b=C2YOX0JKtv2FyAGmg1f1TyxVVGeQtdYM7mBfxsBBSzCLUpflFped92iFl1bNBv0HOhVvhZeOG/JpsGnZWtFZsuiGq7n7g02l710fY5AHI1TnDNqzZnRmplPzOfKVWJECD/yQD7FyYlWLcRwazLP4hRQH1RjpYxS2jxQ31u+aWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689475; c=relaxed/simple;
	bh=Cuc0ZvqIUZjaJFxkBg3nGAz6XibjLy8dm1mBum2pLnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bpi5hjXWf2Z7R427nTH5ZbX9YfTMEcxcCtNVbOYK4MFOUbHh4v72gSxP2XbQmmtEOEwu/Qkk5BPc8KO+sNaSbYiSyo02BlslJ3NuTY7Pv+LtRDHwX3HXKmFB0hxLDlPviWX/DBGw5xe9D2ShIM4atEyYSJqXvfkTShfwZUCEd30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPVFcCbG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740689472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0b9BgNrSRNcKxL7JJeoxnGNdFRVFSo7ngmVFsptsx8=;
	b=KPVFcCbGpgirQOmSvyc313vcAEGR9C/TIp+R2bikiJnwj927yVOLqB7bCJMGM+5JBI4m+a
	yB6YIURcQhJwN5Ie/YR2DJeIg5R09VNqnHzdfK9bVcSPr9eaWYBjWdb9l8yxHnL8n51D3y
	PHFN0wwBvi//ReCX2QM79FtxZUaZlYw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-zbKz8dTTP1CYg-0j8Obe8Q-1; Thu, 27 Feb 2025 15:51:10 -0500
X-MC-Unique: zbKz8dTTP1CYg-0j8Obe8Q-1
X-Mimecast-MFC-AGG-ID: zbKz8dTTP1CYg-0j8Obe8Q_1740689470
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-47220fab76eso46485571cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740689470; x=1741294270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0b9BgNrSRNcKxL7JJeoxnGNdFRVFSo7ngmVFsptsx8=;
        b=v4WUwg/Xu5NH4fy0QSwarz50Vesg0vs9MVAfkAcMsUS3KimrA3kgFawH8FrkrOzGZY
         LfPotttDx7v6Tp51etYSfGQXICMd8JWliTCfDJC99FDxKw9ZYfGw7zG3NDYBtDMGR4g0
         fpxQbN6IVXUMAoPUmrD9OqvzHzZtl9QXPe/OZfqUcVuhs0UhECPexJeQrY4FRCVU8h9o
         8w7dNzHxVBYFA/8toUomhAHRgez2LtkJC+AthBA8O4slDVU+iQ6m96XYewdDOpVT1GBB
         0l6h209ENna0pSVAxoHhikzLbjW/OXwGN5VeSgyZs5B4rm92bNe8/0vhiGfKTzU2xFWm
         LsVw==
X-Forwarded-Encrypted: i=1; AJvYcCXY4ev7ya8Kk/3i6GYExF+Te93fR+dF38/h6jZjhW3yISGc4/uUeYENw2XAMbSAA6CyuIg7dnwGE4AwYQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUv49IflUFPLmg1Xiv0tYTrVMDe8jw3lugW/7Ax4sEKGu69vv
	H79w3Js0sadrX2VrKq6eMuPDE1f4CcDDnjmEohEzpNI44ZINxo49PKZQJ/W+Q7A7BMuYjrQEbmZ
	hgJVSOjUVdDTZhkXVaZmeklJZdJmjFDELZcNjfp79M32h+oiXinvrWEEbPUewdg==
X-Gm-Gg: ASbGncseobMCM5SZ7GPNm8Bd9ulfeEh0I0iIVqJg1NBs1S6Jk/+Kbw4U7irklGBz5UA
	datxCTPNuWkSoDlTcAnX5BIguK6fNyz4KWRh/ncuIZLlBEhPFnRo3zelQIiTICYDxFatXE8bPSM
	36b3qc2zHjGw2RJL9dwl+IFHrbGmTmt32ne8vUD4ouBTQLHw+0ojzZETlAtnUcJUjS66RilopZQ
	uvCT7MF+MuTqaAY3EtBVx6PteZIDp+E/Q78QWtxcgAiTyvFzmJd9aDq+miBJtHvwacUxLXrrShR
	7OV68JkAgnCORD4=
X-Received: by 2002:a05:622a:6001:b0:474:bc8b:3f3d with SMTP id d75a77b69052e-474bc8b3fe6mr1682281cf.7.1740689469889;
        Thu, 27 Feb 2025 12:51:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXSchHq2foaKrZLcs7V3jjAhGMmCw06E/p0SekC5qwicuW3MsABzATaaIO/h6J8cBe2E3BBA==
X-Received: by 2002:a05:622a:6001:b0:474:bc8b:3f3d with SMTP id d75a77b69052e-474bc8b3fe6mr1682121cf.7.1740689469558;
        Thu, 27 Feb 2025 12:51:09 -0800 (PST)
Received: from [192.168.2.110] ([70.52.24.57])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a11fdsm15260961cf.15.2025.02.27.12.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 12:51:09 -0800 (PST)
Message-ID: <7ca09134-271e-48aa-b965-14fddd0504d9@redhat.com>
Date: Thu, 27 Feb 2025 15:50:58 -0500
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
 <68e82e87-606e-4443-99d3-7de6f665ce05@redhat.com>
 <5bb20271-a92a-454e-90e7-8812fd01d31d@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <5bb20271-a92a-454e-90e7-8812fd01d31d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-27 08:50, David Hildenbrand wrote:
> On 25.02.25 23:30, Luiz Capitulino wrote:
>> On 2025-02-25 11:44, David Hildenbrand wrote:
>>> On 24.02.25 22:59, Luiz Capitulino wrote:
>>>> The page_ext_next() function assumes that page extension objects for a
>>>> page order allocation always reside in the same memory section, which
>>>> may not be true and could lead to crashes. Use the new page_ext
>>>> iteration API instead.
>>>>
>>>> Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
>>>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>>>> ---
>>>>    mm/page_owner.c | 61 +++++++++++++++++++++++--------------------------
>>>>    1 file changed, 29 insertions(+), 32 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>>    void __reset_page_owner(struct page *page, unsigned short order)
>>>> @@ -293,11 +297,11 @@ void __reset_page_owner(struct page *page, unsigned short order)
>>>>        page_owner = get_page_owner(page_ext);
>>>>        alloc_handle = page_owner->handle;
>>>> +    page_ext_put(page_ext);
>>>>        handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
>>>> -    __update_page_owner_free_handle(page_ext, handle, order, current->pid,
>>>> +    __update_page_owner_free_handle(page, handle, order, current->pid,
>>>>                        current->tgid, free_ts_nsec);
>>>> -    page_ext_put(page_ext);
>>>
>>> I assume moving that is fine ...
>>>
>>> but I'll not that ...
>>>
>>>> -    for (i = 0; i < (1 << new_page_owner->order); i++) {
>>>> +    rcu_read_lock();
>>>> +    for_each_page_ext(&old->page, 1 << new_page_owner->order, page_ext, iter) {
>>>> +        old_page_owner = get_page_owner(page_ext);
>>>>            old_page_owner->handle = migrate_handle;
>>>> -        old_ext = page_ext_next(old_ext);
>>>> -        old_page_owner = get_page_owner(old_ext);
>>>>        }
>>>> +    rcu_read_unlock();
>>>>        page_ext_put(new_ext);
>>>>        page_ext_put(old_ext);
>>>
>>> ... here you are not moving it?
>>>
>>>
>>> In general, LGTM, only the remaining page_ext_put() are a bit confusing.
>>
>> Which part you found confusing: the fact that I'm not moving them up or that
>> we still make use of them?
> 
> How we are deferring page_ext_put() when not actually working on these
> values anymore. The page_owner itself should not go away here unless we
> have a serious bug.
> 
> To be precise, can't we simply do the following on top?

Yes, that looks good and I like how the new API allows for simpler code.

My only concern is that if the user is not familiar with the page_ext
internals, it might not be clear what page_ext_put() is actually
protecting in which case it looks wrong that we're using a reference
returned by get_page_owner() after releasing the lock. If you think
that that's not an issue then I can apply this change on top.

> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index c9d2c688eb981..12044340adf89 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -356,26 +356,24 @@ void __split_page_owner(struct page *page, int old_order, int new_order)
> 
>   void __folio_copy_owner(struct folio *newfolio, struct folio *old)
>   {
> -       struct page_ext *old_ext;
> -       struct page_ext *new_ext;
>          struct page_ext *page_ext;
>          struct page_ext_iter iter;
>          struct page_owner *old_page_owner;
>          struct page_owner *new_page_owner;
>          depot_stack_handle_t migrate_handle;
> 
> -       old_ext = page_ext_get(&old->page);
> -       if (unlikely(!old_ext))
> +       page_ext = page_ext_get(&old->page);
> +       if (unlikely(!page_ext))
>                  return;
> +       old_page_owner = get_page_owner(page_ext);
> +       page_ext_put(page_ext);
> 
> -       new_ext = page_ext_get(&newfolio->page);
> -       if (unlikely(!new_ext)) {
> -               page_ext_put(old_ext);
> +       page_ext = page_ext_get(&newfolio->page);
> +       if (unlikely(!page_ext))
>                  return;
> -       }
> +       new_page_owner = get_page_owner(page_ext);
> +       page_ext_put(page_ext);
> 
> -       old_page_owner = get_page_owner(old_ext);
> -       new_page_owner = get_page_owner(new_ext);
>          migrate_handle = new_page_owner->handle;
>          __update_page_owner_handle(&newfolio->page, old_page_owner->handle,
>                                     old_page_owner->order, old_page_owner->gfp_mask,
> @@ -402,9 +400,6 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
>                  old_page_owner->handle = migrate_handle;
>          }
>          rcu_read_unlock();
> -
> -       page_ext_put(new_ext);
> -       page_ext_put(old_ext);
>   }
> 
>   void pagetypeinfo_showmixedcount_print(struct seq_file *m,
> 
> 


