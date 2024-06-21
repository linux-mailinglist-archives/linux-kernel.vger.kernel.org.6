Return-Path: <linux-kernel+bounces-224990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8899129A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B111E281DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006D74413;
	Fri, 21 Jun 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xhTl3qo4"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F60654FB5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983740; cv=none; b=poiONdR8p1ODx70UWVuSZxb4y/r44jXJgKIyoUeoy95wsIiHpFPte5dDhkheQt+Qv0yidtbiFKMTJySv01OwXB9j+GH2DCr1UKIFzv0Q7skzHnaQN7DLMvJzKOzsYhURCVsvR9rB/ZFlNc5PGvAcp3RsnnKXeDnFd7DD2bA4TnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983740; c=relaxed/simple;
	bh=iMcdnBSCrVyrNrDO8pMPAElZ06k2xqAs4yysojwGTpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNq3JLmgEypiWLZpYOWBVKpdpQW5U4oc+679f/mbr3ogwK/eGvgR3P3dYHzhPhuBgnHfcsOnKBOunPd/dF/L30gCuxIklBwCoCZWIGbFHwTkXJXZ8kUBluo+yj6DNcvAXy9uvoiawpjyW/kWUxtZLY8sFQZ3dy2ofZ80youZ4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xhTl3qo4; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4ed127d7c3dso514810e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718983737; x=1719588537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QYdGoLjV8Z3CP8OmW5eh6pLgOYuafTXjejO9tHjo7ZY=;
        b=xhTl3qo4hhf1Hj13+hYOSV2Jj78zQsjynVjlLf9QLtZpTQodb27jgPYPD41MkNM3oz
         ZCL1G+p7bVg/9kBzOOx7JAod+Xn0B7X4mjI6Iui2cXe4d88bvor2mCuRAyWZNxGdzyY4
         MVPe6DedssDY7yZuSk/fm3giL/muxRvQFhnStVGHS0ByMhoEe4O3vNkqCehuLWlYUpAc
         Ka+Ko6S/xJutEr0q1dy45hwCuU/uacsoMQH1/Qw5bwSwP9TE1XouL9sDfzte43JoXrJc
         QGfdEQbj8B1o16UaDG5gH8AnKJyiNHrhE9cnEEimW9Y9KSf9uANKfxTHUyFJSPuagTyA
         3zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718983737; x=1719588537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYdGoLjV8Z3CP8OmW5eh6pLgOYuafTXjejO9tHjo7ZY=;
        b=NQBsm1pqZJBpFI+7MjEwAndREYRGQXt+7us0CertIOWvDXeA9aoGpBm7K1h3MGu4zn
         nLKK/rW5/wD73KLr++b1n2SQwvwigIL3r2piUyS86gByR5D9OmsWFiekDpDmU101Gwwv
         Aq3F+JxmiG1DSza948q5nbPMB3fKCvUBPrMmJKNvRU1JclUH8w6jss7vhA4wph4ZvAte
         cj7mSC0P4aaR1JhufQkg+VDPU1Q5xZnKI1msWClDP4+6+HgMqePY4ZTIq3lbQmDmmzg0
         zx0+INfjsREYbzcGSxjE744UB4BjcwFNTHF9I2NvKrC5/TbQzfmweSyDSZSrAfbXUIXW
         2YYg==
X-Forwarded-Encrypted: i=1; AJvYcCW6qZbifkTvwVbr5Z9JJ9uBz+5LqVkM6Pzpjsou66keO1uaQGFPV2FucwHCw7d3LYLR+9iQ0M4R+Sxd2lzIIaZvz6MjzEmHHoHVcFIX
X-Gm-Message-State: AOJu0Yxv74z+D/CHGUTbQbVLBeCvOdt3l9PLbq3IJqG5AhPoZSUXnPR1
	J7WUcv8aUJrrDVj2LrlHuMk6U7IoWZ9Guaka19OT8VwFx2MVBGF1/rGNgj32dR6ZUmsDOydtXa4
	qBDFvUx7a7iLnzDKPusdK80X/JA2/yBl7wwbw
X-Google-Smtp-Source: AGHT+IHEAW3VDBpOi5I+/UCk7VbTgbvh4YQQ6kvt8JBLarOOYXRfwyBHJvUNGr2MF2gNuWN1llJ5pOz1pesqmOhdVGU=
X-Received: by 2002:a05:6122:251c:b0:4ec:f183:c9a8 with SMTP id
 71dfb90a1353d-4ef27709600mr9347198e0c.9.1718983737267; Fri, 21 Jun 2024
 08:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008d1e5a061b666b11@google.com>
In-Reply-To: <0000000000008d1e5a061b666b11@google.com>
From: Marco Elver <elver@google.com>
Date: Fri, 21 Jun 2024 17:28:17 +0200
Message-ID: <CANpmjNORLNHsWamYPU=rS7ftjZndchiEYHXznUS_RyR1edvrCA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in mtree_range_walk /
 rcu_segcblist_enqueue (2)
To: liam.howlett@oracle.com
Cc: syzbot <syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lstoakes@gmail.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	RCU <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

[+Cc rcu folks]

On Fri, 21 Jun 2024 at 15:29, syzbot
<syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    50736169ecc8 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=164ec02a980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=704451bc2941bcb0
> dashboard link: https://syzkaller.appspot.com/bug?extid=9bb7d0f2fdb4229b9d67
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e4cbed12fec1/disk-50736169.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d50b5dcae4cd/vmlinux-50736169.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f2c14c5fcce2/bzImage-50736169.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in mtree_range_walk / rcu_segcblist_enqueue
>
> write to 0xffff888104077308 of 8 bytes by task 12265 on cpu 1:
>  rcu_segcblist_enqueue+0x67/0xb0 kernel/rcu/rcu_segcblist.c:345
>  rcutree_enqueue kernel/rcu/tree.c:2940 [inline]
>  call_rcu_core kernel/rcu/tree.c:2957 [inline]
>  __call_rcu_common kernel/rcu/tree.c:3093 [inline]
>  call_rcu+0x1bd/0x430 kernel/rcu/tree.c:3176
>  ma_free_rcu lib/maple_tree.c:197 [inline]
>  mas_free lib/maple_tree.c:1304 [inline]
>  mas_replace_node+0x2f8/0x440 lib/maple_tree.c:1741
>  mas_wr_node_store lib/maple_tree.c:3956 [inline]
>  mas_wr_modify+0x2bc3/0x3c90 lib/maple_tree.c:4189
>  mas_wr_store_entry+0x250/0x390 lib/maple_tree.c:4229
>  mas_store_prealloc+0x151/0x2b0 lib/maple_tree.c:5485
>  vma_iter_store mm/internal.h:1398 [inline]
>  vma_complete+0x3a7/0x760 mm/mmap.c:535
>  __split_vma+0x623/0x690 mm/mmap.c:2440
>  split_vma mm/mmap.c:2466 [inline]
>  vma_modify+0x198/0x1f0 mm/mmap.c:2507
>  vma_modify_flags include/linux/mm.h:3347 [inline]
>  mprotect_fixup+0x335/0x610 mm/mprotect.c:637
>  do_mprotect_pkey+0x673/0x9a0 mm/mprotect.c:820
>  __do_sys_mprotect mm/mprotect.c:841 [inline]
>  __se_sys_mprotect mm/mprotect.c:838 [inline]
>  __x64_sys_mprotect+0x48/0x60 mm/mprotect.c:838
>  x64_sys_call+0x26f5/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:11
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888104077308 of 8 bytes by task 12266 on cpu 0:
>  mtree_range_walk+0x140/0x460 lib/maple_tree.c:2774
>  mas_state_walk lib/maple_tree.c:3678 [inline]
>  mas_walk+0x16e/0x320 lib/maple_tree.c:4909
>  lock_vma_under_rcu+0x84/0x260 mm/memory.c:5840
>  do_user_addr_fault arch/x86/mm/fault.c:1329 [inline]
>  handle_page_fault arch/x86/mm/fault.c:1481 [inline]
>  exc_page_fault+0x150/0x650 arch/x86/mm/fault.c:1539
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 12266 Comm: syz-executor.3 Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> ==================================================================

This is not an ordinary data race. I suspect this to be an incorrect
use of RCU, resulting in some kind of use-after-free / type-confusion.

The access within rcu_segcblist_enqueue() is to maple_node::rcu (at
offset 8 into maple_node). The racing access in mtree_range_walk() is
to either maple_node::mr64::pivot[0] or maple_node::ma64::pivot[0]
(both also offset 8 into maple_node).

