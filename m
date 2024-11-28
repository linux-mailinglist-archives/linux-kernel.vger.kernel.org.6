Return-Path: <linux-kernel+bounces-424649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1311B9DB781
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10816163942
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83519CC02;
	Thu, 28 Nov 2024 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqNsuCYm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF931993B1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796603; cv=none; b=AXWEINoCoSb9jnlu8DZd//MGVj21gmrZyBvC0St457Grm1KkQ1a4Q+qIGOFMeAXfybcZQmUjBdy9csdSu2m4BThEFHBhVO3GypubdQdRjqf0EeA6iiIaAcy40hrFrDAZgA0UKXWqf2GEKDebThbtRZi3YQvYidQeJTxCzjRHhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796603; c=relaxed/simple;
	bh=PNzE9r8OFToMdKP7PyCbfnj3ZIyf9VwYOUJJwZmusyc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g4qn8pzD+ILnWOiIvH65Dg8gcJMRPR9Z8ylLxLtyRnzL/VGN+Q8guNJqzgFBIQ7vCMyKvrlR+y+uQZD0RDY3yA+f9/pZf7jiEEuUXc/RyunaOZXbtfwDRwfXXtllCZr5Q0YFuhSBmsKpcPnpd61e8vsCRA9kpaBL1k+euDGzQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqNsuCYm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732796599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TE7UP7jSglcR/RvrFLPLuZmGZmeBAbx4PGJdf65WFDI=;
	b=fqNsuCYm/taYdB6x01WwBHcpuGQmlLnOJQE2PKQrhxUGSx+JbrwjH65+Iw/5641zZnnuam
	bHUv3ZADv4UNF2Dqpfch8qRCMTkDfuNsT7n9Ls1gaa5zXecV2ZxxZYFpd+rUiZ0gWTALXX
	dBcVWjubV43Ef9HBMmm8ob9rg1o1jmM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-gJbeFdLdNaGmdbx-mui7PA-1; Thu, 28 Nov 2024 07:23:18 -0500
X-MC-Unique: gJbeFdLdNaGmdbx-mui7PA-1
X-Mimecast-MFC-AGG-ID: gJbeFdLdNaGmdbx-mui7PA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d7611ad3so46368f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796597; x=1733401397;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TE7UP7jSglcR/RvrFLPLuZmGZmeBAbx4PGJdf65WFDI=;
        b=g9zPWWz67Do0Wq7ZLaRVw5HcBLsUH7eG/9W9CJxdPF5PJ9SrTUENdprFhs4+/o+x79
         eBobczgXv9lLdc4Pw2SAFVqZvmmMZGGNi2IDF5+FsLtvAzQ8OYDMyB5t/EkxniyaGeL/
         S4RUZ8bHmoJqi7K+cQXoWB+q1mYfcv5I3Rm6oskq1LUVhftSgPpYDYel8431UzfkBNis
         woAEoQ+i/WUMLGW8pZEdcNKNjcBLydGmB//Qo7s6Q46uEnvmd1Kc2jVN/zgRRPOZl/+J
         rHfqN2sLjGSwaZho5/s097q2ptigC+k7m2o6yNm+82dmv9kgqpUTFE0meDrshZ9cKQ8H
         I/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUCX+XwINtZu7344w6f7ihOweV6YeHnCKpBIZ0XLedXGo4VsCmoWm5jFUcCcbE1CiFuyxnHOtoGlx1imY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8AVnv6Z4hnlSxX8T8bnZV4Mxfrlkc12kWzTjsjtLYLu3wKT5
	hkGxgyqWeWnk8r9DXRcUqKIrIK466QB9xWDoCFJ0oQWaSMMs9XPgUNFBqz0flk9gEGTaZ4bLxr4
	8Nsxqv+8LSeLwmDLjt2tzWq9vg1WI74N4OZwwa3ENS30E8XkmSVmpp/kvGw/GkZzsYu4oKg==
X-Gm-Gg: ASbGncvJsKxgYIS5UTvky51QF41HUEfrNO9FluaEvGhixkIvGsvEGoyrtwWV/BgP3qs
	6lBj+65JV1JsSSjQUV7Bbot/+kGAIoy18Eq8qnZF2GfQ9DDQHnUlLfUPEw0NU9QHg50h4TJjz8p
	qKwnng7T1xYshXWc0Gmbyv02PDmMH7jaG5KgqkC+faC1tGUctzX7C0wPEMSYRWBzNI8afGGM6/a
	AxpWvi9h48as9yZQdPYkFXPDt1g2dw+cHJEgvUQQWJQjdU+ErIRdQGo+9n4H8jyZT3cVkZRWUm9
	Hzm3uL5QM4SaOyVJiaj43x9xCzN+UKiNx1z8+FWzgZRHP1l94wBYuXoIopY98HDqSh7b3BmRSSE
	=
X-Received: by 2002:a5d:64ec:0:b0:382:2f62:bd4b with SMTP id ffacd0b85a97d-385c6ebe46bmr5587503f8f.33.1732796597004;
        Thu, 28 Nov 2024 04:23:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMP/aQZgUCh1OFPCYhgqbB1jG+uYDTFTh+ExRZZ/x5iaWy49rlV4uIBqY1sY/MLN3FlCHcPA==
X-Received: by 2002:a5d:64ec:0:b0:382:2f62:bd4b with SMTP id ffacd0b85a97d-385c6ebe46bmr5587478f8f.33.1732796596592;
        Thu, 28 Nov 2024 04:23:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:1600:f3b:67cc:3b88:620e? (p200300cbc71416000f3b67cc3b88620e.dip0.t-ipconnect.de. [2003:cb:c714:1600:f3b:67cc:3b88:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3729esm1532976f8f.44.2024.11.28.04.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 04:23:16 -0800 (PST)
Message-ID: <27bc1008-dce1-4fad-9142-0b74069da4d9@redhat.com>
Date: Thu, 28 Nov 2024 13:23:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
From: David Hildenbrand <david@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, Matthew Wilcox <willy@infradead.org>
References: <674184c9.050a0220.1cc393.0001.GAE@google.com>
 <20241128114249.1903-1-hdanton@sina.com>
 <1176656f-96a8-4e99-a4c2-7354b7cfd03c@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1176656f-96a8-4e99-a4c2-7354b7cfd03c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.11.24 13:02, David Hildenbrand wrote:
> On 28.11.24 12:42, Hillf Danton wrote:
>> On Thu, 28 Nov 2024 11:52:42 +0100 David Hildenbrand <david@redhat.com>
>>> On 23.11.24 08:31, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    9fb2cfa4635a Merge tag 'pull-ufs' of git://git.kernel.org/..
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10042930580000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c4515f1b6a4e50b7
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105ff2e8580000
>>>>
>>>> Downloadable assets:
>>>> disk image: https://storage.googleapis.com/syzbot-assets/7c0c61a15f60/disk-9fb2cfa4.raw.xz
>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/3363d84eeb74/vmlinux-9fb2cfa4.xz
>>>> kernel image: https://storage.googleapis.com/syzbot-assets/2b1a270af550/bzImage-9fb2cfa4.xz
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com
>>>>
>>>
>>> Staring at the console output:
>>>
>>> [  520.222112][ T7269] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x1403 pfn:0x125be
>>
>> ->mapping is cleared for a order9 page
>   > >> [  520.362213][ T7269] head: order:9 mapcount:0 entire_mapcount:0
> nr_pages_mapped:0 pincount:0
>>> [  520.411963][ T7269] memcg:ffff88807c73c000
>>> [  520.492069][ T7269] flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
>>> [  520.499844][ T7269] raw: 00fff00000000000 ffffea0000490001 dead000000000122 dead000000000400
>>> [  520.551982][ T7269] raw: 00000000000014d0 0000000000000000 00000000ffffffff 0000000000000000
>>> [  520.560912][ T7269] head: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
>>> [  520.672020][ T7269] head: 0000000000001245 0000000000000000 00000001ffffffff ffff88807c73c000
>>> [  520.735699][ T7269] head: 00fff00000000209 ffffea0000490001 ffffffffffffffff 0000000000000000
>>> [  520.901989][ T7269] head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
>>> [  520.991952][ T7269] page dumped because: VM_BUG_ON_PAGE(PageTail(page))
>>> [  521.086487][ T7269] page_owner tracks the page as allocated
>>> [  521.132208][ T7269] page last allocated via order 0, migratetype Movable, gfp_mask 0x3d24ca(GFP_TRANSHUGE|__GFP_NORETRY|
>>>
>>> ^order 0 looks wrong, but let;s not get distracted.
>>>
>>> __GFP_THISNODE), pid 7321, tgid 7321 (syz.1.194), ts 520201520231, free_ts 520193076092
>>> [  521.272012][ T7269]  post_alloc_hook+0x2d1/0x350
>>> [  521.276977][ T7269]  __alloc_pages_direct_compact+0x20e/0x590
>>> [  521.314428][ T7269]  __alloc_pages_noprof+0x182b/0x25a0
>>> [  521.319975][ T7269]  alloc_pages_mpol_noprof+0x282/0x610
>>> [  521.420092][ T7269]  folio_alloc_mpol_noprof+0x36/0xd0
>>> [  521.483167][ T7269]  vma_alloc_folio_noprof+0xee/0x1b0
>>> [  521.539677][ T7269]  do_huge_pmd_anonymous_page+0x258/0x2ae0
>>> ...
>>> [  521.851719][ T7269] page last free pid 7323 tgid 7321 stack trace:
>>> [  521.972611][ T7269]  free_unref_folios+0xa87/0x14f0
>>> [  521.977735][ T7269]  folios_put_refs+0x587/0x7b0
>>> [  522.072508][ T7269]  folio_batch_move_lru+0x2c4/0x3b0
>>> [  522.077794][ T7269]  __folio_batch_add_and_move+0x35b/0xc60
>>> [  522.191992][ T7269]  reclaim_folio_list+0x205/0x3a0
>>> [  522.197131][ T7269]  reclaim_pages+0x481/0x650
>>> [  522.201760][ T7269]  madvise_cold_or_pageout_pte_range+0x163b/0x20d0
>>> ...
>>>
>>>
>>> So we allocated a order-9 anonymous folio, but suddenly find it via shmem in the pagecache?
>>>
>>> Is this some crazy use-after-free / double-free, where we end up freeing a shmem folio
>>> that is still in the pagecache? Once freed, it gets merged in the buddy, and we then re-allocate
>>> it as part of a PMD THP; but shmem still finds it in the pagecache, and as the it's now suddenly
>>
>> It is not in the pagecache.
> 
> next_uptodate_folio() finds it there? Which is .. via the pagecache
> xas_next_entry()?
> 
> But good point on the mapping. If we would have freed a folio while
> still in the pagecache (before truncation), we'd likely have gotten an
> error from free_page_is_bad().
> 
> Well, unless check_pages_enabled() is false.

Ah, now I get it; at the point int time we check it actually isn't in 
the pagecache anymore. We perform a folio_test_locked() check before the 
folio_try_get(), which is wrong as the folio can get freed+reallocated 
in the meantime.

The easy fix would be:

diff --git a/mm/filemap.c b/mm/filemap.c
index 7c76a123ba18b..f61cf51c22389 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3501,10 +3501,10 @@ static struct folio *next_uptodate_folio(struct 
xa_state *xas,
                         continue;
                 if (xa_is_value(folio))
                         continue;
-               if (folio_test_locked(folio))
-                       continue;
                 if (!folio_try_get(folio))
                         continue;
+               if (folio_test_locked(folio))
+                       goto skip;
                 /* Has the page moved or been split? */
                 if (unlikely(folio != xas_reload(xas)))
                         goto skip;


-- 
Cheers,

David / dhildenb


