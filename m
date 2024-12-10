Return-Path: <linux-kernel+bounces-439995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C99EB740
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C566D2857EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46958230D21;
	Tue, 10 Dec 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkLvWGWG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB571A726B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849955; cv=none; b=pgvp2FnDHVHM//KZqARrwNC4/1IEueEi0ls9M5Rd6JZjpR2GOW3O/ImqhJ0Ro8i9HUGdo6C0ZfPaoZYuQb/YvNxpuo9uKLlOg6ftic4HtPNt1RezE2AolWhRewjAU6cmFcYTdDnsicF3juGSPIBg8mLhlWL2BbyWmQLgU7EXMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849955; c=relaxed/simple;
	bh=nrRlpfC3/yHxfGhCJKTWjp61+uNlOOZFud9jzF01DNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLC3UUCz+J4gfAXtnSCtZ5VMJTqXJEXJZfX4z/LE6yPPEBF5PE7Q4okjNAooF2qP7N+avTJhH64in09FlnF7IaOs4tcr1pjuhJKiP7TYOx8qVNW3Z9eMiMsqlVfDLwotkS9PJdtYREfwobrq7Vdxyfcx12i3nVkYuvz0BP3nGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkLvWGWG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DfGmmsmg4Zofd9nV8hhVHjqAT1fL1o8EMH/cuEB8gyw=;
	b=LkLvWGWG09U8UFqkziL2OFqk350SdaiYx6bCQC1zXl2E/D7vCg/KisqiOF7OZCtEUIyYxO
	/511wuEeI6k9dY38vjKTNTvwYifqU016Q3Kad2sNeo4j6lq/GT7zU1pbp5DMLyf32ckoyo
	M0o0pYo87x4rcWJYtj8L+gQAlMUYWTw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-1zZ3EB3sPUW7221KS0xASA-1; Tue, 10 Dec 2024 11:59:11 -0500
X-MC-Unique: 1zZ3EB3sPUW7221KS0xASA-1
X-Mimecast-MFC-AGG-ID: 1zZ3EB3sPUW7221KS0xASA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434ed7f596aso28193205e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733849950; x=1734454750;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DfGmmsmg4Zofd9nV8hhVHjqAT1fL1o8EMH/cuEB8gyw=;
        b=dORAK6aYtsN9Xj+WlQtRq+qVNybL5IDuFTQZeKmcpWWdXWh8IhuYo9jqYU8B8NkfIs
         OovuD+hk0V58qT5tU92TM9eW7r2Eq24EZwFNhIOdLvfrjMxoOAMulpkvrw8w1Upz3MG7
         D4pHZW6pOYgQvj2VTmhic1bYMCD2nGpevtwDcuPtaCo+WKoCbL1RAxNlT8ZB8x+29cPZ
         2gi2vNQb9XCGZYJ+ZbAeM1f/tSTAjdx+F/DP7AXN0fkOh1exOGNx2HMP5buTX6hiHk3H
         EOGru/wnupHZY5i7saSQOIFEjWJSjY1Oob7xfLjL5mByN5TTjaNF6CpWeA+JXaItl+EI
         se4g==
X-Forwarded-Encrypted: i=1; AJvYcCVFVwqQt9XUljCfMCW7v+I4Ev8f0wId7pkIawT1CPYxmuM/0nVtZsFYPj1lLbVsWGv6ES/OeJyXmzuRG0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKK3Zy4JiXyEghTzDI+XdvLCHrfKaYL6kIY384eZjlfwYl8Ojy
	CFA6WB/fnKlGL9zYMOK0SpbY8YoOxUxnSd8UlHUAuiEW82WO4SkItoaps7umydvMWaXzNPkbcMB
	2UJ6iDETi5+RPjMO3L7BAH8rR0Q2OctHz+U/mVVLiKIoVCEXsKZog0K0ucBD1+g==
X-Gm-Gg: ASbGnct8kWyRMlPNKAlHJXi2cusgBrsv6T7fL7INb1z9JTJWD2Pi5WX0JaP0bRmDgia
	K/xvu2va5VUV/l56KTVE5ccx/kK06nR2Qa5PzsOy0b1+2GqJ/NrFx4OMNEWQv0zr5maxqKZ28Gb
	jVTHmal98GULB+2CDYUpFnemOhxFzixIkTYxFsCF4qCIe/pHfG+B0JzoKte+Jc1byR1ZS8T5B3X
	Y/jsij59bo59NucX/3Bk12f52qLQda8zYeS6xo2bMciixeFnJ0izYNBgHmt6B4cYSruglShWdnD
	H4wzty0rAcL2Z8BLJTEl1uRHarwbAumMsxqNH3XpW54KXmalBDGC63qhidUdgE0X7FGbXbFHYBv
	weHKJGg==
X-Received: by 2002:a05:6000:1fa5:b0:385:f00a:a45b with SMTP id ffacd0b85a97d-386453d7028mr3735257f8f.21.1733849950405;
        Tue, 10 Dec 2024 08:59:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWsyhiIZ0TlmXfLhqKjYOUbUvbjZHpT0Q2ih6mLOiEjLepbh1MBFo76koUjqti4gTYqk9exg==
X-Received: by 2002:a05:6000:1fa5:b0:385:f00a:a45b with SMTP id ffacd0b85a97d-386453d7028mr3735242f8f.21.1733849950033;
        Tue, 10 Dec 2024 08:59:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c723:b800:9a60:4b46:49f9:87f3? (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361b09fec0sm5160895e9.4.2024.12.10.08.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 08:59:09 -0800 (PST)
Message-ID: <50e194c2-914d-43eb-bff8-47c4a1119dce@redhat.com>
Date: Tue, 10 Dec 2024 17:59:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
 <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
 <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
 <81fc4cd1-55f4-4569-aef7-0b0da9684fdf@lucifer.local>
 <af887f35-0831-4c7d-9f1d-bc857b52975b@redhat.com>
 <67ae2a5f-0c86-446f-a122-f14decdb84d3@lucifer.local>
 <a3cacdde-8dab-4dcb-a720-9e00833ee9c1@redhat.com>
 <dfe6b339-a742-4adc-9a53-c653510428d8@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <dfe6b339-a742-4adc-9a53-c653510428d8@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.12.24 10:51, Lorenzo Stoakes wrote:
> David,

Hi Lorenzo,

sorry for the late reply.

> 
> To avoid an infinite back-and-forth...
> 
> I think you're stuck on the idea that we are sat in a VMA 'vacuum', perhaps
> because I put so much effort into separating out the VMA logic, for the
> purpose of being able to userland test it, it's almost given the wrong
> impression (I should perhaps have put less effort into this? :)

Yes, that nicely summarizes it.

In particular, because the patch description says "group all VMA-related 
files", and I am having a hard time to even identify *what* a 
"VMA-related" file is, really.

For example, why not mempolicy.c->mbind()? Not that I would suggest 
that, because the file is filled with non-vma-related stuff.

See below of what might make sense to me.

> 
> But we have for quite some time now de facto been expected to maintain all
> aspects of mapping, remapping, etc. INCLUDING page table considerations.
 > > We are more or less de facto maintaining all that (modulo madvise.c - I
> grant you this is the odd one out).
> 
> So you can imagine it's a bit frustrating, when that's the case, to be told
> in effect - no this isn't for you - right?

It isn't "VMA" group for me, independent of "who" is currently listed 
there. And maybe we now agree on that, maybe not.

Talking about things that are frustrating: being called a "senior member 
of the kernel". :)

 > > For instance, as I said before, we have spent large parts of the 
6.12 cycle
> dealing with practical concerns specifically around page table
> manipulation.
 > > Maintainership is more than setting up lei rules, obviously. One 
can set
> lei rules for anything. It means that our say has more impact, and it also
> means that we are (co-)responsible for the listed files, and that's acked
> rather than disregarded.
 > > So, again, I politely disagree with your assessment re: page tables.
 > > I think their manipulation under circumstances where you
> map/remap/mprotect/mlock is -inseparable- from memory mapping/VMA
> logic. Otherwise, what's the point right?

We'll likely have to agree to disagree. :) But again, my main point is 
that the VMA group is misleading.

As a side note, I believe the code can be structures accordingly (call 
that separating it). mmap/munmap handling is the prime example right now 
for me.

For example, I really enjoy how:

munmap() (mmap.c) routes to __vm_munmap (vma.c) makes use of abstracted 
page table logic like free_pgtables() and unmap_vmas() (memory.c).

This way it is clear what the rather high-level MM syscall 
implementation is (mmap.c), what the VMA handling is (vma.c) and what 
the abstracted page table handling logic is (memory.c). I don't think 
that page table handling code should be moved to either mmap.c or vma.c.


I would enjoy if we would handle e.g., mprotect.c in a similar way, such 
that the helper like change_protection() -- again, used by completely 
mprotect()-unrelated code outside of mprotect.c -- would not reside in 
mprotect.c. But that code just evolved naturally after we kept reusing 
change_protection() outside of the file.

Regarding mremap logic there once was a discussion about merging it with 
the uffdio_move logic, but not sure if that really makes sense.

> 
> My suggestion is that:
> 
> a. we put everything in MEMORY MAPPING
> b. We drop mm/madvise.c from the list

Sounds better, although I am still fuzzy on what is supposed to be in 
there and what not. See my mbind() example above ..

I see how mmap/munmap/mprotect/mremap fall into the same category of MM 
syscalls that mainly affect the /proc/self/maps output (in contrast to a 
bunch of others). Which make sense to me to group in such a way.

mseal.c and mlock.c likely as well.

msync.c is a simple VMA walker ... not sure if it belongs in there, but 
who am I to tell.

-- 
Cheers,

David / dhildenb


