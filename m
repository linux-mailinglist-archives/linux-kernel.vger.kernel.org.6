Return-Path: <linux-kernel+bounces-235724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D791D8F1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED5B1C20E27
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5FC8287A;
	Mon,  1 Jul 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WEcBWxIc"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6F7E0F0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818965; cv=none; b=TJHRw1Ae17OIe56277QYUCI2GFceLVmRkNmatTjpyq2/GdrzibsV/pDpZmh6MiaphpXiWE46LGYxLTgxhunMIdLXD2CGhtOS57DpQfP8GzoXw1uW5LCOVuJstrBYDXu1L+FK1cVyUV9VOBXtvN3EfdXtqtvFjpgjPWqkcHU/H2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818965; c=relaxed/simple;
	bh=o4IG1Ydtzsj6A/FLUwqxoG7igH8yPVKoxmt7Uos0s40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKdbyAwBz44k9BP8l49fAnWKcN1pCKfxyw37j6T6v+NEZhsRe5pav5WkR4LOmVWaXulV3Ok/VIQ2T3tM/9L1pFlTDJftR3j2YxcCM2xq46+EZ8WBDjqfOSanM8Nrj4Ytm+uKcWkPOeZJEvA4knRhqtQXjbc1A3YhXet78nmdGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WEcBWxIc; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d561d685e7so2003159b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719818963; x=1720423763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIwvidCJhYXXjv9fs8E48O/N337p1plrTXtjqFhBKIQ=;
        b=WEcBWxIcKxJwIkzDCau0tNXr/CPyTjt5dD5AZ9VmOzl18Aiw3w+PXusAaa/3PC424a
         Gn1ps532BSzyD4N6KhU3UuGo7eOx/6aooDrCKJqEHL9XIk8P69F1JEI1SWhbw6wI+oqf
         c/8h27laPLGOh+WIjUcMj6o++PeIHOIUOai1qFdK+JNaxYuQrsn5ncsgYoDOG38FMFkO
         RBeVD22KD70AV/qnO3GQQ9CHVuztA3BepoX1Zgjkth+lUwDyCc/sDuPyr9Sen+WPDA5g
         NIV/L/S93vG6cIwVR3GMOBpTpB+ZBfIGgsLB3w+mFhW3qAi+Q6A7MHK3NKlRxU8rgR7r
         bE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719818963; x=1720423763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIwvidCJhYXXjv9fs8E48O/N337p1plrTXtjqFhBKIQ=;
        b=m3IzeKfvUetkffqxiGdkiz2EilBtP9Xsgnzun3zr+sSZvbJ4QGT54SqbFVRRsIoa0F
         W6lAGBRXddqDaxZMCFC5amopRPfwcnfXl/UU+F2LhzCwdAGi3br4Y5eoRGjpwQVSM4Yk
         l8g+LwvwZ1hh3LhE3csWlZTTXwGFsXizyOBxVmOHgaDo30o9U5mrmWQp3GMaInA4k5XD
         EnNQxr4qiVu3TJkkeU6gIbseBbr9QAiDfKQN3InvKPk2HIVj1t5WEUkAdFkrfh3RM5Am
         zZ5YkS4lWMu8t36MAt62ZKCwSRSloqUlGvk2hnRvk2U6iT/FITfd34AiPZEVLI6O+sw0
         I1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/W8GhN1/lviHBXiJKST+grZBN1XIvcaL1DjCIHHF7YGDfCTt6LJLdAt51tm7wxI1Obkwi11+P8SgA6k3oZp/sSaGizXoxYeE2ywuX
X-Gm-Message-State: AOJu0Yx1YV8IYnLBhqeM9duEfX0rNbIJfH5aL3CII+eYiCxPePbT48S0
	A3OGOHPQISVCh8FLSHUqEbPWUdbzq/MqWCapFUIKPrWwnXjueZ6/ZXOm93j3v20=
X-Google-Smtp-Source: AGHT+IHRz1SHHY+TmlIy6IZBZFwaBFuAJ4rZWriiRFCwuK0Ao+rNzMBXMsAGPD3T1rYs7tmFaCwRjQ==
X-Received: by 2002:a05:6808:159c:b0:3d6:324b:ddc7 with SMTP id 5614622812f47-3d6b35ca407mr8326356b6e.28.1719818963388;
        Mon, 01 Jul 2024 00:29:23 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf757sm5779337b3a.104.2024.07.01.00.29.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Jul 2024 00:29:23 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	apatel@ventanamicro.com,
	sunilvl@ventanamicro.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	baolu.lu@linux.intel.com,
	lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 1/1] iommu/riscv: Support sharing irq lines between iommu queues
Date: Mon,  1 Jul 2024 15:29:08 +0800
Message-Id: <20240701072908.25503-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240701072908.25503-1-luxu.kernel@bytedance.com>
References: <20240701072908.25503-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the number of wired interrupt lines is less than the number of
iommu queues, we should assign one irq line for several queues and
configure csr icvec accordingly.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/iommu-platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index da336863f152..1d0af1260d5b 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -60,6 +60,10 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	for (vec = 0; vec < iommu->irqs_count; vec++)
 		iommu->irqs[vec] = platform_get_irq(pdev, vec);
 
+	for (vec = iommu->irqs_count; vec < RISCV_IOMMU_INTR_COUNT; vec++)
+		iommu->irqs[vec] = platform_get_irq(pdev,
+						    (vec % iommu->irqs_count));
+
 	/* Enable wire-signaled interrupts, fctl.WSI */
 	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
 		iommu->fctl |= RISCV_IOMMU_FCTL_WSI;
-- 
2.20.1


