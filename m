Return-Path: <linux-kernel+bounces-258182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22249384CA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50D71C20A66
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2D416848B;
	Sun, 21 Jul 2024 13:37:20 +0000 (UTC)
Received: from mailscanner05.zoner.fi (mailscanner05.zoner.fi [5.44.246.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0231662E2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569039; cv=none; b=QPx/sSQPrz0/7xixPFww2G7NjkoY+G4m6wFYyhlnPLX7uodNFQt+FOZTmsW1tZLf5HiUE8UfVudBDbyiCGCBP0ESxn+WU8TBI89IhXWLUkUkS5nqRtsFfOPJfyM87W24W93VEwDmG+0jCcGyVMpMJ6KSzcx5lE7fXJIVlDUo0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569039; c=relaxed/simple;
	bh=3sDSWXkZZ0IOiMfWHnh54tWgDlpd9Qe1o6L9FsPj9Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5jHtwfCO68knBzNWSIlWKxv5s652Mk5R/XRafYnbYGT3mAMZKSyRP2JjJcrhchRDi+vA4od8oEdJVlP3r3h5f6Rs2pKBjSVmBYEWhoa20rmTx3kA40aeYhbkaxYleK7e7x4rAOZgA32+XdgoYugLG2kjRdlSl4nkiZwQHYdszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner05.zoner.fi (Postfix) with ESMTPS id 3A93921346;
	Sun, 21 Jul 2024 16:37:15 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkR-00000001SmU-3ITK;
	Sun, 21 Jul 2024 16:37:15 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/16] xz: Add RISC-V BCJ filter
Date: Sun, 21 Jul 2024 16:36:27 +0300
Message-ID: <20240721133633.47721-13-lasse.collin@tukaani.org>
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

A later commit updates lib/decompress_unxz.c to enable this filter for
kernel decompression. lib/decompress_unxz.c is already used if
CONFIG_EFI_ZBOOT=y && CONFIG_KERNEL_XZ=y.

This filter can be used by Squashfs without modifications to the Squashfs
kernel code (only needs support in userspace Squashfs-tools).

Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 lib/xz/Kconfig       |   5 +++
 lib/xz/xz_dec_bcj.c  | 104 ++++++++++++++++++++++++++++++++++++++++++-
 lib/xz/xz_dec_syms.c |   2 +-
 lib/xz/xz_private.h  |   6 ++-
 4 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/lib/xz/Kconfig b/lib/xz/Kconfig
index 1166627a87dc..20aa459bfb3e 100644
--- a/lib/xz/Kconfig
+++ b/lib/xz/Kconfig
@@ -40,6 +40,11 @@ config XZ_DEC_SPARC
 	default y
 	select XZ_DEC_BCJ
 
+config XZ_DEC_RISCV
+	bool "RISC-V BCJ filter decoder" if EXPERT
+	default y
+	select XZ_DEC_BCJ
+
 config XZ_DEC_MICROLZMA
 	bool "MicroLZMA decoder"
 	default n
diff --git a/lib/xz/xz_dec_bcj.c b/lib/xz/xz_dec_bcj.c
index 941198a8a55b..42d7f268726f 100644
--- a/lib/xz/xz_dec_bcj.c
+++ b/lib/xz/xz_dec_bcj.c
@@ -24,7 +24,8 @@ struct xz_dec_bcj {
 		BCJ_ARM = 7,        /* Little endian only */
 		BCJ_ARMTHUMB = 8,   /* Little endian only */
 		BCJ_SPARC = 9,      /* Big or little endian */
-		BCJ_ARM64 = 10      /* AArch64 */
+		BCJ_ARM64 = 10,     /* AArch64 */
+		BCJ_RISCV = 11      /* RV32GQC_Zfh, RV64GQC_Zfh */
 	} type;
 
 	/*
@@ -388,6 +389,99 @@ static size_t bcj_arm64(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 }
 #endif
 
+#ifdef XZ_DEC_RISCV
+static size_t bcj_riscv(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
+{
+	size_t i;
+	uint32_t b1;
+	uint32_t b2;
+	uint32_t b3;
+	uint32_t instr;
+	uint32_t instr2;
+	uint32_t instr2_rs1;
+	uint32_t addr;
+
+	if (size < 8)
+		return 0;
+
+	size -= 8;
+
+	for (i = 0; i <= size; i += 2) {
+		instr = buf[i];
+
+		if (instr == 0xEF) {
+			/* JAL */
+			b1 = buf[i + 1];
+			if ((b1 & 0x0D) != 0)
+				continue;
+
+			b2 = buf[i + 2];
+			b3 = buf[i + 3];
+
+			addr = ((b1 & 0xF0) << 13) | (b2 << 9) | (b3 << 1);
+			addr -= s->pos + (uint32_t)i;
+
+			buf[i + 1] = (uint8_t)((b1 & 0x0F)
+					| ((addr >> 8) & 0xF0));
+
+			buf[i + 2] = (uint8_t)(((addr >> 16) & 0x0F)
+					| ((addr >> 7) & 0x10)
+					| ((addr << 4) & 0xE0));
+
+			buf[i + 3] = (uint8_t)(((addr >> 4) & 0x7F)
+					| ((addr >> 13) & 0x80));
+
+			i += 4 - 2;
+
+		} else if ((instr & 0x7F) == 0x17) {
+			/* AUIPC */
+			instr |= (uint32_t)buf[i + 1] << 8;
+			instr |= (uint32_t)buf[i + 2] << 16;
+			instr |= (uint32_t)buf[i + 3] << 24;
+
+			if (instr & 0xE80) {
+				/* AUIPC's rd doesn't equal x0 or x2. */
+				instr2 = get_unaligned_le32(buf + i + 4);
+
+				if (((instr << 8) ^ (instr2 - 3)) & 0xF8003) {
+					i += 6 - 2;
+					continue;
+				}
+
+				addr = (instr & 0xFFFFF000) + (instr2 >> 20);
+
+				instr = 0x17 | (2 << 7) | (instr2 << 12);
+				instr2 = addr;
+			} else {
+				/* AUIPC's rd equals x0 or x2. */
+				instr2_rs1 = instr >> 27;
+
+				if ((uint32_t)((instr - 0x3117) << 18)
+						>= (instr2_rs1 & 0x1D)) {
+					i += 4 - 2;
+					continue;
+				}
+
+				addr = get_unaligned_be32(buf + i + 4);
+				addr -= s->pos + (uint32_t)i;
+
+				instr2 = (instr >> 12) | (addr << 20);
+
+				instr = 0x17 | (instr2_rs1 << 7)
+					| ((addr + 0x800) & 0xFFFFF000);
+			}
+
+			put_unaligned_le32(instr, buf + i);
+			put_unaligned_le32(instr2, buf + i + 4);
+
+			i += 8 - 2;
+		}
+	}
+
+	return i;
+}
+#endif
+
 /*
  * Apply the selected BCJ filter. Update *pos and s->pos to match the amount
  * of data that got filtered.
@@ -439,6 +533,11 @@ static void bcj_apply(struct xz_dec_bcj *s,
 	case BCJ_ARM64:
 		filtered = bcj_arm64(s, buf, size);
 		break;
+#endif
+#ifdef XZ_DEC_RISCV
+	case BCJ_RISCV:
+		filtered = bcj_riscv(s, buf, size);
+		break;
 #endif
 	default:
 		/* Never reached but silence compiler warnings. */
@@ -615,6 +714,9 @@ XZ_EXTERN enum xz_ret xz_dec_bcj_reset(struct xz_dec_bcj *s, uint8_t id)
 #endif
 #ifdef XZ_DEC_ARM64
 	case BCJ_ARM64:
+#endif
+#ifdef XZ_DEC_RISCV
+	case BCJ_RISCV:
 #endif
 		break;
 
diff --git a/lib/xz/xz_dec_syms.c b/lib/xz/xz_dec_syms.c
index 495d2cc2e6e8..f40817d65897 100644
--- a/lib/xz/xz_dec_syms.c
+++ b/lib/xz/xz_dec_syms.c
@@ -22,6 +22,6 @@ EXPORT_SYMBOL(xz_dec_microlzma_end);
 #endif
 
 MODULE_DESCRIPTION("XZ decompressor");
-MODULE_VERSION("1.1");
+MODULE_VERSION("1.2");
 MODULE_AUTHOR("Lasse Collin <lasse.collin@tukaani.org> and Igor Pavlov");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index 307e0de8c260..a8b1cbe8d21d 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -39,6 +39,9 @@
 #		ifdef CONFIG_XZ_DEC_ARM64
 #			define XZ_DEC_ARM64
 #		endif
+#		ifdef CONFIG_XZ_DEC_RISCV
+#			define XZ_DEC_RISCV
+#		endif
 #		ifdef CONFIG_XZ_DEC_MICROLZMA
 #			define XZ_DEC_MICROLZMA
 #		endif
@@ -102,7 +105,8 @@
 #	if defined(XZ_DEC_X86) || defined(XZ_DEC_POWERPC) \
 			|| defined(XZ_DEC_IA64) \
 			|| defined(XZ_DEC_ARM) || defined(XZ_DEC_ARMTHUMB) \
-			|| defined(XZ_DEC_SPARC) || defined(XZ_DEC_ARM64)
+			|| defined(XZ_DEC_SPARC) || defined(XZ_DEC_ARM64) \
+			|| defined(XZ_DEC_RISCV)
 #		define XZ_DEC_BCJ
 #	endif
 #endif
-- 
2.45.2


