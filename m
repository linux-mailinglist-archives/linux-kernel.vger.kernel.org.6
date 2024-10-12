Return-Path: <linux-kernel+bounces-362231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C4299B275
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06939B22C47
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E80F14B081;
	Sat, 12 Oct 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjbd2ys9"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEEB1474C5
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728724436; cv=none; b=DxccrU1bSJoRtQu6PlRaARZ3JgahfcisFlViVXHCZWgfVsgPN1bH0vjcUba1BXMKfMkf9X7bIdSW1itHyK70+6RvZBCzZCGiSOJDIadstaf0mk5XZno/aZ6IuuaAEBGdv9CCP2eTMeQlNIVNi+EZID4G2w1G4ygAWE32b2GrB+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728724436; c=relaxed/simple;
	bh=236EMDlymcpW22pwai3pL5fUhHbNTdRH3l5Mq21nZI8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KJ1EQnsDkJML1fJL8MP9pfw0vRrpqlk6W54m1kTSJntZgiowqsHo23ANEx4ibqnOQ7OVcSNiLJH3BoR2dQVAR8bs2vLU/aJutu5ZnHvYLi99AmxmF7fBGTJzOt4hscDnv+XNKXs1+0k8W5qI14gCO9yESxFlOthqtEgig/GOZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vjbd2ys9; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d35639bfaso242981e0c.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728724432; x=1729329232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=236EMDlymcpW22pwai3pL5fUhHbNTdRH3l5Mq21nZI8=;
        b=Vjbd2ys9g6ImDDFviABBWTMhS2p9MXRPnLKdeWmkZqIZUoS5mSsPZ1vQK85zK/vmaf
         29BIkfm8DEYDqwB5aaVhpuz7meRL747g3CTgqUJMD8jQ7FRDjCsxS65GcGEkLjUg2us0
         ABqQ6IlPSYXkJELNX+7AgocGGxj4+eh7SJUWe59xrXA0PM7S6jcRGctkhRhutT7qoaM5
         +idkw3PpK1jto0m6NWXgUPMLjT5IMc0ts0ip0ClaAkGAH54CkCiV1PvTvGs7lGH0u4vD
         LfT/5rGpRuH4QDi7tzNf6SfgzKf4dCZ6V7Eej6ISgfO3judSvY2At99uevAr4azxC9Z3
         iO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728724432; x=1729329232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=236EMDlymcpW22pwai3pL5fUhHbNTdRH3l5Mq21nZI8=;
        b=YeGBF2zo0+khR6RygHTK/+OUzRzoV2TasCN1QIaS9amfndLmFmQiXeEFMd+Q6zqkVQ
         c3h9D4R81CetpKjXlvM/z3A5XLTXtPwlPfFWHekGTlhGeWUle+UYSXpnCeT8kqUvX80K
         QhIoVMguGNjGEliBxqNCBrBdWNB9G7ZmN9fMjn98AKLvV+q+n3W7DERoUH26dYZ8c0jw
         y3pCgNsf+wTYZJCwlgDzDBvV1nPSzk0AL2Mah48rpJJTJm6R2MOThyjBXvKDwkKOHBG9
         CRiJYOOO+1ou7uivbf8fBZHNVlG8TpvNXYHI4kixMQyyhledQAkH54D0aL61TCOpug3Y
         Eyww==
X-Forwarded-Encrypted: i=1; AJvYcCU667H4cUzA06s4J0ns74krSzJBCyN6g91gondZ6LIUhUZ9rsP3d9JtUyr+JhQ8lqa/+qShvYg/J4waKGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykk93a4OCOdWem+oafRCMrL8vyqPXTdKnQ7yFguE9ItzHGcSVk
	py3EDrI5gcaPTUppfZnpkLj34vC/6sgjbYYs8m7BILElNc9z1CNIHZAdH2SVT+U5BZH1q7HBtw3
	oXEkKNzttSgoQ/yQPSEVaUngUrRE=
X-Google-Smtp-Source: AGHT+IFE/L2GY+/g1tgyXYtsNzjhozzCO7E+3X6ln+bXnChcczGpv4LayXNctksfAvlrHTUHv6XXZci5A+vyI1Z//IM=
X-Received: by 2002:a05:6122:2a51:b0:50c:55f4:b53f with SMTP id
 71dfb90a1353d-50d1f56e515mr4044329e0c.8.1728724432347; Sat, 12 Oct 2024
 02:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Sat, 12 Oct 2024 17:13:40 +0800
Message-ID: <CAHOo4gKf2mjPX8oAxCBUc74=+OToMdu6pe6iALGCOmXjToFaKw@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in write_special_inodes
To: Dave Kleikamp <shaggy@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Lizhi Xu <lizhi.xu@windriver.com>, 
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kernel Maintainers,
we found a crash "BUG: unable to handle kernel NULL pointer
dereference in write_special_inodes" in upstream, and reproduced it
successfully.


HEAD Commit: 9852d85ec9d492ebef56dc5f229416c925758edc(tag 'v6.12-rc1')
kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs=
/main/6.12.config

repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9db=
c5dada06496/repro.report
console output:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9dbc5dada06496/re=
pro.log
syz reproducer:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9dbc5dada06496/re=
pro.prog
c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9db=
c5dada06496/repro.cprog


Please let me know if there is anything I can help.
Best,
Hui Guo

This is the crash log I got by reproducing the bug based on the above
environment=EF=BC=8C
I have piped this log through decode_stacktrace.sh for better
understand the cause of the bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
executing program
syzkaller login: [ 43.704796][ T8242] loop3: detected capacity change
from 0 to 32768
[ 43.707859][ T8215] loop0: detected capacity change from 0 to 32768
[ 43.733656][ T8239] loop2: detected capacity change from 0 to 32768
[ 43.759686][ T8234] loop1: detected capacity change from 0 to 32768
[ 43.921958][ T8248] loop5: detected capacity change from 0 to 32768
[ 43.947086][ T8243] loop4: detected capacity change from 0 to 32768
[ 43.969139][ T8250] loop9: detected capacity change from 0 to 32768
[ 43.986996][ T8254] loop14: detected capacity change from 0 to 32768
[ 44.060631][ T8218] BUG: kernel NULL pointer dereference, address:
0000000000000030
[ 44.061395][ T8218] #PF: supervisor read access in kernel mode
[ 44.061959][ T8218] #PF: error_code(0x0000) - not-present page
[ 44.062526][ T8218] PGD 0 P4D 0
[ 44.062898][ T8218] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 44.063564][ T8218] CPU: 1 UID: 0 PID: 8218 Comm: syz-executor368 Not
tainted 6.12.0-rc1 #5
[ 44.064885][ T8218] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[ 44.065764][ T8218] RIP: 0010:write_special_inodes
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr=
.c:208
(discriminator 3))
[ 44.066375][ T8218] Code: 53 e8 6c 30 68 ff 49 8b 45 00 49 39 c5 74
43 48 8d 58 c8 e8 5a 30 68 ff 48 8b 43 10 48 8b 78 30 2e e8 4c 0d 39
03 48 8b 43 28 <48> 8b 78 30 2e e8 3e 0d 39 03 48 8b 83 b0 00 00 00 48
8b 78 30 2e
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 53 push %rbx
1: e8 6c 30 68 ff call 0xffffffffff683072
6: 49 8b 45 00 mov 0x0(%r13),%rax
a: 49 39 c5 cmp %rax,%r13
d: 74 43 je 0x52
f: 48 8d 58 c8 lea -0x38(%rax),%rbx
13: e8 5a 30 68 ff call 0xffffffffff683072
18: 48 8b 43 10 mov 0x10(%rbx),%rax
1c: 48 8b 78 30 mov 0x30(%rax),%rdi
20: 2e e8 4c 0d 39 03 cs call 0x3390d72
26: 48 8b 43 28 mov 0x28(%rbx),%rax
2a:* 48 8b 78 30 mov 0x30(%rax),%rdi <-- trapping instruction
2e: 2e e8 3e 0d 39 03 cs call 0x3390d72
34: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
3b: 48 8b 78 30 mov 0x30(%rax),%rdi
3f: 2e cs

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 48 8b 78 30 mov 0x30(%rax),%rdi
4: 2e e8 3e 0d 39 03 cs call 0x3390d48
a: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
11: 48 8b 78 30 mov 0x30(%rax),%rdi
15: 2e cs
[ 44.068207][ T8218] RSP: 0018:ffff88800f2c3ce8 EFLAGS: 00010286
[ 44.068812][ T8218] RAX: 0000000000000000 RBX: ffff88800e279c00 RCX:
ffffffff814acf4f
[ 44.069570][ T8218] RDX: ffff88800dde3300 RSI: ffffffff814acf5b RDI:
0000000000000005
[ 44.070349][ T8218] RBP: ffff88800f2c3d00 R08: ffff88800a50e3d0 R09:
0000000000000001
[ 44.071123][ T8218] R10: 0000000000000000 R11: 0000000000000001 R12:
ffffffff814b2420
[ 44.071889][ T8218] R13: ffff888040fd5200 R14: ffff888040fd5280 R15:
0000000000000000
[ 44.072665][ T8218] FS: 00005555717b43c0(0000)
GS:ffff88807ee00000(0000) knlGS:0000000000000000
[ 44.073532][ T8218] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 44.074184][ T8218] CR2: 0000000000000030 CR3: 000000000d8fa000 CR4:
0000000000350ef0
[ 44.074962][ T8218] Call Trace:
[ 44.075300][ T8218] <TASK>
[ 44.075599][ T8218] ? show_regs
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/d=
umpstack.c:479)
[ 44.076065][ T8218] ? __die
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/d=
umpstack.c:421
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/du=
mpstack.c:434)
[ 44.076490][ T8218] ? page_fault_oops
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:711)
[ 44.077009][ T8218] ? srso_return_thunk
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/retp=
oline.S:224)
[ 44.077511][ T8218] ? __kvm_handle_async_pf
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/k=
vm.c:262)
[ 44.078096][ T8218] ? exc_page_fault
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:1265
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.=
c:1481
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.=
c:1539)
[ 44.078637][ T8218] ? asm_exc_page_fault
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/includ=
e/asm/idtentry.h:623)
[ 44.079197][ T8218] ? __pfx_filemap_flush
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:463)
[ 44.079730][ T8218] ? filemap_fdatawrite_wbc
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:393)
[ 44.080314][ T8218] ? filemap_fdatawrite_wbc
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:401)
[ 44.080893][ T8218] ? write_special_inodes
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr=
.c:208
(discriminator 3))
[ 44.081423][ T8218] ? write_special_inodes
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr=
.c:208
(discriminator 3))
[ 44.081967][ T8218] lmLogSync
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr=
.c:937)
[ 44.082412][ T8218] ? srso_return_thunk
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/retp=
oline.S:224)
[ 44.082917][ T8218] ? __sanitizer_cov_trace_const_cmp4
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kcov.c:316=
)
[ 44.083568][ T8218] ? srso_return_thunk
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/retp=
oline.S:224)
[ 44.083893][ T8253] loop11: detected capacity change from 0 to 32768
[ 44.084063][ T8218] ? jfs_flush_journal
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr=
.c:1615)
[ 44.085204][ T8218] jfs_syncpt
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr=
.c:1041)
[ 44.085640][ T8218] jfs_sync_fs
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/super.c:68=
8)
[ 44.086107][ T8218] ? __pfx_jfs_sync_fs
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/super.c:67=
4)
[ 44.086625][ T8218] sync_filesystem
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/sync.c:57
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/sync.c:30)
[ 44.087120][ T8218] generic_shutdown_super
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:624)
[ 44.087674][ T8218] kill_block_super
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:1697)
[ 44.088178][ T8218] deactivate_locked_super
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:434
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:475)
[ 44.088742][ T8218] deactivate_super
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:508)
[ 44.089265][ T8218] cleanup_mnt
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:25=
0
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:137=
4)
[ 44.089734][ T8218] __cleanup_mnt
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:13=
81)
[ 44.090212][ T8218] task_work_run
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/s=
ched.h:2031
(discriminator 1)
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/task_work.c=
:230
(discriminator 1))
[ 44.090688][ T8218] syscall_exit_to_user_mode
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/r=
esume_user_mode.h:50
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/commo=
n.c:114
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/en=
try-common.h:328
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/commo=
n.c:207
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/commo=
n.c:218)
[ 44.091087][ T8247] loop10: detected capacity change from 0 to 32768
[ 44.091253][ T8218] do_syscall_64
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/co=
mmon.c:102)
[ 44.092312][ T8218] entry_SYSCALL_64_after_hwframe
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/en=
try_64.S:130)
[ 44.092931][ T8218] RIP: 0033:0x7f44ff534f8b
[ 44.093385][ T8218] Code: 08 00 48 83 c4 08 5b 5d c3 66 0f 1f 44 00
00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 b8 ff
ff ff f7 d8
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 08 00 or %al,(%rax)
2: 48 83 c4 08 add $0x8,%rsp
6: 5b pop %rbx
7: 5d pop %rbp
8: c3 ret
9: 66 0f 1f 44 00 00 nopw 0x0(%rax,%rax,1)
f: c3 ret
10: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
17: 00 00 00
1a: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
1f: f3 0f 1e fa endbr64
23: b8 a6 00 00 00 mov $0xa6,%eax
28: 0f 05 syscall
2a:* 48 3d 00 f0 ff ff cmp $0xfffffffffffff000,%rax <-- trapping instructio=
n
30: 77 05 ja 0x37
32: c3 ret
33: 0f 1f 40 00 nopl 0x0(%rax)
37: 48 c7 c2 b8 ff ff ff mov $0xffffffffffffffb8,%rdx
3e: f7 d8 neg %eax

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 48 3d 00 f0 ff ff cmp $0xfffffffffffff000,%rax
6: 77 05 ja 0xd
8: c3 ret
9: 0f 1f 40 00 nopl 0x0(%rax)
d: 48 c7 c2 b8 ff ff ff mov $0xffffffffffffffb8,%rdx
14: f7 d8 neg %eax
[ 44.095191][ T8218] RSP: 002b:00007ffc50d9a3b8 EFLAGS: 00000202
ORIG_RAX: 00000000000000a6
[ 44.096010][ T8218] RAX: 0000000000000000 RBX: 000000000000a5ee RCX:
00007f44ff534f8b
[ 44.096766][ T8218] RDX: 00007f44ff4e4e88 RSI: 0000000000000009 RDI:
00007ffc50d9a470
[ 44.097530][ T8218] RBP: 00007ffc50d9a470 R08: 0000000000000000 R09:
00007ffc50d9a240
[ 44.098292][ T8218] R10: 00005555717b57b3 R11: 0000000000000202 R12:
00007ffc50d9b500
[ 44.099058][ T8218] R13: 00005555717b5770 R14: 00007ffc50d9a3d8 R15:
00007ffc50d9b560
[ 44.099831][ T8218] </TASK>
[ 44.100138][ T8218] Modules linked in:
[ 44.100537][ T8218] CR2: 0000000000000030
[ 44.100952][ T8218] ---[ end trace 0000000000000000 ]---
[ 44.101472][ T8218] RIP: 0010:write_special_inodes
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr=
.c:208
(discriminator 3))
[ 44.102070][ T8218] Code: 53 e8 6c 30 68 ff 49 8b 45 00 49 39 c5 74
43 48 8d 58 c8 e8 5a 30 68 ff 48 8b 43 10 48 8b 78 30 2e e8 4c 0d 39
03 48 8b 43 28 <48> 8b 78 30 2e e8 3e 0d 39 03 48 8b 83 b0 00 00 00 48
8b 78 30 2e
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 53 push %rbx
1: e8 6c 30 68 ff call 0xffffffffff683072
6: 49 8b 45 00 mov 0x0(%r13),%rax
a: 49 39 c5 cmp %rax,%r13
d: 74 43 je 0x52
f: 48 8d 58 c8 lea -0x38(%rax),%rbx
13: e8 5a 30 68 ff call 0xffffffffff683072
18: 48 8b 43 10 mov 0x10(%rbx),%rax
1c: 48 8b 78 30 mov 0x30(%rax),%rdi
20: 2e e8 4c 0d 39 03 cs call 0x3390d72
26: 48 8b 43 28 mov 0x28(%rbx),%rax
2a:* 48 8b 78 30 mov 0x30(%rax),%rdi <-- trapping instruction
2e: 2e e8 3e 0d 39 03 cs call 0x3390d72
34: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
3b: 48 8b 78 30 mov 0x30(%rax),%rdi
3f: 2e cs

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 48 8b 78 30 mov 0x30(%rax),%rdi
4: 2e e8 3e 0d 39 03 cs call 0x3390d48
a: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
11: 48 8b 78 30 mov 0x30(%rax),%rdi
15: 2e cs
[ 44.103876][ T8218] RSP: 0018:ffff88800f2c3ce8 EFLAGS: 00010286
[ 44.104474][ T8218] RAX: 0000000000000000 RBX: ffff88800e279c00 RCX:
ffffffff814acf4f
[ 44.105248][ T8218] RDX: ffff88800dde3300 RSI: ffffffff814acf5b RDI:
0000000000000005
[ 44.106014][ T8218] RBP: ffff88800f2c3d00 R08: ffff88800a50e3d0 R09:
0000000000000001
[ 44.106771][ T8218] R10: 0000000000000000 R11: 0000000000000001 R12:
ffffffff814b2420
[ 44.107538][ T8218] R13: ffff888040fd5200 R14: ffff888040fd5280 R15:
0000000000000000
[ 44.108300][ T8218] FS: 00005555717b43c0(0000)
GS:ffff88807ee00000(0000) knlGS:0000000000000000
[ 44.109164][ T8218] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 44.109809][ T8218] CR2: 0000000000000030 CR3: 000000000d8fa000 CR4:
0000000000350ef0
[ 44.110572][ T8218] Kernel panic - not syncing: Fatal exception
[ 44.111289][ T8218] Kernel Offset: disabled
[ 44.111722][ T8218] Rebooting in 86400 seconds..

VM DIAGNOSIS:
07:10:48 Registers:
info registers vcpu 0
RAX=3D0000000000000000 RBX=3D0000000000001000 RCX=3Dffffffff814aca55
RDX=3Dffff88800aa46600
RSI=3D0000000000000000 RDI=3D0000000000000001 RBP=3Dffff88800ee03cf8
RSP=3Dffff88800ee03ce0
R8 =3D0000000000001000 R9 =3Dffffea0000b68ac0 R10=3D0000000000000000
R11=3D0000000000000001
R12=3Dffffea0000b68ac0 R13=3D0000000000001000 R14=3D0000000000ed2000
R15=3D0000000000001000
RIP=3Dffffffff8134ec2f RFL=3D00000293 [--S-A-C] CPL=3D0 II=3D0 A20=3D1 SMM=
=3D0 HLT=3D0
ES =3D0000 0000000000000000 00000000 00000000
CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS [-WA]
DS =3D0000 0000000000000000 00000000 00000000
FS =3D0000 00005555717b43c0 00000000 00000000
GS =3D0000 ffff88803ea00000 00000000 00000000
LDT=3D0000 fffffe0000000000 00000000 00000000
TR =3D0040 fffffe0000003000 00004087 00008b00 DPL=3D0 TSS64-busy
GDT=3D fffffe0000001000 0000007f
IDT=3D fffffe0000000000 00000fff
CR0=3D80050033 CR2=3D00007ffc50d99bd8 CR3=3D000000000e6c8000 CR4=3D00350ef0
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
DR3=3D0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000001d01
FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
YMM00=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM01=3D0000000000000000 0000000000000000 00000000ff000000 00000000000000ff
YMM02=3D0000000000000000 0000000000000000 00000000ff000000 00000000000000ff
YMM03=3D0000000000000000 0000000000000000 00007ffc50d9b520 00007ffc50d9b520
YMM04=3D0000000000000000 0000000000000000 0000000000000000 00007ffc50d9b55f
YMM05=3D0000000000000000 0000000000000000 cfff5ffebffcefff d7ffa23fffafff49
YMM06=3D0000000000000000 0000000000000000 1d3ff77236800000 07fec5b8a9ffbb91
YMM07=3D0000000000000000 0000000000000000 ffb2196e227feee7 ffd6adce7ffafff5
YMM08=3D0000000000000000 0000000000000000 7665642f00736672 65646e69622f2e00
YMM09=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM10=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM11=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM12=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM13=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM14=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM15=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
info registers vcpu 1
RAX=3D0000000000000063 RBX=3D0000000000000000 RCX=3D0000000000000000
RDX=3D00000000000003f8
RSI=3Dffffffff82a1d59a RDI=3Dffffffff880cbfc0 RBP=3Dffff88800f2c3828
RSP=3Dffff88800f2c3810
R8 =3D302e34342020205b R9 =3D205b5d3436353336 R10=3D0000000000000063
R11=3D205d383132385420
R12=3Dffffffff880cbfc0 R13=3D0000000000000063 R14=3Dffffffff87fb4b3a
R15=3D0000000000000000
RIP=3Dffffffff82a1d5b1 RFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=
=3D0 HLT=3D0
ES =3D0000 0000000000000000 00000000 00000000
CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS [-WA]
DS =3D0000 0000000000000000 00000000 00000000
FS =3D0000 00005555717b43c0 00000000 00000000
GS =3D0000 ffff88807ee00000 00000000 00000000
LDT=3D0000 fffffe0000000000 00000000 00000000
TR =3D0040 fffffe000003e000 00004087 00008b00 DPL=3D0 TSS64-busy
GDT=3D fffffe000003c000 0000007f
IDT=3D fffffe0000000000 00000fff
CR0=3D80050033 CR2=3D0000000000000030 CR3=3D000000000d8fa000 CR4=3D00350ef0
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
DR3=3D0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000001d01
FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
YMM00=3D0000000000000000 0000000000000000 0000000000989680 0000000000000000
YMM01=3D0000000000000000 0000000000000000 0000000000000000 0000000000989680
YMM02=3D0000000000000000 0000000000000000 00007f44ff5c3bc0 00007f44ff5c3bc0
YMM03=3D0000000000000000 0000000000000000 00007ffc50d9b560 00007ffc50d9b560
YMM04=3D0000000000000000 0000000000000000 0000000000000000 00007ffc50d9b59f
YMM05=3D0000000000000000 0000000000000000 0000000000000000 00007f44ff5b84b0
YMM06=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM07=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM08=3D0000000000000000 0000000000000000 7665642f00736672 65646e69622f2e00
YMM09=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM10=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM11=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM12=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM13=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM14=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000

