Return-Path: <linux-kernel+bounces-548989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145B1A54BCB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55162175013
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F2210F45;
	Thu,  6 Mar 2025 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PLO2JKdQ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510DC20F08F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266936; cv=none; b=ZbUfr/SF2Go0Biy4qNm2j1kV1K5fjAjFxKFY7QGde6R418FsP5sg3m6Py+4jRukZOpMSlfhTn+wdeQXYQYPtECWB4KZk5p/2E2gu1jeTa95nE9y59LcdyF706LZnsNU/6CS9XlHMIKkVvrPmo75+S66ncfdALDoGtcPhPEOJ0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266936; c=relaxed/simple;
	bh=0tGSJ2zcfBUxZkyVy6Lyn8LU+JSKx/WFyTwadsmy5nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwHmH2zimtf0c/oOoTg4QSzKlKdJsnEy76vAwlrYrvrEF4YwLNtKJXdicZRwICY9pJ5gjCdQ6xfSlNLnFIygkywCsU4X+jRsSLs3TclmnO5+sKJe/bWES+a3zEWanCOtRofxtaK1hSD6dlhk2/x/mpgPHrnG22rQftluFDwihwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PLO2JKdQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912c09bea5so492245f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 05:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741266932; x=1741871732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qz4XRTq2wHtyfxO9Iu3bx9YuJ/6rqBX5vJIg6Ki8YEc=;
        b=PLO2JKdQv8xHHNAxPqDJZ1qOmIsmGdiKTFD10pGaXcG77RCl/DkLJNZcCimed9BO6c
         HbYLWTyBF2N0bJXKPWLvmbuz0Zxx2qoTbGXItMyCJhxQr0hhVCygk0TemIY3v3d20gwk
         AwV/Y1QdDLYXElT6EnwCwZD6y1vB/s7wJta/WNOniEV4uomcytWlYtCLNx06Pj7u1gZa
         nFUtIhSrnBgDUpejuasxw14UOgRpiR1FedJ1i+DQ4bhpScWjpYrDwAwRi8k+f7ltWAt5
         nm0s4mMmN3IsRYP6SeXMPimVb+YD0MgL6HJgLV6KSIyd94fNJaWN5wDAnSeDXqny/Mi9
         385Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741266932; x=1741871732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz4XRTq2wHtyfxO9Iu3bx9YuJ/6rqBX5vJIg6Ki8YEc=;
        b=T4jWEpKuu72zQ8SToKYVDkXxUG9TxmywLpDEiILXutJYuJM1b+2AexCDYldDpKFWLP
         k38KRO8Biaj64nCeTlVYe3ueF9+LmAa+32o784s+Mv4GDVEKHKcCh5DKORiCmsMogZFg
         NjH+MPSHNBq+bEKUI3vkcngBNKYFgrsm9+iGvjSFvOR1gymqF2QJULydvR2yUlVDC0FK
         OLqOewmdx79IQpIFC4/8S/LDWFmMBvd9LhmVy0TYljDva4zTZpfkKiV5R6zEKT7e1aeY
         qibhDrpevClTfbWyxR7WpGCniDOl6ygAwi1/E9QjFHUHLHacIhyAmhg7l2DKz/Z4swWQ
         z6UA==
X-Forwarded-Encrypted: i=1; AJvYcCVGoiqZnOgvXg2pQUgWwQ/VwgnbXyPLQPf3PFwq8KSw7NSkS8Dz/CB47sNFbRP9sLmo10xz95nR4QWqFdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVK+aDYN1GF7Cnl3bEkEEUcvR61GTBnwr+4S2HeNvPeh32gSE1
	9APCnk2DJMegtMBgxOU9YNuk3t/APOTI82N6br3e+gonWx/fmLvDIvEJzocNnFQ=
X-Gm-Gg: ASbGncusUFb/ohOnFAke321YGfqg6QfVYbCpjkv4xsgZWN/Mtu3R+iy003Ml0F8HyDD
	6sXXr3HNbaDt7/VvbkG5X4tZgVQ9Y2a2GOPTAnTC0jfugpLcozVlTUlgpxd7yOKBUshWQVpSbFf
	mh7opvDWRZ3d5CuXF9bowqDMzLWHx7Io+kVqTQIYMGbd76sd+N3fYUJp0OcGNTVn//JJiK+/SId
	Dc5fHDnEa+MI+ten5UxQyqf3meDWb3cxJia+vH0/w2kHmpFI+xSIkbubQn63NkxNQ7ML3fdYLOb
	B8hJYyNb3QiTmDEZMfM9srD/SAB782QVbi5kpp7UsF6HFAKq
X-Google-Smtp-Source: AGHT+IHqVig/PZTsgpubptGowxDPhYadgbR/BUVqM7eADw/KYZQQ9lMGwoFbn+PLE/hr3mMmnwG7GQ==
X-Received: by 2002:a5d:6d07:0:b0:38f:3224:660b with SMTP id ffacd0b85a97d-3911f7377fdmr5718510f8f.22.1741266932519;
        Thu, 06 Mar 2025 05:15:32 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c327fsm19704485e9.13.2025.03.06.05.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:15:30 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] module: Add a separate function to mark sections as read-only after init
Date: Thu,  6 Mar 2025 14:13:53 +0100
Message-ID: <20250306131430.7016-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306131430.7016-1-petr.pavlu@suse.com>
References: <20250306131430.7016-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the logic to mark special sections as read-only after module
initialization into a separate function, along other related code in
strict_rwx.c. Use a table with names of such sections to make it easier to
add more.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/internal.h   |  2 ++
 kernel/module/main.c       | 18 +++---------------
 kernel/module/strict_rwx.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 18f32e791db0..7cd250ad1b51 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -336,6 +336,8 @@ int module_enable_text_rox(const struct module *mod);
 int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 				const char *secstrings,
 				const struct module *mod);
+void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+			       const char *secstrings);
 
 #ifdef CONFIG_MODULE_SIG
 int module_sig_check(struct load_info *info, int flags);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad289a6f..e66d501d1209 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2791,7 +2791,6 @@ core_param(module_blacklist, module_blacklist, charp, 0400);
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
-	unsigned int ndx;
 	int err;
 
 	/* Allow arches to frob section contents and sizes.  */
@@ -2809,22 +2808,11 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
 
 	/*
-	 * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
-	 * layout_sections() can put it in the right place.
+	 * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections() can
+	 * put them in the right place.
 	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
 	 */
-	ndx = find_sec(info, ".data..ro_after_init");
-	if (ndx)
-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
-	/*
-	 * Mark the __jump_table section as ro_after_init as well: these data
-	 * structures are never modified, with the exception of entries that
-	 * refer to code in the __init section, which are annotated as such
-	 * at module load time.
-	 */
-	ndx = find_sec(info, "__jump_table");
-	if (ndx)
-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
+	module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstrings);
 
 	/*
 	 * Determine total sizes, and put offsets in sh_entsize.  For now
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 81278e687055..fa701dad4ed1 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -106,3 +106,36 @@ int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 
 	return 0;
 }
+
+static const char *const ro_after_init[] = {
+	/*
+	 * Section .data..ro_after_init holds data explicitly annotated by
+	 * __ro_after_init.
+	 */
+	".data..ro_after_init",
+
+	/*
+	 * Section __jump_table holds data structures that are never modified,
+	 * with the exception of entries that refer to code in the __init
+	 * section, which are marked as such at module load time.
+	 */
+	"__jump_table",
+};
+
+void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+			       const char *secstrings)
+{
+	int i, j;
+
+	for (i = 1; i < hdr->e_shnum; i++) {
+		Elf_Shdr *shdr = &sechdrs[i];
+
+		for (j = 0; j < ARRAY_SIZE(ro_after_init); j++) {
+			if (strcmp(secstrings + shdr->sh_name,
+				   ro_after_init[j]) == 0) {
+				shdr->sh_flags |= SHF_RO_AFTER_INIT;
+				break;
+			}
+		}
+	}
+}
-- 
2.43.0


