Return-Path: <linux-kernel+bounces-424622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2651F9DB716
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC088281CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441E219340D;
	Thu, 28 Nov 2024 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hojaolBG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4082D66
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732795331; cv=none; b=JxnLIvP6aZLtY9yiX5bnipW5iIieQPuAKK/pNDj5fR8XNt78jnSaBgqrghRRKXzOpnmN476/gYksrUdaYUixvzE0wT9j5QM7qWruQ+f0wWYRfnvod9nDrGlCsknBCU4ifYtPk8agC2EgpDMej4YB1HNt69oqkj2TV0OT2FZow9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732795331; c=relaxed/simple;
	bh=AuEcojE7wT+NgHnxJDn2CJXcOeJT8mqw+qNAug9pjSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxIW3nL98v2v1F6iTyvutvTfHOUR3weDty+BmknHOCc/Xz5ApPwCo1yhH/DgJ/dKKOTrwvfACC1fKW+2P9MR1wYq6rZcIbJJfkWA1c2GGkiteub/PJCTy1723r/GO0ErogbjU708+D2SLi3h2stPpEXzRbPHzYPGWMeGFnZkILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hojaolBG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732795328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O6d8MTSPlvgPq8pcFY0rJAePWkTqueu/cHUT5tRtolA=;
	b=hojaolBGd/wxZnzqtUrfDh980b9sfDGkobUvSGehcu0CkO4o4z4H7mJzoVYrrmr+vBX3x8
	Ysw5dlCRGNiE4g0i0eeD8FI3fqzyG3zRYCA6X+BPSgKK5agfdsgasXy0GyUVwVuWsKOR/g
	AuSdhvfxsXOJz0vfx2K4ZzID5aSpPw4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-L6TBs7XpNZWt-hxI_w2Scg-1; Thu, 28 Nov 2024 07:02:06 -0500
X-MC-Unique: L6TBs7XpNZWt-hxI_w2Scg-1
X-Mimecast-MFC-AGG-ID: L6TBs7XpNZWt-hxI_w2Scg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a27c9044so4031645e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732795325; x=1733400125;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O6d8MTSPlvgPq8pcFY0rJAePWkTqueu/cHUT5tRtolA=;
        b=ZQgffh7XQwiEeL1mYwmuoG6Z1KECQ1SnoKhArzmYkZ31jsEUZKfUp3Q2/B2hP861Io
         0k/sUwG/LW5wVyC6JsU5wmnjBLBVJyOoV781QaixsA+NZXbBLjH5M6MZFMZ6X5PpANM+
         OyTcdvxiyz60cGu7MrLMofl/dpKjvYex/le722GiQQaPairegIWSsYTjbq4AjLiYbGYE
         3pQDKqwcDvCf81cdnkDI8C2FQjSiamTlAse7kddzor76g8gJSZr2yG9u7gGBj2UBNJr9
         OLDz8jpI0KmrDfQo3aykeDVybpj+uRJPl4E2cNP/qvCOsG2HkJNAdGDypFy2Eoa6HWYM
         Ksmg==
X-Forwarded-Encrypted: i=1; AJvYcCV+PSAqymkfqlJCQlc01P8ApOs7OaI3lG8QHIdSlg5x3Rc013UQMS5z9yJf2od3wHj0kMLdTnH8VNLc4AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKnjDTJTwsgKkuM7V66Ip0vG2kzegPvUHE+j+IqgwcD4/baolk
	hXTG+AhHvJmrfBgcIaClxEfVUXaVNey9zVLnliWQOtqSTwvYUqonGAhFzwDU65F8BJL/RvqplU7
	4J8nlcb/emytFBW2g9Vrkm0L0WJrRT3KhKSjj26b5mfNVbz8MUsXpIbp44YHzew==
X-Gm-Gg: ASbGncvUkE7UurdJAaorXT2nKeG4HFlhIlAuLOz0zVF3lRWUXVQOmAbOLmWrAz4DRfT
	bd5DVCPfEr+9kpao5PqTs7mhbAi9M9Ytz70XDF991Aape4M0l3XvxTfc+GofiO7dRSuB8AG4H8s
	M75fr8Xo1RtcWCZEjDlTOL9G8oEH2klrbhe/lTA3M0V6SQp+xJCCvTJnilqN7QMfpw0kpBKxsJe
	pBoie3SMR10PhkC6ZIBZJRymziwlayocn8kfCMNGNFIXauTPQfZfLM33VX5CI5eILpqvJ77ZzXs
	UDn72Clm1OZEWDwU13QrBcRuUUC11vB7xagrFpDwU24e4ZGCMcrCTFl6D8lrSu7d3Y29ToH3+EY
	=
X-Received: by 2002:a05:600c:4708:b0:434:a711:ace4 with SMTP id 5b1f17b1804b1-434a9dcffa3mr74015675e9.17.1732795325536;
        Thu, 28 Nov 2024 04:02:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeuCBmiy1SGTkEb63OpOtSLQGg7HoRp9DBLAYqUTO0spji924XQAvsOTgO3ZvPjtipt113XQ==
X-Received: by 2002:a05:600c:4708:b0:434:a711:ace4 with SMTP id 5b1f17b1804b1-434a9dcffa3mr74014975e9.17.1732795325073;
        Thu, 28 Nov 2024 04:02:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:1600:f3b:67cc:3b88:620e? (p200300cbc71416000f3b67cc3b88620e.dip0.t-ipconnect.de. [2003:cb:c714:1600:f3b:67cc:3b88:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70cbfsm20270215e9.36.2024.11.28.04.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 04:02:03 -0800 (PST)
Message-ID: <1176656f-96a8-4e99-a4c2-7354b7cfd03c@redhat.com>
Date: Thu, 28 Nov 2024 13:02:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, Matthew Wilcox <willy@infradead.org>
References: <674184c9.050a0220.1cc393.0001.GAE@google.com>
 <20241128114249.1903-1-hdanton@sina.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241128114249.1903-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.11.24 12:42, Hillf Danton wrote:
> On Thu, 28 Nov 2024 11:52:42 +0100 David Hildenbrand <david@redhat.com>
>> On 23.11.24 08:31, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    9fb2cfa4635a Merge tag 'pull-ufs' of git://git.kernel.org/..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10042930580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c4515f1b6a4e50b7
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105ff2e8580000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/7c0c61a15f60/disk-9fb2cfa4.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/3363d84eeb74/vmlinux-9fb2cfa4.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/2b1a270af550/bzImage-9fb2cfa4.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com
>>>
>>
>> Staring at the console output:
>>
>> [  520.222112][ T7269] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x1403 pfn:0x125be
> 
> ->mapping is cleared for a order9 page
 > >> [  520.362213][ T7269] head: order:9 mapcount:0 entire_mapcount:0 
nr_pages_mapped:0 pincount:0
>> [  520.411963][ T7269] memcg:ffff88807c73c000
>> [  520.492069][ T7269] flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
>> [  520.499844][ T7269] raw: 00fff00000000000 ffffea0000490001 dead000000000122 dead000000000400
>> [  520.551982][ T7269] raw: 00000000000014d0 0000000000000000 00000000ffffffff 0000000000000000
>> [  520.560912][ T7269] head: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
>> [  520.672020][ T7269] head: 0000000000001245 0000000000000000 00000001ffffffff ffff88807c73c000
>> [  520.735699][ T7269] head: 00fff00000000209 ffffea0000490001 ffffffffffffffff 0000000000000000
>> [  520.901989][ T7269] head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
>> [  520.991952][ T7269] page dumped because: VM_BUG_ON_PAGE(PageTail(page))
>> [  521.086487][ T7269] page_owner tracks the page as allocated
>> [  521.132208][ T7269] page last allocated via order 0, migratetype Movable, gfp_mask 0x3d24ca(GFP_TRANSHUGE|__GFP_NORETRY|
>>
>> ^order 0 looks wrong, but let;s not get distracted.
>>
>> __GFP_THISNODE), pid 7321, tgid 7321 (syz.1.194), ts 520201520231, free_ts 520193076092
>> [  521.272012][ T7269]  post_alloc_hook+0x2d1/0x350
>> [  521.276977][ T7269]  __alloc_pages_direct_compact+0x20e/0x590
>> [  521.314428][ T7269]  __alloc_pages_noprof+0x182b/0x25a0
>> [  521.319975][ T7269]  alloc_pages_mpol_noprof+0x282/0x610
>> [  521.420092][ T7269]  folio_alloc_mpol_noprof+0x36/0xd0
>> [  521.483167][ T7269]  vma_alloc_folio_noprof+0xee/0x1b0
>> [  521.539677][ T7269]  do_huge_pmd_anonymous_page+0x258/0x2ae0
>> ...
>> [  521.851719][ T7269] page last free pid 7323 tgid 7321 stack trace:
>> [  521.972611][ T7269]  free_unref_folios+0xa87/0x14f0
>> [  521.977735][ T7269]  folios_put_refs+0x587/0x7b0
>> [  522.072508][ T7269]  folio_batch_move_lru+0x2c4/0x3b0
>> [  522.077794][ T7269]  __folio_batch_add_and_move+0x35b/0xc60
>> [  522.191992][ T7269]  reclaim_folio_list+0x205/0x3a0
>> [  522.197131][ T7269]  reclaim_pages+0x481/0x650
>> [  522.201760][ T7269]  madvise_cold_or_pageout_pte_range+0x163b/0x20d0
>> ...
>>
>>
>> So we allocated a order-9 anonymous folio, but suddenly find it via shmem in the pagecache?
>>
>> Is this some crazy use-after-free / double-free, where we end up freeing a shmem folio
>> that is still in the pagecache? Once freed, it gets merged in the buddy, and we then re-allocate
>> it as part of a PMD THP; but shmem still finds it in the pagecache, and as the it's now suddenly
> 
> It is not in the pagecache.

next_uptodate_folio() finds it there? Which is .. via the pagecache 
xas_next_entry()?

But good point on the mapping. If we would have freed a folio while 
still in the pagecache (before truncation), we'd likely have gotten an 
error from free_page_is_bad().

Well, unless check_pages_enabled() is false.

-- 
Cheers,

David / dhildenb


