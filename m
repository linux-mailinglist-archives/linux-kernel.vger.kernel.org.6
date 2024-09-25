Return-Path: <linux-kernel+bounces-339744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE69869CD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31126282CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABFF1ABECC;
	Wed, 25 Sep 2024 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dnn4lcx6"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447171A42DD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307584; cv=none; b=HSN3WuZgHUK272pcoinLXJegyVXE7n3R5pcmjXKn+iufiEHXR4YRnABhtk2wIVxw3KVygZJBev2iC3eVcWovU4EMe/trbNjRXsnLJGKOwOppNpOZ2OXxGdkfxgAurLGA4J/gYgvhOSFcWUj4He8zxPqDQ01udeliJnWXFXtVHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307584; c=relaxed/simple;
	bh=uwfaf/NAzm+40ipxYEoBkkFYyfKzhKmnZzjM3YJU8lE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ByBUyeWxdFnPegb5qS/btQner/G+MAu1UTjTbHLYRVXjNPJJWhH/xwAGPQ8HDdA/6X07r+oRqRCbMhPNXMfqt9bPR8jbXLNJ0KSRPddxjfigVhSht4VLVT2Yy630N/gYB6oo09Dc5RH+FRXZt2t8m/eckL96wP9O0ugKa9AwK2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dnn4lcx6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so587547276.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307582; x=1727912382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tc4NXPfplG38lAGlz62WMnJTBJMM1sboCG51BTx1YyI=;
        b=Dnn4lcx6ETC3b56/fMVL5Sowje5BnLypRNCI6y7V/UppV+ykNC/QI9yXrPLZa4MZDt
         IiHnuatUNziMF/+SokFMxI0gK60XEbhHCBIUJk6S/fo1t/1cq++ylzYyVRuLE9Nh1qfU
         v2AibX5noO2NCGTeCsNF7VFL8XgWV4/+kWp8VSXbVFom43FlVRqHkSHr9uKSyEh5DFL5
         y2dhTc823caiGsStgcaR3298Pw1aegvPXvVBHk+4CYlTHMqbdoyv1fwD3aIFipfMDUcU
         5o31nY4/exqQ5P3Bpj7AO0SDYu6DhamliBw7OMpApYnlI43yFEggoO8VVNhZP9eWf7kJ
         9XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307582; x=1727912382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tc4NXPfplG38lAGlz62WMnJTBJMM1sboCG51BTx1YyI=;
        b=OvFMOboCvh9dQrMI9ObUvI9JUFw3+QpSD0SjgMMG0OTXFrPzxwTCeJuZGeOIhkE67e
         C+5daoxLzYrFx3ElWWNazjWIdKn1HA5+yPsxDc4osXV+YGCMCTDt0lZ6O1R903aJ121G
         1N45Kg9kNZQxBVI5Xeg4lQPQPFUfzdbMeexGfbg63kiok76ClWNv6eLukT0U4xWvRNGQ
         //N9fSekdSblVHIMPlwJNqazFgrB5pKVnexhaOXJGO+Jj8t3nEfhSTi68SC+v7f9pPVw
         4XRjYmjo6m1ppA1l06uJ3LlLFDoykYTk7xFRM+TmN9Mr5519ld80ogqsLzn46fz7A5o1
         D24Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDLd5nM5R8LdNIBQywleEddIsnPzyc/Y+O6/756i2MaHpExWgh+L9YaEUJOFBeoqTJQwPg4pjdbUulpP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQfyflzVrXi/E8MbT9j/sH920Qp/yUBsBlzH4YMTIZqt1Sz+z
	iQEGTwXtLzqms158K+BnDWXsFGbX69NaGUzVeiqJJBMNxz1sjGl7s0DGwU7mqh2wgaIqFEYyhCs
	iobLL6g==
X-Google-Smtp-Source: AGHT+IF+swNEdiAvpBogXsgKrBiSvXnXm1t/O+Acxf832i2L6CrfB3YUi3r7S2mXXta4Ea8IRO3aupfjGYBp
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:1367:b0:e1a:22d5:d9eb with SMTP
 id 3f1490d57ef6-e24d716247fmr3341276.1.1727307582039; Wed, 25 Sep 2024
 16:39:42 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:24 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-10-mmaurer@google.com>
Subject: [PATCH v5 09/16] module: Group section index calculations together
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

Group all the index detection together to make the parent function
easier to read.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 68 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 43140475aac0..e04a228c694a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2039,6 +2039,56 @@ static int elf_validity_cache_index_str(struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_index() - Resolve, validate, cache section indices
+ * @info:  Load info to read from and update.
+ *         &load_info->sechdrs and &load_info->secstrings must be populated.
+ * @flags: Load flags, relevant to suppress version loading, see
+ *         uapi/linux/module.h
+ *
+ * Populates &load_info->index, validating as it goes.
+ * See child functions for per-field validation:
+ *
+ * * elf_validity_cache_index_info()
+ * * elf_validity_cache_index_mod()
+ * * elf_validity_cache_index_sym()
+ * * elf_validity_cache_index_str()
+ *
+ * If versioning is not suppressed via flags, load the version index from
+ * a section called "__versions" with no validation.
+ *
+ * If CONFIG_SMP is enabled, load the percpu section by name with no
+ * validation.
+ *
+ * Return: 0 on success, negative error code if an index failed validation.
+ */
+static int elf_validity_cache_index(struct load_info *info, int flags)
+{
+	int err;
+
+	err = elf_validity_cache_index_info(info);
+	if (err < 0)
+		return err;
+	err = elf_validity_cache_index_mod(info);
+	if (err < 0)
+		return err;
+	err = elf_validity_cache_index_sym(info);
+	if (err < 0)
+		return err;
+	err = elf_validity_cache_index_str(info);
+	if (err < 0)
+		return err;
+
+	if (flags & MODULE_INIT_IGNORE_MODVERSIONS)
+		info->index.vers = 0; /* Pretend no __versions section! */
+	else
+		info->index.vers = find_sec(info, "__versions");
+
+	info->index.pcpu = find_pcpusec(info);
+
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -2069,16 +2119,7 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	err = elf_validity_cache_secstrings(info);
 	if (err < 0)
 		return err;
-	err = elf_validity_cache_index_info(info);
-	if (err < 0)
-		return err;
-	err = elf_validity_cache_index_mod(info);
-	if (err < 0)
-		return err;
-	err = elf_validity_cache_index_sym(info);
-	if (err < 0)
-		return err;
-	err = elf_validity_cache_index_str(info);
+	err = elf_validity_cache_index(info, flags);
 	if (err < 0)
 		return err;
 
@@ -2095,13 +2136,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	if (!info->name)
 		info->name = info->mod->name;
 
-	if (flags & MODULE_INIT_IGNORE_MODVERSIONS)
-		info->index.vers = 0; /* Pretend no __versions section! */
-	else
-		info->index.vers = find_sec(info, "__versions");
-
-	info->index.pcpu = find_pcpusec(info);
-
 	return 0;
 }
 
-- 
2.46.1.824.gd892dcdcdd-goog


