Return-Path: <linux-kernel+bounces-258184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8F9384CC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F105E1F212CA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A79168C26;
	Sun, 21 Jul 2024 13:37:20 +0000 (UTC)
Received: from mailscanner06.zoner.fi (mailscanner06.zoner.fi [5.44.246.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6DE1662E5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569040; cv=none; b=YXA5WBieGcrhHuXWH2GofbeDhpmLdK7vANkxTCqw8fioT4EteMLEarOuo0e0/c2aodoKGuUvLVLx9e33S+y9d34dohRtVuVazsEv+8DfzT8771V8stjxV9bGTV22Bk3uhdAiyNXRVZS2hLh7LUGoqVZ3636BdwEg3/7nGRGD3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569040; c=relaxed/simple;
	bh=iF4DSwyYfxgF6n0TroyybMMj+B4SYeprWtDfj9yvoAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLkRFM6vMA8JTWequEJCKByLy2x94179fm6Gp/uYUmkisUzaXQTauYrMf8cHj5FBBDmjE5M3uASOz+aAI/wNyFxUApRMY0q3HUpuFDHacHiv70mU1PeXC8Mir0y/VrK82jLOuWX+fwVSCQ36GLGE1aSi/nbqJR5hIlPe2fpulXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner06.zoner.fi (Postfix) with ESMTPS id 83C3021320;
	Sun, 21 Jul 2024 16:37:15 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkS-00000001SmU-0R5F;
	Sun, 21 Jul 2024 16:37:15 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org,
	Simon Glass <sjg@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jubin Zhong <zhongjubin@huawei.com>,
	Jules Maselbas <jmaselbas@zdiv.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 14/16] xz: Adjust arch-specific options for better kernel compression
Date: Sun, 21 Jul 2024 16:36:29 +0300
Message-ID: <20240721133633.47721-15-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721133633.47721-1-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use LZMA2 options that match the arch-specific alignment of instructions.
This change reduces compressed kernel size 0-2 % depending on the arch.
On 1-byte-aligned x86 it makes no difference and on 4-byte-aligned archs
it helps the most.

Use the ARM-Thumb filter for ARM-Thumb2 kernels. This reduces compressed
kernel size about 5 %.[1] Previously such kernels were compressed using
the ARM filter which didn't do anything useful with ARM-Thumb2 code.

Add BCJ filter support for ARM64 and RISC-V. Compared to unfiltered XZ
or plain LZMA, the compressed kernel size is reduced about 5 % on ARM64
and 7 % on RISC-V. A new enough version of the xz tool is required: 5.4.0
for ARM64 and 5.6.0 for RISC-V. With an old xz version, a message is
printed to standard error and the kernel is compressed without the filter.

Update lib/decompress_unxz.c to match the changes to xz_wrap.sh.

Update the CONFIG_KERNEL_XZ help text in init/Kconfig:
  - Add the RISC-V and ARM64 filters.
  - Clarify that the PowerPC filter is for big endian only.
  - Omit IA-64.

Link: https://lore.kernel.org/lkml/1637379771-39449-1-git-send-email-zhongjubin@huawei.com/ [1]
Cc: Simon Glass <sjg@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Jubin Zhong <zhongjubin@huawei.com>
Cc: Jules Maselbas <jmaselbas@zdiv.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-riscv@lists.infradead.org
Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---

Notes:
    v2: Avoid the "eval" command. The use of "eval" on xz's output might
    scare people so this should make the script less scary. This should
    address the concerns in [2]. See also my replies [3] and [4].
    
    [2]: https://lore.kernel.org/lkml/27db456edeb6f72e7e229c2333c5d8449718c26e.camel@16bits.net/
    [3]: https://lore.kernel.org/lkml/20240403225903.0773746d@kaneli/
    [4]: https://lore.kernel.org/lkml/20240404170103.1bc382b3@kaneli/

 init/Kconfig          |   5 +-
 lib/decompress_unxz.c |  14 ++++-
 scripts/xz_wrap.sh    | 142 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 152 insertions(+), 9 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 964355d1757e..236105e4d441 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -310,8 +310,9 @@ config KERNEL_XZ
 	  BCJ filters which can improve compression ratio of executable
 	  code. The size of the kernel is about 30% smaller with XZ in
 	  comparison to gzip. On architectures for which there is a BCJ
-	  filter (i386, x86_64, ARM, IA-64, PowerPC, and SPARC), XZ
-	  will create a few percent smaller kernel than plain LZMA.
+	  filter (i386, x86_64, ARM, ARM64, RISC-V, big endian PowerPC,
+	  and SPARC), XZ will create a few percent smaller kernel than
+	  plain LZMA.
 
 	  The speed is about the same as with LZMA: The decompression
 	  speed of XZ is better than that of bzip2 but worse than gzip
diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index 46aa3be13fc5..cae00395d7a6 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -126,11 +126,21 @@
 #ifdef CONFIG_X86
 #	define XZ_DEC_X86
 #endif
-#ifdef CONFIG_PPC
+#if defined(CONFIG_PPC) && defined(CONFIG_CPU_BIG_ENDIAN)
 #	define XZ_DEC_POWERPC
 #endif
 #ifdef CONFIG_ARM
-#	define XZ_DEC_ARM
+#	ifdef CONFIG_THUMB2_KERNEL
+#		define XZ_DEC_ARMTHUMB
+#	else
+#		define XZ_DEC_ARM
+#	endif
+#endif
+#ifdef CONFIG_ARM64
+#	define XZ_DEC_ARM64
+#endif
+#ifdef CONFIG_RISCV
+#	define XZ_DEC_RISCV
 #endif
 #ifdef CONFIG_SPARC
 #	define XZ_DEC_SPARC
diff --git a/scripts/xz_wrap.sh b/scripts/xz_wrap.sh
index c8c36441ab70..f19369687030 100755
--- a/scripts/xz_wrap.sh
+++ b/scripts/xz_wrap.sh
@@ -6,14 +6,146 @@
 #
 # Author: Lasse Collin <lasse.collin@tukaani.org>
 
+# This has specialized settings for the following archs. However,
+# XZ-compressed kernel isn't currently supported on every listed arch.
+#
+#   Arch        Align   Notes
+#   arm          2/4    ARM and ARM-Thumb2
+#   arm64         4
+#   csky          2
+#   loongarch     4
+#   mips         2/4    MicroMIPS is 2-byte aligned
+#   parisc        4
+#   powerpc       4     Uses its own wrapper for compressors instead of this.
+#   riscv        2/4
+#   s390          2
+#   sh            2
+#   sparc         4
+#   x86           1
+
+# A few archs use 2-byte or 4-byte aligned instructions depending on
+# the kernel config. This function is used to check if the relevant
+# config option is set to "y".
+is_enabled()
+{
+	grep -q "^$1=y$" include/config/auto.conf
+}
+
+# XZ_VERSION is needed to disable features that aren't available in
+# old XZ Utils versions.
+XZ_VERSION=$($XZ --robot --version) || exit
+XZ_VERSION=$(printf '%s\n' "$XZ_VERSION" | sed -n 's/^XZ_VERSION=//p')
+
+# Assume that no BCJ filter is available.
 BCJ=
-LZMA2OPTS=
 
+# Set the instruction alignment to 1, 2, or 4 bytes.
+#
+# Set the BCJ filter if one is available.
+# It must match the #ifdef usage in lib/decompress_unxz.c.
 case $SRCARCH in
-	x86)            BCJ=--x86 ;;
-	powerpc)        BCJ=--powerpc ;;
-	arm)            BCJ=--arm ;;
-	sparc)          BCJ=--sparc ;;
+	arm)
+		if is_enabled CONFIG_THUMB2_KERNEL; then
+			ALIGN=2
+			BCJ=--armthumb
+		else
+			ALIGN=4
+			BCJ=--arm
+		fi
+		;;
+
+	arm64)
+		ALIGN=4
+
+		# ARM64 filter was added in XZ Utils 5.4.0.
+		if [ "$XZ_VERSION" -ge 50040002 ]; then
+			BCJ=--arm64
+		else
+			echo "$0: Upgrading to xz >= 5.4.0" \
+				"would enable the ARM64 filter" \
+				"for better compression" >&2
+		fi
+		;;
+
+	csky)
+		ALIGN=2
+		;;
+
+	loongarch)
+		ALIGN=4
+		;;
+
+	mips)
+		if is_enabled CONFIG_CPU_MICROMIPS; then
+			ALIGN=2
+		else
+			ALIGN=4
+		fi
+		;;
+
+	parisc)
+		ALIGN=4
+		;;
+
+	powerpc)
+		ALIGN=4
+
+		# The filter is only for big endian instruction encoding.
+		if is_enabled CONFIG_CPU_BIG_ENDIAN; then
+			BCJ=--powerpc
+		fi
+		;;
+
+	riscv)
+		if is_enabled CONFIG_RISCV_ISA_C; then
+			ALIGN=2
+		else
+			ALIGN=4
+		fi
+
+		# RISC-V filter was added in XZ Utils 5.6.0.
+		if [ "$XZ_VERSION" -ge 50060002 ]; then
+			BCJ=--riscv
+		else
+			echo "$0: Upgrading to xz >= 5.6.0" \
+				"would enable the RISC-V filter" \
+				"for better compression" >&2
+		fi
+		;;
+
+	s390)
+		ALIGN=2
+		;;
+
+	sh)
+		ALIGN=2
+		;;
+
+	sparc)
+		ALIGN=4
+		BCJ=--sparc
+		;;
+
+	x86)
+		ALIGN=1
+		BCJ=--x86
+		;;
+
+	*)
+		echo "$0: Arch-specific tuning is missing for '$SRCARCH'" >&2
+
+		# Guess 2-byte-aligned instructions. Guessing too low
+		# should hurt less than guessing too high.
+		ALIGN=2
+		;;
+esac
+
+# Select the LZMA2 options matching the instruction alignment.
+case $ALIGN in
+	1)  LZMA2OPTS= ;;
+	2)  LZMA2OPTS=lp=1 ;;
+	4)  LZMA2OPTS=lp=2,lc=2 ;;
+	*)  echo "$0: ALIGN wrong or missing" >&2; exit 1 ;;
 esac
 
 # Use single-threaded mode because it compresses a little better
-- 
2.45.2


