Return-Path: <linux-kernel+bounces-301576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 626F495F2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7952B20ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A7C185945;
	Mon, 26 Aug 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3eF7vgc"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC377F0B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678452; cv=none; b=H//VFJiAakibPch4D6x003+iGP8lw9HAMIYG4Kc/FgN+LChJnt94UiifrE7vHMdyNA6JgBB3lFvd9lEG7xxYNa+k8ZsGB8tQtXvLrZ4LiqBrHDPDoe1wTUm+lbJemefkL/8vage1SeWZtAhdxWLam2N0Df/fcore/UBd1DUFtb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678452; c=relaxed/simple;
	bh=yDo35u0eByMPHO8M0n5dtlK30SfHuw3kMzMtDu2kQpA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hR/8CqBMSBmjoAREkiOj6N+2nSWkU8GbCzYXlwG1e8xbRHZOh3/JiZpNos6X3yPp36JqepTPPo3ub4X5vo6ozHwSyKnMsjBuop8QxClfmxb/XYAZNXDSdQQZn2rgCwJzWgrH8ts9TQh44t9emRuJ/6IRuQ7An3bDcsS580Mfig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X3eF7vgc; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4fcf4ae95dbso1578577e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724678449; x=1725283249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eD175XUZ/ITy7ZdWAydNT67+uOxIgoWBm9/vtDXzUTA=;
        b=X3eF7vgcvRx0xK9T8qpcyEvX3F9Zbm28T3IOMYtJErJUDvHGmqCJ8oK4ssYFZQcXv6
         EmpZqba5kVaRSTszD/6Z22SGHZjJ/9nu2AnsHZ8KOf4QsMUZJo03dVgGJDNte/SmIWRk
         O52iZzCi6tlecXsnsWbMKwWHs7mwLo5/5+xyeJU6rJFk+prEWDWObIPTMbTyZdZJeOV4
         Wgt/t+LPxzXFTZ+Y/x5FcmQUNAwZwDWHcpDKMkRk3jEzO/kzfYJcMGgcPGLiEAH2VyF1
         BoSAC41U+H7Xay6X3bmD3PEiuDIk/ze4feWqjoNvwHbcK8HpsSv/NXgdnxfW1afhRVBP
         tSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724678449; x=1725283249;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eD175XUZ/ITy7ZdWAydNT67+uOxIgoWBm9/vtDXzUTA=;
        b=RuBz5yRkaxdZfjRhsZ6lS6I5A/wzzgp0HbtfO7mhtpv0DPpEgIzUPzWUd6IbfB5X9E
         qT4/G1boiuZQXP0SmTGJ6p9bvOHEq8kK4DY/ZxgfFkzMYWhfUu9RgEYoqXX1OdGtYdD5
         T8Q5zOYCz5tmyd/vbq+V46sXOj3VJRafwPbIWxj7il/hKgt0d5HThG1BZm2CiewvhXja
         E7wjtAkDAMe2oG/jJ/YwW+UppNcK3qFlEvPFjawQDR/MHY8I8SfFuLmMW7lNsrl87ROY
         iBXbqkyrX6wsmPf8THQ0uXPTV3cqVmFqIAaHLin+U47t1DhaviQ04VrRzbSpbGSX+NyA
         0Dyw==
X-Gm-Message-State: AOJu0YzsX9GFcte40yZxPnE5QQ7EclbdIQETRQ16W6Ti4slWBMwMwk3V
	0gpBjrWzQJK/rNLY6MHGxvMEO7IcK7yy8IRlVf+85BAIOazCHI7EOqYIjjhyi1FLQSszE88IV6d
	MAxgbYXKFT0zkzAOKujw85f8ERsYwRn1DCZ5uepsExqf/4ruYfX4=
X-Google-Smtp-Source: AGHT+IHfLYQXJQalFGVZVOgOn/tn6bOUOwnoI9D+YmaRkON0wOcbu81fZMRkrl/+m2cVQflgktyC19x+8RBVqWzPqMk=
X-Received: by 2002:a05:6122:3d08:b0:4f5:28e3:5a5a with SMTP id
 71dfb90a1353d-4fd1a522b94mr12978602e0c.4.1724678449179; Mon, 26 Aug 2024
 06:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 26 Aug 2024 18:50:37 +0530
Message-ID: <CA+G9fYvcBvbabg+m7brKfpGCGZUcK+KHHTFX7hFvW6GmN2XF0g@mail.gmail.com>
Subject: selftests: core: unshare_test: WARNING: at mm/util.c:671 __kvmalloc_node_noprof
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, LTP List <ltp@lists.linux.it>
Cc: Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Barry Song <baohua@kernel.org>, 
	Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following kernel warning is noticed on all arch and all devices while
running selftests: core: unshare_test on Linux next-20240823 and next-20240826.

First seen on next-20240823.
  Good: next-20240822
  BAD:  next-20240823 and next-20240826

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Crash log:
--------
# selftests: core: unshare_test
<4>[   61.084149] ------------[ cut here ]------------
<4>[ 61.085175] WARNING: CPU: 0 PID: 477 at mm/util.c:671
__kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
<4>[   61.088958] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 drm fuse backlight dm_mod ip_tables x_tables
<4>[   61.093141] CPU: 0 UID: 0 PID: 477 Comm: unshare_test Not
tainted 6.11.0-rc5-next-20240826 #1
<4>[   61.094558] Hardware name: linux,dummy-virt (DT)
<4>[   61.096763] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[ 61.097841] pc : __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
<4>[ 61.099701] lr : __kvmalloc_node_noprof (mm/util.c:661)
<4>[   61.100448] sp : ffff800080abbce0
<4>[   61.100819] x29: ffff800080abbcf0 x28: fff0000004549280 x27:
0000000000000000
<4>[   61.101744] x26: 0000000000000000 x25: 0000000000000000 x24:
fff0000003615e40
<4>[   61.102512] x23: fff0000003615ec0 x22: bfafa45863b285c8 x21:
0000000200002000
<4>[   61.103232] x20: 00000000ffffffff x19: 0000000000400cc0 x18:
0000000000000000
<4>[   61.104053] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
<4>[   61.104927] x14: 0000000000000000 x13: 0000000000000000 x12:
0000000000000000
<4>[   61.105752] x11: 0000000000000000 x10: 0000000000000000 x9 :
0000000000000000
<4>[   61.106606] x8 : 0000000000000001 x7 : 0000000000000001 x6 :
0000000000000005
<4>[   61.107377] x5 : 0000000000000000 x4 : fff0000004549280 x3 :
0000000000000000
<4>[   61.108207] x2 : 0000000000000000 x1 : 000000007fffffff x0 :
0000000000000000
<4>[   61.109262] Call trace:
<4>[ 61.109619] __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
<4>[ 61.110248] alloc_fdtable (fs/file.c:133)
<4>[ 61.110751] expand_files
(include/linux/atomic/atomic-arch-fallback.h:457
include/linux/atomic/atomic-instrumented.h:33 fs/file.c:177
fs/file.c:238)
<4>[ 61.111171] ksys_dup3 (fs/file.c:1337)
<4>[ 61.111596] __arm64_sys_dup3 (fs/file.c:1355)
<4>[ 61.112006] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:54)
<4>[ 61.112480] el0_svc_common.constprop.0
(include/linux/thread_info.h:127 (discriminator 2)
arch/arm64/kernel/syscall.c:140 (discriminator 2))
<4>[ 61.112955] do_el0_svc (arch/arm64/kernel/syscall.c:152)
<4>[ 61.113384] el0_svc (arch/arm64/include/asm/irqflags.h:55
arch/arm64/include/asm/irqflags.h:76
arch/arm64/kernel/entry-common.c:165
arch/arm64/kernel/entry-common.c:178
arch/arm64/kernel/entry-common.c:713)
<4>[ 61.113742] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
<4>[ 61.115181] el0t_64_sync (arch/arm64/kernel/entry.S:598)
<4>[   61.115709] ---[ end trace 0000000000000000 ]---


Crash Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/log

Crash failed comparison:
----------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/history/

metadata:
----
  git describe: next-20240823 and next-20240826
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: c79c85875f1af04040fe4492ed94ce37ad729c4d
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2l2pZRzhgRkPgXIKLJCI7vwVd6t/config
  artifact location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2l2pZRzhgRkPgXIKLJCI7vwVd6t/
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2l2pZRzhgRkPgXIKLJCI7vwVd6t/
  toolchain: clang-18 and gcc-13

Steps to reproduce:
---------
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2l2paZVYTloIDBYnua1s12DeIic/reproducer
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2l2paZVYTloIDBYnua1s12DeIic/tux_plan

Please let me know if you need more information.

--
Linaro LKFT
https://lkft.linaro.org

