Return-Path: <linux-kernel+bounces-194825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE638D428E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C40E282BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150C6E57E;
	Thu, 30 May 2024 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hEf5J5lW"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F33D27E
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030378; cv=none; b=dkZsK8MH+R0c8Wvth4Q64xicmTQ7bGPf47jno1TjxdncvLSDhumvHOMWTi33RYrkMTu21u2DfrUWzJMsTo+BMi4Y4IVjF6zDduf7VNgpyS1+032gKjs3uBYvIC3nrvXTXvx6BSQPT2JzMw2/N/hNt5s6PYD75MMEi841dTy9Rf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030378; c=relaxed/simple;
	bh=AM0rnre6QzEoitz2znOIUDKA3H49MhSDYyU0Htiw4H4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XenXKqhKF2ecofo3vnaMKN0JAvAb9AHp/rYNZ06HZ4OtjwDV/HrSA1OqVh+77rtqP6xG/XKUgIzYs9NX9pNolJCUQ8xLzppMMdc2/lvb0sdWue6zKXb4I1EzItdzys366xZqyQQI/6l9TYoErQONGsXvxIGUJgRk1qmUYSN5Nro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hEf5J5lW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6818eea9c3aso252356a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717030376; x=1717635176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2qTNyHyYfp+d7DaR++BJjcIzT2YJygLkWTT2HYJmoM=;
        b=hEf5J5lWl5WxhBB/tmfPIqqttSZ4twiqmp4G4tqzyDV3ZxJUhssa/dJM3UIElKidRv
         9FRjN+6mmFThvS4h/p7yPa6DlFKoilsChM4q8YaEhNRjt8wjk/4hh22hzEhqGFDRf34t
         /yH+qakKZwbuuO56kiXbO0tStoQJAA2bxnJSgCUv0cy/M34q9KM9Q9fGaCEF7JVbjf4K
         CwvK0MU5EbA1HMIKxadMswfpHOa87uN9aoMoyUN+chIiOUtB4tZv4y8A/dZX6pGhmUaH
         jEl/fF0ho/7a64G+sqmJtROtuGQXGnvUybaXw2NVC+P9iJDFcirC00hi/Z2TwY1PyWL3
         1FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717030376; x=1717635176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2qTNyHyYfp+d7DaR++BJjcIzT2YJygLkWTT2HYJmoM=;
        b=bJ4cM+Jdjsogbv4Ve0+a/cePP//bJKhw1sfomliSwPpskktndq6Qg1IoAXoiFQQdQF
         w5okRVVou5pKhCTbys2ccLF8ERXl6kkvYkw+L1Lma7M8Iy5IcXkNVTVp4o+JA5arXHVU
         4aJiix/4wL66DrwVS3aTykxgug9pF8ig4PIFQ3DS4x8BYIwrNj9uvHFomFs4u6UCr6VH
         pdEMK+pM50qkDrsW0QYuqQ58Ira29wCtMKBx7H6nTchx5s+L0cLylkGFbj6eoSNDYe2e
         IrxjMDKAi6MTBM6Afm1FN3dR2cdhPsiVD2SLM8S/1iqCd6NV+2ObE+OGVmF4jLUn6sTZ
         ZTrw==
X-Forwarded-Encrypted: i=1; AJvYcCW8j45rBKbhA9kfJawlv+AAblxtBQXF7Z2d/SuXhFiKPOVKXoWfPkDmKsvxt03bVuAp15a/Jn5mmcQe9u3lO1f/t5TsgzfC68lACNO+
X-Gm-Message-State: AOJu0Yz/v7slxSKYHo/2hAlAW2XiIMiQOnuzKtEzxS+RmspWNfWC8Q8c
	wLue5IrMq99O4FNVNzPae461EYT2IM39NCr1DZrnkO8a4jQnGAH1X4KcZL6O4Y0=
X-Google-Smtp-Source: AGHT+IEpamNzOMpXej0aUkSI+HNZYElaFeXaRdTiKb76E3pGSGOp3OZNuTRt+FHSImXs8V4onJ+Esw==
X-Received: by 2002:a05:6a20:a129:b0:1af:fbab:cf92 with SMTP id adf61e73a8af0-1b264633325mr747533637.54.1717030376269;
        Wed, 29 May 2024 17:52:56 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9683b3sm105898415ad.163.2024.05.29.17.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:52:55 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/gic: Use smp_wmb() instead of dmb(ishst)
Date: Wed, 29 May 2024 17:52:30 -0700
Message-ID: <20240530005254.1495461-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is equivalent on ARM, but also works on other architectures.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 98aa383e39db..dc2e4018a40c 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -839,7 +839,7 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before they observe us issuing the IPI.
 	 */
-	dmb(ishst);
+	smp_wmb();
 
 	/* this always happens on GIC0 */
 	writel_relaxed(map << 16 | d->hwirq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
-- 
2.44.1


