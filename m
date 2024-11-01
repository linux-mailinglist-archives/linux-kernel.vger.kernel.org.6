Return-Path: <linux-kernel+bounces-392915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 235939B999B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DC3B21306
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC5F1E0DEB;
	Fri,  1 Nov 2024 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="G4s/cPrr"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A51E0DD1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493795; cv=none; b=LIt0u8LQrRF449SJ2sDCVvAoZFhXGbLcQz6y2hp1wDRUmYiGSxE5/dAsEIJCt46wv7KesQxokKSst5rN0lp9Gq6CnrsNa8R9gmLdb3ag3vAUgGPEfEHnHYiA3hkx6oo7XmAhLWylseps6I/m0OFAlAU+Ke/wFX+omdlM8uj8nyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493795; c=relaxed/simple;
	bh=ptzQA79PsQ8k8tjkG25pELUgNwGO2fEO4/lbiHnHhpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsNe0CvQSU33sN6DrUAJika6ebwpxTch65R5fgWvc2k2dIiarJ1pFZu+e7k/D11MMOs2A4oZZwtCUUtgVBQUUHKhMPj0gXD2BFtvStj9ZqW6xb8VXk5myJs1cOOdPiEXdTe62vUMwodusUJxOAbdwgeQquibAXlPgNitjqvoDuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=G4s/cPrr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f1292a9bso2810543e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730493792; x=1731098592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9pVXfF7qpg0nDqZ4UjEIaEqqU2lYYTS28zjXtmZEQ4=;
        b=G4s/cPrrpU6q5HYxy45AmbYhRIAlibVUycVCT/VlUgwW94fNewZvHxFX4A6KCo4IDv
         y8Rgcb5b8FRTOUSYri4yxxjfmcOFkUi7ZPDalJPU9IcKkVfoIJKjwhZWlJNLR9ClsWUe
         rPHK9AiVbK4FWDLqrUw+dqMTD7aFLrOnZngPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730493792; x=1731098592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9pVXfF7qpg0nDqZ4UjEIaEqqU2lYYTS28zjXtmZEQ4=;
        b=jmmWvdta4eC64fUxQjKbBhQ44PgIk9XvGv0qNO5/3uTD8V3W1lOS4amUzKSf51QJ3X
         i4AOygupkUvYXn60uvXNKOpi1NSTi6CmbozaVoEg/WAGmjQmFiV/DB1Wd9x498QHXE2i
         BORuemlxtjy+eEPmaLU5IDMsarnxmgwckxm+wSF/jlg9XBoVB8ZEjAeRAyICMijbpyzt
         PxcyaZSPxTEwB8K5W7xFkwUQtu1r27+lpQj6m/+M6xpd7UNFn/qVscvuzJvL6OsiZc2z
         OOQHGDyhBz9fTtPObqTEhV7zfP2D8DW6iKcuQQbFIlAOAg4mRUTNHh9qcPEbdGI2zoy7
         pF8g==
X-Forwarded-Encrypted: i=1; AJvYcCUYRa2kDDd4QKpufFwZx71JwnRac8n4HMXadYBwDapQD5uUFfs61T/KWrxW0k59zAVDfyVNxPsOhxWG2zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXaRZr0mfNEPdsrYNbfkOSRgUGwgxWpGcsjJSOURiEozANBWu
	gP9K9fz1LnUZhwZRwpAYz+ljiGuSxJgiCMiIcvKcy7lTV0eGQBlBrSNXfefDZpM=
X-Google-Smtp-Source: AGHT+IFvB04kMnWVtmkoHKEOl1lrJ4xRWng1c5xgCee6TgrGwVnOQCTmp6GgRvGhGjCb2j9SqaIkcA==
X-Received: by 2002:a05:6512:3b2b:b0:52e:f99e:5dd1 with SMTP id 2adb3069b0e04-53b3491cd1emr12776294e87.47.1730493792017;
        Fri, 01 Nov 2024 13:43:12 -0700 (PDT)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edb4csm25014455ad.58.2024.11.01.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:43:11 -0700 (PDT)
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
Subject: [PATCH 2/2] EDAC/igen6: Add polling support
Date: Fri,  1 Nov 2024 20:41:14 +0000
Message-ID: <20241101204211.414664-3-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101204211.414664-1-orange@aiven.io>
References: <20241101204211.414664-1-orange@aiven.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a PC with Intel N100 (with PCI device 8086:461c, DID_ADL_N_SKU4)
but interrupt does not seems to work, even with the following
configuration in BIOS. I am not sure if this is caused by a BIOS bug or
not.

    In-Band ECC Support: Enabled
    In-Band ECC Operation Mode: 2 (make all requests protected and
                                  ignore range checks)
    IBECC Error Injection Control: Inject Correctable Error on insertion
                                   counter
    Error Injaction Insertion Count: 251658240 (0xf000000)

This commit tried to add polling support.
---
 drivers/edac/igen6_edac.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 07dacf8c10be..5027070410a5 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1170,6 +1170,19 @@ static int igen6_pci_setup(struct pci_dev *pdev, u64 *mchbar)
 	return -ENODEV;
 }
 
+static void igen6_check(struct mem_ctl_info *mci)
+{
+	struct igen6_imc *imc = mci->pvt_info;
+
+	/* errsts_clear() isn't NMI-safe. Delay it in the IRQ context */
+	u64 ecclog = ecclog_read_and_clear(imc);
+	if (!ecclog)
+		return;
+	if (!ecclog_gen_pool_add(imc->mc, ecclog))
+		irq_work_queue(&ecclog_irq_work);
+
+}
+
 static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
 {
 	struct edac_mc_layer layers[2];
@@ -1211,6 +1224,9 @@ static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
 	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->mod_name = EDAC_MOD_STR;
 	mci->dev_name = pci_name(pdev);
+	if (edac_op_state == EDAC_OPSTATE_POLL) {
+		mci->edac_check = igen6_check;
+	}
 	mci->pvt_info = &igen6_pvt->imc[mc];
 
 	imc = mci->pvt_info;
@@ -1450,7 +1466,9 @@ static int __init igen6_init(void)
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
 
-	edac_op_state = EDAC_OPSTATE_NMI;
+	if (edac_op_state == EDAC_OPSTATE_INVAL) {
+		edac_op_state = EDAC_OPSTATE_NMI;
+	}
 
 	rc = pci_register_driver(&igen6_driver);
 	if (rc)
@@ -1474,3 +1492,6 @@ module_exit(igen6_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Qiuxu Zhuo");
 MODULE_DESCRIPTION("MC Driver for Intel client SoC using In-Band ECC");
+
+module_param(edac_op_state, int, 0444);
+MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll,1=NMI. Default=1");
-- 
2.47.0


