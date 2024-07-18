Return-Path: <linux-kernel+bounces-255813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F6493457B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F451C2140E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4F374EA;
	Thu, 18 Jul 2024 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TRTAeu6n"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8528E0F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721263715; cv=none; b=GU/sn0NN281yOUcJDG1X0Xa3JrpmVfAeaVS0u+QxxKXVepIL0sLyGddLEp1crH9QFqwh6zwUnSOn3d+vEZff7E8C7+ma8iQ1/qr4rCQrhLxre7y332c63xms1it5XsdMQ6ITILpZXSAZfH5rzb3WGFJmYFWqswzoUiTLMp+jiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721263715; c=relaxed/simple;
	bh=DViUG853Vkr4ZgM3/qsNgiDhd7tmq0jIGwgE69RL0Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WndQGnDYg5UlOpDFu8MkPuj/xpWV3EurQQPJWX1sarAPtXsj4+kOLKpUjJU8lmb3kPlP7+ZjxxFU+43L+pRWPLOVic7i3QEQDm4ghWkayEulZCC+qhL6KGSoBLkneSGxb0AsLFxlrpVS2xpIYK+q7R8u/ZM/7x/vylQs9FkL1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TRTAeu6n; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-396675b83afso1001455ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721263693; x=1721868493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQiU3jLs/PVYv24pQZF1OM35EdgJeLHTVO+iajBsq3c=;
        b=TRTAeu6nP6DNXubs9Wz+D7eblYv5mTVZ0g9kbAVySSDdpDTXcYDCIDuXFi7lMVj7Oe
         xPcSX2O2K8UUoRybX/LkZfy/o2f2A+/NBQ0N+JWSdq+sW5GuEhhbGic1peKSklAJ3a5x
         SeJc1eoVsYgAxVglMZP63+jbkJbvHxLsDA2+of9FXAkiEEJSNarEb4Sp8Vcay5Jo/7Mx
         hXnc1z+oUd/FWGvWm9ktIz9mrm7AYJsi3h5EmUfNIGwNSyj6l/TJ6462UmIyil5Vc99x
         kTYeOLmh9BpDoXcc1EqprNA+hq8eZDB6PEmOvnYJBAJAo4g9j1uUtTAoEB/sVe7xnD2m
         NytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721263693; x=1721868493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQiU3jLs/PVYv24pQZF1OM35EdgJeLHTVO+iajBsq3c=;
        b=L78ht80BaVkXxtPfewLCrrU2PndPbqfhYqqakjyrXYOrpQLfJFeYre8r/cKQS19zlm
         O6Yuo+oTvWntF6dKA1908E7RxykYSbC73edqEWgBZUbTn5h6S3Jgz3fg8iCb12QNLQjg
         gt6UeUbeTC3lpgdEpXyHgeQ2hQaHENSzyvzqONNBU47zpzu1kQPMFSMNEWobddhIiH/S
         gxXclcztB9I9vls4/QpdgQy3lWxNHE2rpuoqkn9BUZGTzt7EwRhY0Ud3xu3HDfKoOVw5
         p1l5/HR4AayRO51mwzaehDAco9faqolfcIYFj9ijH4T8NIgQKxjMA3rzSamwnqwFQhE/
         Fmbg==
X-Forwarded-Encrypted: i=1; AJvYcCXjNaBKfxU1p3Cex/W+bAQEDQMfbHttqMzEEN3XBPxTeOi2vZ73xRGIbtAXoGsZjNQGZZ4Rgjnuqn36Yf3SuYPZ94kyLamw475Itwjo
X-Gm-Message-State: AOJu0YySjikpoTkrK24toZg9w2Ly5wYlfyV+cRBkD7xUDtQ3vu/FNEA5
	CoPGpzfpN5vT6oqr4y9xq34CB/eqCEZbAnlnfahU1iUYLt4LagBtRmWdtI9uEk0=
X-Google-Smtp-Source: AGHT+IHQC2fSybGj1wvVXYG/rNOyfBlLM1/ZwN9ZqAtrY4RDk0eAm6Wfwf7zO3wfGYZ7JiO0lxUPvQ==
X-Received: by 2002:a05:6e02:15c4:b0:376:410b:ae69 with SMTP id e9e14a558f8ab-39555cd31f3mr46347585ab.15.1721263693464;
        Wed, 17 Jul 2024 17:48:13 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e386d53e4sm5694300a12.70.2024.07.17.17.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 17:48:12 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 1/3] riscv: Enable cbo.zero only when all harts support Zicboz
Date: Wed, 17 Jul 2024 17:47:54 -0700
Message-ID: <20240718004808.2246354-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240718004808.2246354-1-samuel.holland@sifive.com>
References: <20240718004808.2246354-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we enable cbo.zero for usermode on each hart that supports
the Zicboz extension. This means that the [ms]envcfg CSR value may
differ between harts. Other features, such as pointer masking and CFI,
require setting [ms]envcfg bits on a per-thread basis. The combination
of these two adds quite some complexity and overhead to context
switching, as we would need to maintain two separate masks for the
per-hart and per-thread bits. Andrew Jones, who originally added Zicboz
support, writes[1][2]:

  I've approached Zicboz the same way I would approach all
  extensions, which is to be per-hart. I'm not currently aware of
  a platform that is / will be composed of harts where some have
  Zicboz and others don't, but there's nothing stopping a platform
  like that from being built.

  So, how about we add code that confirms Zicboz is on all harts.
  If any hart does not have it, then we complain loudly and disable
  it on all the other harts. If it was just a hardware description
  bug, then it'll get fixed. If there's actually a platform which
  doesn't have Zicboz on all harts, then, when the issue is reported,
  we can decide to not support it, support it with defconfig, or
  support it under a Kconfig guard which must be enabled by the user.

Let's follow his suggested solution and require the extension to be
available on all harts, so the envcfg CSR value does not need to change
when a thread migrates between harts. Since we are doing this for all
extensions with fields in envcfg, the CSR itself only needs to be saved/
restored when it is present on all harts.

This should not be a regression as no known hardware has asymmetric
Zicboz support, but if anyone reports seeing the warning, we will
re-evaluate our solution.

Link: https://lore.kernel.org/linux-riscv/20240322-168f191eeb8479b2ea169a5e@orel/ [1]
Link: https://lore.kernel.org/linux-riscv/20240323-28943722feb57a41fb0ff488@orel/ [2]
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - Rebase on riscv/for-next

 arch/riscv/kernel/cpufeature.c | 7 ++++++-
 arch/riscv/kernel/suspend.c    | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 0366dc3baf33..4efaf12b470e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -27,6 +27,8 @@
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
+static bool any_cpu_has_zicboz;
+
 unsigned long elf_hwcap __read_mostly;
 
 /* Host ISA bitmap */
@@ -97,6 +99,7 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
 		pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
 		return -EINVAL;
 	}
+	any_cpu_has_zicboz = true;
 	return 0;
 }
 
@@ -874,8 +877,10 @@ unsigned long riscv_get_elf_hwcap(void)
 
 void riscv_user_isa_enable(void)
 {
-	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
 		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
+	else if (any_cpu_has_zicboz)
+		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index c8cec0cc5833..9a8a0dc035b2 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -14,7 +14,7 @@
 
 void suspend_save_csrs(struct suspend_context *context)
 {
-	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_XLINUXENVCFG))
 		context->envcfg = csr_read(CSR_ENVCFG);
 	context->tvec = csr_read(CSR_TVEC);
 	context->ie = csr_read(CSR_IE);
@@ -37,7 +37,7 @@ void suspend_save_csrs(struct suspend_context *context)
 void suspend_restore_csrs(struct suspend_context *context)
 {
 	csr_write(CSR_SCRATCH, 0);
-	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_XLINUXENVCFG))
 		csr_write(CSR_ENVCFG, context->envcfg);
 	csr_write(CSR_TVEC, context->tvec);
 	csr_write(CSR_IE, context->ie);
-- 
2.45.1


