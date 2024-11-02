Return-Path: <linux-kernel+bounces-393055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E949B9B6C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E628B213BA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19946F305;
	Sat,  2 Nov 2024 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C9gJJ22o"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0DE5258
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506129; cv=none; b=Cr4RN/WSwlmJFCb0EXmiZ1mNFALBKYnS1G1iu1dOnGRq45CTaXWk8D8V7W2Qrql2MvDOyOVg0Z+D4GGfVmRAvhPKAEiy4St6PgdLx1I7z5f8gioboNeyPwHepWb2SWIIf5a17mRJ2AZPaX2FsQr7jXQSqiuTLi9O1qZI0S9GWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506129; c=relaxed/simple;
	bh=/bl3es7BCibMRvBCdVirx67zoOC9ya6FAPFh3kyjTqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQX5Fa/2yhZ8RLPCPcx01dYXTLbaN8DsRk7vz8OmXFglEV+QKvlEfLuO8zCt7niAyiDkgBVtWriUhW4/O6rZtqz2s0JzC1jSPkzB815ZeLTOcLzzw88Wb3YKb3Jq2a3mqCKxMJ89SqqrrT++GPN5HYqtu0yUvYrK8x/QDt+6F+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=C9gJJ22o; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2ed59a35eso1990393a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730506127; x=1731110927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOEMNZ+33viJM90wJhw0Ad72Zh5qPAKNdSNu0KRw6Xo=;
        b=C9gJJ22o/begA8ZA68J6fz8ja8yaeLMPKS2IChg59LxxvBDtmTLiwve0uL4rR+05u2
         YMEqX+IA+/hpQJ6DzhDMF3w+nQ3S6yMKI1ErbdbV4YUZNUtKmmYjZ6W1q/+5T3olrZqH
         gzEUNdqEaYGfExKoE0SrQ7JYNF5rcSRJhuBodeoLpGLuWvhfr/FAZbbk6L2+f0EslpVq
         EtUGeR/i3hIphrowOXVxSZNCxVbwfuRDuUyLk06kXDAnJ1BptU2UtOgAheGRaNgCITRt
         Fqn0BS8Aa6db9bsP2nQ9S9EkkkID2J+pVFNbwicGwyVGDg9xyhUVMoB4LATOpsxIBUcf
         A8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506127; x=1731110927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOEMNZ+33viJM90wJhw0Ad72Zh5qPAKNdSNu0KRw6Xo=;
        b=Bx9aNHKDGdjgk/Byd7lrYUvkPfbD59s0BJVi5s0PtZFTJgEIFx1DWpgsF7E6Dk+vVP
         trngZjxM2R6zUU7izUdhkSLtN5Yg8ohcQ1RNaEfPJCq+27b+Joks4Cr+my85nqKK50DB
         +iyfbo/6dGrfdAjiRFOqb3reVWdvxYP1xv0uWWqb6DNkB2fH360wuidrDAM0ZUKAMeBf
         PSCCD+MFxVxfkoBEMHCEqTN78LpioVYtOjz9rNEpJgsSzL2hzUnDMlDzr1k2YRxTZSX4
         dW0yyZ78MQLLlpug2aNAnH/oCa629bsAy+Roj5fQHXEYmpFK5mMn1ukATOZhxDngJB2/
         6ZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDYv0vEDwpdEcmWrm/OMHQ2+qR75pfmulSpqcheKAQgt2v++mDc59kLlGDQQBDxODxEoNkxceYlyne1GY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7/3koKCRSGXjS4vmkk9DVpwJSuNFWeFhYFXpGz8MseBc134v
	snGjGj6KpdCef2NneEQlqZQIHB8cJkdVXuXY/FPQkhYl5gZcrIhzxeiGOynTmcg=
X-Google-Smtp-Source: AGHT+IE6EkC5NIMo5m4ZPw7HiXuYchFGSfyQgkFEdoKuXEzVgx9eOAQYjDGPGRWM5i/c7czbrOnwSQ==
X-Received: by 2002:a17:90a:f406:b0:2e0:d693:7884 with SMTP id 98e67ed59e1d1-2e8f0f55a2bmr27105930a91.5.1730506127517;
        Fri, 01 Nov 2024 17:08:47 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fc00856sm5505749a91.54.2024.11.01.17.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:08:47 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 01/11] dt-bindings: riscv: Describe physical memory regions
Date: Fri,  1 Nov 2024 17:07:55 -0700
Message-ID: <20241102000843.1301099-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241102000843.1301099-1-samuel.holland@sifive.com>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Information about physical memory regions is needed by both the kernel
and M-mode firmware. For example, the kernel needs to know about
noncacheable aliases of cacheable memory in order to allocate coherent
memory pages for DMA. M-mode firmware needs to know about aliases so it
can protect itself from lower-privileged software. Firmware also needs
to know the platform's Physical Address Width in order to efficiently
implement Smmpt.

The RISC-V Privileged Architecture delegates the description of Physical
Memory Attributes to the platform. On DT-based platforms, it makes sense
to put this information in the devicetree.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 .../bindings/riscv/physical-memory.yaml       | 101 ++++++++++++++++++
 include/dt-bindings/riscv/physical-memory.h   |  44 ++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/physical-memory.yaml
 create mode 100644 include/dt-bindings/riscv/physical-memory.h

diff --git a/Documentation/devicetree/bindings/riscv/physical-memory.yaml b/Documentation/devicetree/bindings/riscv/physical-memory.yaml
new file mode 100644
index 000000000000..deb49b34672f
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/physical-memory.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/physical-memory.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Physical Memory Regions
+
+maintainers:
+  - Samuel Holland <samuel.holland@sifive.com>
+
+description:
+  The RISC-V Privileged Architecture defines a number of Physical Memory
+  Attributes (PMAs) which apply to a given region of memory. These include the
+  types of accesses (read, write, execute, LR/SC, and/or AMO) allowed within
+  a region, the supported access widths and alignments, the cacheability and
+  coherence of the region, and whether or not accesses to the region may have
+  side effects.
+
+  Some RISC-V platforms provide multiple physical address mappings for main
+  memory or certain peripherals. Each alias of a region generally has different
+  PMAs (e.g. cacheable vs non-cacheable), which allows software to dynamically
+  select the PMAs for an access by referencing the corresponding alias.
+
+  The RISC-V Supervisor Domains specification defines a platform-specific
+  Physical Address Width (PAW), which describes the largest physical address
+  supported by a platform. Any access to an address >= 2^PAW is guaranteed to
+  raise an access fault, and therefore metadata (e.g. Memory Protection Tables)
+  need not be maintained for those addresses.
+
+  On DT-based RISC-V platforms, all of this information is provided by the
+  riscv,physical-memory-regions property of the root node.
+
+properties:
+  $nodename:
+    const: '/'
+
+  riscv,physical-memory-regions:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description:
+      A table of physical memory regions. The first entry in the table must
+      cover the entire range of physical addresses supported by the platform
+      (i.e. 0 to 2^PAW-1) and provides the default PMAs for all addresses not
+      covered by another table entry. Remaining table entries provide PMAs for
+      more specific physical memory regions, which must be contained within the
+      range of entry 0, but which must not overlap with each other.
+    minItems: 1
+    maxItems: 256
+    items:
+      minItems: 4
+      maxItems: 6
+      additionalItems: true
+      items:
+        - description: CPU physical address (#address-cells)
+        - description: >
+            Size (#size-cells). For entry 0, if the size is zero, the size is
+            assumed to be 2^(32 * #size-cells).
+        - description: >
+            Flags describing the most restrictive PMAs for any address within
+            the region.
+
+            The least significant byte indicates the types of accesses allowed
+            for this region. Note that a memory region may support a type of
+            access (e.g. AMOs) even if the CPU does not.
+
+            The next byte describes the cacheability, coherence, idempotency,
+            and ordering PMAs for this region. It also includes a flag to
+            indicate that accesses to a region are unsafe and must be
+            prohibited by software (for example using PMPs or Smmpt).
+
+            The third byte is reserved for future PMAs.
+
+            The most significant byte is the index of the lowest-numbered entry
+            which this entry is an alias of, if any. Aliases need not be the
+            same size, for example if a smaller memory region repeats within a
+            larger alias.
+        - description: Reserved for describing future PMAs
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/riscv/physical-memory.h>
+
+    / {
+      compatible = "starfive,jh7100";
+      #address-cells = <2>;
+      #size-cells = <2>;
+      riscv,physical-memory-regions =
+          <0x00 0x00000000 0x40 0x00000000 (PMA_RW | PMA_IO) 0x0>,
+          <0x00 0x18000000 0x00 0x00020000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY) 0x0>,
+          <0x00 0x18080000 0x00 0x00020000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY) 0x0>,
+          <0x00 0x41000000 0x00 0x1f000000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY) 0x0>,
+          <0x00 0x61000000 0x00 0x1f000000 (PMA_RWXA | PMA_NONCOHERENT_MEMORY | PMR_ALIAS(3)) 0x0>,
+          <0x00 0x80000000 0x08 0x00000000 (PMA_RWXA | PMA_NONCOHERENT_MEMORY) 0x0>,
+          <0x10 0x00000000 0x08 0x00000000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY | PMR_ALIAS(5)) 0x0>,
+          <0x20 0x00000000 0x10 0x00000000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY) 0x0>,
+          <0x30 0x00000000 0x10 0x00000000 (PMA_RWXA | PMA_NONCOHERENT_MEMORY | PMR_ALIAS(7)) 0x0>;
+    };
+
+...
diff --git a/include/dt-bindings/riscv/physical-memory.h b/include/dt-bindings/riscv/physical-memory.h
new file mode 100644
index 000000000000..7cb2e58fa8c1
--- /dev/null
+++ b/include/dt-bindings/riscv/physical-memory.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RISCV_PHYSICAL_MEMORY_H
+#define _DT_BINDINGS_RISCV_PHYSICAL_MEMORY_H
+
+#define PMA_READ			(1 << 0)
+#define PMA_WRITE			(1 << 1)
+#define PMA_EXECUTE			(1 << 2)
+#define PMA_AMO_MASK			(3 << 4)
+#define PMA_AMO_NONE			(0 << 4)
+#define PMA_AMO_SWAP			(1 << 4)
+#define PMA_AMO_LOGICAL			(2 << 4)
+#define PMA_AMO_ARITHMETIC		(3 << 4)
+#define PMA_RSRV_MASK			(3 << 6)
+#define PMA_RSRV_NONE			(0 << 6)
+#define PMA_RSRV_NON_EVENTUAL		(1 << 6)
+#define PMA_RSRV_EVENTUAL		(2 << 6)
+
+#define PMA_RW				(PMA_READ | PMA_WRITE)
+#define PMA_RWA				(PMA_RW | PMA_AMO_ARITHMETIC | PMA_RSRV_EVENTUAL)
+#define PMA_RWX				(PMA_RW | PMA_EXECUTE)
+#define PMA_RWXA			(PMA_RWA | PMA_EXECUTE)
+
+#define PMA_ORDER_MASK			(3 << 8)
+#define PMA_ORDER_IO_RELAXED		(0 << 8)
+#define PMA_ORDER_IO_STRONG		(1 << 8)
+#define PMA_ORDER_MEMORY		(2 << 8)
+#define PMA_READ_IDEMPOTENT		(1 << 10)
+#define PMA_WRITE_IDEMPOTENT		(1 << 11)
+#define PMA_CACHEABLE			(1 << 12)
+#define PMA_COHERENT			(1 << 13)
+
+#define PMA_UNSAFE			(1 << 15)
+
+#define PMA_IO				(PMA_ORDER_IO_RELAXED)
+#define PMA_NONCACHEABLE_MEMORY		(PMA_ORDER_MEMORY | PMA_READ_IDEMPOTENT | \
+						PMA_WRITE_IDEMPOTENT)
+#define PMA_NONCOHERENT_MEMORY		(PMA_NONCACHEABLE_MEMORY | PMA_CACHEABLE)
+#define PMA_NORMAL_MEMORY		(PMA_NONCOHERENT_MEMORY | PMA_COHERENT)
+
+#define PMR_ALIAS_MASK			(0xff << 24)
+#define PMR_ALIAS(n)			((n) << 24)
+
+#endif /* _DT_BINDINGS_RISCV_PHYSICAL_MEMORY_H */
-- 
2.45.1


