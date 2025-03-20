Return-Path: <linux-kernel+bounces-570328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945FDA6AEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FAF423CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D2B229B23;
	Thu, 20 Mar 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pIWkTzPp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="foZCswO8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pIWkTzPp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="foZCswO8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868D204F6A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500961; cv=none; b=sQLl7bPLk+WtI3Zwqx6+fhLwTFKmU/FTg5dR5waV7Mh34NHMyon7WuauEurZof4lQHTRhYmHsFoiXE+ra1CfLp/3DwBFJz0jOF/dfIFTAQCHz7w0ELaI1q00HEiONreeXV9En7DmGRUMG1IwE+XrCSAHMafxJKCfW04/2VCGyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500961; c=relaxed/simple;
	bh=IMyoGWRbiltHWi1qN2gkbbyo74lYc5G3clbZqOL40vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dg1QQQ2cKF5s/FZQKn0sKr+KBymmRuw6/BlIdbT58FJHyrAFL2xbGOQF9g6gyYZfftns9sSGe9c3jbrOQTDpP1u9nudlLwGXKAeOqMA8lQ3ertDU+xd7jKSenZGIi0wCNQtm1rsecgq3XXv6hw5ZBO8l8CB7LG/s5FVQr2G5U8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pIWkTzPp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=foZCswO8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pIWkTzPp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=foZCswO8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 627121F80D;
	Thu, 20 Mar 2025 20:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742500957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RywGZR7MJK4ztXwOvhzxPW6Yg5sf5Kgn8XMy9Lh9SkE=;
	b=pIWkTzPpetLnhHmwHFPlc9E+gxMSOgsez8dj/VJHsp7WfhielYKS2/xghwjrzUPD9zZhkh
	x54ME80gjrTlFQoGxRCI2h7atT+6TkQx/OzvvDQe+KeyT9AoI6FDSWsisU5NEq3c8E9aqi
	WvvMXA0AufTBxpQDsAZ4pX7L0keKSbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742500957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RywGZR7MJK4ztXwOvhzxPW6Yg5sf5Kgn8XMy9Lh9SkE=;
	b=foZCswO8wTNsVOLIXrFC0qRFNSSY2Ts3jn1yz05ma9yXGlp7WKaaZnKJY/AH3XHgLK5EPN
	HEZFM24aF+7Og3Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742500957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RywGZR7MJK4ztXwOvhzxPW6Yg5sf5Kgn8XMy9Lh9SkE=;
	b=pIWkTzPpetLnhHmwHFPlc9E+gxMSOgsez8dj/VJHsp7WfhielYKS2/xghwjrzUPD9zZhkh
	x54ME80gjrTlFQoGxRCI2h7atT+6TkQx/OzvvDQe+KeyT9AoI6FDSWsisU5NEq3c8E9aqi
	WvvMXA0AufTBxpQDsAZ4pX7L0keKSbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742500957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RywGZR7MJK4ztXwOvhzxPW6Yg5sf5Kgn8XMy9Lh9SkE=;
	b=foZCswO8wTNsVOLIXrFC0qRFNSSY2Ts3jn1yz05ma9yXGlp7WKaaZnKJY/AH3XHgLK5EPN
	HEZFM24aF+7Og3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7F72139D2;
	Thu, 20 Mar 2025 20:02:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CmCmKVx03GfVRwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 20 Mar 2025 20:02:36 +0000
Date: Thu, 20 Mar 2025 20:02:34 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: syzbot <syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com>, 
	lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 vma_merge_existing_range
Message-ID: <qn7ncujf5gkfmohf5qp3fdakrymhoapkscafqp5t2gulmgdqai@tuhu2igx33k4>
References: <67dc67f0.050a0220.25ae54.001e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67dc67f0.050a0220.25ae54.001e.GAE@google.com>
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=77423669c2b8fa9];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[20ed41006cf9d842c2b5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Mar 20, 2025 at 12:09:36PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    eb88e6bfbc0a Merge tag 'fsnotify_for_v6.14-rc7' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e6c83f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=77423669c2b8fa9
> dashboard link: https://syzkaller.appspot.com/bug?extid=20ed41006cf9d842c2b5
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-eb88e6bf.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ded0ce69669f/vmlinux-eb88e6bf.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6e6fa3c719e7/bzImage-eb88e6bf.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com
> 
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> BUG: unable to handle page fault for address: fffffffffffffff4
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD df84067 P4D df84067 PUD df86067 PMD 0 
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 UID: 0 PID: 17805 Comm: syz.8.3237 Not tainted 6.14.0-rc6-syzkaller-00212-geb88e6bfbc0a #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
> Code: e8 5f 25 ad ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c 89 ff e8 9f 1f ad ff 48 8b 44 24 08 49 39 c7 0f 83 db
> RSP: 0000:ffffc9000319f988 EFLAGS: 00010246
> RAX: fffffffffffffff4 RBX: ffffc9000319fae8 RCX: ffffffff820cd3e5
> RDX: 1ffffffffffffffe RSI: 0000000080c2a000 RDI: 0000000000000005
> RBP: 0000000080ce2000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
> R13: ffffc9000319fb08 R14: ffff888025eddc98 R15: ffff88804eec0a00
> FS:  0000000000000000(0000) GS:ffff88802b500000(0063) knlGS:00000000f5106b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: fffffffffffffff4 CR3: 00000000614d6000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  vma_modify.constprop.0+0x87/0x410 mm/vma.c:1517
>  vma_modify_flags_uffd+0x241/0x2e0 mm/vma.c:1598
>  userfaultfd_clear_vma+0x91/0x130 mm/userfaultfd.c:1906
>  userfaultfd_release_all+0x2ae/0x4c0 mm/userfaultfd.c:2024
>  userfaultfd_release+0xf4/0x1c0 fs/userfaultfd.c:865
>  __fput+0x3ff/0xb70 fs/file_table.c:464
>  task_work_run+0x14e/0x250 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
>  __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:390
>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:412
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf7fe6579
> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f510655c EFLAGS: 00000296 ORIG_RAX: 0000000000000135
> RAX: 0000000000000001 RBX: 0000000080000180 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> CR2: fffffffffffffff4
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
> Code: e8 5f 25 ad ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c 89 ff e8 9f 1f ad ff 48 8b 44 24 08 49 39 c7 0f 83 db
> RSP: 0000:ffffc9000319f988 EFLAGS: 00010246
> RAX: fffffffffffffff4 RBX: ffffc9000319fae8 RCX: ffffffff820cd3e5
> RDX: 1ffffffffffffffe RSI: 0000000080c2a000 RDI: 0000000000000005
> RBP: 0000000080ce2000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
> R13: ffffc9000319fb08 R14: ffff888025eddc98 R15: ffff88804eec0a00
> FS:  0000000000000000(0000) GS:ffff88802b500000(0063) knlGS:00000000f5106b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: fffffffffffffff4 CR3: 00000000614d6000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	e8 5f 25 ad ff       	call   0xffad2564
>    5:	48 8b 14 24          	mov    (%rsp),%rdx
>    9:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   10:	fc ff df
>   13:	48 c1 ea 03          	shr    $0x3,%rdx
>   17:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>   1b:	0f 85 1c 19 00 00    	jne    0x193d
>   21:	48 8b 04 24          	mov    (%rsp),%rax
>   25:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
> * 2a:	4c 8b 38             	mov    (%rax),%r15 <-- trapping instruction
>   2d:	4c 89 ff             	mov    %r15,%rdi
>   30:	e8 9f 1f ad ff       	call   0xffad1fd4
>   35:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
>   3a:	49 39 c7             	cmp    %rax,%r15
>   3d:	0f                   	.byte 0xf
>   3e:	83                   	.byte 0x83
>   3f:	db                   	.byte 0xdb

Ahh, fun bug. This *seems* to be the bug:

First, in vma_modify:

	merged = vma_merge_existing_range(vmg);
	if (merged)
		return merged;
	if (vmg_nomem(vmg))
		return ERR_PTR(-ENOMEM);

then, all the way up to userfaultfd_release_all (the return value propagates
vma_modify -> vma_modify_flags_uffd -> userfaultfd_clear_vma):

	prev = NULL;
	for_each_vma(vmi, vma) {
		cond_resched();
		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
			prev = vma;
			continue;
		}

		vma = userfaultfd_clear_vma(&vmi, prev, vma,
					    vma->vm_start, vma->vm_end);
		prev = vma;
	}

So, if uffd gets an IS_ERR(vma), it keeps going and takes that vma as the prev value,
which leads to that ERR_PTR(-ENOMEM) deref crash (-12 = -ENOMEM = 0xffffff4).
This situation is kind of awkward because ->release() errors don't mean a thing.
So, I have another idea (pasting for syzbot) which might just be cromulent.
Untested, but thoughts?

#syz test

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d06453fa8aba..fb835d82eb84 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2023,6 +2023,8 @@ void userfaultfd_release_all(struct mm_struct *mm,

                vma = userfaultfd_clear_vma(&vmi, prev, vma,
                                            vma->vm_start, vma->vm_end);
+               if (WARN_ON(IS_ERR(vma)))
+                       break;
                prev = vma;
        }
        mmap_write_unlock(mm);
diff --git a/mm/vma.c b/mm/vma.c
index 71ca012c616c..b2167b7dc27d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1517,8 +1517,16 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
        merged = vma_merge_existing_range(vmg);
        if (merged)
                return merged;
-       if (vmg_nomem(vmg))
+       if (vmg_nomem(vmg)) {
+               /* If we can avoid failing the whole modification
+                * due to a merge OOM and validly keep going
+                * (we're modifying the whole VMA), return vma intact.
+                * It won't get merged, but such is life - we're avoiding
+                * OOM conditions in other parts of mm/ this way */
+               if (start <= vma->vm_start && end >= vma->vm_end)
+                       return vma;
                return ERR_PTR(-ENOMEM);
+       }

        /* Split any preceding portion of the VMA. */
        if (vma->vm_start < start) {

-- 
Pedro

