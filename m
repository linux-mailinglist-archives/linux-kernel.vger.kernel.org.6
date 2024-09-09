Return-Path: <linux-kernel+bounces-320966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208F69712AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4334282B03
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423821B1D49;
	Mon,  9 Sep 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JJbm2UWh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFE14B94A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872175; cv=none; b=a4hqOx4Z57zPtorYLP4zw95n454SbyIDgrpuTREU91kKfiiTNsj/cK01B+8/qYKy/IO2fJIQcEmVmbYRlL+XsO4zPKQhK+017Jcs3qj4ig/hP8ws+gK1UjmWGh/FunfBjAET5p1Rbw8KjiKGRbwf8jcPunrE85DYXzxFr2dkJn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872175; c=relaxed/simple;
	bh=M2gjDYhW0Lq1cfzzc7G73pLRwWKz7XUt96Bt/m9lFyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTifZIpwzAGZGB60kgNfA4/ILuFV4pRNHTzz4wW7Rv8CqPWNVt1kYnCTZO5qEIHjhtbdslxK+dnQsxdImbbbRWNP5HGk/K0dubUxfs7Wp0GDn2hEcANU1TATg4seL20dsrr5EkJ5XrAJYaiykMs1IJe05mCIFrbXelim4W9UMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JJbm2UWh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso36648605e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1725872172; x=1726476972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv2AR1woNQLYJ0Fp1iRI0UhGVzR3YfrOcxidNB7ijGc=;
        b=JJbm2UWhdtr2C6xQyY6GeDfyoxBHonGEr4hYwl6dEwghBc8LaKJ/nzCSIwiKBPgdGK
         jpEePulJS3RMoXasNdgt+DcsawOei6vScsB3m9wrDlCN0pGl0e3MNr3KLT0QdAif5xcT
         oGlb+xwWvxGjA7GCic/Nl+UaGov4pvfej7FGsm+wSavsCF488TV5aq25ouzAUOqrB43+
         zs8NEbtOUi7Kt9s6AzbJqMzhxlKvj1j9moBeKpJvw8HwjVoyEuKfcdeAJFZR7vylPgp/
         XpscX6zxD0PiYV1khM5Cgo0gSxPfj7lGikKJBqa2aIW+lZpk3fjq42YpMX5huiVwj+t0
         a8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725872172; x=1726476972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uv2AR1woNQLYJ0Fp1iRI0UhGVzR3YfrOcxidNB7ijGc=;
        b=kgaXO2uCDszhZApFMnbzP36T8AQgEG/te2xfDa4r2Fr7PuOP9ITctLJDg2WZXBTn9L
         Dj1FTeJq0xMFM9prpNSptdhqiiABC7cYEr/oIuHE6oY7YKOlmpTpOGSoMt+xVu4VLnag
         iM0YOO00ZBb4jKWA0cCM/DicbctvWpPKUaCPNYoYg/o1/PXoF1Qu3NkwgGHT14x83CNs
         bCyddpbmUGUx7FUX6/0v7LUg72NZ9xavk3yjDhJg0trinesx8h1zIbvnTVUQUTTzTYPb
         jDJQpLS8o+MCbeWdab71GTADPgZHfvcDUgaIOTEQMSTUrQ7eULAgP/isQOjtoOTr7ZoP
         X53g==
X-Forwarded-Encrypted: i=1; AJvYcCXCebFa2/E8irY/Jm/vxSlk2yTaNPYeTIKR0Z1I5pC6LtccYQ9TEla4aJ/kTNz8u6WXG2vPj7SwBgQXz3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwaONzs/0dA74sz0gSLlcXt+pyB2knN6Quz2Tq9Va/qZ+KKuIn
	yprrNO1v+Vn4ElpvNappvIszxestexG1y/kuZIQBU8guDxljCGx9LKyeB40JF18=
X-Google-Smtp-Source: AGHT+IFXzJCsb3FQafzENF2vACJ7ZcGkiKnDKQ091lFVFb0euHttZG/dYayGyB4fQORiKo5lMDqVRg==
X-Received: by 2002:a05:600c:1c06:b0:42c:b95c:65b7 with SMTP id 5b1f17b1804b1-42cb95c693amr10352915e9.8.1725872171244;
        Mon, 09 Sep 2024 01:56:11 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb2a08a1dsm50929395e9.1.2024.09.09.01.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:56:10 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: anup@brainfault.org,
	tglx@linutronix.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH] irqchip/riscv-imsic: Fix output text of base address
Date: Mon,  9 Sep 2024 10:56:11 +0200
Message-ID: <20240909085610.46625-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "per-CPU IDs ... at base ..." info log is outputting a physical
address, not a PPN.

Fixes: 027e125acdba ("irqchip/riscv-imsic: Add device MSI domain support for platform devices")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 11723a763c10..c5ec66e0bfd3 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -340,7 +340,7 @@ int imsic_irqdomain_init(void)
 		imsic->fwnode, global->hart_index_bits, global->guest_index_bits);
 	pr_info("%pfwP: group-index-bits: %d, group-index-shift: %d\n",
 		imsic->fwnode, global->group_index_bits, global->group_index_shift);
-	pr_info("%pfwP: per-CPU IDs %d at base PPN %pa\n",
+	pr_info("%pfwP: per-CPU IDs %d at base address %pa\n",
 		imsic->fwnode, global->nr_ids, &global->base_addr);
 	pr_info("%pfwP: total %d interrupts available\n",
 		imsic->fwnode, num_possible_cpus() * (global->nr_ids - 1));
-- 
2.46.0


