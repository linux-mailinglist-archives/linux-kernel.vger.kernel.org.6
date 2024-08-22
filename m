Return-Path: <linux-kernel+bounces-298011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF32395C068
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 23:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8E3285589
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBF71D174E;
	Thu, 22 Aug 2024 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIrGhVwH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABEA933
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724363065; cv=none; b=fgcH6sJdLrfYb4XknbeokPdjIktvS90sL02nwtYOdS5RUIvQVNXf5AaCdPbFE88RKXQ+lGJgtwwONJxyfgRoL1pyotq0SoRerlBtKQMzYxVtlanyzc00CruVibwn+5cEqhJKMpQkJM7y3qkVWWBbP3MVIfx3idUJNPnMvJlRnY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724363065; c=relaxed/simple;
	bh=l6MDzDSxjK3eqrPNj88AHYnZuJiGyQ+DBTYKeBKOfqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMU95NNQyOyo4t/nbYBnglb4CfCCwCqJHRFTmt++F4A/F6FzPES5qzQfeDpCO7iiMkI37QHWj/VvbMccWtz65WuSYpTM7DxbmhfB43bkrbXNy9V1U42G0+udllNzC5MBZ6PiytEJvYVJdh0133lG1qql0sBRqUdasZLMoCpBYGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIrGhVwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21232C4AF10
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 21:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724363064;
	bh=l6MDzDSxjK3eqrPNj88AHYnZuJiGyQ+DBTYKeBKOfqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RIrGhVwHu/kYT02AXOfQNjjgJ/AlwKFNOGtsd5A066y6kTPUJ77FxHGM9mZjuuVsg
	 5EP7n+1NbD1m0xERXFCT7UR41m/z9NoPpYuCNMWIcftxs68c5jirbXGI0GPUSjkoqs
	 jT7DwPSYVQSJo50dycF72mDDeERZlGcS50QVnaw548H23u2gGdmst0ufkK3/qUVCiC
	 +MkmQORp2PTH3mageSYNCAT2nUa8m+PCGV3kfztg51EHvuDCE/a7bg34FP4MR9eC9+
	 FeuOQqDhLaOqsHjxN67I1SEPG16QJGStCqPOqe7dOCEWINLpBA17zy8DhhgSjyZrg8
	 6gnHcmTKbNVfg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-691c85525ebso12423797b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:44:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhd0uUiuQmTBGujEoUa0+lAq7YqqzWVgbp5GD1EdqYZbAKoYQZMwKuq3IxK6KLCRZ6BBw+jm4MpmTHx2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xInO6IjEnkw5x4y/hq/Vfm2lz9M/XAwXL+p7xG+YfUJpd6Ys
	UbQO0306nqfGZQsx+hTPu7sbz8UyzZskQkycrXWPXTffJb4ITpzu1npCNIdr+aSNWayYdebq/cV
	ZKhQaFDFGIwaDo0NOax5a1PXTVcZAQM6iLzWWUw==
X-Google-Smtp-Source: AGHT+IGhAOYERX1OENo3qWa4X6beB7NWFIGiQpEtPKiWE4UuwwKrqlsFaBTNDIgI5x2kfYx0/SnflSTECj6vYTgPMHM=
X-Received: by 2002:a05:690c:3187:b0:664:8646:4d02 with SMTP id
 00721157ae682-6c6251a4944mr2215347b3.12.1724363063370; Thu, 22 Aug 2024
 14:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMgjq7BhpCoPMEkSkCAqWcvTO93KQK4xzn2Av6M0ATkk8YZapg@mail.gmail.com>
 <20240821054921.43468-1-21cnbao@gmail.com> <CAMgjq7Czvr+PXF7Q5eSChAdmiLH-uvd7HTred63T8JPCCYzTSQ@mail.gmail.com>
 <CAJD7tkYxAUVhvb_khBngRg5d504-KYVbW-v=GNfUPR-6_f-rVQ@mail.gmail.com>
 <CACePvbWN4Tt_gyGRebLQeg8edifNaMLKyKHObTyEqkFCyOj2BA@mail.gmail.com> <CAJD7tkbtpyaJxJDk+P_QPBPtnya6AG=SYuhuhZTm+Dqpx_3bxw@mail.gmail.com>
In-Reply-To: <CAJD7tkbtpyaJxJDk+P_QPBPtnya6AG=SYuhuhZTm+Dqpx_3bxw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 22 Aug 2024 14:44:12 -0700
X-Gmail-Original-Message-ID: <CACePvbX=fQ0uHr_76FF6M8_nAajyk=Epbtky-E3uuETquaoMdg@mail.gmail.com>
Message-ID: <CACePvbX=fQ0uHr_76FF6M8_nAajyk=Epbtky-E3uuETquaoMdg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kairui Song <ryncsn@gmail.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 1:20=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Aug 22, 2024 at 1:16=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > On Thu, Aug 22, 2024 at 11:13=E2=80=AFAM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > >
> > > On Tue, Aug 20, 2024 at 11:42=E2=80=AFPM Kairui Song <ryncsn@gmail.co=
m> wrote:
> > > >
> > > > On Wed, Aug 21, 2024 at 1:49=E2=80=AFPM Barry Song <21cnbao@gmail.c=
om> wrote:
> > > > >
> > > > > On Tue, Aug 20, 2024 at 9:02=E2=80=AFPM Kairui Song <ryncsn@gmail=
.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 20, 2024 at 4:47=E2=80=AFPM Kairui Song <ryncsn@gma=
il.com> wrote:
> > > > > > >
> > > > > > > On Tue, Aug 20, 2024 at 4:13=E2=80=AFAM Yosry Ahmed <yosryahm=
ed@google.com> wrote:
> > > > > > > > On Fri, Aug 16, 2024 at 12:52=E2=80=AFPM syzbot
> > > > > > > > <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com> wro=
te:
> > > > > > > > >
> > > > > > > > > Hello,
> > > > > > > > >
> > > > > > > > > syzbot found the following issue on:
> > > > > > > > >
> > > > > > > > > HEAD commit:    367b5c3d53e5 Add linux-next specific file=
s for 20240816
> > > > > > >
> > > > > > > I can't find this commit, seems this commit is not in linux-n=
ext any more?
> > > > > > >
> > > > > > > > > git tree:       linux-next
> > > > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=
=3D12489105980000
> > > > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=
=3D61ba6f3b22ee5467
> > > > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=
=3Dce6029250d7fd4d0476d
> > > > > > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU =
Binutils for Debian) 2.40
> > > > > > > > >
> > > > > > > > > Unfortunately, I don't have any reproducer for this issue=
 yet.
> > > > > > > > >
> > > > > > > > > Downloadable assets:
> > > > > > > > > disk image: https://storage.googleapis.com/syzbot-assets/=
0b1b4e3cad3c/disk-367b5c3d.raw.xz
> > > > > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/5bb=
090f7813c/vmlinux-367b5c3d.xz
> > > > > > > > > kernel image: https://storage.googleapis.com/syzbot-asset=
s/6674cb0709b1/bzImage-367b5c3d.xz
> > > > > > > > >
> > > > > > > > > IMPORTANT: if you fix the issue, please add the following=
 tag to the commit:
> > > > > > > > > Reported-by: syzbot+ce6029250d7fd4d0476d@syzkaller.appspo=
tmail.com
> > > > > > > > >
> > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > WARNING: CPU: 0 PID: 11298 at mm/zswap.c:1700 zswap_swapo=
ff+0x11b/0x2b0 mm/zswap.c:1700
> > > > > > > > > Modules linked in:
> > > > > > > > > CPU: 0 UID: 0 PID: 11298 Comm: swapoff Not tainted 6.11.0=
-rc3-next-20240816-syzkaller #0
> > > > > > > > > Hardware name: Google Google Compute Engine/Google Comput=
e Engine, BIOS Google 06/27/2024
> > > > > > > > > RIP: 0010:zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
> > > > > > > > > Code: 74 05 e8 78 73 07 00 4b 83 7c 35 00 00 75 15 e8 1b =
bd 9e ff 48 ff c5 49 83 c6 50 83 7c 24 0c 17 76 9b eb 24 e8 06 bd 9e ff 90 =
<0f> 0b 90 eb e5 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 7c 90 48 8b 3c
> > > > > > > > > RSP: 0018:ffffc9000302fa38 EFLAGS: 00010293
> > > > > > > > > RAX: ffffffff81f4d66a RBX: dffffc0000000000 RCX: ffff8880=
2c19bc00
> > > > > > > > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff8880=
15986248
> > > > > > > > > RBP: 0000000000000000 R08: ffffffff81f4d620 R09: 1fffffff=
f1d476ac
> > > > > > > > > R10: dffffc0000000000 R11: fffffbfff1d476ad R12: dffffc00=
00000000
> > > > > > > > > R13: ffff888015986200 R14: 0000000000000048 R15: 00000000=
00000002
> > > > > > > > > FS:  00007f9e628a5380(0000) GS:ffff8880b9000000(0000) knl=
GS:0000000000000000
> > > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > > CR2: 0000001b30f15ff8 CR3: 000000006c5f0000 CR4: 00000000=
003506f0
> > > > > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
> > > > > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
> > > > > > > > > Call Trace:
> > > > > > > > >  <TASK>
> > > > > > > > >  __do_sys_swapoff mm/swapfile.c:2837 [inline]
> > > > > > > > >  __se_sys_swapoff+0x4653/0x4cf0 mm/swapfile.c:2706
> > > > > > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > > > > > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > > > > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > > > > > RIP: 0033:0x7f9e629feb37
> > > > > > > > > Code: 73 01 c3 48 8b 0d f1 52 0d 00 f7 d8 64 89 01 48 83 =
c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 =
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 52 0d 00 f7 d8 64 89 01 48
> > > > > > > > > RSP: 002b:00007fff17734f68 EFLAGS: 00000246 ORIG_RAX: 000=
00000000000a8
> > > > > > > > > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9e=
629feb37
> > > > > > > > > RDX: 00007f9e62a9e7e8 RSI: 00007f9e62b9beed RDI: 00005630=
90942a20
> > > > > > > > > RBP: 0000563090942a20 R08: 0000000000000000 R09: 77872e07=
ed164f94
> > > > > > > > > R10: 000000000000001f R11: 0000000000000246 R12: 00007fff=
17735188
> > > > > > > > > R13: 00005630909422a0 R14: 0000563073724169 R15: 00007f9e=
62bdda80
> > > > > > > > >  </TASK>
> > > > > > > >
> > > > > > > > I am hoping syzbot would find a reproducer and bisect this =
for us.
> > > > > > > > Meanwhile, from a high-level it looks to me like we are mis=
sing a
> > > > > > > > zswap_invalidate() call in some paths.
> > > > > > > >
> > > > > > > > If I have to guess, I would say it's related to the latest =
mTHP swap
> > > > > > > > changes, but I am not following closely. Perhaps one of the=
 following
> > > > > > > > things happened:
> > > > > > > >
> > > > > > > > (1) We are not calling zswap_invalidate() in some invalidat=
ion paths.
> > > > > > > > It used to not be called for the cluster freeing path, so m=
aybe we end
> > > > > > > > up with some order-0 swap entries in a cluster? or maybe th=
ere is an
> > > > > > > > entirely new invalidation path that does not go through
> > > > > > > > free_swap_slot() for order-0 entries?
> > > > > > > >
> > > > > > > > (2) Some higher order swap entries (i.e. a cluster) end up =
in zswap
> > > > > > > > somehow. zswap_store() has a warning to cover that though. =
Maybe
> > > > > > > > somehow some swap entries are allocated as a cluster, but t=
hen pages
> > > > > > > > are swapped out one-by-one as order-0 (which can go to zswa=
p), but
> > > > > > > > then we still free the swap entries as a cluster?
> > > > > > >
> > > > > > > Hi Yosry, thanks for the report.
> > > > > > >
> > > > > > > There are many mTHP related optimizations recently, for this =
problem I
> > > > > > > can reproduce this locally. Can confirm the problem is gone f=
or me
> > > > > > > after reverting:
> > > > > > >
> > > > > > > "mm: attempt to batch free swap entries for zap_pte_range()"
> > > > > > >
> > > > > > > Hi Barry,
> > > > > > >
> > > > > > > If a set of continuous slots are having the same value, they =
are
> > > > > > > considered a mTHP and freed, bypassing the slot cache, and ca=
using
> > > > > > > zswap leak.
> > > > > > > This didn't happen in put_swap_folio because that function is
> > > > > > > expecting an actual mTHP folio behind the slots but
> > > > > > > free_swap_and_cache_nr is simply walking the slots.
> > > > > > >
> > > > > > > For the testing, I actually have to disable mTHP, because lin=
ux-next
> > > > > > > will panic with mTHP due to lack of following fixes:
> > > > > > > https://lore.kernel.org/linux-mm/a4b1b34f-0d8c-490d-ab00-eaed=
bf3fe780@gmail.com/
> > > > > > > https://lore.kernel.org/linux-mm/403b7f3c-6e5b-4030-ab1c-3198=
f36e3f73@gmail.com/
> > > > > > >
> > > > > > > >
> > > > > > > > I am not closely following the latest changes so I am not s=
ure. CCing
> > > > > > > > folks who have done work in that area recently.
> > > > > > > >
> > > > > > > > I am starting to think maybe it would be more reliable to j=
ust call
> > > > > > > > zswap_invalidate() for all freed swap entries anyway. Would=
 that be
> > > > > > > > too expensive? We used to do that before the zswap_invalida=
te() call
> > > > > > > > was moved by commit 0827a1fb143f ("mm/zswap: invalidate zsw=
ap entry
> > > > > > > > when swap entry free"), and that was before we started usin=
g the
> > > > > > > > xarray (so it was arguably worse than it would be now).
> > > > > > > >
> > > > > > >
> > > > > > > That might be a good idea, I suggest moving zswap_invalidate =
to
> > > > > > > swap_range_free and call it for every freed slot.
> > > > > > >
> > > > > > > Below patch can be squash into or put before "mm: attempt to =
batch
> > > > > > > free swap entries for zap_pte_range()".
> > > > > >
> > > > > > Hmm, on second thought, the commit message in the attachment co=
mmit
> > > > > > might be not suitable, current zswap_invalidate is also designe=
d to
> > > > > > only work for order 0 ZSWAP, so things are not clean even after=
 this.
> > > > >
> > > > > Kairui, what about the below? we don't touch the path of __try_to=
_reclaim_swap() where
> > > > > you have one folio backed?
> > > > >
> > > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > > index c1638a009113..8ff58be40544 100644
> > > > > --- a/mm/swapfile.c
> > > > > +++ b/mm/swapfile.c
> > > > > @@ -1514,6 +1514,8 @@ static bool __swap_entries_free(struct swap=
_info_struct *si,
> > > > >         unlock_cluster_or_swap_info(si, ci);
> > > > >
> > > > >         if (!has_cache) {
> > > > > +               for (i =3D 0; i < nr; i++)
> > > > > +                       zswap_invalidate(swp_entry(si->type, offs=
et + i));
> > > > >                 spin_lock(&si->lock);
> > > > >                 swap_entry_range_free(si, entry, nr);
> > > > >                 spin_unlock(&si->lock);
> > > > >
> > > >
> > > > Hi Barry,
> > > >
> > > > Thanks for updating this thread, I'm thinking maybe something will
> > > > better be done at the zswap side?
> > > >
> > > > The concern of using zswap_invalidate is that it calls xa_erase whi=
ch
> > > > requires the xa spin lock. But if we are calling zswap_invalidate i=
n
> > > > swap_entry_range_free, and ensure the slot is HAS_CACHE pinned, doi=
ng
> > > > a lockless read first with xa_load should be OK for checking if the
> > > > slot needs a ZSWAP invalidation. The performance cost will be minim=
al
> > > > and we only need to call zswap_invalidate in one place, something l=
ike
> > > > this (haven't tested, comments are welcome). Also ZSWAP mthp will
> > > > still store entried in order 0 so this should be OK for future.
> > >
> > >
> > > While I do agree with this change on a high level, it's essentially
> > > reverting commit 0827a1fb143f ("mm/zswap: invalidate zswap entry when
> > > swap entry free") which fixed a small problem with zswap writeback.
> > > I'd prefer that we don't if possible.
> > >
> > > One thing that I always wanted to do is to pull some of the work done
> > > in swap_entry_range_free() and swap_range_free() before the slots
> > > caching layer. The memcg uncharging, clearing shadow entries from the
> > > swap cache, arch invalidation, zswap invalidation, etc. If we can hav=
e
> > > a hook for these pre-free callbacks we can call it for single entries
> > > before we add them to the slots cache, and call them for the clusters
> > > as we do today. This should also reduce the amount of work done under
> > > the lock, and move more work to where the freeing is actually
> > > happening vs. the cache draining.
> > >
> > > I remember discussing this briefly with Ying before. Anyone have any =
thoughts?
> >
> > Hi Yosry,
> >
> > If I understand correctly, the lock you are talking about is the
> > si->lock, right?
> >
> > Kairui has some WIP patches removing the swap slot cache in the swap
> > entry freeing path. Basically the si->lock is only used to protect the
> > cluster list. Most of the time freeing swap entry will only take the
> > ci->lock. No need to take the si->lock to change the cluster lists.
> > Only when the cluster moves to another list will it require the
> > si->lock e.g. the cluster moves to the free list when all 512 entries
> > are freed. Because each cluster has 512 entries. The need to take
> > si->lock is dramatically reduced. That patch is based on the new
> > cluster swap allocator series. Kairui can share more details.
> >
> > I don't think ci->lock has heavy contentions.
>
> Thanks for sharing these details. However, I think we should still
> pull the irrelevant logic from swap_entry_range_free() and
> swap_range_free() before the slots cache layer. There is no reason to
> defer this work until we drain the cache, and whoever ends up draining
> the cache ends up paying for all the work of previously freed slots.

Sounds like a good idea from a high-level point of view. It will
likely reduce the complexity of freeing the swap entries as well.
Again, the devil is in the details. Likely need to see the patch to
reason it in more detail.

Chris

