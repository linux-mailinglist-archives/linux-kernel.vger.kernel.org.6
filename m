Return-Path: <linux-kernel+bounces-393729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080829BA485
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F6B1C2122F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 07:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C721632EE;
	Sun,  3 Nov 2024 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3FyJu6k"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1F15CD58;
	Sun,  3 Nov 2024 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730620241; cv=none; b=l0K7h8em9W1MkoFZAO7QPwP/n6tqdA+NtLzAsurU2XsupEUNCYutHi5mJAdYTbsnTZ8+ROtSDVAGjIICTXM8jBUN/jUhZR4jjdtGumx49c6zHHSS5U3Xf7Rf7dKDNZdIoYdAtZciefBDGj5n1nNLaXIfSi472nNLEWMyQlI1XMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730620241; c=relaxed/simple;
	bh=J3lvfNu94j/hIu8zW/nlNeCHxY5XSNW9+1XkAp2wfNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyJrYJ1DeqrP+w2gThro3o3Vfng/RFXdYgUpnE2sXb+U62AT6aDaGzKll6bw/56JGhx6MIhjTKXU3+33yxUDYLk+HMkV6TC5CHr60bP3RJNVzxUU4Pbl0tAJsfN8RfJWU4qACkrbERQLajQdACSl6wHZ7rdv4x6aJlFsCLhjyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3FyJu6k; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720d5ada03cso1826694b3a.1;
        Sun, 03 Nov 2024 00:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730620239; x=1731225039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uizG+AQKjMiNSyY0/c5FnD4O0HivvPLaMjzCzg5Rho=;
        b=W3FyJu6k9VJylGfA+bzTongX8UyMQYs02N6Iq/qJIlP0xMPj0GtZSiF9v3iQQZV6Nx
         gRveHTnYlEg81o64eU3AjNNAs9RtnBnvfLxMAkrV0/7JTiw0c6VR6PqQxQdtF1VQQ5/v
         G2VFZDqhF3jaBZaLRWBNzQH0fQPb26FG8l9FCUmIPPjj/+JWSxOkHIgQiGHugT0NfbMR
         KZFmH4pwGEF9KsM72+U7cm1RD4mQUfzfwBLTKu+rj9qI+30MjBd6I163YB7aJdlEJR5P
         lp01Rvf+AQNUjOci70+aBV6/wny6D9XYGAV1V8G+O6PpHrRVq7j7MtHse/WXAagpHkDf
         /YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730620239; x=1731225039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uizG+AQKjMiNSyY0/c5FnD4O0HivvPLaMjzCzg5Rho=;
        b=jhVx/O3ql96iQxc/AwoTYR2kXx/qA3nWdnGTnB03UrrxObDG/pKjOBeWbRY/qNV3mx
         FioMqNKCYtHFVMemRMi0bRtooyGHNEdH1gCeGsbdsl4RlzqFdA1bLISnzaPPIj73VeQk
         PBu2OyJx4D3epOZKD4baaNujcQiEyJn0zy3p+29f6f7a6LjD+szZwMRXFSRLE9bnQAwa
         FXluTpI6t65wOw6UKWHdmq6kexkduyXylDgZ6ByQueOYJJrRKM1RZQENfmI1p+1oApQL
         uF60S+nFeYlfIYagEyk1IddfI860ppcU9OiyYqHnekn4biQg5rQicPTlstic4HHx8Z9i
         WGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtwcsN/sO8sqGQleMov56nApEleMbPRJVRp29UlvvJtknaGpuD+2OxOMLCgBPZx2EMndmcIzG1dBga@vger.kernel.org, AJvYcCWDnuSbjozCDHytoE2Pp2TgtzOg9zfQdpUiEabDixYESOdsPpeO9jpVf4YCPg9yegMDh34kaNp7qJBUQx7K@vger.kernel.org
X-Gm-Message-State: AOJu0YwM8J91rd3quViPdLDNEYxspR0vyI5QrT8HjtKU3Vk37EnNf1kE
	hs4Q5ltkaoz3sMT+R2gah/QmpQNthcl8PduJUKnbb1UqsSHYh5Ae
X-Google-Smtp-Source: AGHT+IGBI9drJicN8m+V2yXjzCG8M+gsBBzp5RBPh4a3AqoLk36+eLE2uPD9/29r0ZVb+zZWxlwzMw==
X-Received: by 2002:a05:6a21:7101:b0:1d9:1c1e:239e with SMTP id adf61e73a8af0-1db91de3c85mr15691002637.28.1730620238824;
        Sun, 03 Nov 2024 00:50:38 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8936sm5276775b3a.5.2024.11.03.00.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 00:50:38 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andybnac@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 2/3] riscv: add ISA extension parsing for bfloat16 ISA extension
Date: Sun,  3 Nov 2024 15:49:56 +0800
Message-ID: <20241103074959.1135240-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103074959.1135240-1-inochiama@gmail.com>
References: <20241103074959.1135240-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add parsing for Zfbmin, Zvfbfmin, Zvfbfwma ISA extension which
were ratified in 4dc23d62 ("Added Chapter title to BF16") of
the riscv-isa-manual.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/asm/hwcap.h | 3 +++
 arch/riscv/kernel/cpufeature.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 46d9de54179e..97657fb63af6 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -93,6 +93,9 @@
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
 #define RISCV_ISA_EXT_SVVPTC		86
+#define RISCV_ISA_EXT_ZFBFMIN		87
+#define RISCV_ISA_EXT_ZVFBFMIN		88
+#define RISCV_ISA_EXT_ZVFBFWMA		89
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3a8eeaa9310c..1b286f5bc591 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -325,6 +325,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
 	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
+	__RISCV_ISA_EXT_DATA(zfbfmin, RISCV_ISA_EXT_ZFBFMIN),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
 	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
@@ -357,6 +358,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts),
 	__RISCV_ISA_EXT_SUPERSET(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts),
 	__RISCV_ISA_EXT_SUPERSET(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts),
+	__RISCV_ISA_EXT_DATA(zvfbfmin, RISCV_ISA_EXT_ZVFBFMIN),
+	__RISCV_ISA_EXT_DATA(zvfbfwma, RISCV_ISA_EXT_ZVFBFWMA),
 	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
 	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
 	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
-- 
2.47.0


