Return-Path: <linux-kernel+bounces-180385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8CF8C6DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D42B22AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19DF15B574;
	Wed, 15 May 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vimvsSMt"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52B15B54A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715808394; cv=none; b=Lv4RcVig6OzjeH3CVsxysYvpABCPFQocOu3mKrkA3UDjqaqhat9gatDRzAaqbywq+Hb0NcCVy3I18HxBmOjCYraaFb+fyqci8ymGWDnj8MAqWojd9XULWKvkbyfU7cb2Gv4nZf1r7RFlw/YzPX47l8MPjp3rm7a8T+gx0M2qWiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715808394; c=relaxed/simple;
	bh=OKCBEgWtvD/dlocxKHXhgf3xa7jUJx2ld8oCeMzEsKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWchn4DfvZ4UC1LX7AXxuD9JRiSmneTpTgGG/Sd//ajgjZ0+LyMpvajXLktba5blheRocU+CV0oIfliTOcHxU3rcvrxpo2rom/4VI3jmjjHVdC3i4KhVUxVM4gYvaatkEFfXEA0Hku1K4jA7CXBOb+6uvtfCl9/lB5eUeAcK8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vimvsSMt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f4dcc3eeb3so4316226b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715808392; x=1716413192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEtMpcdozCEaninIMfDtv7U6J6lXws967E7oEWhvO1w=;
        b=vimvsSMt5xVjzfvihMjGprVdCbZFIUeFqwfKI0Rrk3op3SfuEt5EQNyxniSilkYeuf
         LJfFfAL7bmz6mi2GRV2odqOLZwbmUyQONJKP6ZNDkZ/PBPhkjpb9lhHH+ImWeKh/oLW7
         gTJdqIEYoDiM5LQVRg8LA+46b+L9YvP6tz4qc9hng/BE5b7MPqDZJfWOb4kOAuT5WrIg
         4miZTXlgX4P5VrlhJ8P/H3B6mna9oUUXOreGSfNvoTn26kYxgZs6S+ApAcqoX0fGYjTH
         oSDWW9JHSA0ZXLzHF4o9KF7lAvBy51PsFFcbKAk8uY2QRBo5AHO7DOQVQCeqNY/rA/ZO
         G5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715808392; x=1716413192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEtMpcdozCEaninIMfDtv7U6J6lXws967E7oEWhvO1w=;
        b=kSfx8cOEeyTIz+bQnDrbd53duTnH/co+9v1eznDfCgMmn14W9JWM2C1aSaKSIMlRse
         rgGTcPOr8N4JLk/wiQovWFbZhpteIwptXhP4nWbUcW7w1xKmvEkewatXnTUrt1IUk1Yj
         dGvN6O5hf5vC03flCThC2J0/uLtv6ANQzjD1QB7EtwwwmBo9oSit8Yoc+UeTOefx3jQZ
         bMu5ujhtggowmnomArG1kHGR+F6/QNOmUUMw9w+NH83KcFCNJVagputMlfB1DEITk8bp
         KU0gCYDr5uljARPbOrpcmPfXWJTtCxsWb+g/6ZURzgw4cQi8RLXvc9/hdI3smtpsHnkj
         MiZA==
X-Forwarded-Encrypted: i=1; AJvYcCXmMdZ6ob5er0DG9cbvESiNGMjsDVNmiVMMk2Ipp89gjtMU32Xq7KEnKR2QlYWj9fKXWu+vnQMiEHAW4+qRqFsUGv5xIJYQ5nboT2xQ
X-Gm-Message-State: AOJu0Yy/PwuwvyFJOCRwlhJFlQ+/2DPfl61GbxkGSyfO3++vyQpviXYK
	aKQRUIJiwg9P5PhdwmZigzHNpq7G07vU/ryfFR6XKvsMndRCVaA1Je0pWo8gjQY=
X-Google-Smtp-Source: AGHT+IH32uaq8x0M23Tv8aymfxEIe1JpiMLVWwzdsi9eZUgeqENJpbM71PeLSvsro24FgpBWkZWJRQ==
X-Received: by 2002:a05:6a00:2e17:b0:6f4:b20e:a08a with SMTP id d2e1a72fcca58-6f4e039ccc8mr19686275b3a.29.1715808391671;
        Wed, 15 May 2024 14:26:31 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b30sm11970243b3a.146.2024.05.15.14.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:26:30 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 15 May 2024 14:26:14 -0700
Subject: [PATCH 2/4] riscv: Add vendor extensions to /proc/cpuinfo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-support_vendor_extensions-v1-2-b05dd5ea7d8d@rivosinc.com>
References: <20240515-support_vendor_extensions-v1-0-b05dd5ea7d8d@rivosinc.com>
In-Reply-To: <20240515-support_vendor_extensions-v1-0-b05dd5ea7d8d@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715808387; l=2560;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=OKCBEgWtvD/dlocxKHXhgf3xa7jUJx2ld8oCeMzEsKY=;
 b=iVnq6S9cngstY5V0ai8u5yiNu0mhiLAza0dQF0qiCbRzE8O40tFTOCPpI+zsVRkmZSd4Zmfjp
 ixRuEWJTst9AkcEb/cwrQYQLxxZjvja+BhQzAjvDyoxXMwklkVermz8
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

All of the supported vendor extensions that have been listed in
riscv_isa_vendor_ext_list can be exported through /proc/cpuinfo.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpu.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index d11d6320fb0d..2a7924dd809b 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -16,6 +16,7 @@
 #include <asm/sbi.h>
 #include <asm/smp.h>
 #include <asm/pgtable.h>
+#include <asm/vendor_extensions.h>
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
@@ -203,7 +204,33 @@ arch_initcall(riscv_cpuinfo_init);
 
 #ifdef CONFIG_PROC_FS
 
-static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
+#define ALL_CPUS -1
+
+static void print_vendor_isa(struct seq_file *f, int cpu)
+{
+	struct riscv_isavendorinfo *vendor_bitmap;
+	struct riscv_isa_vendor_ext_data_list *ext_list;
+	const struct riscv_isa_ext_data *ext_data;
+
+	for (int i = 0; i < riscv_isa_vendor_ext_list_size; i++) {
+		ext_list = riscv_isa_vendor_ext_list[i];
+		ext_data = riscv_isa_vendor_ext_list[i]->ext_data;
+
+		if (cpu == ALL_CPUS)
+			vendor_bitmap = &ext_list->all_harts_isa_bitmap;
+		else
+			vendor_bitmap = &ext_list->per_hart_isa_bitmap[cpu];
+
+		for (int j = 0; j < ext_list->ext_data_count; j++) {
+			if (!__riscv_isa_extension_available(vendor_bitmap->isa, ext_data[j].id))
+				continue;
+
+			seq_printf(f, "_%s", ext_data[j].name);
+		}
+	}
+}
+
+static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap, int cpu)
 {
 
 	if (IS_ENABLED(CONFIG_32BIT))
@@ -222,6 +249,8 @@ static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
 		seq_printf(f, "%s", riscv_isa_ext[i].name);
 	}
 
+	print_vendor_isa(f, cpu);
+
 	seq_puts(f, "\n");
 }
 
@@ -284,7 +313,7 @@ static int c_show(struct seq_file *m, void *v)
 	 * line.
 	 */
 	seq_puts(m, "isa\t\t: ");
-	print_isa(m, NULL);
+	print_isa(m, NULL, ALL_CPUS);
 	print_mmu(m);
 
 	if (acpi_disabled) {
@@ -306,7 +335,7 @@ static int c_show(struct seq_file *m, void *v)
 	 * additional extensions not present across all harts.
 	 */
 	seq_puts(m, "hart isa\t: ");
-	print_isa(m, hart_isa[cpu_id].isa);
+	print_isa(m, hart_isa[cpu_id].isa, cpu_id);
 	seq_puts(m, "\n");
 
 	return 0;

-- 
2.44.0


