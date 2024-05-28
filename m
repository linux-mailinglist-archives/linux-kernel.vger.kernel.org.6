Return-Path: <linux-kernel+bounces-192529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E18D1E89
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966C11F20CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D9C16F829;
	Tue, 28 May 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGgzyqmT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA716E895
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906253; cv=none; b=okTjQOOYMP2J++AKH2eLToD2K8WMwCnqxWkXSzol1fl53zzwsQulpgd5uNl8OFGVIiPvVTH7ZdN3R3ftEqYtRC7m9f0hYgYM8z/TNAwpH1EZn1G5tlhEAnwGhALPDNM2i5JPxcwZMofn9uBRGDMTtpz0zSAEiLGUaRx+8fYy5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906253; c=relaxed/simple;
	bh=BAgbIaJ7O9IyvRpFl3SnBuCgOYmAvYzEXVyprL/YZlQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JPeUWLYRPTnqyaBqJuKt3UEkFkzILn2YKK2WO/kTgHyqfDGVshU7CnJepabYoeCneSQPxF9cX3KrnE4C1dua1MAISX4qbl2Vja5hY1Zk5O4RhFR61TRm6CcApCpCz3ZfCQLB/C/9ZgVeG8UOTZqAKupD5FFZYWLFNGu66FlbUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGgzyqmT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716906250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFeFUyDI8MZUuk7pi22smpjjmkxD26zY5WjpsA1fKTk=;
	b=aGgzyqmTUzhwp2/Rm8VDpbuapTKvKjkI/dKk4ElR+5kEGAZVcsRLk/c9LVn9U+UNTLmLSu
	0OhRVIO41Kfz7a+yxEEtmQU8i/5wi64IRvEai0MOUODp4JF3p3mlUeWnO72JrdHg6Jymep
	+Sf0/y2nhlbNNmKTuQJXsdIw4ue1Qw4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-t62pFX9CMcGIMw4BX6PnYw-1; Tue, 28 May 2024 10:24:08 -0400
X-MC-Unique: t62pFX9CMcGIMw4BX6PnYw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-579e6c8f396so576155a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906247; x=1717511047;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFeFUyDI8MZUuk7pi22smpjjmkxD26zY5WjpsA1fKTk=;
        b=iRcOaJX7OgNir+oJa0SN6aX7QeKYYIPJA8l9oT4IoIIR2UJxPQ7dfVmghSU5F1qF69
         9nIWekxVegv0XSQmL3xalkl9xx0XWqE0grdxZHXhOjK5uNu4rBTAod00y1woEMeA7KN6
         ulABS0GYume/gOXbUEqG5d/TZ/fyOWSQ+JNedWr2h9ix1HZgIVwDXpUn/TAoq2KqiTDP
         5fZHW3YyN7haqPQBBdzSRe/MHIxUhSh4q1MgowVoFsSqL0382uu+dHcTF2DjtktWWBx9
         +PIOcbRgU32LHHlRcvQpuNw4quL2goSNIK+56e4IZ2NFJ/7P2Mt3HndMq42tufFD2+io
         LxQQ==
X-Gm-Message-State: AOJu0YxDlCRBgE668fiUQvXJqeqrFF7V6Q4atxQl0jLzh6Olq+8elSKH
	BjDwUk3VnmYnq15pTelfqOiJtWCQsa7NGJ7fZkbHy/IsA6iuO8DKsSG5g4OLSzhgRXP74ce/n5O
	9qSJ33q5VYxFxSCbu80E9A0WpBom6NaqKkx1GvMoaDctsI6weUdBISPwno5Jryg==
X-Received: by 2002:a50:cd89:0:b0:572:7926:a0f9 with SMTP id 4fb4d7f45d1cf-578519ba586mr6750485a12.41.1716906247590;
        Tue, 28 May 2024 07:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHijkdlXElSp5VXxgvnTXmYyGnEF/2jH/gidiJ9qEqmCuQy2Hh1Qt6DibwfrYuXVfeINhz/0w==
X-Received: by 2002:a50:cd89:0:b0:572:7926:a0f9 with SMTP id 4fb4d7f45d1cf-578519ba586mr6750470a12.41.1716906247095;
        Tue, 28 May 2024 07:24:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578572e7aafsm7001506a12.46.2024.05.28.07.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 07:24:06 -0700 (PDT)
Message-ID: <209ff705-fe6e-4d6d-9d08-201afba7d74b@redhat.com>
Date: Tue, 28 May 2024 16:24:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9/BUG: Bad page state in process kswapd0 pfn:d6e840
From: David Hildenbrand <david@redhat.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com>
 <CABXGCsOC2Ji7y5Qfsa33QXQ37T3vzdNPsivGoMHcVnCGFi5vKg@mail.gmail.com>
 <0672f0b7-36f5-4322-80e6-2da0f24c101b@redhat.com>
 <CABXGCsN7LBynNk_XzaFm2eVkryVQ26BSzFkrxC2Zb5GEwTvc1g@mail.gmail.com>
 <6b42ad9a-1f15-439a-8a42-34052fec017e@redhat.com>
 <CABXGCsP46xvu3C3Ntd=k5ARrYScAea1gj+YmKYqO+Yj7u3xu1Q@mail.gmail.com>
 <CABXGCsP3Yf2g6e7pSi71pbKpm+r1LdGyF5V7KaXbQjNyR9C_Rw@mail.gmail.com>
 <162cb2a8-1b53-4e86-8d49-f4e09b3255a4@redhat.com>
Content-Language: en-US
In-Reply-To: <162cb2a8-1b53-4e86-8d49-f4e09b3255a4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.05.24 um 15:57 schrieb David Hildenbrand:
> Am 28.05.24 um 08:05 schrieb Mikhail Gavrilov:
>> On Thu, May 23, 2024 at 12:05 PM Mikhail Gavrilov
>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>
>>> On Thu, May 9, 2024 at 10:50 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> The only known workload that causes this is updating a large
>>> container. Unfortunately, not every container update reproduces the
>>> problem.
>>
>> Is it possible to add more debugging information to make it clearer
>> what's going on?
> 
> If we knew who originally allocated that problematic page, that might help. 
> Maybe page_owner could give some hints?
> 
>>
>> BUG: Bad page state in process kcompactd0  pfn:605811
>> page: refcount:0 mapcount:0 mapping:0000000082d91e3e index:0x1045efc4f
>> pfn:0x605811
>> aops:btree_aops ino:1
>> flags: 
>> 0x17ffffc600020c(referenced|uptodate|workingset|node=0|zone=2|lastcpupid=0x1fffff)
>> raw: 0017ffffc600020c dead000000000100 dead000000000122 ffff888159075220
>> raw: 00000001045efc4f 0000000000000000 00000000ffffffff 0000000000000000
>> page dumped because: non-NULL mapping
> 
> Seems to be an order-0 page, otherwise we would have another "head: ..." report.
> 
> It's not an anon/ksm/non-lru migration folio, because we clear the page->mapping 
> field for them manually on the page freeing path. Likely it's a pagecache folio.
> 
> So one option is that something seems to not properly set folio->mapping to 
> NULL. But that problem would then also show up without page migration? Hmm.
> 
>> Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING WIFI,
>> BIOS 2611 04/07/2024
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x84/0xd0
>>   bad_page.cold+0xbe/0xe0
>>   ? __pfx_bad_page+0x10/0x10
>>   ? page_bad_reason+0x9d/0x1f0
>>   free_unref_page+0x838/0x10e0
>>   __folio_put+0x1ba/0x2b0
>>   ? __pfx___folio_put+0x10/0x10
>>   ? __pfx___might_resched+0x10/0x10
> 
> I suspect we come via
>      migrate_pages_batch()->migrate_folio_unmap()->migrate_folio_done().
> 
> Maybe this is the "Folio was freed from under us. So we are done." path
> when "folio_ref_count(src) == 1".
> 
> Alternatively, we might come via
>      migrate_pages_batch()->migrate_folio_move()->migrate_folio_done().
> 
> For ordinary migration, move_to_new_folio() will clear src->mapping if
> the folio was migrated successfully. That's the very first thing that 
> migrate_folio_move() does, so I doubt that is the problem.
> 
> So I suspect we are in the migrate_folio_unmap() path. But for
> a !anon folio, who should be freeing the folio concurrently (and not clearing 
> folio->mapping?)? After all, we have to hold the folio lock while migrating.
> 
> In khugepaged:collapse_file() we manually set folio->mapping = NULL, before 
> dropping the reference.
> 
> Something to try might be (to see if the problem goes away).
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dd04f578c19c..45e92e14c904 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1124,6 +1124,13 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>                  /* Folio was freed from under us. So we are done. */
>                  folio_clear_active(src);
>                  folio_clear_unevictable(src);
> +               /*
> +                * Anonymous and movable src->mapping will be cleared by
> +                * free_pages_prepare so don't reset it here for keeping
> +                * the type to work PageAnon, for example.
> +                */
> +               if (!folio_mapping_flags(src))
> +                       src->mapping = NULL;
>                  /* free_pages_prepare() will clear PG_isolated. */
>                  list_del(&src->lru);
>                  migrate_folio_done(src, reason);
> 
> But it does feel weird: who freed the page concurrently and didn't clear 
> folio->mapping ...
> 
> We don't hold the folio lock of src, though, but have the only reference. So
> another possible thing might be folio refcount mis-counting: folio_ref_count() 
> == 1 but there are other references (e.g., from the pagecache).

Hmm, your original report mentions kswapd, so I'm getting the feeling someone 
does one folio_put() too much and we are freeing a pageache folio that is still 
in the pageache and, therefore, has folio->mapping set ... bisecting would 
really help.

-- 
Thanks,

David / dhildenb


