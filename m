Return-Path: <linux-kernel+bounces-433917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648499E5EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FDD16C0B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3044A229B2B;
	Thu,  5 Dec 2024 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ERCK74Bw"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF6229B1A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426595; cv=none; b=okkyCt9wVWZOfCLX9KdstmT7JJCrDDmvTxxoC/yi8ebiXzj0WovWZpynxBPAIsuoS678XMC7iOMw2OHmEya9aVF8bCv/cysufYMXskbHYPGiLLdVyONABINqYbYqnUC3ONacDmlHr8YSbeyXIxhE5xPS3iuTmH2MsjkHnWJnbx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426595; c=relaxed/simple;
	bh=EiPLycQOzJwT/MD+t/r9bSSjNX3LgV0cmum8ro/HHYQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MuEpaIcxGPNyNqEkRFVpxvGRCtAeiZO7jsml7mnr3NTOieBQm9ZP6U+l+KSCaXgIYP9urvpjJgUQNXpwHzrOHW+IgBG3vBt8tmXr+8Eqa84SkoKJfO3RRVYZ7pLmAjPHztKDI9Cp//ZVrRDxNTTvxStWKFl767T1NSUolxJwH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ERCK74Bw; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0CA152AC469
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:23:06 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D203028007D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:22:57 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 6A28513C2B0
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:22:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6A28513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733426577;
	bh=EiPLycQOzJwT/MD+t/r9bSSjNX3LgV0cmum8ro/HHYQ=;
	h=Date:To:From:Subject:From;
	b=ERCK74BwqGjHzm6hwmJ+OVpCJdWNyljS97UaCjFnKGKIs9Lt7izIk+8CyeHe44g3t
	 oWzar+CpCPmV3DIrW+L4ByUbWFOQVDm56XL5rScx3FRCjF3HrjvLHoRz1fTiX/2+z0
	 FCGQ7KFUT1N4S6FSv38comSJJJfZC4ZXJa/JpvZs=
Message-ID: <75334977-be5c-08f5-b262-06e2633f4072@candelatech.com>
Date: Thu, 5 Dec 2024 11:22:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: 6.13.0-rc1+: __asan_memcpy crash loading module on boot.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1733426578-BYmdyrvU8yaG
X-MDID-O:
 us5;ut7;1733426578;BYmdyrvU8yaG;<greearb@candelatech.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

I pulled and built a kernel today, with no local modifications.
It is in continuous reboot, crashing like this below.  I'm curious if
this is a known issue.

BUG: unable to handle page fault for address: fffffbfff4041000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 44d0e7067 P4D 44d0e7067 PUD 44d0e3067 PMD 10bb01067 PTE 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 7 UID: 0 PID: 327 Comm: systemd-udevd Not tainted 6.13.0-rc1+ #3
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
RIP: 0010:kasan_check_range+0xa5/0x190
Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 ce 00 00 00 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 d0 0f 84 b29
RSP: 0018:ffff88812c24f980 EFLAGS: 00010206
RAX: fffffbfff4041000 RBX: fffffbfff404101e RCX: ffffffff814f30d6
[  OK  DX: fffffbfff4041018 RSI: 00000000000000f0 RDI: ffffffffa0208000
0m] Finished BP: fffffbfff4041000 R08: 0000000000000001 R09: fffffbfff404101d
;1;39msystemd-udR10: ffffffffa02080ef R11: 0000000000000003 R12: ffffffffa0208000
ev-trig�…e R13: ffffc90000dac930 R14: ffffc90000dac950 R15: dffffc0000000000
- Coldplug All uFS:  00007f46b51deb40(0000) GS:ffff88841dd80000(0000) knlGS:0000000000000000
dev Devices.
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4041000 CR3: 000000012c201006 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x258/0x910
  ? dump_pagetable+0x690/0x690
  ? search_bpf_extables+0x22/0x250
  ? show_ldttss+0x230/0x230
  ? search_bpf_extables+0x164/0x250
  ? kasan_check_range+0xa5/0x190
  ? fixup_exception+0x4d/0xc70
  ? exc_page_fault+0xe1/0xf0
  ? asm_exc_page_fault+0x22/0x30
  ? load_module+0x3c46/0x8680
  ? kasan_check_range+0xa5/0x190
  __asan_memcpy+0x38/0x60
  load_module+0x3c46/0x8680
  ? __kernel_read+0x2a0/0x9f0
  ? module_frob_arch_sections+0x30/0x30
  ? lockdep_lock+0xbe/0x1b0
  ? rw_verify_area+0x18d/0x5e0
  ? kernel_read_file+0x246/0x870
  ? __x64_sys_fspick+0x290/0x290
  ? init_module_from_file+0xd1/0x130
  init_module_from_file+0xd1/0x130
  ? __ia32_sys_init_module+0xa0/0xa0
  ? lock_acquire+0x2d/0xb0
  ? idempotent_init_module+0x10d/0x780
  ? do_raw_spin_unlock+0x54/0x220
  idempotent_init_module+0x21d/0x780
  ? init_module_from_file+0x130/0x130
  ? __fget_files+0x1a5/0x2d0
  __x64_sys_finit_module+0xbe/0x130
  do_syscall_64+0x69/0x160
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f46b5dab27d
Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 248
RSP: 002b:00007ffdec622ae8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055ad173f7950 RCX: 00007f46b5dab27d
RDX: 0000000000000000 RSI: 00007f46b5f1143c RDI: 0000000000000006
RBP: 00007f46b5f1143c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
R13: 000055ad173d0bb0 R14: 0000000000000000 R15: 000055ad173dab30
  </TASK>
Modules linked in:
CR2: fffffbfff4041000
---[ end trace 0000000000000000 ]---
BUG: unable to handle page fault for address: fffffbfff404101e
RIP: 0010:kasan_check_range+0xa5/0x190
#PF: supervisor read access in kernel mode

I'm not using module compression, and can share full .config and/or lsmod from
an earlier kernel if that is helpful.

[root@ben-dt5 linux-linux.x64-dbg]# grep MODULE .config
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
CONFIG_MODULE_SRCVERSION_ALL=y
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODULES_TREE_LOOKUP=y

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


