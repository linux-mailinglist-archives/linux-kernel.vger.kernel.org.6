Return-Path: <linux-kernel+bounces-208669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 378839027EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA16E1F22626
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F1D1482F6;
	Mon, 10 Jun 2024 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0EWeKWS"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0EC142E98
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041495; cv=none; b=NJDrQULOcUArKI8Gt3RkRCDjwN9jl4op4DcnJoCt+w//3cfNoHRlwr8+PX8zAbGMOx4+W6YTyzgcKaptlzIBVBQna+b1/9mlUBdOyFmSM9kJyfXwAqmIAcouHBz1Vy/nv8jJHNhYexRA4sPVvFEvmIh4k9zs6+r/uGpngfE1l3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041495; c=relaxed/simple;
	bh=O5ATfU7jPP31nbZeDtvffWobEreFKmunbQHS5p07M7Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TpwmqPcBKyfvyh27ZRfNEM01hLPsjyhyuBveb/d0MK+Olu05Jydn+yasaSiBJA/4ID66uM5X2GHZhvvIx73vAectuHwsC+j4V0HXTOrN1E1YUBAU4YG0Q9gUkWN88WyeCB6cakTx/sQ9uq0ccT6/CtZhNFJItobk7y1Z0eAxBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0EWeKWS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44051a92f37so24081341cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718041493; x=1718646293; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X4Ar6Y+IfYfYh/Lslpr1g6uSdKMpAIwXMh69kGy9PdQ=;
        b=O0EWeKWSVBRowXKMDeF6WMA7xXh13syosMyAJoLN41hovKR2PObhQnQsBVVxYq5m5H
         zeczzUT2uWPq6XhAf8n5bQDLK6xX7x4ye02hvGsJ3dLpOSPXe/AB4+H8OjiTVg0yX59e
         pzsVJqt9VQN827FhcaSc+9ZDmLOILvMUt3DZSdfwjDrD6P+ey20KHMbFFHnNaZezOQax
         e8/pKO5rT/Un55Ea+Xh152TcxGjExrlVDLhlTDAdHqjdA9CAWQZqrJ1X5pvUpcdsVdb6
         /F788++k4CiH8X0PNu0OPQvqohMxXwkDMkogRJGRMxdlSXUswEZ7eWOm/UzLw9Ju8tKF
         ErNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718041493; x=1718646293;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4Ar6Y+IfYfYh/Lslpr1g6uSdKMpAIwXMh69kGy9PdQ=;
        b=ZxZ7d5KiEBJTV5QH15nDoO2ej+Mhdt5bOR2OG1Li0iURPsKyK/b1aLYPdylOa79mGc
         w1sIfm32fHcaMTApPF1C4gZzxJyxjZNqSbAJFoYjV8Q2xtVPawp7tvwCSEYjgKIz44r1
         yQjGVnCCiFlMg8bJR+3fP3Q/igepo7dYEwVcbl1q8R5h/6hLuMNpNhF0qkawR1x/Ush4
         qHjdyDTIx5KQNHGo2sy27k0RTcNuAIiCtZs7Txu0Rc53UH7bTL43F3GiEL9GvyFhtIM2
         PDxc+KPhoQuxBNAycf78DIeh7iwam8MDIe9TXveuNHRXlE9VIZ9g0s0R3kRo165Jy2cL
         HVTg==
X-Forwarded-Encrypted: i=1; AJvYcCVdGPwxHPZIEA7JEQ38B72mkdwH8td5xzgcvH8kg4BWYkphu7PP4WfVczGQM9FDjATO9BDs0kYX4IwMAhsvhk1ltTnLiQDYX1LKwIhS
X-Gm-Message-State: AOJu0YxJUpo8I+dEvUPFN0wbdkRjyxIxycnq+6ilggT/IJEXJ/WIkQlL
	LVjOKKa/chfMcyuutBAesUGSrzY4Wi7SvlZL/tZEF9bURqjYe9VAjnd/m2uzrtKPQ+xivdQ6jJk
	tvTAiSOvpuKdzgyspT8yPXMdWOxo=
X-Google-Smtp-Source: AGHT+IFjgBI/thOToXIANuiSeCxT+5iVxixXL9tS7e/k7l8+pc+A1/0UmJLxiagGeYXPpPUuD5Pbn1n7mhTCHzgbzjk=
X-Received: by 2002:ac8:5a86:0:b0:440:f54d:1bbb with SMTP id
 d75a77b69052e-4413ab6eac9mr6663441cf.4.1718041492648; Mon, 10 Jun 2024
 10:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhang Zhiyu <zhiyuzhang999@gmail.com>
Date: Tue, 11 Jun 2024 01:44:41 +0800
Message-ID: <CALf2hKuFn3g3Mg3kC1PiyGYZ5WdScF=+n-8DnYdsAuSLh48amQ@mail.gmail.com>
Subject: [Kernel 6.9.3 BUG] general protection fault in jfs_ioc_trim (bad page state)
To: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi upstream maintainers and community,

We found a Linux kernel bug with our modified Syzkaller.

===================== Meta info =====================
Found version: 6.8
Affected files: fs/jfs/ioctl.c:131, fs/jfs/super.c:194
Reproduced version: 6.8 ~ 6.9.3 ~ 6.10-rc3 (with or without sanitizers)
Kernel config (e.g. for 6.9.3 with sanitizers disabled):
https://drive.google.com/file/d/1pJS6B2cMVX1XYIBUgSwpcG-vsb8MCQ-g/view?usp=sharing
Syz reproducer:
https://drive.google.com/file/d/1nz0jTx3-9FYGJ9ePyNmp46IuO-10WGZQ/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1vqXhsSPDQX1l5DkaJYI92dEYwCnbDCqs/view?usp=sharing
Reproduction console output:
https://drive.google.com/file/d/1daq8GayqgVavEdofVLQQhyeLdU-jPm6H/view?usp=sharing

================== How to reproduce ==================
1. Create a image with syzkaller create-image.sh and boot it (or using
an existing one is ok)
2. Compile the repro.c with gcc and scp to qemu vm
3. Execute the repro and observe the bug backtrace looping.

======================= Report ======================
[copy from console output]
 [?2004hroot@syzkaller:~# ./bd08f46
 [?2004l
[  282.651266][   T30] audit: type=1400 audit(1718036000.960:9): avc:
denied  { execmem } for  pid=7748 comm="bd08f46"
scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:system_r:kernel_t:s0 tclass=process permissive=1
[  282.836121][ T7749] loop0: detected capacity change from 0 to 32768
[  282.927686][ T7748] BUG: Bad page state in process bd08f46  pfn:5e2ab
[  282.928954][ T7748] page: refcount:0 mapcount:0
mapping:0000000000000000 index:0x3 pfn:0x5e2ab
[  282.930357][ T7748] flags:
0x4fff1800000820c(referenced|uptodate|workingset|private|node=1|zone=1|lastcpupid=0x7ff)
[  282.935368][ T7748] page_type: 0xffffffff()
[  282.936424][ T7748] raw: 04fff1800000820c dead000000000100
dead000000000122 0000000000000000
[  282.938473][ T7748] raw: 0000000000000003 ffff8880614fd558
00000000ffffffff 0000000000000000
[  282.940469][ T7748] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
[  282.941989][ T7748] page_owner tracks the page as allocated
[  282.943817][ T7748] page last allocated via order 0, migratetype
Unmovable, gfp_mask 0x40c40(GFP_NOFS|__GFP_COMP), pid 7749, tgid 7749
(bd08f46), ts 282878748769, free_ts 282874052762
[  282.946592][ T7748]  post_alloc_hook+0x15c/0x180
[  282.947449][ T7748]  get_page_from_freelist+0x19d2/0x1b40
[  282.948414][ T7748]  __alloc_pages+0x117/0x2d0
[  282.949224][ T7748]  alloc_pages_mpol+0x266/0x380
[  282.950079][ T7748]  folio_alloc+0xd7/0x100
[  282.950832][ T7748]  do_read_cache_folio+0x8e/0x550
[  282.951711][ T7748]  do_read_cache_page+0x31/0x150
[  282.952644][ T7748]  __get_metapage+0x16f/0x8f0
[  282.953472][ T7748]  dbAdjCtl+0xa2/0x400
[  282.954196][ T7748]  dbAllocDmapLev+0x1f2/0x2d0
[  282.955018][ T7748]  dbAllocCtl+0x8c/0x4e0
[  282.955754][ T7748]  dbAllocAG+0xe5/0x590
[  282.956480][ T7748]  dbDiscardAG+0x1e4/0x500
[  282.957257][ T7748]  jfs_ioc_trim+0x161/0x1b0
[  282.958055][ T7748]  jfs_ioctl+0x13a/0x1c0
[  282.958776][ T7748]  __se_sys_ioctl+0xc0/0x130
[  282.959591][ T7748] page last free pid 7749 tgid 7749 stack trace:
[  282.960700][ T7748]  free_unref_page_prepare+0x433/0x4d0
[  282.961651][ T7748]  free_unref_page+0x35/0x250
[  282.965020][ T7748]  lmLogShutdown+0x1a2/0x2c0
[  282.965827][ T7748]  lmLogClose+0xf9/0x200
[  282.966574][ T7748]  jfs_remount+0x1e6/0x2b0
[  282.967358][ T7748]  reconfigure_super+0x1da/0x3e0
[  282.968225][ T7748]  __se_sys_fsconfig+0x6a6/0x860
[  282.969094][ T7748]  do_syscall_64+0xf8/0x240
[  282.969897][ T7748]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  282.971238][ T7748] Modules linked in:
[  282.971914][ T7748] CPU: 1 PID: 7748 Comm: bd08f46 Not tainted 6.9.3 #1
[  282.973065][ T7748] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  282.974753][ T7748] Call Trace:
[  282.975319][ T7748]  <TASK>
[  282.975821][ T7748]  dump_stack_lvl+0x12e/0x1e0
[  282.976645][ T7748]  bad_page+0xde/0xf0
[  282.977339][ T7748]  free_unref_page_prepare+0x4a9/0x4d0
[  282.978283][ T7748]  free_unref_folios+0x116/0x580
[  282.979127][ T7748]  folios_put_refs+0x417/0x480
[  282.979970][ T7748]  truncate_inode_pages_range+0x1ed/0x9d0
[  282.980977][ T7748]  ? debug_object_active_state+0x53/0x150
[  282.981988][ T7748]  dbUnmount+0x60/0x90
[  282.982710][ T7748]  jfs_umount+0xe3/0x1a0
[  282.983454][ T7748]  jfs_put_super+0x63/0xf0
[  282.984226][ T7748]  ? __pfx_jfs_put_super+0x10/0x10
[  282.985124][ T7748]  generic_shutdown_super+0x9b/0x180
[  282.986024][ T7748]  kill_block_super+0x1e/0x50
[  282.986850][ T7748]  deactivate_locked_super+0x5f/0xd0
[  282.987764][ T7748]  cleanup_mnt+0x1a0/0x210
[  282.988541][ T7748]  task_work_run+0x106/0x150
[  282.989314][ T7748]  syscall_exit_to_user_mode+0x170/0x370
[  282.990290][ T7748]  do_syscall_64+0x105/0x240
[  282.991096][ T7748]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  282.992106][ T7748] RIP: 0033:0x7fdf212d8aa7
[  282.992875][ T7748] Code: 23 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66
0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b9 23 0d 00 f7 d8
64 89 01 48
[  282.996131][ T7748] RSP: 002b:00007ffecb179c38 EFLAGS: 00000202
ORIG_RAX: 00000000000000a6
[  282.997553][ T7748] RAX: 0000000000000000 RBX: 0000000000000000
RCX: 00007fdf212d8aa7
[  282.998903][ T7748] RDX: 0000000000000009 RSI: 0000000000000009
RDI: 00007ffecb179ce0
[  283.000244][ T7748] RBP: 00007ffecb17ad20 R08: 00007fdf2136c040
R09: 00007ffecb179ad0
[  283.001579][ T7748] R10: 00007fdf2136bfc0 R11: 0000000000000202
R12: 00000000004012c0
[  283.002925][ T7748] R13: 0000000000000000 R14: 0000000000000000
R15: 0000000000000000
[  283.004275][ T7748]  </TASK>

====================== Analysis ======================
gdb debug screenshots:
1. gdb backtrace:
https://drive.google.com/file/d/14KDOYjUtVxe-ugYPc_MTmlCGHydOQav1/view?usp=sharing
2. gdb print page->flags:
https://drive.google.com/file/d/1tMiAkb1DjJ-YkaEyPkMWAVnt1AgrMx58/view?usp=sharing

Possible root cause: A page was marked as allocated by page_owner
during page releasing in jfs_umount by mistake, which leads to the
badpage check through free_page_prepare.

Unfortunately, we did not find more information about the root cause.
Hope the attached files would be of help for addressing this bug. And
please let me know for anything I can help.

Best,
Zhiyu Zhang

