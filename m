Return-Path: <linux-kernel+bounces-294915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30101959440
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541751C2203C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E758616A947;
	Wed, 21 Aug 2024 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMZJxzYO"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD31547D4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724219373; cv=none; b=CNIqQLdUHnUJ8gSzZ0zyI2GLJSpRji/TbEvHSvGmN8ywJUVXegsxO3tEyvlgumkzkybNykVC4lULIfQfrBtZS03qBMFL71CfUojRJilurUSsHUdzCNn6j2d9U34tnaz2bUeyqN1FEV8g75Wi3WH7i+ooeP4UZEBAmCKzUfoL5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724219373; c=relaxed/simple;
	bh=6+ViLa0fI+0E+P/s6/pLD+umyVETpRD/5UGHjRsWV3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/iGt26adQnDxrbPD2GMj5fO89RrgOihOxDpDpzcvrF18+V4AvQ0UMWtK2cVqdtvKhQhp2ue3Z8v1ZWdt4Q6KVfCsOQG/MlIhcHy4De/ZnRY+6cUMT9DJzrPSeH5tw5Qs9H7BikoWOZ1sn9P6vvjc/mfFDdwDkT7nmIilU5zY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMZJxzYO; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso4876008a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724219370; x=1724824170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epZcu6NqeywwM9Rp6su95R4Re49Q2nt588tKQWwC7ZM=;
        b=BMZJxzYOojOKfHUen+zCFpKNiRqOtAZ23mozB9oP7DpZM9OuFsEDFoUBdlePggHPfi
         HsQTAkXPSIVWgP6/j9xJ/nk5Tt1I1JYJ6BboS0+hu3Snf7YWCr7Ac38zQ3SwRCtYMOCT
         iDZBgWoXzJuR8iRnRzxofeI5qQijUfnWlJtggWWkCvXsOjF8jxGJKexlz53+wu5GSor4
         bc3dOrdPN3W8Y8hW39JojPhd4yCqpEltSic2Tcx8s4LKdKUsLhIydk9zlkcLGwp7Pa/C
         TVvMKWmVcflQRwi+ENdHAPLShLeS6JUQlf0ommqcXd8qqxWNTez7HQuO2rclCVZ+v7JW
         MimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724219370; x=1724824170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epZcu6NqeywwM9Rp6su95R4Re49Q2nt588tKQWwC7ZM=;
        b=KrsVcfz2G/oqwpmZQFfWmKud1OtexK5ZsW8yRQ2u5zFwCGoSNbZ5SK4RrfGtxDn0Zw
         K3IyMrxnu7vSw478srge4hXs/mhAEZf7Ckxc8pnpM/WadL5lzDsWxVWq9f9VnutRjBGz
         VFDcLLCJKaBtq3h623RM/S633H0K3tb4P/wtdYFkH21G+bkYn7RS5e+NFXzBJ1V1x5dy
         WUf7p1NCBLtfgrrEe+S74izPe0m8HQrvW2kHBAzqjvPyBvWo2lmFQQzXBvJrncxpfEhs
         t7W8U790xA9EddB9VKUlHUgpgg9deo7pwzV77oOPA5p8csgJBzfHHpiaeuRatrSUVrjO
         ZUJw==
X-Forwarded-Encrypted: i=1; AJvYcCX/go+KbcJ84k7OTSN+7cL7hox2iXpTI3iuGbcSiO9HH0V368Bu9cVtCRKzyxosJdXDPJ9z9i0ukTE96fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTssR2LPRMTO6f3o7t0MYZ5kd0kNEJBXyJC2PvnV9wWbE5BPp
	fRl5LKNfKDkAZN4bAQ/tZQhzhzgdJ1AATIsvln3EKGJ4hzXV213/
X-Google-Smtp-Source: AGHT+IEbb5CcwUtsPqQA8InXkVkQaWGp+zg2iM8CUmPCKElu58r8lQCccmP2IS2ZXjfGt70drxNiAQ==
X-Received: by 2002:a05:6a20:9f0b:b0:1ca:cbf5:593 with SMTP id adf61e73a8af0-1cad7f8b771mr2137053637.20.1724219370327;
        Tue, 20 Aug 2024 22:49:30 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:9d62:3169:ab00:4dd1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5c2e163a8sm1840894a91.1.2024.08.20.22.49.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Aug 2024 22:49:29 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: ryncsn@gmail.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	ying.huang@intel.com,
	yosryahmed@google.com
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
Date: Wed, 21 Aug 2024 17:49:21 +1200
Message-Id: <20240821054921.43468-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAMgjq7BhpCoPMEkSkCAqWcvTO93KQK4xzn2Av6M0ATkk8YZapg@mail.gmail.com>
References: <CAMgjq7BhpCoPMEkSkCAqWcvTO93KQK4xzn2Av6M0ATkk8YZapg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Aug 20, 2024 at 9:02 PM Kairui Song <ryncsn@gmail.com> wrote:
>
> On Tue, Aug 20, 2024 at 4:47 PM Kairui Song <ryncsn@gmail.com> wrote:
> >
> > On Tue, Aug 20, 2024 at 4:13 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > On Fri, Aug 16, 2024 at 12:52 PM syzbot
> > > <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
> >
> > I can't find this commit, seems this commit is not in linux-next any more?
> >
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=12489105980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=ce6029250d7fd4d0476d
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/disk-367b5c3d.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmlinux-367b5c3d.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709b1/bzImage-367b5c3d.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 0 PID: 11298 at mm/zswap.c:1700 zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
> > > > Modules linked in:
> > > > CPU: 0 UID: 0 PID: 11298 Comm: swapoff Not tainted 6.11.0-rc3-next-20240816-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> > > > RIP: 0010:zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
> > > > Code: 74 05 e8 78 73 07 00 4b 83 7c 35 00 00 75 15 e8 1b bd 9e ff 48 ff c5 49 83 c6 50 83 7c 24 0c 17 76 9b eb 24 e8 06 bd 9e ff 90 <0f> 0b 90 eb e5 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 7c 90 48 8b 3c
> > > > RSP: 0018:ffffc9000302fa38 EFLAGS: 00010293
> > > > RAX: ffffffff81f4d66a RBX: dffffc0000000000 RCX: ffff88802c19bc00
> > > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff888015986248
> > > > RBP: 0000000000000000 R08: ffffffff81f4d620 R09: 1ffffffff1d476ac
> > > > R10: dffffc0000000000 R11: fffffbfff1d476ad R12: dffffc0000000000
> > > > R13: ffff888015986200 R14: 0000000000000048 R15: 0000000000000002
> > > > FS:  00007f9e628a5380(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000001b30f15ff8 CR3: 000000006c5f0000 CR4: 00000000003506f0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  <TASK>
> > > >  __do_sys_swapoff mm/swapfile.c:2837 [inline]
> > > >  __se_sys_swapoff+0x4653/0x4cf0 mm/swapfile.c:2706
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > RIP: 0033:0x7f9e629feb37
> > > > Code: 73 01 c3 48 8b 0d f1 52 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 52 0d 00 f7 d8 64 89 01 48
> > > > RSP: 002b:00007fff17734f68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a8
> > > > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9e629feb37
> > > > RDX: 00007f9e62a9e7e8 RSI: 00007f9e62b9beed RDI: 0000563090942a20
> > > > RBP: 0000563090942a20 R08: 0000000000000000 R09: 77872e07ed164f94
> > > > R10: 000000000000001f R11: 0000000000000246 R12: 00007fff17735188
> > > > R13: 00005630909422a0 R14: 0000563073724169 R15: 00007f9e62bdda80
> > > >  </TASK>
> > >
> > > I am hoping syzbot would find a reproducer and bisect this for us.
> > > Meanwhile, from a high-level it looks to me like we are missing a
> > > zswap_invalidate() call in some paths.
> > >
> > > If I have to guess, I would say it's related to the latest mTHP swap
> > > changes, but I am not following closely. Perhaps one of the following
> > > things happened:
> > >
> > > (1) We are not calling zswap_invalidate() in some invalidation paths.
> > > It used to not be called for the cluster freeing path, so maybe we end
> > > up with some order-0 swap entries in a cluster? or maybe there is an
> > > entirely new invalidation path that does not go through
> > > free_swap_slot() for order-0 entries?
> > >
> > > (2) Some higher order swap entries (i.e. a cluster) end up in zswap
> > > somehow. zswap_store() has a warning to cover that though. Maybe
> > > somehow some swap entries are allocated as a cluster, but then pages
> > > are swapped out one-by-one as order-0 (which can go to zswap), but
> > > then we still free the swap entries as a cluster?
> >
> > Hi Yosry, thanks for the report.
> >
> > There are many mTHP related optimizations recently, for this problem I
> > can reproduce this locally. Can confirm the problem is gone for me
> > after reverting:
> >
> > "mm: attempt to batch free swap entries for zap_pte_range()"
> >
> > Hi Barry,
> >
> > If a set of continuous slots are having the same value, they are
> > considered a mTHP and freed, bypassing the slot cache, and causing
> > zswap leak.
> > This didn't happen in put_swap_folio because that function is
> > expecting an actual mTHP folio behind the slots but
> > free_swap_and_cache_nr is simply walking the slots.
> >
> > For the testing, I actually have to disable mTHP, because linux-next
> > will panic with mTHP due to lack of following fixes:
> > https://lore.kernel.org/linux-mm/a4b1b34f-0d8c-490d-ab00-eaedbf3fe780@gmail.com/
> > https://lore.kernel.org/linux-mm/403b7f3c-6e5b-4030-ab1c-3198f36e3f73@gmail.com/
> >
> > >
> > > I am not closely following the latest changes so I am not sure. CCing
> > > folks who have done work in that area recently.
> > >
> > > I am starting to think maybe it would be more reliable to just call
> > > zswap_invalidate() for all freed swap entries anyway. Would that be
> > > too expensive? We used to do that before the zswap_invalidate() call
> > > was moved by commit 0827a1fb143f ("mm/zswap: invalidate zswap entry
> > > when swap entry free"), and that was before we started using the
> > > xarray (so it was arguably worse than it would be now).
> > >
> >
> > That might be a good idea, I suggest moving zswap_invalidate to
> > swap_range_free and call it for every freed slot.
> >
> > Below patch can be squash into or put before "mm: attempt to batch
> > free swap entries for zap_pte_range()".
>
> Hmm, on second thought, the commit message in the attachment commit
> might be not suitable, current zswap_invalidate is also designed to
> only work for order 0 ZSWAP, so things are not clean even after this.

Kairui, what about the below? we don't touch the path of __try_to_reclaim_swap() where
you have one folio backed?

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c1638a009113..8ff58be40544 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1514,6 +1514,8 @@ static bool __swap_entries_free(struct swap_info_struct *si,
 	unlock_cluster_or_swap_info(si, ci);
 
 	if (!has_cache) {
+		for (i = 0; i < nr; i++)
+			zswap_invalidate(swp_entry(si->type, offset + i));
 		spin_lock(&si->lock);
 		swap_entry_range_free(si, entry, nr);
 		spin_unlock(&si->lock);

>
> And for performance, it will cause unnecessary heavier contention for
> the mTHP page on ZSWAP Xarray. It does fix the leak though, please
> ignore this fix, let's try find a better fix.

