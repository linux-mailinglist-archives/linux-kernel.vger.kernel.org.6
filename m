Return-Path: <linux-kernel+bounces-512110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA72A33426
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488B6188ABB1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A758633F;
	Thu, 13 Feb 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrStPF+H"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF081AC8;
	Thu, 13 Feb 2025 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407154; cv=none; b=jaW3ekh3qSCPqUz4HAJN4eW382MFP2pbd5DC+Luf+C/nVpuBT7g7MbI8d+NgyGjg3+dOlIhE2KqIR3QvNKvP7NybFpEwvJyTPnhgPbIQ4GsURLT4MXN7svvBXCd5sR0Vt9ZyCrk77yzfnsBjSDf5YsNEzAcFt3Z+LsBgm6CfueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407154; c=relaxed/simple;
	bh=/+w6HiAUlBc+kRrinIioqfpoFWtrMKoB/DUDSDW3RCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfUGJCLTaxHFEQxZ/S+6qTRsmFRJi0aR46bwRPsx7kXuTo0NtOWYlxr498qQlOeZTk4nvPMm0UKpjYX0T0xczhQO5E6L/qr8a42oE44O/PxoZxzbUUhB3BCFy0SquA1B1ThstCFr4MM/wrq5XGtfoQvNyJG9FZj+oc5FuiKvTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrStPF+H; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46c8474d8daso2140031cf.3;
        Wed, 12 Feb 2025 16:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739407151; x=1740011951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VKAEXIbPsMighQ8qKly+RRtipWoEJVN3H+Ie+l08Lw=;
        b=MrStPF+Hb3N+pc/qdtGgDFGMcV3YJ6WmF3rUVxCVJ3HMDYeG/YL0WpzTwXM0HnsRUX
         ovKOV/efqY+JmU/BEeF4/Uk46wLCsihmkAu6cVV4bU3nVH3C+7zTn3IsyjCdGMOqPCzz
         rWegswOkfyBcBfZ5okJyay4UgxU3+uadSWuEP/pIyQano55DPX2/mMOarR1zjcYtgeE4
         tiGclw77V3c1fKCNLzId8D6lxhGg/fnuYRIaKk/tz1pRv85AJUPzfj1h/U4lqtu60Zj6
         3MkqnuWfCZy2n92lneHZUjebOEbY2E1N6Tt62AZs0oL6TILZbN3UCPwowI4oTN/6Y3uu
         abhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407151; x=1740011951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VKAEXIbPsMighQ8qKly+RRtipWoEJVN3H+Ie+l08Lw=;
        b=fbqWkcA5ViqOHYyeHSzzgpgJqA84O7FRUxvLJb5Lqit7qGIu1pDNKE5UWNInIwbLa2
         AQraijsgiXy27tJMJmGlwqJPqNRApp2OSvturij6e1qM8NPbBWS2Fr1/4IQmt0bJhrkX
         rsabeCXzZhZQl89Aorr9wl6IP7sptccA6Oz0ddjteiRNRsGsBUZoghiX7JDUzhb+G5Ig
         qubB5vc+IwmlEiqSyFrv9LSrJ6J5z9bULL1lDoickevaZ4oXy9WuHIx7Cu9MR+iQzquf
         baEhCjcLAeRMovSCFRKpSu8uC0nQZJjGTbbZc175IuqHDyLr0ChzOuF84sVxhngret53
         g/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdUMumqZuMO1/gIj8B+9xy/HdDGOSLVVnPOxVctnW0gyLUz3QchEXVbL3hTjNo3pPM3Yj2OluBKTZ4fbpx@vger.kernel.org, AJvYcCX5KW4f0VECAZAW7UoNtxJXPc7KX0vlhX/UTVZiGMEZL+XbzmJNowkOmNkKejrXbsROTDWmy0bc5mab@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7g9vX3y89aW1qkMez3EjCBPURahDgRkn8g3M1se2UwK/Ty4+
	iB0cNcnYDUiwTxZ+q/+nBAgUXOvjIaJQ4oPCl7vEGtgkcF/4mKDz
X-Gm-Gg: ASbGncvNgo2a1ME7+VlJTlfrNEsrla4OqyKOZT3Ib0tqZeOZjaZ8Ci05ul4S/eE0xBL
	HsuQDtQFysroBGTIEOMcm+xAgae0tMH9YPHRC2YNhaS1ECoYcwt0MqnIL8LG28RiPp3YJvx3IT6
	HY4UaPVCtv6oM0K3U+ad/dFZCdlCArEJNipVE8DsQi4GNg+u/Nl8pYLBklEb/jygEsdF8pWugeD
	lH4WB15dyY00U7r2T+kO9CEhoME+54+jVaUd31XmbOnZUsisZRmTel/Hv6r//9Rpg4=
X-Google-Smtp-Source: AGHT+IHBc4LTnAwtHYivgaNgVKDo5w4ZaLaXgX6Xpv7NQpTgZYGhBYw2IsMuK7NVT7OfDxlvlEfZdw==
X-Received: by 2002:ac8:7dd0:0:b0:471:9174:53ba with SMTP id d75a77b69052e-471afde1e0fmr56132161cf.9.1739407151127;
        Wed, 12 Feb 2025 16:39:11 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471c2b04b18sm1163941cf.72.2025.02.12.16.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:39:10 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 3/3] riscv: hwprobe: export bfloat16 ISA extension
Date: Thu, 13 Feb 2025 08:38:47 +0800
Message-ID: <20250213003849.147358-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213003849.147358-1-inochiama@gmail.com>
References: <20250213003849.147358-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export Zfbmin, Zvfbfmin, Zvfbfwma ISA extension through hwprobe.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 12 ++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h |  3 +++
 arch/riscv/kernel/sys_hwprobe.c       |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index f273ea15a8e8..feefe5ea24ea 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -242,6 +242,18 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
        defined in version 1.0 of the RISC-V Pointer Masking extensions.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZFBFMIN`: The Zfbfmin extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFMIN`: The Zvfbfmin extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFWMA`: The Zvfbfwma extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
      :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
      mistakenly classified as a bitmask rather than a value.
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index c3c1cc951cb9..e4e286c63629 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -73,6 +73,9 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
 #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZFBFMIN	(1ULL << 50)
+#define		RISCV_HWPROBE_EXT_ZVFBFMIN	(1ULL << 51)
+#define		RISCV_HWPROBE_EXT_ZVFBFWMA	(1ULL << 52)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index bcd3b816306c..f76163958e27 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -132,6 +132,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZVE64D);
 			EXT_KEY(ZVE64F);
 			EXT_KEY(ZVE64X);
+			EXT_KEY(ZVFBFMIN);
+			EXT_KEY(ZVFBFWMA);
 			EXT_KEY(ZVFH);
 			EXT_KEY(ZVFHMIN);
 			EXT_KEY(ZVKB);
@@ -148,6 +150,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZCD);
 			EXT_KEY(ZCF);
 			EXT_KEY(ZFA);
+			EXT_KEY(ZFBFMIN);
 			EXT_KEY(ZFH);
 			EXT_KEY(ZFHMIN);
 		}
-- 
2.48.1


