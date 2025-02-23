Return-Path: <linux-kernel+bounces-527864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F8A41095
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694F917480B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B1D2F50;
	Sun, 23 Feb 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN86qMYM"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403042770B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740333208; cv=none; b=Ld3dUUWQUZ6OwnBaTaG/b+PPCFI9pRheQBsUc7RBLz5hW3iM3k4tmlsF3fd28ZlajaWw4UYfCPGi2uBP8E5eo9S02v6b4y7aLl9Ti2qdkprzHzkQOsykZNI3pwrUEB6W+nFJHvVzqa40Jo6fJAnbOCILoBjdNlGErd373OtAG9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740333208; c=relaxed/simple;
	bh=HBJEMCaKI0H/esE4FLgB93h8z5b8F4J8jS+u9rIdLU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WE8nuer48Veb70Uk4QINSPnCYwGopWv/IZjBRBvHXhl+VtNYWiHFX10HWudaoa8JpcacBnPMiSX/HTccFGP0pDqKHYLwEW4zp+R1szcFm21PCronysRqBaT9wrDy9zCEPTtJxw8ZsdaVt8NRDa2qzJFJEXwoMqVbN60JeaeHZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YN86qMYM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30737db1ab1so28513621fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 09:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740333204; x=1740938004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBbVLznRp3wr0ziewh2y83BSDd6c32bl40jV+ZXyexQ=;
        b=YN86qMYMEXthyzYkaQfNdZ925HdEGApHXX65FEUtXPs7kuvNM78X5iqFuWkv/S06hu
         xZh3ZSk4A1r3Uqg+pgpxYjjvJlhR7w2gjbtES782xsZJ/gUwlobD1LYkwDpsYUdk9OFw
         pDWAsQ2tg+aoTwgMAYX9gjaFZn9RuiQr+Y32qxiDZ/aCPlSgQ+COzuxTwjELPC/Idzwr
         zruYf6EKY6VKxqPJVc2+4lmPt+k9KsGgWbBl4GHekEFUVD/0ss3kbqxp1ULi+VyIfLzX
         TBo735xXG27iOJv9QoXp/BxHCjqWheRs8omDtxeFB+nnwJIm3lLpn/OEVCMt1n3RbVFl
         +RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740333204; x=1740938004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBbVLznRp3wr0ziewh2y83BSDd6c32bl40jV+ZXyexQ=;
        b=BFTxBpkRetpX0nencqkpHkUuj7QEROnxLHyoG6zBnZx0zTGvL1GQfolEoN5ce52b0N
         kBKGeXlkBVKxgH/ZxaLuqUVASJ+XIqm2WMGBlMd6+j9j31uMqxNHD3x0pmFiwo9UI0ql
         1mybcWKV6UT1+Twk/izMxGtdlGlZNEDwGNklH9LQC5jo4R6IwPP2TP3BlxiIq0K8BImU
         wPN7CRJDmPKyabdLiCjjZoTlz/Z0SJoKIm7pR01ijS5qLpHFLHXzUjcHSJ0R7FAC5uK0
         rc+BTvHIa57uIppQqti+J9duAvdhD30XTRjffdACNK/OHqwnmYlqmFa9t9nEkxNp7zCx
         3UFg==
X-Forwarded-Encrypted: i=1; AJvYcCXljCvmNOBHGfZ0TGd6WdaYv7LulpTBaZvYIoeJdEqOWKcTRatrzBsNtiUH5m01lEGyIcIBhVMqsfJmY9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcTf46XtOMO4nYFKy5C1x5tTGtINe/X2OzjWOmK+xfvifAXTY
	m/Mykk7bhftlgSEB04UeH++e8quNc8wOA/zdOMFxOtV0lo1B2niCXVP4x8mfpIG/a1Xt/Xcs+XQ
	3vmX2WDzEgNBT8Om+/pPs6ywb9fqVnfgdZMM=
X-Gm-Gg: ASbGncsu2IT1zD5lIPxZHloVxWOgwf32yIb5hDzN17QwPDOh49Dy4oVTMdPlJG/D49I
	AnvuSSt5aPJyhyKhwpKUtg1Gh07J0sTnT7aXD1Aq5mvrVLuX0//7XQMQUuAzavcxTtwqyx0ACBC
	CVO6Tc6Bk=
X-Google-Smtp-Source: AGHT+IEH5vgzsoTHwYY3yT0gALB3H55PMPk2C7NUO9KIbuEMH6aHmjmjN9ZABpY1z8174RDjCcd+TTBPEihhynwDUDg=
X-Received: by 2002:a2e:9497:0:b0:309:269e:3ac7 with SMTP id
 38308e7fff4ca-30a5b18af54mr37509581fa.11.1740333203810; Sun, 23 Feb 2025
 09:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738717785.im3r5g2vxc.none.ref@localhost> <1738717785.im3r5g2vxc.none@localhost>
 <25e2d5e4-8214-40de-99d3-2b657181a9fd@linux.alibaba.com> <5dd39b03-c40e-4f34-bf89-b3e5a12753dc@linux.alibaba.com>
 <CAK1f24ni707gcGpYKXqsb9XHxjx3froLs3DzVqkkNZdca_pw4Q@mail.gmail.com> <e7b276eb-960a-4e05-9f84-6152de9ac2ea@linux.alibaba.com>
In-Reply-To: <e7b276eb-960a-4e05-9f84-6152de9ac2ea@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 24 Feb 2025 01:53:07 +0800
X-Gm-Features: AWEUYZmOsMq7PEhlCoRG0Qy5DuQaQVGhhSIFYh_ZOZErn8gQjwRsWidGarZLfn8
Message-ID: <CAMgjq7CNVrQFBozKfZyvXX9w6HqAEH6eSN+ZQFaerbueyyqArw@mail.gmail.com>
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

On Fri, Feb 7, 2025 at 3:24=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> On 2025/2/5 22:39, Lance Yang wrote:
> > On Wed, Feb 5, 2025 at 2:38=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >> On 2025/2/5 09:55, Baolin Wang wrote:
> >>> Hi Alex,
> >>>
> >>> On 2025/2/5 09:23, Alex Xu (Hello71) wrote:
> >>>> Hi all,
> >>>>
> >>>> On 6.14-rc1, I found that creating a lot of files in tmpfs then dele=
ting
> >>>> them reliably hangs when tmpfs is mounted with huge=3Dwithin_size, a=
nd it
> >>>> is swapped out to zram (zstd/zsmalloc/no backing dev). I bisected th=
is
> >>>> to acd7ccb284b "mm: shmem: add large folio support for tmpfs".
> >>>>
> >>>> When the issue occurs, rm uses 100% CPU, cannot be killed, and has n=
o
> >>>> output in /proc/pid/stack or wchan. Eventually, an RCU stall is
> >>>> detected:
> >>>
> >>> Thanks for your report. Let me try to reproduce the issue locally and
> >>> see what happens.
> >>>
> >>>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >>>> rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-11): P25160
> >>>> rcu:     (detected by 10, t=3D2102 jiffies, g=3D532677, q=3D4997 ncp=
us=3D12)
> >>>> task:rm              state:R  running task     stack:0     pid:25160
> >>>> tgid:25160 ppid:24309  task_flags:0x400000 flags:0x00004004
> >>>> Call Trace:
> >>>>    <TASK>
> >>>>    ? __schedule+0x388/0x1000
> >>>>    ? kmem_cache_free.part.0+0x23d/0x280
> >>>>    ? sysvec_apic_timer_interrupt+0xa/0x80
> >>>>    ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> >>>>    ? xas_load+0x12/0xc0
> >>>>    ? xas_load+0x8/0xc0
> >>>>    ? xas_find+0x144/0x190
> >>>>    ? find_lock_entries+0x75/0x260
> >>>>    ? shmem_undo_range+0xe6/0x5f0
> >>>>    ? shmem_evict_inode+0xe4/0x230
> >>>>    ? mtree_erase+0x7e/0xe0
> >>>>    ? inode_set_ctime_current+0x2e/0x1f0
> >>>>    ? evict+0xe9/0x260
> >>>>    ? _atomic_dec_and_lock+0x31/0x50
> >>>>    ? do_unlinkat+0x270/0x2b0
> >>>>    ? __x64_sys_unlinkat+0x30/0x50
> >>>>    ? do_syscall_64+0x37/0xe0
> >>>>    ? entry_SYSCALL_64_after_hwframe+0x50/0x58
> >>>>    </TASK>
> >>>>
> >>>> Let me know what information is needed to further troubleshoot this
> >>>> issue.
> >>
> >> Sorry, I can't reproduce this issue, and my testing process is as foll=
ows:
> >> 1. Mount tmpfs with huge=3Dwithin_size
> >> 2. Create and write a tmpfs file
> >> 3. Swap out the large folios of the tmpfs file to zram
> >> 4. Execute 'rm' command to remove the tmpfs file
> >
> > I=E2=80=99m unable to reproduce the issue as well, and am following ste=
ps similar
> > to Baolin's process:
> >
> > 1) Mount tmpfs with the huge=3Dwithin_size option and enable swap (usin=
g
> > zstd/zsmalloc without a backing device).
> > 2) Create and write over 10,000 files in the tmpfs.
> > 3) Swap out the large folios of these tmpfs files to zram.
> > 4) Use the rm command to delete all the files from the tmpfs.
> >
> > Testing with both 2MiB and 64KiB large folio sizes, and with
> > shmem_enabled=3Dwithin_size, but everything works as expected.
>
> Thanks Lance for confirming again.
>
> Alex, could you give more hints on how to reproduce this issue?
>

Hi Baolin,

I can reproduce this issue very easily with the build linux kernel
test, and the failure rate is very high. I'm not exactly sure this is
the same bug but very likely, my test step:

1. Create a 10G ZRAM device and set up SWAP on it.
2. Create a 1G memcg, and spawn a shell in it.
3. Mount tmpfs with huge=3Dwithin_size, and then untar linux kernel
source code into it.
4. Build with make -j32 (higher or lower job number may also work),
the build will always fall within 10s due to file corrupted.

After some debugging, the reason is in shmem_swapin_folio, when swap
cache is hit `folio =3D swap_cache_get_folio(swap, NULL, 0);` sets folio
to a 0 order folio, then the following shmem_add_to_page_cache will
insert a order 0 folio overriding a high order entry in shmem's
xarray, so data are lost. Swap cache hit could be due to many reasons,
in this case it's the readahead.

One quick fix is just always split the entry upon shmem fault of 0
order folio like this:

diff --git a/mm/shmem.c b/mm/shmem.c
index 4ea6109a8043..c8e5c419c675 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2341,6 +2341,10 @@ static int shmem_swapin_folio(struct inode
*inode, pgoff_t index,
                }
        }

+       /* Swapin of 0 order folio must always ensure the entries are split=
 */
+       if (!folio_order(folio))
+               shmem_split_large_entry(inode, index, swap, gfp);
+
 alloced:
        /* We have to do this with folio locked to prevent races */
        folio_lock(folio);

And Hi Alex, can you help confirm if the above patch fixes your reported bu=
g?

If we are OK with this, this should be merged into 6.14 I think, but
for the long term, it might be a good idea to just share a similar
logic of (or just reuse) __filemap_add_folio for shmem?
__filemap_add_folio will split the entry on insert, and code will be
much cleaner.

