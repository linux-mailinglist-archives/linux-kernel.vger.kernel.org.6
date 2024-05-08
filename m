Return-Path: <linux-kernel+bounces-173134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1508BFBFB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB011F223C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE64981AA2;
	Wed,  8 May 2024 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckIRElua"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832581ABE
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167766; cv=none; b=l5vCSq1KQqZp9APA/4yWinV+kBChWuu9RsyUkqd6wwGzTm4T34src4azL0q27/xrtInWIbvoipSoZB8LjG4/PcumnhohJlR3f/NEdbhyPUhK/s/Y27CTW2Vuf8KuvJbyDmECul3QUUw4lJ1bGrLzXAJCP05LKtdwIeIPVPaFyto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167766; c=relaxed/simple;
	bh=o1P08wRN5zgIFHUzBZZbjDk7vYIB/bRy0pNZCySSAJM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mPvxWklt3BRIXGnWOnZuDlG21eVmUCbbFyi9RLbyNRaZ6tF9REKz3PAX53sZz3YY9lZP9bS85zMZvccbEF2Ur7a68JIjuUOEkVQwsG5SN1PiXnU2YshuSVMfNadACkIt092tDN5R5rQ2dJi7QuCSvgul+hkPScz6iecrc/exvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ckIRElua; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4df2630c49dso1239504e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715167763; x=1715772563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hQ/p1VPhOxx8AauRV82BX+Y5UWsefLJrJMnijX2piSg=;
        b=ckIREluaOu/kHw1qgw5Pf9nrD2b9+HWaWTVCFoTMlyoO5cS3SX/AiHlcNhmhF8U9nz
         6r/brF8YjSi2WrErGamudbBFOf2pQnATA47TNYw3CZ3yJUM2+jRBA90dsBxCI7gDrMXq
         aClbyxw3S5CGDMjMviipEj1ZM7QLrLW5vzt4ZXN7VjrYY7XReDpOv65dHN33WZsVmd1b
         8SMuyWrguqV0PVaWdtJ3+M8pEg4zaCoZv5hlaLwXIE53NBivyNrEUwkuYUOWz9mHqVJB
         C2Vi8LQq8lCYILP2XwK8vL540Wbhh4/LSZpvXfLzmg4bDpzPr4WZfLXG8ffttWHw0lCv
         NFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167763; x=1715772563;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQ/p1VPhOxx8AauRV82BX+Y5UWsefLJrJMnijX2piSg=;
        b=a4W8sj0mxc+7049LFPqQzu5Z5MV0uLlwKxvmJZQN4L3NJMCQ8D44gqJZkfyYRlF35j
         MRv6hHkwtAQtaMnb6VH5dfmXVC7Pz23CrxmzZEzXxbB1LE2tKoI/lyvSk5I9of0aFuja
         tHhu8o7GTqfAMSPSwqCd1edNqMuVHFk3d70m96nASijg7xapMVZRXJgUOw5QEqpMUfGL
         23weOTVXURZWcoCMnZZvblALl4bLsIwSk1cS5BdJY4PoXuqO9FaB1fvLjAxuJiMyM3dv
         8BgYmgWkTRJnVRYL9Vx2LqjLlkOabY+mdc0LX9jX95OKgMlsewCDsNXmJy9Oq9AQd1S8
         B+sg==
X-Gm-Message-State: AOJu0Yw1JVcjCFYJZH98snWSNZVinyHQGbtInjqaCVag7UG120Avhvrf
	CzwH7k/RM5g3UqG97f26+xGj/Y/42wAhrpna0QTFPnSlvk7RP+/aIMpLvsNUz4bLL5rsLCdWICX
	JrWZnTbOuuyAmBUUiAFKUnBhQFyiLQ8x/GdcXFNswWs2lrhDOBHk=
X-Google-Smtp-Source: AGHT+IGJ+T6/99q0ZQKInq6ADBUWPxJxgpXgRQ2dnLje77bkTFuLwMf08tMOi+Ajkvwo9Obpe7o/02KWJU5vShsVCaQ=
X-Received: by 2002:a05:6122:4595:b0:4c8:8d45:5325 with SMTP id
 71dfb90a1353d-4df6918905emr2499319e0c.7.1715167762554; Wed, 08 May 2024
 04:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 8 May 2024 16:59:10 +0530
Message-ID: <CA+G9fYvOjtEBtB21FwFmvbautebx_2Py-tjqduPcWyS5B9nB5w@mail.gmail.com>
Subject: next: kasan: Unable to handle kernel paging request at virtual address
To: open list <linux-kernel@vger.kernel.org>, kunit-dev@googlegroups.com, 
	lkft-triage@lists.linaro.org
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Guenter Roeck <linux@roeck-us.net>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

While running kunit tests on arm64 and x86_64 the following kernel BUG
noticed on running Linux next-20240508 kernel and stride tests failed.

observations:
1) The null pointer dereference notice while running kunit_test
2) The stride test case failed on today's linux next-20240508 tag.

The detailed log provided in the links below.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Crash log:
--------

<6>[   43.086497]     KTAP version 1
<6>[   43.087004]     # Subtest: kunit_fault
<6>[   43.087577]     # module: kunit_test
<6>[   43.087748]     1..1
<1>[   43.092588] Unable to handle kernel paging request at virtual
address dfff800000000000
<1>[   43.093687] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
<1>[   43.094770] Mem abort info:
<1>[   43.095425]   ESR = 0x0000000096000005
<1>[   43.097071]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[   43.098034]   SET = 0, FnV = 0
<1>[   43.098542]   EA = 0, S1PTW = 0
<1>[   43.099104]   FSC = 0x05: level 1 translation fault
<1>[   43.099837] Data abort info:
<1>[   43.100679]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
<1>[   43.101535]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[   43.102321]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[   43.103287] [dfff800000000000] address between user and kernel
address ranges
<0>[   43.105111] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
<4>[   43.106046] Modules linked in:
<4>[   43.108961] CPU: 1 PID: 375 Comm: kunit_try_catch Tainted: G
            N 6.9.0-rc7-next-20240508 #1
<4>[   43.110433] Hardware name: linux,dummy-virt (DT)
<4>[   43.111555] pstate: 82400009 (Nzcv daif +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[   43.113232] pc : kunit_test_null_dereference+0x2c/0x114
<4>[   43.114785] lr : kunit_generic_run_threadfn_adapter+0x84/0x104
<4>[   43.115692] sp : ffff800080ff7dd0
<4>[   43.116646] x29: ffff800080ff7de0 x28: 0000000000000000 x27:
1ffe000018f1db69
<4>[   43.117953] x26: dfff800000000000 x25: ffff943388e90ab8 x24:
0000000000000001
<4>[   43.119037] x23: 1ffe000018a7a771 x22: dfff800000000000 x21:
dfff800000000000
<4>[   43.120659] x20: ffff943388e9d5a0 x19: fff00000c53d3b88 x18:
ffff800080097930
<4>[   43.121669] x17: ffff943388e905e4 x16: ffff94338837d7e4 x15:
0000000000000001
<4>[   43.122762] x14: 1ffe000018f1dc59 x13: 0000000000000000 x12:
0000000000000000
<4>[   43.123881] x11: fffd800018f1dc5a x10: dfff800000000000 x9 :
1ffe000018a7a772
<4>[   43.125204] x8 : 7c0c8af2c07cc400 x7 : 0000000000000000 x6 :
72745f74696e756b
<4>[   43.126291] x5 : fff00000c53d45d6 x4 : 0000000000000000 x3 :
ffff94338acf91b4
<4>[   43.127380] x2 : 0000000000000001 x1 : 0000000000000001 x0 :
ffff800080087af8
<4>[   43.129375] Call trace:
<4>[   43.129852]  kunit_test_null_dereference+0x2c/0x114
<4>[   43.130621]  kunit_generic_run_threadfn_adapter+0x84/0x104
<4>[   43.131480]  kthread+0x268/0x3a4
<4>[   43.132390]  ret_from_fork+0x10/0x20
<0>[   43.133497] Code: d2d00015 f9426508 f2fbfff5 f90007e8 (39c002a8)
<4>[   43.134637] ---[ end trace 0000000000000000 ]---
<3>[   43.136227]     # kunit_test_fault_null_dereference: try
faulted: last line seen lib/kunit/kunit-test.c:95

<trim>

<6>[   98.315793]         KTAP version 1
<6>[   98.317173]         # Subtest: stride
<4>[   98.320844] regmap_test stride.regmap_test: No cache used with
register defaults set!
<3>[   98.323706]
==================================================================
<3>[   98.325683] BUG: KASAN: slab-out-of-bounds in stride+0x698/0x8a8
<3>[   98.326518] Write of size 1 at addr fff00000c7b3320b by task
kunit_try_catch/1143
<3>[   98.328402]
<3>[   98.329468] CPU: 0 PID: 1143 Comm: kunit_try_catch Tainted: G
  D          N 6.9.0-rc7-next-20240508 #1
<3>[   98.330560] Hardware name: linux,dummy-virt (DT)
<3>[   98.331400] Call trace:
<3>[   98.332216]  dump_backtrace+0xf0/0x128
<3>[   98.332815]  show_stack+0x18/0x24
<3>[   98.333475]  dump_stack_lvl+0x40/0x84
<3>[   98.334187]  print_report+0x16c/0x728
<3>[   98.334887]  kasan_report+0xd8/0x134
<3>[   98.335589]  __asan_report_store1_noabort+0x20/0x2c
<3>[   98.337089]  stride+0x698/0x8a8
<3>[   98.337739]  kunit_try_run_case+0x118/0x31c
<3>[   98.338574]  kunit_generic_run_threadfn_adapter+0x84/0x104
<3>[   98.339529]  kthread+0x268/0x3a4
<3>[   98.340427]  ret_from_fork+0x10/0x20
<3>[   98.341331]
<3>[   98.341826] Allocated by task 1143:
<4>[   98.342644]  kasan_save_track+0x40/0x78
<4>[   98.343269]  kasan_save_alloc_info+0x44/0x54
<4>[   98.344067]  __kasan_kmalloc+0x84/0x9c
<4>[   98.345005]  __kmalloc_noprof+0x208/0x3a4
<4>[   98.346322]  __regmap_init_ram+0x70/0x158
<4>[   98.347113]  gen_regmap+0x3a4/0x554
<4>[   98.347878]  stride+0x78/0x8a8
<4>[   98.348639]  kunit_try_run_case+0x118/0x31c
<4>[   98.349326]  kunit_generic_run_threadfn_adapter+0x84/0x104
<4>[   98.350315]  kthread+0x268/0x3a4
<4>[   98.350983]  ret_from_fork+0x10/0x20
<3>[   98.351734]
<3>[   98.352257] The buggy address belongs to the object at fff00000c7b33200
<3>[   98.352257]  which belongs to the cache kmalloc-16 of size 16
<3>[   98.354108] The buggy address is located 0 bytes to the right of
<3>[   98.354108]  allocated 11-byte region [fff00000c7b33200, fff00000c7b3320b)
<3>[   98.355956]
<3>[   98.356752] The buggy address belongs to the physical page:
<4>[   98.357945] page: refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x107b33
<4>[   98.359143] flags: 0xbfffe0000000000(node=0|zone=2|lastcpupid=0x1ffff)
<4>[   98.360819] page_type: 0xffffefff(slab)
<4>[   98.362282] raw: 0bfffe0000000000 fff00000c0001640
dead000000000122 0000000000000000
<4>[   98.363246] raw: 0000000000000000 0000000080800080
00000001ffffefff 0000000000000000
<4>[   98.364762] page dumped because: kasan: bad access detected
<3>[   98.365543]
<3>[   98.365944] Memory state around the buggy address:
<3>[   98.367010]  fff00000c7b33100: fa fb fc fc fa fb fc fc fa fb fc
fc fa fb fc fc
<3>[   98.368304]  fff00000c7b33180: fa fb fc fc fa fb fc fc fa fb fc
fc fa fb fc fc
<3>[   98.369228] >fff00000c7b33200: 00 03 fc fc 00 03 fc fc fc fc fc
fc fc fc fc fc
<3>[   98.370208]                       ^
<3>[   98.370915]  fff00000c7b33280: fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc fc
<3>[   98.372179]  fff00000c7b33300: fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc fc
<3>[   98.373119]
==================================================================
<6>[   98.379784]         not ok 1 none-default @0x0
<6>[   98.387715]         ok 2 flat-default @0x0
<6>[   98.396608]         ok 3 rbtree-default @0x0
<6>[   98.403430]         ok 4 maple-default @0x0
<6>[   98.405635]     # stride: pass:3 fail:1 skip:0 total:4
<6>[   98.406235]     not ok 11 stride

Links:
----
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2gB3M3nlA8sWzr9GBuN7rCQHsPH/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240508/testrun/23827533/suite/log-parser-boot/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240508/testrun/23827533/suite/log-parser-boot/test/check-kernel-bug/log
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2gB3N9JXfJ181Hm9cmchZm9q53F

metadata:
--
  arch: arm64
  environment: qemu-arm64
  git_describe: next-20240508
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next


--
Linaro LKFT
https://lkft.linaro.org

