Return-Path: <linux-kernel+bounces-197701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AEA8D6E3E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E63B23C45
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2B31097B;
	Sat,  1 Jun 2024 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCImkWhn"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668AEDC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717221751; cv=none; b=ns2Yzdb9U5GNPAfhV/QsznxiyPdjk+fg+No0Y8YHyyB7EEBML4W6TbkmKYq00IQt0yK0OfCYw//bfSzQyLC9T5vzHQIfvyRU298sx5JGmCZkBI3+noIfBr80hC4E5VHnmnTylAhtlRKSrXYIbuH1PGMcj7ut2UJGKoCHl9JCtlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717221751; c=relaxed/simple;
	bh=vW8LM7IZhpC6TGdo8NvNXxHRWWq9I8fK/vz2tKTCAmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7dsSv/WqLMcfrLPzk0ojWBHG7K9USr5JQ8G8RhQLTq1pSeyXOvatBA529J7Ip1fEUD7Ejr2GDyAVaZ+rQbrmobzcodOE3jd3RuvqQIWdNOGUH+bSjayO1GlxERA7+S0Lwu169p2+6wvqZlYe1ACkrnAqDzZyBm6O68ms5deYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCImkWhn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42133fbe137so23405e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 23:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717221747; x=1717826547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03Wu35we0AtpCbYTPC6nQVPEe1FBNArJXj6MHkLG5QE=;
        b=jCImkWhn6TCX9d8Cn9g0srsaruaE0Gc3qVj2OyZ04zkpzrX13ww9+RV+5PLpRb0LUu
         H6sw+DNL9dhU29kXs/jT9me90/fcX5LKAcSZtwIp/9TTnrDBOjked4LePPHtUfBjiAfq
         2ItOMRjQxaiWwDnd1/0TnXwrDFbc9/Luj2GXnI/bSMUb7CzD/HjcuAPZRmycd1Jd2Vsn
         dhjkOwCWLvgshe45idnwBkuHskNopZ+jNTkjmXB/Vi4dG6Ck20ZRlGFJzsdmRhaLtCaZ
         xd9b2tIJ8TbUWbc30iIB5iqqCpoXvNhh9OHRKh8N59qBZS62LICcUhuIU4P3zaFsxeon
         M4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717221747; x=1717826547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03Wu35we0AtpCbYTPC6nQVPEe1FBNArJXj6MHkLG5QE=;
        b=iZwH/VeiweZB60LSUG9GXdn5L7X9pP/6wU0sRCDOfyXsu1hGRhNwYsVCYbfu9M/f60
         DnCfHvU0z4cmZpdF44RdnUZ4wmoqKxbr4hB6hgHxXv19Len/ocDrMJTGc9uXjG6daaPM
         4XFBtgBHSKr9Z0etJJAAqB9KNEf9qfxc6F3TlQmn9AaU4iOxU4FcdH/cmlaMKlEQzFgn
         ZDT+i+8CmIC/N1tLx8BVK8z1kUROYePYmEtu3nOnt8mRGqEbIKzIT+mDDp7X70sCYEw6
         ZtkgTpywx//A34dO+xYGSeJPq3iGtEzIYvRZKeeDQL5+TtzKlpUQRsE/tbk1absM1e1W
         U2Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWyIFTnAHMA1BYB3ETy+tMC1/DUETHzdL4KVhZeAFos8rF4DIGzfVdiMU9Ve1utp1xCkjlhxy456s+tfu3fo6QOeIShQ/Poi09/nbIy
X-Gm-Message-State: AOJu0Yye3V0Tog4hUcZEn1eeuz0gIZun9LwadVEE9IYTSqXn6w1CMH19
	gKQ7qqUFA+zR7oyixaOgJnms7+M/HzG3yF/fdk1G/i9A9LmQHryEPryQriJcShehiidmL2XiLRC
	Z6tH5OJddM390UI2nKkhmkCJd92UHBSRYa4pBAxszc6YzvSg1r4d3YWc=
X-Google-Smtp-Source: AGHT+IEVUzMdm8Lm7SZSaitHhHrP131BbDBUR9UqoctY0LV310H6evrUmHxPt9jXfff6VgaBsMCnfOFvtBHzsqfwy5Y=
X-Received: by 2002:a05:600c:3ca6:b0:41b:4c6a:de6d with SMTP id
 5b1f17b1804b1-421358c4114mr613585e9.5.1717221747058; Fri, 31 May 2024
 23:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea> <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
In-Reply-To: <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 1 Jun 2024 00:01:48 -0600
Message-ID: <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 4:06=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, May 15, 2024 at 2:45=E2=80=AFPM Erhard Furtner <erhard_f@mailbox.=
org> wrote:
> >
> > On Wed, 8 May 2024 20:21:11 +0200
> > Erhard Furtner <erhard_f@mailbox.org> wrote:
> >
> > > Greetings!
> > >
> > > Got that on my dual CPU PowerMac G4 DP shortly after boot. This does =
not happen every time at bootup though:
> > >
> > > [...]
> > > kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC), no=
demask=3D(null),cpuset=3D/,mems_allowed=3D0
> > > CPU: 1 PID: 40 Comm: kswapd0 Not tainted 6.8.9-gentoo-PMacG4 #1
> > > Hardware name: PowerMac3,6 7455 0x80010303 PowerMac
> >
> > Very similar page allocation failure on the same machine on kernel 6.9.=
0 too. Seems it can easily be provoked by running a memory stressor, e.g. "=
stress-ng --vm 2 --vm-bytes 1930M --verify -v":
> >
> > [...]
> > kswapd0: page allocation failure: order:0, mode:0xcc0(GFP_KERNEL), node=
mask=3D(null),cpuset=3D/,mems_allowed=3D0
> > CPU: 0 PID: 41 Comm: kswapd0 Not tainted 6.9.0-gentoo-PMacG4 #1
> > Hardware name: PowerMac3,6 7455 0x80010303 PowerMac
> > Call Trace:
> > [c1c65940] [c07926d4] dump_stack_lvl+0x80/0xac (unreliable)
> > [c1c65960] [c01b6234] warn_alloc+0x100/0x178
> > [c1c659c0] [c01b661c] __alloc_pages+0x370/0x8d0
> > [c1c65a80] [c01c4854] __read_swap_cache_async+0xc0/0x1cc
> > [c1c65ad0] [c01cb580] zswap_writeback_entry+0x50/0x154
> > [c1c65be0] [c01cb6f4] shrink_memcg_cb+0x70/0xec
> > [c1c65c10] [c019518c] __list_lru_walk_one+0xa0/0x154
> > [c1c65c70] [c01952a4] list_lru_walk_one+0x64/0x7c
> > [c1c65ca0] [c01cad00] zswap_shrinker_scan+0xac/0xc4
> > [c1c65cd0] [c018052c] do_shrink_slab+0x18c/0x304
> > [c1c65d20] [c0180a40] shrink_slab+0x174/0x260
> > [c1c65da0] [c017cb0c] shrink_one+0xbc/0x134
> > [c1c65dd0] [c017e3e4] shrink_node+0x238/0x84c
> > [c1c65e50] [c017ed38] balance_pgdat+0x340/0x650
> > [c1c65f50] [c017f270] kswapd+0x228/0x25c
> > [c1c65fc0] [c006bbac] kthread+0xe4/0xe8
> > [c1c65ff0] [c0015304] start_kernel_thread+0x10/0x14
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 15, objs: 225, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 15, objs: 225, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 15, objs: 225, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 15, objs: 225, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 15, objs: 225, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: kmalloc-rnd-15-2k, object size: 2048, buffer size: 6144, defau=
lt order: 3, min order: 1
> >   kmalloc-rnd-15-2k debugging increased min order, use slab_debug=3DO t=
o disable.
> >   node 0: slabs: 33, objs: 165, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 15, objs: 225, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: kmalloc-rnd-15-2k, object size: 2048, buffer size: 6144, defau=
lt order: 3, min order: 1
> >   kmalloc-rnd-15-2k debugging increased min order, use slab_debug=3DO t=
o disable.
> >   node 0: slabs: 33, objs: 165, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 15, objs: 225, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: kmalloc-rnd-15-2k, object size: 2048, buffer size: 6144, defau=
lt order: 3, min order: 1
> >   kmalloc-rnd-15-2k debugging increased min order, use slab_debug=3DO t=
o disable.
> >   node 0: slabs: 33, objs: 165, free: 0
> > Mem-Info:
> > active_anon:340071 inactive_anon:139179 isolated_anon:0
> >  active_file:8297 inactive_file:2506 isolated_file:0
> >  unevictable:4 dirty:1 writeback:18
> >  slab_reclaimable:1377 slab_unreclaimable:7426
> >  mapped:6804 shmem:112 pagetables:946
> >  sec_pagetables:0 bounce:0
> >  kernel_misc_reclaimable:0
> >  free:1141 free_pcp:7 free_cma:0
> > Node 0 active_anon:1360284kB inactive_anon:556716kB active_file:33188kB=
 inactive_file:10024kB unevictable:16kB isolated(anon):0kB isolated(file):0=
kB mapped:27216kB dirty:4kB writeback:72kB shmem:448kB writeback_tmp:0kB ke=
rnel_stack:1560kB pagetables:3784kB sec_pagetables:0kB all_unreclaimable? n=
o
> > DMA free:56kB boost:7756kB min:11208kB low:12068kB high:12928kB reserve=
d_highatomic:0KB active_anon:635128kB inactive_anon:58260kB active_file:268=
kB inactive_file:3000kB unevictable:0kB writepending:324kB present:786432kB=
 managed:746644kB mlocked:0kB bounce:0kB free_pcp:28kB local_pcp:28kB free_=
cma:0kB
> > lowmem_reserve[]: 0 0 1280 1280
> > DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB =
0*2048kB 0*4096kB =3D 0kB
> > 63943 total pagecache pages
> > 53024 pages in swap cache
> > Free swap  =3D 8057248kB
> > Total swap =3D 8388604kB
> > 524288 pages RAM
> > 327680 pages HighMem/MovableOnly
> > 9947 pages reserved
> > warn_alloc: 396 callbacks suppressed
> > kswapd0: page allocation failure: order:0, mode:0xcc0(GFP_KERNEL), node=
mask=3D(null),cpuset=3D/,mems_allowed=3D0
> > CPU: 1 PID: 41 Comm: kswapd0 Not tainted 6.9.0-gentoo-PMacG4 #1
> > Hardware name: PowerMac3,6 7455 0x80010303 PowerMac
> > Call Trace:
> > [c1c65940] [c07926d4] dump_stack_lvl+0x80/0xac (unreliable)
> > [c1c65960] [c01b6234] warn_alloc+0x100/0x178
> > [c1c659c0] [c01b661c] __alloc_pages+0x370/0x8d0
> > [c1c65a80] [c01c4854] __read_swap_cache_async+0xc0/0x1cc
> > [c1c65ad0] [c01cb580] zswap_writeback_entry+0x50/0x154
> > [c1c65be0] [c01cb6f4] shrink_memcg_cb+0x70/0xec
> > [c1c65c10] [c019518c] __list_lru_walk_one+0xa0/0x154
> > [c1c65c70] [c01952a4] list_lru_walk_one+0x64/0x7c
> > [c1c65ca0] [c01cad00] zswap_shrinker_scan+0xac/0xc4
> > [c1c65cd0] [c018052c] do_shrink_slab+0x18c/0x304
> > [c1c65d20] [c0180a40] shrink_slab+0x174/0x260
> > [c1c65da0] [c017cb0c] shrink_one+0xbc/0x134
> > [c1c65dd0] [c017e3e4] shrink_node+0x238/0x84c
> > [c1c65e50] [c017ed38] balance_pgdat+0x340/0x650
> > [c1c65f50] [c017f270] kswapd+0x228/0x25c
> > slab_out_of_memory: 53 callbacks suppressed
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: kmalloc-rnd-15-2k, object size: 2048, buffer size: 6144, defau=
lt order: 3, min order: 1
> >   kmalloc-rnd-15-2k debugging increased min order, use slab_debug=3DO t=
o disable.
> >   node 0: slabs: 33, objs: 165, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: kmalloc-rnd-15-2k, object size: 2048, buffer size: 6144, defau=
lt order: 3, min order: 1
> >   kmalloc-rnd-15-2k debugging increased min order, use slab_debug=3DO t=
o disable.
> >   node 0: slabs: 33, objs: 165, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: kmalloc-rnd-15-2k, object size: 2048, buffer size: 6144, defau=
lt order: 3, min order: 1
> >   kmalloc-rnd-15-2k debugging increased min order, use slab_debug=3DO t=
o disable.
> >   node 0: slabs: 33, objs: 165, free: 0
> > [c1c65fc0] [c006bbac] kthread+0xe4/0xe8
> > [c1c65ff0] [c0015304] start_kernel_thread+0x10/0x14
> > Mem-Info:
> > active_anon:351976 inactive_anon:123514 isolated_anon:0
> >  active_file:4648 inactive_file:2081 isolated_file:0
> >  unevictable:4 dirty:1 writeback:39
> >  slab_reclaimable:918 slab_unreclaimable:7222
> >  mapped:5359 shmem:21 pagetables:940
> >  sec_pagetables:0 bounce:0
> >  kernel_misc_reclaimable:0
> >  free:2563 free_pcp:142 free_cma:0
> > Node 0 active_anon:1407904kB inactive_anon:494056kB active_file:18592kB=
 inactive_file:8324kB unevictable:16kB isolated(anon):0kB isolated(file):0k=
B mapped:21436kB dirty:4kB writeback:156kB shmem:84kB writeback_tmp:0kB ker=
nel_stack:1552kB pagetables:3760kB sec_pagetables:0kB all_unreclaimable? no
> > DMA free:0kB boost:7756kB min:11208kB low:12068kB high:12928kB reserved=
_highatomic:0KB active_anon:199336kB inactive_anon:491432kB active_file:461=
2kB inactive_file:5980kB unevictable:0kB writepending:660kB present:786432k=
B managed:746644kB mlocked:0kB bounce:0kB free_pcp:568kB local_pcp:20kB fre=
e_cma:0kB
> > lowmem_reserve[]: 0 0 1280 1280
> > DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB =
0*2048kB 0*4096kB =3D 0kB
> > 45961 total pagecache pages
> > 39207 pages in swap cache
> > Free swap  =3D 8093096kB
> > Total swap =3D 8388604kB
> > 524288 pages RAM
> > 327680 pages HighMem/MovableOnly
> > 9947 pages reserved
> > warn_alloc: 343 callbacks suppressed
> > kswapd0: page allocation failure: order:0, mode:0xcc0(GFP_KERNEL), node=
mask=3D(null),cpuset=3D/,mems_allowed=3D0
> > CPU: 0 PID: 41 Comm: kswapd0 Not tainted 6.9.0-gentoo-PMacG4 #1
> > Hardware name: PowerMac3,6 7455 0x80010303 PowerMac
> > Call Trace:
> > [c1c65940] [c07926d4] dump_stack_lvl+0x80/0xac (unreliable)
> > [c1c65960] [c01b6234] warn_alloc+0x100/0x178
> > [c1c659c0] [c01b661c] __alloc_pages+0x370/0x8d0
> > [c1c65a80] [c01c4854] __read_swap_cache_async+0xc0/0x1cc
> > [c1c65ad0] [c01cb580] zswap_writeback_entry+0x50/0x154
> > [c1c65be0] [c01cb6f4] shrink_memcg_cb+0x70/0xec
> > [c1c65c10] [c019518c] __list_lru_walk_one+0xa0/0x154
> > slab_out_of_memory: 59 callbacks suppressed
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: kmalloc-rnd-15-2k, object size: 2048, buffer size: 6144, defau=
lt order: 3, min order: 1
> >   kmalloc-rnd-15-2k debugging increased min order, use slab_debug=3DO t=
o disable.
> >   node 0: slabs: 33, objs: 165, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: kmalloc-rnd-15-2k, object size: 2048, buffer size: 6144, defau=
lt order: 3, min order: 1
> >   kmalloc-rnd-15-2k debugging increased min order, use slab_debug=3DO t=
o disable.
> >   node 0: slabs: 33, objs: 165, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: skbuff_small_head, object size: 480, buffer size: 544, default=
 order: 1, min order: 0
> >   node 0: slabs: 18, objs: 270, free: 0
> > SLUB: Unable to allocate memory on node -1, gfp=3D0x820(GFP_ATOMIC)
> >   cache: kmalloc-rnd-15-2k, object size: 2048, buffer size: 6144, defau=
lt order: 3, min order: 1
> >   kmalloc-rnd-15-2k debugging increased min order, use slab_debug=3DO t=
o disable.
> >   node 0: slabs: 33, objs: 165, free: 0
> > [c1c65c70] [c01952a4] list_lru_walk_one+0x64/0x7c
> > [c1c65ca0] [c01cad00] zswap_shrinker_scan+0xac/0xc4
> > [c1c65cd0] [c018052c] do_shrink_slab+0x18c/0x304
> > [c1c65d20] [c0180a40] shrink_slab+0x174/0x260
> > [c1c65da0] [c017cb0c] shrink_one+0xbc/0x134
> > [c1c65dd0] [c017e3e4] shrink_node+0x238/0x84c
> > [c1c65e50] [c017ed38] balance_pgdat+0x340/0x650
> > [c1c65f50] [c017f270] kswapd+0x228/0x25c
> > [c1c65fc0] [c006bbac] kthread+0xe4/0xe8
> > [c1c65ff0] [c0015304] start_kernel_thread+0x10/0x14
> > Mem-Info:
> > active_anon:235002 inactive_anon:240975 isolated_anon:0
> >  active_file:4356 inactive_file:2551 isolated_file:0
> >  unevictable:4 dirty:7 writeback:19
> >  slab_reclaimable:1008 slab_unreclaimable:7218
> >  mapped:5601 shmem:21 pagetables:939
> >  sec_pagetables:0 bounce:0
> >  kernel_misc_reclaimable:0
> >  free:1340 free_pcp:23 free_cma:0
> > Node 0 active_anon:940008kB inactive_anon:963900kB active_file:17424kB =
inactive_file:10204kB unevictable:16kB isolated(anon):0kB isolated(file):0k=
B mapped:22404kB dirty:28kB writeback:76kB shmem:84kB writeback_tmp:0kB ker=
nel_stack:1552kB pagetables:3756kB sec_pagetables:0kB all_unreclaimable? no
> > DMA free:0kB boost:7756kB min:11208kB low:12068kB high:12928kB reserved=
_highatomic:0KB active_anon:644060kB inactive_anon:36332kB active_file:5276=
kB inactive_file:5516kB unevictable:0kB writepending:348kB present:786432kB=
 managed:746644kB mlocked:0kB bounce:0kB free_pcp:92kB local_pcp:92kB free_=
cma:0kB
> > lowmem_reserve[]: 0 0 1280 1280
> > DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB =
0*2048kB 0*4096kB =3D 0kB
> > 116345 total pagecache pages
> > 109413 pages in swap cache
> > Free swap  =3D 7819300kB
> > Total swap =3D 8388604kB
> > 524288 pages RAM
> > 327680 pages HighMem/MovableOnly
> > 9947 pages reserved
> >
> >
> > I switched from zstd to lzo as zswap default compressor so zstd does no=
t show up on the dmesg. But the rest looks pretty similar.
> >
> > Full dmesg and kernel .config attached.
> >
> > Regards,
> > Erhard
>
> Hi Erhard,
>
> Thanks for the reports. I'll take a look at them and get back to you
> in a few days.

Hi Erhard,

The OOM kills on both kernel versions seem to be reasonable to me.

Your system has 2GB memory and it uses zswap with zsmalloc (which is
good since it can allocate from the highmem zone) and zstd/lzo (which
doesn't matter much). Somehow -- I couldn't figure out why -- it
splits the 2GB into a 0.25GB DMA zone and a 1.75GB highmem zone:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]

The kernel can't allocate from the highmem zone -- only userspace and
zsmalloc can. OOM kills were due to the low memory conditions in the
DMA zone where the kernel itself failed to allocate from.

Do you know a kernel version that doesn't have OOM kills while running
the same workload? If so, could you send that .config to me? If not,
could you try disabling CONFIG_HIGHMEM? (It might not help but I'm out
of ideas at the moment.)

Thanks!

