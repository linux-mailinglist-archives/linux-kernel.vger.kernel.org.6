Return-Path: <linux-kernel+bounces-228118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AA1915B24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5694D1F227C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8895E107A0;
	Tue, 25 Jun 2024 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Uh9WPsCQ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC518030
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276636; cv=none; b=EyLpmEZddlSAD33egyjqhQBxIo8OW6rowGePKbuad6Todl1JmtWO4DqMtFYi87pgS5d1IkTJ8iPmqy3TMFMxhInjUNdRqnA42SFaQaebFFnm3xdpDLNcTLQU46k6ADrrKWKARD8Ap+XxQbk7CxCrYQTw/wrWtP0xf/vTP1+n1m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276636; c=relaxed/simple;
	bh=/Bt9oE25lnWQdPa/YSCfxFpeXsIhjBhAIfx6hMvpw98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPOUQtltAyoOKdIRLfPll7tKkySRwNH4gm8MJP/k5mhJcMMyoCFT/WN93D36clhatnIW759zH+dGp//zlS/snRr8m+PkZse5MumwCgbbAbsdimFRT9+2fhR5ojv0fXCYJ0Bu3BP54Gg786eqOPG2pepqLfj/jun9oUFcn8VYMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Uh9WPsCQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f862f7c7edso37233895ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719276634; x=1719881434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsFL4pVPRli+inXg9hiGEw7k4kBD3MX99ZHq/8uxkhA=;
        b=Uh9WPsCQ6REABDjEsUOQcq9UzCLpgdcq55lVaebnpEbw2yiMXj2Bxhe8nq5WG35aOR
         eO0+cSRjrKAD4l45+GAJvIJ942WMfKEaJ/Ca0R+9XQre4RH+Ovx3P+RxO2rf6zZWitet
         ilWGudIjQ+LAnyESb0xP6Rg8eWn3/0bMeoaG6AkYMpS8hDkrBpCw7G6k/P7NzsCY2T+V
         fwx1RiKy2PFk5o9GFTeVjlk9MFuTfcp7ErMCYPOZPqRrt412tn9oVjHlP51LhU9ynoLa
         I52SM+ZwIrFuYeDjADcnA7c3FMbnyijTKmnmOQJ/Iqn/qs+gwYjh811YwCeG7KKW8PKF
         U29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719276634; x=1719881434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsFL4pVPRli+inXg9hiGEw7k4kBD3MX99ZHq/8uxkhA=;
        b=p3vLBvfv9mlcRF9q9TQiuDlK2tnCKWwnuUYk4KEle9DT5vI0xidzRZfv6UrgqxO4cX
         FJCj0YJE9pkwQ9gzSSd7F+uZ52qcCEWX0M3OFnVSTcPdh/4Q/5nkC1Doy3Nazs6U3T0l
         ZqKLXyrLo+w40SYsTitoUWD3m7iIpX5j69yPhZSaXQ7bIvG7b5FXN+93syGGTdqWyz7J
         FGYEhQZgnGfY6/XmDEwjoYMDurnQDqZVtBbXMybCLHAzfpKAhMgQuBgR07SHRsPbPpmw
         8fBJJQEOxYcSmW5WvaurvvKq2xXi1Wq5khI7Lv2d+3ltt7HxOrnYpoaTwQtIEV4fLruP
         bm2g==
X-Forwarded-Encrypted: i=1; AJvYcCXW8Z5sMWUVXzEbFjLUV8VupxqsVN6PFEAyiezzRY5PrGvpuBwhiORrnNDnjikYgVN/QenKg6L0s05gx7ZVdvCDvqPiO8FJ/QzI4T2K
X-Gm-Message-State: AOJu0Yyvn02kWIB9Bo62Up4gwOBmPIDbLlmdMM3wVco3Wg0iGvTYGheY
	Zp6IPX7pFon+QJuecGeI+ybngyTvSx9HcBn6MVOFOWIv6k4srOQzT3QCtV8HuSo=
X-Google-Smtp-Source: AGHT+IEpgOILuNHe0y3CrK2jbU7V6dFxD2gSind2RbvoHSr7ZIOp9rwdXozB4OgBe0a+9B3PWo9AGg==
X-Received: by 2002:a17:902:f68f:b0:1fa:3f05:209d with SMTP id d9443c01a7336-1fa3f052432mr46261095ad.45.1719276634455;
        Mon, 24 Jun 2024 17:50:34 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb2a7csm68150235ad.256.2024.06.24.17.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 17:50:34 -0700 (PDT)
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
Subject: [PATCH v3 1/8] RISC-V: Add Zicclsm to cpufeature and hwprobe
Date: Mon, 24 Jun 2024 20:49:54 -0400
Message-ID: <20240625005001.37901-2-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625005001.37901-1-jesse@rivosinc.com>
References: <20240625005001.37901-1-jesse@rivosinc.com>
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

Detecing zicclsm allows the kernel to report if the
hardware supports misaligned accesses even if support wasn't probed.

This is useful for usermode to know if vector misaligned accesses are
supported.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
---
V1 -> V2:
 - Add documentation for Zicclsm
 - Move Zicclsm to correct location
V2 -> V3:
 - No changes
---
 Documentation/arch/riscv/hwprobe.rst  | 3 +++
 arch/riscv/include/asm/hwcap.h        | 1 +
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/cpufeature.c        | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 5 files changed, 7 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index df5045103e73..7085a694b801 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -207,6 +207,9 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZVE64D`: The Vector sub-extension Zve64d is
     supported, as defined by version 1.0 of the RISC-V Vector extension manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICCLSM`: The Zicclsm extension is supported as
+       defined in the RISC-V RVA Profiles Specification.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated. Returns similar values to
      :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`, but the key was mistakenly
      classified as a bitmask rather than a value.
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index f64d4e98e67c..0b3bd8885a2b 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -86,6 +86,7 @@
 #define RISCV_ISA_EXT_ZVE64X		77
 #define RISCV_ISA_EXT_ZVE64F		78
 #define RISCV_ISA_EXT_ZVE64D		79
+#define RISCV_ISA_EXT_ZICCLSM		80
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 2fb8a8185e7a..023b7771d1b7 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -65,6 +65,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZVE64X	(1ULL << 39)
 #define		RISCV_HWPROBE_EXT_ZVE64F	(1ULL << 40)
 #define		RISCV_HWPROBE_EXT_ZVE64D	(1ULL << 41)
+#define		RISCV_HWPROBE_EXT_ZICCLSM	(1ULL << 42)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1d6e4fda00f8..83c5ae16ad5e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -283,6 +283,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
 	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_DATA(zicclsm, RISCV_ISA_EXT_ZICCLSM),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index e4ec9166339f..e910e2971984 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -96,6 +96,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZBB);
 		EXT_KEY(ZBS);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICCLSM);
 		EXT_KEY(ZBC);
 
 		EXT_KEY(ZBKB);
-- 
2.45.2


