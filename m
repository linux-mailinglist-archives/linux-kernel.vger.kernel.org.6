Return-Path: <linux-kernel+bounces-339742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91519869C5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FAE28371D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBB91AC88E;
	Wed, 25 Sep 2024 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wb4Kc+vl"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D31ABECC
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307581; cv=none; b=jmfbtfBTam306xBV8qa2QmYdvJYNnCuu04t5sCplPZnKFHykbNwzDQ0lXjr2mq1/m7ZBHA+dhmIXukwf6EvHlhSiE4nSEdt9VTsXartJtN6cB6u/KuBSCuDoga5R1MVnI2l/4OqehkMUH8B98kAgduywIyBVRqvLXJwz7oxO8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307581; c=relaxed/simple;
	bh=hPcayIG4Zzk7TfnQCe5VB/OkeMCLVNaFCb22SLuD7xA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULUdUQwdQKnzAVBntNKOTrrUHl4jcYNoIahYaYkJhNrZcuG0jlRiWxF5iBgKdddNTTbjss2v2ISLT6YxCBfF/tse4rCURkY3R1gjum1poXDdACpX8+RiVcXFxHH13rPJ/a2MXyQ/p8NF/d3mror81PQ2cwRyyH8aEdFXQsgoyoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wb4Kc+vl; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e249fafe1ebso732986276.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307578; x=1727912378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0kXAOzmEEQHXzTmLkL/vEUOj2egGiISa865No2odHA=;
        b=wb4Kc+vlm9vspCrEGu31uSdmGCFV4N+qq3ZdgtPNuVg7PQ3AnM/tZOhfz3qmMsSGKR
         EJ3oKVJaibX0jMt6Z+MELN82Fl4xPXd8nCqPcMLDXQydk4pva9Aw2Atp1OS9iLAiVwbk
         /FpGLP8QjK2w8po1aocYEVWGjEc/Z9QISVlarljpEcPa5uNqf7A71TvKtxFc0MTg7clF
         5kscch70KYzMTVSw25al7YR2T4jsybqoH2sWWp5pBzSEGjSAHdpvqKthwvZ5YcGadoWF
         s4eLU3/RbMVaF8/7D3L74rtn815TeO0ECl5FTnNu9mxm2o2dt5uKd1HOZkheUoD/Ccmi
         0uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307578; x=1727912378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0kXAOzmEEQHXzTmLkL/vEUOj2egGiISa865No2odHA=;
        b=LYI/WAtTj6duC4U0vbLwPyoZWVyl1PDfkBFIyDozxFOos3FzPgSPzmL8cmiS46kAsW
         o5YZUFiprXS0CAE8QvNpZoeAM9qdvJGoqd61TR724NoE/Xb2LyjIBYpN6DcfIVfGUGSG
         8c5b9jxTrDqMiEkJYvJm5qGfywiDIqRfEGaGeFeiymU0OaKJp3wavjh/PWv27TcQukqO
         i8LohY8lw0i0rdXIvmbVeYfG6v5Q1GcM/BYJVZotYSB18JTwUP0MDy5MY8RVX2mGpUVd
         fhO6WNMlnZhfc79csp6u3KzchZrteNUo5TEPfIGMfIGOmpj2fxL2HrFL4hgpVO5jM0hC
         Xfqw==
X-Forwarded-Encrypted: i=1; AJvYcCVtIQmj2OZNfxBx0iHo0KsBK+aDgb5CW95RDAjodxZWM1WuERcAxhZiTa0DAKoBpSA26KvA4rnIZiPSUJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySHXB7A0YNuq/fgo9ZVcK1W0RRWBksd2ZnzvdAWC/1UprogX6k
	mrn4u5WEiKm2rSRjUMRIWzx3S/Di1f7yRkuuk5iAV/ru3LrfKrRMdYZHw6j0qysX/Wol4MITZfT
	tfg5Nhw==
X-Google-Smtp-Source: AGHT+IFZUoBFWfBOtauI+q+UpHX4EaqZHRhVqScDHU9VRfOA/W5QmMinhHWYwHFcLrUwulCaskY1L43rYGa0
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a5b:841:0:b0:e20:25f5:a889 with SMTP id
 3f1490d57ef6-e24d80d4612mr3980276.5.1727307577820; Wed, 25 Sep 2024 16:39:37
 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:22 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-8-mmaurer@google.com>
Subject: [PATCH v5 07/16] module: Factor out elf_validity_cache_index_sym
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


