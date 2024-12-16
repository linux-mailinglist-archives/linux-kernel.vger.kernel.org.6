Return-Path: <linux-kernel+bounces-447953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB79F3921
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD30A1887AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A4206F13;
	Mon, 16 Dec 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5qUqpFL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C03043AA9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374392; cv=none; b=Dr4S111zDzuquwmqLQwfiV+PNsANbr45c211c2L+xAMPN7zmZ4TVpiTzrwrG+s/j4qoohVmqn2Bk3DvIN0EvllX03+tLHYvvR9BIBFFHpRjcYTlE7cXmhntS4+RYDdCEQwpeRzMNyOisEexzYZ4p6vqCZo4dIw/cpr+ZOd4ywOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374392; c=relaxed/simple;
	bh=v8zC+hRT7LWTpMFOk/xRpKN/iJbd5ILLztijeSa/UiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB+AaAmIaf5ADem07xVYe8PhajWi8029RymlnH6USBiF46JdJJt+d5jU+pzVtqobAvfsRPf02SaLbTY+sii3+v+tXk+yZKvmGkw+k32iyflSWFF+tuElvBAaSPGCnmc8LiEF1Cosr7glIalcrHYKKXE8m4Nd+p725AQb5MtPSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5qUqpFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6C6C4CED0;
	Mon, 16 Dec 2024 18:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734374392;
	bh=v8zC+hRT7LWTpMFOk/xRpKN/iJbd5ILLztijeSa/UiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5qUqpFLiBM1qUWGHPYlrUP71YlgMOtSzT5syC/Dg426bmqllwd0WQ1FUA7gLTo+y
	 I8oy86wXEoHaJLX0lVuDVr1QxUwaiaNpYMLU7T5YBTDgdJmH3dh/ev1m2fzQHZKuh6
	 i93BnHn5vUS1Z0+d85NPt0pnwW3+vxSlBZpnuTdgxe2fslS/ol7CnGe5/i0GELuV8A
	 ct/3L6S1Szvwxf81TWy5xc4z+z/PmKCIBT/KEJpiaXoMOeGgPHqy3ankY1aR07fLGy
	 8+7fkSnWlSYYwceykF9NXkxsDTPlWjNWAgKSgVz8VTy1ngp0WwMJ7UlwnrhyeqbwI3
	 D6DpPJqw85Rag==
Date: Mon, 16 Dec 2024 13:39:50 -0500
From: Sasha Levin <sashal@kernel.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Kairui Song <ryncsn@gmail.com>, syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [syzbot] [mm?] WARNING in lock_list_lru_of_memcg
Message-ID: <Z2Bz9t92Be9l1xqj@lappy>
References: <675d01e9.050a0220.37aaf.00be.GAE@google.com>
 <CAOUHufZ+UDx5pXD7b1pBC8P0Ubu1p2Z5r6Qx+ruT5g78q02Cxw@mail.gmail.com>
 <CAMgjq7BpdyJ=Q4OW4gEeCxP9PU5u=4Mp_Bd=uqr5iaosrQJMZg@mail.gmail.com>
 <CAMgjq7ArVJ8hhqLkuEJNVhhFX4BaFz8uDrZvXkHrDsESJpsWmw@mail.gmail.com>
 <CAOUHufYXqj5QqZ5Kv4CNn2HyeUGT6RidKGJ6Jp17NUGjqgKAXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYXqj5QqZ5Kv4CNn2HyeUGT6RidKGJ6Jp17NUGjqgKAXA@mail.gmail.com>

On Sun, Dec 15, 2024 at 07:45:38PM -0700, Yu Zhao wrote:
>Hi Kairui,
>
>On Sun, Dec 15, 2024 at 10:45 AM Kairui Song <ryncsn@gmail.com> wrote:
>>
>> On Sun, Dec 15, 2024 at 3:43 AM Kairui Song <ryncsn@gmail.com> wrote:
>> >
>> > On Sat, Dec 14, 2024 at 2:06 PM Yu Zhao <yuzhao@google.com> wrote:
>> > >
>> > > On Fri, Dec 13, 2024 at 8:56 PM syzbot
>> > > <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com> wrote:
>> > > >
>> > > > Hello,
>> > > >
>> > > > syzbot found the following issue on:
>> > > >
>> > > > HEAD commit:    7cb1b4663150 Merge tag 'locking_urgent_for_v6.13_rc3' of g..
>> > > > git tree:       upstream
>> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=16e96b30580000
>> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
>> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=38a0cbd267eff2d286ff
>> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> > > >
>> > > > Unfortunately, I don't have any reproducer for this issue yet.
>> > > >
>> > > > Downloadable assets:
>> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7cb1b466.raw.xz
>> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/13e083329dab/vmlinux-7cb1b466.xz
>> > > > kernel image: https://storage.googleapis.com/syzbot-assets/fe3847d08513/bzImage-7cb1b466.xz
>> > > >
>> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> > > > Reported-by: syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com
>> > > >
>> > > > ------------[ cut here ]------------
>> > > > WARNING: CPU: 0 PID: 80 at mm/list_lru.c:97 lock_list_lru_of_memcg+0x395/0x4e0 mm/list_lru.c:97
>> > > > Modules linked in:
>> > > > CPU: 0 UID: 0 PID: 80 Comm: kswapd0 Not tainted 6.13.0-rc2-syzkaller-00018-g7cb1b4663150 #0
>> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> > > > RIP: 0010:lock_list_lru_of_memcg+0x395/0x4e0 mm/list_lru.c:97
>> > > > Code: e9 22 fe ff ff e8 9b cc b6 ff 4c 8b 7c 24 10 45 84 f6 0f 84 40 ff ff ff e9 37 01 00 00 e8 83 cc b6 ff eb 05 e8 7c cc b6 ff 90 <0f> 0b 90 eb 97 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 7a fd ff ff 48
>> > > > RSP: 0018:ffffc9000105e798 EFLAGS: 00010093
>> > > > RAX: ffffffff81e891c4 RBX: 0000000000000000 RCX: ffff88801f53a440
>> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> > > > RBP: ffff888042e70054 R08: ffffffff81e89156 R09: 1ffffffff2032cae
>> > > > R10: dffffc0000000000 R11: fffffbfff2032caf R12: ffffffff81e88e5e
>> > > > R13: ffffffff9a3feb20 R14: 0000000000000000 R15: ffff888042e70000
>> > > > FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
>> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > > > CR2: 0000000020161000 CR3: 0000000032d12000 CR4: 0000000000352ef0
>> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> > > > Call Trace:
>> > > >  <TASK>
>> > > >  list_lru_add+0x59/0x270 mm/list_lru.c:164
>> > > >  list_lru_add_obj+0x17b/0x250 mm/list_lru.c:187
>> > > >  workingset_update_node+0x1af/0x230 mm/workingset.c:634
>> > > >  xas_update lib/xarray.c:355 [inline]
>> > > >  update_node lib/xarray.c:758 [inline]
>> > > >  xas_store+0xb8f/0x1890 lib/xarray.c:845
>> > > >  page_cache_delete mm/filemap.c:149 [inline]
>> > > >  __filemap_remove_folio+0x4e9/0x670 mm/filemap.c:232
>> > > >  __remove_mapping+0x86f/0xad0 mm/vmscan.c:791
>> > > >  shrink_folio_list+0x30a6/0x5ca0 mm/vmscan.c:1467
>> > > >  evict_folios+0x3c86/0x5800 mm/vmscan.c:4593
>> > > >  try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
>> > > >  shrink_one+0x3b9/0x850 mm/vmscan.c:4834
>> > > >  shrink_many mm/vmscan.c:4897 [inline]
>> > > >  lru_gen_shrink_node mm/vmscan.c:4975 [inline]
>> > > >  shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
>> > > >  kswapd_shrink_node mm/vmscan.c:6785 [inline]
>> > > >  balance_pgdat mm/vmscan.c:6977 [inline]
>> > > >  kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
>> > > >  kthread+0x2f0/0x390 kernel/kthread.c:389
>> > > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>> > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>> > > >  </TASK>
>> > >
>> > > This one seems to be related to "mm/list_lru: split the lock to
>> > > per-cgroup scope".
>> > >
>> > > Kairui, can you please take a look? Thanks.
>> >
>> > Thanks for pinging, yes that's a new sanity check added by me.
>> >
>> > Which is supposed to mean, a list_lru is being reparented while the
>> > memcg it belongs to isn't dying.
>> >
>> > More concretely, list_lru is marked dead by memcg_offline_kmem ->
>> > memcg_reparent_list_lrus, if the function is called for one memcg, but
>> > now the memcg is not dying, this WARN triggers. I'm not sure how this
>> > is caused. One possibility is if alloc_shrinker_info() in
>> > mem_cgroup_css_online failed, then memcg_offline_kmem is called early?
>> > Doesn't seem to fit this case though.. Or maybe just sync issues with
>> > the memcg dying flag so the user saw the list_lru dying before seeing
>> > memcg dying? The object might be leaked to the parent cgroup, seems
>> > not too terrible though.
>> >
>> > I'm not sure how to reproduce this. I will keep looking.
>>
>> Managed to boot the image and using the kernel config provided by bot,
>> so far local tests didn't trigger any issue. Is there any way I can
>> reproduce what the bot actually did?
>
>If syzbot doesn't have a repro, it might not be productive for you to
>try to find one. Personally, I would analyze stacktraces and double
>check the code, and move on if I can't find something obviously wrong.
>
>> Or provide some patch for the bot
>> to test?
>
>syzbot only can try patches after it finds a repro. So in this case,
>no, it can't try your patches.
>
>Hope the above clarifies things for you.

Chiming in here as LKFT seems to be able to hit a nearby warning on
boot.

The link below contains the full log as well as additional information
on the run.

https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.13-rc2-232-g4800575d8c0b/testrun/26323524/suite/log-parser-test/test/exception-warning-cpu-pid-at-mmlist_lruc-list_lru_del/details/

-- 
Thanks,
Sasha

