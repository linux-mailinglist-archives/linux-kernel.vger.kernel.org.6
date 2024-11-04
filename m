Return-Path: <linux-kernel+bounces-394853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D839BB4DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAADF1F233BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBA41B6CF8;
	Mon,  4 Nov 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="JSZMFep2"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B51B2EEB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724206; cv=none; b=h2ZtmG1KOm0oIcFIFSOby3CduvIR0Mcc3AnTZ5WP/JXx4oQJUw4K2aqy6QYx8VSHuU00YTWR2RbM4SI46WdZuaWXaaD4epegF6LuEPCea0p1nymxypwwLUoH3UY3hHzT25pUBxVp0MOwudJhhxnIMCnN8+apLGdIhdm+9vZt6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724206; c=relaxed/simple;
	bh=avSNu0jxcOX+JToYoKPOxXqXoAKAFU2u/PiZkiumz/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kspQVOcT+IiHHnxF2wVLTDDrLhxdBijkCNwITc+s8KBXpqHDK/zlbRpxOfOqzUFsp8lXbJbOSrW3Uwkv0PFYrYuHNW0t5mle/0ej0zdHzaxFVBkX2BNvjmVKXL1hhDFg4RYFMP0yorb8PQ31jCOkCiar9fM0FFw7E4XSrX7LSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=JSZMFep2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e63c8678so4633639e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730724203; x=1731329003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T1FnuxuOLfXTEuPhFAXlYWlJnV3S7rPr9KDCR50D/U=;
        b=JSZMFep2+hq9DcSVHC7sstW9ORzuhIYb/WjoZ2cCJ6lrxt6rYifb3rsYg5GkpApBKD
         MQ90KTEbs5TJ56mIECQxnd0PbegVvOibrVfP5LNQeCQvkS6k7sm8T6al34jEzBbiffeD
         263ZDS7JSIOqADj6fbWImvjU8e8B5HhJE7YpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724203; x=1731329003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T1FnuxuOLfXTEuPhFAXlYWlJnV3S7rPr9KDCR50D/U=;
        b=A5cgj+tnnFyzCgoL5whftDUOr3t0F1WvR8IAp6PzMJ9fOcIUD7EQXIkoLc4q18l+3s
         7+eowLRJtQXpFe1bYAE62CxArEyG/VEwg5GIMEQclJSMT6v/t3qL7huWAJazTrDQbnRg
         MwhkSHwziRMke+0dSOGxH4JnU3TARJy9rLFGDvDaVbv8OGoRl3Ke1fUfYtiiDRdoCuA+
         XBpKztxTROh3Xf1ORo34TXivQ2oMjceCf8tDjJXwFd4W/0qBDlHPnDZNo1VsU1pCVE5E
         CciZ40TUxsmbTc95UDDmHDTdrM+tCTbs1pazJbBabgLaamZiue88OaoAtqWPCyjmtQYP
         xQKg==
X-Forwarded-Encrypted: i=1; AJvYcCXTAo8RwRIdjSVt/IIdJgawR3Q4gsgg6xQKKGDck38Vn0iWz+PpmpIpayyu2YG6rlcd1RXNI28OYiI4htM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQIb4bHDX9neFzkWCcQy4SMAL53pDOa/d9Pu/Tdr4qgmLrPj3
	ZFgwCtBgHYhHStzjTGdej4on9326NcYeRw1yf30oSMLvf2CxpKgb776Vw2UqP7I=
X-Google-Smtp-Source: AGHT+IHy1cqxEDldE+jOPeivOL7psrHsxOIdD/UD+h/Dzy5pOzG/4GiogDeZsSMbjYh7bZiqKhM2FQ==
X-Received: by 2002:a05:6512:1089:b0:539:959e:f0e8 with SMTP id 2adb3069b0e04-53d65de8ba0mr5390339e87.21.1730724203018;
        Mon, 04 Nov 2024 04:43:23 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057071fasm60567525ad.84.2024.11.04.04.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:43:22 -0800 (PST)
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
Subject: [PATCH 2/3] EDAC/igen6: Initialize edac_op_state according to the configuration data
Date: Mon,  4 Nov 2024 12:40:53 +0000
Message-ID: <20241104124237.124109-3-orange@aiven.io>
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


