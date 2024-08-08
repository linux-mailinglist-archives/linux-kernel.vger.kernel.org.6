Return-Path: <linux-kernel+bounces-279630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D0094BFC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07EA1B238FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F1018E760;
	Thu,  8 Aug 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="C6MxJB92"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6318E038
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127908; cv=none; b=ILwAPZBFsfwhawwkGQSFRCY+X1yI0IMZggCQyZvlVNBuJb5L9rZCxQ0m02rY5v58tTHpL9FGGadts2xbBprTLA1n88YCoctcoeUQYRyhRgI4mOtixQlcg8Yy4NBD2Aol+VdUxkLluKH+u7Jti1JH3UrgmOPgYJv7bKql9wSBORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127908; c=relaxed/simple;
	bh=ZHY69bn4zkG3Bec7Y5+D9/RG4Lgy/kYv0Z+VNKx08xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYgE8l2dGfs+u+JszlyMgp359O2J1/n+VYx9CLH+K2ydaNqEY7h0DwsqYEYR4biBquIIrRGOEjBBPVlV7o8LoPTZWTU71UZsXBkkZ+wbyMBEFAbr5mOozurH7jjyYP43uIfy0xUN5x4fBcbaeAChpWL7/DyRipsC1iFQhIxM7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=C6MxJB92; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44feaa08040so5879451cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723127906; x=1723732706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxTnFMiW5NpNKcXksgsMIVAEv1c5dPsaim/ynjFpGro=;
        b=C6MxJB928yg8PMepLBDF59gac5yERJ/DAQqCQp/WRiK5egYw0WWGl5b//uscFsb/vo
         yp/ljm26KdUg2EouUAD04IVoNtRw67QGRuutV+sFJ0a0oH3H1thL1O/FdAFPA1JxYghu
         Qlq0clsUAQUNrRQ/8n7OFCBwNndQFyzEfb/UXVUz43/BVaO6muinmYXr5uw4UdbCane5
         kKdu5BlOwnfyqeblhV0KPyAN4Q2LP8HPsZ6K0TfieVEdNjG5j5Lx7mQXYIuxZVOz6iro
         rxWQRzVTTt2Xw7Y/Z7XkrzEEfC7w4vTaVCwSxS+6VSgjpJP7Zw1ahQGVSujZU6Px0LHj
         dOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723127906; x=1723732706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxTnFMiW5NpNKcXksgsMIVAEv1c5dPsaim/ynjFpGro=;
        b=t7NZK8A4iCVuk6FuYLKMiDP5aKoQ4gA4b4BSmN1gHdFluvD8dXOODgoM6bjxz4dqbt
         NYvGDupOpamGxsBZqnk8FUruuAfLxUMstBhzSzn0Yt/W5eUBxe9lxLUjy6qlmdQBZptP
         +0TrG1A4GYqjKjh19/8Pwho/rZ2/+ugHiPLcKZ2Vg0A/2URXjpTw7WapIGG2r67l3AIR
         f3PL474c84tUcGLJ72U9Ql+uSoSfkQmdMlHjewGV887o/kZI/0qrFN86BTJxl2nfO3Mo
         GctQW1iWkwoAaMFFSg54iesRccPy1WkLtvvsR6I2c/voS85+w5UEoH7xU48IxmU8CRg/
         nXfA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Gum8pMvJEwTW9OP3El4aFdLVzmSfBeYJBngP0IAoRZQktgJRmCdJHMxWRS75eQt/JE6ystBZPlZ/BR67cEG6mvsXu8j2DCzO3V3Q
X-Gm-Message-State: AOJu0Yy+bO90homQjHNh4GpqByIMcUNGH/e/pee3GhsLTe92I/LuF0l4
	26cVHq4Gi1P6JJ116/ewUnAMXAhah6tgqNQOdibKUMz7wXVT7SD5sv31yLFHzuPZpFDwAFh8OL9
	KjCTTQPBGGeb2X2H8MNceI7xMAWcWP0J6TMo0TQ==
X-Google-Smtp-Source: AGHT+IE4Q18JvF0O8xoPrLNZi+cEFK4Ub9f6UlLXgkDGTwk2Tfq6nQktE8hMqrq7CGrtOdjIDNCic8427B7Nu1awNOQ=
X-Received: by 2002:a05:622a:5c0d:b0:446:5568:a6de with SMTP id
 d75a77b69052e-451d42dab81mr19305801cf.48.1723127905793; Thu, 08 Aug 2024
 07:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
 <20240807211929.3433304-4-pasha.tatashin@soleen.com> <E5F2A1F6-DD29-4FD8-B4AA-2CA917F6E89F@linux.dev>
 <CA+CK2bCOYYkGK6yDm4NKto15TjgNGXrDDbhkx1=rGeyQ-ofv9w@mail.gmail.com> <CAJD7tkZK_9+mHupROfWomxXm=br0vvu_aJc2dyEOye2fhgk+eQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZK_9+mHupROfWomxXm=br0vvu_aJc2dyEOye2fhgk+eQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 10:37:48 -0400
Message-ID: <CA+CK2bBkdqDyi_TX84F8G9xEfLdaeshLLHTXA2RbgBAvf3tzWQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: don't account memmap per node
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, cerasuolodomenico@gmail.com, 
	Johannes Weiner <hannes@cmpxchg.org>, Joel Granados <j.granados@samsung.com>, lizhijian@fujitsu.com, 
	Nhat Pham <nphamcs@gmail.com>, David Rientjes <rientjes@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Sourav Panda <souravpanda@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Wed, Aug 7, 2024 at 9:04=E2=80=AFPM Pasha Tatashin <pasha.tatashin@sol=
een.com> wrote:
> >
> > On Wed, Aug 7, 2024 at 10:59=E2=80=AFPM Muchun Song <muchun.song@linux.=
dev> wrote:
> > >
> > >
> > >
> > > > On Aug 8, 2024, at 05:19, Pasha Tatashin <pasha.tatashin@soleen.com=
> wrote:
> > > >
> > > > Currently, when memory is hot-plugged or hot-removed the accounting=
 is
> > > > done based on the assumption that memmap is allocated from the same=
 node
> > > > as the hot-plugged/hot-removed memory, which is not always the case=
.
> > > >
> > > > In addition, there are challenges with keeping the node id of the m=
emory
> > > > that is being remove to the time when memmap accounting is actually
> > > > performed: since this is done after remove_pfn_range_from_zone(), a=
nd
> > > > also after remove_memory_block_devices(). Meaning that we cannot us=
e
> > > > pgdat nor walking though memblocks to get the nid.
> > > >
> > > > Given all of that, account the memmap overhead system wide instead.
> > >
> > > Hi Pasha,
> > >
> > > You've changed it to vm event mechanism. But I found a comment (below=
) say
> > > "CONFIG_VM_EVENT_COUNTERS". I do not know why it has such a rule
> > > sice 2006. Now the rule should be changed, is there any effect to use=
rs of
> > > /proc/vmstat?
> >
> > There should not be any effect on the users of the /proc/vmstat, the
> > values for nr_memap and nr_memmap_boot before and after are still in
> > /proc/vmstat under the same names.
> >
> > >
> > > /*
> > >  * Light weight per cpu counter implementation.
> > >  *
> > >  * Counters should only be incremented and no critical kernel compone=
nt
> > >  * should rely on the counter values.
> > >  *
> > >  * Counters are handled completely inline. On many platforms the code
> > >  * generated will simply be the increment of a global address.
> >
> > Thank you for noticing this. Based on my digging, it looks like this
> > comment means that the increment only produces the most efficient code
> > on some architectures (i.e. i386, ia64):
> >
> > Here is the original commit message from 6/30/06:
> > f8891e5e1f93a1 [PATCH] Lightweight event counters
> >
> >  Relevant information:
> >   The implementation of these counters is through inline code that hope=
fully
> >   results in only a single instruction increment instruction being emit=
ted
> >   (i386, x86_64) or in the increment being hidden though instruction
> >   concurrency (EPIC architectures such as ia64 can get that done).
> >
> > My patch does not change anything in other places where vm_events are
> > used, so it won't introduce performance regression anywhere. Memmap,
> > increment and decrement can happen based on the value of delta. I have
> > tested, and it works correctly. Perhaps we should update the comment.
>
> I think there may be a semantic inconsistency here.
>
> I am not so sure about this code, but for memcg stats, there is a
> semantic distinction between stat (or state) and event.
>
> Per-memcg events (which are a subset of NR_VM_EVENT_ITEMS) are
> basically counting the number of times a certain event happened (e.g.
> PGFAULT). This naturally cannot be decremented because the number of
> page faults that happened cannot decrease.

From what I can tell, for users, there is no difference, at the end
everything is provided through /proc/vmstat, depending on a counter
name they can either only-grow or go up and down. The separation is an
internal only concept.

> Per-memcg state are things that represent the current state of the
> system (e.g. NR_SWAPCACHE). This can naturally go up or down.
>
> It seems like the code here follows the same semantics, and this
> change breaks that. Also, now these stats depend on
> CONFIG_VM_EVENT_COUNTERS .

Yes, nr_memmap_* won't show up without this config with my change.

>
> Looking at NR_VMSTAT_ITEMS, it looks like it's composed of:
> NR_VM_ZONE_STAT_ITEMS,
> NR_VM_NUMA_EVENT_ITEMS,
> NR_VM_NODE_STAT_ITEMS,
> NR_VM_WRITEBACK_STAT_ITEMS,
> NR_VM_EVENT_ITEMS (with CONFIG_VM_EVENT_COUNTERS)
> Semantically, the memmap stats do not fit into any of the above
> categories if we do not want them to be per-node. Maybe they should
> have their own category like NR_VM_WRITEBACK_STAT_ITEMS, or maybe we
> should consolidate both of them into a global stat items category
> (e.g. NR_VM_STAT_ITEMS)?

I like the idea of renaming NR_VM_WRITEBACK_STAT_ITEMS with
NR_GLOBAL_STAT_ITEMS, and add counters there, let me do that.

Pasha

