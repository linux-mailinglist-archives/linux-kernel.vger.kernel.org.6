Return-Path: <linux-kernel+bounces-315486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CEC96C336
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919BC1C24D54
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1631DCB3F;
	Wed,  4 Sep 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L+4MwgcM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B581D172F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465510; cv=none; b=BrxqOBodRvljJ6rZNY01MYbpv8MiJZCzY7wqkHn5OeAoXOkV2CkusjU54O/MaIuQ5SjTqzMfppn+kbCJFJ4muv9Fi5zJaP2hetbz7WbA9IyO/3gVXqD+iny8JSTazSAiT+OlsLe9VMVtmA1jjb1mNPm+46ubqQdFOX6uhLM5I+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465510; c=relaxed/simple;
	bh=JZXKEHNOBVh7HrBzuAh/ix4QyM+yFrRyCNw/WHZzYGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oL53QLVf5hpBvgSiMObZBa8NXIqqjpLQV2SfZcpLwm+b48veM80eV+zQqMRsBqHQup4KoaCkP5nJEHhUjFLKcOQ4CfGlqWsssVhZol4wk2RJR9J+8sQjAuK4t3JdKtZTxjsVNwC887hAYjWutexrp4tYwlc7S24F0RANbAmvwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=L+4MwgcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEAFC4CEC2;
	Wed,  4 Sep 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L+4MwgcM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725465507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e72KV22vdv2g3YfWhATqVqG4Lxvn2VwDkeaI4raeyrs=;
	b=L+4MwgcMU5lIHzAQTK2q3y9PTwVDF3ld65FXRsGm+XBGFM28Pzz069ySrNR4sdV0ohyRvt
	N4Z6DK9FLCRd5G4F67rxmnmLIrcqS+ZHMzIdBcMZx7CfLtIrHwsh3CgmFRhS1uBW/4UcHr
	cvBV0Gmk4Lalbl9ezu1z6l6T6w0mlMY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 472fa3eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 15:58:26 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] selftests: vDSO: don't include generated headers for chacha test
Date: Wed,  4 Sep 2024 17:58:17 +0200
Message-ID: <20240904155817.1153783-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not correct to use $(top_srcdir) for generated header files, for
builds that are done out of tree via O=, and $(objtree) isn't valid in
the selftests context. Instead, just obviate the need for these
generated header files by defining empty stubs in tools/include/asm,
which is the same thing that's done for rwlock.h.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/include/asm/asm-offsets.h       | 0
 tools/include/asm/cpucap-defs.h       | 0
 tools/include/asm/sysreg-defs.h       | 0
 tools/testing/selftests/vDSO/Makefile | 1 -
 4 files changed, 1 deletion(-)
 create mode 100644 tools/include/asm/asm-offsets.h
 create mode 100644 tools/include/asm/cpucap-defs.h
 create mode 100644 tools/include/asm/sysreg-defs.h

diff --git a/tools/include/asm/asm-offsets.h b/tools/include/asm/asm-offsets.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/include/asm/cpucap-defs.h b/tools/include/asm/cpucap-defs.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/include/asm/sysreg-defs.h b/tools/include/asm/sysreg-defs.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 3c6fafbd83a6..55038a65fa61 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -40,6 +40,5 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
 $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
                                       -idirafter $(top_srcdir)/arch/$(SRCARCH)/include \
-                                      -idirafter $(top_srcdir)/arch/$(SRCARCH)/include/generated \
                                       -idirafter $(top_srcdir)/include \
                                       -D__ASSEMBLY__ -Wa,--noexecstack
-- 
2.46.0


