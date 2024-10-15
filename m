Return-Path: <linux-kernel+bounces-366914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9DF99FC37
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB75B245E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C121FAF04;
	Tue, 15 Oct 2024 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CfVslK/m"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A51CACD9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034227; cv=none; b=YT15f89ObFNQ/jgI4E1BSF/CeTclUNCBZD+61F3dGRjngiKY0gJHHhs1UknQ3T468jqfrEnBCfBknPdzQBcjNJ2CGkb58woFcoBZMC0PQTpahAVO3d1EXnVgfVsBdySbgPP/5fLMBpq6L1Z04XtYe08y5TniFObIOaordTLkTuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034227; c=relaxed/simple;
	bh=Q/ebP4VppKXgX75HHkGyapl6+59q2K1k/6cBCCOTXVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YFsjHxM5LlYZcTVxlvxvai6ZKyxi0cPTPzN6UXSDvkqS9I4Skdu7wara6nPtVnnAJ6r3Z2BQf3lz9WnkGBMaOJViO7ZepMOjw1kPgJj2Nwqc+4J+9Fu4NoNsUbuDb8p+C6lqZZKKGumtj2DmjImTLB0ZTa/e1hGiqh0Ff2xnTFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CfVslK/m; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2928d9e615so6644470276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034225; x=1729639025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9C2Ei02TD++bK2BpkVHJvqSOFvsQEfujDFHeRhGRWA=;
        b=CfVslK/mQVPkVgi4qJvoUZuABqvmzYgpJ6kTRKUmqxe8S7zCiSW7iob7vGS+xY4cAT
         SRP68ozJtRNQr795X4nh2LyqiTysn4ptun2+nwfAncPcdaR8r0UNBVdX1/m0KiaTBSQk
         WNwkJ/frh8rDOPyLEos1bqxVoRBth+TfLH9RZQ8TAYmn7Kqzngd5kSTiU15EX6Ix1l/O
         dOhtXgts75yCjRl+hehBodMZ7JaWZCp49lRh2rjKYnYgEnVNwxGwiwIqIhgdsg0n7ZEM
         nH1FXWMknZZ+doIM3pAy5lCDa/DlMp1KSbzDwIVGFM06fxF2uh+VHQcc9OnpOmRh/ytC
         mzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034225; x=1729639025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9C2Ei02TD++bK2BpkVHJvqSOFvsQEfujDFHeRhGRWA=;
        b=Q0TvyWNCDGBBPY7r7GWJyV8UPrmquqsFTrtUO3JpNCHulU75d+YY0m5RU3O3+oREqA
         K04V6hotJCq6n8Up92BYEgJSfro2/4EpY38SjQ6wgP4G6N3TSfVbf4AYMEE2nazfnPoX
         tuP5qW4gUT58hnyWgr64ThYScCwYsDOfMFkoUns2a8Emq8wEgMhmvpk+eRC1hYPEmN8x
         3E8YyGhnJQWP/J2e+kKVKGvds++zW7pAmRiGrXrIXqrf3cOr83Cd1Rjb2p/bKCMu5iH8
         sXQeghb1rBkJogaLpmI0woesjhjXvW9m2IvMunHRwtOxyYOguqbde5c6zNzQdIhTLw/S
         pPlg==
X-Gm-Message-State: AOJu0YywlLxourgA5VNljdPW7nPikARVE0M36C1rtdpESY1h2cGynNxW
	uEaSLPxcWHGk+tgw5DnC84tCLOjElYYjOoqO4WD7JeSb1AsQHc3B3Jc/t56tJbpz8V0mj4OnQQe
	QnhonWg==
X-Google-Smtp-Source: AGHT+IF9/RrejyXjamOHmES0fO9LFDxPPSqw0EHrizmRCN81klIy8hyZiM00NmuWFywfdGDutrXWewNuQlb5
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:68d4:0:b0:e29:6fd5:70ec with SMTP id
 3f1490d57ef6-e2978558d8dmr2050276.6.1729034224721; Tue, 15 Oct 2024 16:17:04
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:37 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-4-mmaurer@google.com>
Subject: [PATCH 03/12] module: Factor out elf_validity_cache_sechdrs
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Factor out and document the validation of section headers.

Because we now validate all section offsets and lengths before accessing
them, we can remove the ad-hoc checks.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 125 ++++++++++++++++++++++++++++---------------
 1 file changed, 82 insertions(+), 43 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c836354928f0..467e35f0232a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1741,6 +1741,87 @@ static int elf_validity_ehdr(const struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_sechdrs() - Cache section headers if valid
+ * @info: Load info to compute section headers from
+ *
+ * Checks:
+ *
+ * * ELF header is valid (see elf_validity_ehdr())
+ * * Section headers are the size we expect
+ * * Section array fits in the user provided data
+ * * Section index 0 is NULL
+ * * Section contents are inbounds
+ *
+ * Then updates @info with a &load_info->sechdrs pointer if valid.
+ *
+ * Return: %0 if valid, negative error code if validation failed.
+ */
+static int elf_validity_cache_sechdrs(struct load_info *info)
+{
+	Elf_Shdr *sechdrs;
+	Elf_Shdr *shdr;
+	int i;
+	int err;
+
+	err = elf_validity_ehdr(info);
+	if (err < 0)
+		return err;
+
+	if (info->hdr->e_shentsize != sizeof(Elf_Shdr)) {
+		pr_err("Invalid ELF section header size\n");
+		return -ENOEXEC;
+	}
+
+	/*
+	 * e_shnum is 16 bits, and sizeof(Elf_Shdr) is
+	 * known and small. So e_shnum * sizeof(Elf_Shdr)
+	 * will not overflow unsigned long on any platform.
+	 */
+	if (info->hdr->e_shoff >= info->len
+	    || (info->hdr->e_shnum * sizeof(Elf_Shdr) >
+		info->len - info->hdr->e_shoff)) {
+		pr_err("Invalid ELF section header overflow\n");
+		return -ENOEXEC;
+	}
+
+	sechdrs = (void *)info->hdr + info->hdr->e_shoff;
+
+	/*
+	 * The code assumes that section 0 has a length of zero and
+	 * an addr of zero, so check for it.
+	 */
+	if (sechdrs[0].sh_type != SHT_NULL
+	    || sechdrs[0].sh_size != 0
+	    || sechdrs[0].sh_addr != 0) {
+		pr_err("ELF Spec violation: section 0 type(%d)!=SH_NULL or non-zero len or addr\n",
+		       sechdrs[0].sh_type);
+		return -ENOEXEC;
+	}
+
+	/* Validate contents are inbounds */
+	for (i = 1; i < info->hdr->e_shnum; i++) {
+		shdr = &sechdrs[i];
+		switch (shdr->sh_type) {
+		case SHT_NULL:
+		case SHT_NOBITS:
+			/* No contents, offset/size don't mean anything */
+			continue;
+		default:
+			err = validate_section_offset(info, shdr);
+			if (err < 0) {
+				pr_err("Invalid ELF section in module (section %u type %u)\n",
+				       i, shdr->sh_type);
+				return err;
+			}
+		}
+	}
+
+	info->sechdrs = sechdrs;
+
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -1770,29 +1851,10 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	unsigned int num_info_secs = 0, info_idx;
 	unsigned int num_sym_secs = 0, sym_idx;
 
-	err = elf_validity_ehdr(info);
+	err = elf_validity_cache_sechdrs(info);
 	if (err < 0)
 		return err;
 
-	if (info->hdr->e_shentsize != sizeof(Elf_Shdr)) {
-		pr_err("Invalid ELF section header size\n");
-		goto no_exec;
-	}
-
-	/*
-	 * e_shnum is 16 bits, and sizeof(Elf_Shdr) is
-	 * known and small. So e_shnum * sizeof(Elf_Shdr)
-	 * will not overflow unsigned long on any platform.
-	 */
-	if (info->hdr->e_shoff >= info->len
-	    || (info->hdr->e_shnum * sizeof(Elf_Shdr) >
-		info->len - info->hdr->e_shoff)) {
-		pr_err("Invalid ELF section header overflow\n");
-		goto no_exec;
-	}
-
-	info->sechdrs = (void *)info->hdr + info->hdr->e_shoff;
-
 	/*
 	 * Verify if the section name table index is valid.
 	 */
@@ -1805,11 +1867,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	}
 
 	strhdr = &info->sechdrs[info->hdr->e_shstrndx];
-	err = validate_section_offset(info, strhdr);
-	if (err < 0) {
-		pr_err("Invalid ELF section hdr(type %u)\n", strhdr->sh_type);
-		return err;
-	}
 
 	/*
 	 * The section name table must be NUL-terminated, as required
@@ -1826,18 +1883,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 		goto no_exec;
 	}
 
-	/*
-	 * The code assumes that section 0 has a length of zero and
-	 * an addr of zero, so check for it.
-	 */
-	if (info->sechdrs[0].sh_type != SHT_NULL
-	    || info->sechdrs[0].sh_size != 0
-	    || info->sechdrs[0].sh_addr != 0) {
-		pr_err("ELF Spec violation: section 0 type(%d)!=SH_NULL or non-zero len or addr\n",
-		       info->sechdrs[0].sh_type);
-		goto no_exec;
-	}
-
 	for (i = 1; i < info->hdr->e_shnum; i++) {
 		shdr = &info->sechdrs[i];
 		switch (shdr->sh_type) {
@@ -1856,12 +1901,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 			sym_idx = i;
 			fallthrough;
 		default:
-			err = validate_section_offset(info, shdr);
-			if (err < 0) {
-				pr_err("Invalid ELF section in module (section %u type %u)\n",
-					i, shdr->sh_type);
-				return err;
-			}
 			if (strcmp(info->secstrings + shdr->sh_name,
 				   ".gnu.linkonce.this_module") == 0) {
 				num_mod_secs++;
-- 
2.47.0.rc1.288.g06298d1525-goog


