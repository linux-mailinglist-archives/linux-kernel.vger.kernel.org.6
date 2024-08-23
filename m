Return-Path: <linux-kernel+bounces-299265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0477795D233
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 208DFB23391
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8004318BC2A;
	Fri, 23 Aug 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbGnkPte"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638A1898F4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428518; cv=none; b=nq++KeasIS2/QXIbJRgeSH+7h9b7Q1W6+ox0ctnnQ86qku0kAinRTG6h3yogtQ66yLeuX/d3fB4pKjSy5HDU1IsvBrULHthQQXXmh2fdiAoyQKFkrz3KHyG5JZv5aq4RrqyFjj2HMwI62VPxYFb0Q/3oO5wq8fCqylqNiackoJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428518; c=relaxed/simple;
	bh=I2OaP2G9ZSUZb5B1yFwzmWeX6kKkcvOPS4FPAh5q6eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcgO4HJFp+i9ghPr0QdhrwsoedwG04MeRZ4em+Yoll7LjsyLQX1hibXlSLHTQgpsEh21nFHTvTkZGqplVWohl+by5OCd/QyKXpObInNhM+ZWIebSToj1MMz3Tk2fWG7oj3IFFEvxDE/+/xE5lAy8mcleqRc9+FRXYD834FnyKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbGnkPte; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202508cb8ebso15382695ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724428516; x=1725033316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6OlRtyM144d7+hDbDg/Ar+tRLxHvv6vXiCYuDqqU2U=;
        b=JbGnkPteAEQrYJX4bDnXAdGh0kF4bQqOdV/rSoz2NipOgo/Kq8cPvYgi8YB5cm2pIX
         nj9IMzaOEwqi/2zTu5ma3L9oIlBgxGbAd8GCusD+zG/s2NIaBfKVAJl0GQEGKig5GoWV
         VAVjLtRymVJ6l+9MU26mdIFxTQhO9dJPiXr1oAM+hTcVFKniIfLqCHbj+AlKA3t0VBuf
         oymosoViVjefimOs+3RCkxKwi3MDk+mtI1n0uN5Wkf8n3HTK0yzgb/FV2jTUEsTP76xF
         jR8ir7xT0PgzMrma+7Tzp+r3khrpSJcXJq+lgVvFdKB226WFavdHrENEPNFQummPLnB5
         2N5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428516; x=1725033316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6OlRtyM144d7+hDbDg/Ar+tRLxHvv6vXiCYuDqqU2U=;
        b=M7kTxsTjKdxzS6aT9q2HyiHMaUI8OZW4AToJkeW/InPUvQ3V31Ib6YVOqHfP4P5Rja
         AukTR/2NdO9Bqq9AQKPq/aNZqZ6ioJg3zkF0XC9CFqiPF+KBhEX5OTSaN+0VRnSZ5eCo
         cJekZOw0s7CcO/LhlUmw1W4gxnKZB3FgHzIEZmMzvLC1KjpQda0KUqOzTUfLnPHG4521
         DypRAnMLnX2bFyAJgM+vzc7aqDHxglIGkRliJq5vvxRAp9gsX+zqoyL/VgiugFV9DNE2
         V+16hzjqbvRnaa6kUN4bYIGhFRxeeyRQazkdkW2y/QbYyo/LjLxt90uuWZk+y0vkj2ZI
         rtKg==
X-Forwarded-Encrypted: i=1; AJvYcCUbv4aHqF4K8MGwdIENbqxrYurQ2N7l8yGmWFQiVskNh4Cgjfs68N+2MjcwGIH8CdaTRKH0Djh76yQysQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7l27RVCUN5d5jzCgxmEuQYbtjgjPhjaJB2/FqdV09hhER2je
	QEYeY6ppD2YxYEaa9M98a+L2MMoueCHKBWPH8OxQP3MIBYqd7aMLG+/T1TRfvA==
X-Google-Smtp-Source: AGHT+IHU9XYQVlwdi75xAtVt2K4NPPU34/rpoSBNw0HOQIYbBIP/tEV3woHJzuCA/9MOnobrbzXezA==
X-Received: by 2002:a17:903:244b:b0:203:a0c6:91e5 with SMTP id d9443c01a7336-203a0c691femr20981215ad.51.1724428516533;
        Fri, 23 Aug 2024 08:55:16 -0700 (PDT)
Received: from localhost.localdomain ([120.60.50.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556649bsm29824005ad.49.2024.08.23.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:55:16 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kvalo@kernel.org,
	jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] wifi: ath12k: Set IRQ affinity hint after requesting all shared IRQs
Date: Fri, 23 Aug 2024 21:25:01 +0530
Message-Id: <20240823155502.57333-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
References: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a shared IRQ is used by the driver due to platform limitation, then the
IRQ affinity hint is set right after the allocation of IRQ vectors in
ath11k_pci_alloc_msi(). This does no harm unless one of the functions
requesting the IRQ fails and attempt to free the IRQ.

This may end up with a warning from the IRQ core that is expecting the
affinity hint to be cleared before freeing the IRQ:

kernel/irq/manage.c:

	/* make sure affinity_hint is cleaned up */
	if (WARN_ON_ONCE(desc->affinity_hint))
		desc->affinity_hint = NULL;

So to fix this, let's set the IRQ affinity hint after requesting all the
shared IRQ. This will make sure that the affinity hint gets cleared in the
error path before freeing the IRQ.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/wireless/ath/ath12k/pci.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 9e0b9e329bda..f265c1b8ce4e 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1446,16 +1446,10 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_pci_msi_free;
 
-	ret = ath12k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
-	if (ret) {
-		ath12k_err(ab, "failed to set irq affinity %d\n", ret);
-		goto err_pci_msi_free;
-	}
-
 	ret = ath12k_mhi_register(ab_pci);
 	if (ret) {
 		ath12k_err(ab, "failed to register mhi: %d\n", ret);
-		goto err_irq_affinity_cleanup;
+		goto err_pci_msi_free;
 	}
 
 	ret = ath12k_hal_srng_init(ab);
@@ -1476,6 +1470,12 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		goto err_ce_free;
 	}
 
+	ret = ath12k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
+	if (ret) {
+		ath12k_err(ab, "failed to set irq affinity %d\n", ret);
+		goto err_free_irq;
+	}
+
 	/* kernel may allocate a dummy vector before request_irq and
 	 * then allocate a real vector when request_irq is called.
 	 * So get msi_data here again to avoid spurious interrupt
@@ -1484,16 +1484,19 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	ret = ath12k_pci_config_msi_data(ab_pci);
 	if (ret) {
 		ath12k_err(ab, "failed to config msi_data: %d\n", ret);
-		goto err_free_irq;
+		goto err_irq_affinity_cleanup;
 	}
 
 	ret = ath12k_core_init(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to init core: %d\n", ret);
-		goto err_free_irq;
+		goto err_irq_affinity_cleanup;
 	}
 	return 0;
 
+err_irq_affinity_cleanup:
+	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
+
 err_free_irq:
 	ath12k_pci_free_irq(ab);
 
@@ -1509,9 +1512,6 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 err_pci_msi_free:
 	ath12k_pci_msi_free(ab_pci);
 
-err_irq_affinity_cleanup:
-	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
-
 err_pci_free_region:
 	ath12k_pci_free_region(ab_pci);
 
-- 
2.25.1


