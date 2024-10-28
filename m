Return-Path: <linux-kernel+bounces-384044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B710C9B2392
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 04:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE671F21B71
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F518A6D5;
	Mon, 28 Oct 2024 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cTo/Yzyr"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E82418A6BC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730086785; cv=none; b=fpCcc2eTUi3cMY6GWOk7Epn0ZqKhvC7C9EY1Lyqs76XlkCuUInxWBRoPgADSMv9BoYzdTdwb7qTLK1a3lYP+iOpJFYhSbQ4/qzF466PE4Auezt7smGjjgD2aEHAybetW2vrDiOdXlOtnK+4O4CXAjT1oMCfC1AReU71QscCRNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730086785; c=relaxed/simple;
	bh=IOaCLXtRKMj1XaFGEqYfcoGSRq0kGRGrZLs1Q90y+f4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k7g4gILgvgXD2Zw3Lk0cJc6fx6A3cj9iEqkTzDFzb1S+w22GDUCibGj/VBhDJtc04jAKHQu0ngPJGKPkMCoSgyZeofK+O5ajCO0uE4c7aHB4Sq5wpf182w2Dn3GkiJeEnOl0jR+noUBCfjWX/R33jetP76KRDhV8y3IH0DujIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cTo/Yzyr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso2826223a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730086781; x=1730691581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riHqjf4TEkSfIjrBl/2OcUP/uMFiYpg8/raWLqLOU7Y=;
        b=cTo/YzyriVjyxoo3WAYLN1GXww0W6Ok830S2VEszvPSeLEvE5Kx19S0rYdQel/0nO+
         0rivDnTkqnYhCiq+jalsniPPQkqUAo0FppzWEHe1A0X4wo9Yw700UvUsbUYCk3NjlVhP
         gaXGfGS3FRpgKcOarrHr40yB/UWWCST1u/5UiPqTD9nu/JpNlJ7mfnhXFOBl4J+onS2/
         2pt5sI3WoMVdANsJzb/ilVml6FFqX88fc1b5nFAb1Xb665p4369ggB2Dg9hEVeVY//VN
         MJmXnpj5/37mjVUbn3LkCwTBBIVaMs8p8udjjKrDDyfnUcbsN8Vwig5fI4P2lUd6r6aT
         M+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730086781; x=1730691581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riHqjf4TEkSfIjrBl/2OcUP/uMFiYpg8/raWLqLOU7Y=;
        b=I3Bzm34TSXWNcyoddARtPdvqFJW9jv2qaE0uldqSzfOkV0iGD5X9p3JeBG/zNLU3F3
         uE9B58M5WoW/IM/+T7glvNpf0YDvBD+0kp1VM80z5pr02O+Yr4bP6L4o/GUMqiH+WVwa
         XQlfh3JIzylMoGq00GXxFpkQZ/2QNXNIeQDoRKchcECxvPbrpX5cBAE7kV6pyPZ0QAYa
         89FLehN9zz4gzbPXkrErwylSEmXt5rN7HYRyvpV1vajH/pAge+Mw8sKQK40U8ZRhbmAi
         B7XBXGgf0Epzm8ALPum+WqTbK7XcfEMIa29Lc5CFkjwaRne+6est1hvjemIN4E5gdqHB
         VZxA==
X-Forwarded-Encrypted: i=1; AJvYcCWdFe3hwRq84Zel3rrb6jdSzgecNt2JOpoh3u/9Fi0Mv4vgiy5B4SS8TzHIUxg2KpcpOL1aBJ+5ROesN8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgsk3rZcifIG6fE5pXGTjztRK3v5sXZkKTExj87CYW4tRA8kvo
	747tuFutwr4Kw9yJSI3iIRjsr2mkAH+DPqPnpxxgdv9V2njMa5wfkRoXO/I8GnY=
X-Google-Smtp-Source: AGHT+IFvmxoPCy/7sSomoKgH2rLyOpEyqOsKkL4VWxhavzi+tm5x5d2JksHbArO8sToXYxd+TOAmNQ==
X-Received: by 2002:a17:90a:1c16:b0:2e2:e937:7141 with SMTP id 98e67ed59e1d1-2e8f107d831mr7994236a91.20.1730086781313;
        Sun, 27 Oct 2024 20:39:41 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e340e544sm5961888a91.0.2024.10.27.20.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:39:41 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Hu <nick.hu@sifive.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] riscv: Add stimecmp save and restore
Date: Mon, 28 Oct 2024 11:39:25 +0800
Message-Id: <20241028033928.223218-2-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028033928.223218-1-nick.hu@sifive.com>
References: <20241028033928.223218-1-nick.hu@sifive.com>
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
 arch/riscv/kernel/suspend.c      | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 4ffb022b097f..dc5782b5fbad 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -18,6 +18,10 @@ struct suspend_context {
 	unsigned long ie;
 #ifdef CONFIG_MMU
 	unsigned long satp;
+	unsigned long stimecmp;
+#if __riscv_xlen < 64
+	unsigned long stimecmph;
+#endif
 #endif
 };
 
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 9a8a0dc035b2..24b3f57d467f 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -30,6 +30,13 @@ void suspend_save_csrs(struct suspend_context *context)
 	 */
 
 #ifdef CONFIG_MMU
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		context->stimecmp = csr_read(CSR_STIMECMP);
+#if __riscv_xlen < 64
+		context->stimecmph = csr_read(CSR_STIMECMPH);
+#endif
+	}
+
 	context->satp = csr_read(CSR_SATP);
 #endif
 }
@@ -43,6 +50,13 @@ void suspend_restore_csrs(struct suspend_context *context)
 	csr_write(CSR_IE, context->ie);
 
 #ifdef CONFIG_MMU
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		csr_write(CSR_STIMECMP, context->stimecmp);
+#if __riscv_xlen < 64
+		csr_write(CSR_STIMECMPH, context->stimecmph);
+#endif
+	}
+
 	csr_write(CSR_SATP, context->satp);
 #endif
 }
-- 
2.34.1


