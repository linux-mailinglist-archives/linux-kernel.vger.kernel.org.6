Return-Path: <linux-kernel+bounces-301627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6C595F364
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4159280D29
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8650F18858E;
	Mon, 26 Aug 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jupoWjcM"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D7187FFC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680689; cv=none; b=V57i7K42EEz4nc8ix7+zK/oiuVUu03bPGDDZxE9WgDgFkzROjfV2EKPde1NYXmCZqN4UYE973YybHcqu63DnHcvCIazKVgWisIljb8l4SBSw4dLbRNqd4D5biAF8qZD3Iiv35Xk9p4L30OvMcDti2gejNPAjlma1wv/Qu7lOWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680689; c=relaxed/simple;
	bh=A4YSou4tOXvbIuPzLXfypl9njFMcXQewS4CyJQsx7MI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Mzg8YHSDahVwNxdLjqCpqR04LklLXCz5umGTZSgssMe3jh/E49YfKUU3bn6Ug1crqbbIMPP2w6yuGj3kwj1DNYIvdQ3yfOnfDdrGG1WmsNhEUKN18oJwXj19Qj/pKlv+etljrKUaaGYJOkjWUjyYHF4tuXsVj9pf0zzhTJjbFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jupoWjcM; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-498d2c6b5b4so1212213137.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724680686; x=1725285486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3CDS805nHUtFyonKh5PIk1kaPDlOeosb6cbz/9l2QOw=;
        b=jupoWjcMcOOOAq7UCXV3mstxs1jteDYwBqgLr9Au7PSpMuPqNz92j3h+nyv/4sYtcD
         R3sWg6XE0prjER+aaHaCvUFy2CpCfKxmCjXEf/RYh9RMOzNhTLJ+Oegb0e2+so/+EKr6
         Fho5NHKonqHb8i1EMIt7TptkVvs0+of2bBaSWwNlCKFYNDCNENA1VcBGTNyqcP+oGbhL
         ZIy6zt0IZwAgXN26OdfJoMC9ttFm0uQFL0cPO3+sK4TwiDEvenXIdqI61ieJbN33BwrP
         FEuX5ernuahLX2G688NQDoeUJ5akjxB8dHasqFxJIXmLgh0rrdLYylJoEvnZuyMpAais
         hakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680686; x=1725285486;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CDS805nHUtFyonKh5PIk1kaPDlOeosb6cbz/9l2QOw=;
        b=aCq/YFtYP6RIbC5zkE+3UuDCusDDp3G6IvMxxA7Wf6sDlJOGMk0QNZBzp7jhtRe9pm
         1CBmEo1QlrmTF7DHgvPWv8Yw20M2/FJGza5R7YeQ2yqWaULvM+18mowjT4kaTjPrJReZ
         kA11XlUwxKP390hLITP+hIEqOka5BaeBRWp2wq8ZVx0UA6Gkfbz7c53P+Ugyvvfma4dn
         QP0aQxHsuv0+B2dp31JreX+dy0Uh7+P4DiH3sTxOpMrms78tegeTk9jXl7/6CvCanXnO
         Vho5WUMAAiPX0UDOYCg+fRK3/jctygtwshqVjNrrpQ0DJyR7PbeRgElLbBdz914MSojC
         S5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVd4jCYSeoHKEryMjJ0buTr3vIO0yOWkhKAqE9JEGcYjtCwUZHjaPznAFurSziDh4fvZF9s4ObqccCD/CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFbwKiaGEUisDmoZFj9LotwGSQ+l23dchHw064kUjuGxpm2Jn
	wdT4/u7l8Cgdu7XSZ66ynkW/DYRW9msL9PKq6wRsyRHEXVl3Bfy7zdd9inx8tnKCOD+kNqIsk3A
	XKDvKh1xKhnhLe7hAt1sW0y/cPh3MmktjHdcCtg==
X-Google-Smtp-Source: AGHT+IFkcpeAOuBUs2E4wa+6RNK7C+e5xuFrPEf8HQlraPIyedR7HkaKxZf8OYQXei/P8iMoV551RENJbhZbpHUkRu4=
X-Received: by 2002:a67:af09:0:b0:498:f4e1:22ed with SMTP id
 ada2fe7eead31-498f4e1234fmr6104016137.31.1724680686375; Mon, 26 Aug 2024
 06:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 26 Aug 2024 19:27:55 +0530
Message-ID: <CA+G9fYtOaqvOkargaX9qaOHdKbF_EeB49vAJr985kLujm5-cmw@mail.gmail.com>
Subject: LTP: hugemmap19: PF: supervisor read access in kernel mode
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following kernel BUG noticed on x86_64 and qemu-x86_64 while running
LTP hugetlb test cases on Linux next-20240823 and next-20240826 intermittently
This is been noticed with compat mode running 64 bit kernel on 32-bit rootfs.

We will re-investigate these test plan combinations with HUGE_PAGE on
compat mode.

First seen on - not sure - intermittent
  Good: not sure
  BAD:  next-20240826 (intermittent)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Crash log:
--------
hugemmap15.c:123: TINFO: SIGBUS at 0xf5200000 (sig_expected=0xf51fff80)
hugemmap15.c:123: TINFO: SIG[   63.974604] hugemmap19 (460): drop_caches: 3
BUS at 0xf4e00000 (sig_expected=0xf4dfff80)
hugemmap15.c:123: TINFO: SIGBUS at 0xf4a00000 (sig_[   63.987273] BUG:
kernel NULL pointer dereference, address: 0000000000000000
[   63.995130] #PF: supervisor read access in kernel mode
[   64.000269] #PF: error_code(0x0000) - not-present page
[   64.005400] PGD 8000000105996067 P4D 8000000105996067 PUD 0
[   64.011061] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[   64.015765] CPU: 3 UID: 0 PID: 461 Comm: hugemmap19 Not tainted
6.11.0-rc5-next-20240826 #1
[   64.024111] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.7 12/07/2021
[   64.031518] RIP: 0010:mmap_region+0x443/0xcf0
[   64.035908] Code: cd 29 00 85 c0 0f 84 c0 04 00 00 49 c7 c0 f4 ff
ff ff 48 83 7d a0 00 74 af 80 7d 9d 00 0f 85 af 00 00 00 48 8b 9d 50
ff ff ff <48> 8b 04 25 00 00 00 00 83 7b 38 01 74 14 48 3b 43 08 0f 82
fb 00
[   64.054653] RSP: 0018:ffff9fcdc0647ba0 EFLAGS: 00010246
[   64.059879] RAX: 0000000000000000 RBX: ffff9fcdc0647c28 RCX: 000000000000000a
[   64.067012] RDX: ffffffff9d892a02 RSI: ffffffff9d892a02 RDI: ffffffff9d89274f
[   64.074142] RBP: ffff9fcdc0647d90 R08: ffffffffffffffea R09: 00000000f7a00000
[   64.081268] R10: 00000000f7c00000 R11: ffff94ea42ba6000 R12: 00000000f7a00000
[   64.088400] R13: ffff94ea40064ec0 R14: 0000000000000073 R15: ffff94ea428e91e0
[   64.095533] FS:  0000000000000000(0000) GS:ffff94ebafb80000(0063)
knlGS:00000000f7f525c0
[   64.103618] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   64.109356] CR2: 0000000000000000 CR3: 0000000102ba6005 CR4: 00000000003706f0
[   64.116486] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   64.123610] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   64.130736] Call Trace:
[   64.133180]  <TASK>
[   64.135277]  ? show_regs+0x68/0x80
[   64.138709]  ? __die+0x28/0x70
[   64.141766]  ? page_fault_oops+0x17b/0x560
[   64.145858]  ? free_pgtables+0x23e/0x2c0
[   64.149777]  ? do_user_addr_fault+0x2e0/0x600
[   64.154136]  ? exc_page_fault+0x71/0x170
[   64.158060]  ? asm_exc_page_fault+0x2b/0x30
[   64.162247]  ? call_rcu+0x12/0x20
[   64.165564]  ? call_rcu+0x12/0x20
[   64.168876]  ? __call_rcu_common.constprop.0+0x12f/0x390
[   64.174187]  ? mmap_region+0x443/0xcf0
[   64.177938]  do_mmap+0x327/0x5b0
[   64.181201]  vm_mmap_pgoff+0xe6/0x1b0
[   64.184865]  ksys_mmap_pgoff+0x15c/0x1f0
[   64.188784]  __ia32_sys_mmap_pgoff+0x29/0x30
[   64.193056]  ia32_sys_call+0x1ebe/0x27c0
[   64.196981]  __do_fast_syscall_32+0x6e/0x120
[   64.201255]  do_fast_syscall_32+0x37/0x80
[   64.205266]  do_SYSENTER_32+0x23/0x30
[   64.208924]  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
[   64.214410] RIP: 0023:0xf7f57579
[   64.217641] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08
03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 2e 8d b4 26 00 00 00 00 8d b4 26 00
00 00
[   64.236378] RSP: 002b:00000000ffc4c3a0 EFLAGS: 00000286 ORIG_RAX:
00000000000000c0
[   64.243936] RAX: ffffffffffffffda RBX: 00000000f7a00000 RCX: 0000000000200000
[   64.251059] RDX: 0000000000000003 RSI: 0000000000000012 RDI: 0000000000000003
[   64.258184] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[   64.265306] R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000000
[   64.272432] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   64.279558]  </TASK>
[   64.281749] Modules linked in: x86_pkg_temp_thermal
[   64.286627] CR2: 0000000000000000
[   64.289937] ---[ end trace 0000000000000000 ]---
[   64.294547] RIP: 0010:mmap_region+0x443/0xcf0
[   64.298898] Code: cd 29 00 85 c0 0f 84 c0 04 00 00 49 c7 c0 f4 ff
ff ff 48 83 7d a0 00 74 af 80 7d 9d 00 0f 85 af 00 00 00 48 8b 9d 50
ff ff ff <48> 8b 04 25 00 00 00 00 83 7b 38 01 74 14 48 3b 43 08 0f 82
fb 00
[   64.317636] RSP: 0018:ffff9fcdc0647ba0 EFLAGS: 00010246
[   64.322861] RAX: 0000000000000000 RBX: ffff9fcdc0647c28 RCX: 000000000000000a
[   64.329986] RDX: ffffffff9d892a02 RSI: ffffffff9d892a02 RDI: ffffffff9d89274f
[   64.337117] RBP: ffff9fcdc0647d90 R08: ffffffffffffffea R09: 00000000f7a00000
[   64.344240] R10: 00000000f7c00000 R11: ffff94ea42ba6000 R12: 00000000f7a00000
[   64.351364] R13: ffff94ea40064ec0 R14: 0000000000000073 R15: ffff94ea428e91e0
[   64.358512] FS:  0000000000000000(0000) GS:ffff94ebafb80000(0063)
knlGS:00000000f7f525c0
[   64.366592] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   64.372329] CR2: 0000000000000000 CR3: 0000000102ba6005 CR4: 00000000003706f0
[   64.379469] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   64.386604] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   64.393728] note: hugemmap19[461] exited with irqs disabled
expected=0xf49fff80)
hugemmap15.c:123: TINFO: SIGBUS at 0xf4600000 (sig_expected=0xf45fff80)


Crash Log links,
--------
 x86_64 device log -
https://lkft.validation.linaro.org/scheduler/job/7821061#L2049
 x86_64 device log -
https://lkft.validation.linaro.org/scheduler/job/7821898#L2102

 Qemu-x86_64 log -
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24952975/suite/log-parser-test/test/check-kernel-oops-oops-oops-preempt-smp-pti/log

Crash failed comparison:
----------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24954436/suite/log-parser-test/test/check-kernel-oops-oops-oops-preempt-smp-pti/history/

metadata:
----
  git describe: next-20240826
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: 1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lC5Io63H0fgSxxgMVk7RTlr00F/config
  artifact location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lC5Io63H0fgSxxgMVk7RTlr00F/
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lC5Io63H0fgSxxgMVk7RTlr00F/
  toolchain: gcc-13
  arch: x86_64
  LTP url: https://storage.tuxboot.com/overlays/debian/trixie/i386/ltp/20240524/ltp.tar.xz
  rootfs url: https://storage.tuxboot.com/debian/trixie/i386/rootfs.tar.xz

Steps to reproduce:
---------
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2lC5MBjPoo5vifL9EXfsMWCSHfN/reproducer
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2lC5MBjPoo5vifL9EXfsMWCSHfN/tux_plan
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2lC5MDbvH0o3j1TMpyOSDF4alXR/reproducer
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2lC5MDbvH0o3j1TMpyOSDF4alXR/tux_plan


Please let me know if you need more information.

--
Linaro LKFT
https://lkft.linaro.org

