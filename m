Return-Path: <linux-kernel+bounces-222171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AF290FDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89251F2253C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D562545C18;
	Thu, 20 Jun 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTIL7SNZ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB455882
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868800; cv=none; b=P9IgkcVve4OrAYhEOx7sijqxawrba9LkoKL5mQ73g3B1ZihZMHjGiMWDAJYhHHx43nZqrlt1rf8rQLYjC/AdW9xot3FwFKwhx9XxBLydv1XnuzgqTHwG/wiESB+w2QpwvpGd7aNC5dpyGjKTBkjk3GZgT1E6PcAnedCEPjKv2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868800; c=relaxed/simple;
	bh=xzxKSKvW3nrC4d+JdNIkEIF3s9sTLi0qMvbe6hzqOjs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DFmpINmIDYxJE6ja1eirSqTmT4DX3LgrsFSUfnamJ8Zswlb5fUybDtwLMH1aLPJbQZsPAsKtNeIGgC9aNzfYaB3YIMX9V11ZzhpVvJUUjOokCuwEJZY/Npzw90iOzHMitYrLiRex+AcLVyfwwwFLN9PpntZxx4uhl+7IHv78U1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lTIL7SNZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfdfe3d9fc8so1113660276.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718868798; x=1719473598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=166dPazPKyYzg5vR0VbXCP/S/mUewx8BE1resQ0m6Yo=;
        b=lTIL7SNZTSRSvEL+HX1UYvwOhmiHCpXCku/ASK7YgDvNrAyRM4pj8+aV6hkp0E128f
         CUXM77VcihYEr9uqHLBf4uu37o1yeSHRXW3UfLwX/fCoK+semrbTTF7qTH8C7JoVYTmJ
         3hQKpO5ofODAF9GYajKSh2+hX2M+A/JxX7RFrfEQ8p0ds8CqvOayhw9sWIjRcFrS5xAH
         df/AFDjIZE+P6A2kaYkNmbmpPdNfUqdsRqoSefpNte2oxHnB2tmRVJtTM5ilIVsH/1+p
         kGBl6wRei9Leo4hNYTdP0kZ32ddlnqA8LOIkEuduGPDzr544ldvWEXuP45ItB9CgNSe8
         ZeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718868798; x=1719473598;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=166dPazPKyYzg5vR0VbXCP/S/mUewx8BE1resQ0m6Yo=;
        b=kard+sqgTEqj0Ux1VgezeyuX/Z87f9TgUAWf5ZLtDEAif/NutgNi56TgV22NcRVrYC
         pUm1BEePbzhXT9l9PYRoX+gZEPbAGMc8sxPh8zXX/8pXgPoWpksqdlE1CjpDNDbTM0mB
         EQXckv2RGefUfWtsv66XgUDrHEygXdQjfiFQ9uUhEC0x6z5NNpoOANKa8aNOMnFeFaAN
         tRq3NcKk09UcGLumkfm7eF91f5fJm5AsL/ndQYK5bedB78fxdUBIWQDRa8k8PYoNhSuE
         TVEguQXMhVf+dRMltwevF/+rdR4bg1fhrPrxO3C6VpQmkRbMmLt5Ar+k2TvDjkTgVPxE
         j80Q==
X-Forwarded-Encrypted: i=1; AJvYcCUi06ccrXRT80dhR+2xCA8IJCSilrntDnWVsrdKwwRW3KsQPFjRIBWtPZ50BPB/GsuDg8uCZYalhK1rrTq13Q5Q3Ahlf7Xz1AlWFFaf
X-Gm-Message-State: AOJu0Yzps7kNl2JL2HFh7jdPgJHDUyhpvaHHrWLtfvpRzOHz5yhfgdeT
	BBiU4ueok1b3s25RwtbiKtaCDgSUlQ8M18oscLud18W5dZVieKnB7KrCUYWCqyf4j2IrRQ==
X-Google-Smtp-Source: AGHT+IHBZWz6iYm5ZTVn9Doe9+6KscmS9dl7/eBGp7jwavCYNAjmEtZKBfpBnO9iydjl8Ij9kBt3Si97
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:c09:b0:df4:a381:5cc9 with SMTP id
 3f1490d57ef6-e02be22ffc7mr1543837276.8.1718868797537; Thu, 20 Jun 2024
 00:33:17 -0700 (PDT)
Date: Thu, 20 Jun 2024 09:32:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240620073205.1543145-1-ardb+git@google.com>
Subject: [RFC PATCH] x86/efi: Drop support for fake EFI memory maps
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, dyoung@redhat.com, 
	Dan Williams <dan.j.williams@intel.com>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Between kexec and confidential VM support, handling the EFI memory maps
correctly on x86 is already proving to be rather difficult (as opposed
to other EFI architectures which manage to never modify the EFI memory
map to begin with)

EFI fake memory map support is essentially a development hack (for
testing new support for the 'special purpose' and 'more reliable' EFI
memory attributes) that leaked into production code. The regions marked
in this manner are not actually recognized as such by the firmware
itself or the EFI stub (and never have), and marking memory as 'more
reliable' seems rather futile if the underlying memory is just ordinary
RAM.

Marking memory as 'special purpose' in this way is also dubious, but may
be in use in production code nonetheless. However, the same should be
achievable by using the memmap= command line option with the ! operator.

EFI fake memmap support is not enabled by any of the major distros
(Debian, Fedora, SUSE, Ubuntu) and does not exist on other
architectures, so let's drop support for it.

Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  21 ---
 arch/x86/Kconfig                                |  20 --
 arch/x86/boot/compressed/kaslr.c                |  43 +----
 arch/x86/include/asm/efi.h                      |  15 --
 arch/x86/kernel/setup.c                         |   1 -
 arch/x86/platform/efi/efi.c                     |   2 -
 arch/x86/platform/efi/fake_mem.c                | 197 --------------------
 arch/x86/platform/efi/memmap.c                  |   1 +
 drivers/firmware/efi/libstub/x86-stub.c         |   2 +-
 9 files changed, 11 insertions(+), 291 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11e57ba2985c..90c64525e7e1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1450,27 +1450,6 @@
 			you are really sure that your UEFI does sane gc and
 			fulfills the spec otherwise your board may brick.
 
-	efi_fake_mem=	nn[KMG]@ss[KMG]:aa[,nn[KMG]@ss[KMG]:aa,..] [EFI,X86,EARLY]
-			Add arbitrary attribute to specific memory range by
-			updating original EFI memory map.
-			Region of memory which aa attribute is added to is
-			from ss to ss+nn.
-
-			If efi_fake_mem=2G@4G:0x10000,2G@0x10a0000000:0x10000
-			is specified, EFI_MEMORY_MORE_RELIABLE(0x10000)
-			attribute is added to range 0x100000000-0x180000000 and
-			0x10a0000000-0x1120000000.
-
-			If efi_fake_mem=8G@9G:0x40000 is specified, the
-			EFI_MEMORY_SP(0x40000) attribute is added to
-			range 0x240000000-0x43fffffff.
-
-			Using this parameter you can do debugging of EFI memmap
-			related features. For example, you can do debugging of
-			Address Range Mirroring feature even if your box
-			doesn't support it, or mark specific memory as
-			"soft reserved".
-
 	efivar_ssdt=	[EFI; X86] Name of an EFI variable that contains an SSDT
 			that is to be dynamically loaded by Linux. If there are
 			multiple variables with the same name but with different
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d7122a1883e..0c31f65aeb1d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2038,26 +2038,6 @@ config EFI_MIXED
 
 	  If unsure, say N.
 
-config EFI_FAKE_MEMMAP
-	bool "Enable EFI fake memory map"
-	depends on EFI
-	help
-	  Saying Y here will enable "efi_fake_mem" boot option.  By specifying
-	  this parameter, you can add arbitrary attribute to specific memory
-	  range by updating original (firmware provided) EFI memmap.  This is
-	  useful for debugging of EFI memmap related feature, e.g., Address
-	  Range Mirroring feature.
-
-config EFI_MAX_FAKE_MEM
-	int "maximum allowable number of ranges in efi_fake_mem boot option"
-	depends on EFI_FAKE_MEMMAP
-	range 1 128
-	default 8
-	help
-	  Maximum allowable number of ranges in efi_fake_mem boot option.
-	  Ranges can be set up to this value using comma-separated list.
-	  The default value is 8.
-
 config EFI_RUNTIME_MAP
 	bool "Export EFI runtime maps to sysfs" if EXPERT
 	depends on EFI
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index dec961c6d16a..f4d82379bf44 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -119,13 +119,8 @@ char *skip_spaces(const char *str)
 #include "../../../../lib/ctype.c"
 #include "../../../../lib/cmdline.c"
 
-enum parse_mode {
-	PARSE_MEMMAP,
-	PARSE_EFI,
-};
-
 static int
-parse_memmap(char *p, u64 *start, u64 *size, enum parse_mode mode)
+parse_memmap(char *p, u64 *start, u64 *size)
 {
 	char *oldp;
 
@@ -148,29 +143,11 @@ parse_memmap(char *p, u64 *start, u64 *size, enum parse_mode mode)
 		*start = memparse(p + 1, &p);
 		return 0;
 	case '@':
-		if (mode == PARSE_MEMMAP) {
-			/*
-			 * memmap=nn@ss specifies usable region, should
-			 * be skipped
-			 */
-			*size = 0;
-		} else {
-			u64 flags;
-
-			/*
-			 * efi_fake_mem=nn@ss:attr the attr specifies
-			 * flags that might imply a soft-reservation.
-			 */
-			*start = memparse(p + 1, &p);
-			if (p && *p == ':') {
-				p++;
-				if (kstrtoull(p, 0, &flags) < 0)
-					*size = 0;
-				else if (flags & EFI_MEMORY_SP)
-					return 0;
-			}
-			*size = 0;
-		}
+		/*
+		 * memmap=nn@ss specifies usable region, should
+		 * be skipped
+		 */
+		*size = 0;
 		fallthrough;
 	default:
 		/*
@@ -185,7 +162,7 @@ parse_memmap(char *p, u64 *start, u64 *size, enum parse_mode mode)
 	return -EINVAL;
 }
 
-static void mem_avoid_memmap(enum parse_mode mode, char *str)
+static void mem_avoid_memmap(char *str)
 {
 	static int i;
 
@@ -200,7 +177,7 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
 		if (k)
 			*k++ = 0;
 
-		rc = parse_memmap(str, &start, &size, mode);
+		rc = parse_memmap(str, &start, &size);
 		if (rc < 0)
 			break;
 		str = k;
@@ -281,7 +258,7 @@ static void handle_mem_options(void)
 			break;
 
 		if (!strcmp(param, "memmap")) {
-			mem_avoid_memmap(PARSE_MEMMAP, val);
+			mem_avoid_memmap(val);
 		} else if (IS_ENABLED(CONFIG_X86_64) && strstr(param, "hugepages")) {
 			parse_gb_huge_pages(param, val);
 		} else if (!strcmp(param, "mem")) {
@@ -295,8 +272,6 @@ static void handle_mem_options(void)
 
 			if (mem_size < mem_limit)
 				mem_limit = mem_size;
-		} else if (!strcmp(param, "efi_fake_mem")) {
-			mem_avoid_memmap(PARSE_EFI, val);
 		}
 	}
 
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 481096177500..b3e4d999b913 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -384,23 +384,8 @@ static inline void efi_reserve_boot_services(void)
 }
 #endif /* CONFIG_EFI */
 
-#ifdef CONFIG_EFI_FAKE_MEMMAP
-extern void __init efi_fake_memmap_early(void);
-extern void __init efi_fake_memmap(void);
-#else
-static inline void efi_fake_memmap_early(void)
-{
-}
-
-static inline void efi_fake_memmap(void)
-{
-}
-#endif
-
 extern int __init efi_memmap_alloc(unsigned int num_entries,
 				   struct efi_memory_map_data *data);
-extern void __efi_memmap_free(u64 phys, unsigned long size,
-			      unsigned long flags);
 
 extern int __init efi_memmap_install(struct efi_memory_map_data *data);
 extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 05c5aa951da7..282e8577ac7b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -995,7 +995,6 @@ void __init setup_arch(char **cmdline_p)
 	mem_encrypt_setup_arch();
 	cc_random_init();
 
-	efi_fake_memmap();
 	efi_find_mirror();
 	efi_esrt_init();
 	efi_mokvar_table_init();
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index f090ec972d7b..88a96816de9a 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -226,8 +226,6 @@ int __init efi_memblock_x86_reserve_range(void)
 	if (add_efi_memmap || do_efi_soft_reserve())
 		do_add_efi_memmap();
 
-	efi_fake_memmap_early();
-
 	WARN(efi.memmap.desc_version != 1,
 	     "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
 	     efi.memmap.desc_version);
diff --git a/arch/x86/platform/efi/fake_mem.c b/arch/x86/platform/efi/fake_mem.c
deleted file mode 100644
index 41d57cad3d84..000000000000
--- a/arch/x86/platform/efi/fake_mem.c
+++ /dev/null
@@ -1,197 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * fake_mem.c
- *
- * Copyright (C) 2015 FUJITSU LIMITED
- * Author: Taku Izumi <izumi.taku@jp.fujitsu.com>
- *
- * This code introduces new boot option named "efi_fake_mem"
- * By specifying this parameter, you can add arbitrary attribute to
- * specific memory range by updating original (firmware provided) EFI
- * memmap.
- */
-
-#include <linux/kernel.h>
-#include <linux/efi.h>
-#include <linux/init.h>
-#include <linux/memblock.h>
-#include <linux/types.h>
-#include <linux/sort.h>
-#include <asm/e820/api.h>
-#include <asm/efi.h>
-
-#define EFI_MAX_FAKEMEM CONFIG_EFI_MAX_FAKE_MEM
-
-static struct efi_mem_range efi_fake_mems[EFI_MAX_FAKEMEM];
-static int nr_fake_mem;
-
-static int __init cmp_fake_mem(const void *x1, const void *x2)
-{
-	const struct efi_mem_range *m1 = x1;
-	const struct efi_mem_range *m2 = x2;
-
-	if (m1->range.start < m2->range.start)
-		return -1;
-	if (m1->range.start > m2->range.start)
-		return 1;
-	return 0;
-}
-
-static void __init efi_fake_range(struct efi_mem_range *efi_range)
-{
-	struct efi_memory_map_data data = { 0 };
-	int new_nr_map = efi.memmap.nr_map;
-	efi_memory_desc_t *md;
-	void *new_memmap;
-
-	/* count up the number of EFI memory descriptor */
-	for_each_efi_memory_desc(md)
-		new_nr_map += efi_memmap_split_count(md, &efi_range->range);
-
-	/* allocate memory for new EFI memmap */
-	if (efi_memmap_alloc(new_nr_map, &data) != 0)
-		return;
-
-	/* create new EFI memmap */
-	new_memmap = early_memremap(data.phys_map, data.size);
-	if (!new_memmap) {
-		__efi_memmap_free(data.phys_map, data.size, data.flags);
-		return;
-	}
-
-	efi_memmap_insert(&efi.memmap, new_memmap, efi_range);
-
-	/* swap into new EFI memmap */
-	early_memunmap(new_memmap, data.size);
-
-	efi_memmap_install(&data);
-}
-
-void __init efi_fake_memmap(void)
-{
-	int i;
-
-	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
-		return;
-
-	for (i = 0; i < nr_fake_mem; i++)
-		efi_fake_range(&efi_fake_mems[i]);
-
-	/* print new EFI memmap */
-	efi_print_memmap();
-}
-
-static int __init setup_fake_mem(char *p)
-{
-	u64 start = 0, mem_size = 0, attribute = 0;
-	int i;
-
-	if (!p)
-		return -EINVAL;
-
-	while (*p != '\0') {
-		mem_size = memparse(p, &p);
-		if (*p == '@')
-			start = memparse(p+1, &p);
-		else
-			break;
-
-		if (*p == ':')
-			attribute = simple_strtoull(p+1, &p, 0);
-		else
-			break;
-
-		if (nr_fake_mem >= EFI_MAX_FAKEMEM)
-			break;
-
-		efi_fake_mems[nr_fake_mem].range.start = start;
-		efi_fake_mems[nr_fake_mem].range.end = start + mem_size - 1;
-		efi_fake_mems[nr_fake_mem].attribute = attribute;
-		nr_fake_mem++;
-
-		if (*p == ',')
-			p++;
-	}
-
-	sort(efi_fake_mems, nr_fake_mem, sizeof(struct efi_mem_range),
-	     cmp_fake_mem, NULL);
-
-	for (i = 0; i < nr_fake_mem; i++)
-		pr_info("efi_fake_mem: add attr=0x%016llx to [mem 0x%016llx-0x%016llx]",
-			efi_fake_mems[i].attribute, efi_fake_mems[i].range.start,
-			efi_fake_mems[i].range.end);
-
-	return *p == '\0' ? 0 : -EINVAL;
-}
-
-early_param("efi_fake_mem", setup_fake_mem);
-
-void __init efi_fake_memmap_early(void)
-{
-	int i;
-
-	/*
-	 * The late efi_fake_mem() call can handle all requests if
-	 * EFI_MEMORY_SP support is disabled.
-	 */
-	if (!efi_soft_reserve_enabled())
-		return;
-
-	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
-		return;
-
-	/*
-	 * Given that efi_fake_memmap() needs to perform memblock
-	 * allocations it needs to run after e820__memblock_setup().
-	 * However, if efi_fake_mem specifies EFI_MEMORY_SP for a given
-	 * address range that potentially needs to mark the memory as
-	 * reserved prior to e820__memblock_setup(). Update e820
-	 * directly if EFI_MEMORY_SP is specified for an
-	 * EFI_CONVENTIONAL_MEMORY descriptor.
-	 */
-	for (i = 0; i < nr_fake_mem; i++) {
-		struct efi_mem_range *mem = &efi_fake_mems[i];
-		efi_memory_desc_t *md;
-		u64 m_start, m_end;
-
-		if ((mem->attribute & EFI_MEMORY_SP) == 0)
-			continue;
-
-		m_start = mem->range.start;
-		m_end = mem->range.end;
-		for_each_efi_memory_desc(md) {
-			u64 start, end, size;
-
-			if (md->type != EFI_CONVENTIONAL_MEMORY)
-				continue;
-
-			start = md->phys_addr;
-			end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
-
-			if (m_start <= end && m_end >= start)
-				/* fake range overlaps descriptor */;
-			else
-				continue;
-
-			/*
-			 * Trim the boundary of the e820 update to the
-			 * descriptor in case the fake range overlaps
-			 * !EFI_CONVENTIONAL_MEMORY
-			 */
-			start = max(start, m_start);
-			end = min(end, m_end);
-			size = end - start + 1;
-
-			if (end <= start)
-				continue;
-
-			/*
-			 * Ensure each efi_fake_mem instance results in
-			 * a unique e820 resource
-			 */
-			e820__range_remove(start, size, E820_TYPE_RAM, 1);
-			e820__range_add(start, size, E820_TYPE_SOFT_RESERVED);
-			e820__update_table(e820_table);
-		}
-	}
-}
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 6ed1935504b9..061b8ecc71a1 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -30,6 +30,7 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
 	return PFN_PHYS(page_to_pfn(p));
 }
 
+static
 void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
 {
 	if (flags & EFI_MEMMAP_MEMBLOCK) {
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1983fd3bf392..68df27bd71c9 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -781,7 +781,7 @@ static const char *cmdline_memmap_override;
 static efi_status_t parse_options(const char *cmdline)
 {
 	static const char opts[][14] = {
-		"mem=", "memmap=", "efi_fake_mem=", "hugepages="
+		"mem=", "memmap=", "hugepages="
 	};
 
 	for (int i = 0; i < ARRAY_SIZE(opts); i++) {
-- 
2.45.2.627.g7a2c4fd464-goog


