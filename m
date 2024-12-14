Return-Path: <linux-kernel+bounces-446126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8321C9F2019
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B40188461A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262FA1B394C;
	Sat, 14 Dec 2024 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="L/WpQJKV"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5E1AC429
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197236; cv=none; b=V6ke3QjeUZ7uX/p0D8oI1IDV+iYv84nH1Vv44zfNpQ8lSxdWi06Yfa1qMSsOTy7e+B8rPmplkVRXwU5tPRebSYqGjYTk7BV7cZ5vLH55Tfb30tLy1rOGk7rNSET/ZDkoudFas//96hUcU5OX6+nHrH6+lzcqCPRt5m7UCTiY0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197236; c=relaxed/simple;
	bh=rcWXudtubpY/LSH8y20isvvWa3ivWgmUdiDIzyRLaJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOnOVqIFvaokQCF7U+ubnQWmlfY4XakPftU+4cZxszQi75XbP02bWruJByuqHal3hpXCbiX31fadm+pepm9s8DRT9nfScuhOUaEuAZfUHEU2kpWUiZSNGvJoHxVypvfiQioZ17ubfpmhdH3PSdHdxAmaHtoOpephM0lfbx6hoPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=L/WpQJKV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efded08c79so1919805a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734197234; x=1734802034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP+pJC86HytY47PbI5sMBg+o5TFAFMoqjjekp4WBZSk=;
        b=L/WpQJKVwRCMzuBpUIPkpyuxxiQvlsDAzHCIKFAn8RRm+0kqZLakdH6iqjOHyAZbrE
         v3kwJM0Bvy/fgA1X5WnSwiYdQknQLVbd0SGs7tAAiDHFfqB0U+/UVPFG7Cx06FqTbbmY
         urw5WPxUEVp/AfvIP/owoTY7P9D5vrzz5x5EizCC3actuJUF/ZydOEewGlZMtxTo7FUv
         zBGl5cLYUe//2LIWrH6+VnyBvA4ThjEDiYJmWYd2OrLQP+ZHwCcGVYom0L02Mt6PYZhv
         sw7aKkXarYcQ6bnXWLR3nY0ALnrbDMFPFnJii3/8COfNF3gT8RluCwtopfsxa286RKAp
         BoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197234; x=1734802034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EP+pJC86HytY47PbI5sMBg+o5TFAFMoqjjekp4WBZSk=;
        b=kxhdj0pjYdTlj6JaiWsaIhzwMFA3kPAhQwczjRHVDxct2ja6SvkNrcb3lkiafVwikx
         v3QVV36W4kMLkuq3rvjCdKF5EQKpO9afvL8ljhDh7ThxMWWQoosgYsqnt23J2OGtjXGA
         m2M3mnIfyuc6nEUHsTD9ID+rlSV7UDBWMmYsaYJ5amE3flm7sIDggXCJqIl+/+tNQBzV
         I3NuvaAhhHLfHwUJUenWLa8XgbEwbIveO+EF1sqqvFYIgV+11DpFoiEZ10qt5BpBafI+
         ynXImEdTpY23unoI6Y0JUovZD3IGz++OQvucjvnSwu7tLm+/gBSkYMg2UmG3GIaT9oh6
         4jzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEKdMAPZZplHWu1cVTtm8Fxhyy+SvXakG6D1h6LiddzNYhrmV3y5/NTqfHtnyhqAdDrh0EXX1zq5KH/f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYiRN/FN/Kzur+dMMGHPWnWPdME+hQMVsgGbc/tRssy71J8Vx
	7YwuPkI1IwwgoWua1MHmz67uaI+eNqVP2SuaX9xRpM0R5mhefLAW4dDttSXsFJU=
X-Gm-Gg: ASbGnctunNhC5ziHf40wQueZnhHc8uZu1NccZIlQkX0AT7iN5lCd9981vrN0aAIDise
	lraVG/4Y5utA/6gzLuWUoGquuCWidgEPI+h2M1cOVCo/rWJFs4lA2RrTlcTgj9tfUMfeFkyI1NE
	p/5KO5SqzPfLKcC2TWmDPBjlAWfl2qN3mIjxPRg9vCCGXXaOUQILMnQdbttexCNRPYzx1MS4qa9
	uLi/uIuisy553X5m15ZL4QsRAyhM+OJC9cZZmPb4vk8AF8L1fLP2VSghmPFLRhaWPa901tSB/h1
	UBGE1KhWrI52Oh8=
X-Google-Smtp-Source: AGHT+IEViE/EyOEoU9avO8xOUuGHIK7Nu4di+ccQuUelW0qrSBcAUC23H6R13dSAPO44yc0spDyzYw==
X-Received: by 2002:a17:90a:ec84:b0:2ee:f80c:6889 with SMTP id 98e67ed59e1d1-2f290dbce03mr10584296a91.33.1734197234199;
        Sat, 14 Dec 2024 09:27:14 -0800 (PST)
Received: from localhost.localdomain ([223.185.132.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm5049811a91.41.2024.12.14.09.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 09:27:13 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 10/11] irqchip/riscv-imsic: Replace hwirq with irq in the IMSIC vector
Date: Sat, 14 Dec 2024 22:55:48 +0530
Message-ID: <20241214172549.8842-11-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214172549.8842-1-apatel@ventanamicro.com>
References: <20241214172549.8842-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the imsic_handle_irq() uses generic_handle_domain_irq() to
handle the irq which internally has an extra step of resolving hwirq
using domain. This extra step can be avoided by replacing hwirq with
irq in the IMSIC vector and directly calling generic_handle_irq().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-early.c    | 6 ++----
 drivers/irqchip/irq-riscv-imsic-platform.c | 2 +-
 drivers/irqchip/irq-riscv-imsic-state.c    | 8 ++++----
 drivers/irqchip/irq-riscv-imsic-state.h    | 4 ++--
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 73a93ce8668f..0c94ce8ce580 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -73,7 +73,7 @@ static int __init imsic_ipi_domain_init(void) { return 0; }
 static void imsic_handle_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int err, cpu = smp_processor_id();
+	int cpu = smp_processor_id();
 	struct imsic_vector *vec;
 	unsigned long local_id;
 
@@ -103,9 +103,7 @@ static void imsic_handle_irq(struct irq_desc *desc)
 			continue;
 		}
 
-		err = generic_handle_domain_irq(imsic->base_domain, vec->hwirq);
-		if (unlikely(err))
-			pr_warn_ratelimited("hwirq 0x%x mapping not found\n", vec->hwirq);
+		generic_handle_irq(vec->irq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index fae47b8ccf73..e6c81718ba78 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -112,7 +112,7 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 		return -EBUSY;
 
 	/* Get a new vector on the desired set of CPUs */
-	new_vec = imsic_vector_alloc(old_vec->hwirq, mask_val);
+	new_vec = imsic_vector_alloc(old_vec->irq, mask_val);
 	if (!new_vec)
 		return -ENOSPC;
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index c915a5cf4187..aca769d915bf 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -434,7 +434,7 @@ struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned int l
 	return &lpriv->vectors[local_id];
 }
 
-struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask *mask)
+struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpumask *mask)
 {
 	struct imsic_vector *vec = NULL;
 	struct imsic_local_priv *lpriv;
@@ -450,7 +450,7 @@ struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask
 
 	lpriv = per_cpu_ptr(imsic->lpriv, cpu);
 	vec = &lpriv->vectors[local_id];
-	vec->hwirq = hwirq;
+	vec->irq = irq;
 	vec->enable = false;
 	vec->move_next = NULL;
 	vec->move_prev = NULL;
@@ -463,7 +463,7 @@ void imsic_vector_free(struct imsic_vector *vec)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
-	vec->hwirq = UINT_MAX;
+	vec->irq = 0;
 	irq_matrix_free(imsic->matrix, vec->cpu, vec->local_id, false);
 	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
 }
@@ -522,7 +522,7 @@ static int __init imsic_local_init(void)
 			vec = &lpriv->vectors[i];
 			vec->cpu = cpu;
 			vec->local_id = i;
-			vec->hwirq = UINT_MAX;
+			vec->irq = 0;
 		}
 	}
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 19dea0c77738..3202ffa4e849 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -20,7 +20,7 @@ struct imsic_vector {
 	unsigned int				cpu;
 	unsigned int				local_id;
 	/* Details saved by driver in the vector */
-	unsigned int				hwirq;
+	unsigned int				irq;
 	/* Details accessed using local lock held */
 	bool					enable;
 	struct imsic_vector			*move_next;
@@ -96,7 +96,7 @@ void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_ve
 
 struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned int local_id);
 
-struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask *mask);
+struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpumask *mask);
 void imsic_vector_free(struct imsic_vector *vector);
 
 void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, int ind);
-- 
2.43.0


