Return-Path: <linux-kernel+bounces-306081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0729638DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA581F232DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23D84C618;
	Thu, 29 Aug 2024 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QqROOwUh"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2C49626
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902779; cv=none; b=GzI8jlSL9UusMma1euPdF70JW/lJ/+Rjl7sNvIcCfosJRgbgeMJ0wGm/SOzbhtWzj6PxC0JbNuMyv8XLu0tNwOVxgpBxM+/IH7L6OySk62KVLBTdtDCrr1IVP8yGlsyNivyD1fpvxwcTrbFlFcTDCw6JuKz4taary2EmD2XZO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902779; c=relaxed/simple;
	bh=EbBEvc0PKXsSnG7+GH+yqgj1djjwXCeEDQP2lGPTKew=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N46iaVRQZ3UmNTzrF4Z40qhEOry4iUzJZATYk7sPSDJ5WIAludvsws0KVZ8GQFV20zHEsfmJa1Q+CjwlGcbWIn0oF9DseFkzfHAP1NNsISfW0jrz57/Y6zIKsfLYr76EcIz55weKerlaw6BPrEEu9dQJzfyTbGPJErRSvOOV+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QqROOwUh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-202376301e6so1490265ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724902776; x=1725507576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3GAnBxuP0k13UOo0B/EnxeGCQ0ew6a+lFlFL3wfeVM=;
        b=QqROOwUhd5EyI5k97vdfTkdEbkoipbTIKQcIHtHtNtqnh3kcM0V7/I4b1QclvIfoqz
         h0ISggYy6MbUl1T5KqsdNOGETszwXJCVl4LuOr8BbUkL6Hk+EuCAiUvMEo2APzKgCLDl
         ATDqmdAzDUsq48LjyWozoSSkXIEWegS852/EneBDlnJfzeF1WeZJXPtMq28hlKhLhv/1
         YInDuysa6n90K98yGymmduRaCcRLqQk3vnZuh2sQK8+kzqrjgR1HWSrapuHl6qIQJ64x
         jRr29aMM8XgcpIkZhNark9BJVRLj/Tvh5qj8GNo5IQRZUmTTiu079v++CQYl+aMOU+2e
         08dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724902776; x=1725507576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3GAnBxuP0k13UOo0B/EnxeGCQ0ew6a+lFlFL3wfeVM=;
        b=U9eDarSmZyR1kzlbkHY+nXVL23ETPrIimavTanswxj6XZqYmrhiuwEh2MbybgWR6E3
         r3lHVikPOOrgCaecEHuPXYOtLIbsUzFG5jymA12PnCHBhgpf3k5RhJblCkENKULkGXG6
         VZtrmPJ/0iN0uTvEKNX3sv8CH/fUOeW8P+RGUiaitlk2OwJkbPqqLeg1A8qJxcBmhVoL
         wm14YvlNHKcLWdOpzaVyD8POWrTavxzPTGNTOi/ThioCR/duo20UrwLfS+FfBHgdFSQH
         f44BIjwHSS6hi2MVfzaPrLUHJJB37Tm0SR1ricXVetyNlqRucYiuzOUZ35M9IuLRwqnB
         BaRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLpWvJnLsPyjWFQ4JyyOjreK9KkqtHokuwhd8Gl6+pON6b92lPaWGlS3WVCKWEq2Yt1AGbMK+1X2BhxUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywhgDPnr+aQ/aCGsuQkBU0QorfjBIsWQUqsiIoJiov6KGp5pYd
	cqkyDI9aAKJtj7wvYn2gHOsAOSlK2C8C1S+Kn62Gqj7JMxTdfb9ZyOz0Y02zidk=
X-Google-Smtp-Source: AGHT+IH/8fsuBgr/qoojKI4pyRmSBKKLvKU8OllZIsbVlPHRLEjgz17SXXEQ34o9DYQ5ZzKFjsFW3Q==
X-Received: by 2002:a17:902:d50d:b0:202:5075:428d with SMTP id d9443c01a7336-2050c4b6ca4mr16399455ad.64.1724902775824;
        Wed, 28 Aug 2024 20:39:35 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515542498sm2056065ad.188.2024.08.28.20.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:39:35 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: greentime.hu@sifive.com,
	zong.li@sifive.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Hu <nick.hu@sifive.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv: Add stimecmp save and restore
Date: Thu, 29 Aug 2024 11:38:59 +0800
Message-Id: <20240829033904.477200-2-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829033904.477200-1-nick.hu@sifive.com>
References: <20240829033904.477200-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the HW support the SSTC extension, we should save and restore the
stimecmp register while cpu non retention suspend.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 arch/riscv/include/asm/suspend.h |  4 ++++
 arch/riscv/kernel/suspend.c      | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 4ffb022b097f..ffaac2efabb5 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -16,6 +16,10 @@ struct suspend_context {
 	unsigned long envcfg;
 	unsigned long tvec;
 	unsigned long ie;
+#if __riscv_xlen < 64
+	unsigned long stimecmph;
+#endif
+	unsigned long stimecmp;
 #ifdef CONFIG_MMU
 	unsigned long satp;
 #endif
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index c8cec0cc5833..3afd86e1abf7 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -19,6 +19,12 @@ void suspend_save_csrs(struct suspend_context *context)
 	context->tvec = csr_read(CSR_TVEC);
 	context->ie = csr_read(CSR_IE);
 
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		context->stimecmp = csr_read(CSR_STIMECMP);
+#if __riscv_xlen < 64
+		context->stimecmph = csr_read(CSR_STIMECMPH);
+#endif
+	}
 	/*
 	 * No need to save/restore IP CSR (i.e. MIP or SIP) because:
 	 *
@@ -42,6 +48,13 @@ void suspend_restore_csrs(struct suspend_context *context)
 	csr_write(CSR_TVEC, context->tvec);
 	csr_write(CSR_IE, context->ie);
 
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		csr_write(CSR_STIMECMP, context->stimecmp);
+#if __riscv_xlen < 64
+		csr_write(CSR_STIMECMPH, context->stimecmph);
+#endif
+	}
+
 #ifdef CONFIG_MMU
 	csr_write(CSR_SATP, context->satp);
 #endif
-- 
2.34.1


