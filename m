Return-Path: <linux-kernel+bounces-438621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D149EA391
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFEB1882CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88DE4DA04;
	Tue, 10 Dec 2024 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXi6cVnf"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DD67A0D;
	Tue, 10 Dec 2024 00:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789972; cv=none; b=doFBzSBxTdqTkOLFQADZbQehoucllr0XEVYc+hB+F2ald2rwAuMmTTtpBag0KECzW8/iDR2WqfZQgWhL6h/sia2nZ8uoO30VHEKADmC+ccUZs6clT/9jzlG8a4UcqSPVW2gr6g1oxA12Xqp0naSpL2syPHF3Wuqz7oD+KuPSA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789972; c=relaxed/simple;
	bh=/K4eSvI1Ipf4Aur9iVP05PUVjTwf8ShxKmTB6bwov2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVQbw4+tR7YQVnKlXnn0c9kN15akh5mHcS6qAeS1a0d/q32rTLY4qYAHc/eBylQD4sw99ozY2LumWF0o7vD96rAITkxN0NZpFg8gKdORGSh6ejdQGmSVM1Emq0FOWPFpd/b+lel+bIOQa59TFQby9PQarTQ4opVTyJ+8ljVHWrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXi6cVnf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725ee27e905so1722447b3a.2;
        Mon, 09 Dec 2024 16:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733789970; x=1734394770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaW3Ni06SPvaTbLHs0pbUeHaTTwDPxQuBfccVmzf3vY=;
        b=eXi6cVnfnoFFYmTXCwAR4NtO3coNe4MMjc1NInp64kzE+FhLxMT3PL7g86HYx9a4es
         DH9wjGzLvcyBZ58P7+KsxYXwLeGiVM/pgK5qyy2IK9+WzTLgIy4MKCyBwjb0BZpFoq0H
         Cdlv/OyFEt1EkboJwQTfmW9rD5pNG297TrpXgc17Wf9PFguujL/l0SAejRHTW7tU9Gon
         4Q65g3vOus5HEWuMVZ5OZ8PAnobmtahi5TTADXDBRpjD70l5Xgv1SsFUzrTkUxcH6oFD
         iLNAmDEijF2xsjo0C4aoOqQDmFPqCEts3fXJReFj18iz/SypK1+RaIuchjSMpypHr8wj
         S2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789970; x=1734394770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaW3Ni06SPvaTbLHs0pbUeHaTTwDPxQuBfccVmzf3vY=;
        b=vVdozXWui4+/eDvRQCGqAAnuWKH79Ce7AioUvULn8xoWan8vwEb+4oofMey96Io9Z9
         gEdIaU1piaO/aAgSstlD6dfFKuMEsDpbnHo8HUKnEZgOQVsRGZwNqUej6Ddqh69B3r2N
         hXrTcFX5SElSpo4l2hZTAQQtk7M7WTPkcQ01AKn/2sd+i4qluzzuWTVrtiqswew77qli
         vUm+TqdpxyhmLjimJ9ZBCavYvwJcoAqF2W5+ei07JRht2yhmCRig2/NcC/YUGuhF+woF
         baAT+wmIDQejQ7H2LQ5HNgsvQT9bLQlpxBt6Qgtd2Z7ns5gyUDi0va3CI2lV2S4fWn93
         5ZBw==
X-Forwarded-Encrypted: i=1; AJvYcCXDRI9B00qDtQAaBYwV5dpFBPAz9BmR8Ikh+wu19ysKdbq9zbb1tV0hEPH4anEC5hRPZcu+J0LmpmC9hXAB2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWuGJte6qhVvEnvqA2fKh0hkp01eNA7uq2xRj7YMQS65PHSALq
	+3Sn/Dx9bXn4qcoLGDfz2uiPg7W3HlRH9zJ/PdThgznXjWsHQlzAIYe3VNdC
X-Gm-Gg: ASbGncu02i1W9WnCiBxU2zvTe0qC751FFOE1a2t4lwTHjCDvQzrT4eegsGXf+IXilmg
	+gFnIPmYagW4eSekG2OXtiLeC4inMtvPuGIIhkVDVcb7PI8/tnaEfrwQp7Rxqwwj/WgTX0JmS5T
	gUFpgTbWghE+SQ4OyXYXqhLbvlveYyBpCUrDU25EwFkEUUittso4tY0zJedYLfPeTooseNoDIAX
	Se9zu27bmYGbHna+017vOZ/FABJu9OQM3r1OlKNhhpDnW/8J/loba8n4mSuxPn9vOZggFe/4suF
	9ag+qG+CxfqRmYvP7yRoYkiyYLqh
X-Google-Smtp-Source: AGHT+IEHFQLb+CnaKIfB/aQiVn4EtFWGkBf9ZZUksgIXRkbcaqD+tHXdDTDwGlizNlrZosk3pbCxTw==
X-Received: by 2002:a05:6a00:1d8b:b0:725:dab9:f732 with SMTP id d2e1a72fcca58-725dab9f7f2mr11873956b3a.22.1733789970068;
        Mon, 09 Dec 2024 16:19:30 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f1fba027sm2005005b3a.3.2024.12.09.16.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:19:29 -0800 (PST)
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
Subject: [PATCH v1 3/5] arm64/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with Rust
Date: Tue, 10 Dec 2024 09:17:59 +0900
Message-ID: <20241210001802.228725-4-fujita.tomonori@gmail.com>
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
 arch/arm64/include/asm/asm-bug.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index 6e73809f6492..822e9d51d3e9 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -21,16 +21,21 @@
 #endif
 
 #ifdef CONFIG_GENERIC_BUG
-
-#define __BUG_ENTRY(flags) 				\
+#define __BUG_ENTRY_START				\
 		.pushsection __bug_table,"aw";		\
 		.align 2;				\
 	14470:	.long 14471f - .;			\
-_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
-		.short flags; 				\
+
+#define __BUG_ENTRY_END					\
 		.align 2;				\
 		.popsection;				\
 	14471:
+
+#define __BUG_ENTRY(flags)				\
+		__BUG_ENTRY_START			\
+_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
+		.short flags;				\
+		__BUG_ENTRY_END
 #else
 #define __BUG_ENTRY(flags)
 #endif
@@ -41,4 +46,22 @@ _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 
 #define ASM_BUG()	ASM_BUG_FLAGS(0)
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_LOCATION_STRING(file, line)		\
+		".long " file "- .;"			\
+		".short " line ";"
+#else
+#define __BUG_LOCATION_STRING(file, line)
+#endif
+
+#define __BUG_ENTRY_STRING(file, line, flags)		\
+		__stringify(__BUG_ENTRY_START)		\
+		__BUG_LOCATION_STRING(file, line)	\
+		".short " flags ";"			\
+		__stringify(__BUG_ENTRY_END)
+
+#define ARCH_WARN_ASM(file, line, flags, size)		\
+	__BUG_ENTRY_STRING(file, line, flags)		\
+	__stringify(brk BUG_BRK_IMM)
+
 #endif /* __ASM_ASM_BUG_H */
-- 
2.43.0


