Return-Path: <linux-kernel+bounces-436614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D269E889A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 00:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D62F1884E73
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 23:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A29192D77;
	Sun,  8 Dec 2024 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1lNv1G1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F265DB66E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733702037; cv=none; b=Ir74EyvNVIYumUE/a0+R5OuHDtuT0YXc7gvz1fWUmmFMxbB5Ja3pvsQEjWHyvqdZ7rRl7QxjErToGoXoNpJgWJO3HjF+hNgZh+yr5vMNxdx4fCrSVhipw3dga+OBq1980HJKJDuYHoOkVGqH7WH6IVVtKXIb/HOrkpbPdszMCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733702037; c=relaxed/simple;
	bh=sVH9ZqpCvQDz7d361utUpjIEsZi2/pdFCUGB60yV1Sk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Gmp0I+dSfeNigAz5XyM9WHDOfmysGf+Wszzxjp68wz67p4xBBNH9xhjl9VSpH1rQDA5aghmeKvs8Ij7oJmEkO5BsO+Vwn59EKE8+mtqQSZ6osluQm5gVODC8nfj8f+mXTvLPTdDMmZCun0UVdm8Y7qUBnVz7dT0sj/vt3Ma07T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1lNv1G1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9D4C4CED2;
	Sun,  8 Dec 2024 23:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733702036;
	bh=sVH9ZqpCvQDz7d361utUpjIEsZi2/pdFCUGB60yV1Sk=;
	h=From:To:Subject:Date:From;
	b=d1lNv1G1TMat4RrUYqlgR6515kanRf3QTtu1IdX2PkUaBHltP9W5SG0HMP0peFQtU
	 gamUhMf6wYy4eMAACBiynmWe0EfVWyYM9+c5C9+/V7zjnF0Tci848zClEfejmMVIxk
	 9fo6VYMXg59T+SskgRHOQl7VbU7vj1B4rnDRv9uTMbxk/YO//OJAPXd9CbGqy9nyu6
	 H51aQcyAKXeGKmJe0Sk8wCjR2kv0ALjtQ0+h3tb4tfCD4gDHWJNczLl/USPab5csLF
	 dS98mYkbwQp5kpiac5M1olJQ0PvohpeRtBLqt5q2YN7zC9arevvMUq5+0Xd7XgA5ql
	 88bSJTWchKYJw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Fix build regression with CONFIG_KEXEC_JUMP enabled
Date: Mon,  9 Dec 2024 08:53:32 +0900
Message-ID: <20241208235332.479460-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build 6.13-rc12 for x86_64 with gcc 14.2.1 fails with the error:

ld: vmlinux.o: in function `virtual_mapped':
linux/arch/x86/kernel/relocate_kernel_64.S:249:(.text+0x5915b): undefined reference to `saved_context_gdt_desc'

when CONFIG_KEXEC_JUMP is enabled. This regression was introduced by
commit 07fa619f2a40 ("x86/kexec: Restore GDT on return from
::preserve_context kexec") which introduced a use of
saved_context_gdt_desc without a declaration for it. Fix that by
including asm/asm-offsets.h where saved_context_gdt_desc is defined
(indirectly in include/generated/asm-offsets.h which asm/asm-offsets.h
includes).

Fixes: 07fa619f2a40 ("x86/kexec: Restore GDT on return from ::preserve_context kexec")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 arch/x86/kernel/relocate_kernel_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 1236f25fc8d1..540443d699e3 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -13,6 +13,7 @@
 #include <asm/pgtable_types.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
+#include <asm/asm-offsets.h>
 
 /*
  * Must be relocatable PIC code callable as a C function, in particular
-- 
2.47.1


