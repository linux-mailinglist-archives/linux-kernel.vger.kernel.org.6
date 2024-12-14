Return-Path: <linux-kernel+bounces-446125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AAA9F2018
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8DD7A114F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299CF1ABEBB;
	Sat, 14 Dec 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="c1rijWmo"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072671B394C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197229; cv=none; b=I9TPcFNFpP3SqZet39EU3XNfUCF1fX37NRvuAij+tcg9UFuVgN5NuPa2+lwsn8pFNOZzp/SAIHuGEn79XJS/VxB9SEmAWXMiLQB8qqd6el8E+tRk+GXKyj8sNMRwgeiOrqaR3WR3zrW4f+uEzj5mZL0O3M7Ec+5CPNQo5DoA8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197229; c=relaxed/simple;
	bh=ZmZx+N5nuIhjnt8Ku3H4Aa5bBD/jkRAUPw+E2i+2ziU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvnUn2ZnKn5zFdDWt1o/MowwKvTLN07sxNSqsoq9TzFzUYu/RbhFlO8CnRCgRNfUUnsynSnrLLJM1r4S5wvwTom882aIgg0tz7Fp4Ghun7AYkeyUtZULZEeOTvZZnWwThRIEJ4op8W4oj/bUkOqO1KkmBo0z+u/smtzA51FzEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=c1rijWmo; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso2462019a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734197227; x=1734802027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8c4bSx6OeCafE/EjjWkj4NBjcuAlryx7NpTdvjZLKQ=;
        b=c1rijWmo73SjEJEgsDg/sXWShtIL0EtCgYRIfTJQ5pYRFSD3nvMf9Nd8irP4P2M3sY
         6EP96SHKDQ0w7biXQxybt21x7w72rN0AqF+SxF6P6clSQ2c07/Mp238wNF7To/uXAIlB
         ExfoxXSc/N4qVR9zO9aTRASDBpsHN91/tAIAs/8LOEp3Grvg41AHsHcl/8emVWk2TME1
         heAFDzXFSBf5E4fHQrsK3sLYHldg1bo8PA+sKbxtyKMKJpUEO1JZBywjlMOzSbwxzCMg
         H8wTxWKL++cFr8VCrJWAi1ppLNxqxOLNlbMTbTS3eljtTl9soSq3/aIO8DbwOfotOGQE
         l9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197227; x=1734802027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8c4bSx6OeCafE/EjjWkj4NBjcuAlryx7NpTdvjZLKQ=;
        b=UtiS3f8bSuDr1ZMPHqFSkAmMcRN4ubF2evxsuZv7VnWX35zbF0EECAcdyP3RByUr1Y
         v/2483r3mCnIhKBu3TEGDEpGsMGc1D6Q7rw+JwNhfOXkIaTOaKhjTVTaJk/MA4WXSdlY
         ocrXR4/duN1mo7CbwYmyp+6tXNl+vUtIZJwf7icWT/taFcmtxUHrEZxPATEdMjSt+mIS
         QArTxfExjnMIk2VZA9pu3iaITthN+VRpR21n+2tsVbpAa3ZqzLT8xZcbH+umxY1UnMFp
         o5jJc4Q+3dSbQZZPwvz1W+yEsq3OTGRFpdOcVx+PVKWXlQ+049TK2aHb7TF7h3CqRfHH
         XCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOrv3dCuhVHZgHi5cdsHhqnTTGl5L1aopEs/IaAcLUa8hKlt5KIPBl9TOwLgg9N7FlDoPvUEZ+zZky8Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAm2w4zXtO7q9OCywk3/N1xWP5D6X/cJH3NK5s0fD+hmd1L2v
	znW43LoQ1kDW/1zRjavT/vT7WSElJCuv2K8nwMGcsceO+GYGXemIvizb5NekJ+Q=
X-Gm-Gg: ASbGncuuW6/nb47ubvcq5MPJWB1B9nLklcy7vygtslVm2eUn0Yd8LfPRoJ5y8FyfYdl
	rHUh3XDPkjEvM1somiF7pRkHsj0PUl1WfPZ3p4yqec3MSRyYQWUkcXwytVsi0cJ/Mo+iV8aMLkq
	CAjKPaXWzG4fx4paSjBAXnqrlITiFpkQ5kKV/Cf8M3SKxB4GSPVAPI1LvrhEU4ifL7b+rmqmCbL
	j35M2ttxyrXjMSo21b8YQGxQm8cZP/D1YLSNnuZFRGyldhX1Bb5zyvFoPWriVaIbyiGGGIKcobT
	uVMP7WYUXj7iOR4=
X-Google-Smtp-Source: AGHT+IHUcfTVYGQvMkfUU7jHBszvrCcnJgKMrSzxBafo9cGQC89Lrd4GQaGCXdK1f1d1ktL3gp5V1w==
X-Received: by 2002:a17:90b:4a4f:b0:2ee:9902:18b4 with SMTP id 98e67ed59e1d1-2f2900a9878mr10311790a91.27.1734197227250;
        Sat, 14 Dec 2024 09:27:07 -0800 (PST)
Received: from localhost.localdomain ([223.185.132.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm5049811a91.41.2024.12.14.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 09:27:06 -0800 (PST)
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
Subject: [PATCH v2 09/11] irqchip/riscv-imsic: Implement irq_force_complete_move() for IMSIC
Date: Sat, 14 Dec 2024 22:55:47 +0530
Message-ID: <20241214172549.8842-10-apatel@ventanamicro.com>
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

Implement irq_force_complete_move() for IMSIC driver so that in-flight
vector movements on a CPU can be cleaned-up when the CPU goes down.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 32 ++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.c    | 17 ++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h    |  1 +
 3 files changed, 50 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 2fab20d2ce3e..fae47b8ccf73 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -156,6 +156,37 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 
 	return IRQ_SET_MASK_OK_DONE;
 }
+
+static void imsic_irq_force_complete_move(struct irq_data *d)
+{
+	struct imsic_vector *mvec, *vec = irq_data_get_irq_chip_data(d);
+	unsigned int cpu = smp_processor_id();
+
+	if (WARN_ON(!vec))
+		return;
+
+	/* Do nothing if there is no in-flight move */
+	mvec = imsic_vector_get_move(vec);
+	if (!mvec)
+		return;
+
+	/* Do nothing if the old IMSIC vector does not belong to current CPU */
+	if (mvec->cpu != cpu)
+		return;
+
+	/*
+	 * The best we can do is force cleanup the old IMSIC vector.
+	 *
+	 * The challenges over here are same as x86 vector domain so
+	 * refer to the comments in irq_force_complete_move() function
+	 * implemented at arch/x86/kernel/apic/vector.c.
+	 */
+
+	/* Force cleanup in-flight move */
+	pr_info("IRQ fixup: irq %d move in progress, old vector cpu %d local_id %d\n",
+		d->irq, mvec->cpu, mvec->local_id);
+	imsic_vector_force_move_cleanup(vec);
+}
 #endif
 
 static struct irq_chip imsic_irq_base_chip = {
@@ -164,6 +195,7 @@ static struct irq_chip imsic_irq_base_chip = {
 	.irq_unmask		= imsic_irq_unmask,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= imsic_irq_set_affinity,
+	.irq_force_complete_move = imsic_irq_force_complete_move,
 #endif
 	.irq_retrigger		= imsic_irq_retrigger,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index da49a160ea09..c915a5cf4187 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -323,6 +323,23 @@ void imsic_vector_unmask(struct imsic_vector *vec)
 	raw_spin_unlock(&lpriv->lock);
 }
 
+void imsic_vector_force_move_cleanup(struct imsic_vector *vec)
+{
+	struct imsic_local_priv *lpriv;
+	struct imsic_vector *mvec;
+	unsigned long flags;
+
+	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+
+	mvec = READ_ONCE(vec->move_prev);
+	WRITE_ONCE(vec->move_prev, NULL);
+	if (mvec)
+		imsic_vector_free(mvec);
+
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+}
+
 static bool imsic_vector_move_update(struct imsic_local_priv *lpriv,
 				     struct imsic_vector *vec, bool is_old_vec,
 				     bool new_enable, struct imsic_vector *move_vec)
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index f02842b84ed5..19dea0c77738 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -91,6 +91,7 @@ static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector *ve
 	return READ_ONCE(vec->move_prev);
 }
 
+void imsic_vector_force_move_cleanup(struct imsic_vector *vec);
 void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_vec);
 
 struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned int local_id);
-- 
2.43.0


