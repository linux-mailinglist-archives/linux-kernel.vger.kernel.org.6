Return-Path: <linux-kernel+bounces-325053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9922C975447
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 010C1B29895
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315D1A4B83;
	Wed, 11 Sep 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QSvymY8U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59581A3044
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061912; cv=none; b=pCYAs2fJyi9dLVTw8XwWulmZSYZAIrU1SHHxH0VNKO7mQEXTZicOhtjx7tKTdDn35lNREXJzHsMb4VNKJ5SD70p3Be2c3waZDxQ0XLiqnisJOvU79XaQM7RzLy0AntcGfHtkzKbElVQ5/BMHmETZaHsfEkCGR2vw89fNBKsnjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061912; c=relaxed/simple;
	bh=bab+Fp8v9P+/4SD5PSMgAxH3pKU88jU9/dI8Ujk2T7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyRKQAY+9vDjNWAwO8cz84+HRZKCew/Xz2A5wEtRazjEHHXgeBe4WyFi3HFBDSwjzdAEJ69/0+/QTv1ZK55zTqf0jBZRkhmN7+WBzgTXXp1sCM8yiG81OCUhYkSvZGDSdoBhwycdrq+e+53zHg9mFehcZZIuTSS8aTM2/T6ZiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QSvymY8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593E4C4CEC5;
	Wed, 11 Sep 2024 13:38:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QSvymY8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726061906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1w+zr6A9Weeq+KVQVMGHcQzy+H/R8yAKQXFhsrI0HYc=;
	b=QSvymY8UJqtY9jP+wEhs7Gq/iFe9c0jmhm8umIHKQIZRBmGMAj4bMPpwshKGzMbeDuNXix
	2ChtZ4vRdzMVWpHS/hgoiTjtsgMkzZOvF5BkxPOJ7xymnWC6kUkKi1RCiCEZ5KG7OsUk4p
	t5n0PrTJBwfKO6VlHGSaXAnUybEQaxU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d7e48410 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Sep 2024 13:38:26 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Aishwarya TCV <aishwarya.tcv@arm.com>,
	adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Mark Brown <broonie@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] selftests: vDSO: don't include generated headers for chacha test
Date: Wed, 11 Sep 2024 15:36:32 +0200
Message-ID: <20240911133745.3124327-2-Jason@zx2c4.com>
In-Reply-To: <ZuGcQnzUev6eAy0w@zx2c4.com>
References: <ZuGcQnzUev6eAy0w@zx2c4.com>
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
generated header files by defining empty stubs in tools/include, which
is the same thing that's done for rwlock.h.

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
I'll replace the broken commit with this one. I've verified the
kselftests are fine now, particularly for kvm.

 tools/include/generated/asm-offsets.h     | 0
 tools/include/generated/asm/cpucap-defs.h | 0
 tools/include/generated/asm/sysreg-defs.h | 0
 tools/testing/selftests/vDSO/Makefile     | 2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
 create mode 100644 tools/include/generated/asm-offsets.h
 create mode 100644 tools/include/generated/asm/cpucap-defs.h
 create mode 100644 tools/include/generated/asm/sysreg-defs.h

diff --git a/tools/include/generated/asm-offsets.h b/tools/include/generated/asm-offsets.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/include/generated/asm/cpucap-defs.h b/tools/include/generated/asm/cpucap-defs.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/include/generated/asm/sysreg-defs.h b/tools/include/generated/asm/sysreg-defs.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 3c6fafbd83a6..610056acc1b7 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -39,7 +39,7 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
 
 $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
+                                      -idirafter $(top_srcdir)/tools/include/generated \
                                       -idirafter $(top_srcdir)/arch/$(SRCARCH)/include \
-                                      -idirafter $(top_srcdir)/arch/$(SRCARCH)/include/generated \
                                       -idirafter $(top_srcdir)/include \
                                       -D__ASSEMBLY__ -Wa,--noexecstack
-- 
2.46.0


