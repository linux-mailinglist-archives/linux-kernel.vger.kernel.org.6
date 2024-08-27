Return-Path: <linux-kernel+bounces-303552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5D4960DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA621F244B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0B81C4EFC;
	Tue, 27 Aug 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a0HPM6JC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D441494AC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769734; cv=none; b=qV4ns2MgU+0qjVDeF3U7LMjphK/B4id3qnqdnqo8iQjk1Zdm4HzSBD9IEMS+7TPUFqCFSg+MNIOXEtHlOgAj9gSHMuLgZ7f1FWKRCBqPJBBsGvGRUymUPWxLKvznv4rOvifgH18UsaXnp2OM03Hvtavl1exnXIMWfzewcMPxVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769734; c=relaxed/simple;
	bh=3fqBU61QtSDC5sGVcR4FM8vgKj2RqjUOYXg9JKkBmP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaL4wkQx8BMKB7QQLchgxOCmDK/HfbfrfXdAunHF0WVAjTbBEC7x3bdFTZgjMYC0bIpvRpM8XDO36zBkhmBSerHOVojB0kGu8frReSY/L8+j7VMVgXkxKlPwV1z+lV1S2nEDUy4EqsRI9V2GgxNGLxz0Wf8O9r7i9BwtK/7/6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=a0HPM6JC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AEAC4AF15;
	Tue, 27 Aug 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a0HPM6JC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724769732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KJwM2ikHL0FTXgtpjgz3YbY8HbWuRXnrzS1Vfg9OJI=;
	b=a0HPM6JC6xj/FT4Z3zhh51gpRmMGb12klSU1NtTBKYnV2VXtrxJnqHJgPbaF6E+NzgbFdL
	/k26X888bvh+8JED/zsgou8+KzOpYyfCr9asALyvl9fqc5PZE8iv+m47854tBNuIpaFr0s
	JKe60ZvfP0MfA3bdFirXyG0b+Mzfm9s=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fa035d6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 14:42:12 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Subject: [PATCH] selftests/vDSO: separate LDLIBS from CFLAGS for libsodium
Date: Tue, 27 Aug 2024 16:41:36 +0200
Message-ID: <20240827144200.3315093-1-Jason@zx2c4.com>
In-Reply-To: <7d9c376c-10ae-40cc-8d8a-d614b8dd289f@linaro.org>
References: <7d9c376c-10ae-40cc-8d8a-d614b8dd289f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems that set -Wl,--as-needed, putting the -lsodium in the wrong
place on the command line means we get a linker error:

      CC       vdso_test_chacha
    /usr/bin/ld: /tmp/ccKpjnSM.o: in function `main':
    vdso_test_chacha.c:(.text+0x276): undefined reference to `crypto_stream_chacha20'
    collect2: error: ld returned 1 exit status

Fix this by passing pkg-config's --libs output to the LDFLAGS field
instead of the CFLAGS field, as is customary.

Reported-by: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/vDSO/Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 180854eb9fec..834aa862ba2c 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
-SODIUM := $(shell pkg-config --libs --cflags libsodium 2>/dev/null)
+SODIUM_LIBS := $(shell pkg-config --libs libsodium 2>/dev/null)
+SODIUM_CFLAGS := $(shell pkg-config --cflags libsodium 2>/dev/null)
 
 TEST_GEN_PROGS := vdso_test_gettimeofday
 TEST_GEN_PROGS += vdso_test_getcpu
@@ -13,7 +14,7 @@ endif
 TEST_GEN_PROGS += vdso_test_correctness
 ifeq ($(uname_M),x86_64)
 TEST_GEN_PROGS += vdso_test_getrandom
-ifneq ($(SODIUM),)
+ifneq ($(SODIUM_LIBS),)
 TEST_GEN_PROGS += vdso_test_chacha
 endif
 endif
@@ -41,8 +42,9 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
                                          -isystem $(top_srcdir)/include/uapi
 
 $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(ARCH)/vdso/vgetrandom-chacha.S
+$(OUTPUT)/vdso_test_chacha: LDLIBS += $(SODIUM_LIBS)
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
                                       -idirafter $(top_srcdir)/arch/$(ARCH)/include \
                                       -idirafter $(top_srcdir)/include \
                                       -D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 \
-                                      -Wa,--noexecstack $(SODIUM)
+                                      -Wa,--noexecstack $(SODIUM_CFLAGS)
-- 
2.46.0


