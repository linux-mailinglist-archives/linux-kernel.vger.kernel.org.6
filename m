Return-Path: <linux-kernel+bounces-337639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A2984CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50983B23508
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5435A1AE873;
	Tue, 24 Sep 2024 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tcsE/buZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5E12D758
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212857; cv=none; b=K8uwEqwtaQwxUzBJJ4VVqufRpsUH6Q3Y3AAAf2WzLG7+Sfs50efvTbfeNYGuji4p1SOBYadik2z/f5ALCeiS4xFaQa8xzNvvlhHLh2FEcOQGY/NABlQL6paO7nNd7kaqGswlou6K/nu4sWRny5pBGKjhHamo3iy/gt8Rf+fNGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212857; c=relaxed/simple;
	bh=9QDYzeFqtIgpifJubbDxlmlH7eEjUZaH/2YQ84rdY0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GSNvq133xJRkOaqeYxbtMOKZvun0bGUcQLb5JDgduDvzYaE2hr7TJn5a9U3+1Pcn3yTbHF0aTVG+rKGA5DhD/GSNMTdMT20hDGDOWBrJguu6ISnB5lasZbdTJcmq2vKK/IVfxIPXmzqH6ZfhK8MDQizUB5/vP9x7VJwDhotX+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tcsE/buZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4bd76f5a8so94500687b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727212855; x=1727817655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6yXvv/vrTLDrEzmPTfvxgBAIug2sA8OdrjoRUJniL2M=;
        b=tcsE/buZV/Pd4YVm+6yOgO65KcvKQyVX2kO1KuKrbmj91Nsa5UPlj4R5fdPbJFwdbc
         2qz2f55PkQKFcFl5ZW7g6oAPy71wktmAVVrGYelB37w2BbO7RNnRREOoTHO2fxd3tTZb
         YU8EmUb02q+/zPoKJX7oyFy9ARWkgt6rvsEWjR8O/4dhwKz0/nBfZc2330Kq/RaiTMhI
         +bVgmhk33ugCosRwkzq0KyXXQvY3c2jwDGvKjWnhjOtoumr9dg3SSunKUr8SooVAoWjH
         hv9g5DvomDnrOyEQjfPHbSt1AAH/uXNcmGLL8iAC2kIREqvZUGxviN6JQjzYbYwNHnVe
         yY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212855; x=1727817655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yXvv/vrTLDrEzmPTfvxgBAIug2sA8OdrjoRUJniL2M=;
        b=O2u6OBlIonqxytf1ICJrbV9WmDLebHhFOPLheh+rgpmwZVf8iLk6w2PeM6x3Aky+L3
         EIk+wVrVuufH1JL3NiQmtVoEWZ8Om76dXxZjfIuDg2MXofGu/1rMfXtTDJ5BeDFSTlvm
         GQvPN5di2CETVw/nlTSQ6bQOoT8o3PQWelKiOkQoMFJ+OtsMH63ToeLjBqqkKGHODUTJ
         iuCQ0uJxbU88ecY5StBy5PpG8His+lE0gZOmTShUci41SipeBIlvib5P0QRs1c9iaNeP
         HJMreMO6OhqUtTFDCb5lc8ZiOPtVhA+Lt+gMOWwRUDYlzoEE8VE9OfFgSz+C6KaQErQR
         Qzag==
X-Forwarded-Encrypted: i=1; AJvYcCWx17zK4UsYEY+jToKJbM27mWaeVjB5nkdVTtOob1g+jhWYoIQf0zow8MfjaLmW5HvDf6mZ8tD7w/BtZYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2LEtvwpira2gdVoUTx0AZxAuOMn+c0nGCmy8tpUp0AYy89tk
	JUeegPfbyypDIBwdZ9HGMgpZ4+g3yDmYwV6q0yBVwzY+94AIdyLkrvVTk0e5+JlJwqnYr783s0a
	E+fP0sw==
X-Google-Smtp-Source: AGHT+IFs8LQAasANVAvCofJO+q+i4+lB4kywHbjnYQOLx8KwspGXX2ok0JuXHR7DN8S+jA9Mu0adrskEziGr
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:64c3:b0:6db:c6ac:62a0 with SMTP
 id 00721157ae682-6e21d9f538amr44047b3.5.1727212854854; Tue, 24 Sep 2024
 14:20:54 -0700 (PDT)
Date: Tue, 24 Sep 2024 21:19:53 +0000
In-Reply-To: <20240924212024.540574-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924212024.540574-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240924212024.540574-12-mmaurer@google.com>
Subject: [PATCH v4 11/16] module: Additional validation in elf_validity_cache_strtab
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, linux-modules@vger.kernel.org
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
index c082d5d41a8d..b40b632f00a6 100644
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
2.46.1.824.gd892dcdcdd-goog


