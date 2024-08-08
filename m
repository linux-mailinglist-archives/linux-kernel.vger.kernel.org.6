Return-Path: <linux-kernel+bounces-278899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8294B64C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9741C2194C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209661822DA;
	Thu,  8 Aug 2024 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQntNZ5Y"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD8181B88
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095400; cv=none; b=ZtnJKEAEc4R9thmrFCjJm6a+JXM9enej9uvdY35+yXw1lsYtNWXwFsec+IAoPxbHiOOeyEaWUm872wZivD6COdw7oMJxn7kyYzD4DD84uQ0tydm5lENbBOqEhVKrIwKDuHrGZIwyayZASDBudIz/GlJmh5Zfzao+9dOHVF4a8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095400; c=relaxed/simple;
	bh=4YK/r6DRSUZqHJN1/1rCT/zNhMb+E7NERu7a7jBl5mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnJtuWRock08Wn+JR420y9ZkTzMqZTBcHJMB3OrKHnxBUX9PEY0M9/an5vgjiqnZWXw5EfbQnbnhbWAqp+fW05WvhWRT9Oa0MZjxyhZ3A6+HoAyyYmXCs2WudaaQS9irl2Dyw8bu61TTBcYvwPhkNZv0LxatqDmAdkyf51SrO2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQntNZ5Y; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so524859a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 22:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723095397; x=1723700197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2bYV8yuUe3ADBH7qqTaNKMMTmxTnCLFADBvEorq2rg=;
        b=GQntNZ5YLjNpKqOO0ALum/CcPQV3xYItZWFfmi85aHdnTVrtxfaLG7IYGRMKDTZ+ps
         m59EjuvMcN+ogp3bEK1f2Bm11XEX9CQl9R9aOT+qDisuE/3qmTOKBayLtv856EXQBle/
         Zwc+52+uLdurtDRATfeIfABCcAFjOw7vEEZjCKt24ff6cYK6Ao0t5LC2L/+K1zMSmKAk
         9mHV9mJKCFHyR5vwAO+fvmnfi6Lr3YP8M8I1zmYcUIXcqJwTFzOQeJ3lB4ZycGMIh/mJ
         gFNktOO4c6DuODjdufcEOpmfDAgk/V7b0y6yyOkTOcFSGvefIWk2JInrRZPqVO1nfkKm
         sQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723095397; x=1723700197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2bYV8yuUe3ADBH7qqTaNKMMTmxTnCLFADBvEorq2rg=;
        b=KgXcQc0QGPQKlOvd3y+m9aUN8TjBQbNjQjiEtMpPhB5GXU+g0q1iPHqJ+jTCFxx/gt
         mkdxynrqjcCJg0iPYjSfRelvDSjE2hrivRxzWSvTVBDXJVUAT9ao/P8Tx5BN2tXkRX75
         rTCVRrib4q27knAgzqCT5exbldxcI+zRyGMkltSpNzdY/Enrjl/URpYT51K1EKqtEdrg
         S6zffXL4JNdwXo8sXQO09zWzmzA6A5xo/8EthZR3szpmbJoCt0rDCoB0xBGAjyS4Jswx
         cordvaK/tqFfRXCTIFLaIqK63PmA0RTK82ZNbGnXygCXDxN1eT+4c0NAUvz7Is7/e/wM
         qtvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHojCpTaS/JRY9m/SOO2XMIszwGWcB/OzPz6I3ItbhRRrg+OsBC7B60y4urPnJamW5voUuniPmRwIItZO6TIyWQLr3kE5xoBHWSn6y
X-Gm-Message-State: AOJu0YyBi5ZU6sLxYhVqbLLvRIjhXpYEGrqX/gSNLapQmrZ1v8F/gkVN
	nIgWufCCvwg1ug6v38oEdrTvP/iIvR2HqcafF1BpKtcQDkJruZ+/IjITHpwf4V0pRjjldNPWHyl
	jf68wxq+mpK6stQ/2PtrDjMYbZgAMvGxRoDhi
X-Google-Smtp-Source: AGHT+IF5udCs3TsHHqF5Sev1ErsNKEVv5sjR1M+FSt5Pr4THpCz1+i6NjCR/IEqeWonkW0rpnd/Bt/rkfXDjkzoC+1Y=
X-Received: by 2002:a17:907:efd1:b0:a7a:8bcf:ac64 with SMTP id
 a640c23a62f3a-a8090db1e2amr54882466b.36.1723095396219; Wed, 07 Aug 2024
 22:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
 <20240807211929.3433304-4-pasha.tatashin@soleen.com> <E5F2A1F6-DD29-4FD8-B4AA-2CA917F6E89F@linux.dev>
 <CA+CK2bCOYYkGK6yDm4NKto15TjgNGXrDDbhkx1=rGeyQ-ofv9w@mail.gmail.com>
In-Reply-To: <CA+CK2bCOYYkGK6yDm4NKto15TjgNGXrDDbhkx1=rGeyQ-ofv9w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 7 Aug 2024 22:35:59 -0700
Message-ID: <CAJD7tkZK_9+mHupROfWomxXm=br0vvu_aJc2dyEOye2fhgk+eQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: don't account memmap per node
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, cerasuolodomenico@gmail.com, 
	Johannes Weiner <hannes@cmpxchg.org>, Joel Granados <j.granados@samsung.com>, lizhijian@fujitsu.com, 
	Nhat Pham <nphamcs@gmail.com>, David Rientjes <rientjes@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Sourav Panda <souravpanda@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:04=E2=80=AFPM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> On Wed, Aug 7, 2024 at 10:59=E2=80=AFPM Muchun Song <muchun.song@linux.de=
v> wrote:
> >
> >
> >
> > > On Aug 8, 2024, at 05:19, Pasha Tatashin <pasha.tatashin@soleen.com> =
wrote:
> > >
> > > Currently, when memory is hot-plugged or hot-removed the accounting i=
s
> > > done based on the assumption that memmap is allocated from the same n=
ode
> > > as the hot-plugged/hot-removed memory, which is not always the case.
> > >
> > > In addition, there are challenges with keeping the node id of the mem=
ory
> > > that is being remove to the time when memmap accounting is actually
> > > performed: since this is done after remove_pfn_range_from_zone(), and
> > > also after remove_memory_block_devices(). Meaning that we cannot use
> > > pgdat nor walking though memblocks to get the nid.
> > >
> > > Given all of that, account the memmap overhead system wide instead.
> >
> > Hi Pasha,
> >
> > You've changed it to vm event mechanism. But I found a comment (below) =
say
> > "CONFIG_VM_EVENT_COUNTERS". I do not know why it has such a rule
> > sice 2006. Now the rule should be changed, is there any effect to users=
 of
> > /proc/vmstat?
>
> There should not be any effect on the users of the /proc/vmstat, the
> values for nr_memap and nr_memmap_boot before and after are still in
> /proc/vmstat under the same names.
>
> >
> > /*
> >  * Light weight per cpu counter implementation.
> >  *
> >  * Counters should only be incremented and no critical kernel component
> >  * should rely on the counter values.
> >  *
> >  * Counters are handled completely inline. On many platforms the code
> >  * generated will simply be the increment of a global address.
>
> Thank you for noticing this. Based on my digging, it looks like this
> comment means that the increment only produces the most efficient code
> on some architectures (i.e. i386, ia64):
>
> Here is the original commit message from 6/30/06:
> f8891e5e1f93a1 [PATCH] Lightweight event counters
>
>  Relevant information:
>   The implementation of these counters is through inline code that hopefu=
lly
>   results in only a single instruction increment instruction being emitte=
d
>   (i386, x86_64) or in the increment being hidden though instruction
>   concurrency (EPIC architectures such as ia64 can get that done).
>
> My patch does not change anything in other places where vm_events are
> used, so it won't introduce performance regression anywhere. Memmap,
> increment and decrement can happen based on the value of delta. I have
> tested, and it works correctly. Perhaps we should update the comment.

I think there may be a semantic inconsistency here.

I am not so sure about this code, but for memcg stats, there is a
semantic distinction between stat (or state) and event.

Per-memcg events (which are a subset of NR_VM_EVENT_ITEMS) are
basically counting the number of times a certain event happened (e.g.
PGFAULT). This naturally cannot be decremented because the number of
page faults that happened cannot decrease.

Per-memcg state are things that represent the current state of the
system (e.g. NR_SWAPCACHE). This can naturally go up or down.

It seems like the code here follows the same semantics, and this
change breaks that. Also, now these stats depend on
CONFIG_VM_EVENT_COUNTERS .

Looking at NR_VMSTAT_ITEMS, it looks like it's composed of:
NR_VM_ZONE_STAT_ITEMS,
NR_VM_NUMA_EVENT_ITEMS,
NR_VM_NODE_STAT_ITEMS,
NR_VM_WRITEBACK_STAT_ITEMS,
NR_VM_EVENT_ITEMS (with CONFIG_VM_EVENT_COUNTERS)

Semantically, the memmap stats do not fit into any of the above
categories if we do not want them to be per-node. Maybe they should
have their own category like NR_VM_WRITEBACK_STAT_ITEMS, or maybe we
should consolidate both of them into a global stat items category
(e.g. NR_VM_STAT_ITEMS)?

