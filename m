Return-Path: <linux-kernel+bounces-392199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544239B90E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACB528286A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB3419C569;
	Fri,  1 Nov 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="WO+6k39q"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C109175D2D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462903; cv=none; b=UIvmx5ep/hoaLPCqVDGqjcdfLXZqnRcGMFZhFWurFprk1ECopF/sJvD0DxB+KF0TcKqez8QT3iTpouJQx7VPl0sSNDWMnTKIyLUuvOLU9VNv7JwZ8j5M5+yBWXPjqTPcCpA034UT1ccEQ2tS+S2k3SnRVXySxjTx++6p6VhQ388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462903; c=relaxed/simple;
	bh=evphT9Levh8iSGrIyA3iV2Q4n/gTxYKNQhtxs27IDSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t/g7zw1nXDYkC2xGpyNCeZSAx9MA2ECk6OAc3u+A3ZPyoOMiPfxvO83eTMfAXgj1FrX08M9shZnD61HkKq0p7rMllY0ucyIal8iIVEJ1T1DFqvETM6ibbXntEeroLe1xY0ztJCxbOyZK6DKidBmlnN/m6Hosm++G6NEeQ35wCYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=WO+6k39q; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 8CEA04346B;
	Fri,  1 Nov 2024 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1730462890;
	bh=evphT9Levh8iSGrIyA3iV2Q4n/gTxYKNQhtxs27IDSU=;
	h=From:Date:Subject:To:Cc;
	b=WO+6k39q9hO90X4GxNxwlk1Ts7Z0sQPh1L6QVxAwpnAx+FII85VLWxvS9V/dnZKSV
	 wswPp9+3bdPA5ekkeO3Qd915naCXSm6wgCXyE2K7AXtxAgsgAsHb4cq2s98JRLz3Zt
	 I3Z0nNqxd2d3nQDzvwbk4EpiMyso2IYckrkYkmZ9G5VoOLQcZ5HL411glRDe+25k5L
	 8mJtVoBPrKBDeRlOSlDEE0HaqeWwCiLjhOcuV8uPAz0f72envqtAbZ77z+wOmxd0el
	 5I4xgRhC+zw5+NbEFbJ44VCPDsLLswPDxwQJJqMAd/dH8hdDKX905ieMucKGDHcD4Y
	 H5z/xqrLqKVIw==
From: Asahi Lina <lina@asahilina.net>
Date: Fri, 01 Nov 2024 21:08:02 +0900
Subject: [PATCH] mm: Fix __wp_page_copy_user fallback path for remote mm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-mm-remote-pfn-v1-1-080b609270b7@asahilina.net>
X-B4-Tracking: v=1; b=H4sIAKHEJGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwND3dxc3aLU3PySVN2CtDzdFCNTIzMzyyRLE3NTJaCegqLUtMwKsHn
 RsbW1AJDfJgVfAAAA
X-Change-ID: 20241101-mm-remote-pfn-d252669b9475
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergio Lopez Pascual <slp@redhat.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730462889; l=3847;
 i=lina@asahilina.net; s=20240902; h=from:subject:message-id;
 bh=evphT9Levh8iSGrIyA3iV2Q4n/gTxYKNQhtxs27IDSU=;
 b=hflyZWsN1dNrY23uoJlhzkdpkOKAbGfGkZG7106swJktCq92mh4pd3ABT59AikfQWEZx02yc3
 sSn4Z9BNz22BNzzImHeFplX7auEfLtZxU01IhqdRyPL0ZCYiGPXywoh
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=tpv7cWfUnHNw5jwf6h4t0gGgglt3/xcwlfs0+A/uUu8=

If the source page is a PFN mapping, we copy back from userspace.
However, if this fault is a remote access, we cannot use
__copy_from_user_inatomic. Instead, use access_remote_vm() in this case.

Fixes WARN and incorrect zero-filling when writing to CoW mappings in
a remote process, such as when using gdb on a binary present on a DAX
filesystem.

[  143.683782] ------------[ cut here ]------------
[  143.683784] WARNING: CPU: 1 PID: 350 at mm/memory.c:2904 __wp_page_copy_user+0x120/0x2bc
[  143.683793] CPU: 1 PID: 350 Comm: gdb Not tainted 6.6.52 #1
[  143.683794] Hardware name: linux,dummy-virt (DT)
[  143.683795] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  143.683796] pc : __wp_page_copy_user+0x120/0x2bc
[  143.683798] lr : __wp_page_copy_user+0x254/0x2bc
[  143.683799] sp : ffff80008272b8b0
[  143.683799] x29: ffff80008272b8b0 x28: 0000000000000000 x27: ffff000083bad580
[  143.683801] x26: 0000000000000000 x25: 0000fffff7fd5000 x24: ffff000081db04c0
[  143.683802] x23: ffff00014f24b000 x22: fffffc00053c92c0 x21: ffff000083502150
[  143.683803] x20: 0000fffff7fd5000 x19: ffff80008272b9d0 x18: 0000000000000000
[  143.683804] x17: ffff000081db0500 x16: ffff800080fe52a0 x15: 0000fffff7fd5000
[  143.683804] x14: 0000000000bb1845 x13: 0000000000000080 x12: ffff80008272b880
[  143.683805] x11: ffff000081d13600 x10: ffff000081d13608 x9 : ffff000081d1360c
[  143.683806] x8 : ffff000083a16f00 x7 : 0000000000000010 x6 : ffff00014f24b000
[  143.683807] x5 : ffff00014f24c000 x4 : 0000000000000000 x3 : ffff000083582000
[  143.683807] x2 : 0000000000000f80 x1 : 0000fffff7fd5000 x0 : 0000000000001000
[  143.683808] Call trace:
[  143.683809]  __wp_page_copy_user+0x120/0x2bc
[  143.683810]  wp_page_copy+0x98/0x5c0
[  143.683813]  do_wp_page+0x250/0x530
[  143.683814]  __handle_mm_fault+0x278/0x284
[  143.683817]  handle_mm_fault+0x64/0x1e8
[  143.683819]  faultin_page+0x5c/0x110
[  143.683820]  __get_user_pages+0xc8/0x2f4
[  143.683821]  get_user_pages_remote+0xac/0x30c
[  143.683823]  __access_remote_vm+0xb4/0x368
[  143.683824]  access_remote_vm+0x10/0x1c
[  143.683826]  mem_rw.isra.0+0xc4/0x218
[  143.683831]  mem_write+0x18/0x24
[  143.683831]  vfs_write+0xa0/0x37c
[  143.683834]  ksys_pwrite64+0x7c/0xc0
[  143.683834]  __arm64_sys_pwrite64+0x20/0x2c
[  143.683835]  invoke_syscall+0x48/0x10c
[  143.683837]  el0_svc_common.constprop.0+0x40/0xe0
[  143.683839]  do_el0_svc+0x1c/0x28
[  143.683841]  el0_svc+0x3c/0xdc
[  143.683846]  el0t_64_sync_handler+0x120/0x12c
[  143.683848]  el0t_64_sync+0x194/0x198
[  143.683849] ---[ end trace 0000000000000000 ]---

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 mm/memory.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3ccee51adfbbd007b24331fe6874265f231a877b..dba25d9734063ac02cdaeb0a5cd5432473f6372e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3081,13 +3081,18 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 			update_mmu_cache_range(vmf, vma, addr, vmf->pte, 1);
 	}
 
+	/* If the mm is a remote mm, copy in the page using access_remote_vm() */
+	if (current->mm != mm) {
+		if (access_remote_vm(mm, (unsigned long)uaddr, kaddr, PAGE_SIZE, 0) != PAGE_SIZE)
+			goto warn;
+	}
 	/*
 	 * This really shouldn't fail, because the page is there
 	 * in the page tables. But it might just be unreadable,
 	 * in which case we just give up and fill the result with
 	 * zeroes.
 	 */
-	if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
+	else if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
 		if (vmf->pte)
 			goto warn;
 

---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241101-mm-remote-pfn-d252669b9475

Cheers,
~~ Lina


