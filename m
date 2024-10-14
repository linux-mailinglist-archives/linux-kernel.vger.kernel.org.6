Return-Path: <linux-kernel+bounces-364410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BA599D450
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33399288B43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAEE1AC8AE;
	Mon, 14 Oct 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/Adz256"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB961AAE01
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922269; cv=none; b=gPqsoXdK8n0+ykdSnM1UeuEMqr83zbBQrJALXd4oekwvjufmCpBR3bA1h2SLCCW5L4aztDI88Xys1d98Q46oWhqc+FdJ5K0tT2MzNEZE90I04PvR65ALHPMeWwNjbX2sKScIWc3Lgjnw6ysO9ej3vp5bq5XI6eAbESHuekgdiHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922269; c=relaxed/simple;
	bh=wOqrwTp34LIuaLxXUWvsvqtFruSD5VEeAEnaub7ceTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nj2xNDB6bFz+gF4/urxVryQBFadDXYOjmIadpvYGkGoGSxkHePQW6GRnGC5RvZhkQWE6P9veZ6bZ2odC/3iJJYlr1GFMETkbJ8TLzcmzi7MMCnAFMgHtug7hGMKsG9ykEc7n59ubxb9bGFg6JrWyOgMwhI2gI3k8sW12olsh60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/Adz256; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA5DC4CEC3;
	Mon, 14 Oct 2024 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728922269;
	bh=wOqrwTp34LIuaLxXUWvsvqtFruSD5VEeAEnaub7ceTs=;
	h=From:To:Cc:Subject:Date:From;
	b=D/Adz256Xdf+mrawykJtzhVASiYOfpa0IwX3FMvxrVz2YweLRVFW9jxuHDfqhmAud
	 EX/OfDsT5YcKIAt0/0jYU0pRGqdgAIXbHl2iDM4yTBThMGKRnrzyXJPGkhlZgKI+me
	 G1GiX6e1gC/3Y6UPKg9hP7jrx1mLr9lfzhgSG+BNeWl3nTlifrrUMJEPcI7jsYzATM
	 Om6l6jV/DUaW4S//gG5cRdcklwg52DsYh1Hgu2Xjt4nDQORIgC0mGjwF9c+LM5GmhZ
	 0njUvD9G/zEeDzfw0qAWsL15P2l4h+lkH2c5WWZJvG/7faEwSwnrsshKuzR1GDRqpW
	 e82VDWBrynuSA==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	Will Deacon <will@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	syzbot+908886656a02769af987@syzkaller.appspotmail.com
Subject: [PATCH] kasan: Disable Software Tag-Based KASAN with GCC
Date: Mon, 14 Oct 2024 17:11:00 +0100
Message-Id: <20241014161100.18034-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reports a KASAN failure early during boot on arm64 when building
with GCC 12.2.0 and using the Software Tag-Based KASAN mode:

  | BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
  | BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
  | Write of size 4 at addr 03ff800086867e00 by task swapper/0
  | Pointer tag: [03], memory tag: [fe]

Initial triage indicates that the report is a false positive and a
thorough investigation of the crash by Mark Rutland revealed the root
cause to be a bug in GCC:

  > When GCC is passed `-fsanitize=hwaddress` or
  > `-fsanitize=kernel-hwaddress` it ignores
  > `__attribute__((no_sanitize_address))`, and instruments functions
  > we require are not instrumented.
  >
  > [...]
  >
  > All versions [of GCC] I tried were broken, from 11.3.0 to 14.2.0
  > inclusive.
  >
  > I think we have to disable KASAN_SW_TAGS with GCC until this is
  > fixed

Disable Software Tag-Based KASAN when building with GCC by making
CC_HAS_KASAN_SW_TAGS depend on !CC_IS_GCC.

Cc: Andrey Konovalov <andreyknvl@gmail.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218854
Signed-off-by: Will Deacon <will@kernel.org>
---
 lib/Kconfig.kasan | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

While sweeping up pending fixes and open bug reports, I noticed this one
had slipped through the cracks...

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 98016e137b7f..233ab2096924 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -22,8 +22,11 @@ config ARCH_DISABLE_KASAN_INLINE
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
+# GCC appears to ignore no_sanitize_address when -fsanitize=kernel-hwaddress
+# is passed. See https://bugzilla.kernel.org/show_bug.cgi?id=218854 (and
+# the linked LKML thread) for more details.
 config CC_HAS_KASAN_SW_TAGS
-	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
+	def_bool !CC_IS_GCC && $(cc-option, -fsanitize=kernel-hwaddress)
 
 # This option is only required for software KASAN modes.
 # Old GCC versions do not have proper support for no_sanitize_address.
@@ -98,7 +101,7 @@ config KASAN_SW_TAGS
 	help
 	  Enables Software Tag-Based KASAN.
 
-	  Requires GCC 11+ or Clang.
+	  Requires Clang.
 
 	  Supported only on arm64 CPUs and relies on Top Byte Ignore.
 
-- 
2.47.0.rc1.288.g06298d1525-goog


