Return-Path: <linux-kernel+bounces-333900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4644E97CFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AB51C22327
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 00:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61E8F6B;
	Fri, 20 Sep 2024 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2b6ewUDo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bHDedZDr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73579D2
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 00:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726792758; cv=none; b=RZUh6/hKbfB/wmkV8PSXFpNlxS8gkplFqQlx3BKKTKo/Z9cvID5frEIUEidmw4X1xS5nw0J18it+/1IAlxKtLYFcNrk7qw8Z17duAk/vmhakswljoiNco7B/v8Gt6PmFEgBxLVAjq8yMemiXgB7idepdBj25eaBDZhOGL5orLfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726792758; c=relaxed/simple;
	bh=I17ZgvwuOvAGNkRqQ3ZV/fAZ5UGvI4rhZ7Y+v9mjunA=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=cPxEENIOnhymcsUmuqYyK2NKb3S8p4XawYsUjSgvEz/jixXsfvmnTO+RXtw04JN+n+S1aMByiI38MR7zmbPsX+8oihRlfG1+CFIQ81muMN7i8CHvQiC0P8oPjO7MSI+c3Ry0W73io0v1bMl6JkWNgEazON5q9PqBxdbrMKEYEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2b6ewUDo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bHDedZDr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726792755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=omT6qHi3dHTUuQmtEw+wP0mwJKPwdS2PWeHchBEZGUc=;
	b=2b6ewUDoXfTIvXrLEAMOAoQON8oFd9s4g7JS1nv9ifiq15NSN3X9iVQCmbjFW4+MeYveo/
	6dH4ZRnBAzeFrr689lHPuK3FwYwSPCmj5sIK+S/cBHc6XTNU0PMRMijP+sQykBRINxsZAD
	ucYxZmLkfQDGmoUW21goTEojsZJKhPoh9bNFzdJrludojdVqTmu+S8os+WXZ5TE/O6yuDG
	YQRiyXvcL64I1fSheC7wFzVgx4DBlxBjph7hnUsQ2XYaJVa9LbQXlOdkvqAIZcpgVXLe0o
	Hb7lkTFrBkn7E9L8AAJiCqFQlZOIwee2eTkJEul3wOuOYIgRESTX9ulYliYNnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726792755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=omT6qHi3dHTUuQmtEw+wP0mwJKPwdS2PWeHchBEZGUc=;
	b=bHDedZDrYCkrAWj5V1FqynJGFM9/YZW1dcem8HZ7U7rSROM00fyhqrQbsCHG71WAtJlGaA
	oxszQMFPVVB9GrCQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [GIT pull] sched/rt for v6.12-rc1
Message-ID: <172656429254.2474571.1051331842339040765.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Sep 2024 02:39:14 +0200 (CEST)

Linus,

please pull the latest sched/rt branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-rt-2024-09=
-17

up to:  2638e4e6b182: riscv: Allow to enable PREEMPT_RT.

Enable PREEMPT_RT on supported architectures:

  After twenty years of development we finally reached the point to enable
  PREEMPT_RT support in the mainline kernel.

  All prerequisites are merged, so enable it on the supported architectures
  ARM64, RISCV and X86(32/64-bit).

Thanks,

	tglx

------------------>
Sebastian Andrzej Siewior (3):
      x86: Allow to enable PREEMPT_RT.
      arm64: Allow to enable PREEMPT_RT.
      riscv: Allow to enable PREEMPT_RT.


 arch/arm64/Kconfig | 1 +
 arch/riscv/Kconfig | 1 +
 arch/x86/Kconfig   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ed15b876fa74..7da710b21f76 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -100,6 +100,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_RT
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 86d1f1cea571..82724bc95b74 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -65,6 +65,7 @@ config RISCV
 	select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >=3D 140000
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
+	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_MEMTEST
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6f1c31f4b9ab..865573bef975 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -122,6 +122,7 @@ config X86
 	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST


