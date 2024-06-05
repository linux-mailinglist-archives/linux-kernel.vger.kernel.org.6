Return-Path: <linux-kernel+bounces-203216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F888FD7F6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6A2B214A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F1F15F3E2;
	Wed,  5 Jun 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Tbbq1xIT"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA915F41F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621024; cv=none; b=bFfT72hz8axh2eIn+vTzlL8oxnWmBE4z90SwZFehU7Hc5YjtVXYBOsSUgIcwZ/512vKDs7kE+Fm3zMm/2xNr1nLUiBnYRAoDHqiZDfrQoGqXCs0YuGBK7CneAwCAmjHT/KHD9wrW9q8Pgob6nsyXGLW7SpqQBh2zY5VVhSta2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621024; c=relaxed/simple;
	bh=UwGdShtt55ngYaoblk5KGQivCkS0QFEToBpGh5fXpGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3wqiLK5zn9WC7spenJn8lxX7K3zuqWF3ABR25bvui+pg+++xvukKpHQFlaprNKS0sWHmxflIwfIb+sYt2YvutmIVhbKIUJI/M/xJ6Dwmj3lwd6P1bM/mNA4o9B8QKH32kDPY3Nw1kgYYBf9D1h+GED2p1QWJURIRyieMAuJlH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Tbbq1xIT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6ad2e2f5bso2745075ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717621022; x=1718225822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2bVegCzCkDHXMVMeg8qYCHprvPezD5elt/KHLJxQVU=;
        b=Tbbq1xITkX1A7ONtD6L1XvJeVLzvf/2Y/5wRvdCzazIkhvFGc2plFjGYOo5wVErEJU
         VnRuU/dIXk7xOG9H0pZftxvsnObCe6YXzW1tek+qD59PsaKxzvgvI/RonX0s+TkeHLVM
         nya8lkqZBl2p9FcM3ibrsakb1GL8UJY9vstETAE2gvrngD18UaFYSOoFC/aFf0vL3dd4
         g3GSoY6QoXTBg7Kh0cl72ZMJAx7mVM1Rc33Zba4vIgxB0Xc75c119VBdy3uedz0rMq23
         nFTIDbhgOUVFyf+5/Vu5ekRRZS4RCOcOC5UBNhTZQUvxqDnMbjeNtLDwdCsHnsvSOHt6
         s0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621022; x=1718225822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2bVegCzCkDHXMVMeg8qYCHprvPezD5elt/KHLJxQVU=;
        b=OVx5Lz1pMaJNBWBAl+I4atJLaqsRfW8pbrZO6OGteE7yr8mjE9dWYxMDurgUKZMZ2V
         /akgSEUeF8T0HoyDr6Xg8YHCDcAqJgxzDtLMh8ajJQjIW37qdOG/ZxiSPEyXdPjzEssQ
         Id6m+45SrTp/uQvv3WrYWoAUYRI9gnGZkCdFmPbpRDyHVrnDvynu2X4dLhC4TJowBy/7
         dDmYCefemqqDM9EXbOrsL9UZYSwbNBlU7Z7k3PnHbbliasfbwAyASROdMDpf4EGsWl2c
         wWZ5OdlY0ZG/zV9rfwThnZBgebRqoKVG3pwOiColxX0bBOXPEHxLKAg9/mqsFL1NhhV1
         rdng==
X-Forwarded-Encrypted: i=1; AJvYcCWFI3vHzvMicEc3KLYNVBDKxqfeyf8MjrNOCQMwKvdKswOi+fwa9WAtpenZpYJHeWYUn7L6MhC2sS9z0l9w/YSEuRq+MJKh9rchHxY3
X-Gm-Message-State: AOJu0Yw6I3vPvkWX+ftQoGb7BFwEyd0ZQV39S6ozTQ8RVBIVhSkqIjtK
	AgC0srNIy5aH8So6R1sALr/mQK24OoQFo7ZjsUcZfStaeCbloN0Q9E3HvKkrdOY=
X-Google-Smtp-Source: AGHT+IEMiuzcom7/QujTrzZBUVPvtMGj/7csXw9/xKWBGQkukRtCW8OVo9AbXr0Dsd33zcb6XPLvdA==
X-Received: by 2002:a17:902:f684:b0:1f6:6ad1:fdf9 with SMTP id d9443c01a7336-1f6a5a84d6cmr39536575ad.57.1717621021640;
        Wed, 05 Jun 2024 13:57:01 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd86esm107332135ad.121.2024.06.05.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:57:01 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 1/3] riscv: Enable cbo.zero only when all harts support Zicboz
Date: Wed,  5 Jun 2024 13:56:45 -0700
Message-ID: <20240605205658.184399-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240605205658.184399-1-samuel.holland@sifive.com>
References: <20240605205658.184399-1-samuel.holland@sifive.com>
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
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/cpufeature.c | 7 ++++++-
 arch/riscv/kernel/suspend.c    | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 5ef48cb20ee1..2879e26dbcd8 100644
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
@@ -724,8 +727,10 @@ unsigned long riscv_get_elf_hwcap(void)
 
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


