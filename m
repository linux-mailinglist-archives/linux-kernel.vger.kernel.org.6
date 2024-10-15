Return-Path: <linux-kernel+bounces-366919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F76199FC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41521F224F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4809D1E103D;
	Tue, 15 Oct 2024 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z69UuG6m"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC71A1FE0E1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034235; cv=none; b=gBUH19n5kBUucUo8LMfsDIPDiHgJZswpsnD99157ld2YwIxsXEC7b5IRZbkAjbE/ULcwE/sTLU5UB1kHdslCsfXDcq89ftUlvSJeiwavcV1H/itOZKz9GjmpJ6gvVa8pU6XU1NqJKInpAW1kQdnvhVieIVCYF5L3YoTePh8rjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034235; c=relaxed/simple;
	bh=IoH7pzgf0vRG81KSc64PH526sZjBPee8CO7MjeLtc0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nfKg5x2z1v8v7JM2O34jlI6/ne5k6ZlFd91pL5IMdLoOVae8F91fpM1nSj0oAyaVyH8brbKetII9P8tSob2LDjBYYR+Y+ii+HgtKBrmghMsQMSvxB7yC564ZSfLw33KwfUKtCR+OIH0QZkYeviI5NJuWylnG2YWRKzwesStaDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z69UuG6m; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2968b2ab27so467402276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034233; x=1729639033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=719H0QwRK260v2OWeLynQ1hn1vTZVWJ8dOTdLhhDG88=;
        b=Z69UuG6m70uqmnEcK9+h3Z4w+uXySDKybz7231PjCfbLDIlK3Xx7KBr0l94VQzwNVz
         02Q+lIN2oWS4wQZQhqFLt53+q3+Tr2FM4yQERh7+1YlweF+4s48AH7kNfvKs4ga0Vr6T
         E5uwNIRHPQsvTmKrhIwQ0lSGgsRtPVD38yYlSSSpMz2g6xsP86y3egkVJiqXrUahyojb
         U4aNitZ+Bub0t7bmNrZtTGKt3wi+bOvysI2ErQ21QgmGhM0UHsn+MAP9HZUP16EadHnE
         7NIB8JjxA5H614BXxm5EatDEEgt6f74OrhYFYorKfb1VXZ56Df5YlxEEojRWoI1vZoyC
         47Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034233; x=1729639033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=719H0QwRK260v2OWeLynQ1hn1vTZVWJ8dOTdLhhDG88=;
        b=OZoV/ftbulPQxGPer/mbT52WoFqrNDRu5Df8V+pWLw02iwBw9HRRqcivC3PhmUOLq5
         0AfDPAoJy+qX0kRAKRaUnFu/T/8TiO+Vwr/dVAi7Ap0jiglJcHTvXA1Jngn1C/Ix/Hbh
         EpomQKILF+azDNUeUK91v4hhgA2vySFwnNGrqYePnAsihi7LSEXsDcFSp4KTlSiZB1M3
         cpiPAWt1eWhsxtf1MJSEMqMGdH1I+IJX+o51VQtge20njxohDMELycSYbpvfA+eCdV0s
         nTRbRPJlwNoJayc3XdP8jEM+18p5E0p2URDRxcLId6XxRHtzLtqNhCrZ+awQiK8YoS/E
         UwuQ==
X-Gm-Message-State: AOJu0YxXT00VVbfIU3h32CDnRIwPTE3thZr/Ri0LXgXY4oqfSVZFJV/N
	MVBsQoTBkaM2/iHbKJoW8oMtBRCb+vzkRk43YB+3U62GJZDUQ7lSiSAIyPa3vlhf6eMao8VDBKD
	7jQR1cw==
X-Google-Smtp-Source: AGHT+IFVoc/78thbQxUF8y16OnSrdHo3E4CbWYdabzTsfLPOZQvqyCxP9i6oAH1nir8Og6g/hirEotZrgmAw
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:ad42:0:b0:e28:fdd7:bb27 with SMTP id
 3f1490d57ef6-e2977517616mr11736276.3.1729034232869; Tue, 15 Oct 2024 16:17:12
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:41 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-8-mmaurer@google.com>
Subject: [PATCH 07/12] module: Factor out elf_validity_cache_index_sym
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Centralize symbol table detection and property validation.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index b633347d5d98..955746649f37 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2013,6 +2013,39 @@ static int elf_validity_cache_index_mod(struct load_info *info)
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
@@ -2036,10 +2069,8 @@ static int elf_validity_cache_index_mod(struct load_info *info)
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
@@ -2051,34 +2082,21 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
@@ -2099,9 +2117,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	info->index.pcpu = find_pcpusec(info);
 
 	return 0;
-
-no_exec:
-	return -ENOEXEC;
 }
 
 #define COPY_CHUNK_SIZE (16*PAGE_SIZE)
-- 
2.47.0.rc1.288.g06298d1525-goog


