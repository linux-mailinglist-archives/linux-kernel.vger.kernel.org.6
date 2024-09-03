Return-Path: <linux-kernel+bounces-313967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3259896ACF9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6305F1C24657
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6691D79B0;
	Tue,  3 Sep 2024 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HNgRFhb+"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8BC126C0B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725406889; cv=none; b=PqU2d15YjWVWrA1MZFbpfLAkX51C/aNpc8i31rcCUdaOquUxB8WeAMBhIhS5vOsULJnRb0O+LBUqDO2qgvJRhSGDGVxif+o6liAvizNEns1puWEZKCY15McOWDllJQpOTZoOI9ArBRLNpE14sCxm3ErLlm3aKjOVYhkyUMlnxvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725406889; c=relaxed/simple;
	bh=NEqMSUiXPJnE6dN6HQOChucnRrDzOVn8LzJu3RmeZNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cmroyd+wNeWnUHaeiXojRPghFJFv3itgTAw2qUj6KT/9abyH+RQYimRwhSizIrQ7HWysl+LlunnDsA+NtictwL//DZIDq/fqM0acNZspkVoeqpSyFiTAJNZIr345xrMhBvy+OSIDz9hyyFQUR7luwuwTvo/Y+QfB6tp/GA4Jb58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HNgRFhb+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71431524f33so4856808b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725406887; x=1726011687; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8bYoZW+QQkfz32T7M8NYqTFSmzIgCZm1Z0RlhJ5J+EY=;
        b=HNgRFhb+DX/Th8lVjTEuhW3pFGyjow5pGw9OdN2Wix6bKmH0vqsf/r8JhKEnCiKKtL
         SfAqLjISROmAMlLJ1WhvOXbISc5y5uhPdqJKMRqQ2SRvDCdJIzzmRspBhhvrqADVGm5+
         Nogpuu07xHYdhNbs9EdhWN0JY+w6yhxPcxnsBPGu5enrSx+EUxR3BqhjP1H2QxIrDWPY
         uU3RBws+MMpUZGHgwtp9e0LENGN5lrgatE0BuVtIv+967JkSr87cAdskxk0HKOc7owLm
         fbQu468CXW+V57yefSKDXwvk4rUxu29TmM/dqD87qnU9i9OYtPk0gZsESJLbks53S8As
         Jqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725406887; x=1726011687;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bYoZW+QQkfz32T7M8NYqTFSmzIgCZm1Z0RlhJ5J+EY=;
        b=UVBXKYBqmfcyLR/+so9vvKN35SfhOVirJmK0ru5MJPFKufD7UGy3HzHfkrZLhHfTW2
         uvqGUQvDXyZJ6wYE0syRW6VTqLkb/i4QgGEMbI6F5DSL9fYVgL28/FFKUKNNW+D3+PDQ
         /dRfXeIwBRJAm0UWs1TDzI3cLshxioJt/+rLOYdY2cOyLnQ0aSvYyuxILxIkWJ1PnDjO
         fLq7M2gKPIwA0eHsp9sIk+hRtXaBQFiAYTV6RaJJRPiMb8U6I8GEYI6YY4iUtfJl++Fa
         okN98zUfQJN/ydnYpzsfTOIU5lpRaXSHyvs8zQGRL/W1XHLYIJ7qBS4AKlWES4Gj//6z
         t4OQ==
X-Gm-Message-State: AOJu0YzPn1Q/ubP36BJsOYbJzJd7m9TEAwsLpe7Bx5Qx+ubNroopxPNZ
	dKKk2adhDVgrmiS4fMzRM5go0Cm88DK8MN+tT5XJcq5jL0tgToS+Jpu1rrQ08vc=
X-Google-Smtp-Source: AGHT+IH7ezt/NbLCrPaBllv4u0hUzRFiNnKEuctKhUStQwRWDmqE/m8sQIb/jU9irTsFdN2m8pF3NA==
X-Received: by 2002:a05:6a21:3115:b0:1cc:eb34:b1c0 with SMTP id adf61e73a8af0-1cecf5145b1mr15795533637.25.1725406886694;
        Tue, 03 Sep 2024 16:41:26 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea354b8sm3338325ad.143.2024.09.03.16.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 16:41:26 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 03 Sep 2024 16:36:19 -0700
Subject: [PATCH] irqchip/sifive-plic: Fix error codes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-correct_error_codes_sifive_plic-v1-1-d929b79663a2@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAHKd12YC/x3NQQrCMBBG4auUWRtIYhXiVUSCTP7ogDRlRkqh9
 O4NXX6b9zYyqMDoMWykWMSkTR3hMhB/39MHTko3RR9Hn/zVcVMF/zNUm2ZuBZZNqizI80/Yjfc
 Q6i3FFEqlXpkVVdbz8Hzt+wEkZsp0cQAAAA==
To: Thomas Gleixner <tglx@linutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Anup Patel <apatel@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Charlie Jenkins <charlie@rivosinc.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=NEqMSUiXPJnE6dN6HQOChucnRrDzOVn8LzJu3RmeZNg=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9r1eTNt3y1fsGdnbznPef/Ji2bcWeqpZj9Xz7rMaG94z
 4WgVnHPjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACai2cPwz2Cel5Lv9MSytD95
 j557Wc2M/b7t6+LyEztZM37xWhocPcXI8Cn27XwGfZbXtgIvdka56/tNiXgsrWefwK9yl63H7OY
 7bgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Set error to -ENOMEM if kcalloc() fails or if irq_domain_add_linear()
fails inside of plic_probe().

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202409031122.yBh8HrxA-lkp@intel.com/
---
 drivers/irqchip/irq-sifive-plic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 2f6ef5c495bd..0b730e305748 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -626,8 +626,10 @@ static int plic_probe(struct fwnode_handle *fwnode)
 
 		handler->enable_save = kcalloc(DIV_ROUND_UP(nr_irqs, 32),
 					       sizeof(*handler->enable_save), GFP_KERNEL);
-		if (!handler->enable_save)
+		if (!handler->enable_save) {
+			error = -ENOMEM;
 			goto fail_cleanup_contexts;
+		}
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -639,8 +641,10 @@ static int plic_probe(struct fwnode_handle *fwnode)
 
 	priv->irqdomain = irq_domain_create_linear(fwnode, nr_irqs + 1,
 						   &plic_irqdomain_ops, priv);
-	if (WARN_ON(!priv->irqdomain))
+	if (WARN_ON(!priv->irqdomain)) {
+		error = -ENOMEM;
 		goto fail_cleanup_contexts;
+	}
 
 	/*
 	 * We can have multiple PLIC instances so setup global state

---
base-commit: 6804f0edbe7747774e6ae60f20cec4ee3ad7c187
change-id: 20240903-correct_error_codes_sifive_plic-4611f59291df
-- 
- Charlie


