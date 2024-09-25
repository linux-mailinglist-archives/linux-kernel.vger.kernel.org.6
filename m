Return-Path: <linux-kernel+bounces-339740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140289869BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806881F26E34
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7C1AB6CF;
	Wed, 25 Sep 2024 23:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5Z5tSey"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBAF1A76BD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307575; cv=none; b=YCFGbM4hl/y/CSq0ja3K1L3S106cAqnEU3E1P+Bd44dyisUD9TmbGC6dpF/FeNkpivSMj3CkHclChPN8dN7OKtKw5Ixf/Gkt+m1BDkuKbpbgkRMSQ6S7cCRsMO3z/hNuXGuyF4aFN5OVdT74L3IMonBe6YMX3AUfe2LTSz369Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307575; c=relaxed/simple;
	bh=oOvwo7YW3AUcfbqrf+A9OVLdTk2yYzaOPGripVgZWf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V7TcAjdQhc2XhH/xRhbGzqhB7bC2jI+J/1qXLPYGjdbYB/l9gXKC3nbOJ5hIBW8i5G2iNesgnnCps+uRXyKSz1C+8lGBhkeeeIZed3q7KPmwN+rRFZ4x1zQsrjoTEXuyjdIzKFXHNpsZJgACR9EL0pwK/WSLbC1TsHgsOW+qj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m5Z5tSey; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e20993a03dso7454677b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307573; x=1727912373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKJyYEevVucNlB3/71Ku7Qx+VTTwNT+eh7LmoeHsrUQ=;
        b=m5Z5tSeyRlsxLy1ersJE+UGxQCyLHbFGDz8D/MbyB/kQa7EYcqRvp/f8uPQukKcrCt
         EfJ1Aezcx3fQoA6m0su+FwrkOEJYSSEJ9sjwyh81XN3Y497rH+FbhbDjzOEl5RRxJqcp
         VlypXpgjrZZc7R8C480eVLG4oXVSYm2L+1bi4g0AX+N+4vnBqlNY73Op1ZsJ7ljiUy9q
         ixYagzg4Gdj+FamIYtiuTGhEiXptWpg5DFWUiQc1qygfowqRpMKtS8WnGuyNST4lx3nZ
         oxHSLIjZkt0GL4tiNEHelvV57QkjUxh1raAHGuZMGQxxKpuRoMq3uVZFs+7SK92eC2Vp
         /qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307573; x=1727912373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKJyYEevVucNlB3/71Ku7Qx+VTTwNT+eh7LmoeHsrUQ=;
        b=SaVSe86fjQ2fjf5uAT0zqgxYuLDXfCNcn17R8uRr2B8PfZkhPypHW6vw1eB+Uj1V+9
         rzpQmGepFWUhBi1Itwfg8YwVdvphMQe+SQyHqlZveCXX5NvvDurqo9B/CjgoxRrQOyB7
         /Q+hpzyru2MeBHxcU/2L7HnhG2w0KkUwxxZc27RFaGpmZCA6c/KB/UYQ3mKwfXYrY9Jo
         XUHmBLq68rqBS9dfuRrg5kSREmctlZPa5zq/+1vy6cfsz7c3kc0hHGb+JLYrTMJmK9cg
         8WSte/PPGsAohSn1qKCKSl0cx7e/stRq0/WCi2xIDNC+g3KRiDJftgPj8F2bw3GwrYrV
         zr1w==
X-Forwarded-Encrypted: i=1; AJvYcCXci5OQKxshDva4GHevEu5AEmSMAxh97MPvhItoskLmwb6KgF7CHvy+OHavVL6eRjFh6Upd08qxfTDz0Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlRrDqsIbH6IQP6u3T+vP+HV7P5sUrhWONNiM2ahl9o0RRFz+
	owprBLKUM2H/H6e30GuJZi1zT7VRjrqBEjGY2kURIij207mp/F94Yx6nnBK+6UWd66/jmU3YLXW
	WiUN+WA==
X-Google-Smtp-Source: AGHT+IGx+nve+AoQTJhC0039Mrm5L1Mmot8nzzFqz6EcNfCPXpgrANZ2tGjsmltzJQkDur51XUIFhuHCnZ0h
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:780e:0:b0:e16:6e0a:bb0b with SMTP id
 3f1490d57ef6-e24d44cad51mr4787276.0.1727307572609; Wed, 25 Sep 2024 16:39:32
 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:20 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-6-mmaurer@google.com>
Subject: [PATCH v5 05/16] module: Factor out elf_validity_cache_index_info
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

Centralize .modinfo detection and property validation.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 82 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 14 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6a9159afca02..511d645ac577 100644
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
@@ -1854,6 +1886,39 @@ static int elf_validity_cache_secstrings(struct load_info *info)
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
@@ -1880,13 +1945,15 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
 
@@ -1912,24 +1979,11 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
2.46.1.824.gd892dcdcdd-goog


