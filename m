Return-Path: <linux-kernel+bounces-281588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B4794D879
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553AB1C21EBC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8335C16A95A;
	Fri,  9 Aug 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zNtIM36j"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201816CD13
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723239904; cv=none; b=W9TpkCor9pRIk2cjomuy5AiUilSvA08HywHNMeMCWoliwLadlAZjCLawiyQxsED0SsCJrM7zRdCMrz5rXtpWuKzzb0tRgakDbU5xmQtoV+CxcInBoE6bFmL7pLS6Ioc+VMjn40AlE3mJ4LhU/2+BZtxFgq8TuPje7LyLTHK5iQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723239904; c=relaxed/simple;
	bh=XTRmOUa+fj32e3IKxchOkfKJBGOFkBhbExnSrLWAPEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kj6UGoGn5mcDjD38OP83Qs+AUT65wl3L+eqxXNf0Upt/2FMwZo7nQpOISigRvUx4fAKJ7odW++31DS6ZWM06oUMvqmvD/KsoxOH9ySV0Lwcl/QQzsgkhe71fisYnF9QYPd8sFT5TuNNU2gGLrob2CSNOjHA4ZepwAZcJszACyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zNtIM36j; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc692abba4so22413695ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 14:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723239902; x=1723844702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Py63dN9Cyk4F4VNdUn5bUyFD7ir6dWa470OTbK+T4Q=;
        b=zNtIM36jZ7kef/Tg3kRuzjpBj5HILdgDh53+pqhckxCEEA7s3fgoEcrN76Tg9nUt1A
         cT2xEbwPCm5obq9WWI4P1V3t2oHpJrPZmCAEW+/+k2tLvrFN/RJMEF2/ddiLY8mfzSz3
         cgF9it/YjOSuEFNEnJPWEkly6t0G0s05H3Ij4g+A0qPWwRNeCAzs62+2yVGjrgna5WKf
         5PbaZNcSl+GVgyc6qfrEoOH630WooW04aKkIlhduSwYbM+nn+89QjJlg2bHv/6YfG1Ut
         JmYEjQt3s9G0U0pRkTnCebQYUaGjXSRLDgvptVF8oOFd772Y1lBdJGfXntX/eE6Pz5zw
         sXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723239902; x=1723844702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Py63dN9Cyk4F4VNdUn5bUyFD7ir6dWa470OTbK+T4Q=;
        b=IasZwERq+2ntTD3zLNDN+0BRjPafQgHN3GZiIngjNMY6ixYYTgx3cvO+u9MoHqfOOt
         lkfwcOHTZARpPVccXNkiF7PKFUzbq98FhZaZB8Ktb+ASnNcWQqICSAOG6nouY6AJVNM9
         d3+JT81ZFbmjLo/TFyx8ZV/KMp+jwc5kVrTFEUpQG7qdoXllbjINEPomr27Wr7Q0o7Jr
         Wg0S5us7RcqqXMPz3HjJhXusapMCnfGKOqYw+sSNTENd+ga+sCLiQtVCDvHt5zuN9W6s
         lqZZtWevFQOTXW1akTXbLd3svVwfHIUlT4uS5x8GeQMES7GwOdOIL1AeNnFIb6gsy6Hm
         e4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUJq6pHeH0/wJjf1pjcI3NU8HAtctU5kTbTr6BqoNOIgNmuPZXyTrFEGVZ3b/S3Goi+TYp0peNX7kzy+NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbTYjVS0Z2NjRijJreEzSimyu4bupW2K5VJlObHk6BMDD1yU5
	cTo6gOXNAa13tMmvdZz4Q/0g3mQZujReAYgCrYRfUrAyUwyA7sXjuSsa4tkzf5c=
X-Google-Smtp-Source: AGHT+IFjDZgbJQsKw0eK2fTkldjulQaz92a71XFZ9dmavytbJZRanoXcfYvEgZjb23iSdRpUxDXggQ==
X-Received: by 2002:a17:902:d48c:b0:1fc:5462:7eb7 with SMTP id d9443c01a7336-200ae5dd1c1mr37420745ad.58.1723239902113;
        Fri, 09 Aug 2024 14:45:02 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb7e93fesm2073905ad.43.2024.08.09.14.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 14:45:01 -0700 (PDT)
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
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/2] RISC-V: hwprobe: Add SCALAR to misaligned perf defines
Date: Fri,  9 Aug 2024 14:44:44 -0700
Message-Id: <20240809214444.3257596-3-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809214444.3257596-1-evan@rivosinc.com>
References: <20240809214444.3257596-1-evan@rivosinc.com>
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

Changes in v4:
 - Add the word scalar (Charlie)

Changes in v3:
 - Leave the old defines in place (Conor, Palmer)

Changes in v2:
 - Added patch to rename misaligned perf key values (Palmer)

 Documentation/arch/riscv/hwprobe.rst       | 28 ++++++++++++----------
 arch/riscv/include/uapi/asm/hwprobe.h      |  5 ++++
 arch/riscv/kernel/sys_hwprobe.c            | 10 ++++----
 arch/riscv/kernel/traps_misaligned.c       |  6 ++---
 arch/riscv/kernel/unaligned_access_speed.c | 12 +++++-----
 5 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index a994eed75bde..85b709257918 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -247,23 +247,25 @@ The following keys are defined:
   the performance of misaligned scalar native word accesses on the selected set
   of processors.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
-    accesses is unknown.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN`: The performance of
+    misaligned scalar accesses is unknown.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses are
-    emulated via software, either in or below the kernel.  These accesses are
-    always extremely slow.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED`: Misaligned scalar
+    accesses are emulated via software, either in or below the kernel.  These
+    accesses are always extremely slow.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned native word
-    sized accesses are slower than the equivalent quantity of byte accesses.
-    Misaligned accesses may be supported directly in hardware, or trapped and
-    emulated by software.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW`: Misaligned scalar native
+    word sized accesses are slower than the equivalent quantity of byte
+    accesses. Misaligned accesses may be supported directly in hardware, or
+    trapped and emulated by software.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned native word
-    sized accesses are faster than the equivalent quantity of byte accesses.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_FAST`: Misaligned scalar native
+    word sized accesses are faster than the equivalent quantity of byte
+    accesses.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
-    not supported at all and will generate a misaligned address fault.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED`: Misaligned scalar
+    accesses are not supported at all and will generate a misaligned address
+    fault.
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 635753084275..1e153cda57db 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -83,6 +83,11 @@ struct riscv_hwprobe {
 #define RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS	7
 #define RISCV_HWPROBE_KEY_TIME_CSR_FREQ	8
 #define RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF	9
+#define		RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN		0
+#define		RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED	1
+#define		RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW		2
+#define		RISCV_HWPROBE_MISALIGNED_SCALAR_FAST		3
+#define		RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED	4
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 2d0f4f6a32c3..cea0ca2bf2a2 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -178,13 +178,13 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
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
@@ -192,12 +192,12 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
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


