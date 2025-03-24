Return-Path: <linux-kernel+bounces-574507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F61A6E60F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706CC176769
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA9C1F561B;
	Mon, 24 Mar 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdKhrnUO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44F1F5408
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853392; cv=none; b=o4pWR3P+2o2YTOpA5hudbJBF0GSkkr7rykwobWXJ1DUK/vzzOsgFcXPSZxRHJtzeiqsMyvEmDog2wKnlBMiLJh4KSW5mZY5D9qjUM0bXcBEVDY+XRkhgZV2c4QVpX8UUUQ/i6WUHk5/sbH03Fa2LLF+DgxhKmtyxTbIs41iUkmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853392; c=relaxed/simple;
	bh=DnvNW34wKVbDzGcEkkl8RsUUyZnTIp8TkKvklbn36Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quYNBpOT4nyZ0i2G4nhAf/+ydr0jCVQkLooc/2vbj6ppJA4fHOmApniO8g+PlpQaL08WlHnlfMK6TeyZ1mAFfscpOIIWa85UR4rB6Rgk4XwndDq8azYQZehBG/wfG/BpustzYEERK55glwmnYgjAp27jOMo7CXB/E6He2VvK6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdKhrnUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA49C4CEDD;
	Mon, 24 Mar 2025 21:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853391;
	bh=DnvNW34wKVbDzGcEkkl8RsUUyZnTIp8TkKvklbn36Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hdKhrnUO+9H86+tZGJaHp/2LarDqHaeG9fNcqinkm42y336x0n73DZRG6h/MI3w9I
	 ZUC0JfG4PtB5LVDcCEatGlu0MRsQVGC6wRGm4pmmcd4tnraw1pTfuuD8XGNaTuI/d5
	 mC+z/bmARiEbZBzsqvFSEAbJGYEWbh52PoKARwI8b5oZl3GcUScUKpLjorQ6RjlQOn
	 NQ9aAvuOfo/RVzheRo0PdDnR3DxrvQX+bLebizC5RsLWWifnLFx7j1Q6kRO2fpYhME
	 gEdGcDrzyF136v7KZWXSp46LJcZeitCCqF2UhuLJWOJaERl7kVdtThqV2GnwMang4l
	 CVuckExGFOnFw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 22/22] lkdtm: Obfuscate do_nothing() pointer
Date: Mon, 24 Mar 2025 14:56:12 -0700
Message-ID: <30b9abffbddeb43c4f6320b1270fa9b4d74c54ed.1742852847.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742852846.git.jpoimboe@kernel.org>
References: <cover.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If execute_location()'s memcpy of do_nothing() gets inlined and unrolled
by the compiler, it copies one word at a time:

    mov    0x0(%rip),%rax    R_X86_64_PC32    .text+0x1374
    mov    %rax,0x38(%rbx)
    mov    0x0(%rip),%rax    R_X86_64_PC32    .text+0x136c
    mov    %rax,0x30(%rbx)
    ...

Those .text references point to the middle of the function, causing
objtool to complain about their lack of ENDBR.

Prevent that by resolving the function pointer at runtime rather than
build time.  This fixes the following warning:

  drivers/misc/lkdtm/lkdtm.o: warning: objtool: execute_location+0x23: relocation to !ENDBR: .text+0x1378

Cc: Kees Cook <kees@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503191453.uFfxQy5R-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/misc/lkdtm/perms.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 5b861dbff27e..6c24426104ba 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -28,6 +28,13 @@ static const unsigned long rodata = 0xAA55AA55;
 /* This is marked __ro_after_init, so it should ultimately be .rodata. */
 static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
 
+/*
+ * This is a pointer to do_nothing() which is initialized at runtime rather
+ * than build time to avoid objtool IBT validation warnings caused by an
+ * inlined unrolled memcpy() in execute_location().
+ */
+static void __ro_after_init *do_nothing_ptr;
+
 /*
  * This just returns to the caller. It is designed to be copied into
  * non-executable memory regions.
@@ -65,13 +72,12 @@ static noinline __nocfi void execute_location(void *dst, bool write)
 {
 	void (*func)(void);
 	func_desc_t fdesc;
-	void *do_nothing_text = dereference_function_descriptor(do_nothing);
 
-	pr_info("attempting ok execution at %px\n", do_nothing_text);
+	pr_info("attempting ok execution at %px\n", do_nothing_ptr);
 	do_nothing();
 
 	if (write == CODE_WRITE) {
-		memcpy(dst, do_nothing_text, EXEC_SIZE);
+		memcpy(dst, do_nothing_ptr, EXEC_SIZE);
 		flush_icache_range((unsigned long)dst,
 				   (unsigned long)dst + EXEC_SIZE);
 	}
@@ -267,6 +273,8 @@ static void lkdtm_ACCESS_NULL(void)
 
 void __init lkdtm_perms_init(void)
 {
+	do_nothing_ptr = dereference_function_descriptor(do_nothing);
+
 	/* Make sure we can write to __ro_after_init values during __init */
 	ro_after_init |= 0xAA;
 }
-- 
2.48.1


