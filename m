Return-Path: <linux-kernel+bounces-400086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3379C08D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB521C227F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471C9212634;
	Thu,  7 Nov 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="A+velQAv"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7729CF4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989425; cv=none; b=G0xAd+OUxrPx0fFytesxKHbbpfJC/0GgauqplWTmAXYmzQqHQeFlGJptBgzlc8cIFTf3ddC600GHNcm6jHo8yqpTC2JS/zbHi34/SGez6cAobXe9i4wEUIWc4Edc01QNt3p7kQzbS4BYhnOctxt/rH4T3ACQNUyHd1Obcmq2jgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989425; c=relaxed/simple;
	bh=CAsuFjs1NYlcSm6u1lueVNEjIC39HMWlgUrLzm3GkVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQ0BNpyG0YVoFuPSLQ5L9dqP5XoRSIP9QApBCa/qgACW5kpQVheyWc5bFo65ew16aPnser26opo1YgP0BneWXP2CjTgvS70mnvkkgob9lAufEHdnu5nvrzB7N7uh0wBjubXEWYj5MOf4W2TrAthWm/PmU6quBILBH1m0mkl3sFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=A+velQAv; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d382664fadso5868656d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 06:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730989420; x=1731594220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y8bIIYpNFjI/KTA7i4uS/nCeffwjvh7yAuAPrrYwVs=;
        b=A+velQAvpvrfC+yLPy6xcJSKx8Y0gQv2H/PYteAEdg/wd6Euxf/aW+Ik2q4hRcbuZu
         qVf8AexnrCM586oMr862f5tJQ/96vPmcBtTZJFg5I+Tm7m03R2bdH7iFuWRy7ESGEoNj
         VphIgAw8m9DpcE//qa77lYU1vn53tvFMnE17veCBVU5xUQ25QF61YQJMpSWEC+bQyzzX
         LvgSnidbb1FJ1j0Nbw3BEVCRHt93nnHrzLVu+p3fpKg89wGmxFLTMOdSnQIijjD7smA1
         qigMt2AL+YEmRXpLKyfdHxcjoqCDqwHSSaqjWomHSceCyAt7SCS0/XMp2tFd8AOxIiYB
         M1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730989420; x=1731594220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y8bIIYpNFjI/KTA7i4uS/nCeffwjvh7yAuAPrrYwVs=;
        b=CaAjVoTN8iYy7VNB6PtE6pR5BBSbcwEi9kX+fpSljIbZnvLW6yRAK+SXBIM2tY0OkO
         fmINpVpD6Un3EA1ATkwXj21fe3oVrQwQjtXkWMCgIcfDbx2/1wYAgNcipCultgdKiiCj
         u2MlVn8qLHBmVcX2EM4YnWNzXsiujg5R8DLtqFBPSlAd4oTmfS/qN9hQNN/agazZC6zw
         U3jQdHICmukmPVH55X+sv269DLIStqpYZNF+xR8C9unDDcS1BFWA7gT3+D2wHdO/R0ie
         7+EsuRgNKJzs9j8DUePHU/MUv0x8UQJATHeF/ht5fkNmQ/HlBDNYq0iFOX+qrQvhgZlx
         UB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGtOCOkeHZOa8ZK9gHLA+a1CVmiZEY66V90lmAtHArg60lAOM72Lb7ZX5bk0mJRqblyYOTToKAePkoMu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybQ1mBxvp5+BhTsrMDJa9S9pZLNpdK2Ez446tReqY1morNg1Ya
	kpefPtq8XDoSb77mD3K/g1HNwxYqxGlBDGPSJM2JTEpusqNxmAmeKn7SBnKfDWA=
X-Google-Smtp-Source: AGHT+IHB9FN+0AccVytMwlmLbuOHJscvcbqFSfLY7CfaYuMIuY7L99f9F7tCKuggPZta0SDkkCr1YQ==
X-Received: by 2002:a05:6214:1316:b0:6cb:f195:22c7 with SMTP id 6a1803df08f44-6d39d028537mr1233866d6.38.1730989420389;
        Thu, 07 Nov 2024 06:23:40 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d39643b98dsm7883546d6.82.2024.11.07.06.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:23:39 -0800 (PST)
Date: Thu, 7 Nov 2024 09:23:35 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: syzbot <syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
	Kairui Song <ryncsn@gmail.com>
Subject: Re: [syzbot] [mm?] general protection fault in
 swap_reclaim_full_clusters
Message-ID: <20241107142335.GB1172372@cmpxchg.org>
References: <672ac50b.050a0220.2edce.1517.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672ac50b.050a0220.2edce.1517.GAE@google.com>

On Tue, Nov 05, 2024 at 05:23:23PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    59b723cd2adb Linux 6.12-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1076c740580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b77c8a55ccf1d9e2
> dashboard link: https://syzkaller.appspot.com/bug?extid=078be8bfa863cb9e0c6b
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167aa1f7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110d86a7980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/699c7100a12a/disk-59b723cd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/74524a66d4bc/vmlinux-59b723cd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e81ed2bba0ef/bzImage-59b723cd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 1 UID: 0 PID: 51 Comm: kworker/1:1 Not tainted 6.12.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events swap_reclaim_work
> RIP: 0010:__list_del_entry_valid_or_report+0x20/0x1c0 lib/list_debug.c:49
> Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 fe 48 83 c7 08 48 83 ec 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 19 01 00 00 48 89 f2 48 8b 4e 08 48 b8 00 00 00
> RSP: 0018:ffffc90000bb7c30 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88807b9ae078
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 000000000000004f R12: dffffc0000000000
> R13: ffffffffffffffb8 R14: ffff88807b9ae000 R15: ffffc90003af1000
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fffaca68fb8 CR3: 00000000791c8000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __list_del_entry_valid include/linux/list.h:124 [inline]
>  __list_del_entry include/linux/list.h:215 [inline]
>  list_move_tail include/linux/list.h:310 [inline]
>  swap_reclaim_full_clusters+0x109/0x460 mm/swapfile.c:748
>  swap_reclaim_work+0x2e/0x40 mm/swapfile.c:779
>  process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
>  process_scheduled_works kernel/workqueue.c:3310 [inline]
>  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__list_del_entry_valid_or_report+0x20/0x1c0 lib/list_debug.c:49
> Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 fe 48 83 c7 08 48 83 ec 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 19 01 00 00 48 89 f2 48 8b 4e 08 48 b8 00 00 00
> RSP: 0018:ffffc90000bb7c30 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88807b9ae078
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 000000000000004f R12: dffffc0000000000
> R13: ffffffffffffffb8 R14: ffff88807b9ae000 R15: ffffc90003af1000
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fffaca68fb8 CR3: 00000000791c8000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	90                   	nop
>    1:	90                   	nop
>    2:	90                   	nop
>    3:	90                   	nop
>    4:	90                   	nop
>    5:	90                   	nop
>    6:	90                   	nop
>    7:	90                   	nop
>    8:	90                   	nop
>    9:	90                   	nop
>    a:	f3 0f 1e fa          	endbr64
>    e:	48 89 fe             	mov    %rdi,%rsi
>   11:	48 83 c7 08          	add    $0x8,%rdi
>   15:	48 83 ec 18          	sub    $0x18,%rsp
>   19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   20:	fc ff df
>   23:	48 89 fa             	mov    %rdi,%rdx
>   26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>   2e:	0f 85 19 01 00 00    	jne    0x14d
>   34:	48 89 f2             	mov    %rsi,%rdx
>   37:	48 8b 4e 08          	mov    0x8(%rsi),%rcx
>   3b:	48                   	rex.W
>   3c:	b8                   	.byte 0xb8
>   3d:	00 00                	add    %al,(%rax)
> 
> 

This should fix it:

---

From cf580e76e9fc23eab347e232b32d8bc9378a3f4e Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 7 Nov 2024 09:08:36 -0500
Subject: [PATCH] mm: swapfile: fix cluster reclaim work crash on rotational
 devices

syzbot and Daan report a NULL pointer crash in the new full swap
cluster reclaim work:

> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 1 UID: 0 PID: 51 Comm: kworker/1:1 Not tainted 6.12.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events swap_reclaim_work
> RIP: 0010:__list_del_entry_valid_or_report+0x20/0x1c0 lib/list_debug.c:49
> Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 fe 48 83 c7 08 48 83 ec 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 19 01 00 00 48 89 f2 48 8b 4e 08 48 b8 00 00 00
> RSP: 0018:ffffc90000bb7c30 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88807b9ae078
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 000000000000004f R12: dffffc0000000000
> R13: ffffffffffffffb8 R14: ffff88807b9ae000 R15: ffffc90003af1000
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fffaca68fb8 CR3: 00000000791c8000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __list_del_entry_valid include/linux/list.h:124 [inline]
>  __list_del_entry include/linux/list.h:215 [inline]
>  list_move_tail include/linux/list.h:310 [inline]
>  swap_reclaim_full_clusters+0x109/0x460 mm/swapfile.c:748
>  swap_reclaim_work+0x2e/0x40 mm/swapfile.c:779

The syzbot console output indicates a virtual environment where
swapfile is on a rotational device. In this case, clusters aren't
actually used, and si->full_clusters is not initialized. Daan's report
is from qemu, so likely rotational too.

Make sure to only schedule the cluster reclaim work when clusters are
actually in use.

Link: https://lore.kernel.org/lkml/672ac50b.050a0220.2edce.1517.GAE@google.com/
Link: https://github.com/systemd/systemd/issues/35044
Fixes: 5168a68eb78f ("mm, swap: avoid over reclaim of full clusters")
Reported-by: syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com
Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 46bd4b1a3c07..9c85bd46ab7f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -929,7 +929,7 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 		si->highest_bit = 0;
 		del_from_avail_list(si);
 
-		if (vm_swap_full())
+		if (si->cluster_info && vm_swap_full())
 			schedule_work(&si->reclaim_work);
 	}
 }
-- 
2.47.0


