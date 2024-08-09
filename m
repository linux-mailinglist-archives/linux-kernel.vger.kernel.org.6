Return-Path: <linux-kernel+bounces-281226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821CB94D494
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DE1285A06
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9D61990A3;
	Fri,  9 Aug 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S3Yf5qXn"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2C1991BD
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220573; cv=none; b=QA+zrdgmL3JHJR16rtdk32D6P6AYRUNYJuBLCClhp88g5SkVcow4UKZQMCNN+d3hJzoQy6VUDuZXQrqXA20SsYBhSfbal9aziOs7T/X68Qur8koBF019wCdTYbDoc8/48thGD64bCADyuRwkeMNtBNtu1pnJ8sI5vZgBE4onr4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220573; c=relaxed/simple;
	bh=/F04v4UBpYu+E0RKI3+Ot84mXLlG+sM2Lwm4bICl/Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkhK7VkBud/z3Lt+EtG4f36yHCZvprFr52ag/8+rGncMjMGIED/7RCb+ymbOXPIsOqc7tyZI8SCnzFy7AvUUievPRcEK+EBrl2ri3w7xJ8rsMxroBvu/KpvKr03LbBfFEjUzdwji6pJTceI2AW43AA54jbJuysfzeDkt8xa7pdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S3Yf5qXn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fdd6d81812so23122825ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723220571; x=1723825371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOQ+OFulXv4+TA+0pLiq5tA7x0FPgkPHgCvbhs6i/1o=;
        b=S3Yf5qXnpHbEsWQs8dc5tYibCfnDik9AbMsUqrL/zCYbEw8C7co32y3PggESASzYQq
         S/JVKzvjFLDN968OV30JIgOKJy+zG1W2pTpmXhF9TwSFIWy79WssGzxHjAU8KMZQgxFw
         pp6Fe7vhgaYq7YsRjR0Wb7JUdfCiMe4mOZJue3wR1Z3jEZ0VxfkIa/P/AVR+3Xyf31GD
         w4YOirFj2i+2xuqsl4CAsz5XS8Trjf16o4Z8sBm+MBC91QA/EzYXyYEWMFcASrVZEOFA
         EdTv96Z1tVV3WxqClNOTzqQcx+1xEgddVSC0jKeou8DQDd4Pi4smdE4mXknlcP500jwh
         1pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723220571; x=1723825371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOQ+OFulXv4+TA+0pLiq5tA7x0FPgkPHgCvbhs6i/1o=;
        b=GCUBr9rrdMLGSzzLXb1EoK4yGkE5wJNDA3ILshROzEzaiac5/aptqpf8Y7Rdcs4hCB
         7PBj8tU2Za5XV/VaYKrb7Xlk3+k7dE+YiW1id+SnB/4ZzZUeccjch2BrBIjfx8TZLWoK
         9s01MmAmRCa3H0PZ58/cuXUXfpjiGanD/IuEiiQQjistxsRPyIPVBVR5N2YtF/IhCL5j
         stHBHhni/LIfRrn/qvAUFU7mMTJgk6xtXHdqnBPCScfwuK+79u4WMB2RR4DqLAZyBTBC
         O6jCYdb75YwGt0Fpx5DS3BzWff5ZQpT/80UKEW+Jzt/WNmcodl71ApnEoqk2vK0yJqFv
         hOOw==
X-Forwarded-Encrypted: i=1; AJvYcCXFlonnWlcx2eGIEbgGE9Pqq6bz8SflGIVk5tkcue97AI0OqeGXIyX3GUO6zHjYeZbqJFJ5GvNHU/0QRj9QT1f9CKgKcIxdBNOpD3Vw
X-Gm-Message-State: AOJu0YxeJTEm9CwcV7EUQaI3vjB37MIx1nTpUQI1UlgdLXKqZQiC6zga
	HJSSj2lnF9nucxZjNyg2pmtJ25J+bR4X7bbdOQ/oQZmfsdqFSp2sp4dZUrvFi3w=
X-Google-Smtp-Source: AGHT+IH3pK0geHF2CHBmpCT69qUwnp2goLvBrxbauCwkdfSz3T1PmQvrfcDDIE7gDo4gS91r+kAHag==
X-Received: by 2002:a17:902:fc46:b0:1fe:d72d:13e9 with SMTP id d9443c01a7336-200ae5154a3mr21892875ad.33.1723220571020;
        Fri, 09 Aug 2024 09:22:51 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200668fc398sm100414505ad.207.2024.08.09.09.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:22:50 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 1/2] RISC-V: Add Zicclsm to cpufeature and hwprobe
Date: Fri,  9 Aug 2024 12:22:39 -0400
Message-ID: <20240809162240.1842373-2-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809162240.1842373-1-jesse@rivosinc.com>
References: <20240809162240.1842373-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Zicclsm Misaligned loads and stores to main memory regions with both
> the cacheability and coherence PMAs must be supported.
> Note:
> This introduces a new extension name for this feature.
> This requires misaligned support for all regular load and store
> instructions (including scalar and vector) but not AMOs or other
> specialized forms of memory access. Even though mandated, misaligned
> loads and stores might execute extremely slowly. Standard software
> distributions should assume their existence only for correctness,
> not for performance.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
---
V1 -> V2:
 - Add documentation for Zicclsm
 - Move Zicclsm to correct location
V2 -> V3:
 - No changes
V3 -> V4:
 - Add definitions to hwprobe.rst
V4 -> V5:
 - No changes
V5 -> V6:
 - No changes
V6 -> V7:
 - No changes
V7 -> V8:
 - Rebase onto 2d1f51d8a4b0 (palmer/for-next)
 - Change commit description
---
 Documentation/arch/riscv/hwprobe.rst  | 5 +++++
 arch/riscv/include/asm/hwcap.h        | 1 +
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/cpufeature.c        | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 5 files changed, 9 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 3db60a0911df..22c118df520b 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -239,6 +239,11 @@ The following keys are defined:
        ratified in commit 98918c844281 ("Merge pull request #1217 from
        riscv/zawrs") of riscv-isa-manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICCLSM`:  The Zicclsm extension is supported as
+        defined in the RISC-V RVA Profiles Specification. Misaligned support for
+        all regular load and store instructions (including scalar and vector) but
+        not AMOs or other specialized forms of memory access.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5a0bd27fd11a..c93d957458f0 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -92,6 +92,7 @@
 #define RISCV_ISA_EXT_ZCF		83
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
+#define RISCV_ISA_EXT_ZICCLSM		86
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index b706c8e47b02..a9370968fc9f 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -72,6 +72,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_ZICCLSM	(1ULL << 49)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 8f20607adb40..2f54d811a9b8 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -314,6 +314,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 					  riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
 					  riscv_ext_zicboz_validate),
+	__RISCV_ISA_EXT_DATA(zicclsm, RISCV_ISA_EXT_ZICCLSM),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 8d1b5c35d2a7..01eea29a56cd 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -107,6 +107,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICCLSM);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
 		EXT_KEY(ZIHINTPAUSE);
-- 
2.45.2


