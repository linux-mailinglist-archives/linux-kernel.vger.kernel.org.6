Return-Path: <linux-kernel+bounces-398122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C657C9BE5CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 084B3B24424
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD91DED76;
	Wed,  6 Nov 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="Tz2FZ4yH"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB171D619E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893278; cv=none; b=g6dntYYoXJMDjXybWPnk8duyZGqvOTCnW8kqeyAtzWe9TZpVZYxSFHDlmk16I7Y/TUNYgmcAEIrBT/SVqFxjnd49dfKBHRODr+gWG7Uu/KXU5d6z11uLpxD7EU/X2h2ci6iCBtUZSRpYh6TPYKYxr4QDJhChqSrK81Sh183wUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893278; c=relaxed/simple;
	bh=avSNu0jxcOX+JToYoKPOxXqXoAKAFU2u/PiZkiumz/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw8NYrj6Vip9A8tzcH8aXLB7x+/hEIVwseZm6xDBvbK9gQAxU6J9Bq0J7lE2xJ50P/FDa8nSBRd5hGB4tmSpeTbmnEmwKgDppDnPmAdyBFibpFt+FcJ0g8CBc+hghK25+8LKczl9HCbdfIAuvXu/i/CowckRe+7lA8iuGNZFzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=Tz2FZ4yH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4fd00574so468634f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 03:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730893275; x=1731498075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T1FnuxuOLfXTEuPhFAXlYWlJnV3S7rPr9KDCR50D/U=;
        b=Tz2FZ4yHRYG4lmV/Gysq6ZLh8Iv9j3DYs79i1STYg4GKsPcPSIFAY5O9rS0TTxSoh7
         zrRHk906GFjYpKfVGSDQkcP+rANVRugbrNGqs85ISRMqDWtVjpSZlq3P2ooWl+71fQ8V
         KfDNmkU1UcxsGwdDuzHknyiy3l1lyjtft/MUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730893275; x=1731498075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T1FnuxuOLfXTEuPhFAXlYWlJnV3S7rPr9KDCR50D/U=;
        b=LeMaRtD2iF+fxR3qhSUeqbf+rXqFLEQXM3pyDcLQH3hm4aoEZbEmapiy5lxQAlyUJy
         NXyux5Mwchgdz6d/+tyoGm3pLaPDf6DjxtpD3LoaSXzobAOcCf0233d6Y044g5Pw632S
         X75ozZ5s4XaJTiaWlgpQS3UTFh1nKJ7I6iDoaC7mIXY0P1brdqgdNHjLBsSCvTWJcnBS
         akFagG6K0oF9owKx9GfvAeeUbZ6HlodIgvXGU1biAh5zaQ7Ta9ig/4t/Jt9U/KVdqJLU
         z6hReDslmcPxURyNWtlCL15v2tgLqYoEkuuYfE2pemi/IxaHcUki4XFAJNKtj4IbZUa+
         Z5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXK9+qiFKLcSJh5ypX1qSq+Hw+uq81Wg2HuClCH7/OHB3vw7yo0PuMEKUIKMasQ0GpsxU2cCjuc/u3i9F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysAZLibCcPkeOfRi0WasJ9cJ+lCVpcHYW/KghTzj7hPzVDXQG8
	Rk9eU/HP/YHXP18EfEk2o1ElTNjeow6Hd2JJ019jCdYc5z+h6y4MBO2QU7Fk3W4=
X-Google-Smtp-Source: AGHT+IGs7rtq/82Gf4X8l5DLzpbnfcApHai1n4nlgCsS52D3NRA4jUVMSqr7KG3kWQvNyUORpNBznw==
X-Received: by 2002:a5d:588d:0:b0:374:b6e4:16a7 with SMTP id ffacd0b85a97d-381e81ca8d5mr1811747f8f.8.1730893275055;
        Wed, 06 Nov 2024 03:41:15 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3f87sm93796755ad.249.2024.11.06.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:41:14 -0800 (PST)
From: Orange Kao <orange@aiven.io>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	orange@kaosy.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org
Subject: [PATCH 1/3] EDAC/igen6: Initialize edac_op_state according to the configuration data
Date: Wed,  6 Nov 2024 11:35:45 +0000
Message-ID: <20241106114024.941659-2-orange@aiven.io>
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

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Currently, igen6_edac sets edac_op_state to EDAC_OPSTATE_NMI, while the
driver also supports memory errors reported from Machine Check. Initialize
edac_op_state to the correct value according to the configuration data
that the driver probed.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 07dacf8c10be..fa488ba15059 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1350,6 +1350,15 @@ static void unregister_err_handler(void)
 	unregister_nmi_handler(NMI_SERR, IGEN6_NMI_NAME);
 }
 
+static void opstate_set(struct res_config *cfg)
+{
+	/* Set the mode according to the configuration data. */
+	if (cfg->machine_check)
+		edac_op_state = EDAC_OPSTATE_INT;
+	else
+		edac_op_state = EDAC_OPSTATE_NMI;
+}
+
 static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	u64 mchbar;
@@ -1367,6 +1376,8 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto fail;
 
+	opstate_set(res_cfg);
+
 	for (i = 0; i < res_cfg->num_imc; i++) {
 		rc = igen6_register_mci(i, mchbar, pdev);
 		if (rc)
@@ -1450,8 +1461,6 @@ static int __init igen6_init(void)
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
 
-	edac_op_state = EDAC_OPSTATE_NMI;
-
 	rc = pci_register_driver(&igen6_driver);
 	if (rc)
 		return rc;
-- 
2.47.0


