Return-Path: <linux-kernel+bounces-366916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1D99FC39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CDD1F21E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1C91D9675;
	Tue, 15 Oct 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwwwPg+Z"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7051F9EBD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034230; cv=none; b=ejkkWE59PU/hvhLrSBVIJ3N820Mr76RbUYFzcStstj+snYWQ2PO6Vv7BGgX/adGyxOZ/jDpOYNzB2qctzWWiZQwgGE6h7nxDvzRMmGWYJsDPEAm08P8+HQ0AvSyr1NC0m8DM5aSmWQK4gZ0w+Wt1cp5ORD5cPhW12jP6j/UVf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034230; c=relaxed/simple;
	bh=YE/oK9ZOhdsHNUDoCLONYihU16c/izMFQR3EpE6qWgg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ira+WerPYsoj04t6TszuQ2i2p0M4GUdn682qVb3MbxRCNF7daem0SjxziekaCUWa/wKnJolGsquL5y/gvPRJXE/mU1ssPYn6j422EIOz4gspHCQPM+FGJs/QcrWSkowBhmw7/CRubfyIUi/xI04cDnSrYHGDoqk4kiYGxHp+JAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwwwPg+Z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so9004312276.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034227; x=1729639027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpXqqJ7mhE4OTX7mw0ZIHnsdobY/QXMTdFshJ+hNzmc=;
        b=TwwwPg+ZV1lFiBZt4WXhSYohJ4VKuSEvF31Vx47EuMkHa+FwmCcvjhXZFfeTxm4o0c
         EnMvqT3CZDLSPv8vY9g6CP296PScmCdWPOdCuDZg67a07jmbjdI42Eus4UoUJMWs2mcS
         BS50jFuSGHhphKfHguQ+YRphsVkhW6fQSomgCCBqiLpUpuGy4G+PG1smnbvmiR7XS22b
         hgyBo/QLC+1XnVRFjwg8kLQdVR1oxHH2kwer0FOYdzk75fjOp4uUzVZBYYyg3Y58yWvN
         +CTHmvR5YJ1dSWBrpOrAP5GITbOKPBNOvt3sHM+Q6ZKajPIEuHSq7iH81o9/NWHrD3Bp
         WeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034227; x=1729639027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpXqqJ7mhE4OTX7mw0ZIHnsdobY/QXMTdFshJ+hNzmc=;
        b=SgUzqUaGF/1DsvgvniD6e/ANV1SwgiwUPxgaPFtfI3x19tK9t6KqL1XMt5Jl69eqwG
         gDGcrYhaJL6pIfYQUbsXMeAZZgX62tkzEEDABGecX50iIPUTvPt4BMgq4pN+4Z8ngZrh
         iMJbHikJEDCbSnTYF/xbXAGiytW8I5LUKQ6j4fz4b6jlAkLsDxlE0qlMrLtBo6hpqapp
         cAVSjVis6mnC3NyKr4tZCE/MIFnfMW8HE3D1IYDk0JMw6no86lUp9qkYLYlROzhxD0lZ
         qo4GALdOeJuG5Fxgzz2EK/TPeWjvx7whSutpeW2mCl0MM6Wx8jr1ls02XzylvBfEGiDw
         QmOw==
X-Gm-Message-State: AOJu0Yz4uILMEhLfryQ9ZE1BlQLB8bNDMy0VbRE7mFCF7ieoeppNTYib
	1cq/X6mA1z0Dw798b+qFqBi1BDbceKsBJHCc5nQwt+IvsKjgLGZtm7k5AZzZ6EgLVNibr91xsM5
	T1T7bIQ==
X-Google-Smtp-Source: AGHT+IHizGOPKT5xbBjYB4IekU0DU2Mgds5ptzsICNd3lT/qy4QxEafJXfV6FVd+c7tsCcxLBv+gbqraWgah
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:947:0:b0:e29:76b7:ed37 with SMTP id
 3f1490d57ef6-e2978585cc5mr1523276.9.1729034226849; Tue, 15 Oct 2024 16:17:06
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:38 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-5-mmaurer@google.com>
Subject: [PATCH 04/12] module: Factor out elf_validity_cache_secstrings
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Factor out the validation of section names.

There are two behavioral changes:

1. Previously, we did not validate non-SHF_ALLOC sections.
   This may have once been safe, as find_sec skips non-SHF_ALLOC
   sections, but find_any_sec, which will be used to load BTF if that is
   enabled, ignores the SHF_ALLOC flag. Since there's no need to support
   invalid section names, validate all of them, not just SHF_ALLOC
   sections.
2. Section names were validated *after* accessing them for the purposes
   of detecting ".modinfo" and ".gnu.linkonce.this_module". They are now
   checked prior to the access, which could avoid bad accesses with
   malformed modules.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 106 ++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 37 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 467e35f0232a..473f1fb25de2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1822,6 +1822,71 @@ static int elf_validity_cache_sechdrs(struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_secstrings() - Caches section names if valid
+ * @info: Load info to cache section names from. Must have valid sechdrs.
+ *
+ * Specifically checks:
+ *
+ * * Section name table index is inbounds of section headers
+ * * Section name table is not empty
+ * * Section name table is NUL terminated
+ * * All section name offsets are inbounds of the section
+ *
+ * Then updates @info with a &load_info->secstrings pointer if valid.
+ *
+ * Return: %0 if valid, negative error code if validation failed.
+ */
+static int elf_validity_cache_secstrings(struct load_info *info)
+{
+	Elf_Shdr *strhdr, *shdr;
+	char *secstrings;
+	int i;
+
+	/*
+	 * Verify if the section name table index is valid.
+	 */
+	if (info->hdr->e_shstrndx == SHN_UNDEF
+	    || info->hdr->e_shstrndx >= info->hdr->e_shnum) {
+		pr_err("Invalid ELF section name index: %d || e_shstrndx (%d) >= e_shnum (%d)\n",
+		       info->hdr->e_shstrndx, info->hdr->e_shstrndx,
+		       info->hdr->e_shnum);
+		return -ENOEXEC;
+	}
+
+	strhdr = &info->sechdrs[info->hdr->e_shstrndx];
+
+	/*
+	 * The section name table must be NUL-terminated, as required
+	 * by the spec. This makes strcmp and pr_* calls that access
+	 * strings in the section safe.
+	 */
+	secstrings = (void *)info->hdr + strhdr->sh_offset;
+	if (strhdr->sh_size == 0) {
+		pr_err("empty section name table\n");
+		return -ENOEXEC;
+	}
+	if (secstrings[strhdr->sh_size - 1] != '\0') {
+		pr_err("ELF Spec violation: section name table isn't null terminated\n");
+		return -ENOEXEC;
+	}
+
+	for (i = 0; i < info->hdr->e_shnum; i++) {
+		shdr = &info->sechdrs[i];
+		/* SHT_NULL means sh_name has an undefined value */
+		if (shdr->sh_type == SHT_NULL)
+			continue;
+		if (shdr->sh_name >= strhdr->sh_size) {
+			pr_err("Invalid ELF section name in module (section %u type %u)\n",
+			       i, shdr->sh_type);
+			return -ENOEXEC;
+		}
+	}
+
+	info->secstrings = secstrings;
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -1845,7 +1910,7 @@ static int elf_validity_cache_sechdrs(struct load_info *info)
 static int elf_validity_cache_copy(struct load_info *info, int flags)
 {
 	unsigned int i;
-	Elf_Shdr *shdr, *strhdr;
+	Elf_Shdr *shdr;
 	int err;
 	unsigned int num_mod_secs = 0, mod_idx;
 	unsigned int num_info_secs = 0, info_idx;
@@ -1854,34 +1919,9 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	err = elf_validity_cache_sechdrs(info);
 	if (err < 0)
 		return err;
-
-	/*
-	 * Verify if the section name table index is valid.
-	 */
-	if (info->hdr->e_shstrndx == SHN_UNDEF
-	    || info->hdr->e_shstrndx >= info->hdr->e_shnum) {
-		pr_err("Invalid ELF section name index: %d || e_shstrndx (%d) >= e_shnum (%d)\n",
-		       info->hdr->e_shstrndx, info->hdr->e_shstrndx,
-		       info->hdr->e_shnum);
-		goto no_exec;
-	}
-
-	strhdr = &info->sechdrs[info->hdr->e_shstrndx];
-
-	/*
-	 * The section name table must be NUL-terminated, as required
-	 * by the spec. This makes strcmp and pr_* calls that access
-	 * strings in the section safe.
-	 */
-	info->secstrings = (void *)info->hdr + strhdr->sh_offset;
-	if (strhdr->sh_size == 0) {
-		pr_err("empty section name table\n");
-		goto no_exec;
-	}
-	if (info->secstrings[strhdr->sh_size - 1] != '\0') {
-		pr_err("ELF Spec violation: section name table isn't null terminated\n");
-		goto no_exec;
-	}
+	err = elf_validity_cache_secstrings(info);
+	if (err < 0)
+		return err;
 
 	for (i = 1; i < info->hdr->e_shnum; i++) {
 		shdr = &info->sechdrs[i];
@@ -1910,14 +1950,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 				num_info_secs++;
 				info_idx = i;
 			}
-
-			if (shdr->sh_flags & SHF_ALLOC) {
-				if (shdr->sh_name >= strhdr->sh_size) {
-					pr_err("Invalid ELF section name in module (section %u type %u)\n",
-					       i, shdr->sh_type);
-					return -ENOEXEC;
-				}
-			}
 			break;
 		}
 	}
-- 
2.47.0.rc1.288.g06298d1525-goog


