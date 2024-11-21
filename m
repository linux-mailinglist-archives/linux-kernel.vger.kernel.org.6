Return-Path: <linux-kernel+bounces-417454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F174B9D5445
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7746A1F23247
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2C1DFE17;
	Thu, 21 Nov 2024 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5pg+LcL"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4471DF990
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221788; cv=none; b=btcHoDAD2hu0btrv+vEbEFzMbuMztl+Ugmtrd7g15Qp/ieHg12LHJv8h9pBiypm9QDTj2jLwvIKEhKjp+NxMoEO46oOKmFHf8xLFS64KJqKzFRFPfwRiHwSYwGHzB4Uh+IdZw7YVSxeY8uCau0ayq6dGcfxhSuTDA+J0BEnAOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221788; c=relaxed/simple;
	bh=jbxFhuvey1WTvyXfp5U6GmMsYsEYqr1Ay/4F5G1PdfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LRdK1FYc2EsATbvN+tn2uvFhEsQqmUH7wDIYThkHs/kJ1gDOvqbKTY0AtttMpPOIFzoXnckokiP9AlEWtOVFw8dxBw748CTHcCTrHvS8YbOTWcMhrV0TsHsIbzp8/B4bJBYenMHdYvCTY2IwvkpZDaFopny31fg/Wtv/IYI3oSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5pg+LcL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fb966ee0cdso1007398a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732221785; x=1732826585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5MCNRfop5nOfUUV7hHmV5AoBzZh1cegVvykqd2dnJM=;
        b=a5pg+LcL/X+sn2EgvG91smFjKUDL1dSI//qcJIpSO3ue5zbS12rO2nyRj7yO7RNrIj
         4GEwifCMMJCjRkqtb1YdzlxjQ9QFR+qV4aA9F1Ks0ILDQ4PW/m0ikb/jlaK7CR69cTxK
         VIVmPCRs7ggvx13yoY8tSOnFnTFdqd86KASIjTotM2x/qpu1U0Zatk6W4mKNjprrYuYp
         +F9HFaSaINtsUV7CLGdC+LUxeIekSoVn7DnnxajvUuYcLVCNHZPEx5mf0q9QyAUVYMKB
         pvPC/su0YMua79azbrALEZIWAaqMztRHDn0GdAuvqdqs3rJWLMI6Mn0ciXEkWqTgzFvD
         17FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221785; x=1732826585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5MCNRfop5nOfUUV7hHmV5AoBzZh1cegVvykqd2dnJM=;
        b=dJkYgGpkDoUd0b83VfFXIXlSXo1LjQ6y89nj/cRrryOleDxkaO+G9I3VJq0jNTzvFw
         5lB0tfucK7IOK9yg8/Sos61w+Hv4FBZhf4wvsGZkOuIpy2VdM4e4JCLW8QwjUTZ4a6CK
         xSJpz7L1LNJtOxIWWmVPVwsFCiqEbF6S3wTqRWzyS0NeyLudcxIZ2YBlBteTPYW2Kebg
         nZB1STW/RkULgx404beGa7O/ZA/ytB4MeOw8t4J0O9A9pVcxDU3Xh7EnmWZvgWMwQle2
         18RkjCO+waWXygD94UKKjiLCcN9A/IUavlE8OcY64PfQ0MF9EoabT4OJTdYmvRSf/++G
         BVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIHQDJZwjN6I7ug7NHAI+I0vGoN5/T6hKT3mk67kgR45f8qHp+gkITgcJgo3KEBZ16PUshSf9qYpsyjdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvYHoujof7x4maahDsvNLFu9jtKkvP71GxQRyV4R14r+aSHPL
	EnVnoCkOfk0u0QALOc4+iLQjCmebfG0CzCJNzS1s7ItOp94gvzlDH+5y4dPM8EQcGy/tBuCI68v
	Fd+ht+qfV1WtPYQOLbk1rm/2CqQ==
X-Google-Smtp-Source: AGHT+IHybJoSX8i6NWVVo83CFQI1wGyIHwg1VGSqiPTrJEHr5+EdtAXeiKNNUzkyQFUirqk0zWW0qCwUXRK0ndBz7QI=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a63:b54c:0:b0:7e9:c9d5:4d98 with SMTP
 id 41be03b00d2f7-7fbccbd3a38mr276a12.5.1732221785245; Thu, 21 Nov 2024
 12:43:05 -0800 (PST)
Date: Thu, 21 Nov 2024 20:42:38 +0000
In-Reply-To: <20241121204220.2378181-20-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121204220.2378181-20-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4744; i=samitolvanen@google.com;
 h=from:subject; bh=jbxFhuvey1WTvyXfp5U6GmMsYsEYqr1Ay/4F5G1PdfI=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOn2s02/Ciw89OEv3yVPw15n/tALmZNm6cdOWyUbZ9Kq+
 91yYVRfRwkLgxgHg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZhItg4jQ4Nd88ufWXa2rLdb
 dCPcWct/sPfqb1xxb3n2rjdfnA7VbWT48TLg4JuLa5h5HL8WFp+I/pEXv6Ly7//m9qiTLQxcHY8 4AQ==
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121204220.2378181-37-samitolvanen@google.com>
Subject: [PATCH v6 17/18] kbuild: Add gendwarfksyms as an alternative to genksyms
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

When MODVERSIONS is enabled, allow selecting gendwarfksyms as the
implementation, but default to genksyms.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/module/Kconfig  | 25 ++++++++++++++++++++++++-
 scripts/Makefile       |  2 +-
 scripts/Makefile.build | 35 +++++++++++++++++++++++++++++------
 3 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index f9e5f82fa88b..e6b2427e5c19 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -169,13 +169,36 @@ config MODVERSIONS
 	  make them incompatible with the kernel you are running.  If
 	  unsure, say N.
 
+choice
+	prompt "Module versioning implementation"
+	depends on MODVERSIONS
+	default GENKSYMS
+	help
+	  Select the tool used to calculate symbol versions for modules.
+
+	  If unsure, select GENKSYMS.
+
+config GENKSYMS
+	bool "genksyms (from source code)"
+	help
+	  Calculate symbol versions from pre-processed source code using
+	  genksyms.
+
+	  If unsure, say Y.
+
 config GENDWARFKSYMS
-	bool
+	bool "gendwarfksyms (from debugging information)"
 	depends on DEBUG_INFO
 	# Requires full debugging information, split DWARF not supported.
 	depends on !DEBUG_INFO_REDUCED && !DEBUG_INFO_SPLIT
 	# Requires ELF object files.
 	depends on !LTO
+	help
+	  Calculate symbol versions from DWARF debugging information using
+	  gendwarfksyms. Requires DEBUG_INFO to be enabled.
+
+	  If unsure, say N.
+endchoice
 
 config ASM_MODVERSIONS
 	bool
diff --git a/scripts/Makefile b/scripts/Makefile
index d7fec46d38c0..8533f4498885 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -53,7 +53,7 @@ hostprogs += unifdef
 targets += module.lds
 
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
-subdir-$(CONFIG_MODVERSIONS) += genksyms
+subdir-$(CONFIG_GENKSYMS) += genksyms
 subdir-$(CONFIG_GENDWARFKSYMS) += gendwarfksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
 subdir-$(CONFIG_SECURITY_IPE) += ipe
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f41ce2131979..d6b211a7b261 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -107,13 +107,24 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
 $(obj)/%.i: $(obj)/%.c FORCE
 	$(call if_changed_dep,cpp_i_c)
 
+getexportsymbols = $(NM) $@ | sed -n 's/.* __export_symbol_\(.*\)/$(1)/p'
+
+gendwarfksyms = $(objtree)/scripts/gendwarfksyms/gendwarfksyms	\
+	$(if $(KBUILD_SYMTYPES), --symtypes $(@:.o=.symtypes))	\
+	$(if $(KBUILD_GENDWARFKSYMS_STABLE), --stable)
+
 genksyms = $(objtree)/scripts/genksyms/genksyms		\
 	$(if $(KBUILD_SYMTYPES), -T $(@:.o=.symtypes))	\
 	$(if $(KBUILD_PRESERVE), -p)			\
 	$(addprefix -r , $(wildcard $(@:.o=.symref)))
 
 # These mirror gensymtypes_S and co below, keep them in synch.
+ifdef CONFIG_GENDWARFKSYMS
+cmd_gensymtypes_c = $(if $(skip_gendwarfksyms),,	\
+	$(call getexportsymbols,\1) | $(gendwarfksyms) $@)
+else
 cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
+endif # CONFIG_GENDWARFKSYMS
 
 # LLVM assembly
 # Generate .ll files from .c
@@ -279,14 +290,26 @@ $(obj)/%.ll: $(obj)/%.rs FORCE
 # This is convoluted. The .S file must first be preprocessed to run guards and
 # expand names, then the resulting exports must be constructed into plain
 # EXPORT_SYMBOL(symbol); to build our dummy C file, and that gets preprocessed
-# to make the genksyms input.
+# to make the genksyms input or compiled into an object for gendwarfksyms.
 #
 # These mirror gensymtypes_c and co above, keep them in synch.
-cmd_gensymtypes_S =                                                         \
-   { echo "\#include <linux/kernel.h>" ;                                    \
-     echo "\#include <asm/asm-prototypes.h>" ;                              \
-     $(NM) $@ | sed -n 's/.* __export_symbol_\(.*\)/EXPORT_SYMBOL(\1);/p' ; } | \
-    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
+getasmexports =								\
+   { echo "\#include <linux/kernel.h>" ;				\
+     echo "\#include <linux/string.h>" ;				\
+     echo "\#include <asm/asm-prototypes.h>" ;				\
+     $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }
+
+ifdef CONFIG_GENDWARFKSYMS
+cmd_gensymtypes_S =							\
+	$(getasmexports) |						\
+	$(CC) $(c_flags) -c -o $(@:.o=.gendwarfksyms.o) -xc -;		\
+	$(call getexportsymbols,\1) |					\
+	$(gendwarfksyms) $(@:.o=.gendwarfksyms.o)
+else
+cmd_gensymtypes_S =							\
+	$(getasmexports) |						\
+	$(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
+endif # CONFIG_GENDWARFKSYMS
 
 quiet_cmd_cpp_s_S = CPP $(quiet_modtag) $@
 cmd_cpp_s_S       = $(CPP) $(a_flags) -o $@ $<
-- 
2.47.0.371.ga323438b13-goog


