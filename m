Return-Path: <linux-kernel+bounces-257477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31027937A96
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B1928668D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2E5146584;
	Fri, 19 Jul 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ay6K3eYy"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B829D06
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405742; cv=none; b=jVfeSiCgAI3iB7X5vN/nT99FJFKusU6DzPg6tciGm6fjTslvDdrog2YrFwVAeLAfNIz1y+lV0O0KxbbVhvvkgxNDo+zO8cQNqaYsFiZ6GwWJkACZQ0mvHnS129vIX2a+4/FtYKPBg6DpTChOg8mO+U3TyvR/NxH0LTDtaiMCecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405742; c=relaxed/simple;
	bh=jX1rj/5Eo6K4VCkcWXFPVGV22tyIjfGbooFelFlP1yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R75fMnTExJQN8oZ/fDH9XxtRX1HWxfm+GaHEG7KeLRIVbGzZQFuavNOKa7geJb7sOeYTzFYOA1ZFgE3Rlo/tYzT6VhrigCpInrTR5LmBwTrWH5De1aLj4zw8uuIzPNKTAK+radrxf0NkeCKiU3omjt6eHtwmI428Kp8V2rw4gB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ay6K3eYy; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b9776123a3so918815eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721405740; x=1722010540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpjb3e/cwn7NO7Zc46N1APao8n8upBlVj5xz8tHyLtY=;
        b=ay6K3eYyQv/5/zlOA0TftVufR/3xkrK8nvRm9tMk6RyLERy9Xr9JqWuafpuKY/4moQ
         MP6GbwzjZ7qbMaPI3J5r0KvUo+d2uHr9/PqaTtKaLXkh3sBdCPJAvhzrUXpOZcvonf6L
         TEt3ZvYjcefoCFDnDub6LQkZxxnVwJrIKn/dDwDh9PB8yDaV6WrkWMGSyw/Lne95zUXG
         Dg8+e2NYYQM6FG2mjFiLWu+699R6Vko/kwyzjJzZ1sO9JnNPcupOT1ZIYDiYdLoe2467
         QmxIcin5vYpB6Kz2DaHADK+sGZ0AEScHzPGXZi5Va5FZQ+r8Ic9aWOmOHFSp4cA9fcUi
         IP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405740; x=1722010540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpjb3e/cwn7NO7Zc46N1APao8n8upBlVj5xz8tHyLtY=;
        b=FwQG/AgrbZBCzpnBWka/VzPIV5RHqbw4bV+vQBUmyKlPqVs3mEv1MD+9K9EC0xyoB4
         kXlJKN63m2rPlTSw1T7ltO7fXcLP+pUq5Bg83fsK23YUGR4PAAcoqqKP7zto7f48ln3b
         aZpJTyIw7W7I2Mp121kWFoxSoO8TZFk/c+kQByDiXIiXQI1Ib0BCMRWv3IoXM2gWFGUl
         RLPJBrQWFMzptsI0xZHIiFhphRK8r9iZFb91kiDf6k78wf+nIgWUwVZX593wWPJy0GMZ
         IwmKyTW0PjudUI0XJ5kgAKna/pJ2w1mqyWPwNKQS1WAinc5kJ4LYB18lMEriJXsFZ3Gc
         X55g==
X-Forwarded-Encrypted: i=1; AJvYcCXmgHAs9+pxxZWBad8JRHV9fYV/6g8SOofszY7m1wEhOPdHToDUopy1tOLR9FDmJPvDjeyhuR8Ck6sUtDwGJeXsa2/YDocMN6VekiVx
X-Gm-Message-State: AOJu0Yw10Ua5g082vUuhH0MRbcQTSk+wAQPMuErJpbMaZz5dQdHl1uRL
	Pvs3M60Kqer8ef1ERCpg3ti4BQXubsekqaJoqAxwgyegFusL8eJ6L+2jTG/l+jc=
X-Google-Smtp-Source: AGHT+IFoAtt/05zWiwEnh/GR3LUdJjmbVnpR5v+x7lYjPP5dLjhM86KY0E+JfVdgpVZRQ4YdUQ390g==
X-Received: by 2002:a05:6870:148c:b0:25d:f0ba:eab7 with SMTP id 586e51a60fabf-260d91c14eemr7070243fac.18.1721405739971;
        Fri, 19 Jul 2024 09:15:39 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0ad73cc4sm579589a12.29.2024.07.19.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:15:39 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 19 Jul 2024 09:15:19 -0700
Subject: [PATCH v3 2/4] riscv: Add vendor extensions to /proc/cpuinfo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-support_vendor_extensions-v3-2-0af7587bbec0@rivosinc.com>
References: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
In-Reply-To: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721405734; l=2560;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=jX1rj/5Eo6K4VCkcWXFPVGV22tyIjfGbooFelFlP1yQ=;
 b=lhgzvNChjg8kplCDzaODRjelwprExmqYizaI7GahQwX36jwYoLg90IMReAZacNf3LCHSV3OJi
 4i7f2uis6h6DZOqSKfRpKT76WiHAFmjVrX/9dVn+wV7FBGGLky57PIx
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


