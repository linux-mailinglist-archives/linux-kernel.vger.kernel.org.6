Return-Path: <linux-kernel+bounces-367890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDB49A0805
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544662840F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B737D207212;
	Wed, 16 Oct 2024 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8N+67fh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B72071F7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076761; cv=none; b=Q7i1icXApIcq/QNmkD96DZueXvCQD+eW1AYHzGZPQyHAGU8qbTbZ4ghcpiLxbBMrEtLdpFt7+vJZ9khuS3+rzKZ50NnnF5e5x8GqswU/jNgyCPm1W5hZXboHoGLOJY9DHA8yaaMvJJZXOcr5NWNfRpX3pKpt56k6pE/OR1+fAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076761; c=relaxed/simple;
	bh=eReoyzzSz6DB+Oauwr2FIz7PBvFbImy4hKwqPu7RsgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/WznWjwNxUGWZi83vmEstcaJ05oGopJUBk6u6R0m59G2uaICSwibllxP49UeI50mDJFU5svMka7vKUZ8FbxX2u5AMYYn9b2UtbW9R7vB+rl4NuhspUeKSeUfbRazUBVKEgwYDPIuSrVDTixEOom/ZdCbFmkl2DG/ZXyPCfj+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8N+67fh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729076759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i5SVeglfZP1L5TlSxUT5a2GinBaKrfovrWWQq+I/2HU=;
	b=C8N+67fhACKLV3niVtoJ4/BhcSSMxaUzT49SPjI0JxZB53QVCemMmCCwJJcQhSX53yzqn9
	DpCWYaSv0KhLaGTwz6Y1RFUnl1m05JWZl17xweGeMYWMJ65lnhn8BASgQnSkzZBCd+fkeN
	Utd/VcOJCykqZSwCPtqciZClwOxc0VI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-6cg33wzHPH-fmyK-fr_2Zw-1; Wed, 16 Oct 2024 07:05:57 -0400
X-MC-Unique: 6cg33wzHPH-fmyK-fr_2Zw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43154a0886bso1681325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729076756; x=1729681556;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i5SVeglfZP1L5TlSxUT5a2GinBaKrfovrWWQq+I/2HU=;
        b=PVLvZi+po5CffxYEjWnFv6QIvAdoyhWT61MvsZOO9lQfo/GwutzEhw0vJowngSIDFy
         i1kkpjJxAys+lyYB+UwruVu93b7aMgT88JNNyRdHO7EYu6a8vDCc/FrcRvDqGKf1jZFX
         vxFRuZqnNcCLTWzqfIYyg9iH9S/yKAiB5VKO5nBjXq8xhcdbBNmpLscWVrz2L/9eXa5J
         ARH6uicpu0hs/AuJN9vhI8pqBCwrgFU/zE40uc+5/c4FbpfOXm5ruNF6Zraf63uxRUlm
         50UTHDtWlaOT+Wk64GihqkZqXsEDtQ13suhwfg/u8SdrCtpoMeKcK6PPfMOlhHhfjc90
         kyMA==
X-Gm-Message-State: AOJu0YzPRqwC7hqaP5/7ulPrOepVFbBaT3q4n3TxQB12Q4+z3r2fr0Vx
	K5Mrd3it93BKGitUdnsgWNw2ra59dyc/XuSOo2x5QfLx09/sIF0hGmV5g+V0D+KeePyPfZFegoj
	55a9C+XFZhn8FzhzDwUwfD9tG6qFzt83mi4yNzahRLicNRs12JNaKA8i/9PO8xA==
X-Received: by 2002:a05:600c:19cc:b0:42f:8229:a0a1 with SMTP id 5b1f17b1804b1-43125619ec2mr122581235e9.33.1729076756572;
        Wed, 16 Oct 2024 04:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAA8+q0kFhJYZYEcQ2r32tamWZ+lKAi2/ejP4wtEVI193f7liM5IArCWqvrKnr3o62foPIcA==
X-Received: by 2002:a05:600c:19cc:b0:42f:8229:a0a1 with SMTP id 5b1f17b1804b1-43125619ec2mr122581015e9.33.1729076756136;
        Wed, 16 Oct 2024 04:05:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3? (p200300cbc74bd00003a9de5c9ae6ccb3.dip0.t-ipconnect.de. [2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56ea10sm47224315e9.24.2024.10.16.04.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 04:05:55 -0700 (PDT)
Message-ID: <0436c217-0afc-45e6-949b-2291ee1ebc6e@redhat.com>
Date: Wed, 16 Oct 2024 13:05:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/pagewalk: fix usage of pmd_leaf()/pud_leaf()
 without present check
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>
References: <20241015111236.1290921-1-david@redhat.com>
 <4898fdf4-7c88-4697-9df4-64fd8a900e95@redhat.com>
 <c364015e-ab37-411d-b2e9-4e7b10effdf5@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c364015e-ab37-411d-b2e9-4e7b10effdf5@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.10.24 12:58, Qi Zheng wrote:
> 
> 
> On 2024/10/15 21:13, David Hildenbrand wrote:
>> On 15.10.24 13:12, David Hildenbrand wrote:
>>> pmd_leaf()/pud_leaf() only implies a pmd_present()/pud_present() check on
>>> some architectures. We really should check for
>>> pmd_present()/pud_present() first.
>>>
>>> This should explain the report we got on ppc64 (which has
>>> CONFIG_PGTABLE_HAS_HUGE_LEAVES set in the config) that triggered:
>>>      VM_WARN_ON_ONCE(pmd_leaf(pmdp_get_lockless(pmdp)));
>>>
>>> Likely we had a PMD migration entry for which pmd_leaf() did not
>>> trigger. We raced with restoring the PMD migration entry, and suddenly
>>> saw a pmd_leaf(). In this case, pte_offset_map_lock() saved us from more
>>> trouble, because it rechecks the PMD value, but we would not have
>>> processed
>>> the migration entry -- which is not too bad because the only user of
>>> FW_MIGRATION is KSM for unsharing, and KSM only applies to small folios.
>>>
>>> Further, we shouldn't re-read the PMD/PUD value for our warning, the
>>> primary purpose of the VM_WARN_ON_ONCE() is to find spurious use of
>>> pmd_leaf()/pud_leaf() without CONFIG_PGTABLE_HAS_HUGE_LEAVES.
>>>
>>> As a side note, we are currently not implementing FW_MIGRATION support
>>> for PUD migration entries, which likely should exist due to hugetlb. Add
>>> a TODO so this won't fall through the cracks if more FW_MIGRATION users
>>> get added.
>>>
>>> Fixes: aa39ca6940f1 ("mm/pagewalk: introduce folio_walk_start() +
>>> folio_walk_end()")
>>> Reported-by: syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com
>>> Closes:
>>> https://lkml.kernel.org/r/670d3248.050a0220.3e960.0064.GAE@google.com
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Jann Horn <jannh@google.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>
>> Was able to write a quick reproducer and verify that the issue no longer
>> triggers with this fix.
>>
>> https://gitlab.com/davidhildenbrand/scratchspace/-/blob/main/reproducers/move-pages-pmd-leaf.c
>>
>> Without this fix after a couple of seconds in a VM with 2 NUMA nodes:
>>
>> [   54.333753] ------------[ cut here ]------------
>> [   54.334901] WARNING: CPU: 20 PID: 1704 at mm/pagewalk.c:815
>> folio_walk_start+0x48f/0x6e0
>> [   54.336455] Modules linked in: ...
>> [   54.345009] CPU: 20 UID: 0 PID: 1704 Comm: move-pages-pmd- Not
>> tainted 6.12.0-rc2+ #81
>> [   54.346529] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>> 1.16.3-2.fc40 04/01/2014
>> [   54.348191] RIP: 0010:folio_walk_start+0x48f/0x6e0
>> [   54.349134] Code: b5 ad 48 8d 35 00 00 00 00 e8 6d 59 d7 ff e8 08 74
>> da ff e9 9c fe ff ff 4c 8b 7c 24 08 4c 89 ff e8 26 2b be 00 e9 8a fe ff
>> ff <0f> 0b e9 ec fe ff ff f7 c2 ff 0f 00 00 0f 85 81 fe ff ff 48 8b 02
>> [   54.352660] RSP: 0018:ffffb7e4c430bc78 EFLAGS: 00010282
>> [   54.353679] RAX: 80000002a3e008e7 RBX: ffff9946039aa580 RCX:
>> ffff994380000000
>> [   54.355056] RDX: ffff994606aec000 RSI: 00007f004b000000 RDI:
>> 0000000000000000
>> [   54.356440] RBP: 00007f004b000000 R08: 0000000000000591 R09:
>> 0000000000000001
>> [   54.357820] R10: 0000000000000200 R11: 0000000000000001 R12:
>> ffffb7e4c430bd10
>> [   54.359198] R13: ffff994606aec2c0 R14: 0000000000000002 R15:
>> ffff994604a89b00
>> [   54.360564] FS:  00007f004ae006c0(0000) GS:ffff9947f7400000(0000)
>> knlGS:0000000000000000
>> [   54.362111] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   54.363242] CR2: 00007f004adffe58 CR3: 0000000281e12005 CR4:
>> 0000000000770ef0
>> [   54.364615] PKRU: 55555554
>> [   54.365153] Call Trace:
>> [   54.365646]  <TASK>
>> [   54.366073]  ? __warn.cold+0xb7/0x14d
>> [   54.366796]  ? folio_walk_start+0x48f/0x6e0
>> [   54.367628]  ? report_bug+0xff/0x140
>> [   54.368324]  ? handle_bug+0x58/0x90
>> [   54.369019]  ? exc_invalid_op+0x17/0x70
>> [   54.369771]  ? asm_exc_invalid_op+0x1a/0x20
>> [   54.370606]  ? folio_walk_start+0x48f/0x6e0
>> [   54.371415]  ? folio_walk_start+0x9e/0x6e0
>> [   54.372227]  do_pages_move+0x1c5/0x680
>> [   54.372972]  kernel_move_pages+0x1a1/0x2b0
>> [   54.373804]  __x64_sys_move_pages+0x25/0x30
> 
> It would be better to add this call stack to the commit message, which
> can help people find this fix patch when they encounter same problem. ;)

The commit is not part of a released kernel, though, and a lore search 
would return the result until it's included.

Before it's included, the commit message won't really be helpful :)

But sure, @Andrew, can we include that in the commit?

> 
> Otherwise, LGTM.
> 
> Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 

Thanks!

-- 
Cheers,

David / dhildenb


