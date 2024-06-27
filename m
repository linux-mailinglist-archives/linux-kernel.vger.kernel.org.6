Return-Path: <linux-kernel+bounces-232753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB3C91ADFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F427B2A2EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851B519AA56;
	Thu, 27 Jun 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mFAFCgGt"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A019E810
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508985; cv=none; b=VD6bcJQ3lpehsFRWBvdShlF69KwAJNbchNOx1GBBIA+uYyQovfTnGVcnpTefZ+6J+Ne7dy3Cs81tttOlw+P8DljIxZ2tTHmg3yR9s4rt87SoBxGy/G9Ax5IoA93WE/QwU6RWhErLw8yL5pu8N8z5nYelbEU4Slm+0K6kjJCmfrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508985; c=relaxed/simple;
	bh=JXXlPXccbyhFcGcATRCSAgEZbpc1SuYgHVtnO5FsXLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ejVgm/zEy2ubNEJu0vbC+XVfnly3Cs2D0DfhHSSBU4XYxyPRss9JW90Ip9usnKr1fKdgC0B+UcCDNQAoli7YDW4IYGL3p0avW6EZRCoIhvnJ3cpZSOW/aAzWSCo7G+x5Y3NVfBIJH82iOvGhIwnzoN24jBgdoiPADDfc1mGNrq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mFAFCgGt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-706683e5249so4501375b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719508983; x=1720113783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBy/I5g30Afg6Ip53Uvr05h0yboT8uG6AlPNhdgJavA=;
        b=mFAFCgGtjaj6xVdG2+9CdLwMKf4C7PHRt6WS5l6Uor7mYQSAikozRYC2Q4RFsFUyRA
         f+1wjBrtxEwcqxYcZT0FdjrKRuPj+7usaBdTZ8pYEVVZb3+uWUhgnGyVdrzNocnKp/ar
         /slQATET1tVkBPd5KmjwDpQtLU56XgZWp3O3EkRIP0NtRmFYdngYqzJYfdTIXt3g4/ca
         4zlxTs4Tj43a8YZrlk7kwq1i1tb2MY1chI1ANUyS65tdUeG9p3h1CbujchKaxkrYbwcj
         LS1Qp1eJcXc0+VjtTpkn5y/J0uPtoH3DdyV+FKIsHPTsFuVNy02XpdTCFpszCU+/9RyA
         MaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508983; x=1720113783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBy/I5g30Afg6Ip53Uvr05h0yboT8uG6AlPNhdgJavA=;
        b=QQOZB0/GkBa0loRLzfjsorZ02n9eIdj7jEtiIa86e4mJ6yCQ0gDvA+fIjesLdwBbcf
         F9B+DTOInKeqUXyYCFf46gIuhwV8w2tUhQJecGqWX9zOc2J9boIJUo8SpcZncMD4R5uz
         03hnt0429d5+N47A3FHv1hajoXbGS5CVXtiKPK2yRQQfBIQSKHkIblsT/HzNJM28xiX5
         6rLRwSDzCt2sBOmoVtzhm6cd8s6OjsBkwHDaffh8HfQldRxkPH8idovr88J8A76zquZT
         EPyOIhMWu+wnAHCP+Qp3T//5JJI/iWGGPHf+PDU33/V3HoE0DCg8fEMAUKkbRuQ3nNae
         ctVA==
X-Forwarded-Encrypted: i=1; AJvYcCUKZQ0OG3RgtZ5FwSReCZ8gdRkUP24f3Z6pFphVdkO6kHCDKVMpfLkUucXAXHAcU23CcPHPCzQIyuNvlaKFKn9Yywz6jUlu4QdyiNf9
X-Gm-Message-State: AOJu0YxxU62Vo8/Ma1NaTBlgc7pQh6uum3RolSvVYWDM3ZNEfQj5d/Vt
	UjVohrrzrcWt+DtEnn8BISkwJ+H6mX7yEx0oc8hml1WXFgrGQWWxZPF7zivqQP0=
X-Google-Smtp-Source: AGHT+IHNzwD75G4DCcfJ5H0IAezjiX7N7H3o7hyu24co/DPv8hD7Ygm2LVOFxEE4oALKKKYJb0dY1A==
X-Received: by 2002:a05:6a00:1d1d:b0:706:61cc:577f with SMTP id d2e1a72fcca58-70674548227mr16032428b3a.3.1719508982671;
        Thu, 27 Jun 2024 10:23:02 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a58847sm1617843b3a.186.2024.06.27.10.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:23:02 -0700 (PDT)
From: Evan Green <evan@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Yangyu Chen <cyy@cyyself.name>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Erick Archer <erick.archer@gmx.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 2/2] RISC-V: hwprobe: Add SCALAR to misaligned perf defines
Date: Thu, 27 Jun 2024 10:22:38 -0700
Message-Id: <20240627172238.2460840-3-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627172238.2460840-1-evan@rivosinc.com>
References: <20240627172238.2460840-1-evan@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for misaligned vector performance hwprobe keys, rename
the hwprobe key values associated with misaligned scalar accesses to
include the term SCALAR. Leave the old defines in place to maintain
source compatibility.

This change is intended to be a functional no-op.

Signed-off-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

---

Changes in v3:
 - Leave the old defines in place (Conor, Palmer)

Changes in v2:
 - Added patch to rename misaligned perf key values (Palmer)

 Documentation/arch/riscv/hwprobe.rst       | 14 +++++++-------
 arch/riscv/include/uapi/asm/hwprobe.h      |  5 +++++
 arch/riscv/kernel/sys_hwprobe.c            | 10 +++++-----
 arch/riscv/kernel/traps_misaligned.c       |  6 +++---
 arch/riscv/kernel/unaligned_access_speed.c | 12 ++++++------
 5 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 7121a00a8464..0d14e9d83a78 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -243,23 +243,23 @@ The following keys are defined:
   the performance of misaligned scalar native word accesses on the selected set
   of processors.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
-    accesses is unknown.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN`: The performance of
+    misaligned accesses is unknown.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses are
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED`: Misaligned accesses are
     emulated via software, either in or below the kernel.  These accesses are
     always extremely slow.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned native word
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW`: Misaligned native word
     sized accesses are slower than the equivalent quantity of byte accesses.
     Misaligned accesses may be supported directly in hardware, or trapped and
     emulated by software.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned native word
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_FAST`: Misaligned native word
     sized accesses are faster than the equivalent quantity of byte accesses.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
-    not supported at all and will generate a misaligned address fault.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED`: Misaligned accesses
+    are not supported at all and will generate a misaligned address fault.
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 7ebb2f2cc4cf..bcb2d91241d5 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -80,6 +80,11 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
 #define RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF	7
+#define		RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN		0
+#define		RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED	1
+#define		RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW		2
+#define		RISCV_HWPROBE_MISALIGNED_SCALAR_FAST		3
+#define		RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED	4
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index b18639020c61..d5541f6c843e 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -176,13 +176,13 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
 			perf = this_perf;
 
 		if (perf != this_perf) {
-			perf = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+			perf = RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
 			break;
 		}
 	}
 
 	if (perf == -1ULL)
-		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+		return RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
 
 	return perf;
 }
@@ -190,12 +190,12 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
 static u64 hwprobe_misaligned(const struct cpumask *cpus)
 {
 	if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS))
-		return RISCV_HWPROBE_MISALIGNED_FAST;
+		return RISCV_HWPROBE_MISALIGNED_SCALAR_FAST;
 
 	if (IS_ENABLED(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS) && unaligned_ctl_available())
-		return RISCV_HWPROBE_MISALIGNED_EMULATED;
+		return RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
 
-	return RISCV_HWPROBE_MISALIGNED_SLOW;
+	return RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW;
 }
 #endif
 
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index b62d5a2f4541..192cd5603e95 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -338,7 +338,7 @@ int handle_misaligned_load(struct pt_regs *regs)
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
 #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
-	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
+	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
 #endif
 
 	if (!unaligned_enabled)
@@ -532,13 +532,13 @@ static bool check_unaligned_access_emulated(int cpu)
 	unsigned long tmp_var, tmp_val;
 	bool misaligned_emu_detected;
 
-	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+	*mas_ptr = RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
 
 	__asm__ __volatile__ (
 		"       "REG_L" %[tmp], 1(%[ptr])\n"
 		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
 
-	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
+	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED);
 	/*
 	 * If unaligned_ctl is already set, this means that we detected that all
 	 * CPUS uses emulated misaligned access at boot time. If that changed
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index a9a6bcb02acf..160628a2116d 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -34,9 +34,9 @@ static int check_unaligned_access(void *param)
 	struct page *page = param;
 	void *dst;
 	void *src;
-	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
+	long speed = RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW;
 
-	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN)
 		return 0;
 
 	/* Make an unaligned destination buffer. */
@@ -95,14 +95,14 @@ static int check_unaligned_access(void *param)
 	}
 
 	if (word_cycles < byte_cycles)
-		speed = RISCV_HWPROBE_MISALIGNED_FAST;
+		speed = RISCV_HWPROBE_MISALIGNED_SCALAR_FAST;
 
 	ratio = div_u64((byte_cycles * 100), word_cycles);
 	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
 		cpu,
 		ratio / 100,
 		ratio % 100,
-		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
+		(speed == RISCV_HWPROBE_MISALIGNED_SCALAR_FAST) ? "fast" : "slow");
 
 	per_cpu(misaligned_access_speed, cpu) = speed;
 
@@ -110,7 +110,7 @@ static int check_unaligned_access(void *param)
 	 * Set the value of fast_misaligned_access of a CPU. These operations
 	 * are atomic to avoid race conditions.
 	 */
-	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
+	if (speed == RISCV_HWPROBE_MISALIGNED_SCALAR_FAST)
 		cpumask_set_cpu(cpu, &fast_misaligned_access);
 	else
 		cpumask_clear_cpu(cpu, &fast_misaligned_access);
@@ -188,7 +188,7 @@ static int riscv_online_cpu(unsigned int cpu)
 	static struct page *buf;
 
 	/* We are already set since the last check */
-	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN)
 		goto exit;
 
 	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
-- 
2.34.1


