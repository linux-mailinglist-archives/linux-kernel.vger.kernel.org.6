Return-Path: <linux-kernel+bounces-297942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A942495BF7E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E351F244B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F01D0DFB;
	Thu, 22 Aug 2024 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lg1EergQ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C8C1D173F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358041; cv=none; b=aCebsX+JWAD74hEnA5DqLl65JPc/bm+imx7GAkR9anL1aB8FoL6OJ2VikM2PhTBInkAGePf/2OtJ1+7h/E65GU2bHa1tBzU02ta7GRsUnM7mSvKABep9WFY8lDLjqjnyVetCvo6Szw+ukqv2FdKXKgdP3ddY2j9x53PqBtks2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358041; c=relaxed/simple;
	bh=K4fsF/4gcQE6VEDaufzLbbV53ItAXp/f/OAoyT1o5mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfaRdPpROAGNvj1mJ5T9k3n9x5URJMJFCU/uEohqpQcavTq6WItAeJxW1ZDDJbn6HcAHpPS1SVvF3aOiopx7IlNlrcqU712Hi8b4mmXrYLbpqtiRNg+xB3cClJWqff3gWTsEW4oGN8zTNu8IY/SvSq4wzsHY2EyZ/zElHpXDS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lg1EergQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso1651134a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724358037; x=1724962837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4BpYDCBRf3GhJ+JefscMjttTkRWb7SwwgJbqDtQX14=;
        b=Lg1EergQeSAgrtekKNKr2yORJFPBRO7uTkW7s1K1dWsYSrfElajVx33Rt/U+JHBgDP
         AGAgK2jB/i1I/bjB9bUi5kz783zraDvqXIj2/yfsJCx+Sl5zJ6h6O5uy4qdrgdIO0sdH
         RXkWWiAw1s1Q+WCV4qkjAJ9aLEUTtaJ4UPqF+1cotgkYh0Y3tcy6/3cyuCA6BZoh3ImY
         8r6el1sCMkMmJUeuCG20KBODP/3AS16meFtE1DjeA1PDY2A62XBjuswqNgpWdHbxgTfR
         XHg4Xx2XhRVMQZg70HXlJrNv3emEbeQv6c3YUqYtP0SU/GGMD2ogScls+sF25ZbYLhAG
         dZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358037; x=1724962837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4BpYDCBRf3GhJ+JefscMjttTkRWb7SwwgJbqDtQX14=;
        b=LdITwJN67rrTdbE8WzUdqwsNnfRJVsh4A6G/JxhrFyV5oIjA0tpC7RGtRsZ7ejSrIc
         JrsHfPFRJd+dc6nYfG+AeX+KVSyxeyAiTsEjH/fJOum7c/b5FbkNgx/l+NQDWQdMcQsd
         3dIK5gZ0AcWy2GG4rinSrmEGjKsGAgWP6uGc3QCvfjgqAY2PM/yRiYnkmTiMFEGuXzef
         Q2+Cr8T8VLMnlj4Ff4K/4zswLVUpImkDafuTeaZjvZkzOKaBX0Ny9LvvTixqZR5FUMCR
         ZfqrR1pyqtEggMP/pLE9k5L2SKbmQsxamlFljPGhxm9BbKpBf2LBTQyc6vraAYY9ewRe
         Pq1w==
X-Forwarded-Encrypted: i=1; AJvYcCXslocRN3IZEh0f9uhvRrhFBD7dgEm82naMDGSibLALP12PKBxNcahssHRPpriv9SDXkYUj2Z/Fq+QjmlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKd5ugVHr1H7VUDRAe9mTVCEppvDKWgRxZ5GwUgZZmx2qxTeB5
	866pKeMpeEmfZm1ikzzjFBPEgBcmsM0nf8g7xKgoXTEz8aNclYGM8j5KbsdCfM1TBaXMsJ1di0Z
	RgIqqoAH/3aiuZDLYEBMr7YD/mbcRla1nxKVo
X-Google-Smtp-Source: AGHT+IGvYH5gdd4Q+SZLHa/8b3nOfvz1yRofw3F7hT4vkXLiQL5nXUvsI6pXMy1/wquOoEKgKfmfTVpkNd8K1aV3vrY=
X-Received: by 2002:a17:907:9483:b0:a7a:8e98:890d with SMTP id
 a640c23a62f3a-a866f2fe311mr620238566b.16.1724358036265; Thu, 22 Aug 2024
 13:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMgjq7BhpCoPMEkSkCAqWcvTO93KQK4xzn2Av6M0ATkk8YZapg@mail.gmail.com>
 <20240821054921.43468-1-21cnbao@gmail.com> <CAMgjq7Czvr+PXF7Q5eSChAdmiLH-uvd7HTred63T8JPCCYzTSQ@mail.gmail.com>
 <CAJD7tkYxAUVhvb_khBngRg5d504-KYVbW-v=GNfUPR-6_f-rVQ@mail.gmail.com> <CACePvbWN4Tt_gyGRebLQeg8edifNaMLKyKHObTyEqkFCyOj2BA@mail.gmail.com>
In-Reply-To: <CACePvbWN4Tt_gyGRebLQeg8edifNaMLKyKHObTyEqkFCyOj2BA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 22 Aug 2024 13:20:00 -0700
Message-ID: <CAJD7tkbtpyaJxJDk+P_QPBPtnya6AG=SYuhuhZTm+Dqpx_3bxw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 1:16=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Aug 22, 2024 at 11:13=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Tue, Aug 20, 2024 at 11:42=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > On Wed, Aug 21, 2024 at 1:49=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > On Tue, Aug 20, 2024 at 9:02=E2=80=AFPM Kairui Song <ryncsn@gmail.c=
om> wrote:
> > > > >
> > > > > On Tue, Aug 20, 2024 at 4:47=E2=80=AFPM Kairui Song <ryncsn@gmail=
.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 20, 2024 at 4:13=E2=80=AFAM Yosry Ahmed <yosryahmed=
@google.com> wrote:
> > > > > > > On Fri, Aug 16, 2024 at 12:52=E2=80=AFPM syzbot
> > > > > > > <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com> wrote=
:
> > > > > > > >
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > syzbot found the following issue on:
> > > > > > > >
> > > > > > > > HEAD commit:    367b5c3d53e5 Add linux-next specific files =
for 20240816
> > > > > >
> > > > > > I can't find this commit, seems this commit is not in linux-nex=
t any more?
> > > > > >
> > > > > > > > git tree:       linux-next
> > > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=
=3D12489105980000
> > > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=
=3D61ba6f3b22ee5467
> > > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc=
e6029250d7fd4d0476d
> > > > > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Bi=
nutils for Debian) 2.40
> > > > > > > >
> > > > > > > > Unfortunately, I don't have any reproducer for this issue y=
et.
> > > > > > > >
> > > > > > > > Downloadable assets:
> > > > > > > > disk image: https://storage.googleapis.com/syzbot-assets/0b=
1b4e3cad3c/disk-367b5c3d.raw.xz
> > > > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/5bb09=
0f7813c/vmlinux-367b5c3d.xz
> > > > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/=
6674cb0709b1/bzImage-367b5c3d.xz
> > > > > > > >
> > > > > > > > IMPORTANT: if you fix the issue, please add the following t=
ag to the commit:
> > > > > > > > Reported-by: syzbot+ce6029250d7fd4d0476d@syzkaller.appspotm=
ail.com
> > > > > > > >
> > > > > > > > ------------[ cut here ]------------
> > > > > > > > WARNING: CPU: 0 PID: 11298 at mm/zswap.c:1700 zswap_swapoff=
+0x11b/0x2b0 mm/zswap.c:1700
> > > > > > > > Modules linked in:
> > > > > > > > CPU: 0 UID: 0 PID: 11298 Comm: swapoff Not tainted 6.11.0-r=
c3-next-20240816-syzkaller #0
> > > > > > > > Hardware name: Google Google Compute Engine/Google Compute =
Engine, BIOS Google 06/27/2024
> > > > > > > > RIP: 0010:zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
> > > > > > > > Code: 74 05 e8 78 73 07 00 4b 83 7c 35 00 00 75 15 e8 1b bd=
 9e ff 48 ff c5 49 83 c6 50 83 7c 24 0c 17 76 9b eb 24 e8 06 bd 9e ff 90 <0=
f> 0b 90 eb e5 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 7c 90 48 8b 3c
> > > > > > > > RSP: 0018:ffffc9000302fa38 EFLAGS: 00010293
> > > > > > > > RAX: ffffffff81f4d66a RBX: dffffc0000000000 RCX: ffff88802c=
19bc00
> > > > > > > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff888015=
986248
> > > > > > > > RBP: 0000000000000000 R08: ffffffff81f4d620 R09: 1ffffffff1=
d476ac
> > > > > > > > R10: dffffc0000000000 R11: fffffbfff1d476ad R12: dffffc0000=
000000
> > > > > > > > R13: ffff888015986200 R14: 0000000000000048 R15: 0000000000=
000002
> > > > > > > > FS:  00007f9e628a5380(0000) GS:ffff8880b9000000(0000) knlGS=
:0000000000000000
> > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > CR2: 0000001b30f15ff8 CR3: 000000006c5f0000 CR4: 0000000000=
3506f0
> > > > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
> > > > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
> > > > > > > > Call Trace:
> > > > > > > >  <TASK>
> > > > > > > >  __do_sys_swapoff mm/swapfile.c:2837 [inline]
> > > > > > > >  __se_sys_swapoff+0x4653/0x4cf0 mm/swapfile.c:2706
> > > > > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > > > > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > > > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > > > > RIP: 0033:0x7f9e629feb37
> > > > > > > > Code: 73 01 c3 48 8b 0d f1 52 0d 00 f7 d8 64 89 01 48 83 c8=
 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <4=
8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 52 0d 00 f7 d8 64 89 01 48
> > > > > > > > RSP: 002b:00007fff17734f68 EFLAGS: 00000246 ORIG_RAX: 00000=
000000000a8
> > > > > > > > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9e62=
9feb37
> > > > > > > > RDX: 00007f9e62a9e7e8 RSI: 00007f9e62b9beed RDI: 0000563090=
942a20
> > > > > > > > RBP: 0000563090942a20 R08: 0000000000000000 R09: 77872e07ed=
164f94
> > > > > > > > R10: 000000000000001f R11: 0000000000000246 R12: 00007fff17=
735188
> > > > > > > > R13: 00005630909422a0 R14: 0000563073724169 R15: 00007f9e62=
bdda80
> > > > > > > >  </TASK>
> > > > > > >
> > > > > > > I am hoping syzbot would find a reproducer and bisect this fo=
r us.
> > > > > > > Meanwhile, from a high-level it looks to me like we are missi=
ng a
> > > > > > > zswap_invalidate() call in some paths.
> > > > > > >
> > > > > > > If I have to guess, I would say it's related to the latest mT=
HP swap
> > > > > > > changes, but I am not following closely. Perhaps one of the f=
ollowing
> > > > > > > things happened:
> > > > > > >
> > > > > > > (1) We are not calling zswap_invalidate() in some invalidatio=
n paths.
> > > > > > > It used to not be called for the cluster freeing path, so may=
be we end
> > > > > > > up with some order-0 swap entries in a cluster? or maybe ther=
e is an
> > > > > > > entirely new invalidation path that does not go through
> > > > > > > free_swap_slot() for order-0 entries?
> > > > > > >
> > > > > > > (2) Some higher order swap entries (i.e. a cluster) end up in=
 zswap
> > > > > > > somehow. zswap_store() has a warning to cover that though. Ma=
ybe
> > > > > > > somehow some swap entries are allocated as a cluster, but the=
n pages
> > > > > > > are swapped out one-by-one as order-0 (which can go to zswap)=
, but
> > > > > > > then we still free the swap entries as a cluster?
> > > > > >
> > > > > > Hi Yosry, thanks for the report.
> > > > > >
> > > > > > There are many mTHP related optimizations recently, for this pr=
oblem I
> > > > > > can reproduce this locally. Can confirm the problem is gone for=
 me
> > > > > > after reverting:
> > > > > >
> > > > > > "mm: attempt to batch free swap entries for zap_pte_range()"
> > > > > >
> > > > > > Hi Barry,
> > > > > >
> > > > > > If a set of continuous slots are having the same value, they ar=
e
> > > > > > considered a mTHP and freed, bypassing the slot cache, and caus=
ing
> > > > > > zswap leak.
> > > > > > This didn't happen in put_swap_folio because that function is
> > > > > > expecting an actual mTHP folio behind the slots but
> > > > > > free_swap_and_cache_nr is simply walking the slots.
> > > > > >
> > > > > > For the testing, I actually have to disable mTHP, because linux=
-next
> > > > > > will panic with mTHP due to lack of following fixes:
> > > > > > https://lore.kernel.org/linux-mm/a4b1b34f-0d8c-490d-ab00-eaedbf=
3fe780@gmail.com/
> > > > > > https://lore.kernel.org/linux-mm/403b7f3c-6e5b-4030-ab1c-3198f3=
6e3f73@gmail.com/
> > > > > >
> > > > > > >
> > > > > > > I am not closely following the latest changes so I am not sur=
e. CCing
> > > > > > > folks who have done work in that area recently.
> > > > > > >
> > > > > > > I am starting to think maybe it would be more reliable to jus=
t call
> > > > > > > zswap_invalidate() for all freed swap entries anyway. Would t=
hat be
> > > > > > > too expensive? We used to do that before the zswap_invalidate=
() call
> > > > > > > was moved by commit 0827a1fb143f ("mm/zswap: invalidate zswap=
 entry
> > > > > > > when swap entry free"), and that was before we started using =
the
> > > > > > > xarray (so it was arguably worse than it would be now).
> > > > > > >
> > > > > >
> > > > > > That might be a good idea, I suggest moving zswap_invalidate to
> > > > > > swap_range_free and call it for every freed slot.
> > > > > >
> > > > > > Below patch can be squash into or put before "mm: attempt to ba=
tch
> > > > > > free swap entries for zap_pte_range()".
> > > > >
> > > > > Hmm, on second thought, the commit message in the attachment comm=
it
> > > > > might be not suitable, current zswap_invalidate is also designed =
to
> > > > > only work for order 0 ZSWAP, so things are not clean even after t=
his.
> > > >
> > > > Kairui, what about the below? we don't touch the path of __try_to_r=
eclaim_swap() where
> > > > you have one folio backed?
> > > >
> > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > index c1638a009113..8ff58be40544 100644
> > > > --- a/mm/swapfile.c
> > > > +++ b/mm/swapfile.c
> > > > @@ -1514,6 +1514,8 @@ static bool __swap_entries_free(struct swap_i=
nfo_struct *si,
> > > >         unlock_cluster_or_swap_info(si, ci);
> > > >
> > > >         if (!has_cache) {
> > > > +               for (i =3D 0; i < nr; i++)
> > > > +                       zswap_invalidate(swp_entry(si->type, offset=
 + i));
> > > >                 spin_lock(&si->lock);
> > > >                 swap_entry_range_free(si, entry, nr);
> > > >                 spin_unlock(&si->lock);
> > > >
> > >
> > > Hi Barry,
> > >
> > > Thanks for updating this thread, I'm thinking maybe something will
> > > better be done at the zswap side?
> > >
> > > The concern of using zswap_invalidate is that it calls xa_erase which
> > > requires the xa spin lock. But if we are calling zswap_invalidate in
> > > swap_entry_range_free, and ensure the slot is HAS_CACHE pinned, doing
> > > a lockless read first with xa_load should be OK for checking if the
> > > slot needs a ZSWAP invalidation. The performance cost will be minimal
> > > and we only need to call zswap_invalidate in one place, something lik=
e
> > > this (haven't tested, comments are welcome). Also ZSWAP mthp will
> > > still store entried in order 0 so this should be OK for future.
> >
> >
> > While I do agree with this change on a high level, it's essentially
> > reverting commit 0827a1fb143f ("mm/zswap: invalidate zswap entry when
> > swap entry free") which fixed a small problem with zswap writeback.
> > I'd prefer that we don't if possible.
> >
> > One thing that I always wanted to do is to pull some of the work done
> > in swap_entry_range_free() and swap_range_free() before the slots
> > caching layer. The memcg uncharging, clearing shadow entries from the
> > swap cache, arch invalidation, zswap invalidation, etc. If we can have
> > a hook for these pre-free callbacks we can call it for single entries
> > before we add them to the slots cache, and call them for the clusters
> > as we do today. This should also reduce the amount of work done under
> > the lock, and move more work to where the freeing is actually
> > happening vs. the cache draining.
> >
> > I remember discussing this briefly with Ying before. Anyone have any th=
oughts?
>
> Hi Yosry,
>
> If I understand correctly, the lock you are talking about is the
> si->lock, right?
>
> Kairui has some WIP patches removing the swap slot cache in the swap
> entry freeing path. Basically the si->lock is only used to protect the
> cluster list. Most of the time freeing swap entry will only take the
> ci->lock. No need to take the si->lock to change the cluster lists.
> Only when the cluster moves to another list will it require the
> si->lock e.g. the cluster moves to the free list when all 512 entries
> are freed. Because each cluster has 512 entries. The need to take
> si->lock is dramatically reduced. That patch is based on the new
> cluster swap allocator series. Kairui can share more details.
>
> I don't think ci->lock has heavy contentions.

Thanks for sharing these details. However, I think we should still
pull the irrelevant logic from swap_entry_range_free() and
swap_range_free() before the slots cache layer. There is no reason to
defer this work until we drain the cache, and whoever ends up draining
the cache ends up paying for all the work of previously freed slots.

In the zswap case, deferring the invalidation causes a problem, which
is why we moved it to free_swap_slot(). However, now with the mTHP
changes more freeing paths are being added and it's easy to miss
invalidating zswap in every case, so I think we need a more
centralized place to execute pre-free hooks, and call it before the
swap slots cache.

>
> Chris

