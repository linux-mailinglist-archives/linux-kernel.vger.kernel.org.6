Return-Path: <linux-kernel+bounces-366921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778FB99FC43
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D251F25D07
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B3A1FF04D;
	Tue, 15 Oct 2024 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qR0cowVi"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3F1FF026
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034239; cv=none; b=KjUP4gKKnrjYivmVaJfEeLaXfOlLBTB3SKGOYTQ3drBbH45hBf2Dng2fH9C6dGDjO8Ne3hxb85XPK2rHvO8DyjtS4Sh7j6pnkgdwXAXACHsfxq0AZXQzHBVXUHxH1TjpSOmTp0wv3KrNAB0rF1ATMWbATn2WiDLmzRaRm+PUDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034239; c=relaxed/simple;
	bh=hjDQXeiUX95J1QXpCz5oPWaRB52qH/la5DEMemSKDsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kjSiiQ75CEOtV7STFT2fJpoEBgqoBEhhBZN6VuGZ/d+OnRDYTXG4ftYQVL+HgfhNOg2dikVLnAyL+ITeYLxyOGXNgI1tMRXsnnfMjVUHPPJuLWCsn0TDQgz7SKBbGzydmOwavUE36iOxggn+K30r5pE8UBoRnJitg531ITs9N/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qR0cowVi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fc60660dso7634575276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034237; x=1729639037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uwZjjsLk0MIG36tHEbuTh0oExV8i1gjaEov3sAmvfo=;
        b=qR0cowVijVl+7tBWjBpajUVhFgopifQqX9m1kqLycTJqCQyQawkaMg0jtnctU9ty1Z
         HcOI8dcLZEePBlV49ah2rKzypqySz8pNB7f+N8GKsccnR34YEhSyts9ULrPG3TluY9FZ
         fJVcRm3NPI4/dDMfFO0nK2azMBpbLuhwQZ0PiKASjPWHkzHSXn04GMdHpP49aCrD3One
         l5y7NBnpXQqtAcTxTXM2pNNzRQZy8t8+sFLjWARoTWHpjOusiUaCZ+0IBMGc712/dTGx
         zbIW7buXcfWBVgkC0Xwb43F6tGiZcfjd0nyeQcUE6YW5M+zFdg04X5ngd8rKTDcIZnrg
         s5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034237; x=1729639037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uwZjjsLk0MIG36tHEbuTh0oExV8i1gjaEov3sAmvfo=;
        b=UBlSaER9+5ZPM2hB9e65JD4QVj5NLOQfYcn7bqxJMUz/9LMrtwOyORlM2FlzlijSe0
         HxAjGmBpT8HYDtgGlmC4EX/rZ6M+WJwZQgC8I0AUCDe2y3PviEZjOp97mjVtlzV6KVWJ
         LOSn4FRG94rek0B7covShaLH/igZUzt2hD2mfSo9f9gqzvu9KSYVNHfM51ieIyxkIBCF
         25JAIB9bgD4qn+OK6IbhCKm3ph6BIbd7nUmANaEp9tAEd7G/XDrJWD0Pxis5ghYqPzX9
         CJOfs7NUQCOgKnrvazrt+01WwpiH3ZFiBbbq9FOweWid30qR9nSPNL6aeZgTV7+Mz+80
         t6xg==
X-Gm-Message-State: AOJu0Yx0yRQ+S+6NFhLDBsdOX7DmxtMw8kuvbG85j6I1ETFlsPwl/ag4
	W5l13FFQf77aG3pm11VfDptK5IUs6TXaHjV2I/X5GwRBfpathsEaHL8JDPi5gzLmsRidLJHuuSZ
	v2wd8+g==
X-Google-Smtp-Source: AGHT+IFgckrRNMXFF24rFhgTtnbQoAnZBnt81LEcyNJagNruc4+MU3SMi75f9nEJkDNi/O4B6WflF8vc2KSQ
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:112:b0:e29:7587:66db with SMTP id
 3f1490d57ef6-e29782b20edmr2157276.2.1729034236773; Tue, 15 Oct 2024 16:17:16
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:43 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-10-mmaurer@google.com>
Subject: [PATCH 09/12] module: Group section index calculations together
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Group all the index detection together to make the parent function
easier to read.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 68 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a6bed293d97b..f352c73b6f40 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2072,6 +2072,56 @@ static int elf_validity_cache_index_str(struct load_info *info)
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
@@ -2102,16 +2152,7 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
 
@@ -2128,13 +2169,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
2.47.0.rc1.288.g06298d1525-goog


