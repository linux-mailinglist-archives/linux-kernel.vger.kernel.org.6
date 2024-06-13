Return-Path: <linux-kernel+bounces-213723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEBC907980
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE18B2878E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234D14A0B2;
	Thu, 13 Jun 2024 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZxXTW7t4"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF0145FFD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298893; cv=none; b=TPSETF41PHpBfFBSu4/nMYNK/Q+Eg5UE8zUZLdYsNdVd65Uc5cCPXWcq8dYKsqFdWCXxML0NzgVU+XrnN9b68ITi4nHmEbyON8/xZdcmKLti54raZK0hG3vOpwsvgdS0FYoF7CvfOROvBzfmfB3Rtl6M8GR8IKAPLQdfMxhmAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298893; c=relaxed/simple;
	bh=u3vd/ly9zjF+WctuwxHgm2L54X7Zhgk7u+s6+h7VaEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3PTDGr2Kr5Cz+39yx9op6ZvHF4bRVPgurgaG78HU1TMHkZG89PCfL/7yG/EPPqD9gitiYhsVnBFBxaT7UMNoB+1EhXwxy+u7FpxgZIhzPUZWznlxppccS3fVqQSlu/4c/x1i6GKkgTrZF2cxTcvltZ1qaUKzF5L9ucTq7MRTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZxXTW7t4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f480624d0dso10913835ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718298891; x=1718903691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWKKc9/VVGODzNuhTkLxFLmhIceztWrJoblOszvDngE=;
        b=ZxXTW7t4PGcZGI/W4t2dnXvBncBIEJFOzRLuJUOEv4fQpRE4loEJvgwo1D9UyL5I5/
         lym8RlluTRsGLSoCwp/8UPlxUSL0AbozGpOSsoTjrfUE5hR1xRJ6Gg8SjM0DsoXbzFXZ
         Si5RGaAUGeBysv+yO/z1pe9EaFVPQ+5J5Xsi0hu8pOA2nzbXHxJoXgFQeUNdfVJlimbW
         PSrOwxLpYoGn6/9HI1Cx/qQCM5eP0c7VqeCc4EEkw45JpkZRgTkxjURVnesg+Z9oMRAT
         fVB0IqaqsdAkMJ3ze3chTJuD60V703L6RUvJ4E1Nid/RGedgKqNc1DPU8Sf++u5j/9rX
         HMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298891; x=1718903691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWKKc9/VVGODzNuhTkLxFLmhIceztWrJoblOszvDngE=;
        b=BuTGD7UFisrDAm2m3hzBPRy/WYXuN6fYl3w/fq0gDiN7n3zntjoXdsgs75TekM6OY5
         2xQ6F3ObJsxS4xP1D7uqGXzuHxCn+66eQ3zImfXen9BMD9lTY0p+Qp9K9AfOpU/RgRS4
         UoIM47LxRrgVj4tjaE9g4tt1xYI6DhTM7mrpxaW9IRvQRTAlqxzo/FqtRJwPjM5Uk8Lg
         mDc/O0PW8+v9nFpBg6dagUhG0pILg3rVLwsWmsOjcAtL9MF9Ek503hg/EjNYc0sLXBaf
         ZfBSi9hQREPAqKyzA8NMEaMCJweIgZgqjCRSdJMSXt7yoLgUhUEfF04v88Fq/CCJjujy
         UZWg==
X-Forwarded-Encrypted: i=1; AJvYcCVcBeOcvmiAuEv1ycZsoAaZASPxCzouIbxbvKYyfWqWM9zXfsH5OOnBQldBZu37DA4MW1EfbgDbORk50ILe48l4WPshMBIhFK9sckFP
X-Gm-Message-State: AOJu0YxhpZYUu7QP7BmuAdyKlA6bNTaYeGr5zN85WYfvoEbfsQCWsjUw
	F+DIPIOw61AlzJeazX7k2Nqi0Je9ZXRx898maWRBmnN4b3yzBzAKePWJhg4I7Gs=
X-Google-Smtp-Source: AGHT+IHklgQWIpYY76YIpc507mgBwe7YRfUtJ7t8FaDKK4F93+FO1RhmCjEna4DXn6WioYV2N57SxA==
X-Received: by 2002:a17:903:244a:b0:1f7:1a31:fae8 with SMTP id d9443c01a7336-1f8625cf24dmr3968735ad.26.1718298890952;
        Thu, 13 Jun 2024 10:14:50 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55eb0sm16445035ad.18.2024.06.13.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:14:50 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 1/3] riscv: Enable cbo.zero only when all harts support Zicboz
Date: Thu, 13 Jun 2024 10:14:39 -0700
Message-ID: <20240613171447.3176616-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240613171447.3176616-1-samuel.holland@sifive.com>
References: <20240613171447.3176616-1-samuel.holland@sifive.com>
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
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/kernel/cpufeature.c | 7 ++++++-
 arch/riscv/kernel/suspend.c    | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1d6e4fda00f8..4347c9f91dc3 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -27,6 +27,8 @@
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
+static bool any_cpu_has_zicboz;
+
 unsigned long elf_hwcap __read_mostly;
 
 /* Host ISA bitmap */
@@ -92,6 +94,7 @@ static bool riscv_isa_extension_check(int id)
 			pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
 			return false;
 		}
+		any_cpu_has_zicboz = true;
 		return true;
 	case RISCV_ISA_EXT_INVALID:
 		return false;
@@ -768,8 +771,10 @@ unsigned long riscv_get_elf_hwcap(void)
 
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
2.44.1


