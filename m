Return-Path: <linux-kernel+bounces-174680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC28C12CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28A51C20DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB00C17166B;
	Thu,  9 May 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bQBAA0Gr"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465DB16F8F1
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272066; cv=none; b=PI9UZvgCQfaoVQEoWPqoLmZthJ3pX+IqOebTjCUFNc8gqOroYCmFTN8hjp5l6xtqlc5k2iiraVHJc9j+L6UA2rRjXOpCC+YUp0MlBLVW+aYFNaocP2UFQWAba1CFvusUPSOU9bN0t6B//Mz9OlV4NvH0c2lhmoScFr9eKMCwAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272066; c=relaxed/simple;
	bh=d+mYI6dxJIL04rhk4/n1dO8Ggk9e997Ohv38lDy0jX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MtBKe9e8CEYvXEF9P0Rfo5sVzGcHFFmhFCI4Q2NP9yL7UIf/4Y7xv9+XDhHpBIhG9YEGwrc+b9OtraCqFcFAbhN0JaYkgChOaL9QVXrb1EDgpHWBP3tp4pDELNiKgAiMWGyuuCaI98dcYNdJMTQki3+7jTL7+63LU47U6RtquxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bQBAA0Gr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ee5235f5c9so8760605ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715272065; x=1715876865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gS0Jn2CNRETSxII8vxmdki1qJ+zipNSMB0uxD87mL7s=;
        b=bQBAA0Grvo0z+XwYjwzlQTRZHYD7MWnYzgFMDrylVER0VkgTN0EosniISsqOPYdmdq
         u0XnCbMYvSTG0XQlbKAnpaXT/H+P/aSaYQ/pFE7BhAjgsNRNWC5/iDxm3WhFIW4IwluS
         7ElYIIUtnpZK/rWjxZ8Mub1KIMBO+5VEt+P8/COLfi59NahyfPFvxiMpyY06pFtqJUZX
         kZRVQW4PNJrSy7UKvdknU1VTjNCX7YQEFpQEog6gC1l6bPpimEXTr0Gm+l/VxaOdy5TR
         iibg6SOhgrZMtJPzqCpsf2hcRQhhM2oosq4ZeDBtTjfL+hRIHccyIQNhpcndms02L7V9
         Dzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715272065; x=1715876865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gS0Jn2CNRETSxII8vxmdki1qJ+zipNSMB0uxD87mL7s=;
        b=VVC5SR+tVYoKKQm+0EGVsvJ8P7lFLFqn3twBTveQq2CMQQW81VcLo4ct2NQvcPOA9Z
         Ip8xomqIjYvsVG1GHtJcnCK2mQt/O8M4xJJAFbRe3IFztxZ6ZU3qeIIJjyKNzh2q5FHX
         wqPzilNlJrslGKPosK8NiBBp0Nb7FvdP3VwlMfKFzRRV1wbO+KdEAILCXq18S+DSLf/b
         Ks05aLd71pjw+gOLdlLqgz9tMq6tN+boqpY1H6Zz5Q83DB+xKLbUFR6JgnlSL/fR1ZAo
         euLA1+q6mP4m4GXBHAmC5FVTk6j90sA5CzlOdV4mLg9CQZ3kvttH40BdRLb0Z7UH0yMS
         iFcA==
X-Forwarded-Encrypted: i=1; AJvYcCURDs64DbSDN5uyGs8OpaGo6dnjKrnfnuftgMA9y8fKtOf9eWNUtiLISZA5ZBwiaMoxDWB+/AS907ia7pAS1QIj03Lcz8KvOuapsOPF
X-Gm-Message-State: AOJu0YzDkjQwmwe/OaGwgv8z+nhWQ6wPKYcgOeUpkpwTX3WZP+jUK15A
	kKxhe17sb139k4lG6aSUdw6Tkr+2HHTG328RsO5afRtZLQC3+wDWoFweR3vjJAU=
X-Google-Smtp-Source: AGHT+IEcfNG5b+WnhP899fciFO7zYJT6fjTvSFp0///eZQlXzATxkTOr3r8djPCFfhzo/MtEAYsIKQ==
X-Received: by 2002:a17:902:ea10:b0:1ea:2753:2b9f with SMTP id d9443c01a7336-1ef43d15560mr1959745ad.20.1715272064666;
        Thu, 09 May 2024 09:27:44 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13805asm16210285ad.264.2024.05.09.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 09:27:44 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 10 May 2024 00:26:56 +0800
Subject: [PATCH v5 6/8] riscv: hwprobe: add zve Vector subextensions into
 hwprobe interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240510-zve-detection-v5-6-0711bdd26c12@sifive.com>
References: <20240510-zve-detection-v5-0-0711bdd26c12@sifive.com>
In-Reply-To: <20240510-zve-detection-v5-0-0711bdd26c12@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Andy Chiu <andy.chiu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Vincent Chen <vincent.chen@sifive.com>, 
 Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.13-dev-a684c

The following Vector subextensions for "embedded" platforms are added
into RISCV_HWPROBE_KEY_IMA_EXT_0:
 - ZVE32X
 - ZVE32F
 - ZVE64X
 - ZVE64F
 - ZVE64D

Extensions ending with an X indicates that the platform doesn't have a
vector FPU.
Extensions ending with F/D mean that whether single (F) or double (D)
precision vector operation is supported.
The number 32 or 64 follows from ZVE tells the maximum element length.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
---
Changelog v5:
 - Rebase thus add ZVE32X after RISCV_HWPROBE_EXT_ZICOND.
Changelog v2:
 - zve* extensions in hwprobe depends on whether kernel supports v, so
   include them after has_vector(). Fix a typo. (Clément)
---
 Documentation/arch/riscv/hwprobe.rst  | 15 +++++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h |  5 +++++
 arch/riscv/kernel/sys_hwprobe.c       |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 204cd4433af5..fc015b452ebf 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -192,6 +192,21 @@ The following keys are defined:
        supported as defined in the RISC-V ISA manual starting from commit
        d8ab5c78c207 ("Zihintpause is ratified").
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve32x is
+    supported, as defined by version 1.0 of the RISC-V Vector extension manual.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVE32F`: The Vector sub-extension Zve32f is
+    supported, as defined by version 1.0 of the RISC-V Vector extension manual.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVE64X`: The Vector sub-extension Zve64x is
+    supported, as defined by version 1.0 of the RISC-V Vector extension manual.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVE64F`: The Vector sub-extension Zve64f is
+    supported, as defined by version 1.0 of the RISC-V Vector extension manual.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVE64D`: The Vector sub-extension Zve64d is
+    supported, as defined by version 1.0 of the RISC-V Vector extension manual.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 31c570cbd1c5..6593aedb9d2b 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -60,6 +60,11 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
 #define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
 #define		RISCV_HWPROBE_EXT_ZIHINTPAUSE	(1ULL << 36)
+#define		RISCV_HWPROBE_EXT_ZVE32X	(1ULL << 37)
+#define		RISCV_HWPROBE_EXT_ZVE32F	(1ULL << 38)
+#define		RISCV_HWPROBE_EXT_ZVE64X	(1ULL << 39)
+#define		RISCV_HWPROBE_EXT_ZVE64F	(1ULL << 40)
+#define		RISCV_HWPROBE_EXT_ZVE64D	(1ULL << 41)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 969ef3d59dbe..35390b4a5a17 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -114,6 +114,11 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZIHINTPAUSE);
 
 		if (has_vector()) {
+			EXT_KEY(ZVE32X);
+			EXT_KEY(ZVE32F);
+			EXT_KEY(ZVE64X);
+			EXT_KEY(ZVE64F);
+			EXT_KEY(ZVE64D);
 			EXT_KEY(ZVBB);
 			EXT_KEY(ZVBC);
 			EXT_KEY(ZVKB);

-- 
2.44.0.rc2


