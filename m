Return-Path: <linux-kernel+bounces-558632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31908A5E8CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1F01898EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A5D1F2365;
	Wed, 12 Mar 2025 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QteANfTi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C65165F1F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823754; cv=none; b=iAdLFBjvRa1LB/bIeimoyFP7+natxi1x7Ei5DbCl8evzdAHjzx6zJ6VQoCLYPQFcZitMDbrrX3ke6Nh0yNTjAXftl+cUfhGOImnpYBnjVDBBQR1IZxHnnT7cs8oxUB2M+K3wOT9SaxI/AIRGK2GnqZkdfm46W0STbqpOuRFULqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823754; c=relaxed/simple;
	bh=1Tj0Goh28iA3jnjbJ3tKztzIofMYGKcaVAaDHlQhUOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mHe9jfkytRp6xfUVYJioXRQZMa7gezwD9ljvtzqBpuUKmjj48HDdfazbyQ/6PeBkOUAgJ/SbpIdD/L0GY+I0qTPh5BaVav8+ZuZtRGR19vugLzfy3cJNfQKJ62LL+nSpCa3N+STtJ9Ql+0zA78gkfmPh8PwQVvP+InOP1wQN4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QteANfTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEE1C4CEDD;
	Wed, 12 Mar 2025 23:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741823753;
	bh=1Tj0Goh28iA3jnjbJ3tKztzIofMYGKcaVAaDHlQhUOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QteANfTinliZI2rX7EKfm6uSAXkAIKF7pIAJrOBamonahWh6wxDdXNLzlr+oWUi2k
	 ifxiXV1GqL5LzV+2CYRbZ0VkmJWpAEeSer0hT0r5gmvta5RUpmi54b9J3ctJCabaHX
	 OWB0F46lLNi+qFapUt8Og60VANXK22QjgzWM0c9FGwEvrxwCrfrIA7XNl4BMWatbre
	 3H7OB/aZ0/RYxPjXEd1sG75oaJDD5kcjbv9DYZyVnGPH3lmmjOiZUaNRwRZRtzjEWT
	 CpMQP24zoZemjYWvdSMWUrLeGRkZFbgaL4g3TlpYp6YqWjdi1MV07HSqeeFkWpWnFK
	 LKxOW2isikS0Q==
Date: Thu, 13 Mar 2025 00:55:48 +0100
From: Vasily Gorbik <gor@kernel.org>
To: Yang Shi <yang@os.amperecomputing.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
	jannh@google.com, oliver.sang@intel.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [v2 PATCH] mm: vma: skip anonymous vma when inserting vma to
 file rmap tree
Message-ID: <your-ad-here.call-01741821544-ext-0004@work.hours>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312221521.1255690-1-yang@os.amperecomputing.com>

On Wed, Mar 12, 2025 at 03:15:21PM -0700, Yang Shi wrote:
> LKP reported 800% performance improvement for small-allocs benchmark
> from vm-scalability [1] with patch ("/dev/zero: make private mapping
> full anonymous mapping") [2], but the patch was nack'ed since it changes
> the output of smaps somewhat.
...
> ---
> v2:
>    * Added the comments in code suggested by Lorenzo
>    * Collected R-b from Lorenze
> 
>  mm/vma.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Hi Yang,

Replying to v2, as the code is the same as v1 in linux-next:

The LTP test "mmap10" consistently triggers a kernel NULL pointer
dereference with this change, at least on x86 and s390. Reverting just
this single patch from linux-next fixes the issue.

LTP: starting mmap10
BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 800000010d22a067 P4D 800000010d22a067 PUD 11ff09067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 5 UID: 0 PID: 1719 Comm: mmap10 Not tainted 6.14.0-rc6-next-20250312 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
RIP: 0010:__rb_insert_augmented+0x2b/0x1d0
Code: 0f 1e fa 48 89 f8 48 8b 3f 48 85 ff 0f 84 a4 01 00 00 41 55 49 89 f5 41 54 49 89 d4 55 53 48 8b 1f f6 c3 01 0f 85 e1 00 00 00 <48> 8b 53 08 48 39 fa 74 67 48 85 d2 74 09 f6 02 01 0f 84 a0 00 00
RSP: 0018:ffffc90002b47cc8 EFLAGS: 00010246
RAX: ffff8881143ab788 RBX: 0000000000000000 RCX: 00000000000009ff
RDX: ffffffff814ad5d0 RSI: ffff888100bb5060 RDI: ffff8881143ab088
RBP: ffff8881053af8c0 R08: ffff8881143ab700 R09: 00007ff6433f2000
R10: 00007ff6433f2000 R11: ffff8881143ab000 R12: ffffffff814ad5d0
R13: ffff888100bb5060 R14: ffff8881143ab700 R15: ffff8881143ab000
FS:  00007ff643df1740(0000) GS:ffff8882b45bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000011b042000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? __die_body.cold+0x19/0x2b
 ? page_fault_oops+0xc4/0x1f0
 ? search_extable+0x26/0x30
 ? search_module_extables+0x3f/0x60
 ? exc_page_fault+0x6b/0x150
 ? asm_exc_page_fault+0x26/0x30
 ? __pfx_vma_interval_tree_augment_rotate+0x10/0x10
 ? __pfx_vma_interval_tree_augment_rotate+0x10/0x10
 ? __rb_insert_augmented+0x2b/0x1d0
 copy_mm+0x48a/0x8c0
 copy_process+0xf98/0x1930
 kernel_clone+0xb7/0x3b0
 __do_sys_clone+0x65/0x90
 do_syscall_64+0x9e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff643eb2b00
Code: 31 c0 31 d2 31 f6 bf 11 00 20 01 48 89 e5 53 48 83 ec 08 64 48 8b 04 25 10 00 00 00 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 89 c3 85 c0 75 31 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffdac219010 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff643eb2b00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffdac219020 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ff643df1a10 R11: 0000000000000202 R12: 0000000000000001
R13: 0000000000000000 R14: 00007ff644036000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: 0000000000000008
---[ end trace 0000000000000000 ]---
RIP: 0010:__rb_insert_augmented+0x2b/0x1d0
Code: 0f 1e fa 48 89 f8 48 8b 3f 48 85 ff 0f 84 a4 01 00 00 41 55 49 89 f5 41 54 49 89 d4 55 53 48 8b 1f f6 c3 01 0f 85 e1 00 00 00 <48> 8b 53 08 48 39 fa 74 67 48 85 d2 74 09 f6 02 01 0f 84 a0 00 00
RSP: 0018:ffffc90002b47cc8 EFLAGS: 00010246
RAX: ffff8881143ab788 RBX: 0000000000000000 RCX: 00000000000009ff
RDX: ffffffff814ad5d0 RSI: ffff888100bb5060 RDI: ffff8881143ab088
RBP: ffff8881053af8c0 R08: ffff8881143ab700 R09: 00007ff6433f2000
R10: 00007ff6433f2000 R11: ffff8881143ab000 R12: ffffffff814ad5d0
R13: ffff888100bb5060 R14: ffff8881143ab700 R15: ffff8881143ab000
FS:  00007ff643df1740(0000) GS:ffff8882b45bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000011b042000 CR4: 00000000000006f0



LTP: starting mmap10
Unable to handle kernel pointer dereference in virtual kernel address space
Failing address: 0000000000000000 TEID: 0000000000000483
Fault in home space mode while using kernel ASCE.
AS:000000000247c007 R3:00000001ffffc007 S:00000001ffffb801 P:000000000000013d
Oops: 0004 ilc:3 [#1] SMP
Modules linked in:
CPU: 0 UID: 0 PID: 665 Comm: mmap10 Not tainted 6.14.0-rc6-next-20250312 #16
Hardware name: IBM 3931 A01 704 (KVM/Linux)
Krnl PSW : 0704c00180000000 000003ffe0ee0440 (__rb_insert_augmented+0x60/0x210)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
Krnl GPRS: 00000000009ff000 0000000000000000 000000008e5f7508 0000000084a7ed08
           00000000000009fe 0000000000000000 0000000000000000 0000037fe06c7b68
           00000000801d0e90 000003ffe04158d0 0000000084a7ed08 0000000000000000
           000003ffbb700000 00000000801d0e48 000003ffe0ee057c 0000037fe06c7a40
Krnl Code: 000003ffe0ee0430: e31030080004        lg      %r1,8(%r3)
           000003ffe0ee0436: ec1200888064        cgrj    %r1,%r2,8,000003ffe0ee0546
          #000003ffe0ee043c: b90400a3            lgr     %r10,%r3
          >000003ffe0ee0440: e310b0100024        stg     %r1,16(%r11)
           000003ffe0ee0446: e3b030080024        stg     %r11,8(%r3)
           000003ffe0ee044c: ec180009007c        cgij    %r1,0,8,000003ffe0ee045e
           000003ffe0ee0452: ec2b000100d9        aghik   %r2,%r11,1
           000003ffe0ee0458: e32010000024        stg     %r2,0(%r1)
Call Trace:
 [<000003ffe0ee0440>] __rb_insert_augmented+0x60/0x210
 [<000003ffe016d6c4>] dup_mmap+0x424/0x8c0
 [<000003ffe016dc62>] copy_mm+0x102/0x1c0
 [<000003ffe016e8ae>] copy_process+0x7ce/0x12b0
 [<000003ffe016f458>] kernel_clone+0x68/0x380
 [<000003ffe016f84a>] __do_sys_clone+0x5a/0x70
 [<000003ffe016faa0>] __s390x_sys_clone+0x40/0x50
 [<000003ffe011c9b6>] do_syscall.constprop.0+0x116/0x140
 [<000003ffe0ef1d64>] __do_syscall+0xd4/0x1c0
 [<000003ffe0efd044>] system_call+0x74/0x98
Last Breaking-Event-Address:
 [<000003ffe0ee058a>] __rb_insert_augmented+0x1aa/0x210
Kernel panic - not syncing: Fatal exception: panic_on_oops

