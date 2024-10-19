Return-Path: <linux-kernel+bounces-372560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D74E9A4A4F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369FF283F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10EF1917FE;
	Fri, 18 Oct 2024 23:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzNaUc0L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC39E20E33E;
	Fri, 18 Oct 2024 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295641; cv=none; b=sqzRuzMuUytVr9ZVrjYz3Oy16DgRfTGQOoCdhIJnzp8MR25IeW1GhPuwBwR1WTW9be3Ud4QtE0BGEZOV1zEiR1Ic/rWdXbvvC7suyIpL54gH3pXQP59QaFCM6rRTkmhSaGGD8/KDxOvkP0RD3aTBs+fuXNTP5ylM6BnBduxKWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295641; c=relaxed/simple;
	bh=elOLD3WjAMYZQazXg2MfqiGC4poV1qZ75XpOhxfqRvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HN3WQy3FmRr9G01cVJNI/bXLVUwRXqq876W4ZLHE9gSa97nS8mNK7qRYbHTUNNsryB6v8GTkQqANayZoKLW0UjwIufcwwtJKc2NrgRsDl4xdZLSEBuUFodq/YD+SOrQ4Rpu0qfoNaFnttQdyL6/uPjfkCJzm+U0ey3KA9XhfpEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzNaUc0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFF2C4CEC3;
	Fri, 18 Oct 2024 23:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729295639;
	bh=elOLD3WjAMYZQazXg2MfqiGC4poV1qZ75XpOhxfqRvA=;
	h=From:To:Cc:Subject:Date:From;
	b=GzNaUc0L/q0xETsXLZ74DJ6nsirKY5DimiizEpYR2NSXyNScxb+gWNQwYRacL5Ae7
	 H2/7fJ8zYuVkb8iNbQKn14NAZErF6Vv+TW64OIb6/B2wOYoBoTtBMVuiSjMrqpb8JY
	 ctVtERDBelfWiuQzCoxYD8KaPHUEj0Y0qfLvmoAws2hQiSmoJmEwsRfby9dia3kyxW
	 g3dG1fb8Jlaq5haWsxiLLcrWWTErCE4YWqEANREv4u9uU1M8gjhcf9fba879ibZQgE
	 jPxgvBbKHT6zG4GrxkODT6ZFR1x649NJyvcbWI9eCURzQO1qdXMr6FF7g5KMKuFZdl
	 QMXVwTRg+8UhQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto - move crypto_simd_disabled_for_test to lib
Date: Fri, 18 Oct 2024 16:53:43 -0700
Message-ID: <20241018235343.425758-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Move crypto_simd_disabled_for_test to lib/ so that crypto_simd_usable()
can be used by library code.

This was discussed previously
(https://lore.kernel.org/linux-crypto/20220716062920.210381-4-ebiggers@kernel.org/)
but was not done because there was no use case yet.  However, this is
now needed for the arm64 CRC32 library code.

Tested with:
    export ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
    echo CONFIG_CRC32=y > .config
    echo CONFIG_MODULES=y >> .config
    echo CONFIG_CRYPTO=m >> .config
    echo CONFIG_DEBUG_KERNEL=y >> .config
    echo CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n >> .config
    echo CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y >> .config
    make olddefconfig
    make -j$(nproc)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/algapi.c     |  6 ------
 lib/crypto/Makefile |  2 ++
 lib/crypto/simd.c   | 11 +++++++++++
 3 files changed, 13 insertions(+), 6 deletions(-)
 create mode 100644 lib/crypto/simd.c

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 74e2261c184ca..429a832f90fe0 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -4,11 +4,10 @@
  *
  * Copyright (c) 2006 Herbert Xu <herbert@gondor.apana.org.au>
  */
 
 #include <crypto/algapi.h>
-#include <crypto/internal/simd.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/fips.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -21,15 +20,10 @@
 
 #include "internal.h"
 
 static LIST_HEAD(crypto_template_list);
 
-#ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
-DEFINE_PER_CPU(bool, crypto_simd_disabled_for_test);
-EXPORT_PER_CPU_SYMBOL_GPL(crypto_simd_disabled_for_test);
-#endif
-
 static inline void crypto_check_module_sig(struct module *mod)
 {
 	if (fips_enabled && mod && !module_sig_ok(mod))
 		panic("Module %s signature verification failed in FIPS mode\n",
 		      module_name(mod));
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 969baab8c805f..01fac1cd05a19 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -56,5 +56,7 @@ libblake2s-y					+= blake2s-selftest.o
 libchacha20poly1305-y				+= chacha20poly1305-selftest.o
 libcurve25519-y					+= curve25519-selftest.o
 endif
 
 obj-$(CONFIG_MPILIB) += mpi/
+
+obj-$(CONFIG_CRYPTO_MANAGER_EXTRA_TESTS)	+= simd.o
diff --git a/lib/crypto/simd.c b/lib/crypto/simd.c
new file mode 100644
index 0000000000000..9c36cb3bb49c4
--- /dev/null
+++ b/lib/crypto/simd.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SIMD testing utility functions
+ *
+ * Copyright 2024 Google LLC
+ */
+
+#include <crypto/internal/simd.h>
+
+DEFINE_PER_CPU(bool, crypto_simd_disabled_for_test);
+EXPORT_PER_CPU_SYMBOL_GPL(crypto_simd_disabled_for_test);

base-commit: 5c20772738e1d1d7bec41664eb9d61497e53c10e
-- 
2.47.0


