Return-Path: <linux-kernel+bounces-337635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D30984CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497A3284DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BDA1AD404;
	Tue, 24 Sep 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFA4vnhG"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA111ACDE5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212848; cv=none; b=l70+ChiTXlUt226x8N7KXCyXVZVDa0oDtYZHo3KAcxKuqvGyi/pWZxYgOuv3L+GTdvSGhV1Wk9C05hGifQhdSEXbFsr8QcGONhK6fqsbAkDKjwu0k4oPYq+tUxcqdKQwfwpVUY6lNpGSK8zLBMYV4YVOkSZRCvKBygU/7aQ4MSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212848; c=relaxed/simple;
	bh=hPcayIG4Zzk7TfnQCe5VB/OkeMCLVNaFCb22SLuD7xA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UsjsKhhlhQGb5izbzvXyXOX9C+zmS3B1FzI5JEYeoizi8lfmedlDTq1BrngW+sB/83WUQKHuJltlroiXkFOByUi1+bLSLjveoEQRsRR8iFdOyJ8qnZje7eKRmlsrlDKnlvGJMlVt353E8VJCPaXfaV0aJ/OTrpxvkG6uMsQY38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFA4vnhG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e201a37e5a4so9615112276.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727212846; x=1727817646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0kXAOzmEEQHXzTmLkL/vEUOj2egGiISa865No2odHA=;
        b=YFA4vnhG7v3wBEtJRSWPxljSAzlMN9QnEngViZVnd5PDdLWNLb0TIe1vq+uOBLMt8Z
         kcQ7DwG5Ba47eaBGIw1UZM4yGCOj9NPz30vGbA7kybcrY7ORgrAG+cKVXxTt9f6Dqebh
         bXTzpQTWhjRCqF2t9rBT+Svoe0/FMXIyGwoFI77fUqOKfiMqUrrT3kkuX5gZ8EUuZ3hA
         KF0AmhvkGLN9nxAKwWTdM/1OajsPW5z3fobqzK6IV7ZgUeiGIKlll6wbmTVfT4kTGbQD
         XI0Q0BcbBcryqiuPJRNeH/EY2aBAwoEGIRPuvshu477qzEZAzOf4IjYJe9Gd7hm0kSM2
         c9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212846; x=1727817646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0kXAOzmEEQHXzTmLkL/vEUOj2egGiISa865No2odHA=;
        b=r4lXID89ImXDEjkPHdmUJ4/gKoM+oYCFqxLBEZdTklSuSlemqcEApgMoo5mK/fNf2a
         ItOnm4UJtBcPZ8i1px7peapN+SHbwslxmi0+qC4QvbkgxGAuOOpZSLRUzgxPLOf+pfIC
         TVpv0k5yeCP+SfQtdtvPyoYMOsV/aYwfSTmjFEHw0hUds/3c6vdZIrrwJR3AmyKouigS
         Dz+UG8jPzHrD1yxgao0SM8Kv/uUM9ohkUuT8H2zYa4S7032HVBniow0y2sLO5qv4ZR9w
         eUy7zbFhJ8QNR2uMicACu7XS79OflaJXwZqaWQ10eh/fqksik4nPgErA7sO/8tn2hq+V
         Og6g==
X-Forwarded-Encrypted: i=1; AJvYcCW7zdE9baGrjHIlIC20dPpb/w2BAXfv6OWw1yfBvGYewxCEeXcu/Efse9DBxQ6H9pktTI/60nK02imEi5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTMbKvGn0DC74hSO9n7J5tzUvkngzQpiXnm40wSUtlaY6J/Qg
	NCPs49Lcw/3nUOb8N/at8dhqhbHvub5Omoa+1fnXR5yYZ6Ns0faG9aSFH6VBzjTMIHkL2dECtfv
	KiYsB9A==
X-Google-Smtp-Source: AGHT+IHDISpnfdzBaOTWR8C0ioj3uPYVqLGAlaWzdMvCzf+f+r+0H0cGN2cqc+XvC1wkkQdhXDCIGGe8xEvv
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:d608:0:b0:e0b:ab63:b9c8 with SMTP id
 3f1490d57ef6-e24da399c47mr364276.11.1727212846139; Tue, 24 Sep 2024 14:20:46
 -0700 (PDT)
Date: Tue, 24 Sep 2024 21:19:49 +0000
In-Reply-To: <20240924212024.540574-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924212024.540574-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240924212024.540574-8-mmaurer@google.com>
Subject: [PATCH v4 07/16] module: Factor out elf_validity_cache_index_sym
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Centralize symbol table detection and property validation.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index ec638187ffcf..6be58b0a6468 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1980,6 +1980,39 @@ static int elf_validity_cache_index_mod(struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_index_sym() - Validate and cache symtab index
+ * @info: Load info to cache symtab index in.
+ *        Must have &load_info->sechdrs and &load_info->secstrings populated.
+ *
+ * Checks that there is exactly one symbol table, then caches its index in
+ * &load_info->index.sym.
+ *
+ * Return: %0 if valid, %-ENOEXEC on failure.
+ */
+static int elf_validity_cache_index_sym(struct load_info *info)
+{
+	unsigned int sym_idx;
+	unsigned int num_sym_secs = 0;
+	int i;
+
+	for (i = 1; i < info->hdr->e_shnum; i++) {
+		if (info->sechdrs[i].sh_type == SHT_SYMTAB) {
+			num_sym_secs++;
+			sym_idx = i;
+		}
+	}
+
+	if (num_sym_secs != 1) {
+		pr_warn("%s: module has no symbols (stripped?)\n",
+			info->name ?: "(missing .modinfo section or name field)");
+		return -ENOEXEC;
+	}
+
+	info->index.sym = sym_idx;
+
+	return 0;
+}
 
 /*
  * Check userspace passed ELF module against our expectations, and cache
@@ -2003,10 +2036,8 @@ static int elf_validity_cache_index_mod(struct load_info *info)
  */
 static int elf_validity_cache_copy(struct load_info *info, int flags)
 {
-	unsigned int i;
-	Elf_Shdr *shdr;
 	int err;
-	unsigned int num_sym_secs = 0, sym_idx;
+	int str_idx;
 
 	err = elf_validity_cache_sechdrs(info);
 	if (err < 0)
@@ -2018,34 +2049,21 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	if (err < 0)
 		return err;
 	err = elf_validity_cache_index_mod(info);
+	if (err < 0)
+		return err;
+	err = elf_validity_cache_index_sym(info);
 	if (err < 0)
 		return err;
 
-	for (i = 1; i < info->hdr->e_shnum; i++) {
-		shdr = &info->sechdrs[i];
-		if (shdr->sh_type == SHT_SYMTAB) {
-			if (shdr->sh_link == SHN_UNDEF
-			    || shdr->sh_link >= info->hdr->e_shnum) {
-				pr_err("Invalid ELF sh_link!=SHN_UNDEF(%d) or (sh_link(%d) >= hdr->e_shnum(%d)\n",
-				       shdr->sh_link, shdr->sh_link,
-				       info->hdr->e_shnum);
-				goto no_exec;
-			}
-			num_sym_secs++;
-			sym_idx = i;
-		}
-	}
-
-	if (num_sym_secs != 1) {
-		pr_warn("%s: module has no symbols (stripped?)\n",
-			info->name ?: "(missing .modinfo section or name field)");
-		goto no_exec;
+	str_idx = info->sechdrs[info->index.sym].sh_link;
+	if (str_idx == SHN_UNDEF || str_idx >= info->hdr->e_shnum) {
+		pr_err("Invalid ELF sh_link!=SHN_UNDEF(%d) or (sh_link(%d) >= hdr->e_shnum(%d)\n",
+				str_idx, str_idx, info->hdr->e_shnum);
+		return -ENOEXEC;
 	}
 
-	/* Sets internal symbols and strings. */
-	info->index.sym = sym_idx;
-	shdr = &info->sechdrs[sym_idx];
-	info->index.str = shdr->sh_link;
+	/* Sets internal strings. */
+	info->index.str = str_idx;
 	info->strtab = (char *)info->hdr + info->sechdrs[info->index.str].sh_offset;
 
 	/* This is temporary: point mod into copy of data. */
@@ -2066,9 +2084,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	info->index.pcpu = find_pcpusec(info);
 
 	return 0;
-
-no_exec:
-	return -ENOEXEC;
 }
 
 #define COPY_CHUNK_SIZE (16*PAGE_SIZE)
-- 
2.46.1.824.gd892dcdcdd-goog


