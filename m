Return-Path: <linux-kernel+bounces-438619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F013C9EA38F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C7D1658A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB82AE84;
	Tue, 10 Dec 2024 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEQPPnQT"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68618801;
	Tue, 10 Dec 2024 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789961; cv=none; b=id/NPghPuIEi64WedZOUrW7nNjAU0ns9QQJAd4WYCPV6tDcxLJTa1WnTkFX3schfxoG522UkCNZ15h7klGx0y35bvfK0edjB2SypdQRdw9DQIsEItV28FKyrrxkf88y+jclQ+M0pfX55f936mV+zIOu94ZesSTM66H8hExA0v7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789961; c=relaxed/simple;
	bh=Dcj41wgoErpyvv6rMccASWdZmCVr+BwsDARBxcvPC6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeQxmW4J+ydi4EdgU3yye1GIQWQ37lVqGzWKfwL+/2O3J4p7z3by+FRgvMIW2gQXd6B/kwiKHbqW+kt8pHGUGreflDa8IwiyPt2613Z05Sob4qjXx8/I5/B9pK0pAkW46Jwn72lrXUmGfJlTVsZ2Q8GxA4q3dDN57WC0NxSFGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEQPPnQT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725c86bbae7so2736914b3a.3;
        Mon, 09 Dec 2024 16:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733789957; x=1734394757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvYxXwvEnjyqSBQUdMwEVvz9hfO5O8pSiGSR6Ept2V0=;
        b=NEQPPnQTv0JCzN3c9ZkiWvlg6LlVrITeoUP0ufWgiwcqWIEInLK8BpExEt6Agx+YLv
         sCKSgFHAoJNZBqSxSeKzKNa99O1vJAzeje3IOHylenTiUUwi+L81+fPj86mZS0vDm23B
         6zS4MJFCoip13ubI4Vsb6UvxH+jgv6bB/uI8E/jaKHoj2x22F+OCjWrdYSJiN4bRwWu/
         Epai1Y40bx0eTJNmzkCIT69VWID250fIftFCZtmZ1hcLyW1JJzRnpfG2tcsT6SWcGUBy
         j8J64vIvzrAMzuVtj4w61xe8EU/dQ9wrP2SiLOs2kLmtby8pLvkOI+6VYyFsJyIILU3C
         JOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789957; x=1734394757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvYxXwvEnjyqSBQUdMwEVvz9hfO5O8pSiGSR6Ept2V0=;
        b=mTwjp+8kewfDJWbBvp1QuXXseYO5OgPJLmLc57UsxQ0r3cpaFyWrzzAOIb3zhDzoSH
         KBXGb36FLKSkyXte5Gz69DhSCcqXEOo+6tR/E4yvqqeD/FMbnM+MLu90ZIC0J5cNeSgT
         t5S6E0ziDSPYV2g8EDmGPmOKlMIn8/RAPEfwVuBX9rDUrPnBhZ4Fb10FgOHJtalySxaP
         wj9Kr7sdVM2fSKCmeo7RELtodLKLIZdEZSD9zHJyS6hY+Tq0qqj6tSwul/QN0EMtFAJZ
         AVUL8e+F6sgMaYZMMEt6nWnpprk6wvIOYoNP1Ye5xcALSldVE52hwT5UJXUZ2LSAQdzU
         Y9XA==
X-Forwarded-Encrypted: i=1; AJvYcCUvcS0UJPKzdu49u8b6EgfM4ANAE/v16ZNZkSa5LsYAYTWZajrUhpp00SJWv6dc8hY4SyMusKpI/8uupY11+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0IDAckaV7mLEpfA/oKb97klSPuEZKiUMMexBa95al2bBSP3EM
	06fjVQLQ1zAq9wz/B6SxPDGdXInQEtFSUY4najK/H5tdA2DraAuPzSdwMv9b
X-Gm-Gg: ASbGnctGtcP3LRJiKJL8dYUgaqocRJ/w3B9mnhci/FGVdAxxGS/0gU+0t6dJZMnZ1Aa
	7emnTOmrfuJWXRfTzuR1p/S90qgEzXzgsES6KsAtQPxE8312wcX8Id80hwc6ja2hHoMfI6tNypR
	pwvnHkieCxR/czBjk+sgMbaos917pNrHsi2Pt5RFkGBb7Zp3q+DYyGsmjIwhG4ZZ4f4obJy8UG+
	pAJ7yr9nIAuviFiNGDiGsDbkRpoUZH+5WUPSVEapbfyUFz8tTDmupo1Lyieui0T0A/25p9OexJa
	e69dwo5fsIOAricf1Uikl4TPe/al
X-Google-Smtp-Source: AGHT+IGXDLB74qKfVuatRG8d4NT0q2/7WE7V1EKSlo1ahbfyprBuniJ//vSx8P3YzstgSPlCq25zXA==
X-Received: by 2002:a05:6a00:1815:b0:725:e015:9090 with SMTP id d2e1a72fcca58-7273c90ae9bmr3318953b3a.9.1733789957264;
        Mon, 09 Dec 2024 16:19:17 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f1fba027sm2005005b3a.3.2024.12.09.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:19:17 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	peterz@infradead.org,
	hpa@zytor.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tangyouling@loongson.cn,
	hejinyang@loongson.cn,
	yangtiezhu@loongson.cn,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Subject: [PATCH v1 1/5] x86/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
Date: Tue, 10 Dec 2024 09:17:57 +0900
Message-ID: <20241210001802.228725-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210001802.228725-1-fujita.tomonori@gmail.com>
References: <20241210001802.228725-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new ARCH_WARN_ASM macro for BUG/WARN assembly code sharing with
Rust to avoid the duplication.

No functional changes.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 arch/x86/include/asm/bug.h | 51 ++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 806649c7f23d..71df68e2a731 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -28,45 +28,42 @@
 #ifdef CONFIG_GENERIC_BUG
 
 #ifdef CONFIG_X86_32
-# define __BUG_REL(val)	".long " __stringify(val)
+# define __BUG_REL(val)	".long " val
 #else
-# define __BUG_REL(val)	".long " __stringify(val) " - ."
+# define __BUG_REL(val)	".long " val " - ."
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_ENTRY(file, line, flags)					\
+	"2:\t" __BUG_REL("1b") "\t# bug_entry::bug_addr\n"		\
+	"\t" __BUG_REL(file)   "\t# bug_entry::file\n"			\
+	"\t.word " line        "\t# bug_entry::line\n"			\
+	"\t.word " flags       "\t# bug_entry::flags\n"
+#else
+#define __BUG_ENTRY(file, ine, flags)					\
+	"2:\t" __BUG_REL("1b") "\t# bug_entry::bug_addr\n"		\
+	"\t.word " flags       "\t# bug_entry::flags\n"
+#endif
+
+#define _BUG_FLAGS_ASM(ins, file, line, flags, size, extra)		\
+	"1:\t" ins "\n"							\
+	".pushsection __bug_table,\"aw\"\n"				\
+	__BUG_ENTRY(file, line, flags)					\
+	"\t.org 2b + " size "\n"					\
+	".popsection\n"							\
+	extra
 
 #define _BUG_FLAGS(ins, flags, extra)					\
 do {									\
-	asm_inline volatile("1:\t" ins "\n"				\
-		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
-		     "\t.word %c1"        "\t# bug_entry::line\n"	\
-		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c3\n"					\
-		     ".popsection\n"					\
-		     extra						\
+	asm_inline volatile(_BUG_FLAGS_ASM(ins, "%c0",			\
+					   "%c1", "%c2", "%c3", extra)	\
 		     : : "i" (__FILE__), "i" (__LINE__),		\
 			 "i" (flags),					\
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
 
-#else /* !CONFIG_DEBUG_BUGVERBOSE */
-
-#define _BUG_FLAGS(ins, flags, extra)					\
-do {									\
-	asm_inline volatile("1:\t" ins "\n"				\
-		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c1\n"					\
-		     ".popsection\n"					\
-		     extra						\
-		     : : "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
-} while (0)
-
-#endif /* CONFIG_DEBUG_BUGVERBOSE */
+#define ARCH_WARN_ASM(file, line, flags, size)				\
+	_BUG_FLAGS_ASM(ASM_UD2, file, line, flags, size, "")
 
 #else
 
-- 
2.43.0


