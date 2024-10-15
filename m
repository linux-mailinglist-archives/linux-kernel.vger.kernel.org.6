Return-Path: <linux-kernel+bounces-366923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B567B99FC46
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6566F1F25CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64B42003CF;
	Tue, 15 Oct 2024 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVeqJ2LV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991272003AE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034243; cv=none; b=GmPZOb/npNX3MDlLNRcQSX/GC1fz7LQbPPUr6UZwNmp7Vqk2Vp5DKVgTEn0wQGHSAi0vtckMYL+cs6jmopj2F8M9OHX4+cWEFdVrdtOxOvaFIduMRNOvvBcEtzJ6y1eXJksd4+ol5cUXUKzSuUgY56XHVH2Fi5+1FTr77HW8R1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034243; c=relaxed/simple;
	bh=GPb1TpKFNjVVCpW2qIAL8wvN9CirdjY1ZpdtVrcA0Wo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SmwUOvadEmdj8OVy9qE5L6EHoCgyIV8j5Im4cuXlnswxN6j4NX6HK7by3OHkAC5xEQB+R/ctp35rKubrl5VjXyOibblukg7evd39jEAOb5Hhz5B3dWNVAh2y4p/WMF+qG6nS/sMb7WvZyhEPSo2ej93RLzk2k/ziwV7F19NmLJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVeqJ2LV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fdb4f35fso9300123276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034241; x=1729639041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnoeOJ9yqvZhu5BOCvDTuTGU7w1wCrt97NAeyTTyfDc=;
        b=UVeqJ2LVWz1wTIuAVy+fx69TM7ZWqALtDu2AuE2B9dpm3VkBB/Wh4xl7+TUTOA7FcZ
         Nj0aUdFuo+z5dD+JqCt+4mupbMymOtDzkvjMutytSEXu1WhGy47doAD4tZRCmh3rBKKm
         JgjwuDvgohtnhvkysml0PCpGF8UzkM4FKI/I4cMm1oDO4jfOmr4fhWG8Rabcr7sCRqt5
         d6RYUyfpRCJXTPEo0Ru4UiAaV8WdiKDbJIHuN8HIHZC3Vt853Jlr/OqYVPbAHkm7WVxL
         IKaDk3Ti0ZgnB7XaXjCC0K6++HkGkDP4lK1afdQmrWM5P7nKHR/PrxZBso2rHrgihCmp
         u+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034241; x=1729639041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnoeOJ9yqvZhu5BOCvDTuTGU7w1wCrt97NAeyTTyfDc=;
        b=u/oxSYLNyvMxfWRG3w0tDZKdC5NqaU/JOhpnceABgbUEpnOH9Hh/FOD2IImxgYk1QH
         fOjroZ0DK6MqArPJUSXSXY6ULi7n7Qj0FRe7gUGe+U5Jvj1xZFn3RmwclNVF3NO+2xuF
         BR4jmr8ekLNl0FWB3f/VDxGt3qwTMQbrPGYdIuADwPXaOam4vM8WMBEHGvIMlN6hN52W
         PDfz2a/D7Jew1JR2+6aPE0yhyGy4f/LayAGlZFyevufedEqCmyXqnhsa1kTafmPcKqq3
         rN2fivL58BdSfq99FmGQzEKhXKKfT/Pupso4Wap/PzUPONJ17JXyLvXsmXSFQgQL8HGl
         JKJA==
X-Gm-Message-State: AOJu0YwYB1hB4AxOJCMW88jOwE0TxtI0i/BXvr8v3JCY3+QaaLlOGxbi
	wSeeBfoaFSxdZvniWTA76oP+EMOlCpWpe5ejLbPFJn1s6Hki3gyNas1yr8UVLSPORQTZhw58aHd
	FVUibAg==
X-Google-Smtp-Source: AGHT+IGHz6HPifKuNrMT95HK5iMWP8yOrgiK3ZaaQuMaSy1FjZCKCjGsfCmky7q8W2xsP6eERZaKJdG2Y8g2
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a5b:80e:0:b0:e28:f6f6:81a5 with SMTP id
 3f1490d57ef6-e29780d7669mr1444276.0.1729034240688; Tue, 15 Oct 2024 16:17:20
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:45 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-12-mmaurer@google.com>
Subject: [PATCH 11/12] module: Additional validation in elf_validity_cache_strtab
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
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
index 22aa5eb4e4f4..3db9ff544c09 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2123,17 +2123,53 @@ static int elf_validity_cache_index(struct load_info *info, int flags)
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
2.47.0.rc1.288.g06298d1525-goog


