Return-Path: <linux-kernel+bounces-403373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D96D9C34B3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331E11F22102
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B015443C;
	Sun, 10 Nov 2024 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qeridPJl"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2181F153838
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731272933; cv=none; b=BD3/50fnjneE7WaeIWUPzVUEffW3v5dLV6u6Nz8OVMY0t6Mzr3BjRbwEoEkCKy2lzPlBXIB3xEyJXvxLwxTlpa46EX2Hh1K18oxy2epXcRE2yainUA218Id1sScjeu8KZYuh+J8KTQBwiCOwyjgGdQAKxZ+Wtzjml83LMHqXBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731272933; c=relaxed/simple;
	bh=t8RoIVM8yxBt8+znlr3MEbsoYeB+vGg8Q5gl1kAFOsI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BY4o6wfWxZvupLPMifyWbiwywG689t8mk27Q2Oa0Qne7s3uPlYUx684bIXEqp10aqptRhVUT2xZ92yYhQ9F9l2VSRZTCjQp7pI5/hVwRqDd42PYUu3ZhwlAWdd2LkuBxy0ec/0dYmYvYz4Tma79+OKgwIjdD2kryTLmXXT2VsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qeridPJl; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ebbed44918so2594333eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 13:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731272931; x=1731877731; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMht+vxaFjz9axh0ZalC7+1ISXKbvuYgeiAVju4o7E0=;
        b=qeridPJlavrOnaQdT+yaH++9kTfCbx6VCzsYKJia3w/Q8eSAcyNgaAnyVbegTebodd
         pxpzVWXmRdkOoX4El9VSmXWidKIuv6h5e/Y7dWMIVR7eHemSzXI6sVkiSJm2hVkRw3Z7
         fvCvkY+1e/F8mOTtL2RgA9QuwfSFAP0ut3ifsUqh02vgvgEk2BMH2XM6shoYxRXrnWdK
         MeYP+3porY703+c4h0FGbI52E9xO8IKpmG8KnHr4eLj7n4MbpBzokwzHW3c2DgZVaHfk
         LKzEoK63MZqJiy/cL90CBLTtmR1Cs7SU15QJ5/3hZu3+2BFS6FT5M6gy2JR5oaGM+jXQ
         AFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731272931; x=1731877731;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMht+vxaFjz9axh0ZalC7+1ISXKbvuYgeiAVju4o7E0=;
        b=vRI+gO+pcspZXkXzMXMUgaTk0BeAdh4oFSaZz1Mh8C8GLgXIXe1ZcfkGjgDcJkXeXL
         uVT1Vov4M2Du0t8+VfJAULbDVqvhX62KD0HhA75GtVSaonAQ6ljluvxM9MAf2sHVA9n/
         AbITPo2oq5KgLUwfxN76/zP0EqfpYjTbPxqY6qaURtpLAheOC541KmvLuCeiwjqJaiW3
         ZtH3gwEsmsr5dMEOB0AzG0afJdcyXRQ8OzF2iX+T0XrptBwtym88MgRXJvMKIxaKfKdh
         XckS76v4Ltm7814WkxrRr1OadVuoKAbAU7UxpwY5IpApaq+8tAjktfu5ZWVAdOjaYK+t
         NJqw==
X-Forwarded-Encrypted: i=1; AJvYcCV/TWQycvOQlMqn+V7lCigVkwhFqy8r7NZnHr1b9XiHYGrT1OEtXlJ1YWxL6yYXaCwOcRXqyTDSW7+YciU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7MX4Qbl1CnCEkorQHA72Ux0AflQciPpvY5QzDc/teiSrg3rP
	jk08KTxvFvltOWH6wanl03i4qqVjqwnDBbgzBu7p61xjfEilzzfQC+mPsZqaDw==
X-Google-Smtp-Source: AGHT+IGFj8eLtBd7Jy5XaqUUsdZIzcV0pQhujMhDeP/QPwnZPS3lmAbgCtfgoEh5J5pjLxtyPfKjQA==
X-Received: by 2002:a05:6820:2d0b:b0:5ec:c22c:72db with SMTP id 006d021491bc7-5ee57bba7b6mr7528549eaf.2.1731272931003;
        Sun, 10 Nov 2024 13:08:51 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee495275f0sm1668915eaf.25.2024.11.10.13.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 13:08:49 -0800 (PST)
Date: Sun, 10 Nov 2024 13:08:37 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Zi Yan <ziy@nvidia.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>, 
    Wei Yang <richard.weiyang@gmail.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, 
    Chris Li <chrisl@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix v2 1/2] mm/thp: fix deferred split queue not
 partially_mapped
In-Reply-To: <C4ECCA8C-FBF6-41AA-9877-4376EC94E021@nvidia.com>
Message-ID: <6fcaaa72-4ef6-ebda-cf37-b6f49874d966@google.com>
References: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com> <C4ECCA8C-FBF6-41AA-9877-4376EC94E021@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 27 Oct 2024, Zi Yan wrote:
> On 27 Oct 2024, at 15:59, Hugh Dickins wrote:
> 
> > Recent changes are putting more pressure on THP deferred split queues:
> > under load revealing long-standing races, causing list_del corruptions,
> > "Bad page state"s and worse (I keep BUGs in both of those, so usually
> > don't get to see how badly they end up without).  The relevant recent
> > changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
> > improved swap allocation, and underused THP splitting.
> >
> > The new unlocked list_del_init() in deferred_split_scan() is buggy.
> > I gave bad advice, it looks plausible since that's a local on-stack
> > list, but the fact is that it can race with a third party freeing or
> > migrating the preceding folio (properly unqueueing it with refcount 0
> > while holding split_queue_lock), thereby corrupting the list linkage.
> >
> > The obvious answer would be to take split_queue_lock there: but it has
> > a long history of contention, so I'm reluctant to add to that. Instead,
> > make sure that there is always one safe (raised refcount) folio before,
> > by delaying its folio_put().  (And of course I was wrong to suggest
> > updating split_queue_len without the lock: leave that until the splice.)
> >
> > And remove two over-eager partially_mapped checks, restoring those tests
> > to how they were before: if uncharge_folio() or free_tail_page_prepare()
> > finds _deferred_list non-empty, it's in trouble whether or not that folio
> > is partially_mapped (and the flag was already cleared in the latter case).
> >
> > Fixes: dafff3f4c850 ("mm: split underused THPs")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Acked-by: Usama Arif <usamaarif642@gmail.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > ---
> > Based on 6.12-rc4
> > v2: added ack and reviewed-bys
> 
> Acked-by: Zi Yan <ziy@nvidia.com>

Thank you: but I owe you and Andrew and everyone else an apology.

Those 1/2 and 2/2, which have gone in to Linus's tree this morning
(thank you all), have still left a once-a-week list_del corruption on
the deferred split queue: which I've been agonizing over then giving up
on repeatedly for three weeks now (last weekend's seemed to get fixed by
applying a missed microcode update; but then another crash this Friday).

Sorry if the timing makes it look as if I'm trying to game the system
in some way, but it was only yesterday evening that at last I understood
the reason for (I hope the last of) these deferred split queue corruptions;
and the fix turns out to be to this patch.  Perhaps if I'd worked out why
sooner, I'd have just switched to proper spinlocking as you asked; but now
that I do understand, I still prefer to continue this much more tested way.

My ability to reproduce these crashes seems to be one or two orders of
magnitude weaker than it used to be (generally a good thing I suppose: but
frustrating when I want to test), and there's no way I can satisfy myself
that the crashes are completely eliminated in a single week.

But I have been successful in adding temporary debug code, to check that
the preceding "safe" folio on the local list has non-0 refcount: that
check fails much sooner than reaching corruption, and I've run it often
enough now to confirm that the fix does fix that.

Fix patch follows... as you'll see, it's very obvious *in retrospect*.

Hugh

