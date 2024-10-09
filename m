Return-Path: <linux-kernel+bounces-356622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E2F996445
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9662B1C20E37
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC26B188012;
	Wed,  9 Oct 2024 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bJjq5dM5"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F43BB48
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464283; cv=none; b=NQ09bs3RNoY6Ku7oakLZFH4UEDRj4yve9eoO8nM9yB7Ag2WBLxrTsXdR9YS+t5z940XtVVhPbV/MPuFegfjahc2S2WIwyPtC96Dbq+BXnlYUaISBy7BeCMQO7oe24xNeVzyr2wm8BjD6MA6EMvmvN1vNS+L2a+L9bBs/573tjsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464283; c=relaxed/simple;
	bh=ARn9yfmpyUoe1zo2iyo+pgs2zsZ++EsKAVpos3PjaNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3ndzFibAiHvwHYB6qBpOd5ZUgr1rI2o7VE+pWZ/4QqD3zX/4Eu3voV8YhtJ6F322BGH3WeLteOCl7xAtubhDfhYuJLaxDNOJt9juQC4V4awXrOcFEEvf4vtEhtfdrdttvk3R6yZxsYCJ1FY32ufBrm92uH3OrntlI+ETYFpQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bJjq5dM5; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728464278; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DKxvwHZfnacsX7sqv4P183tNFvAODjSTuNfhtpMMbws=;
	b=bJjq5dM5zSdN1QAUnlMEXyh41E8joVfXt63yjCBXuvE/V/d8PfMjGkSfpu0u7YIHdIARNUtlKC4YqcgraRENF2lbkShcAu3ZiJbBTNhyY+dNAuPZ5L7IiKwuK4efR6/NuX0lyKj4pn6Xdrr2bMMM80ml+nqh4eYjJOIq/DEBWjY=
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0WGiB8vX_1728464276)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 16:57:57 +0800
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] KVM: arm64: nVHE: gen-hyprel: Silent build warnings
Date: Wed,  9 Oct 2024 16:57:51 +0800
Message-ID: <20241009085751.35976-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch silent the some mismatch format build warnings
with clang, like:

  arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:233:2: warning: format specifies
  type 'unsigned long' but the argument has type 'Elf64_Off'
  (aka 'unsigned long long') [-Wformat]
    233 |         assert_ne(off, 0UL, "%lu");
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
        |                              %llu
  arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:193:34: note: expanded from macro 'assert_ne'
    193 | #define assert_ne(lhs, rhs, fmt)        assert_op(lhs, rhs, fmt, !=)
        |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:188:19: note: expanded from macro 'assert_op'
    187 |                                 " failed (lhs=" fmt ", rhs=" fmt        \
        |                                                 ~~~
    188 |                                 ", line=%d)", _lhs, _rhs, __LINE__);    \
        |                                               ^~~~
  arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:167:17: note: expanded from macro 'fatal_error'
    166 |                 fprintf(stderr, "error: %s: " fmt "\n",                 \
        |                                               ~~~
    167 |                         elf.path, ## __VA_ARGS__);                      \
        |                                      ^~~~~~~~~~~

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/kvm/hyp/nvhe/gen-hyprel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/gen-hyprel.c b/arch/arm64/kvm/hyp/nvhe/gen-hyprel.c
index b63f4e1c1033..0d916d91b13c 100644
--- a/arch/arm64/kvm/hyp/nvhe/gen-hyprel.c
+++ b/arch/arm64/kvm/hyp/nvhe/gen-hyprel.c
@@ -230,7 +230,7 @@ static inline const char *section_begin(Elf64_Shdr *shdr)
 /* Find a section by its offset from the beginning of the file. */
 static inline Elf64_Shdr *section_by_off(Elf64_Off off)
 {
-	assert_ne(off, 0UL, "%lu");
+	assert_ne(off, 0ULL, "%llu");
 	return elf_ptr(Elf64_Shdr, off);
 }
 
@@ -276,7 +276,7 @@ static void init_elf(const char *path)
 	close(fd);
 
 	/* Get pointer to the ELF header. */
-	assert_ge(stat.st_size, sizeof(*elf.ehdr), "%lu");
+	assert_ge(stat.st_size, (off_t)sizeof(*elf.ehdr), "%llu");
 	elf.ehdr = elf_ptr(Elf64_Ehdr, 0);
 
 	/* Check the ELF magic. */
@@ -340,7 +340,7 @@ static void emit_rela_abs64(Elf64_Rela *rela, const char *sh_orig_name)
 	 * a symbol at the beginning of the relocated section, and <offset>
 	 * is `rela->r_offset`.
 	 */
-	printf(".reloc %lu, R_AARCH64_PREL32, %s%s + 0x%lx\n",
+	printf(".reloc %lu, R_AARCH64_PREL32, %s%s + 0x%llx\n",
 	       reloc_offset, HYP_SECTION_SYMBOL_PREFIX, sh_orig_name,
 	       elf64toh(rela->r_offset));
 
@@ -376,7 +376,7 @@ static void emit_rela_section(Elf64_Shdr *sh_rela)
 		uint32_t type = (uint32_t)elf64toh(rela->r_info);
 
 		/* Check that rela points inside the relocated section. */
-		assert_lt(elf64toh(rela->r_offset), elf64toh(sh_orig->sh_size), "0x%lx");
+		assert_lt(elf64toh(rela->r_offset), elf64toh(sh_orig->sh_size), "0x%llx");
 
 		switch (type) {
 		/*
-- 
2.47.0


