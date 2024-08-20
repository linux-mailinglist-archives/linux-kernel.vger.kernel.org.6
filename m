Return-Path: <linux-kernel+bounces-293582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B111F958198
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EFE1C20AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EE1189F2F;
	Tue, 20 Aug 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COSCI8hS"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5B18E349
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144561; cv=none; b=fnw4Hri1Cz0er7AKcv1YQA3bT5ld3GL/ijr1neUfUXeq6nLyROfl891zlKR/HNo99dDvfqZim8tTHuQv79hLRcb1hqBiYkYvkt8CggNT2DgypIYHxXfCO+ifT840cwLYy+6L4K5Axxj+iwXOQTvXMXbFQz3atn3l1kZigcx1Sl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144561; c=relaxed/simple;
	bh=PdHf7ZrrhrsDpDcnUm+eXUic8UB/5r7ePMtPRrTm1QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvNxBaEUy5X3zrsFF8ZvxLnQvsVw1rIP6QDytI7cIEb6TPoemLSONTT6WO+zQMmGiz3KHSpcZ3zQYh0p9q68pgZb7HsZYahD43IcaCNSSqZQfiQAdhwFLeLrnO+q4R+S/EwaeUjFIqCeVbg+9r6ll6QRlvh/DgGb/dASRws7Oog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COSCI8hS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f1a7faa4d5so64565851fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724144558; x=1724749358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQvEj+i2KB/Df0ml1vf1DAW64uAm8Q1UNpNL60RFnfs=;
        b=COSCI8hSEaX7P5yr3KK28IwetfW2HONCVVVpLQkiBoJd2mQMIAX78AJCRwGc9zFNkJ
         SqLm3p3nHyu9CMsu5LMeHv/M5eyeZ2V5696wCPpi+B+4G6hpiEeUiaD59c3K78SwYbjW
         KdS4RgF/yn2inpoPtZSbJN2/nm0duIAyJ4TGFNeWTws3ypBrkn+SpVQIWN+JSUfaD4H3
         E13nDyzCyyhAxmFtiCb82bQVK6F6GyphjxFQ0McKIG7QmbqI1GFaIwsDVQ0hTDLQSyQH
         VJU+4/fxxRInsjZnsNEHHSfcs9VJa82OwPFjzeKRuISI39+O8JH0KSceESEqoZcwi8Hp
         lUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724144558; x=1724749358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQvEj+i2KB/Df0ml1vf1DAW64uAm8Q1UNpNL60RFnfs=;
        b=hC5Cx8Q1ycxtPFa9TBiX7iANcSSaya4XDjq9VG+R6ogglFuZBT7zz6TCLklZ8WHqY5
         Rqbula0on6iembu0Ti/sh99uGHhSWRZGysxybTqVlzP/ro4CXp9ZhWfxpkewVB/35apH
         u0F0Y5ZcEpnDHBiozG87PtP8IyOqaMQxVe0RFIN9ey1ux/DKNnlPZ1oTHhacS2DDJXp9
         BtmVToyINryzdQ54M39OtvcvfZ4mFWOPsjUpQqBdZQv17UgUhA70zhl4wzgdXOaTXp8B
         3OUWvrClNzx1rAsA6c1FmxpKUq+gSWXfeGgqgI9y6r8+scyECLkt22sHNBz3iPpsMlAR
         AzKw==
X-Forwarded-Encrypted: i=1; AJvYcCVMI8s/MIlF0QhyabwMJCy56v/541y6Rrx0k0Mu6xfRN7nuFJJiXowK7FeSRxBzFJvHvM1TkhPRemv5oQ224Oal0z4/zArytjenscq9
X-Gm-Message-State: AOJu0YxhI0j9ZXEbfHhP2B0nPh3w8IVFu4AXC6k4ps8IrSQ+1Wxutlo2
	+dZ2Q8c6cYlHa+KIT+a0OkwXTP/O1cBAGsdkLFPuyU/krNc6t/FY75yqu5sFjDgWgPcY8LV6G+r
	fREd7InmzzEk0kyGtbqD+JgceCsCX7GJMRTs=
X-Google-Smtp-Source: AGHT+IEsiXwFlzQo0g+R6eE/DS/Ct1wvhPZjsaLOCdc2PyEJ7YhxP5z2ilu5qAyZI20if7MzIy4b3o6XTdVQxmD1Re4=
X-Received: by 2002:a05:651c:504:b0:2f1:56a6:6057 with SMTP id
 38308e7fff4ca-2f3be57849emr85755641fa.7.1724144557428; Tue, 20 Aug 2024
 02:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000060cf79061fd24ca8@google.com> <CAJD7tkYWMkcFeXKA2S71PoZAubS+0R29G5qbhTSLLCcd7DfqkQ@mail.gmail.com>
 <CAMgjq7CaCEZN2hf5pPR4N6BLzUEiMAA7Ax+G_nv4CyHVukxCNw@mail.gmail.com>
In-Reply-To: <CAMgjq7CaCEZN2hf5pPR4N6BLzUEiMAA7Ax+G_nv4CyHVukxCNw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 20 Aug 2024 17:02:20 +0800
Message-ID: <CAMgjq7BhpCoPMEkSkCAqWcvTO93KQK4xzn2Av6M0ATkk8YZapg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
To: Yosry Ahmed <yosryahmed@google.com>, Barry Song <21cnbao@gmail.com>
Cc: syzbot <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, Chris Li <chrisl@kernel.org>, 
	Ying <ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 4:47=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Aug 20, 2024 at 4:13=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> > On Fri, Aug 16, 2024 at 12:52=E2=80=AFPM syzbot
> > <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    367b5c3d53e5 Add linux-next specific files for 202408=
16
>
> I can't find this commit, seems this commit is not in linux-next any more=
?
>
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D124891059=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61ba6f3b2=
2ee5467
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dce6029250d7=
fd4d0476d
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c=
/disk-367b5c3d.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vm=
linux-367b5c3d.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709=
b1/bzImage-367b5c3d.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 11298 at mm/zswap.c:1700 zswap_swapoff+0x11b/0x2=
b0 mm/zswap.c:1700
> > > Modules linked in:
> > > CPU: 0 UID: 0 PID: 11298 Comm: swapoff Not tainted 6.11.0-rc3-next-20=
240816-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 06/27/2024
> > > RIP: 0010:zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
> > > Code: 74 05 e8 78 73 07 00 4b 83 7c 35 00 00 75 15 e8 1b bd 9e ff 48 =
ff c5 49 83 c6 50 83 7c 24 0c 17 76 9b eb 24 e8 06 bd 9e ff 90 <0f> 0b 90 e=
b e5 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 7c 90 48 8b 3c
> > > RSP: 0018:ffffc9000302fa38 EFLAGS: 00010293
> > > RAX: ffffffff81f4d66a RBX: dffffc0000000000 RCX: ffff88802c19bc00
> > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff888015986248
> > > RBP: 0000000000000000 R08: ffffffff81f4d620 R09: 1ffffffff1d476ac
> > > R10: dffffc0000000000 R11: fffffbfff1d476ad R12: dffffc0000000000
> > > R13: ffff888015986200 R14: 0000000000000048 R15: 0000000000000002
> > > FS:  00007f9e628a5380(0000) GS:ffff8880b9000000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000001b30f15ff8 CR3: 000000006c5f0000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  __do_sys_swapoff mm/swapfile.c:2837 [inline]
> > >  __se_sys_swapoff+0x4653/0x4cf0 mm/swapfile.c:2706
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7f9e629feb37
> > > Code: 73 01 c3 48 8b 0d f1 52 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 8b 0d c1 52 0d 00 f7 d8 64 89 01 48
> > > RSP: 002b:00007fff17734f68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a=
8
> > > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9e629feb37
> > > RDX: 00007f9e62a9e7e8 RSI: 00007f9e62b9beed RDI: 0000563090942a20
> > > RBP: 0000563090942a20 R08: 0000000000000000 R09: 77872e07ed164f94
> > > R10: 000000000000001f R11: 0000000000000246 R12: 00007fff17735188
> > > R13: 00005630909422a0 R14: 0000563073724169 R15: 00007f9e62bdda80
> > >  </TASK>
> >
> > I am hoping syzbot would find a reproducer and bisect this for us.
> > Meanwhile, from a high-level it looks to me like we are missing a
> > zswap_invalidate() call in some paths.
> >
> > If I have to guess, I would say it's related to the latest mTHP swap
> > changes, but I am not following closely. Perhaps one of the following
> > things happened:
> >
> > (1) We are not calling zswap_invalidate() in some invalidation paths.
> > It used to not be called for the cluster freeing path, so maybe we end
> > up with some order-0 swap entries in a cluster? or maybe there is an
> > entirely new invalidation path that does not go through
> > free_swap_slot() for order-0 entries?
> >
> > (2) Some higher order swap entries (i.e. a cluster) end up in zswap
> > somehow. zswap_store() has a warning to cover that though. Maybe
> > somehow some swap entries are allocated as a cluster, but then pages
> > are swapped out one-by-one as order-0 (which can go to zswap), but
> > then we still free the swap entries as a cluster?
>
> Hi Yosry, thanks for the report.
>
> There are many mTHP related optimizations recently, for this problem I
> can reproduce this locally. Can confirm the problem is gone for me
> after reverting:
>
> "mm: attempt to batch free swap entries for zap_pte_range()"
>
> Hi Barry,
>
> If a set of continuous slots are having the same value, they are
> considered a mTHP and freed, bypassing the slot cache, and causing
> zswap leak.
> This didn't happen in put_swap_folio because that function is
> expecting an actual mTHP folio behind the slots but
> free_swap_and_cache_nr is simply walking the slots.
>
> For the testing, I actually have to disable mTHP, because linux-next
> will panic with mTHP due to lack of following fixes:
> https://lore.kernel.org/linux-mm/a4b1b34f-0d8c-490d-ab00-eaedbf3fe780@gma=
il.com/
> https://lore.kernel.org/linux-mm/403b7f3c-6e5b-4030-ab1c-3198f36e3f73@gma=
il.com/
>
> >
> > I am not closely following the latest changes so I am not sure. CCing
> > folks who have done work in that area recently.
> >
> > I am starting to think maybe it would be more reliable to just call
> > zswap_invalidate() for all freed swap entries anyway. Would that be
> > too expensive? We used to do that before the zswap_invalidate() call
> > was moved by commit 0827a1fb143f ("mm/zswap: invalidate zswap entry
> > when swap entry free"), and that was before we started using the
> > xarray (so it was arguably worse than it would be now).
> >
>
> That might be a good idea, I suggest moving zswap_invalidate to
> swap_range_free and call it for every freed slot.
>
> Below patch can be squash into or put before "mm: attempt to batch
> free swap entries for zap_pte_range()".

Hmm, on second thought, the commit message in the attachment commit
might be not suitable, current zswap_invalidate is also designed to
only work for order 0 ZSWAP, so things are not clean even after this.

And for performance, it will cause unnecessary heavier contention for
the mTHP page on ZSWAP Xarray. It does fix the leak though, please
ignore this fix, let's try find a better fix.

