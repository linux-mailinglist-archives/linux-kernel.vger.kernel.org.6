Return-Path: <linux-kernel+bounces-446122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873249F2015
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4921887F5F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627771A8F86;
	Sat, 14 Dec 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="d3DgLXZe"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD6C1A8F80
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197208; cv=none; b=uwdRXFuzq/lmSlyNHKk91ll4RAli88+Rt7KYEQfqUqxzRn1S9kk+biq/iGrS3aNcAlcoEr7D1kbzQjM1fPx2cm3CHG6BbNvplm8MI/LTGsOMI1WGpHuJA+NniTJ9+9UtNxGyFExDoKli64uhvGPInrCNrd23un4HeeI2223WRlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197208; c=relaxed/simple;
	bh=KQvgHMf4mn/NJ5Xhw6rUHo6j+G4++aBmhNInEZUS85A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSNXVP+v2NqgZyjQLLNote34tuL/3uYjAoJQTvbS+9CeAYBMJQkng3bg9VxyuUc+y5U0rhexTnwFFoNFunxA5rrYjad/aAJxtYziA1DRK9t02zAqMXpSPKzWx7rRBNxwJOwKR3VIjFt3OcKGioWMzZr5A8pWob/tb9Tqp08YhXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=d3DgLXZe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2164b1f05caso26267355ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734197207; x=1734802007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBJthI+mqNYzorludLEAXvfiuDja+LCnD6djvnBek6Y=;
        b=d3DgLXZew7K5QBclQ/cD4nFeStj8kh5eg8R+odpkIxGz4dz0rZwxoegej0l1UyWcN3
         fXBpLC3wuTvnoqcQ3HvAoVBLtcSrQp0IWFQ6c3qcaRXteWaUH5u2d6o8bD7pe6mFlY5F
         pllPV52jlH+UKjWs3ReSLm1bhIlJyWWDb4YqCJ7w2/0sObNro51axkAylCYAwE3Za5EL
         SoWZE7eRQFzRLJBmOLhOVKqWQZx5SH0GjXBsaWfpLcUdfxZEwaY38zj9MCF8ELOCkFIB
         ebGjCFh4I561go/VS1r7bI9TvwBZ3hoR3RqQ/BC0QkBFlgxK3UWjPzl2xa+8V/d40Hkh
         vOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197207; x=1734802007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBJthI+mqNYzorludLEAXvfiuDja+LCnD6djvnBek6Y=;
        b=bc6T6U4Y9Sl52UVlCARJRxXeCumsKT2y5w/jx/LoOvhgTgqFPzDHQa+1Y7SHxLOpz1
         fEY6fBTvmqQvQsQjfN8woe7KWN6/vmPjboqVO7AducbZWL3f6dnypcm4DByQvKQOkX08
         WI4wckseBjkB8jEdQtk6i9p7jvZlDqeZ2s6BQakHYa3I/PXUnRaK85EoDOdGJrqw2byz
         QSqWkzlLNtmH+96FK5cFBqQHmTgNzg8gz1TnjJ1Tq345yN24VAUvMabEUt+plhGCSTTu
         LyxmPDSlBUobqLPT0gjq4oEKUIqbjJ2GW9OzL+tmo/53YomwJIOZAFH11QAnN7l8YWN3
         k2eA==
X-Forwarded-Encrypted: i=1; AJvYcCXovZ/E7k06nc5Bv0iZvpS6szVH7w94v9jCi3ueavDUZD6KJgtwb5P9g+dU4t2qRtLyI8c/i3VBqaI2TNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0BTgNtc8D6kzjScRPhIv8CRUL6PXWLjjA80VVoS+t/WC9TVo
	X+TCkJlxnxEv3MV3A84UmsbwIyRO0xCFOyewyJWqcEwcGSyoDXOj2h2yxP0QG6o=
X-Gm-Gg: ASbGncuP0AOeEuXgETOxuIcqbQC+oTryl3lH6tqjd5pnb4yzPHgvEgBBF/mXz9tifwo
	LIkpKLBHbn8vE/XXRxp/SL9UNilW6SFmsC44XeGNPZCLdzUhuV5Adc9tnyLCX5wfo67S5E/5fKA
	NcOkWzXOoIjAsK9gcdgi+CZvYkKAjUZ/8zf5B5Mkq+VQz1OrBPtE2PGVHzB8hMifKQeolgn8jOm
	BpSUn7gFrSjb30uuaL8HDx+sfXdvbFgkXeRaRbkEjAM9zolFxuUzNi7n6UIO9pn+lyZfML8MV8a
	H2j+XL8hVSauT8Q=
X-Google-Smtp-Source: AGHT+IHWMVLk7VAHEJKffclkR/GgfiztR1cE76mj+f0onDTerIF7KBl2vajNkAVkEerHi9sn/JzVIA==
X-Received: by 2002:a17:902:ccd0:b0:216:3466:7414 with SMTP id d9443c01a7336-21892a41a9dmr113376145ad.44.1734197206669;
        Sat, 14 Dec 2024 09:26:46 -0800 (PST)
Received: from localhost.localdomain ([223.185.132.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm5049811a91.41.2024.12.14.09.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 09:26:46 -0800 (PST)
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
Subject: [PATCH v2 06/11] genirq: Introduce common irq_force_complete_move() implementation
Date: Sat, 14 Dec 2024 22:55:44 +0530
Message-ID: <20241214172549.8842-7-apatel@ventanamicro.com>
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

The GENERIC_PENDING_IRQ requires an arch specific implementation
of irq_force_complete_move(). At the moment, only x86 implements
this but for RISC-V the irq_force_complete_move() is only needed
when RISC-V IMSIC driver is in use and not needed otherwise.

To address the above, introduce common weak implementation of
the irq_force_complete_move() which lets irqchip do the actual
irq_force_complete_move().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/irq.h    | 5 +++++
 kernel/irq/migration.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b689c8fe8d60..509c0ee4ef38 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -496,6 +496,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @ipi_send_mask:	send an IPI to destination cpus in cpumask
  * @irq_nmi_setup:	function called from core code before enabling an NMI
  * @irq_nmi_teardown:	function called from core code after disabling an NMI
+ * @irq_force_complete_move:	optional function to force complete pending irq move
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -547,6 +548,10 @@ struct irq_chip {
 	int		(*irq_nmi_setup)(struct irq_data *data);
 	void		(*irq_nmi_teardown)(struct irq_data *data);
 
+#if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
+	void		(*irq_force_complete_move)(struct irq_data *data);
+#endif
+
 	unsigned long	flags;
 };
 
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index eb150afd671f..2920024475a3 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -5,6 +5,15 @@
 
 #include "internals.h"
 
+void __weak irq_force_complete_move(struct irq_desc *desc)
+{
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip = irq_data_get_irq_chip(d);
+
+	if (chip && chip->irq_force_complete_move)
+		chip->irq_force_complete_move(d);
+}
+
 /**
  * irq_fixup_move_pending - Cleanup irq move pending from a dying CPU
  * @desc:		Interrupt descriptor to clean up
-- 
2.43.0


