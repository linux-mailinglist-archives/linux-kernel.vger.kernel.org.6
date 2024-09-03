Return-Path: <linux-kernel+bounces-312849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95A3969C66
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600B61F22BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3681C9857;
	Tue,  3 Sep 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7ASvUJj"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C51C768A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364180; cv=none; b=IKKiKiAFcAlY68rxDSI+GvcDN+j/Ee23cgPUS10uLzRNfk3JDS/tZaX+MU+HBLTaaojvdkCiHvs0H/jDacHtWi+kWPOk6hHefikOxDMN+j6sd0Ggs0EEHhknmXMVOS1/NBzUk15I3YD8RtdwJkXK2eo5oxujB8HH9fmFyJhHRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364180; c=relaxed/simple;
	bh=hg2nMzLMkXMJQSnFT++plnotGh0SMsPXzQ8K0k1UGHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+VmE4ZW79d8ZhMqLqvrvl/UlkOtP9xvFfn10yMuopO6lVgPWuR83TDzMlnubVsXzIc2XMggIqMXqZznGZ+mWeUHc7T7a6iMFI2GckjB6LyJE3g3KXiHF4ztL3wijnFDurzuQxkuLUP+Hb1jNyN0DquDwE4CUN0l2nLgxGrW0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7ASvUJj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d885019558so2452950a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 04:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725364178; x=1725968978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U6C7QkWlVDKnT2CWXcrqEZKngVRL71CQp2rLjnAagZU=;
        b=m7ASvUJj6COAXvjbEN7cjb2n4mocM8WFgKE6GYczVAtPY6OkAbv0/kKlD3xg5zbonm
         8thoKDXpYgtRCBivKcl4Afc7q++ucQlF6CFd1QjEUrzLAa+3TvqbUhl3mQnc2HgkIeF8
         yUr32bIGYkhjfqWSLjT6U9O7igyiXRKMqFjDgwc4cj7zdrPCptfEmRd7VFl+KlxkNwDW
         Ovih7LZ2CnO0UN0wRRra+3IQIkq4ktJGPoLi8ziu2BYhtZWVOOr/95EFKD7wCha4J1HA
         AGOY9nRf+HHPIohTE/QvDOLNawTaq0RQg5QxQlpx2cdk5vLdXUtqBjIakS2spjNmi7AY
         vQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725364178; x=1725968978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6C7QkWlVDKnT2CWXcrqEZKngVRL71CQp2rLjnAagZU=;
        b=Rek1WTd8oAlOp3tgsxmuIwy5u947+/Vavuilvanakwc0IQ+XhIxXodF4ABnu8cXsdX
         z3W1guQo7/83ds0PJBbKS6Js3t3y8Im/DapCYsYz6u5CByoC04rsUJ1BDzJljdl3Pf71
         Km5s6AqwGShVRdkiD077FhHjoopRPMl0GqnY/R57YNjquRulDTGK8+wevSKz/9lAQR2K
         Amuitj1QCem+SNm0cS4vd0qG3iU5P3cMFmtk02onpFqic4mTB1+UYHucxvVk8z7k4FMp
         njx+3m00x3/TlvCwYuEmyIxmKPNOJdogHrZZXoAdBz5bHTaE/BrTFPxu3J/yfYdtiDe4
         +pjQ==
X-Gm-Message-State: AOJu0YzTD+lk9G1nNl2Qeld9cKqTn7Vt3UpkIC317tHxv0RDy+dCAR45
	gIFHhPWF7UzEq4GIsTddfQ6FtMxq00Nb0mycR+Vxq5x6aqC4LL3+
X-Google-Smtp-Source: AGHT+IFNV3FArPUfswa8M56Sn3485ijYAdQYs9HZbjTrSUzH+sRJtgY65inZ+m7W2suJ2zZ1NYY5Ag==
X-Received: by 2002:a17:90a:ce8f:b0:2d1:ca16:554d with SMTP id 98e67ed59e1d1-2d893284d70mr8485199a91.4.1725364178208;
        Tue, 03 Sep 2024 04:49:38 -0700 (PDT)
Received: from fedora.. ([106.219.162.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85afb2d88sm11108780a91.0.2024.09.03.04.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 04:49:37 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH v2] staging: vme_user: changed geoid data type from int to u32
Date: Tue,  3 Sep 2024 17:18:51 +0530
Message-ID: <20240903114849.4953-3-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Geoid is a module parameter which is set by root user.
Its valid values are between 0 and VME_MAX_SLOTS. So, changing data type
of geoid from int to u32 since it will always be positive.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
v1 -> v2: changed data type of geoid to u32 and removed negative geoid check 

 drivers/staging/vme_user/vme_fake.c   | 6 +++---
 drivers/staging/vme_user/vme_tsi148.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index c4fb2b65154c..4a59c9069605 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -79,7 +79,7 @@ struct fake_driver {
 };
 
 /* Module parameter */
-static int geoid;
+static u32 geoid;
 
 static const char driver_name[] = "vme_fake";
 
@@ -1059,7 +1059,7 @@ static int __init fake_init(void)
 	struct vme_slave_resource *slave_image;
 	struct vme_lm_resource *lm;
 
-	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+	if (geoid >= VME_MAX_SLOTS) {
 		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
 			VME_MAX_SLOTS, geoid);
 		return -EINVAL;
@@ -1289,7 +1289,7 @@ static void __exit fake_exit(void)
 }
 
 MODULE_PARM_DESC(geoid, "Set geographical addressing");
-module_param(geoid, int, 0);
+module_param(geoid, uint, 0);
 
 MODULE_DESCRIPTION("Fake VME bridge driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 6b6ad781b966..31a44025e08f 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -36,7 +36,7 @@ static void tsi148_remove(struct pci_dev *);
 
 /* Module parameter */
 static bool err_chk;
-static int geoid;
+static u32 geoid;
 
 static const char driver_name[] = "vme_tsi148";
 
@@ -2252,7 +2252,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct vme_dma_resource *dma_ctrlr;
 	struct vme_lm_resource *lm;
 
-	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+	if (geoid >= VME_MAX_SLOTS) {
 		dev_err(&pdev->dev, "VME geographical address must be between 0 and %d (exclusive), but got %d\n",
 			VME_MAX_SLOTS, geoid);
 		return -EINVAL;
@@ -2631,7 +2631,7 @@ MODULE_PARM_DESC(err_chk, "Check for VME errors on reads and writes");
 module_param(err_chk, bool, 0);
 
 MODULE_PARM_DESC(geoid, "Override geographical addressing");
-module_param(geoid, int, 0);
+module_param(geoid, uint, 0);
 
 MODULE_DESCRIPTION("VME driver for the Tundra Tempe VME bridge");
 MODULE_LICENSE("GPL");
-- 
2.46.0


