Return-Path: <linux-kernel+bounces-446732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92569F288A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4D0164C40
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826D2D047;
	Mon, 16 Dec 2024 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5Wuy8wq"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33A847B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734317178; cv=none; b=AEhosfvkF3K/E8GO3JzDeqKyEypPbHG+rlINrQY/CqcHkrsAGBuvQkt/+fJAzRj+eXsaTQgK15gW9+zKS5hsj5rzH1FYvC/oJoYhPZI1F+C4X1ECUzudaGKOmBzQhGMdwQonsiPQZOnXm7p+8aMGNNNsHw0/UOXe431f/ybBkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734317178; c=relaxed/simple;
	bh=adFfkkYsz7Dgh7jh68hNiZWv8a44DX5CUB0udcGTyZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjZG8rJSOkbXbPbCPPILh18tjfJj8uTP4tSATvjBe7WEOXWZM99LSITZ88sSNcGvQtGXQep+cxjc8lLO5j9MeI/zFDqekIWULgyM4ik3QJmm+6bOq6b4gqGSPGtCYj7wj26iQhEvWyltT8agiyeJdxNplKDnUPF6YWZ3vj3YAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5Wuy8wq; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afe2a1849bso2255490137.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 18:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734317175; x=1734921975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLot+HbM4BYaCqewmjaj28U0zQAIhd5TkE+/D1yxeW4=;
        b=o5Wuy8wqpick3HT/fFBfrgsNn1w0jCp6Lli2lr7SfI8+BFqkCvafFwRcMott+qMmg5
         Dkw8YVrOC0lsRxFppxNslGS+sgAe+XIPpMAp8bTddOwXvbstql0405syblENVeVKCE5H
         7w6VT8O7ybNiD2UDXtbGkAVsxKV+rWcYun6sC22Lix8pgPdMSP82jsboaMcbRpvK2gjP
         Sl3syNWnJb2ORI2O/0x2SYBW2nWRHEiyTsvY45dQI2moJSnE7xXMykJ8oK+7E+l6lrWx
         T/Zj/ELbpHclP8AAYK7Wr+oud7XZK3iyuQ/jtYP3e2GvF57PqZIleIKkU651wHH9DUM4
         GlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734317175; x=1734921975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLot+HbM4BYaCqewmjaj28U0zQAIhd5TkE+/D1yxeW4=;
        b=EdNHWegDpEb9aLauqS6WQAH18uw/ZlLEemHb/MW9oUXpkE5kZbCxwjq1srMVID17Aq
         UIqwzHgR+/e2NYdbbwTUiBw6Er4wK+mYOpvT+Nkvbt4f044RIg+S9nHAsUI1Q6vmM0V3
         9V26G0dugOSXB3YFtnGfTUyzCr+gW2GaOf4+HvO7sccVFYmBPHXzWCAY/yKIXVPYgn7Z
         IyQ1HjqNF62miYXc5+Pa7j2fTG6SOGARmiyi81mlhl6bjUhRPcz+qtYtS0ArY4w13u8+
         Oua9GHiwOtKrvrGRQCumtqUnv4aJcqEWzSyHzjhUbQlxjGXwMfgEB+Ok3jNQiwf6LJKu
         dZHw==
X-Forwarded-Encrypted: i=1; AJvYcCXKW/44co9gixJdO7DIcXOqpgfQ4FkvYR1ZUzOiu4vlodE8H95U+10+ubwCvRNJRQT7MHYEfDBMIkcxlks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+wbRCXVlqhqMPenxjlAkULy+tiG693UyF3P1KhtqgIP43XvD
	vdtLFmSHbazPnz+xJeFfYrhFIxsqn33I9KaCcXhcez15bbrUjVH0vV/LHRcxVyT3IDM0X63LA1C
	Jn7kkwFJhGYAdEYCGzXzPRkkYLeTJIHSkBAYH6182M7T2/MRAUw==
X-Gm-Gg: ASbGnctOpL1jeDzVzzVNa9yqp05QDSwwtZQAXTRv5ZVuSNxHAVjHSeEtPYFToBzDbGX
	jdqkq4vuJBQ6gOQHlwmMC68mLTe+3g+18qZn1J1+aSE0YygR1qLAjawoOGSjcOveGrpEGGZo=
X-Google-Smtp-Source: AGHT+IHzmN5Q/2SZLvSlTt9yiw4IXAt/Sa+yEhgGUkSl4PdZo5HjNcgcm+bmfmI4L4FXYoNCmJDrR3rG6Sn5aZjApBs=
X-Received: by 2002:a05:6102:50a2:b0:4b1:1b67:6a5c with SMTP id
 ada2fe7eead31-4b25db3f390mr9431174137.18.1734317175094; Sun, 15 Dec 2024
 18:46:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675d01e9.050a0220.37aaf.00be.GAE@google.com> <CAOUHufZ+UDx5pXD7b1pBC8P0Ubu1p2Z5r6Qx+ruT5g78q02Cxw@mail.gmail.com>
 <CAMgjq7BpdyJ=Q4OW4gEeCxP9PU5u=4Mp_Bd=uqr5iaosrQJMZg@mail.gmail.com> <CAMgjq7ArVJ8hhqLkuEJNVhhFX4BaFz8uDrZvXkHrDsESJpsWmw@mail.gmail.com>
In-Reply-To: <CAMgjq7ArVJ8hhqLkuEJNVhhFX4BaFz8uDrZvXkHrDsESJpsWmw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 15 Dec 2024 19:45:38 -0700
Message-ID: <CAOUHufYXqj5QqZ5Kv4CNn2HyeUGT6RidKGJ6Jp17NUGjqgKAXA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in lock_list_lru_of_memcg
To: Kairui Song <ryncsn@gmail.com>
Cc: syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kairui,

On Sun, Dec 15, 2024 at 10:45=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Sun, Dec 15, 2024 at 3:43=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Sat, Dec 14, 2024 at 2:06=E2=80=AFPM Yu Zhao <yuzhao@google.com> wro=
te:
> > >
> > > On Fri, Dec 13, 2024 at 8:56=E2=80=AFPM syzbot
> > > <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    7cb1b4663150 Merge tag 'locking_urgent_for_v6.13_rc=
3' of g..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16e96b3=
0580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfee25f9=
3665c89ac
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D38a0cbd26=
7eff2d286ff
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-as=
sets/7feb34a89c2a/non_bootable_disk-7cb1b466.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/13e083329dab/=
vmlinux-7cb1b466.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/fe3847d0=
8513/bzImage-7cb1b466.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 0 PID: 80 at mm/list_lru.c:97 lock_list_lru_of_memcg+=
0x395/0x4e0 mm/list_lru.c:97
> > > > Modules linked in:
> > > > CPU: 0 UID: 0 PID: 80 Comm: kswapd0 Not tainted 6.13.0-rc2-syzkalle=
r-00018-g7cb1b4663150 #0
> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-deb=
ian-1.16.3-2~bpo12+1 04/01/2014
> > > > RIP: 0010:lock_list_lru_of_memcg+0x395/0x4e0 mm/list_lru.c:97
> > > > Code: e9 22 fe ff ff e8 9b cc b6 ff 4c 8b 7c 24 10 45 84 f6 0f 84 4=
0 ff ff ff e9 37 01 00 00 e8 83 cc b6 ff eb 05 e8 7c cc b6 ff 90 <0f> 0b 90=
 eb 97 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 7a fd ff ff 48
> > > > RSP: 0018:ffffc9000105e798 EFLAGS: 00010093
> > > > RAX: ffffffff81e891c4 RBX: 0000000000000000 RCX: ffff88801f53a440
> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > > RBP: ffff888042e70054 R08: ffffffff81e89156 R09: 1ffffffff2032cae
> > > > R10: dffffc0000000000 R11: fffffbfff2032caf R12: ffffffff81e88e5e
> > > > R13: ffffffff9a3feb20 R14: 0000000000000000 R15: ffff888042e70000
> > > > FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000000020161000 CR3: 0000000032d12000 CR4: 0000000000352ef0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  <TASK>
> > > >  list_lru_add+0x59/0x270 mm/list_lru.c:164
> > > >  list_lru_add_obj+0x17b/0x250 mm/list_lru.c:187
> > > >  workingset_update_node+0x1af/0x230 mm/workingset.c:634
> > > >  xas_update lib/xarray.c:355 [inline]
> > > >  update_node lib/xarray.c:758 [inline]
> > > >  xas_store+0xb8f/0x1890 lib/xarray.c:845
> > > >  page_cache_delete mm/filemap.c:149 [inline]
> > > >  __filemap_remove_folio+0x4e9/0x670 mm/filemap.c:232
> > > >  __remove_mapping+0x86f/0xad0 mm/vmscan.c:791
> > > >  shrink_folio_list+0x30a6/0x5ca0 mm/vmscan.c:1467
> > > >  evict_folios+0x3c86/0x5800 mm/vmscan.c:4593
> > > >  try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
> > > >  shrink_one+0x3b9/0x850 mm/vmscan.c:4834
> > > >  shrink_many mm/vmscan.c:4897 [inline]
> > > >  lru_gen_shrink_node mm/vmscan.c:4975 [inline]
> > > >  shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
> > > >  kswapd_shrink_node mm/vmscan.c:6785 [inline]
> > > >  balance_pgdat mm/vmscan.c:6977 [inline]
> > > >  kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
> > > >  kthread+0x2f0/0x390 kernel/kthread.c:389
> > > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > > >  </TASK>
> > >
> > > This one seems to be related to "mm/list_lru: split the lock to
> > > per-cgroup scope".
> > >
> > > Kairui, can you please take a look? Thanks.
> >
> > Thanks for pinging, yes that's a new sanity check added by me.
> >
> > Which is supposed to mean, a list_lru is being reparented while the
> > memcg it belongs to isn't dying.
> >
> > More concretely, list_lru is marked dead by memcg_offline_kmem ->
> > memcg_reparent_list_lrus, if the function is called for one memcg, but
> > now the memcg is not dying, this WARN triggers. I'm not sure how this
> > is caused. One possibility is if alloc_shrinker_info() in
> > mem_cgroup_css_online failed, then memcg_offline_kmem is called early?
> > Doesn't seem to fit this case though.. Or maybe just sync issues with
> > the memcg dying flag so the user saw the list_lru dying before seeing
> > memcg dying? The object might be leaked to the parent cgroup, seems
> > not too terrible though.
> >
> > I'm not sure how to reproduce this. I will keep looking.
>
> Managed to boot the image and using the kernel config provided by bot,
> so far local tests didn't trigger any issue. Is there any way I can
> reproduce what the bot actually did?

If syzbot doesn't have a repro, it might not be productive for you to
try to find one. Personally, I would analyze stacktraces and double
check the code, and move on if I can't find something obviously wrong.

> Or provide some patch for the bot
> to test?

syzbot only can try patches after it finds a repro. So in this case,
no, it can't try your patches.

Hope the above clarifies things for you.

