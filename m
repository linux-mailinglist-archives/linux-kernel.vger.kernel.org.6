Return-Path: <linux-kernel+bounces-339743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B89869C9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A382B23C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487A11AC8B2;
	Wed, 25 Sep 2024 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ace5t6Cv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAECF1AC449
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307582; cv=none; b=NHILiHg/IPnjtY5YAvkrHoOEcu+5SC6MHm8LIroXYKwvN4BJZbf5TRaMqWXjB2vXTYP+73o1w5jTBFXvEidt6io8raf0cjfLAG+gia/UqENPUTqFmfILNexLg2wnfz57B/DE5u7KXiWTbvIhGLiSo+fb1EdYmRJkO97xtCRjIvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307582; c=relaxed/simple;
	bh=wM975yYhhnJbskoT3Xe/Z8RaXLTIAwoZIK7NoqKeDB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JQsxk6QtAlHG2MQbo9VpSqCZd1/UtYfYrzLhakv3wKgmSqhzOFvkaFFe9f7t4nT0hVbknWSHU0WMI/w+6H8A+5Ue9CT1e7m/8PuJw9z5SCCRarT6l8WkAd+IGCvlCLgXa27HRVSHW+0yXvfuROAIhu4Mks3ZdlMarFof839T1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ace5t6Cv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159fb161fso624212276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307580; x=1727912380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOjsxdYdAkInxupUorws184MmwFGmal1AWb/bAcHrOQ=;
        b=Ace5t6CvyKVH55R5F+8+SFEGTxJt+z7edGdIMLwXZb2veNJnyJiw+inHBKPQefkXcj
         yfj9g09w66ixqXNGIKfYucTJ/eQohq0K1Zw2pRs/eTkiv0VfbbVbxWuoBf/BqOEqslT5
         /ztQBPjaqKWZO0jdXdJa3Wu5L1+NUjStuEM5JR2vT+eTeJuhMuhiklq/b6z3OdsGFcwm
         dEwg8wI3mrLRBO4tM79Mpzhv34Gs4wka9YKLR6aAjcdY5/2JuRczf900R1uv+5+F6+33
         A11AMc3aVg0SeQnHWFLMN4hDviU7z4O6SwauY33tJ1U/86KDOoxW2/k2Gqmtpu/SXwey
         eadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307580; x=1727912380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOjsxdYdAkInxupUorws184MmwFGmal1AWb/bAcHrOQ=;
        b=uf46Jo6WTveSdePp16VbPe3blucG+z9f7I6zl7Rrry8U9pxe8Pw1cmowyOy7+yuypt
         pgqyzMKFNIhjmfkDb3OoOjoC0v0vtXv8KYrGkUM81TTdfjXIu8J3+Mpd3WNUXSyY023m
         jmpUzwwh2By1vfzyEc4hw58nqUAOt9k9QpPuDH4VY2nCLTwhffJQDPjP/FTPdK6FFwkZ
         0A+kv4dE9Ic+ZjO6KcIdJBZEY99IKQ3Oq9LISqCB79NtbSoAbTSsAnL6GRbx5Z8U0saS
         TTRACOct2uLcL1YKxtx2GrC/Jj7B6UVXA9baVYIQgTCFJxDkkBSxLhEvD0NxgvU+yw72
         FFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/OoSUHat+bdXijH5hq67FnDmDvJGtCdWQ6Rg9APr+Cn6byV+pytHn+YXwBKJxxSq8YxnUJQFMJcAv/7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLzpD1U46L4Z6BvH2PGuxHr5PxVGurm42zF9eBD/OAjGmtZa5
	SG8BhAYu3nIU9fcgYtsuCfbU1prtpCt28PNoiLhpPi0jISsvGFF+lRA4SFM0HLAwo65ExDJq/Kq
	cF4uJBA==
X-Google-Smtp-Source: AGHT+IHdWqR9IrD2hZQX0Xo9yhQJzQmApDf52iNmKjMPjmcrCoxOYUdkaSUs0GEug6EnSPPHsMtafWiB8pKN
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a5b:841:0:b0:e24:9af1:43e7 with SMTP id
 3f1490d57ef6-e24d7fdf205mr3591276.5.1727307579861; Wed, 25 Sep 2024 16:39:39
 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:23 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-9-mmaurer@google.com>
Subject: [PATCH v5 08/16] module: Factor out elf_validity_cache_index_str
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

Pull out index validation for the symbol string section.

Note that this does not validate the *contents* of the string table,
only shape and presence of the section.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6be58b0a6468..43140475aac0 100644
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
2.46.1.824.gd892dcdcdd-goog


