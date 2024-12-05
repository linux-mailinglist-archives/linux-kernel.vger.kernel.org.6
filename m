Return-Path: <linux-kernel+bounces-433103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 476FE9E53E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C11282E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8060A1F5414;
	Thu,  5 Dec 2024 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3D1RC7v"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14086202C51
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398112; cv=none; b=LsEMrdolulOhi7olIPxwmVBRNUy0v87UMg3Rq4zsF3VJbOOrBff8c7M+s36dmI0LwV2vs2AVXLs/WYMc/86357gcaHbs236DNl/X22BhEApgjlnta1Ljw42d2rVyeIxqaLu98BZcp4dTXwEjoR+eGnxKJeBZFZXPX8woQCfvaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398112; c=relaxed/simple;
	bh=lni3T7nAOKqeKR9aOuwR3FyPjos9+9swT71Frm1TROA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wj8bQgoEE3rzqW3G/xnAVNlF1UaUA7STvUoDwsAjeKWZCfcGTmAzEaMjUQr7QvjDFQy2otsrwH+ejq990I3ajLO6jyIGWy/u31S4V8oOw6Il5RWdr9UR1nVQ4294LScEse/Iik08m0QY6IGdN/cB2lTF+3ua7OgMoo+wwEP1Dog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3D1RC7v; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434c214c05aso7241535e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733398109; x=1734002909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVHFtdC4tGHrnT2RLaG/kfBVCtydj5FxuAbxuEoeQDM=;
        b=b3D1RC7vKxAsdbI99xd/7GOqQ84WNcUhns2jQpYq0xzstbgIC/Ep7TiiKIhJFh34do
         gep5ghQ8QSxSZAO5dvG7MEt+AtaD+KMhJPelEaxYLk/RPepD8Qa0/URh6Av0+G2rXZpw
         VhDI8uXo7+PVg1XceG3x+DOSc1CpGaS+A2lzbHVS8GZ+VnScLRMcqHdc8DDu5GyAycAJ
         Tqev1S537JYeHNkvxwaYC5j9gJ/7AoV7lxdBKC4pyPoJKA34FqaRqhNDTlBvkXsUDIPQ
         iB1/UNibfY9Eq/terT0wUVJho5rsUkQhoQQPPuGhx7yUs5r6QJ0F+zhEfA20uEz+96gH
         x8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398109; x=1734002909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVHFtdC4tGHrnT2RLaG/kfBVCtydj5FxuAbxuEoeQDM=;
        b=H2PvQrcyQamXqkFCZ2tgEkaDv9PXgYC/Ztg3X0SwH6+BvlYBQBqC5Hjwp4t6Uuf8wD
         DSYwOPdrBRMbjxEuDhIT/apCSqq6P9HI873tbdMZ2tEfdfOi01r7h0WZmYB5YXTKKTQt
         MauBZaCb/25Qmva6zUxryyCRXNV0VaO6ueSZjRSA8it9KHnr4TvKHpxgmns5LO7xXHuT
         1jpKFItm+5ieQ3SjzjMKdeRemaJkL2hfOX6v1Y+Hm/W7N6uMfgh+vXeGhXeCgMjYlj3o
         3IPIxkEKQ2tywQGVEbjf9JT2bN24kZxFKhZNuQufWylnESEOjcRLWY5Xql2+JJLuISEM
         OSeA==
X-Gm-Message-State: AOJu0Yy/lvsfGge5X6xDHkv04dOiaHWhFIpIBxdmKkthd8R4ly0itxGL
	sq8XoB175N4K0Q6FGrPtdOJfZAMUpV6FxxorIgEhEXvd3TFdCI3s4LuKCuxEAHSllq7pROSznT7
	fgITCeoCXRTuY4BvbTiZAjv2HU/XkLQOkVaAX4ICM845MK42NupkaO/TDCf+2dP3mCJjeE0pTWo
	ItXfcAZvrAcwCNxE5Xq2XSqy5hi6bu7Q==
X-Google-Smtp-Source: AGHT+IFTBWeUj+w5hoMCItRs01C+vgEGeOiYmN6U1m93meOyBKQFdsSn/zlL9qmWVZYMLtF+AbhRnW6h
X-Received: from wmpu36.prod.google.com ([2002:a05:600c:4d24:b0:434:9e7b:42c1])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1553:b0:431:93dd:8e77
 with SMTP id 5b1f17b1804b1-434d0a16c18mr95064735e9.31.1733398109494; Thu, 05
 Dec 2024 03:28:29 -0800 (PST)
Date: Thu,  5 Dec 2024 12:28:09 +0100
In-Reply-To: <20241205112804.3416920-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205112804.3416920-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=ardb@kernel.org;
 h=from:subject; bh=uES8g+LccWV6nXK1JQl+/U3ZNTuBuvX5wGEg7FtZn6A=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT2wz9vp4yGz0uwJlh+EbzcXXn7quvnf3LfbZslUTo51i
 T/9J2tdRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIFgvD/9JU3fO7v6ctXF1x
 bMY7n/6GFye0Jl/NqTNzTzp/2CvlmDTDf7e5LDGsPQ8X6WgtY8hozXSJ9Q3vEK284cO2VD2660g 4GwA=
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205112804.3416920-13-ardb+git@google.com>
Subject: [PATCH v4 4/7] x86/boot: Disable UBSAN in early boot code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The early boot code runs from a 1:1 mapping of memory, and may execute
before the kernel virtual mapping is even up. This means absolute symbol
references cannot be permitted in this code.

UBSAN injects references to global data structures into the code, and
without -fPIC, those references are emitted as absolute references to
kernel virtual addresses. Accessing those will fault before the kernel
virtual mapping is up, so UBSAN needs to be disabled in early boot code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/coco/sev/shared.c  | 7 ++++---
 arch/x86/include/asm/init.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index afb7ffc355fe..96023bd978cc 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -498,7 +498,7 @@ static const struct snp_cpuid_table *snp_cpuid_get_table(void)
  *
  * Return: XSAVE area size on success, 0 otherwise.
  */
-static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
+static u32 __head snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 	u64 xfeatures_found = 0;
@@ -576,8 +576,9 @@ static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpui
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-				 struct cpuid_leaf *leaf)
+static int __head
+snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+		      struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 14d72727d7ee..0e82ebc5d1e1 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
-#define __head	__section(".head.text")
+#define __head	__section(".head.text") __no_sanitize_undefined
 
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
-- 
2.47.0.338.g60cca15819-goog


