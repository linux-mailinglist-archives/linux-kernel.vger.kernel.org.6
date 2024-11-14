Return-Path: <linux-kernel+bounces-409879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 372629C92D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FF7B2A408
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29B41AAE01;
	Thu, 14 Nov 2024 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FCf/wGcV"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1811ABEB7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614501; cv=none; b=I/qZCSDpx/Bwv1Wf8KX7oCyEZoAbU8lrPPGYhpxzZwn1E2T+WSaRObxvLtSS/TMkPoblZCMuGQCN2eB0eYDh+8YwCQ98Z+mvG2COVT4RxlgufBhDLqQHBwLF8nP/e9KYUa4HioyaTHUUbwovYWxGPZ/CW1ZFIYdX8sh67gO20CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614501; c=relaxed/simple;
	bh=6tYvS6UjOVc+bH34gdufMawNWKJmxIIMfkjwtl1wyYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpGbzWDhc+6f2axXstULqTfwOXMcqDccmhbSeP9up46RTBDtm4sAEHBqLqIa517iUNwsKKqCH5UsBGPRijVLGX+sWeRwMm3tUZqIFFzodhgu3KNfvAXQZDhm2gaHTJGaHKZoHvpv28JTUSfEhP66LW/3mbn/c/IHnt3rCxaLgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FCf/wGcV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbcd71012so12020305ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1731614496; x=1732219296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9p95eykbRlT1WDCjV5vpfrxyrRN0UXkf09A2IQ4L1cA=;
        b=FCf/wGcVOOrTd1KPOrRdzSd3eArDN5JmDbo8YETiEDa28iQe8MK1nqzkMFOMjQA0ad
         a2r3ITK7NJ3qeHiLGXXpu5NuZLZvpbOd4tkcg6SnLxEwqZzWbh2Yv/hhD4WX2qFj2mjY
         Wq7tbsZJnNjcSNdR/L/FcYAhvR7HxWyA0kqyFYz53pLjWRqGvobOlNKpRRDgEFvLsZwa
         xL5QmIwDzFDGZ7c8mYJ+AABFRF738zWPdVj+Rhs8rP/vLlJzpKdS68m7XrM3XvH4510e
         h6lPwDSnmJRFdE/MS71OazgJ/B+eZFuACbiatp7c13U7rb1tTmTXEAQu9l/d/w38ABgO
         EJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614496; x=1732219296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9p95eykbRlT1WDCjV5vpfrxyrRN0UXkf09A2IQ4L1cA=;
        b=DzHVlP/aeWfM0gw14rJizWqpVNTcuNYmxj7fHQ5lMiKXf37YjT6UEF5A9738mFYjZx
         SEX5RUazMQg9S45/G0DtIF5fC3CtZ4ZGMdp7gDoXvFF+mcenrQyrbvouVMI01CSWZ5Zm
         y1D/VDF+nJyBQPB2hbpzgwljfFOwmz07BR4ZTkVc6Sn06wUah/TESQenjWdDFURpD6m0
         zc/rNX4v4N15Au5JXc89DM72oVvTiGHbZgUYjcox+d9hMAOQW9Qh5OgxFqSz6uAuRIcI
         A/jJvieNaYt7za1ymnFgfuH6Gml6dvbeQ0CYtXtxA8tkS3Kf2AzQFonelzCrC2diW7rI
         XVxw==
X-Forwarded-Encrypted: i=1; AJvYcCW1TD+7FmHKL7MESWg46oWhB3yzltYW7q934yjNjcsM4PzWvni3iIl+HcTDEBQ7Db4NgUrqfUe7PfPJoZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA52RSTXnB6h2oi2AesIY8BK9aNHdDWaegNwoQj5baJsY0iQbW
	okj7iHtLwd57ra+IrsA7I12Hml+zm1kc2VzqomfDVHvtY+Vf2uKkhhScNaiaRww=
X-Google-Smtp-Source: AGHT+IHV1CsLdoXybXKM452VDK98CEq/bcsjexgeJSn8LVqswl7/cwUzqv6UuDfnhEWk2CdV3V0HlQ==
X-Received: by 2002:a17:902:e54b:b0:210:fccc:1c3b with SMTP id d9443c01a7336-211d0f11d0dmr745895ad.55.1731614495473;
        Thu, 14 Nov 2024 12:01:35 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f31f49sm147815ad.117.2024.11.14.12.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:01:35 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] irqchip/riscv-aplic: Fix crash when MSI domain is missing
Date: Thu, 14 Nov 2024 12:01:30 -0800
Message-ID: <20241114200133.3069460-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the APLIC driver is probed before the IMSIC driver, the parent MSI
domain will be missing, which causes a NULL pointer dereference in
msi_create_device_irq_domain(). Avoid this by deferring probe until the
parent MSI domain is available. Use dev_err_probe() to avoid printing an
error message when returning -EPROBE_DEFER.

Fixes: ca8df97fe679 ("irqchip/riscv-aplic: Add support for MSI-mode")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/irqchip/irq-riscv-aplic-main.c | 3 ++-
 drivers/irqchip/irq-riscv-aplic-msi.c  | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 900e72541db9..93e7c51f944a 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -207,7 +207,8 @@ static int aplic_probe(struct platform_device *pdev)
 	else
 		rc = aplic_direct_setup(dev, regs);
 	if (rc)
-		dev_err(dev, "failed to setup APLIC in %s mode\n", msi_mode ? "MSI" : "direct");
+		dev_err_probe(dev, rc, "failed to setup APLIC in %s mode\n",
+			      msi_mode ? "MSI" : "direct");
 
 #ifdef CONFIG_ACPI
 	if (!acpi_disabled)
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 945bff28265c..fb8d1838609f 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -266,6 +266,9 @@ int aplic_msi_setup(struct device *dev, void __iomem *regs)
 			if (msi_domain)
 				dev_set_msi_domain(dev, msi_domain);
 		}
+
+		if (!dev_get_msi_domain(dev))
+			return -EPROBE_DEFER;
 	}
 
 	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic_msi_template,
-- 
2.45.1


