Return-Path: <linux-kernel+bounces-319380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678296FBD0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C3128A3F9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D91CDFB9;
	Fri,  6 Sep 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LZ4njcMR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820D1B85F6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649638; cv=none; b=FIrQr6WGSw1aAuNPrugpL8Excq/lUJFPC2Qqk6nlgV6wtZZZuQo5SWYxbD2nQi6YjSAWdWZ495HT9nHNge+B4WQlYGeCkl0pwsKzQVzeEpcIghOoyh1RtOTuuJnjrsrvTvSrRd/UaxYJC/isQ9mqq8wjsZPb3rzM9k2/qkPu9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649638; c=relaxed/simple;
	bh=A4Qzg5ZSDOZJxlWCiReQhyX3T6JyIGJXQvSqgMY5Gbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p76MturB+HYdPck+0uSZoXNGH96DCBbP6TFptezQsQYFeadOWOETQA8gtn/bIp/5YC1NNb5v6AaljiCI2up0qErIuqRzBDmYIG7x37flFA9k9kkzL/RoCFtpv3Pq7ROj9ReEHgpxq2XWMtTH2rkXRYf9pIyxcmT0MqubvFet7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=LZ4njcMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719AEC4CEC4;
	Fri,  6 Sep 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LZ4njcMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725649635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YPKzmf4KaeeaKMbZfROMhAFVMwRpETjYLHIvom3hyVI=;
	b=LZ4njcMRfXNSRAwn4pkmkofb2uK1LNIPK84MS80l162U7xO1+HXiab8glz4PMFNzFzJs5a
	Vb3I9XeyQeG8rDMDaw/3THWW44/cMi39x0t4CWW9NVcIF1c24ljPb4nwomWNk/13qU0Fa2
	sUzvgNl9fd8zrzDpPTj2KkL13+cguzY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 604b07a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 19:07:15 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH tip] x86: vdso: Compute timens page offset statically
Date: Fri,  6 Sep 2024 21:06:55 +0200
Message-ID: <20240906190655.2777023-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The expression `((void *)&__timens_vdso_data - (void *)&__vdso_data)`
seems harmless, but it actually results in quite a bit of code and two
jumps, in a place that's supposed to be somewhat lean on code. The value
of that calculation is always 3*PAGE_SIZE, as it turns out. Changing it
to that results in a more modest cmov instruction being emitted. It also
makes it a bit more clear what's happening.

To accomplish this, define offset macros in vvar.h, which can be shared
by C code and by the linker script that decides where these pages will
actually go.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 11 +++++------
 arch/x86/include/asm/vdso/getrandom.h |  2 +-
 arch/x86/include/asm/vvar.h           |  5 +++++
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index bafa73f09e92..ddd6999b6946 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -16,17 +16,16 @@ SECTIONS
 	 * segment.
 	 */
 
-	vvar_start = . - 4 * PAGE_SIZE;
-	vvar_page  = vvar_start;
-
 	/* Place all vvars at the offsets in asm/vvar.h. */
 #define EMIT_VVAR(name, offset) vvar_ ## name = vvar_page + offset;
 #include <asm/vvar.h>
 #undef EMIT_VVAR
 
-	pvclock_page = vvar_start + PAGE_SIZE;
-	hvclock_page = vvar_start + 2 * PAGE_SIZE;
-	timens_page  = vvar_start + 3 * PAGE_SIZE;
+	vvar_start = . - 4 * PAGE_SIZE;
+	vvar_page    = vvar_start + VVAR_PAGE_OFFSET * PAGE_SIZE;
+	pvclock_page = vvar_start + PVCLOCK_PAGE_OFFSET * PAGE_SIZE;
+	hvclock_page = vvar_start + HVCLOCK_PAGE_OFFSET * PAGE_SIZE;
+	timens_page  = vvar_start + TIMENS_PAGE_OFFSET * PAGE_SIZE;
 
 #undef _ASM_X86_VVAR_H
 	/* Place all vvars in timens too at the offsets in asm/vvar.h. */
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
index b96e674cafde..3569fe95aa4e 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -33,7 +33,7 @@ static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsig
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
 {
 	if (IS_ENABLED(CONFIG_TIME_NS) && __vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
-		return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)&__vdso_data);
+		return (void *)&__vdso_rng_data + (TIMENS_PAGE_OFFSET << CONFIG_PAGE_SHIFT);
 	return &__vdso_rng_data;
 }
 
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 9d9af37f7cab..d2a2ffa72909 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -19,6 +19,11 @@
 #ifndef _ASM_X86_VVAR_H
 #define _ASM_X86_VVAR_H
 
+#define VVAR_PAGE_OFFSET	0
+#define PVCLOCK_PAGE_OFFSET	1
+#define HVCLOCK_PAGE_OFFSET	2
+#define TIMENS_PAGE_OFFSET	3
+
 #ifdef EMIT_VVAR
 /*
  * EMIT_VVAR() is used by the kernel linker script to put vvars in the
-- 
2.46.0


