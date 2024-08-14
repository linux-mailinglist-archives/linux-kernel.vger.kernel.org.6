Return-Path: <linux-kernel+bounces-286079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E742F95163D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEEE28286F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB0B13E02C;
	Wed, 14 Aug 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PqRLFrrI"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6E13D51E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623094; cv=none; b=fNOwQtmJEM1gbbLPU1ya7ZnAk2dr6SiZK/yIJajHIGSAgjiFsUC9RvqnQKcMyJ70Qu/dPajkS/HJkKTtIFMzIx/zGjLIznudPz3Hs59Z9NLsqetCOf6ZT0akhcq+Bol1F5HjOGm2pL4Iqa4YeUlf/20xMCWQgYGjWxzjfNO0nw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623094; c=relaxed/simple;
	bh=bLQ9LIwaq5uQIXBkvRWqyA68sVAFZjIgd47ZJlG6OdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBSnKOgy/O6f6YAhN7qTZZnHA4Zrd/Dtc7mnP+KNRuoa9mUCBYjPcf2goHr9N63XSw+sCAYIHH9qf3x5FTqlXe6Q3Z55ZGlUIjjZEJTe8xYKAV7fNBZkhhmq3J474jRD0rMC86nsqyS2ojqkDBVFzsqBlsZ2S/akHEKakGbj8Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PqRLFrrI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so5835126b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723623091; x=1724227891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aeJwSkJyEYhCArckd2TWKFlpkUc8ta4z33pmclBmZc=;
        b=PqRLFrrIUdz5UziiPZBotG2yOreWc6iJ7IPK1ND5cDNVQ6Y5vvXxcsKz6Xq93Qu78x
         CymyE2P/IppW482KJ/9JWXg5iUN3pgnGHDysOqVavEc2X8RCcfgog8BDgEFNlZoqrcKb
         n1FuMmWJWrxxpWg6DFlQNnFU4phLvAmDO2V7ZOiSTmzx+bbxdAy3KIEng7RJv9k1RJET
         /kZetgxDQWIEOjjmpwbyVBGaEiHnbt41zWRocU5FsEtLrGP8UMWLgLV+RS161msYXfY9
         GbU7RcrK2YqJmHH4ZNvUwud4MLJxqo+bp2FzNZkr0TzrtadYEu/xXdfN+bjgWnSsf0NF
         VfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623091; x=1724227891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aeJwSkJyEYhCArckd2TWKFlpkUc8ta4z33pmclBmZc=;
        b=kr9H5yno6HBbruRLA62PWFw8ABd8KWfCKtP++WpL/zhgwN+OPFa7gTOREci3fy6LG5
         Q9IeEcjSFo9KibPuKwhM6FeGicf6wOHcF1+SrUdK+L9ZvP2t0cEaSEOG3a6/tjPQ/8jh
         5e55pEk6/uG296aNml9Oi+QrqOi9tXRn7B8gycKZRgLNh249J+FsWy8WQBfVGAkGlG5/
         tMtbScHY+DHooXSxrC45AZE9q/4zZ/O6VqhmzfYg4Nj3+Ywe43FKu91DPYHnwFZ5pMtz
         03D2Zr1ju7Q87shP9ztpxXF7g2xpDwWks73vfTHW8OUpd0zbb68rVLZT7xYs/5vKuSrk
         IeUw==
X-Forwarded-Encrypted: i=1; AJvYcCVYjr45UEfpXFkwN4wTrexriwFm7CzQQm4mqpNcLuIG/BAQadcNG5lkfvFt6KqsR8Bwv/5wsC6ohitjh3IFt/BfIHUXoPVQML2NkB1E
X-Gm-Message-State: AOJu0YyyBLdqkQUNGJLHj9SNPFM6aixZaHV1EP44ESMtFl8FVe/PHgcJ
	m6OWGxhaDwXYkIPeAzvFAyNyVxuTn0A4MRS5+mPW779Q+5x0yFdbzCJZ8vpqbYo=
X-Google-Smtp-Source: AGHT+IHzz6k/y9eJBQjHqqaXxD/Ow2KDkmoZxQIFeBXhlwFgBTesdH1eA+S+4NnIpxaGBpdLmz+UBA==
X-Received: by 2002:a05:6a20:c908:b0:1c4:7929:a593 with SMTP id adf61e73a8af0-1c8eae8dccemr2856680637.23.1723623091285;
        Wed, 14 Aug 2024 01:11:31 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a94d2sm24559955ad.127.2024.08.14.01.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:11:30 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 1/3] riscv: Enable cbo.zero only when all harts support Zicboz
Date: Wed, 14 Aug 2024 01:10:54 -0700
Message-ID: <20240814081126.956287-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240814081126.956287-1-samuel.holland@sifive.com>
References: <20240814081126.956287-1-samuel.holland@sifive.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v3)

Changes in v3:
 - Rebase on riscv/for-next

 arch/riscv/kernel/cpufeature.c | 7 ++++++-
 arch/riscv/kernel/suspend.c    | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b427188b28fc..0139d4ea8426 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -28,6 +28,8 @@
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
+static bool any_cpu_has_zicboz;
+
 unsigned long elf_hwcap __read_mostly;
 
 /* Host ISA bitmap */
@@ -98,6 +100,7 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
 		pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
 		return -EINVAL;
 	}
+	any_cpu_has_zicboz = true;
 	return 0;
 }
 
@@ -918,8 +921,10 @@ unsigned long riscv_get_elf_hwcap(void)
 
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


