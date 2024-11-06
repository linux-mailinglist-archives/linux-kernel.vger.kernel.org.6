Return-Path: <linux-kernel+bounces-398123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD139BE5CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C64280F67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306171DED6F;
	Wed,  6 Nov 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="cYLRzsPs"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBDF1D619E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893294; cv=none; b=YaPy6vNSrmelP0WkCi4yqB5mtYM79KhNwyGuhOCbXZ07DY29DhUl84VwP9qXF2iadbKSQHip9DpRzUX9S17ySLG3PVc/It/cO+iaEIhfuidTibqHrwOXDL2KvdT1NE8vSx1jcnv5KuUJiBTm+fMUjjuBkIHH+nqS0uLjy2FvlMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893294; c=relaxed/simple;
	bh=apl7e3mJoFn2XbWQpbe8pkRROPdUrvxhPgFBzUrah94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgWgIag1WFparcyk5QfUbO8UvC8E8MilhI8ZWBoba4CAnHaFJR+wPVkHPymQebreW22jNKw3pUdY1pf3B6P7cG6bdH/6vYUbRsIPTx1GdXS3NdrrGWzUhNRbwx3XhfjKTXVQwIDD3E8FahM5bMdmBoMEpBL9jQowrPmRlcOnjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=cYLRzsPs; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e63c8678so7351125e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 03:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730893291; x=1731498091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlN7JzcdEbavKyAODal4cf94DP35W34jit6g8RCrNoE=;
        b=cYLRzsPsXW75lEl3wtVLFvPNfhpzXtKnO/Mgr+Ydlb3mRZfNCl7Duk30lLE1lVuO/k
         pW7tYJojDIX3l8q0FqFSyN4fhKNS25pBhzyLpNDdcEgoYMuNbG3fdhhA6XtBdE/3s3xw
         hJ76Easc1lmXtNxwa/9FV7G9nkgbrakABYuVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730893291; x=1731498091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlN7JzcdEbavKyAODal4cf94DP35W34jit6g8RCrNoE=;
        b=qbQxzHp9kM+/oWEBQFKhVXid5KsHfd05SbTP0hGIEAifid/VxFkJI8z7A4E+RZ5oUo
         ldKaWoRGwrPOWGENpGi3U+RdBWh7SL6GKEhfEvcnCCYdBg8PPe9FqwOYC1wJy1KGRLmv
         /ZZWpSma7p3cQlxqGgCxsuPOVyBr9u465wgUMV46u6hBh6ovyOU1+wisqNOb7H/TKsnR
         r8Db+rJ2aIadGioCW7t1g1IBiodjblv9oJchqLFUNcAKCeUCeUHCUw9kV27pxEcP7o+T
         EdwOAj+RmpT2lNnsYmz5M3HKOqvfF/HemlIYk6lQwZfQGXcrc0TuYd0g2LYCm/K6cKxA
         N2dg==
X-Forwarded-Encrypted: i=1; AJvYcCUPB9NIWbH1ohAAOrmDaxGglzcBgWSc4YW2WuT7PYuyyFF0LjHHsW9iw5pNXqS/BiI8UOa6Ah9dzXrbxgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIzU+5cvUR9V+xlesnbHZLn16EZj2M/u4Cj6JN/J4zIHwQyA2
	N2bNf3gh0+77GkVCK9K5xFHae4YHjMuoTfCOGDAvQEEyu7baVm3rww2cviJp2k0=
X-Google-Smtp-Source: AGHT+IE5w1XpLWuVJXxnO8FGFsIqJic4Uxz8A2R8dhYAwHn/+iZlhlvJaC749E3qkfkw1T8G4ufSDg==
X-Received: by 2002:a05:6512:401a:b0:536:a4e1:5fa2 with SMTP id 2adb3069b0e04-53d65df2818mr10182825e87.26.1730893290939;
        Wed, 06 Nov 2024 03:41:30 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3f87sm93796755ad.249.2024.11.06.03.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:41:30 -0800 (PST)
From: Orange Kao <orange@aiven.io>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	orange@kaosy.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org,
	Orange Kao <orange@aiven.io>
Subject: [PATCH 2/3] EDAC/igen6: Add polling support
Date: Wed,  6 Nov 2024 11:35:46 +0000
Message-ID: <20241106114024.941659-3-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106114024.941659-1-orange@aiven.io>
References: <20241106114024.941659-1-orange@aiven.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PCs with Intel N100 (with PCI device 8086:461c, DID_ADL_N_SKU4)
experienced issues with error interrupts not working, even with the
following configuration in the BIOS.

    In-Band ECC Support: Enabled
    In-Band ECC Operation Mode: 2 (make all requests protected and
                                   ignore range checks)
    IBECC Error Injection Control: Inject Correctable Error on insertion
                                   counter
    Error Injection Insertion Count: 251658240 (0xf000000)

Add polling mode support for these machines to ensure that memory error
events are handled.

Signed-off-by: Orange Kao <orange@aiven.io>
---
 drivers/edac/igen6_edac.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index fa488ba15059..dd62aa1ea9c3 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1170,6 +1170,20 @@ static int igen6_pci_setup(struct pci_dev *pdev, u64 *mchbar)
 	return -ENODEV;
 }
 
+static void igen6_check(struct mem_ctl_info *mci)
+{
+	struct igen6_imc *imc = mci->pvt_info;
+	u64 ecclog;
+
+	/* errsts_clear() isn't NMI-safe. Delay it in the IRQ context */
+	ecclog = ecclog_read_and_clear(imc);
+	if (!ecclog)
+		return;
+
+	if (!ecclog_gen_pool_add(imc->mc, ecclog))
+		irq_work_queue(&ecclog_irq_work);
+}
+
 static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
 {
 	struct edac_mc_layer layers[2];
@@ -1211,6 +1225,8 @@ static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
 	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->mod_name = EDAC_MOD_STR;
 	mci->dev_name = pci_name(pdev);
+	if (edac_op_state == EDAC_OPSTATE_POLL)
+		mci->edac_check = igen6_check;
 	mci->pvt_info = &igen6_pvt->imc[mc];
 
 	imc = mci->pvt_info;
@@ -1350,8 +1366,18 @@ static void unregister_err_handler(void)
 	unregister_nmi_handler(NMI_SERR, IGEN6_NMI_NAME);
 }
 
-static void opstate_set(struct res_config *cfg)
+static void opstate_set(struct res_config *cfg, const struct pci_device_id *ent)
 {
+	/*
+	 * Quirk: Certain SoCs' error reporting interrupts don't work.
+	 *        Force polling mode for them to ensure that memory error
+	 *        events can be handled.
+	 */
+	if (ent->device == DID_ADL_N_SKU4) {
+		edac_op_state = EDAC_OPSTATE_POLL;
+		return;
+	}
+
 	/* Set the mode according to the configuration data. */
 	if (cfg->machine_check)
 		edac_op_state = EDAC_OPSTATE_INT;
@@ -1376,7 +1402,7 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto fail;
 
-	opstate_set(res_cfg);
+	opstate_set(res_cfg, ent);
 
 	for (i = 0; i < res_cfg->num_imc; i++) {
 		rc = igen6_register_mci(i, mchbar, pdev);
-- 
2.47.0


