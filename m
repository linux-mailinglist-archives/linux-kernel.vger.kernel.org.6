Return-Path: <linux-kernel+bounces-527878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93EBA410C7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF19E1717AA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309B1607B7;
	Sun, 23 Feb 2025 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA8fP4bQ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944A5D8F0
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740334943; cv=none; b=jOhqk4IKoQbILVrAFDlaxUDMPEbzWjLrjvrPqbu005h9U4anzirKz9HNOEaUcM2Ks15FaeDO3zT/BWsj5wFLAWCPAhJlCsHoLhZZpBzBGjWI/LnRMBmHHEsGeUPo3iIFw6r2FzoU9e0RtP96tJzb1pGN8Gv+7djKeDmhyxZ3MMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740334943; c=relaxed/simple;
	bh=7/LYCeGe9K2+aYsUfMlLC5PRXMCPm+Dst9VX+KWQRiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUfFbBKRP7hqG5gg+5Zfa6XIV0wMvuVcyABUT4oztSw3+6MsTwkOrQkQEbczmk5s4vw1dc/JVaTTS9NRNwcu+MEqJqqTRp7zECIY9iVw3XtPGTvQCDi85+EK78tIN0iYbzrOkH4wUQatQ4dzP6H0H6pswizTRulIEyepnv6DX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA8fP4bQ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so35767251fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740334939; x=1740939739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAMj3CJr0eyOhuiIvatbgsXBCE3tisydD/SwTS+kILw=;
        b=jA8fP4bQRw3uLDCs/Ghh/kDl+k5g35ODxgnjk3bcs2OYD7dmbto5akYSVzenln8WAA
         DEuEvHZRcy4inkRmOshcyvrt4KCnBPgey+GHT0FGyj7tpRLIRRiE1TXjEXe33cRsbpnJ
         MYvBgu27/8s440t9bvR9gtAsU68+eUvvLFOyEtAuhrGrJXmnjPrdTirv3Ic9D/gVqOAa
         c/oIuBjAZw4AxvIqi+Zb2Ar3CMXEQZgrK7orXKtkHDSgqlxqETyA8xKMAvz0r6/u0DrF
         UCcE9xTKH1hzZl3p37Osz0n4QImtot+wZMYXAEIcVb67ddCLm7buW4fFkVEzNxCo03nv
         fmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740334939; x=1740939739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAMj3CJr0eyOhuiIvatbgsXBCE3tisydD/SwTS+kILw=;
        b=T6Z98LQWEOIgrJ61+vSUDSXmr1DmxzzmcQ6sF+IhmskP4DRLyN9xeuAUQHCFwfNWMA
         AMUTTYqQB5ANFXkh961w9DV0YXj5S08euWR63em87H59LhN8JWQRZF2OiJlNxHMW0uSu
         D1HSRfnnjaG60myyulRogMKgse/wxflwYUghyGvP/QECFopabwqk8/M+8RzWftvOJSHn
         ZRyfs5FZ4//XQf3J2mth52T60i1iDAWNTwo2wCyAkQ2MLO+26ohElQJAZpujI6x2hMi0
         TrIXcF1e55TZ4SF/7jxR9cq7otF40dn+w3meLcpMbYMBADQGH1JJoPKE/YqP+Ckl8LTB
         ZJHA==
X-Forwarded-Encrypted: i=1; AJvYcCXUwEVcCf86OsgXY9h7RyGEV/5DVPSZd59oitjjPfebEx7gH198Bfi5EG1hPR86Twydl54L07yUHazXh9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+RN7h3f0KZfvNxJvrR3bI9zso6bkWHm187ET+iYEFqEGqtt7
	Fr7juQ3b3l4IIpZcH7PAHCPfGnwkOSoxx6ZnSeXk0m9XYCI4n10hKEe2pw34IqjWkZIVt6JbLff
	mmm6zpqeeaNUIifQJQ/3s0Hho1RU=
X-Gm-Gg: ASbGncvvCE/lvmv6qHLe24jJRT3leY2ABcnNDFuPGB4Mco7eVEs/Gu+/4QhhunmfQLE
	qNcgrNhcvHA9ADpLEY+7mE+hvowYtSboNzlbglYWkjVB7MKn7teC5xGnVPe2NmlSoYHa0/ORoHb
	YkxsKiDTQ=
X-Google-Smtp-Source: AGHT+IFL91UEj1E4npQkqa08kCZcmPohOg1WSdSwo6GID2lgmHBnReo0wU2ueSqavxTwwjzy/xB4TxuC0PahKqH+YpU=
X-Received: by 2002:a2e:9c8d:0:b0:306:10d6:28ab with SMTP id
 38308e7fff4ca-30a5985e2a2mr32932371fa.5.1740334939366; Sun, 23 Feb 2025
 10:22:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738717785.im3r5g2vxc.none.ref@localhost> <1738717785.im3r5g2vxc.none@localhost>
 <25e2d5e4-8214-40de-99d3-2b657181a9fd@linux.alibaba.com> <5dd39b03-c40e-4f34-bf89-b3e5a12753dc@linux.alibaba.com>
 <CAK1f24ni707gcGpYKXqsb9XHxjx3froLs3DzVqkkNZdca_pw4Q@mail.gmail.com>
 <e7b276eb-960a-4e05-9f84-6152de9ac2ea@linux.alibaba.com> <CAMgjq7CNVrQFBozKfZyvXX9w6HqAEH6eSN+ZQFaerbueyyqArw@mail.gmail.com>
In-Reply-To: <CAMgjq7CNVrQFBozKfZyvXX9w6HqAEH6eSN+ZQFaerbueyyqArw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 24 Feb 2025 02:22:03 +0800
X-Gm-Features: AWEUYZmES3RFfQbRyxkw5Oy4WSTKFulXiOgte4CoFIeasX2d5vPqD2AHskJwtkQ
Message-ID: <CAMgjq7DY_C+-rfFiM7=jdRAdCX7Gv17cRMyDpuc3_36bePURww@mail.gmail.com>
Subject: Re: Hang when swapping huge=within_size tmpfs from zram
To: Baolin Wang <baolin.wang@linux.alibaba.com>, "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc: Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	Daniel Gomez <da.gomez@samsung.com>, Barry Song <baohua@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "ziy@nvidia.com" <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:53=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Fri, Feb 7, 2025 at 3:24=E2=80=AFPM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> > On 2025/2/5 22:39, Lance Yang wrote:
> > > On Wed, Feb 5, 2025 at 2:38=E2=80=AFPM Baolin Wang
> > > <baolin.wang@linux.alibaba.com> wrote:
> > >> On 2025/2/5 09:55, Baolin Wang wrote:
> > >>> Hi Alex,
> > >>>
> > >>> On 2025/2/5 09:23, Alex Xu (Hello71) wrote:
> > >>>> Hi all,
> > >>>>
> > >>>> On 6.14-rc1, I found that creating a lot of files in tmpfs then de=
leting
> > >>>> them reliably hangs when tmpfs is mounted with huge=3Dwithin_size,=
 and it
> > >>>> is swapped out to zram (zstd/zsmalloc/no backing dev). I bisected =
this
> > >>>> to acd7ccb284b "mm: shmem: add large folio support for tmpfs".
> > >>>>
> > >>>> When the issue occurs, rm uses 100% CPU, cannot be killed, and has=
 no
> > >>>> output in /proc/pid/stack or wchan. Eventually, an RCU stall is
> > >>>> detected:
> > >>>
> > >>> Thanks for your report. Let me try to reproduce the issue locally a=
nd
> > >>> see what happens.
> > >>>
> > >>>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > >>>> rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-11): P25160
> > >>>> rcu:     (detected by 10, t=3D2102 jiffies, g=3D532677, q=3D4997 n=
cpus=3D12)
> > >>>> task:rm              state:R  running task     stack:0     pid:251=
60
> > >>>> tgid:25160 ppid:24309  task_flags:0x400000 flags:0x00004004
> > >>>> Call Trace:
> > >>>>    <TASK>
> > >>>>    ? __schedule+0x388/0x1000
> > >>>>    ? kmem_cache_free.part.0+0x23d/0x280
> > >>>>    ? sysvec_apic_timer_interrupt+0xa/0x80
> > >>>>    ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > >>>>    ? xas_load+0x12/0xc0
> > >>>>    ? xas_load+0x8/0xc0
> > >>>>    ? xas_find+0x144/0x190
> > >>>>    ? find_lock_entries+0x75/0x260
> > >>>>    ? shmem_undo_range+0xe6/0x5f0
> > >>>>    ? shmem_evict_inode+0xe4/0x230
> > >>>>    ? mtree_erase+0x7e/0xe0
> > >>>>    ? inode_set_ctime_current+0x2e/0x1f0
> > >>>>    ? evict+0xe9/0x260
> > >>>>    ? _atomic_dec_and_lock+0x31/0x50
> > >>>>    ? do_unlinkat+0x270/0x2b0
> > >>>>    ? __x64_sys_unlinkat+0x30/0x50
> > >>>>    ? do_syscall_64+0x37/0xe0
> > >>>>    ? entry_SYSCALL_64_after_hwframe+0x50/0x58
> > >>>>    </TASK>
> > >>>>
> > >>>> Let me know what information is needed to further troubleshoot thi=
s
> > >>>> issue.
> > >>
> > >> Sorry, I can't reproduce this issue, and my testing process is as fo=
llows:
> > >> 1. Mount tmpfs with huge=3Dwithin_size
> > >> 2. Create and write a tmpfs file
> > >> 3. Swap out the large folios of the tmpfs file to zram
> > >> 4. Execute 'rm' command to remove the tmpfs file
> > >
> > > I=E2=80=99m unable to reproduce the issue as well, and am following s=
teps similar
> > > to Baolin's process:
> > >
> > > 1) Mount tmpfs with the huge=3Dwithin_size option and enable swap (us=
ing
> > > zstd/zsmalloc without a backing device).
> > > 2) Create and write over 10,000 files in the tmpfs.
> > > 3) Swap out the large folios of these tmpfs files to zram.
> > > 4) Use the rm command to delete all the files from the tmpfs.
> > >
> > > Testing with both 2MiB and 64KiB large folio sizes, and with
> > > shmem_enabled=3Dwithin_size, but everything works as expected.
> >
> > Thanks Lance for confirming again.
> >
> > Alex, could you give more hints on how to reproduce this issue?
> >
>
> Hi Baolin,
>
> I can reproduce this issue very easily with the build linux kernel
> test, and the failure rate is very high. I'm not exactly sure this is
> the same bug but very likely, my test step:
>
> 1. Create a 10G ZRAM device and set up SWAP on it.
> 2. Create a 1G memcg, and spawn a shell in it.
> 3. Mount tmpfs with huge=3Dwithin_size, and then untar linux kernel
> source code into it.
> 4. Build with make -j32 (higher or lower job number may also work),
> the build will always fall within 10s due to file corrupted.
>
> After some debugging, the reason is in shmem_swapin_folio, when swap
> cache is hit `folio =3D swap_cache_get_folio(swap, NULL, 0);` sets folio
> to a 0 order folio, then the following shmem_add_to_page_cache will
> insert a order 0 folio overriding a high order entry in shmem's
> xarray, so data are lost. Swap cache hit could be due to many reasons,
> in this case it's the readahead.
>
> One quick fix is just always split the entry upon shmem fault of 0
> order folio like this:
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4ea6109a8043..c8e5c419c675 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2341,6 +2341,10 @@ static int shmem_swapin_folio(struct inode
> *inode, pgoff_t index,
>                 }
>         }
>
> +       /* Swapin of 0 order folio must always ensure the entries are spl=
it */
> +       if (!folio_order(folio))
> +               shmem_split_large_entry(inode, index, swap, gfp);
> +
>  alloced:
>         /* We have to do this with folio locked to prevent races */
>         folio_lock(folio);
>
> And Hi Alex, can you help confirm if the above patch fixes your reported =
bug?
>
> If we are OK with this, this should be merged into 6.14 I think, but
> for the long term, it might be a good idea to just share a similar
> logic of (or just reuse) __filemap_add_folio for shmem?
> __filemap_add_folio will split the entry on insert, and code will be
> much cleaner.

Some extra comments for above patch: If it raced with another split,
or the entry used for swap cache lookup is wrongly aligned due to
large entry, the shmem_add_to_page_cache below will fail with -EEXIST
and try again. So that seems to be working well in my test.

