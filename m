Return-Path: <linux-kernel+bounces-276922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A9E949A1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF39282FD2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D0017A902;
	Tue,  6 Aug 2024 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdTckeFX"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95217A581
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979294; cv=none; b=ftjzWYXVQg2jXFX8MOScyNxk9rzIVUHLNkWWR/YNi1OiOOZIFitvnlA7LMbyGLZ57bReP+IIJbFNSScA8RzKFL2CWRv/0D109JgtEhSWSTYr5FMV2QWFCgXpHK4FHLNDNlOCfPePrGtDxwLoFq7uED8Vm1uFcVF5fNm5/C9c1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979294; c=relaxed/simple;
	bh=epnI8eGvDDKISVPVfjjyglGB5CLDgu79i3HpiZi/AGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fk8E58hQSY28PGwrAuPtBoN66geKtiHKXPqgL8hfGLCor7kgnZftNWtdUrHBfvloJ7iun6uTVmTc55OpIaSQr+1B0XZVEX/SRIEyYjV1++14LhaoqkgEkFtuoSzF/efWtpV8joTpJ+Pzp0usnw7U8rH/fYVAJVmjkbYTl4NZhik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdTckeFX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso1927370276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979292; x=1723584092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ2zq/LCKzRU6SFahUeU1WMrViDXPV+lPPZmW0ps8uk=;
        b=pdTckeFXWIegKqc+4CmBazJKel8IMcm8mDemjVEdO0+mj7/5wfkCkEBnLvbUXqYblx
         NnTT7A80izGbzfLnMY7q6VgfHBxe58erO08xd7XOMkmstGIk1ElWiLDQUIl2gQPT/ELf
         gjg8UptB/wVnz9qUEGlPFd6iusGQvqaF6tIXSlBtjNfgdpA6Ncntou5SZUkt2QOVB9Dz
         sjs/IG1QKih8lI0+1nleiVZFs4J+2kDKj1xw3S2CZRh7jPRnEbuEXkEmnxw2KXTKly9g
         NR5dEwinei7OHsx28vsrmP9BcQJjtPAiHLlScdSW1DVXBZpTScXrUH0KewWrw4VqYHZ7
         QVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979292; x=1723584092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ2zq/LCKzRU6SFahUeU1WMrViDXPV+lPPZmW0ps8uk=;
        b=KoHxtOcQAezgw2R1ZDbtnCDUplW5fbYDHDyQahB27Wyb6ZPy3SAXHMho8s12o7c5+2
         X6l53ks6VzGa2KTRiph7ijidejiVpH7b+Jf2dhWS7hL3bpxec06gFJHJioed2DGPrajP
         lsDLpJiewS80kfmZMWGUmdWP+PjWQVWrx3tbRetAOkJMHvpK4yF3Y03C0jZoLLXWOwcR
         S+axWoWVlpolc850cFH8LY8TdvkHNECoXF/GgDM8wDSPGNwGrDtyV5PwW4/BHJBm6jsw
         QHW/kJQ27y9Zi70dTEdXf6/NSpGN5nM2PWs3Fk+aOPAW3pLj6v4itsnKV6UJQ0lR1t4X
         2iEg==
X-Forwarded-Encrypted: i=1; AJvYcCUDS7iQaJQJlyb/EjyElJn4+9etaVRI35j2qZkcYA69Ix4itLFoZ2ceFWjYpDbPTNwAARupx5dPy60UK95AyBEwwwXoxvHuY8IJA2BK
X-Gm-Message-State: AOJu0YxqrELR4gKU5LSSOOUp9ThjO4FZpDLG9SRlf++rHABd8RNSctLu
	HxuJtf23zBWvFg8VcG4RnUdPm4+oWv+9213LhIZPB9jgTZtXEwd5Dz8S9T7w0/2UuOyFHXb2jBP
	/LXVlkQ==
X-Google-Smtp-Source: AGHT+IH6x1pd7T7CSwv3R+eylAyRZmNxI/232pEEFyoDFtMxFDuEMBONgvXpuP7EkLOuGdtv0x2gUeU1cK01
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:100c:b0:dfa:8ed1:8f1b with SMTP
 id 3f1490d57ef6-e0bde22affamr345027276.1.1722979292488; Tue, 06 Aug 2024
 14:21:32 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:37 +0000
In-Reply-To: <20240806212106.617164-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-12-mmaurer@google.com>
Subject: [PATCH v3 11/16] module: Additional validation in elf_validity_cache_strtab
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Validate properties of the strtab that are depended on elsewhere, but
were previously unchecked:
* String table nonempty (offset 0 is valid)
* String table has a leading NUL (offset 0 corresponds to "")
* String table is NUL terminated (strfoo functions won't run out of the
  table while reading).
* All symbols names are inbounds of the string table.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d70d829b5ab9..7001054c5c4f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2090,17 +2090,53 @@ static int elf_validity_cache_index(struct load_info *info, int flags)
 }
 
 /**
- * elf_validity_cache_strtab() - Cache symbol string table
+ * elf_validity_cache_strtab() - Validate and cache symbol string table
  * @info: Load info to read from and update.
  *        Must have &load_info->sechdrs and &load_info->secstrings populated.
  *        Must have &load_info->index populated.
  *
+ * Checks:
+ *
+ * * The string table is not empty.
+ * * The string table starts and ends with NUL (required by ELF spec).
+ * * Every &Elf_Sym->st_name offset in the symbol table is inbounds of the
+ *   string table.
+ *
+ * And caches the pointer as &load_info->strtab in @info.
+ *
  * Return: 0 on success, negative error code if a check failed.
  */
 static int elf_validity_cache_strtab(struct load_info *info)
 {
 	Elf_Shdr *str_shdr = &info->sechdrs[info->index.str];
+	Elf_Shdr *sym_shdr = &info->sechdrs[info->index.sym];
 	char *strtab = (char *)info->hdr + str_shdr->sh_offset;
+	Elf_Sym *syms = (void *)info->hdr + sym_shdr->sh_offset;
+	int i;
+
+	if (str_shdr->sh_size == 0) {
+		pr_err("empty symbol string table\n");
+		return -ENOEXEC;
+	}
+	if (strtab[0] != '\0') {
+		pr_err("symbol string table missing leading NUL\n");
+		return -ENOEXEC;
+	}
+	if (strtab[str_shdr->sh_size - 1] != '\0') {
+		pr_err("symbol string table isn't NUL terminated\n");
+		return -ENOEXEC;
+	}
+
+	/*
+	 * Now that we know strtab is correctly structured, check symbol
+	 * starts are inbounds before they're used later.
+	 */
+	for (i = 0; i < sym_shdr->sh_size / sizeof(*syms); i++) {
+		if (syms[i].st_name >= str_shdr->sh_size) {
+			pr_err("symbol name out of bounds in string table");
+			return -ENOEXEC;
+		}
+	}
 
 	info->strtab = strtab;
 	return 0;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


