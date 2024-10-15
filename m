Return-Path: <linux-kernel+bounces-366917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A69D699FC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7852859B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA69A1FDF9D;
	Tue, 15 Oct 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDUpd6ZD"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82421FC7E3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034231; cv=none; b=mzWPLBXenJo2AIJHlAhtBU5mgpgXy6sQBwfxoZC22GQrUXEbHH1pa1ssZMvZX0HvGGN+tvIsMQRd5+bcy0j7CSfq3ZtBn2EPoZ4t2FKhHrfWuhpAGxZQhjSXOrCVPPh9ZiMQI6envhBQVkBYGQfqxt0RfIWkYQ+ZREuetJDJCPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034231; c=relaxed/simple;
	bh=keltVl7vYU9EPlcQRfVtCcny2Z6cQUk1MMTzAOK5SA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dpKxv11BoNABFrpvYzVNf5QgEc6tzYHtw90ZbFNnznkGNDt3X0uKKoNXf7VikCZZKd51/aSqzRGdxY4vjS+Qjog688w3/+0f1mPtUSpOB7UiIckQDC4nWfC0Byh896SVtRAGEIte7OQs3HanQ3d3K6P7pekypJn4H15MGFiNjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDUpd6ZD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e292dbfd834so5696761276.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034229; x=1729639029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQYiDylULU1Fc0U45JVmZV1jTxB4Hv3WLTHptCyQE2g=;
        b=MDUpd6ZDW/46H5uih+sC5p0hbH+2TgiHDd5ZjVFgDcb2zdy9YVya/9UAGy4BmVz8hu
         7hjbr/8LObxT2x9Mok7YHG9ad6nuauL2tU83okr6JdyuWjCOLsrYgAwg5oKpqtZ2DMDs
         4LwiX5Pln9KZLIuEzdCkL3bjGymYlT5BzKBtUGO2RelAlJt8x1cX/ONLa6+6EFV5AknT
         zP6dbSwovGRYvqLpazrx5xJqVd2+lVuQP1BnZYtULu22VZaOHA01DOvBBNK2WyBJmDaJ
         897CoHTnr90hTi5ZhUjALuzFQQU8fdPb77wYNfzrsB3JSUsSm8fb0fq+b+hDB7ioNRKs
         geBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034229; x=1729639029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQYiDylULU1Fc0U45JVmZV1jTxB4Hv3WLTHptCyQE2g=;
        b=CWZHMnILQ4OnLnCd9YcYwY2Bke5rg4Z1wd7VvUbHdTx2UVXJpRl93njYu88NFl0P2d
         I1KSGa4dk5tzdBly78yNOLDrCFOo8xGbXk9hqOxeahCR6c8ZTAz83rGzWCjqhSMDSMUk
         FIIZAvR20YzEfto6+C257HsmQ/Eru7YBZI6xMknMTH1N3awAxzGS+XXgwLq++B6FIvct
         QTbWZTWoY8wj1IHagzi6nBDD/zaFXKXaCMCc+9t6piNCHQ91FaXTJTauuDoX0dzyGHDu
         D9BrTMV3/GCw8DC2+d3c6FQgaazWwXsUi+C2O/C3jjNBQA/KknXO1o6oUVCeP6tzaFeS
         Y0nA==
X-Gm-Message-State: AOJu0YyLnm7T/1sDCrgOcJrdRXQD0pqxIvfi3tUwx8EuM7nY3jbWMEva
	9bNJQaCXBlYgF7espAsLS1UvYVUtuxgorqV30tY1nK1xGEqB4Oc/2IHKtfIl4vSYk2xckONksUw
	DUSAGZg==
X-Google-Smtp-Source: AGHT+IESRWGhdP/DVUgoBjA23GTWDfK0rZz9759983ENQNbLXCK4xnlPImOdO8gU18zMbWXRCEMfPIx3Zu6o
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:68d4:0:b0:e28:f454:7de5 with SMTP id
 3f1490d57ef6-e297855147cmr1515276.6.1729034228858; Tue, 15 Oct 2024 16:17:08
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:39 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-6-mmaurer@google.com>
Subject: [PATCH 05/12] module: Factor out elf_validity_cache_index_info
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Centralize .modinfo detection and property validation.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 82 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 14 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 473f1fb25de2..6747cbc774b0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -195,6 +195,38 @@ static unsigned int find_sec(const struct load_info *info, const char *name)
 	return 0;
 }
 
+/**
+ * find_any_unique_sec() - Find a unique section index by name
+ * @info: Load info for the module to scan
+ * @name: Name of the section we're looking for
+ *
+ * Locates a unique section by name. Ignores SHF_ALLOC.
+ *
+ * Return: Section index if found uniquely, zero if absent, negative count
+ *         of total instances if multiple were found.
+ */
+static int find_any_unique_sec(const struct load_info *info, const char *name)
+{
+	unsigned int idx;
+	unsigned int count = 0;
+	int i;
+
+	for (i = 1; i < info->hdr->e_shnum; i++) {
+		if (strcmp(info->secstrings + info->sechdrs[i].sh_name,
+			   name) == 0) {
+			count++;
+			idx = i;
+		}
+	}
+	if (count == 1) {
+		return idx;
+	} else if (count == 0) {
+		return 0;
+	} else {
+		return -count;
+	}
+}
+
 /* Find a module section, or NULL. */
 static void *section_addr(const struct load_info *info, const char *name)
 {
@@ -1887,6 +1919,39 @@ static int elf_validity_cache_secstrings(struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_index_info() - Validate and cache modinfo section
+ * @info: Load info to populate the modinfo index on.
+ *        Must have &load_info->sechdrs and &load_info->secstrings populated
+ *
+ * Checks that if there is a .modinfo section, it is unique.
+ * Then, it caches its index in &load_info->index.info.
+ * Finally, it tries to populate the name to improve error messages.
+ *
+ * Return: %0 if valid, %-ENOEXEC if multiple modinfo sections were found.
+ */
+static int elf_validity_cache_index_info(struct load_info *info)
+{
+	int info_idx;
+
+	info_idx = find_any_unique_sec(info, ".modinfo");
+
+	if (info_idx == 0)
+		/* Early return, no .modinfo */
+		return 0;
+
+	if (info_idx < 0) {
+		pr_err("Only one .modinfo section must exist.\n");
+		return -ENOEXEC;
+	}
+
+	info->index.info = info_idx;
+	/* Try to find a name early so we can log errors with a module name */
+	info->name = get_modinfo(info, "name");
+
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -1913,13 +1978,15 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	Elf_Shdr *shdr;
 	int err;
 	unsigned int num_mod_secs = 0, mod_idx;
-	unsigned int num_info_secs = 0, info_idx;
 	unsigned int num_sym_secs = 0, sym_idx;
 
 	err = elf_validity_cache_sechdrs(info);
 	if (err < 0)
 		return err;
 	err = elf_validity_cache_secstrings(info);
+	if (err < 0)
+		return err;
+	err = elf_validity_cache_index_info(info);
 	if (err < 0)
 		return err;
 
@@ -1945,24 +2012,11 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 				   ".gnu.linkonce.this_module") == 0) {
 				num_mod_secs++;
 				mod_idx = i;
-			} else if (strcmp(info->secstrings + shdr->sh_name,
-				   ".modinfo") == 0) {
-				num_info_secs++;
-				info_idx = i;
 			}
 			break;
 		}
 	}
 
-	if (num_info_secs > 1) {
-		pr_err("Only one .modinfo section must exist.\n");
-		goto no_exec;
-	} else if (num_info_secs == 1) {
-		/* Try to find a name early so we can log errors with a module name */
-		info->index.info = info_idx;
-		info->name = get_modinfo(info, "name");
-	}
-
 	if (num_sym_secs != 1) {
 		pr_warn("%s: module has no symbols (stripped?)\n",
 			info->name ?: "(missing .modinfo section or name field)");
-- 
2.47.0.rc1.288.g06298d1525-goog


