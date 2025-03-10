Return-Path: <linux-kernel+bounces-554501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF1A598E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757611891B95
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3618423E354;
	Mon, 10 Mar 2025 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O8fbsLvd"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429F23E33D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618414; cv=none; b=DMumDSLd0hp6K8mkcExX95lShgfStI1dy0+8a7PaDeD96nr/5vUi5I68K63+NT7UCXnm1WXwe3kOLQIDQSPZgN+oPH211++Ye0kjETV03Nd7fB1qWqkhpQTr3s8HH+2Qg6BJyMdR5tegiCaZ8iGPhyfQKfIYcCK+eLXg+oVU83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618414; c=relaxed/simple;
	bh=Eua84f2QnuJ0+u1eEfH6+3KRo1p7kHINzNbKNk8bPkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YHN44KYPlD9Nk5NgrwVzT2daLvViWHfZ1jg3XgxOSwzgMyRBfwxpKaSCOhBHA4Cgq/XWxFtUs0yZVd70URl+NwqZn8txY4+5wZedZue+EgJigfJ5/iRWItYCh848bQinJeqB54TVK6Yz43Ck/UEJoTbSKkmC6rVZiGpiabWoazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O8fbsLvd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224191d92e4so73640505ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618411; x=1742223211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LN1OOVFFK55bIQe9Bj7KSCICvDpdODqLxcVYOIQy28=;
        b=O8fbsLvdnD8UIpI0UlJYiIL1lmGzpKtFjWwms4QoY9YaH3g/9k1ytjjnEo0uM2m9Yy
         W2+Y6867Upup1zQj5IAU2dgH03j17eT/1zaY4BVmuJM23jmrrJXgehS3ICvbG7LfdfIZ
         QP2E02aEVi+J+ESa6fcPFwgqfT1ZxOVBUvlgBG8sImxddE4P/II57EuZQZcClr/HMaRD
         oSwMqUtUIZGhXodE0rBBd8Kx7q8fN3Z95Lo63cCYt1ivb9PhTmekIeiV6/dPI7mm1Uk7
         12q7qlXE1j2tlsZ93G7j8IaJlk3TYZY8BGZDhnhxsag4zLwfdFjZDxV1TEZUwFAQzL9p
         YXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618411; x=1742223211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LN1OOVFFK55bIQe9Bj7KSCICvDpdODqLxcVYOIQy28=;
        b=HWQv83MD1QeTXdxS8mub2+vY06qgXKkrHq+XFX2OoES//e48NDZeJ0JDkUVeT/pn4k
         rYy+OOKfEUiAa+MA7ScuDgEp0GyKPO0BI8thtKT85+WwK6Pa6c8N/3++UdqXUhlrjRSj
         GRum55edEebpciSoIivBV7/c9WE2kZyo+e7/UwzGbAk4/WeazFJbNYVUlBwNonrdZKsR
         wrdhMRHqJJLx0XXTpqA7vVs65+334KSVSFxZLunGmwcwh8e0N/XvkB5bmX4ucvvjVdO8
         SYiOfEUHxbVFikKTQ/pLxK4nJLBj1abejwYdHBJI0J2hyzAss5foCE9c5ib79OomeKls
         JNsw==
X-Gm-Message-State: AOJu0YwGWvGUotE1HK4/aIfGeGcEKnPbiH/U0DIlIkphwHqwD9fu+Orq
	6QVxhlTBSJvsR9r/I5yVud5h89u6eGIZYK/vlqiCa8ZUln/rcGlfcSM0S5EKyEg=
X-Gm-Gg: ASbGncusfrdspMI0Bmj0O6QZuM+4pqTYkkPqXsoSr3OBOUmm/Ha9SD7nDPExiM1W2Pj
	VK7Szi1Fmpm2fmhBoIhml453+EV/3bsjb7Ej+2w2pRnWBEXJ2fUN0mjY5K8v3mDprLNSS8ClKiN
	hzHxORmrwDCBMfOR6MK8CuTA+L7bcv/7/B++bA/c9Kuj5WBdxvNP4GsjhbsWIRCtwQhChRf1PxI
	UEKBMUrhM8FES2wFqO5Sth2dZ+mVlQgViq+6qZ/f54cfPypVkxxO8587ibSlQGgDxq+FOeI6t4W
	sX+Sdh5V3EdEir68oyJMnEpKMn+Lr5tE5KKkftsVE5bi6y3J2xvmwVY=
X-Google-Smtp-Source: AGHT+IG9tC1WaMP/xC1ABIbEOt50ns/8+sJ1nYsKd4Gr0OatbIpLJiaEKJdeufsJkmLrEp7EYv+TbQ==
X-Received: by 2002:a05:6a00:928b:b0:736:5dc6:a14b with SMTP id d2e1a72fcca58-736aaa1ace3mr21470128b3a.13.1741618411393;
        Mon, 10 Mar 2025 07:53:31 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:53:31 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:46 -0700
Subject: [PATCH v11 24/27] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-24-86b36cbfb910@rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
`ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..0a2e50f056e8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -250,6 +250,26 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select DYNAMIC_SIGFRAME
+	help
+	  Provides CPU assisted control flow integrity to userspace tasks.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge in program.
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption. This helps mitigate ROP attacks.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This mitigates against
+	  JOP / COP attacks. Applications must be enabled to use it, and old user-
+	  space does not get protection "for free".
+	  default y
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8

-- 
2.34.1


