Return-Path: <linux-kernel+bounces-347391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B398D20C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D0B2820E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263831EBFE6;
	Wed,  2 Oct 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5riImhw"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9519D07D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727867451; cv=none; b=nR7/epQcuk+D5y/gRATgQOZBkucULfG9l/SVtrRYA3ZaFopc8liU2HumbGm59MvvW+SBxMWEye2MKs9uuMpSBr2laU8uqiSwsF2VlbW2KlvEZdchKoMo0ufZXV7aFOpjVzdaIjGqOzbBKqFCVJ/CN55/f5ceHHqtdJY/dNP2//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727867451; c=relaxed/simple;
	bh=Xa+lW0fjqVmBEgZJFM3xdIUf1yL8qSpAWWexKBzHebE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MuSecxfVeS5frni5dqVsx4eRhiO++Huvkok21pcFPgkODK+fRn+CUd6hReO5DWbNli5IvxlyyAkC74N/H2gOhgtCB0tACqbzyCHtPsjLuiQzljiPyiNP/En6SbDMFBC8J7lp9cBhGajTizxTmPhVOS49mInAgmMDYE6K4tX9iFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s5riImhw; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4a3be8c420cso1106926137.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727867448; x=1728472248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2kGi5asJjvPPSghlJTF20OUed1yXJQ8MjIuBXcPNa8c=;
        b=s5riImhw/6JUfH5c24Zkk6z7qNddm3cuKVjr3fOKJYViNCyiuECjIcItsJLeBPI27l
         q0WpFbBAYIq1nvX6rNNJ37esuHzBULcAGRHdWPYUO90R3PEnN/NikBiogFlWMR2hbZR5
         kPtTkMiA6yQoV/3bJuXF0eb01N5zEBf22Bunhso2RZfrTrIdv53cP/f+6bTPT7C46e32
         BqiWEkucJrXxSlarIQNi737fJAt5QxJ+eyOA0XsrFb1D764RdNJ5ZOj0DieXDM0+k2m3
         D+5VVugmxMJnAB4YWs2XLLmUsTEaYxdW9LSK0Ho5Fv8VGVSZI3dYV8EIkhZKivXfqnXu
         B4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727867448; x=1728472248;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kGi5asJjvPPSghlJTF20OUed1yXJQ8MjIuBXcPNa8c=;
        b=CW/jTDTxO//Irbh5Y9RNh7SCXXdP9vJh3butBJZQTBGOq5zp7UM4o8KrJ97CBM+7se
         czdfHzI7zixazgr45KRqMktd5S2WtXnB12YJNrBkeK7Eshlx8csjwPOZFNcpt3RSxIHl
         tdzVKwcraaV0OqpSyyHeja6TRNHR3o6AagYE/1km4ogQOxD0fZmYtHm3VCmctvgsUWW1
         a4/uSAtQDPMInmRV5vYLTJVRcvnqhquerc3kUVReTJIpOJi+gLxjd/K6UKk3YuBciuXg
         +vH94bpqF68C9B51+MNNeshq36Sotealbpiq3K5wg8lV5LwHR9Izk/F4JVXioXLDBsYl
         /SFQ==
X-Gm-Message-State: AOJu0Yy1+3Ng11w3TXt/tRnQ+UFl0Cdy6rFi5p2Zz4k07hgk99mGrNc3
	DJ3iT4oNBlACPu+SbbCaaAlJ3H7131qkxE8z9ZSoqhnJFL0FYN3YwOOOlKE309BoNF+gB/IsBL+
	GkYEf77WJcYjIPKtDHM5OP+L2IimMvyhNPybtIZl++0IPJhDV1fc=
X-Google-Smtp-Source: AGHT+IFiKKSaJD7S31bQvy9uMtiLZrCFDEgo+HN4D40OjnWSzEx7to/xFzO7TFWzKf+00X0VN8/NZaGH3WXPbVzxdBQ=
X-Received: by 2002:a05:6102:370d:b0:4a3:a137:b9b with SMTP id
 ada2fe7eead31-4a3e68519b1mr1659730137.11.1727867448216; Wed, 02 Oct 2024
 04:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 2 Oct 2024 16:40:36 +0530
Message-ID: <CA+G9fYvo5npQ3o_vgiOX2guHtgafRoFPL__4O8Kcwg2=ssXmKg@mail.gmail.com>
Subject: next-20241001: WARNING: at mm/list_lru.c:77 list_lru_del
 (mm/list_lru.c:212 mm/list_lru.c:200)
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-mm <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following kernel warnings have been occurring on arm64 DUT and qemu-arm64
running Linux next-20240930, next-20241001 and next-20241002 while
booting the kernel.

This is an intermittent warning noticed on arm64
 - Juno-r2
 - Dragonboard-410c
 - Qemu-arm64

First seen on next-20240930

  Good: next-20240927
  BAD:  next-20240930..next-20241002

Since this is an intermittent problem hard to bisect.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Warning log:
----------
<4>[   26.293906] ------------[ cut here ]------------
<4>[ 26.295948] WARNING: CPU: 1 PID: 1 at mm/list_lru.c:77
list_lru_del (mm/list_lru.c:212 mm/list_lru.c:200)
<4>[   26.299608] Modules linked in: fuse drm backlight ip_tables x_tables
<4>[   26.308212] CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted
6.12.0-rc1-next-20241001 #1
<4>[   26.310552] Hardware name: linux,dummy-virt (DT)
<4>[   26.313304] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[ 26.315519] pc : list_lru_del (mm/list_lru.c:212 mm/list_lru.c:200)
<4>[ 26.316457] lr : list_lru_del (mm/list_lru.c:76 mm/list_lru.c:200)
<4>[   26.317603] sp : ffff80008002b950
<4>[   26.319015] x29: ffff80008002b950 x28: fff00000c0540240 x27:
0000000000000000
<4>[   26.321155] x26: fff00000c2dce690 x25: 8000000000000000 x24:
0000000000000000
<4>[   26.322653] x23: fff00000c0c4e900 x22: fff00000c12f4478 x21:
fff00000c12f4458
<4>[   26.324697] x20: fff00000c1b14800 x19: fff00000c0542088 x18:
0000000000000000
<4>[   26.326121] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
<4>[   26.327590] x14: 0000000000000000 x13: fff00000c146b940 x12:
0000000000000005
<4>[   26.329087] x11: 0000000000000000 x10: 0000000000000402 x9 :
0000000000000003
<4>[   26.330650] x8 : ffffffffffffffff x7 : 0000000023d53570 x6 :
0000000023d53570
<4>[   26.332484] x5 : 00000000000f000c x4 : ffffc1ffc3032e20 x3 :
fff00000c2f70800
<4>[   26.334759] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
0000000000000001
<4>[   26.338095] Call trace:
<4>[ 26.339907] list_lru_del (mm/list_lru.c:212 mm/list_lru.c:200)
<4>[ 26.340990] list_lru_del_obj (mm/list_lru.c:221)
<4>[ 26.341972] d_lru_del (fs/dcache.c:463)
<4>[ 26.342794] to_shrink_list (fs/dcache.c:477 fs/dcache.c:887)
<4>[ 26.343615] select_collect (fs/dcache.c:0)
<4>[ 26.344524] d_walk (fs/dcache.c:1278)
<4>[ 26.345384] shrink_dcache_parent (include/linux/list.h:373 fs/dcache.c:1511)
<4>[ 26.346512] d_invalidate (fs/dcache.c:1617)
<4>[ 26.347451] proc_invalidate_siblings_dcache (fs/proc/inode.c:143)
<4>[ 26.348744] proc_flush_pid (fs/proc/base.c:3480)
<4>[ 26.349747] release_task (kernel/exit.c:281)
<4>[ 26.350810] wait_consider_task (kernel/exit.c:1253 kernel/exit.c:1477)
<4>[ 26.352093] __do_wait (kernel/exit.c:1617 kernel/exit.c:1651)
<4>[ 26.353151] do_wait (kernel/exit.c:1693)
<4>[ 26.353958] __arm64_sys_waitid (kernel/exit.c:1775
kernel/exit.c:1788 kernel/exit.c:1783 kernel/exit.c:1783)
<4>[ 26.359772] invoke_syscall (arch/arm64/kernel/syscall.c:50)
<4>[ 26.360706] el0_svc_common (include/linux/thread_info.h:127
arch/arm64/kernel/syscall.c:140)
<4>[ 26.361477] do_el0_svc (arch/arm64/kernel/syscall.c:152)
<4>[ 26.362218] el0_svc (arch/arm64/kernel/entry-common.c:165
arch/arm64/kernel/entry-common.c:178
arch/arm64/kernel/entry-common.c:713)
<4>[ 26.363014] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:765)
<4>[ 26.364138] el0t_64_sync (arch/arm64/kernel/entry.S:598)
<4>[   26.365321] ---[ end trace 0000000000000000 ]---

boot Log links,
--------
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241001/testrun/25235075/suite/log-parser-boot/test/check-kernel-exception-warning-cpu-pid-at-mmlist_lruc-list_lru_del/log
  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2mp2m5m4PnjJgdix32h7pIGe63Y/logs?format=html

Test results history:
----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241002/testrun/25242215/suite/log-parser-boot/test/check-kernel-exception-warning-cpu-pid-at-mmlist_lruc-list_lru_del/history/

metadata:
----
  git describe: next-20241001
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
  kernel config:
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2mp2jhmSKhlF6c0x1SBsJFyBbTq/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2mp2jhmSKhlF6c0x1SBsJFyBbTq/
  toolchain: clang-19 and gcc-13

Steps to reproduce:
---------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2mp2m5m4PnjJgdix32h7pIGe63Y/reproducer
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2mp2m5m4PnjJgdix32h7pIGe63Y/tux_plan

--
Linaro LKFT
https://lkft.linaro.org

