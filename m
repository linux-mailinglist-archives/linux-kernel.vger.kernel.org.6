Return-Path: <linux-kernel+bounces-347093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E580598CDB4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA8CB213D9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEE71922CA;
	Wed,  2 Oct 2024 07:25:03 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A744C94
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853903; cv=none; b=XX84x6L7nq4k8Vdvj8WryQTcHqa0xO5DjDwRBPu9v5qhzZmDAqkpAho0JnQCAxhBJoRF4FkfE9GThG8kGyHmS3yEUt84HAV0aZzEQGLt6UYKFVn2ZD8JcGXe0PchqRJIO7G0qFaPCdoD0zZk6LtOesKAqL5grzyffCanmql/hls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853903; c=relaxed/simple;
	bh=wQbZTpLttmIMInuXUSZ0jyh22RYHd4NRZmtIWTZVWmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XQKlPqxUp8hGtdgWesQ6u+TmmylIFHF3yfO5n/ACvtHWLMPza2fIykNW/RhD4Ir0S2wTegZiAhO3Y6IbMV2EfKFCBxHI9qcxrM6i9rnUn1dJ/7sZjuHI9n1akjN2qnK/kg2HqSQO78+l0IARGWpvXtCf7G6KQC1fw6T3JZoCWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:80d:3d68:c8fe:1932])
	by michel.telenet-ops.be with cmsmtp
	id KKQs2D0054Qoffy06KQs3H; Wed, 02 Oct 2024 09:24:52 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1svtj1-0016y9-O3;
	Wed, 02 Oct 2024 09:24:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1svtj9-003tIP-UU;
	Wed, 02 Oct 2024 09:24:51 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Tony Ambardar <tony.ambardar@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
Date: Wed,  2 Oct 2024 09:24:50 +0200
Message-Id: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

All my gcc-11 compilers (Ubuntu 11.4.0-1ubuntu1~22.04) claim to support
the __retain__ attribute, but only riscv64-linux-gnu-gcc-11 and
x86_64-linux-gnu-gcc-11 (not x86_64-linux-gnux32-gcc-11!) actually do.
The arm-linux-gnueabi-gcc-11.5.0 compiler from kernel.org crosstool
fails in the same way:

    error: ‘retain’ attribute ignored [-Werror=attributes]

All my gcc-12 compilers seem to support the attribute.

Play it safe, and disable __retain unconditionally on gcc-11.

Fixes: 0a5d3258d7c97295 ("compiler_types.h: Define __retain for __attribute__((__retain__))")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Tony Ambardar <tony.ambardar@gmail.com>
---
Tested with the following gcc-11 compilers:

  1. All compilers available on Ubuntu 22.04LTS:

	aarch64-linux-gnu-gcc-11
	alpha-linux-gnu-gcc-11
	arm-linux-gnueabi-gcc-11
	arm-linux-gnueabihf-gcc-11
	hppa64-linux-gnu-gcc-11
	hppa-linux-gnu-gcc-11
	i686-linux-gnu-gcc-11
	m68k-linux-gnu-gcc-11
	powerpc64le-linux-gnu-gcc-11
	powerpc64-linux-gnu-gcc-11
	powerpc-linux-gnu-gcc-11
	riscv64-linux-gnu-gcc-11
	s390x-linux-gnu-gcc-11
	sh4-linux-gnu-gcc-11
	sparc64-linux-gnu-gcc-11
	x86_64-linux-gnu-gcc-11
	x86_64-linux-gnux32-gcc-11

  2. A few from kernel.org crosstool:

	ia64-linux-gcc-11.1.0
	sh2eb-linux-muslfdpic-gcc-11.2.0
	arm-linux-gnueabi-gcc-11.5.0

  3. A compiler from the J-Core folks:

	sh2eb-linux-muslfdpic-gcc-11.2.0

v2:
  - Update comment in <linux/compiler_types.h>,
  - Add Reviewed-by.
---
 include/linux/compiler-gcc.h   | 9 +++++++++
 include/linux/compiler_types.h | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f805adaa316e9a21..bedeb76b63a34745 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -145,3 +145,12 @@
 #if GCC_VERSION < 90100
 #undef __alloc_size__
 #endif
+
+/*
+ * Most 11.x compilers claim to support it, but only riscv64-linux-gnu-gcc and
+ * x86_64-linux-gnu-gcc actually do.
+ */
+#if GCC_VERSION < 120000
+#undef __retain
+#define __retain
+#endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1a957ea2f4fe78ed..76ddf04a7e66f890 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -153,7 +153,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
  * being optimized out, but operates at the compiler/IR-level and may still
  * allow unintended removal of objects during linking.
  *
- * Optional: only supported since gcc >= 11, clang >= 13
+ * Optional: only supported since gcc >= 11 (partial), clang >= 13
  *
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-retain-function-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#retain
-- 
2.34.1


