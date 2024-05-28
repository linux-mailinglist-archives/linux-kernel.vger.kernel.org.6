Return-Path: <linux-kernel+bounces-192479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB18D1DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098E8282CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FCF16F0F9;
	Tue, 28 May 2024 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRQQgIp1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD61DFEB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904688; cv=none; b=Q13Xe01vOjRCAvDvsb/m/sr4uXWFDAmhYvDNk/fnNZ/i25lr6AoD/vnrPHiy4PjFF1X+Hn43q9sz3b1Ne3D/A5Ruj8pZCPfYA7+42Hyg3f8ZeOtBadoOads2VyLtcefioi/azLZ2wm24B6jhq3IcWOzj5v5drri5Q5Mhg6eSZjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904688; c=relaxed/simple;
	bh=ZVtxcJa3l+RUPtsfeqDSxKSN/0xPmlwDIeDN+f5Ie5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxoD7y7vxNnqZoggz8yiZ87N5xbg9XfAH3yWELSRL3DQQpKRX7W/04afXo60mpKWptz/eZ1zdMjVoG/r5AnpKlhlyKmjFWlbYYTE+OP1I/ij6iQXUysmmC++nLG+0onUxChawtXYku0na1lf7p1We07ZYhpBk9PWU9DxmkCoC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aRQQgIp1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716904685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fzsmeKVNJqT1kCCG+RLWqVYIt72dG70HCy83DBhcgg=;
	b=aRQQgIp1TVTV7f7z025EZ4H6x7bbi97bIO29PSPNTB8YaHUqIZKz2BAXH2rfBsSeMjXpiw
	hoy9NMJxxashBJX8OloRCpt2RmMtJTrl9dJQAQibGIdzpl1JOoLOG38f5SaY3dcyluo7PT
	zc1516VLdnKRfetnbjNZp8B+NormhPM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-l3XbuQaxNSCskl7yzPMVog-1; Tue, 28 May 2024 09:58:02 -0400
X-MC-Unique: l3XbuQaxNSCskl7yzPMVog-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-579cced186eso444739a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716904681; x=1717509481;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fzsmeKVNJqT1kCCG+RLWqVYIt72dG70HCy83DBhcgg=;
        b=O1uVBSQTTE0kQOHVlppNTAIeeDObWFdvpcDUU3CQ74QmbOqUKYMMCEav2Qe74YaOkf
         Hth+W36bmyrmAynU4Ig7KK12FbTNe/f9cjlNogZxenwcUA84Xj+78Xx1HYdN77jFd/b7
         ZmCkfcamGgjcFOdJ3sQvtxc754lnAZNALRSRBcPFzhCjZGv0mDveMvA/l53l79ltE/Om
         l2x77+V+iVd1HBZ8JeItxvu9icDO3fHUBL45CKqsKzmSSp9Ik4InhvkHZS4VVS9AXUtU
         ynjXW5enGFIAnJr5gJ5cPnpChmnscCTX48Lks3wl/COjJzGvaICVmH8aImpExmHvbqc/
         jpUA==
X-Gm-Message-State: AOJu0Yx/hP/9Ng3tHabVsCn1w73o8yWXui18kmv6J1ozM0ZsbaNLLG0V
	e34fUVwHjY+qDN/SldeoPoi3EVmLYHX/gVyn2QegcRAyiVz9LfOv6sLuLmIVjzSYeOsINQo+pHn
	2ooo9PCIA6izHTTM0vu564u7YlFxeCvvqczHFJk0v1hcu21KyxiD1fcGWoV/fTsdVbConeg==
X-Received: by 2002:a50:d593:0:b0:578:5f1b:5018 with SMTP id 4fb4d7f45d1cf-5785f1b50f6mr7419657a12.29.1716904680831;
        Tue, 28 May 2024 06:58:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/9hwXAmsyFr8n4AY7oT/3Ktlf+X2RxT5CuoFiU3PmOw7lZ/A28IR/cQP+Izo4xMNtE9k9+g==
X-Received: by 2002:a50:d593:0:b0:578:5f1b:5018 with SMTP id 4fb4d7f45d1cf-5785f1b50f6mr7419640a12.29.1716904680345;
        Tue, 28 May 2024 06:58:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579ce607407sm3572608a12.74.2024.05.28.06.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 06:57:59 -0700 (PDT)
Message-ID: <162cb2a8-1b53-4e86-8d49-f4e09b3255a4@redhat.com>
Date: Tue, 28 May 2024 15:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9/BUG: Bad page state in process kswapd0 pfn:d6e840
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com>
 <CABXGCsOC2Ji7y5Qfsa33QXQ37T3vzdNPsivGoMHcVnCGFi5vKg@mail.gmail.com>
 <0672f0b7-36f5-4322-80e6-2da0f24c101b@redhat.com>
 <CABXGCsN7LBynNk_XzaFm2eVkryVQ26BSzFkrxC2Zb5GEwTvc1g@mail.gmail.com>
 <6b42ad9a-1f15-439a-8a42-34052fec017e@redhat.com>
 <CABXGCsP46xvu3C3Ntd=k5ARrYScAea1gj+YmKYqO+Yj7u3xu1Q@mail.gmail.com>
 <CABXGCsP3Yf2g6e7pSi71pbKpm+r1LdGyF5V7KaXbQjNyR9C_Rw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <CABXGCsP3Yf2g6e7pSi71pbKpm+r1LdGyF5V7KaXbQjNyR9C_Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.05.24 um 08:05 schrieb Mikhail Gavrilov:
> On Thu, May 23, 2024 at 12:05 PM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>>
>> On Thu, May 9, 2024 at 10:50 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> Do you have the other stracktrace as well?
>>>
>>> Maybe triggering memory reclaim (e.g., using "stress" or "memhog") could
>>> trigger it, that might be reasonable to trey. Once we have a reproducer
>>> we could at least bisect.
>>>
>>
>> The only known workload that causes this is updating a large
>> container. Unfortunately, not every container update reproduces the
>> problem.
> 
> Is it possible to add more debugging information to make it clearer
> what's going on?

If we knew who originally allocated that problematic page, that might help. 
Maybe page_owner could give some hints?

> 
> BUG: Bad page state in process kcompactd0  pfn:605811
> page: refcount:0 mapcount:0 mapping:0000000082d91e3e index:0x1045efc4f
> pfn:0x605811
> aops:btree_aops ino:1
> flags: 0x17ffffc600020c(referenced|uptodate|workingset|node=0|zone=2|lastcpupid=0x1fffff)
> raw: 0017ffffc600020c dead000000000100 dead000000000122 ffff888159075220
> raw: 00000001045efc4f 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: non-NULL mapping

Seems to be an order-0 page, otherwise we would have another "head: ..." report.

It's not an anon/ksm/non-lru migration folio, because we clear the page->mapping 
field for them manually on the page freeing path. Likely it's a pagecache folio.

So one option is that something seems to not properly set folio->mapping to 
NULL. But that problem would then also show up without page migration? Hmm.

> Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING WIFI,
> BIOS 2611 04/07/2024
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x84/0xd0
>   bad_page.cold+0xbe/0xe0
>   ? __pfx_bad_page+0x10/0x10
>   ? page_bad_reason+0x9d/0x1f0
>   free_unref_page+0x838/0x10e0
>   __folio_put+0x1ba/0x2b0
>   ? __pfx___folio_put+0x10/0x10
>   ? __pfx___might_resched+0x10/0x10

I suspect we come via 		
	migrate_pages_batch()->migrate_folio_unmap()->migrate_folio_done().

Maybe this is the "Folio was freed from under us. So we are done." path
when "folio_ref_count(src) == 1".

Alternatively, we might come via
	migrate_pages_batch()->migrate_folio_move()->migrate_folio_done().

For ordinary migration, move_to_new_folio() will clear src->mapping if
the folio was migrated successfully. That's the very first thing that 
migrate_folio_move() does, so I doubt that is the problem.

So I suspect we are in the migrate_folio_unmap() path. But for
a !anon folio, who should be freeing the folio concurrently (and not clearing 
folio->mapping?)? After all, we have to hold the folio lock while migrating.

In khugepaged:collapse_file() we manually set folio->mapping = NULL, before 
dropping the reference.

Something to try might be (to see if the problem goes away).

diff --git a/mm/migrate.c b/mm/migrate.c
index dd04f578c19c..45e92e14c904 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1124,6 +1124,13 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
                 /* Folio was freed from under us. So we are done. */
                 folio_clear_active(src);
                 folio_clear_unevictable(src);
+               /*
+                * Anonymous and movable src->mapping will be cleared by
+                * free_pages_prepare so don't reset it here for keeping
+                * the type to work PageAnon, for example.
+                */
+               if (!folio_mapping_flags(src))
+                       src->mapping = NULL;
                 /* free_pages_prepare() will clear PG_isolated. */
                 list_del(&src->lru);
                 migrate_folio_done(src, reason);

But it does feel weird: who freed the page concurrently and didn't clear 
folio->mapping ...

We don't hold the folio lock of src, though, but have the only reference. So
another possible thing might be folio refcount mis-counting: folio_ref_count() 
== 1 but there are other references (e.g., from the pagecache).


>   ? migrate_folio_done+0x1de/0x2b0
>   migrate_pages_batch+0xe73/0x2880
>   ? __pfx_compaction_alloc+0x10/0x10
>   ? __pfx_compaction_free+0x10/0x10
>   ? __pfx_migrate_pages_batch+0x10/0x10
>   ? trace_irq_enable.constprop.0+0xce/0x110
>   ? __pfx_remove_migration_pte+0x10/0x10
>   ? rcu_is_watching+0x12/0xc0
>   migrate_pages+0x194f/0x22f0
>   ? __pfx_compaction_alloc+0x10/0x10
>   ? __pfx_compaction_free+0x10/0x10
>   ? __pfx_migrate_pages+0x10/0x10
>   ? trace_irq_enable.constprop.0+0xce/0x110
>   ? rcu_is_watching+0x12/0xc0
>   ? isolate_migratepages_block+0x2b02/0x4560
>   ? __pfx_isolate_migratepages_block+0x10/0x10
>   ? __pfx___might_resched+0x10/0x10
>   compact_zone+0x1a7c/0x3860
>   ? rcu_is_watching+0x12/0xc0
>   ? __pfx___free_object+0x10/0x10
>   ? __pfx_compact_zone+0x10/0x10
>   ? rcu_is_watching+0x12/0xc0
>   ? lock_acquire+0x457/0x540
>   ? kcompactd+0x2fa/0xc70
>   ? rcu_is_watching+0x12/0xc0
>   compact_node+0x144/0x240
>   ? __pfx_compact_node+0x10/0x10
>   ? rcu_is_watching+0x12/0xc0
>   kcompactd+0x686/0xc70
>   ? __pfx_kcompactd+0x10/0x10
>   ? __pfx_autoremove_wake_function+0x10/0x10
>   ? __kthread_parkme+0xb1/0x1d0
>   ? __pfx_kcompactd+0x10/0x10
>   ? __pfx_kcompactd+0x10/0x10
>   kthread+0x2d2/0x3a0
>   ? _raw_spin_unlock_irq+0x28/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x31/0x70
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 

-- 
Thanks,

David / dhildenb


