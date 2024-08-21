Return-Path: <linux-kernel+bounces-295061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78943959633
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493DC281530
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543DB1A7AD8;
	Wed, 21 Aug 2024 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyPLCAyN"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC918BC3F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225920; cv=none; b=lOYWYUmawklSYvzaiOu0SWNmlLULN3BH8CFpX2ai+aaehvQuY64EQKdm81jf4ldUwFr4+bs6swXfErquS2DmWDdkdubBlTB5v7kDqPvwcj+uGIbqOuvNXVdoB59EMYJFQiggfRM3gBDQP6QV8KT25uSmLUbzMJmmAOPQz7ifFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225920; c=relaxed/simple;
	bh=EHPpJIiSV0XQyyVA4wct/MdQV/8U9tVtraYERRZ9KQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npFiZI86wUdzkYizyemDcCehufCqu6k7NDvBd0TUT+g4BrBsHuQMN8xP8IWpd28YoXH+xyiEsBPNZNn5Oht+oFhXZCwifkcMVYLM1oezHqdR4vAKwvEEvDBbSZ+iCVwnEu6Z9Y29t83mNR2wLCZCEMSL9LydrqTk3wpMQQ3SxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyPLCAyN; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-498c4d5a912so580946137.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724225917; x=1724830717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzSGGFm7ZFWjbOa6s0GPDWc8zH4KT9ub5u4nCrK74XY=;
        b=QyPLCAyNvzhJTVxnc4L6Pdc85MmEVu62YfkL3lzFr/8GeyAcsxBxZBCav86spnoaDv
         O/OOwWbegVH/GduNhSPUBGEtesK18g6uZsZkUNZVKQVWUdBlyI6S2o6/bIsZL1E7WLLP
         agPBWhUHhqf3pw7H+ExxCHWNxPrYMKBuXkTaK9uyylytX1Vp5+3QcKKsEcPFTGjNlK0U
         rVWrLzKSFjNb11Lb4HCk3NoAaaufVdOlyxhll/b3Qf3HA3+vKgkd61XpGsgQlKaV78z0
         MiXB8VDc/DgXlBoYkoKltTto3FEqbhnL+YAHtm5iUvMm6xNn2I/lZ1yqGg/ZmnjJq6Vy
         VBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724225917; x=1724830717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzSGGFm7ZFWjbOa6s0GPDWc8zH4KT9ub5u4nCrK74XY=;
        b=Yuqd1s5LQE7HIA7wZZJa3dTqp1uWUcBiWEk7d1Y5DagMYSdg9zxTKZJNNGlhocwgpn
         o80kGx9rikkrblx7PdL+4/5DXgAw91k1dPUc8RnehleynuuzIy6s1KzU+Qmtrzr9wiKU
         Zgt7PooGOXzEo7HPFe6hr6zo0NAWgPd+kdxxYM/XOWNbT8fUzmmFN8naxXKNjEJkIxA/
         DZ+60OeaD4scWeLeymYZHHX+Ib4QN/8xc1uqLlw7GVbN57Xf9QbyYNVmROfczIkLuzQJ
         UkRVu9SpGYX9USZfDhZ4UdWikWPW/giNGjzHfR1L06BF26B+YtmVexLx8X/+zLxXRuhA
         +iOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDZPNEA71wU9Ilr5j5DZMRBXIa0qKdG6093sCE0lerRBraiHxCFthTV5y6ZPeenj0kW2L3hD+c/6Dn1QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZG5uGkbsPl1Q5h4tsSs959OuNm99mfDhtScp+ylzH7GTf1p1
	DHTE0QyhSfFEpTpgHWQn7ud6XNoh8djJjnjVWZJYR2QFq0q7SuUSYHkSgbZGGAmBtXK5hRkVNgv
	NVXTNL7dqDtWBvkX0eRTHfAfaUCY=
X-Google-Smtp-Source: AGHT+IGb0IvWmhD+dR+4kYq6qhy0FbbAusEE10A/bsVVzs+38juYCZfDym/dtA42RGU8+6R5Q2uI+yBzZFEsftxRZDk=
X-Received: by 2002:a05:6102:3906:b0:497:5eed:cd89 with SMTP id
 ada2fe7eead31-498d2f8e4d3mr2437108137.22.1724225917078; Wed, 21 Aug 2024
 00:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMgjq7BhpCoPMEkSkCAqWcvTO93KQK4xzn2Av6M0ATkk8YZapg@mail.gmail.com>
 <20240821054921.43468-1-21cnbao@gmail.com> <CAMgjq7Czvr+PXF7Q5eSChAdmiLH-uvd7HTred63T8JPCCYzTSQ@mail.gmail.com>
In-Reply-To: <CAMgjq7Czvr+PXF7Q5eSChAdmiLH-uvd7HTred63T8JPCCYzTSQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 21 Aug 2024 19:38:25 +1200
Message-ID: <CAGsJ_4xkzWY3qpi=hq7uexkaSYW0WSKxVShVNywZJ7GVWY=t4A@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, ryan.roberts@arm.com, 
	syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@intel.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 6:42=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Wed, Aug 21, 2024 at 1:49=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Tue, Aug 20, 2024 at 9:02=E2=80=AFPM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Tue, Aug 20, 2024 at 4:47=E2=80=AFPM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > On Tue, Aug 20, 2024 at 4:13=E2=80=AFAM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > > On Fri, Aug 16, 2024 at 12:52=E2=80=AFPM syzbot
> > > > > <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    367b5c3d53e5 Add linux-next specific files for =
20240816
> > > >
> > > > I can't find this commit, seems this commit is not in linux-next an=
y more?
> > > >
> > > > > > git tree:       linux-next
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D124=
89105980000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61b=
a6f3b22ee5467
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dce602=
9250d7fd4d0476d
> > > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binuti=
ls for Debian) 2.40
> > > > > >
> > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > >
> > > > > > Downloadable assets:
> > > > > > disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e=
3cad3c/disk-367b5c3d.raw.xz
> > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f78=
13c/vmlinux-367b5c3d.xz
> > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/6674=
cb0709b1/bzImage-367b5c3d.xz
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag t=
o the commit:
> > > > > > Reported-by: syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.=
com
> > > > > >
> > > > > > ------------[ cut here ]------------
> > > > > > WARNING: CPU: 0 PID: 11298 at mm/zswap.c:1700 zswap_swapoff+0x1=
1b/0x2b0 mm/zswap.c:1700
> > > > > > Modules linked in:
> > > > > > CPU: 0 UID: 0 PID: 11298 Comm: swapoff Not tainted 6.11.0-rc3-n=
ext-20240816-syzkaller #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engi=
ne, BIOS Google 06/27/2024
> > > > > > RIP: 0010:zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
> > > > > > Code: 74 05 e8 78 73 07 00 4b 83 7c 35 00 00 75 15 e8 1b bd 9e =
ff 48 ff c5 49 83 c6 50 83 7c 24 0c 17 76 9b eb 24 e8 06 bd 9e ff 90 <0f> 0=
b 90 eb e5 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 7c 90 48 8b 3c
> > > > > > RSP: 0018:ffffc9000302fa38 EFLAGS: 00010293
> > > > > > RAX: ffffffff81f4d66a RBX: dffffc0000000000 RCX: ffff88802c19bc=
00
> > > > > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff8880159862=
48
> > > > > > RBP: 0000000000000000 R08: ffffffff81f4d620 R09: 1ffffffff1d476=
ac
> > > > > > R10: dffffc0000000000 R11: fffffbfff1d476ad R12: dffffc00000000=
00
> > > > > > R13: ffff888015986200 R14: 0000000000000048 R15: 00000000000000=
02
> > > > > > FS:  00007f9e628a5380(0000) GS:ffff8880b9000000(0000) knlGS:000=
0000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 0000001b30f15ff8 CR3: 000000006c5f0000 CR4: 00000000003506=
f0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000000=
00
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000004=
00
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  __do_sys_swapoff mm/swapfile.c:2837 [inline]
> > > > > >  __se_sys_swapoff+0x4653/0x4cf0 mm/swapfile.c:2706
> > > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > > RIP: 0033:0x7f9e629feb37
> > > > > > Code: 73 01 c3 48 8b 0d f1 52 0d 00 f7 d8 64 89 01 48 83 c8 ff =
c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <48> 3=
d 01 f0 ff ff 73 01 c3 48 8b 0d c1 52 0d 00 f7 d8 64 89 01 48
> > > > > > RSP: 002b:00007fff17734f68 EFLAGS: 00000246 ORIG_RAX: 000000000=
00000a8
> > > > > > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9e629feb=
37
> > > > > > RDX: 00007f9e62a9e7e8 RSI: 00007f9e62b9beed RDI: 0000563090942a=
20
> > > > > > RBP: 0000563090942a20 R08: 0000000000000000 R09: 77872e07ed164f=
94
> > > > > > R10: 000000000000001f R11: 0000000000000246 R12: 00007fff177351=
88
> > > > > > R13: 00005630909422a0 R14: 0000563073724169 R15: 00007f9e62bdda=
80
> > > > > >  </TASK>
> > > > >
> > > > > I am hoping syzbot would find a reproducer and bisect this for us=
.
> > > > > Meanwhile, from a high-level it looks to me like we are missing a
> > > > > zswap_invalidate() call in some paths.
> > > > >
> > > > > If I have to guess, I would say it's related to the latest mTHP s=
wap
> > > > > changes, but I am not following closely. Perhaps one of the follo=
wing
> > > > > things happened:
> > > > >
> > > > > (1) We are not calling zswap_invalidate() in some invalidation pa=
ths.
> > > > > It used to not be called for the cluster freeing path, so maybe w=
e end
> > > > > up with some order-0 swap entries in a cluster? or maybe there is=
 an
> > > > > entirely new invalidation path that does not go through
> > > > > free_swap_slot() for order-0 entries?
> > > > >
> > > > > (2) Some higher order swap entries (i.e. a cluster) end up in zsw=
ap
> > > > > somehow. zswap_store() has a warning to cover that though. Maybe
> > > > > somehow some swap entries are allocated as a cluster, but then pa=
ges
> > > > > are swapped out one-by-one as order-0 (which can go to zswap), bu=
t
> > > > > then we still free the swap entries as a cluster?
> > > >
> > > > Hi Yosry, thanks for the report.
> > > >
> > > > There are many mTHP related optimizations recently, for this proble=
m I
> > > > can reproduce this locally. Can confirm the problem is gone for me
> > > > after reverting:
> > > >
> > > > "mm: attempt to batch free swap entries for zap_pte_range()"
> > > >
> > > > Hi Barry,
> > > >
> > > > If a set of continuous slots are having the same value, they are
> > > > considered a mTHP and freed, bypassing the slot cache, and causing
> > > > zswap leak.
> > > > This didn't happen in put_swap_folio because that function is
> > > > expecting an actual mTHP folio behind the slots but
> > > > free_swap_and_cache_nr is simply walking the slots.
> > > >
> > > > For the testing, I actually have to disable mTHP, because linux-nex=
t
> > > > will panic with mTHP due to lack of following fixes:
> > > > https://lore.kernel.org/linux-mm/a4b1b34f-0d8c-490d-ab00-eaedbf3fe7=
80@gmail.com/
> > > > https://lore.kernel.org/linux-mm/403b7f3c-6e5b-4030-ab1c-3198f36e3f=
73@gmail.com/
> > > >
> > > > >
> > > > > I am not closely following the latest changes so I am not sure. C=
Cing
> > > > > folks who have done work in that area recently.
> > > > >
> > > > > I am starting to think maybe it would be more reliable to just ca=
ll
> > > > > zswap_invalidate() for all freed swap entries anyway. Would that =
be
> > > > > too expensive? We used to do that before the zswap_invalidate() c=
all
> > > > > was moved by commit 0827a1fb143f ("mm/zswap: invalidate zswap ent=
ry
> > > > > when swap entry free"), and that was before we started using the
> > > > > xarray (so it was arguably worse than it would be now).
> > > > >
> > > >
> > > > That might be a good idea, I suggest moving zswap_invalidate to
> > > > swap_range_free and call it for every freed slot.
> > > >
> > > > Below patch can be squash into or put before "mm: attempt to batch
> > > > free swap entries for zap_pte_range()".
> > >
> > > Hmm, on second thought, the commit message in the attachment commit
> > > might be not suitable, current zswap_invalidate is also designed to
> > > only work for order 0 ZSWAP, so things are not clean even after this.
> >
> > Kairui, what about the below? we don't touch the path of __try_to_recla=
im_swap() where
> > you have one folio backed?
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index c1638a009113..8ff58be40544 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1514,6 +1514,8 @@ static bool __swap_entries_free(struct swap_info_=
struct *si,
> >         unlock_cluster_or_swap_info(si, ci);
> >
> >         if (!has_cache) {
> > +               for (i =3D 0; i < nr; i++)
> > +                       zswap_invalidate(swp_entry(si->type, offset + i=
));
> >                 spin_lock(&si->lock);
> >                 swap_entry_range_free(si, entry, nr);
> >                 spin_unlock(&si->lock);
> >
>
> Hi Barry,
>
> Thanks for updating this thread, I'm thinking maybe something will
> better be done at the zswap side?
>
> The concern of using zswap_invalidate is that it calls xa_erase which
> requires the xa spin lock. But if we are calling zswap_invalidate in
> swap_entry_range_free, and ensure the slot is HAS_CACHE pinned, doing
> a lockless read first with xa_load should be OK for checking if the
> slot needs a ZSWAP invalidation. The performance cost will be minimal
> and we only need to call zswap_invalidate in one place, something like
> this (haven't tested, comments are welcome). Also ZSWAP mthp will
> still store entried in order 0 so this should be OK for future.

Hi Kairui,

I fully welcome the callers of swap_entry_range_free not needing to worry
about the zswap mechanism=E2=80=94it's a freedom from concerning themselves
with zswap. However, currently, zswap_invalidate is executed outside of
the si lock, and after the changes, it will be inside the si lock, which ma=
y
potentially increase the time spent holding the si lock. So, is it possible=
 to
move the action of acquiring the si lock for swap_entry_range_free to
this function and do it after completing zswap_invalidate? Or am I
overthinking it?

swap_entry_range_free(si, entry, size)
{
      for(nr)
            zswap_invalidate(....)

     spin_lock(si->lock)
     ...
     spin_unlock(si->lock)
}

>
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 13ab3b771409..d7bb3caa9d4e 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -273,9 +273,6 @@ void free_swap_slot(swp_entry_t entry)
>  {
>          struct swap_slots_cache *cache;
>
> -        /* Large folio swap slot is not covered. */
> -        zswap_invalidate(entry);
> -
>          cache =3D raw_cpu_ptr(&swp_slots);
>          if (likely(use_swap_slot_cache && cache->slots_ret)) {
>                  spin_lock_irq(&cache->free_lock);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f947f4dd31a9..fbc25d38a27e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -242,9 +242,6 @@ static int __try_to_reclaim_swap(struct
> swap_info_struct *si,
>          folio_set_dirty(folio);
>
>          spin_lock(&si->lock);
> -        /* Only sinple page folio can be backed by zswap */
> -        if (nr_pages =3D=3D 1)
> -                zswap_invalidate(entry);
>          swap_entry_range_free(si, entry, nr_pages);
>          spin_unlock(&si->lock);
>          ret =3D nr_pages;
> @@ -1545,6 +1542,10 @@ static void swap_entry_range_free(struct
> swap_info_struct *si, swp_entry_t entry
>          unsigned char *map_end =3D map + nr_pages;
>          struct swap_cluster_info *ci;
>
> +        /* Slots are pinned with SWAP_HAS_CACHE, safe to invalidate */
> +        for (int i =3D 0; i < nr_pages; ++i)
> +                zswap_invalidate(swp_entry(si->type, offset + i));
> +
>          ci =3D lock_cluster(si, offset);
>          do {
>                  VM_BUG_ON(*map !=3D SWAP_HAS_CACHE);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index df66ab102d27..100ad04397fe 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1656,15 +1656,18 @@ bool zswap_load(struct folio *folio)
>          return true;
>  }
>
> +/* Caller need to pin the slot to prevent parallel store */
>  void zswap_invalidate(swp_entry_t swp)
>  {
>          pgoff_t offset =3D swp_offset(swp);
>          struct xarray *tree =3D swap_zswap_tree(swp);
>          struct zswap_entry *entry;
>
> -        entry =3D xa_erase(tree, offset);
> -        if (entry)
> -                zswap_entry_free(entry);
> +        if (xa_load(tree, offset)) {
> +                entry =3D xa_erase(tree, offset);
> +                if (entry)
> +                        zswap_entry_free(entry);
> +        }
>  }
>
>  int zswap_swapon(int type, unsigned long nr_pages)
> --
> 2.45.2

