Return-Path: <linux-kernel+bounces-295983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C595A3F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2241F22511
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A651B2EC0;
	Wed, 21 Aug 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvVZNqaV"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB914E2CB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261621; cv=none; b=fk0MzGQd5mYtD4d4QKt47s+ST2ILmVAuBpawYGb1Y0peXf/G024zAAkT2F5j8k+2ArGlwG9r96+n7WK4sqVUYqnqKj/wx1oeYE0mEV9WR0EtJlKzIyRh1xqZS1N8I5HF7zy4hTf/JQGjtDaNSoFuF9rIb6tPasnrtW/cuKfYKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261621; c=relaxed/simple;
	bh=6c6mfCa4P5FdgYey1tS34B4lFtvxGdcTwD+2g2Gc1TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cpq8nWVQZ5jYLlq29M4DzRmHRnnE/PH9PpEiwL65SMF8Uqm8OROaWdBTBvZsXbUamgiXa5acXY5Fq6w9PnugCIRSVKLidu6AlSohqaF0F+82MH0tWbFEt2zOUPl9goPl3o6IZrPVCtEmYhnS8dNvsljy1FvdaAE+2qbYD3usNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvVZNqaV; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f15790b472so82151491fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724261617; x=1724866417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG0L7T5brrgf/dB5io/VhqVeNovJfBpdXV92+QwYVhk=;
        b=ZvVZNqaVExV00dfgB3+pQVjEN3l98u2MCvmPxdae64OromgU+zWdbN6aC78qI9FXaU
         P5chyYGBsye26Mz2w11otban/1XcInZ7IrfR8IfiPcUiAns47XQAmEBdPvScWdPlU32a
         hcFEUrimo/4T+KbkPPO12ycmm8G/+v9kMvZbbCIoMyjtYKUUx0vpwIEI94IZrCB6jnFd
         MZwfH1OBWyAkgGBh/8JNbKWFR6rY8Frjyov2vQgd6eHApTzPoBrOFel0KEwRPFD2vPOc
         1Wch7hj+nIKAwYP6ejCd9hlwtRghKKmvcPU/M7Uqe25q1S4A5n+9qmYow42TjbUCJ9BU
         O6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724261617; x=1724866417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DG0L7T5brrgf/dB5io/VhqVeNovJfBpdXV92+QwYVhk=;
        b=AO/o0rdc4DVbmPMn4lSzEsqvXL0DJKnEaZm127N052IPRW8qaCiZtvdX8jMNG+b0HS
         XlE0++6yigTxL8YqXcDogeZvgrZ7f26XoZz1hHnhk7vJDBPJqjSAiOsv8uHPBfUswFMC
         /GbQk1rQ1HsiymVjpJ1JrMup7Y1cOQa/laFarJb5kNilO+s3qGFhTFa+diSzzmERQ6Km
         IFt0fGcNhQvI15e0LvLEH0TPRz/d615lsOQ/oVTSTXqbxg/MbxnsUInwawolJwlqDWO7
         nGAH19tX6HhJGW5DkzkMAitVAv++ikSAkQCQsIEwxz2IUe3ZfTjxxuoBtsyGBrQi20jb
         mFIg==
X-Forwarded-Encrypted: i=1; AJvYcCUAvtHs4NmK43FSV3hv9nWNcValN6BIOJAclLQbJPWZD/0819kouJ01vIHjEaGzbu56V9ipvBxBKVDJUtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/idSy2bPis2ZAyUToLWVC6NMx5Tvtk1BE5PuKpjs7u+G8kGVG
	aQr8PsG22k1DU3H8aWpCKf//qBoucBynuEXrzttvVQnesBZA8ASm5JgAEMOB4ep+P3qXcAaPV5T
	UT1QegBrBfezB+Q/OvAYFiBaaII4=
X-Google-Smtp-Source: AGHT+IFWPNhCHah7os4XbDKAleEQ689Y4y3I54uQ4GN2e4UDpyKKHKkIseA2Bt+2txREZkcu2+n9O4YLv7xDh7yP/Ig=
X-Received: by 2002:a2e:bc1f:0:b0:2f3:f441:af1a with SMTP id
 38308e7fff4ca-2f3f89527ffmr20247231fa.42.1724261616697; Wed, 21 Aug 2024
 10:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMgjq7BhpCoPMEkSkCAqWcvTO93KQK4xzn2Av6M0ATkk8YZapg@mail.gmail.com>
 <20240821054921.43468-1-21cnbao@gmail.com> <CAMgjq7Czvr+PXF7Q5eSChAdmiLH-uvd7HTred63T8JPCCYzTSQ@mail.gmail.com>
 <CAGsJ_4xkzWY3qpi=hq7uexkaSYW0WSKxVShVNywZJ7GVWY=t4A@mail.gmail.com>
In-Reply-To: <CAGsJ_4xkzWY3qpi=hq7uexkaSYW0WSKxVShVNywZJ7GVWY=t4A@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 22 Aug 2024 01:33:19 +0800
Message-ID: <CAMgjq7BX3cTP1aWJWAnJtwVmK5J87juh42gmVG_qPsPfRb1Kgw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, ryan.roberts@arm.com, 
	syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@intel.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 3:38=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Aug 21, 2024 at 6:42=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Wed, Aug 21, 2024 at 1:49=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Tue, Aug 20, 2024 at 9:02=E2=80=AFPM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > On Tue, Aug 20, 2024 at 4:47=E2=80=AFPM Kairui Song <ryncsn@gmail.c=
om> wrote:
> > > > >
> > > > > On Tue, Aug 20, 2024 at 4:13=E2=80=AFAM Yosry Ahmed <yosryahmed@g=
oogle.com> wrote:
> > > > > > On Fri, Aug 16, 2024 at 12:52=E2=80=AFPM syzbot
> > > > > > <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > syzbot found the following issue on:
> > > > > > >
> > > > > > > HEAD commit:    367b5c3d53e5 Add linux-next specific files fo=
r 20240816
> > > > >
> > > > > I can't find this commit, seems this commit is not in linux-next =
any more?
> > > > >
> > > > > > > git tree:       linux-next
> > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1=
2489105980000
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6=
1ba6f3b22ee5467
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dce6=
029250d7fd4d0476d
> > > > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binu=
tils for Debian) 2.40
> > > > > > >
> > > > > > > Unfortunately, I don't have any reproducer for this issue yet=
.
> > > > > > >
> > > > > > > Downloadable assets:
> > > > > > > disk image: https://storage.googleapis.com/syzbot-assets/0b1b=
4e3cad3c/disk-367b5c3d.raw.xz
> > > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f=
7813c/vmlinux-367b5c3d.xz
> > > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/66=
74cb0709b1/bzImage-367b5c3d.xz
> > > > > > >
> > > > > > > IMPORTANT: if you fix the issue, please add the following tag=
 to the commit:
> > > > > > > Reported-by: syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmai=
l.com
> > > > > > >
> > > > > > > ------------[ cut here ]------------
> > > > > > > WARNING: CPU: 0 PID: 11298 at mm/zswap.c:1700 zswap_swapoff+0=
x11b/0x2b0 mm/zswap.c:1700
> > > > > > > Modules linked in:
> > > > > > > CPU: 0 UID: 0 PID: 11298 Comm: swapoff Not tainted 6.11.0-rc3=
-next-20240816-syzkaller #0
> > > > > > > Hardware name: Google Google Compute Engine/Google Compute En=
gine, BIOS Google 06/27/2024
> > > > > > > RIP: 0010:zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
> > > > > > > Code: 74 05 e8 78 73 07 00 4b 83 7c 35 00 00 75 15 e8 1b bd 9=
e ff 48 ff c5 49 83 c6 50 83 7c 24 0c 17 76 9b eb 24 e8 06 bd 9e ff 90 <0f>=
 0b 90 eb e5 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 7c 90 48 8b 3c
> > > > > > > RSP: 0018:ffffc9000302fa38 EFLAGS: 00010293
> > > > > > > RAX: ffffffff81f4d66a RBX: dffffc0000000000 RCX: ffff88802c19=
bc00
> > > > > > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88801598=
6248
> > > > > > > RBP: 0000000000000000 R08: ffffffff81f4d620 R09: 1ffffffff1d4=
76ac
> > > > > > > R10: dffffc0000000000 R11: fffffbfff1d476ad R12: dffffc000000=
0000
> > > > > > > R13: ffff888015986200 R14: 0000000000000048 R15: 000000000000=
0002
> > > > > > > FS:  00007f9e628a5380(0000) GS:ffff8880b9000000(0000) knlGS:0=
000000000000000
> > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > CR2: 0000001b30f15ff8 CR3: 000000006c5f0000 CR4: 000000000035=
06f0
> > > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000=
0000
> > > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000000=
0400
> > > > > > > Call Trace:
> > > > > > >  <TASK>
> > > > > > >  __do_sys_swapoff mm/swapfile.c:2837 [inline]
> > > > > > >  __se_sys_swapoff+0x4653/0x4cf0 mm/swapfile.c:2706
> > > > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > > > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > > > RIP: 0033:0x7f9e629feb37
> > > > > > > Code: 73 01 c3 48 8b 0d f1 52 0d 00 f7 d8 64 89 01 48 83 c8 f=
f c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <48>=
 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 52 0d 00 f7 d8 64 89 01 48
> > > > > > > RSP: 002b:00007fff17734f68 EFLAGS: 00000246 ORIG_RAX: 0000000=
0000000a8
> > > > > > > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9e629f=
eb37
> > > > > > > RDX: 00007f9e62a9e7e8 RSI: 00007f9e62b9beed RDI: 000056309094=
2a20
> > > > > > > RBP: 0000563090942a20 R08: 0000000000000000 R09: 77872e07ed16=
4f94
> > > > > > > R10: 000000000000001f R11: 0000000000000246 R12: 00007fff1773=
5188
> > > > > > > R13: 00005630909422a0 R14: 0000563073724169 R15: 00007f9e62bd=
da80
> > > > > > >  </TASK>
> > > > > >
> > > > > > I am hoping syzbot would find a reproducer and bisect this for =
us.
> > > > > > Meanwhile, from a high-level it looks to me like we are missing=
 a
> > > > > > zswap_invalidate() call in some paths.
> > > > > >
> > > > > > If I have to guess, I would say it's related to the latest mTHP=
 swap
> > > > > > changes, but I am not following closely. Perhaps one of the fol=
lowing
> > > > > > things happened:
> > > > > >
> > > > > > (1) We are not calling zswap_invalidate() in some invalidation =
paths.
> > > > > > It used to not be called for the cluster freeing path, so maybe=
 we end
> > > > > > up with some order-0 swap entries in a cluster? or maybe there =
is an
> > > > > > entirely new invalidation path that does not go through
> > > > > > free_swap_slot() for order-0 entries?
> > > > > >
> > > > > > (2) Some higher order swap entries (i.e. a cluster) end up in z=
swap
> > > > > > somehow. zswap_store() has a warning to cover that though. Mayb=
e
> > > > > > somehow some swap entries are allocated as a cluster, but then =
pages
> > > > > > are swapped out one-by-one as order-0 (which can go to zswap), =
but
> > > > > > then we still free the swap entries as a cluster?
> > > > >
> > > > > Hi Yosry, thanks for the report.
> > > > >
> > > > > There are many mTHP related optimizations recently, for this prob=
lem I
> > > > > can reproduce this locally. Can confirm the problem is gone for m=
e
> > > > > after reverting:
> > > > >
> > > > > "mm: attempt to batch free swap entries for zap_pte_range()"
> > > > >
> > > > > Hi Barry,
> > > > >
> > > > > If a set of continuous slots are having the same value, they are
> > > > > considered a mTHP and freed, bypassing the slot cache, and causin=
g
> > > > > zswap leak.
> > > > > This didn't happen in put_swap_folio because that function is
> > > > > expecting an actual mTHP folio behind the slots but
> > > > > free_swap_and_cache_nr is simply walking the slots.
> > > > >
> > > > > For the testing, I actually have to disable mTHP, because linux-n=
ext
> > > > > will panic with mTHP due to lack of following fixes:
> > > > > https://lore.kernel.org/linux-mm/a4b1b34f-0d8c-490d-ab00-eaedbf3f=
e780@gmail.com/
> > > > > https://lore.kernel.org/linux-mm/403b7f3c-6e5b-4030-ab1c-3198f36e=
3f73@gmail.com/
> > > > >
> > > > > >
> > > > > > I am not closely following the latest changes so I am not sure.=
 CCing
> > > > > > folks who have done work in that area recently.
> > > > > >
> > > > > > I am starting to think maybe it would be more reliable to just =
call
> > > > > > zswap_invalidate() for all freed swap entries anyway. Would tha=
t be
> > > > > > too expensive? We used to do that before the zswap_invalidate()=
 call
> > > > > > was moved by commit 0827a1fb143f ("mm/zswap: invalidate zswap e=
ntry
> > > > > > when swap entry free"), and that was before we started using th=
e
> > > > > > xarray (so it was arguably worse than it would be now).
> > > > > >
> > > > >
> > > > > That might be a good idea, I suggest moving zswap_invalidate to
> > > > > swap_range_free and call it for every freed slot.
> > > > >
> > > > > Below patch can be squash into or put before "mm: attempt to batc=
h
> > > > > free swap entries for zap_pte_range()".
> > > >
> > > > Hmm, on second thought, the commit message in the attachment commit
> > > > might be not suitable, current zswap_invalidate is also designed to
> > > > only work for order 0 ZSWAP, so things are not clean even after thi=
s.
> > >
> > > Kairui, what about the below? we don't touch the path of __try_to_rec=
laim_swap() where
> > > you have one folio backed?
> > >
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index c1638a009113..8ff58be40544 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -1514,6 +1514,8 @@ static bool __swap_entries_free(struct swap_inf=
o_struct *si,
> > >         unlock_cluster_or_swap_info(si, ci);
> > >
> > >         if (!has_cache) {
> > > +               for (i =3D 0; i < nr; i++)
> > > +                       zswap_invalidate(swp_entry(si->type, offset +=
 i));
> > >                 spin_lock(&si->lock);
> > >                 swap_entry_range_free(si, entry, nr);
> > >                 spin_unlock(&si->lock);
> > >
> >
> > Hi Barry,
> >
> > Thanks for updating this thread, I'm thinking maybe something will
> > better be done at the zswap side?
> >
> > The concern of using zswap_invalidate is that it calls xa_erase which
> > requires the xa spin lock. But if we are calling zswap_invalidate in
> > swap_entry_range_free, and ensure the slot is HAS_CACHE pinned, doing
> > a lockless read first with xa_load should be OK for checking if the
> > slot needs a ZSWAP invalidation. The performance cost will be minimal
> > and we only need to call zswap_invalidate in one place, something like
> > this (haven't tested, comments are welcome). Also ZSWAP mthp will
> > still store entried in order 0 so this should be OK for future.
>
> Hi Kairui,
>
> I fully welcome the callers of swap_entry_range_free not needing to worry
> about the zswap mechanism=E2=80=94it's a freedom from concerning themselv=
es
> with zswap. However, currently, zswap_invalidate is executed outside of
> the si lock, and after the changes, it will be inside the si lock, which =
may
> potentially increase the time spent holding the si lock. So, is it possib=
le to
> move the action of acquiring the si lock for swap_entry_range_free to
> this function and do it after completing zswap_invalidate? Or am I
> overthinking it?
>
> swap_entry_range_free(si, entry, size)
> {
>       for(nr)
>             zswap_invalidate(....)
>
>      spin_lock(si->lock)
>      ...
>      spin_unlock(si->lock)
> }
>

Hi Barry,

Thanks for raising the concern.

zswap_invalidate was called inside si->lock before commit
0827a1fb143f ("mm/zswap: invalidate zswap entry when
swap entry free"), and I didn't see any performance change update
about this, so this might be trivial.

And if we apply the patch above, when ZSWAP is not enabled,
the xa_load will return NULL very fast so there should be very
low overhead. If ZSWAP is enabled, that may increase contention
on si->lock indeed, but maybe not too much of a concern either,
it should not be worse than before 0827a1fb143f. And I have a
pending series that will remove si->lock dependency of
swap_entry_range_free. I'm working on it and should be sent out
soon. So I think this should be acceptable?

And I think we may optimize the operations of xarray in zswap_invalidate
too to reduce the overhead of redundant xarray walk.

