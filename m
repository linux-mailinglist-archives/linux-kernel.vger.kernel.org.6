Return-Path: <linux-kernel+bounces-293700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A10E958342
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C21C24248
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C318C32F;
	Tue, 20 Aug 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNPAfwkz"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA118B473
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147646; cv=none; b=TG5c+TjHcsKMiOZC9QigGUWSV9yxzQVfuX6rpyc84Ymq7/tL/OQHcMor/xBRbk5os3a4Ssaij6Ow51r/S3T0c/SmaGIyfNAidtQ07Mhx8SWTXua8zj4/3ugfQUP4nJRPYATIl/kK6VLOl4uosgcrSxqwMgokkDb/ezWHgaHIsMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147646; c=relaxed/simple;
	bh=AHk7e1MSmuZy2Ok9JgBf0xmandGH6Yf2Nwj2XWydPpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yz9ef48GNo5iLEAUDqBvBgnzPHa3EJBEYCnneeM7ow+Wbmj84mO4iRqIJDFp9a06GLS9v1EvaQaPxvPfuWcyrKrvWie681c6J5XfZwRDlTDWJ2EAGxmwMHPN2BmIoea/kEgFEmWgpcftO6XJ9J5m4L5POtpbM3viOcBb3VhE/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNPAfwkz; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f89c9a1610so1868050e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724147643; x=1724752443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfXTNi+9KRHgqOjspdInTAKK9BT9wdv5JXOCg5Q+FcQ=;
        b=YNPAfwkzaoDEqoCJfZH37q0OiHo9JftH/TkyPPQ7PeYiJAq0T5yyG/HhlfU3eOxAZ5
         oftxJKYocAd/DdwiLRvXyBTNN/WptV2nVO+zed5D7UVZz+IToF32wjAUOs1xZJFcT9iB
         3X25qMP09Vn6/ulF/bZV5wT9TJZEHq6kmA/FD9txYwdAVn0VJQqtkhWRS2cuBuFWVBgY
         lUVcNJ9fmLr4TLKzl0v2zaXXipKMX1PzCFE8ScR5CePl0iq4IXdq8VyNsHrYjxZaql94
         4AIDXl3LEKYFLBbcs6IbWFupPBMvB32ZaV4TZ52JGdW+ZlovB3g/98S0HobTm/QTrBbx
         gKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724147643; x=1724752443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfXTNi+9KRHgqOjspdInTAKK9BT9wdv5JXOCg5Q+FcQ=;
        b=HlJodcAZmnb6zc878GICi/ZQHOxZHn3weRAn8b79GPjewA9LH63XCGL0gC6QZ0VPfv
         y9PxmK+Ev4CkfqTF5vB+cRNSAsbTp8oq4CgH7C+ZeMJYJt9JXbAu+VEYj/a42GflIVh+
         EMS5q9IzeubkzJaZitwQJ03e7IS8IswetPy4Ud5YvOVjYEvAU5VBs1rojwWN8DA9BYIg
         sl6EUw473+visqyX1HR8NFQhvGeVOZOxShn80ryTKpSMclxZalcJgHDRF9w7DCV796uW
         k3/0ZN9JCSb2aeDUpHvCdi28dWxXREne5zWW99h4ngzfeiO2Hjer+bXyFULRrg9uxBQN
         FloQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqNTtwE/v4d94wCA7e9YOfzX9/QGqyE2a4FuA/A5SrGedIQ8Ol2ZvIavs2Ijv+I8+Bs2HRh8R/WPCmsM+Pys5n88bMzrbNpT0fdRAW
X-Gm-Message-State: AOJu0YwxYfsw+CbfqYQv3kU+aF4QJazN/WqSxndqsNDNCcZn3cj8VaMO
	MCQEXMXTMZ6ag5DpIuMjG5l367APNHBwJnV87LxUzboBRhw37Qy/6Xsjt6JFvcMM1T6MBiRXgUB
	4O7Ljgde7RNJ8uSXw9/mgxvIuB9M=
X-Google-Smtp-Source: AGHT+IF4ya3omDs6URedYhxTyQFSrIuUpYbw2wINvOku2uKp/ZyFSjecj3JE/wuOIBf8S90Fq1zoBUhT1t24rYk6cJQ=
X-Received: by 2002:a05:6122:3293:b0:4ef:594a:a706 with SMTP id
 71dfb90a1353d-4fc6cc4a3ddmr15822499e0c.14.1724147643459; Tue, 20 Aug 2024
 02:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000060cf79061fd24ca8@google.com> <CAJD7tkYWMkcFeXKA2S71PoZAubS+0R29G5qbhTSLLCcd7DfqkQ@mail.gmail.com>
 <CAMgjq7CaCEZN2hf5pPR4N6BLzUEiMAA7Ax+G_nv4CyHVukxCNw@mail.gmail.com>
 <CAGsJ_4x3ekOw-BKVOm7-D-+z+F1urn74DLxpjxdJDr=wOwHHAA@mail.gmail.com> <CAMgjq7D9tfW626dki+cC_SjHK-Z=KnPvXmWmmSQO6xsyxokrfQ@mail.gmail.com>
In-Reply-To: <CAMgjq7D9tfW626dki+cC_SjHK-Z=KnPvXmWmmSQO6xsyxokrfQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Aug 2024 21:53:52 +1200
Message-ID: <CAGsJ_4x=DEmHdQP+NuoaQ4db4PzOmRabcoxhK4iEBHL547Skdg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
To: Kairui Song <ryncsn@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, 
	syzbot <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, Chris Li <chrisl@kernel.org>, 
	Ying <ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 9:29=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Aug 20, 2024 at 5:22=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Tue, Aug 20, 2024 at 8:47=E2=80=AFPM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Tue, Aug 20, 2024 at 4:13=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > > On Fri, Aug 16, 2024 at 12:52=E2=80=AFPM syzbot
> > > > <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20=
240816
> > >
> > > I can't find this commit, seems this commit is not in linux-next any =
more?
> > >
> > > > > git tree:       linux-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12489=
105980000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61ba6=
f3b22ee5467
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dce60292=
50d7fd4d0476d
> > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils=
 for Debian) 2.40
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3c=
ad3c/disk-367b5c3d.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813=
c/vmlinux-367b5c3d.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/6674cb=
0709b1/bzImage-367b5c3d.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to =
the commit:
> > > > > Reported-by: syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.co=
m
> > > > >
> > > > > ------------[ cut here ]------------
> > > > > WARNING: CPU: 0 PID: 11298 at mm/zswap.c:1700 zswap_swapoff+0x11b=
/0x2b0 mm/zswap.c:1700
> > > > > Modules linked in:
> > > > > CPU: 0 UID: 0 PID: 11298 Comm: swapoff Not tainted 6.11.0-rc3-nex=
t-20240816-syzkaller #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine=
, BIOS Google 06/27/2024
> > > > > RIP: 0010:zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
> > > > > Code: 74 05 e8 78 73 07 00 4b 83 7c 35 00 00 75 15 e8 1b bd 9e ff=
 48 ff c5 49 83 c6 50 83 7c 24 0c 17 76 9b eb 24 e8 06 bd 9e ff 90 <0f> 0b =
90 eb e5 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 7c 90 48 8b 3c
> > > > > RSP: 0018:ffffc9000302fa38 EFLAGS: 00010293
> > > > > RAX: ffffffff81f4d66a RBX: dffffc0000000000 RCX: ffff88802c19bc00
> > > > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff888015986248
> > > > > RBP: 0000000000000000 R08: ffffffff81f4d620 R09: 1ffffffff1d476ac
> > > > > R10: dffffc0000000000 R11: fffffbfff1d476ad R12: dffffc0000000000
> > > > > R13: ffff888015986200 R14: 0000000000000048 R15: 0000000000000002
> > > > > FS:  00007f9e628a5380(0000) GS:ffff8880b9000000(0000) knlGS:00000=
00000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 0000001b30f15ff8 CR3: 000000006c5f0000 CR4: 00000000003506f0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  __do_sys_swapoff mm/swapfile.c:2837 [inline]
> > > > >  __se_sys_swapoff+0x4653/0x4cf0 mm/swapfile.c:2706
> > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > RIP: 0033:0x7f9e629feb37
> > > > > Code: 73 01 c3 48 8b 0d f1 52 0d 00 f7 d8 64 89 01 48 83 c8 ff c3=
 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <48> 3d =
01 f0 ff ff 73 01 c3 48 8b 0d c1 52 0d 00 f7 d8 64 89 01 48
> > > > > RSP: 002b:00007fff17734f68 EFLAGS: 00000246 ORIG_RAX: 00000000000=
000a8
> > > > > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9e629feb37
> > > > > RDX: 00007f9e62a9e7e8 RSI: 00007f9e62b9beed RDI: 0000563090942a20
> > > > > RBP: 0000563090942a20 R08: 0000000000000000 R09: 77872e07ed164f94
> > > > > R10: 000000000000001f R11: 0000000000000246 R12: 00007fff17735188
> > > > > R13: 00005630909422a0 R14: 0000563073724169 R15: 00007f9e62bdda80
> > > > >  </TASK>
> > > >
> > > > I am hoping syzbot would find a reproducer and bisect this for us.
> > > > Meanwhile, from a high-level it looks to me like we are missing a
> > > > zswap_invalidate() call in some paths.
> > > >
> > > > If I have to guess, I would say it's related to the latest mTHP swa=
p
> > > > changes, but I am not following closely. Perhaps one of the followi=
ng
> > > > things happened:
> > > >
> > > > (1) We are not calling zswap_invalidate() in some invalidation path=
s.
> > > > It used to not be called for the cluster freeing path, so maybe we =
end
> > > > up with some order-0 swap entries in a cluster? or maybe there is a=
n
> > > > entirely new invalidation path that does not go through
> > > > free_swap_slot() for order-0 entries?
> > > >
> > > > (2) Some higher order swap entries (i.e. a cluster) end up in zswap
> > > > somehow. zswap_store() has a warning to cover that though. Maybe
> > > > somehow some swap entries are allocated as a cluster, but then page=
s
> > > > are swapped out one-by-one as order-0 (which can go to zswap), but
> > > > then we still free the swap entries as a cluster?
> > >
> > > Hi Yosry, thanks for the report.
> > >
> > > There are many mTHP related optimizations recently, for this problem =
I
> > > can reproduce this locally. Can confirm the problem is gone for me
> > > after reverting:
> > >
> > > "mm: attempt to batch free swap entries for zap_pte_range()"
> > >
> > > Hi Barry,
> > >
> > > If a set of continuous slots are having the same value, they are
> > > considered a mTHP and freed, bypassing the slot cache, and causing
> > > zswap leak.
> > > This didn't happen in put_swap_folio because that function is
> > > expecting an actual mTHP folio behind the slots but
> > > free_swap_and_cache_nr is simply walking the slots.
> >
> > Hi Kairui,
> >
> > I don't understand, if anyone has a folio backend, the code will
> > go fallback to __try_to_reclaim_swap(),  it won't call
> > swap_entry_range_free().
> >
> >      ci =3D lock_cluster_or_swap_info(si, offset);
> >         if (!swap_is_last_map(si, offset, nr, &has_cache)) {
> >                 unlock_cluster_or_swap_info(si, ci);
> >                 goto fallback;
> >         }
> >         for (i =3D 0; i < nr; i++)
> >                 WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
> >         unlock_cluster_or_swap_info(si, ci);
> >
> >         if (!has_cache) {
> >                 spin_lock(&si->lock);
> >                 swap_entry_range_free(si, entry, nr);
> >                 spin_unlock(&si->lock);
> >         }
> >         return has_cache;
> >
> > Am i missing something?
>
> Hi Barry,
>
> Per my understanding, ZSWAP invalidation could happen after the folio
> is gone from the swap cache, especially in free_swap_and_cache_nr, it
> will iterate and zap the swap slots without swapping them in.
> So a slot doesn't have a folio backed doesn't mean it doesn't have ZSWAP =
data.

well. thanks! the original non-batched code always has a zswap_invalidate()
in free_swap_slot().
void free_swap_slot(swp_entry_t entry)

{
        struct swap_slots_cache *cache;
        /* Large folio swap slot is not covered. */
        zswap_invalidate(entry);
        ...
}

but the benefits of batched-free is huge(on phones, almost 100% PTEs have n=
o
swapcache as it uses sync io swap; on SSD cases, only a small part of PTEs =
have
folio backend in swapcache, so it will still benefit significantly
from this batched-free).
so let's try to find a proper fix for this before we have to do the
below ugly (which will
at least benefit phones who never use zswap):

diff --git a/mm/swapfile.c b/mm/swapfile.c
index f947f4dd31a9..c8c70a9bf6d6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1498,6 +1498,9 @@ static bool __swap_entries_free(struct
swap_info_struct *si,
        unsigned char count;
        int i;

+       if (!zswap_never_enabled())
+               return fallback;
+
        if (nr <=3D 1 || swap_count(data_race(si->swap_map[offset])) !=3D 1=
)
                goto fallback;
        /* cross into another cluster */


Thanks
Barry

