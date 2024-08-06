Return-Path: <linux-kernel+bounces-276919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A051B949A11
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A21B1F252A3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568C17839B;
	Tue,  6 Aug 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4WmCiMAK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7001779B8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979289; cv=none; b=l0N3sefkUUTZVs5iWdF0+0fhA44syFOy/YPbtq2Oocb1lejX27OBVLY0sXfKgVsj9eUF4elL4rhPhkm21mn/78In89cQzBP6AI/LsVdKS8CNxHMndXm1MaAph4mvKZSMzZ8P1uuEmJY41zRTkZmdED4Ux1HC9+U9ffZSEfN1a8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979289; c=relaxed/simple;
	bh=Okhe1T5As6Y64+KRW1MjEmzZ0Hbd7KikHv1V2PgrJsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MhRCRHsq2ue14ciGATjZEOWhS+rqt0P+z0KLT164EYKzDNI/HfJIrmXzRNJSOuVCorPPhufwM2OcjgN6blz1HBefWQ6+Ry903MtPQpm8+Tb1D9FBSWhyP/NQwbgrzyK3ERqMV9KffAvZ4E3qsyaWCFdYCjx6xJiWHu5sQ/VMvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4WmCiMAK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-68fd6ccd4c8so21176657b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979287; x=1723584087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAFNE/2pEcN+jEiRbAPKQh51YEyYvD+OIb1ItIySijg=;
        b=4WmCiMAKduvUZyAP9BxIYPo7b/CvFzQZa8FKEdeUq7SikwFTgZQbLAR+Mw0P5hksIR
         R0NkfSyDEb+UEUohgsj44P7Bcq3cwN0QFk9vCaePKh3+mX86yRQ0Ktjj8jXyLRwdbMja
         ZW0iQGsS6KJSIEvLQxll/Vl6mmOP8HsB+ZDPIaryLBrfkK7at7roc3vnFq4j9s/NUER8
         W87ZFrrgGiPm7tjJSOuj8eG99O5glfFj5rsb1t7wDTeLCKUwBiVs4Jgr8advlGC/LdVV
         FBSqKYQ/agLSEe1mneZ2yymXoraRh+wlEjwQOzgOYDfOzBYRSroIf5+WJb7Ev2gAh5VN
         LRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979287; x=1723584087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAFNE/2pEcN+jEiRbAPKQh51YEyYvD+OIb1ItIySijg=;
        b=E4hPqtCr8Hbo53pbHyL6v6wEyb4T0pvKFaUCzxfLhKHMVp/X4jFP/RdR5t6bTWt6KQ
         +4hashd5EnBfIJ6VMcZGxThTgNLF9S19CTevvWliuH3o1Shr+7DqXr+uO9B9TBr/PNG1
         7V8R5WYP12oIiebHz7Utf00lG6NMEMSBTfbHqL0IFG7LS/98MPg6/dZ0BJL0Zuw+jxA3
         mXvRPIZPwOpZj/6iKh70OUKTfOhTrarLXIR+lCsjoQ95ajt7KDdpLkeqj6PoFouDd3Ea
         LhIAFjt53+ygXKuLe+UUN1niOKtJWSLpWVaj43fpK+DIm0cGyQ4AQAJet3cM7pKw4Rx5
         fH3g==
X-Forwarded-Encrypted: i=1; AJvYcCW6SMJ8401MvpyimvW6WwLwcaRhgmiXJg3K1AvPjg8FBaoF9ta9BoH/c6ovPTy3x3V4BiajM3gY6tuKXocF8Gt1KOSyI5ZHc2kLRJ7V
X-Gm-Message-State: AOJu0YyMAjMptZhC8eVs1ix+r2qaSM8XrOk3Gj6elUIlgfBZHFk6IkUJ
	6ZzaOLWg6c3NdMfDT2ek+McTXgw7Z9K+U8C2sKrBdAv4ksXc+QtRWoA8Jg8bRvlZFHTyANBj0dI
	oMTfe+Q==
X-Google-Smtp-Source: AGHT+IEzhkK2hIEZemS/GfHuHvcaKTZwEFGEZ6GZBQ1IPi5h6XQ4rxIprirl+QthlbpWBOw+2Rg13mYDMQTW
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:113:b0:648:3f93:61f2 with SMTP id
 00721157ae682-689641a414emr7231967b3.6.1722979286737; Tue, 06 Aug 2024
 14:21:26 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:34 +0000
In-Reply-To: <20240806212106.617164-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-9-mmaurer@google.com>
Subject: [PATCH v3 08/16] module: Factor out elf_validity_cache_index_str
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pull out index validation for the symbol string section.

Note that this does not validate the *contents* of the string table,
only shape and presence of the section.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 53597b785e2a..dec733989ad6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2014,6 +2014,31 @@ static int elf_validity_cache_index_sym(struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_index_str() - Validate and cache strtab index
+ * @info: Load info to cache strtab index in.
+ *        Must have &load_info->sechdrs and &load_info->secstrings populated.
+ *        Must have &load_info->index.sym populated.
+ *
+ * Looks at the symbol table's associated string table, makes sure it is
+ * in-bounds, and caches it.
+ *
+ * Return: %0 if valid, %-ENOEXEC on failure.
+ */
+static int elf_validity_cache_index_str(struct load_info *info)
+{
+	unsigned int str_idx = info->sechdrs[info->index.sym].sh_link;
+
+	if (str_idx == SHN_UNDEF || str_idx >= info->hdr->e_shnum) {
+		pr_err("Invalid ELF sh_link!=SHN_UNDEF(%d) or (sh_link(%d) >= hdr->e_shnum(%d)\n",
+		       str_idx, str_idx, info->hdr->e_shnum);
+		return -ENOEXEC;
+	}
+
+	info->index.str = str_idx;
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -2037,7 +2062,6 @@ static int elf_validity_cache_index_sym(struct load_info *info)
 static int elf_validity_cache_copy(struct load_info *info, int flags)
 {
 	int err;
-	int str_idx;
 
 	err = elf_validity_cache_sechdrs(info);
 	if (err < 0)
@@ -2054,16 +2078,11 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	err = elf_validity_cache_index_sym(info);
 	if (err < 0)
 		return err;
-
-	str_idx = info->sechdrs[info->index.sym].sh_link;
-	if (str_idx == SHN_UNDEF || str_idx >= info->hdr->e_shnum) {
-		pr_err("Invalid ELF sh_link!=SHN_UNDEF(%d) or (sh_link(%d) >= hdr->e_shnum(%d)\n",
-				str_idx, str_idx, info->hdr->e_shnum);
-		return -ENOEXEC;
-	}
+	err = elf_validity_cache_index_str(info);
+	if (err < 0)
+		return err;
 
 	/* Sets internal strings. */
-	info->index.str = str_idx;
 	info->strtab = (char *)info->hdr + info->sechdrs[info->index.str].sh_offset;
 
 	/* This is temporary: point mod into copy of data. */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


