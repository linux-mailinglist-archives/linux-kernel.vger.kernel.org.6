Return-Path: <linux-kernel+bounces-306415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068DB963EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269831C21C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45218C031;
	Thu, 29 Aug 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFhxCRqA"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE515C137
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920586; cv=none; b=hl/6uBi5GbeLa4wmDZQ8tkXzxw21iEXGXgWf4gl+bL6xEg15dQL/W0cd/T5H6kqgKI490d6HCZbGLOQZ+qGo3A/PLIdI5UJJpJABuksFSQ5ylg6JuZMRuzi0/nRK5fhjK7BP761DVTzssmJ+KPuNzEuEvCG5vy+jxmPyzNoBM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920586; c=relaxed/simple;
	bh=Fzgjo2J07ABXVaLIxJic+27vrCqqR9H4hHBGhuiE60Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q8jT0+SHWyHcUd9oOK4KJePpwGxhhv9AQYardp0gyXYNQFzm6UZY211j4uza5Mh8zfLG7w1Dcul8xGbgwOWwFk8/mIw47ekq9N3VwYgAPogYne89606q0ZaobUsv8sXgXcCMN3aoRTI3qRPyjkD9P/pXayfRpFFHaZijsDQ7g9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFhxCRqA; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso450641276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724920584; x=1725525384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DrDQ0wA34pBDFFccccUkyMwTsnel+cOfI7PjKq2Yir8=;
        b=ZFhxCRqAEoJQuYuf/R3p7t0Mp4qlb+yhGFTpn3Jqn56oyIUlKEqDfj2KvMlBh5ruLo
         v5l3SYzanS2fMwinoRoIrz7PXKm8sQd3IFBg99L+AwI4SBm1Z0ZZ91KSXuBfmK8wh5P9
         OmSjIiyrgkJS6eUjyRhPZeGHudQWQnpmtZN/raOYg+x7TxlMUgYukWUG7xVvasmr2SOy
         LBSt27gYeuLHfNBMxm5xZlwVvwpc1HdDkNb6TB1xWcC5t6MfR8ApBd5kEzdqazydq/bK
         WMFnz2jqs7FWujxuioGWYjbFWE576O5IDHatQmGnlUowZVxv137EI/0nnUcn2TDFPNCx
         ArEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920584; x=1725525384;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrDQ0wA34pBDFFccccUkyMwTsnel+cOfI7PjKq2Yir8=;
        b=DqrdNggMMo+B70lhAGs+8aUNlnCWPbBkiibeoUzB8whF3miwJwNxtWUji8YareI/1A
         kA3E5f4XhOQy8Ps6e5q82COEflGHlvMWm6cQnet5C7PWysargVvgHAY4XZI/8BoKLt3c
         FM94p289oibANbrGsjIaIvOO+5JpA8ajzPhrgcdkyUl/FhlCgyKgyLyxZ+XPfZF1JR1A
         gk/abSQLPH0FJG3F814nLzLd7diyg/dG69ePnDrg6sL0P0fNAmXYjyVZAIC2SCmGf4EK
         RnSOGRC9/SP1lyDPgpqnX8CpUbQphKbHPiF5A0xH/xiPAg8rUQFRrEJNlui0Un/Hw5AP
         5ZdA==
X-Forwarded-Encrypted: i=1; AJvYcCXlbGD5NJnXzmlbiuwpbRWfoxJI7jMMMp6XatcraGY1fIja4LzvZR/RPlamg/ybyn0C3Qu0jxC5de10F58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDKeszmbYQARKkou0mOkBjtNaWmM5od2CpxUp0YJ5pNKTuCTM3
	bTHda2pp2CrzxyLEil7ObHiMJ1192v1kGIJTlWgpmKECUTI1GgJlMXSARs0K+j0n6zurA91EK3Q
	AWz058COMTLnYSAx0uN0CkIumsbM=
X-Google-Smtp-Source: AGHT+IExgH+87KtgAU7Ul9jdINz2l1t1vpl5InAGu5TO2vz1ull6FphidfVEG3nm1omVz0iF98wF8dDkypAd3DwDE0A=
X-Received: by 2002:a05:6902:e0f:b0:e16:1ebf:2945 with SMTP id
 3f1490d57ef6-e1a5acab457mr2071335276.27.1724920583701; Thu, 29 Aug 2024
 01:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Thu, 29 Aug 2024 16:36:13 +0800
Message-ID: <CAJqJ8ih+pamx2o1tvd+w-G+THb_wSvOPP=5RqHt82x96N=yKRQ@mail.gmail.com>
Subject: [PATCH] mm/mglru: wake up flushers when legacy cgroups run out of
 clean caches
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Alexander Motin <mav@ixsystems.com>, Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
removed the opportunity to wake up flushers during the MGLRU page
reclamation process can lead to an increased likelihood of triggering
OOM when encountering many dirty pages during reclamation on MGLRU.

This leads to premature OOM if there are too many dirty pages in cgroup:
Killed

dd invoked oom-killer: gfp_mask=0x101cca(GFP_HIGHUSER_MOVABLE|__GFP_WRITE),
order=0, oom_score_adj=0

Call Trace:
  <TASK>
  dump_stack_lvl+0x5f/0x80
  dump_stack+0x14/0x20
  dump_header+0x46/0x1b0
  oom_kill_process+0x104/0x220
  out_of_memory+0x112/0x5a0
  mem_cgroup_out_of_memory+0x13b/0x150
  try_charge_memcg+0x44f/0x5c0
  charge_memcg+0x34/0x50
  __mem_cgroup_charge+0x31/0x90
  filemap_add_folio+0x4b/0xf0
  __filemap_get_folio+0x1a4/0x5b0
  ? srso_return_thunk+0x5/0x5f
  ? __block_commit_write+0x82/0xb0
  ext4_da_write_begin+0xe5/0x270
  generic_perform_write+0x134/0x2b0
  ext4_buffered_write_iter+0x57/0xd0
  ext4_file_write_iter+0x76/0x7d0
  ? selinux_file_permission+0x119/0x150
  ? srso_return_thunk+0x5/0x5f
  ? srso_return_thunk+0x5/0x5f
  vfs_write+0x30c/0x440
  ksys_write+0x65/0xe0
  __x64_sys_write+0x1e/0x30
  x64_sys_call+0x11c2/0x1d50
  do_syscall_64+0x47/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 memory: usage 308224kB, limit 308224kB, failcnt 2589
 swap: usage 0kB, limit 9007199254740988kB, failcnt 0

  ...
  file_dirty 303247360
  file_writeback 0
  ...

oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=test,
mems_allowed=0,oom_memcg=/test,task_memcg=/test,task=dd,pid=4404,uid=0
Memory cgroup out of memory: Killed process 4404 (dd) total-vm:10512kB,
anon-rss:1152kB, file-rss:1824kB, shmem-rss:0kB, UID:0 pgtables:76kB
oom_score_adj:0

Wake up flushers when legacy cgroups run out of clean caches.

Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
Signed-off-by: kasong <kasong@tencent.com>

