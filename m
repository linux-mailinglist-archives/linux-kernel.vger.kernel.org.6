Return-Path: <linux-kernel+bounces-394854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 577EE9BB4E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8F12827CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A718C025;
	Mon,  4 Nov 2024 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="ex9uBBY5"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A91E4B0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724219; cv=none; b=nuq93lxHz3oInv5tShm2YrI5aMD3c6wQZvy5GVnJTKj0iu9qK4w0XN0NWgE55ldpchs70mqfhcLeLY1QB1XpdRrR8Ey63aVEr0g7d80VwpeXGBzNmbPzN4l9xD55SoAMZWmvbs4/Kd7RUuNusn8CwJNIfn5GZ417/61HgKzHnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724219; c=relaxed/simple;
	bh=cKR4mIuxU+pZHomU02/B0JOA4nMGY2eIkkwjNLsRKNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecHxtX4rztw2qiDegfn56J7037dMbBLG9G0bUoj9KenkmUeEN+UIES1Dp9kqY+gAE7IhvQtjp2giusatE7yUnqXROp9llybtCDcceBLUqF/vkG1POkoefa6F2Syt29f/sSOo8v8PCrNlW+0sF/vjUJRcwIYasV8Y7vs8y1WetFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=ex9uBBY5; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so6345241e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730724216; x=1731329016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QxRN4fIUmMgqqmSgoGjRQ84Tw++DtIiEKSH0O+MnK4=;
        b=ex9uBBY5BoPmeZEYOkkqs5MmvLHPMHBW4wU5ueDB21fohSdWEnDsubzQe5oKZ4iP1S
         UeaoWNDwqPcucHQ/J1DoRwOZfk4J/1EUJKrAxyG4Vu3cCWvplxIGnwmwizXycFLGc0IC
         Z48WS0SXvsB5RJn4B+/aa0Ij/GIiJjj0djWGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724216; x=1731329016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QxRN4fIUmMgqqmSgoGjRQ84Tw++DtIiEKSH0O+MnK4=;
        b=tF6iOVNKnPM477VepqSSLjfphWLOg+2IaSh+tG1620Vbrn1mpo9L4k192fUT56pTZ/
         Mx9BvtOi6xS8JdR3zXbsvVXq4QHd38uEOkii+eZ+fYW91CgRCwpauLFNH/vhEg0VRJ26
         iXB5M3hTpSuizQJQmRAc+ewjhcvtm+qmvIlbI2Sf5CVoEQAAlQMMpDQFsaop3O/bjSN3
         bkeptOwGp8OStu76SACYCY0vsEHj2aDlc6xWBt173YNHwa3C+MCMkRzl94AZTV1UsPwe
         4frfa2z1b7DA204ToeqTfNW9O6Dz6xdKFNGe89sL8IvHARaF/A3/vjKXvc8nMH1FDzHi
         y4MA==
X-Forwarded-Encrypted: i=1; AJvYcCWLQdLpsPUOBZxAy0VaWC53qGdEVmaloja1qdhW5WBwpsGntrqqq6kHLUjTwn9fkYFT4w+6Mk77kO114Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwGqRx8pNQvznp78a76twng2iueIq/DETIPYG+/bfMdBVKMYyl
	3/byio9/Kfdp//A2oNXo3rGC6FLLmdVTnHAUUVkf7UQS3t2zlUPQnK8ekk0bcko=
X-Google-Smtp-Source: AGHT+IGgBMF58yJeGdFQky+NLdR4fiA6k5ZEPcqTxWYN7oXWvE3Y7NIIuc+Tgxb0I33E3BFKHU/hWQ==
X-Received: by 2002:a05:6512:2350:b0:53b:7ecc:5ddf with SMTP id 2adb3069b0e04-53d65df1a08mr7897714e87.26.1730724215737;
        Mon, 04 Nov 2024 04:43:35 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057071fasm60567525ad.84.2024.11.04.04.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:43:35 -0800 (PST)
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
Subject: [PATCH 3/3] EDAC/igen6: Add polling support
Date: Mon,  4 Nov 2024 12:40:54 +0000
Message-ID: <20241104124237.124109-4-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104124237.124109-1-orange@aiven.io>
References: <20241104124237.124109-1-orange@aiven.io>
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
 drivers/edac/igen6_edac.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index fa488ba15059..eb783c6b77f1 100644
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
@@ -1352,6 +1368,10 @@ static void unregister_err_handler(void)
 
 static void opstate_set(struct res_config *cfg)
 {
+	/* Only the polling mode can be set via the module parameter. */
+	if (edac_op_state == EDAC_OPSTATE_POLL)
+		return;
+
 	/* Set the mode according to the configuration data. */
 	if (cfg->machine_check)
 		edac_op_state = EDAC_OPSTATE_INT;
@@ -1483,3 +1503,6 @@ module_exit(igen6_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Qiuxu Zhuo");
 MODULE_DESCRIPTION("MC Driver for Intel client SoC using In-Band ECC");
+
+module_param(edac_op_state, int, 0444);
+MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll, Others or default=Auto detect");
-- 
2.47.0


