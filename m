Return-Path: <linux-kernel+bounces-396126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566369BC835
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0FC1C20D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B23D1CCEFD;
	Tue,  5 Nov 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhYXPMVE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D73188587
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796144; cv=none; b=I0/7vIRErxkzndGB/3YxTaX6bbNzHYqVa1y7o8RCi5vlWrQMqE0vmbHof+TDyaCQ4dlGbAFiK9bLsXgtky5/EAl2O0iwom5/QJs82ryHvj5WFZ+ZAUPJp1WJ1J8DARyHTKAM3YSdf2CAZimVCvKU8JSyRfyjiMjgvWKavDTW1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796144; c=relaxed/simple;
	bh=IfWseYwoUnWsAPmDnmtrbQc+oQVqqZ+eQBi//7JRDho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+2sd3rY9O90J8B2rspFL/FPoR8Wurl+c7PjdVulpBZpxnQ+wUp/XcyTEZ79zjRFhu+Bk40oE6SFi4sdbuJgefYYANgX9EsR9ZeG3xcUAXskc06ZogvXGXopMVdRRDlieqBvRzY6snR+FhHnv+637qcvHoR8BDUP6GaqFGMOwk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhYXPMVE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730796141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hl+03ocOz1kfjkiIns+a5q05fu0hnoz/zzn7+DW+E3E=;
	b=dhYXPMVECV+zqwj5VY9AiWEffprOgqjgaoUuoR0x9I+P0d4zUZC87DGKfa6fM2huvN71/7
	nVK7cHRATmrVp1Jr1ESsAAdA34H9jGem1OC/fzSGE/3KEOAnxZET+bYXX8BToskNJTnVn5
	X6j/xR6kBtKb1BYyzI3Cx+Dg1dRWwCA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-GdCNL1z4PbySoRkpjQ88XA-1; Tue, 05 Nov 2024 03:42:19 -0500
X-MC-Unique: GdCNL1z4PbySoRkpjQ88XA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4d51b4efso2307298f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 00:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730796138; x=1731400938;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hl+03ocOz1kfjkiIns+a5q05fu0hnoz/zzn7+DW+E3E=;
        b=AsNpGYaDe3pdpisvcHcR54DCWEnabP+JOPgj67YHvGjrWyZN/p8jfo+xJPiJx1G8Ks
         tgMhm2FibeSCWatV1v4idjJ4Vym4qrlWjA3BWxYO4GvC5FYnKZBi8vySY88NUgBKCKrX
         qig5Uf7sPjQ6OpY2Rmir45CEax9I6MMFoJNTB/MyXDKTeLjZoTltMx5M5oTeWJb0ifNi
         wZeMcJF5mNZ4oOUgGnZWrId04EGCqAZz8pwhVTA8ggex5oiVbkNy3arz4ztJmidwiquK
         +XgE/PWgDwnq3lst4OYtgt+u035Lme7Gu12pDWQ7Nzgmp67sHg/A8wcoEWcj2XN7IqIV
         93Rw==
X-Gm-Message-State: AOJu0YwK90zNRwHJ+pNQ7vsGyonpR63a7+ImoDgXUUfZHxfHt+vxHJ9i
	RJAhCOPvFJ1lZmb3PpUfK6ZXN9yMDxwbammkRwofgXN6IpInaVIz17BsHJHJgboHiMWHZiatjlV
	LtGdQOJXZcRMbLvdcpgoUuxV47wl4hZ1av+1kds69e7Kf+nSXtt5QrLd7ECRcIA==
X-Received: by 2002:a5d:5749:0:b0:37d:808c:afe7 with SMTP id ffacd0b85a97d-3806113712dmr24583393f8f.21.1730796138153;
        Tue, 05 Nov 2024 00:42:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcv3C2eC0Resu0P9+fy7bFPbRxIk+UDUssSAdDMYarUrGWLTdY43fnDp9t2VIUisMsKSSYgw==
X-Received: by 2002:a5d:5749:0:b0:37d:808c:afe7 with SMTP id ffacd0b85a97d-3806113712dmr24583364f8f.21.1730796137754;
        Tue, 05 Nov 2024 00:42:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:db00:b0d7:66ca:e3e9:6528? (p200300cbc73bdb00b0d766cae3e96528.dip0.t-ipconnect.de. [2003:cb:c73b:db00:b0d7:66ca:e3e9:6528])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e89csm15541297f8f.74.2024.11.05.00.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 00:42:16 -0800 (PST)
Message-ID: <f747223e-042f-40f4-841c-1c8019dc8510@redhat.com>
Date: Tue, 5 Nov 2024 09:42:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] mm/gup: avoid an unnecessary allocation call for
 FOLL_LONGTERM cases
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Dave Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>, Hugh Dickins <hughd@google.com>,
 Junxiao Chang <junxiao.chang@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>,
 linux-stable@vger.kernel.org
References: <20241105032944.141488-1-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241105032944.141488-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.24 04:29, John Hubbard wrote:
> This applies to today's mm-hotfixes-unstable (only). In order to test
> this, my earlier patch is a prequisite: commit 255231c75dcd ("mm/gup:
> stop leaking pinned pages in low memory conditions").
> 
> Changes since v1 [1]:
> 
> 1) Completely different implementation: instead of changing the
> allocator from kmalloc() to kvmalloc(), just avoid allocations entirely.
> 
> Note that David's original suggestion [2] included something that I've
> left out for now, mostly because it's a pre-existing question and
> deserves its own patch. But also, I don't understand it yet, either.

Yeah, I was only adding it because I stumbled over it. It might not be a 
problem, because we simply "skip" if we find a folio that was already 
isolated (possibly by us). What might happen is that we unnecessarily 
drain the LRU.

__collapse_huge_page_isolate() scans the compound_pagelist() list, 
before try-locking and isolating. But it also just "fails" instead of 
retrying forever.

Imagine the page tables looking like the following (e.g., COW in a 
MAP_PRIVATE file mapping that supports large folios)

		      ------ F0P2 was replaced by a new (small) folio
		     |
[ F0P0 ] [ F0P1 ] [ F1P0 ] [F0P3 ]

F0P0: Folio 0, page 0

Assume we try pinning that range and end up in 
collect_longterm_unpinnable_folios() with:

F0, F0, F1, F0


Assume F0 and F1 are not long-term pinnable.

i = 0: We isolate F0
i = 1: We see that it is the same F0 and skip
i = 2: We isolate F1
i = 3: We see !folio_test_lru() and do a lru_add_drain_all() to then
        fail folio_isolate_lru()

So the drain in i=3 could be avoided by scanning the list, if we already 
isolated that one. Working better than I originally thought.

-- 
Cheers,

David / dhildenb


