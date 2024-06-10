Return-Path: <linux-kernel+bounces-207621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0505E9019CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E48B1C20E87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 04:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0D011723;
	Mon, 10 Jun 2024 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e8aYdic1"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7FB653
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994064; cv=none; b=WJCCyJ5jRnbsAxrLKVOKVFa0msQZvyDtVBGk4W3bUlORJPti+uGbucpW4ogT5bb5xo91IrFzUmpgZGPNLPmK2ugLw8KReTQewg1tb/v3uCUXiX9Xz9Mp5LaknT2GhBOUV+6OMysGYPlFhGRsdpJDTHrylwD5orhY12pxlR3Kl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994064; c=relaxed/simple;
	bh=jX1rj/5Eo6K4VCkcWXFPVGV22tyIjfGbooFelFlP1yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YrZj0x6hqsU9RBBaHPOouH9jGCFZDOv34Tr5FnunUlPZ3vBiAiv13vswNXpcUD5V+TtVL1O9H4w9gvaFUjANQ8FwcBpqLwyjc6C5S/f9beI0DybFh+tEW717P+f9L8QorteJDZWqdGoR2E+gsBTf+JnE/SGPNOjz/vpH6PzaZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e8aYdic1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6818e31e5baso3356070a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 21:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717994062; x=1718598862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpjb3e/cwn7NO7Zc46N1APao8n8upBlVj5xz8tHyLtY=;
        b=e8aYdic1lptvWOTSh641Xez8Xu8EoB+sGH3TCklIpvJ9ngmeJ4xEpvcsEYegwhsB1E
         z6IGTttB6P+6E+0/ij/gogR1xRO5OroNaPW9FPIJfWynZNdZvRKwiajZjG6ks2r39isu
         H+0ukH3UzL1q1uA6eOUjox2M9m1nmCsWa6SRKhoxngE3YVkKqHB61MsWKOUfIgZbMX8X
         ScvVS6iIJ0fwPaHTF8Fd/QsLTBAlvDzSvf39QRA2Vw7KoMip7JiueUj5if76gnVo7Mz9
         qgEvJ2bYxOB6Q3F+24kWewyBkPZVP++pJmJUA9GEtHnQ3h6VA0GCvjEMee9pqRAX7eIK
         itNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994062; x=1718598862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpjb3e/cwn7NO7Zc46N1APao8n8upBlVj5xz8tHyLtY=;
        b=gLfEbVocQm/ei83byZskQqkkJCmn9CbvO+qpdGntzM+IladhTThyyS6PsC/ACpcTfp
         vwHQCvu+52/rZZexQOVSR6OvdfJaHrSS3+eCVVBPifOd6MBw/nRjWysLRzXqcu3ZytZO
         HKPKdbxizUJlOg9Gv0LpaMoQpo2iX0nobVHs2UZxt2ayp+HSsM7M2b0hlgzqBYmxvsjz
         ZIRFbt6acbwCE4GjF/WMtQdbvS0P6L6OPL6F91K2aXivJ5HjM7NJ/h9HVwYnXp7Fs5nH
         2cAD51gjqICGqKsqHAsSYwH5VIiEnc70nccnBtRaaakHQygZ8y5hyT1xtJI8PHmjbuhY
         NJgw==
X-Forwarded-Encrypted: i=1; AJvYcCX/ee8hPHSAvnw7/Wd101liQLiCH91J6ogoedyf3osneaiKT2CTuQZT9EB8v2Pvb8nsxXKHm3LuVuzQ19YzXS3Ya1cpfoUFukzbXigP
X-Gm-Message-State: AOJu0YyHUyEPx0+Zj9GxQB5+zv4DtyvvHqPZel2T7mWCFm3fWWy88LRW
	xQm7VQ1YxXJRZNRO3UWypACbavsKH/tKhf4TvR1HwzTwfsSmK6CGxFcsGSDV6nY=
X-Google-Smtp-Source: AGHT+IG+FJiR8GwWMRcVqRMlspmsP9IMRu8fB6JZlGWawVSImskZdZ+E8TXT701sjPwnXv2NeszQvQ==
X-Received: by 2002:a05:6a20:d043:b0:1b4:4568:4c40 with SMTP id adf61e73a8af0-1b445684d58mr7174790637.12.1717994062670;
        Sun, 09 Jun 2024 21:34:22 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2fe295cf5sm1894756a91.47.2024.06.09.21.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:34:21 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sun, 09 Jun 2024 21:34:15 -0700
Subject: [PATCH v2 2/4] riscv: Add vendor extensions to /proc/cpuinfo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240609-support_vendor_extensions-v2-2-9a43f1fdcbb9@rivosinc.com>
References: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
In-Reply-To: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717994057; l=2560;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=jX1rj/5Eo6K4VCkcWXFPVGV22tyIjfGbooFelFlP1yQ=;
 b=ty36o27Fcnn+ri6LPLaSahNWqUaPMAyATVlOaPFfWk4YvgxmcebiM6fPO7dMnRQFBm0Zor7vR
 MZQSv2/3WpjDWKZA8mMPhVbkpLjRbKfToO0tycFohoJfn0nt1a5+pC2
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
index c1f3655238fd..f6b13e9f5e6c 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -16,6 +16,7 @@
 #include <asm/sbi.h>
 #include <asm/smp.h>
 #include <asm/pgtable.h>
+#include <asm/vendor_extensions.h>
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
@@ -235,7 +236,33 @@ arch_initcall(riscv_cpuinfo_init);
 
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
@@ -254,6 +281,8 @@ static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
 		seq_printf(f, "%s", riscv_isa_ext[i].name);
 	}
 
+	print_vendor_isa(f, cpu);
+
 	seq_puts(f, "\n");
 }
 
@@ -316,7 +345,7 @@ static int c_show(struct seq_file *m, void *v)
 	 * line.
 	 */
 	seq_puts(m, "isa\t\t: ");
-	print_isa(m, NULL);
+	print_isa(m, NULL, ALL_CPUS);
 	print_mmu(m);
 
 	if (acpi_disabled) {
@@ -338,7 +367,7 @@ static int c_show(struct seq_file *m, void *v)
 	 * additional extensions not present across all harts.
 	 */
 	seq_puts(m, "hart isa\t: ");
-	print_isa(m, hart_isa[cpu_id].isa);
+	print_isa(m, hart_isa[cpu_id].isa, cpu_id);
 	seq_puts(m, "\n");
 
 	return 0;

-- 
2.44.0


