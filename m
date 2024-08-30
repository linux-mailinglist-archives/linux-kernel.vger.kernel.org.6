Return-Path: <linux-kernel+bounces-308066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F8D9656CE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C9EBB23004
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B130E14C588;
	Fri, 30 Aug 2024 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho+5EnUp"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160A13C672
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724995097; cv=none; b=L6NDTf0pf/h+IlYnBViQURo4whhf8CDQ+518O1iZ9yOHz1lGEF1LokGu/TvnN1XbxFz3+8iQFcKNdiFENMzYBNcizG8TJvf8nrz+z04mul74y/C3K3i09OwqootoJqllJyL4yqECoTXPxeDPliJYoN9B0E+cK2tB54Ug1CF1NLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724995097; c=relaxed/simple;
	bh=t4kbdGAxtPguU+bAxcGS2rq6P+WLCvz4IOBMCY7MIKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpkYUDoo24ZumXXSB04CFCEw2/q9IfT9N8x+xpM+E+WPH/rhQ63unuDuO/68PZHC4DZDJA5KBZHAMeR/w2zPath9XgM6hj74HMHkDl+Rd+ecooCSzNua2H/VU9JBGwesF3IIQeghQK7dR5voIkQJ4jNFVZcE/+eHNKNoqu0WguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho+5EnUp; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-715c160e231so1178068b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724995095; x=1725599895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssc6z58Q9ZpbGeFW4UOcRDaOLol5H9gcdkFINcBIMq0=;
        b=ho+5EnUpM78E6IdDe62wDqomoT7EXvEWCzvowyWOBMmIj+by+pKse4LGqa2qTZ6LVn
         3MoL8ilrt/Aky4Z1w5XHuYYsUwC0Hgn5YWziMpKDWk3GSy5zpx2u1QvsgqBXjvOiYSxq
         pC/PaIvDroZPQYgWy70B1rn5oQby6xregh3dC8e+ZRUiryRGy1sS/suy+ZuzcYxilMSv
         YR8KEz+R8sqXkIOFX+6civ80akb7Sl/758CHQVgQ3t/dPYHqMav8zQKC5epIxFklX0kr
         SYvRo/RiJZViyq+sPdAVLGCwTm34omTL+9+PbXVZ4/X8KSoLF1P7VVPPWDS9g2/9z+aK
         IB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724995095; x=1725599895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssc6z58Q9ZpbGeFW4UOcRDaOLol5H9gcdkFINcBIMq0=;
        b=Z7R1i+5ixf9Kw3eBveA87AOPsqsvKCQg/bW3MWXNJgqOLyhw1l/49as0hYIBJRspfQ
         Irgc53InCElAI50uwUtzFa97iQG7NrcEtj3GCX/Qy5iyJo9aDMyOqCQkg1fRM0W+eHaF
         V+9OhncPi+mwBf81B8/LfHz0b2RU07/JKUGNAmL69vkh9Uc6Nzq6wId2h1JX9mFhjNQk
         /aPLwlq2GdSaqNNWsUMB4zTLAFLsWcLyCR9NRdasTX8zMT/FA2kvJvk5ky5034J7jmwB
         gizf2BChvLUZLfTG9NdC5PDIlekrY7mS30a2x4amwFjZD99fd2JjQ9IaiM+yReumR43y
         3bDA==
X-Gm-Message-State: AOJu0Yzqux0d23dk7rR6rOaWI25siE72595YvIE7mU3Z/KQmkn96t9WR
	x0tnKtkMMqAsdFGKIGSxReuPEFCOTiQLkmXAo57zMT8QMoM5e54H1P1Ec/n6ldw=
X-Google-Smtp-Source: AGHT+IEPva632bmQqJBFKxEikCEAtW8zvLrbfVLcHcMd2B/A84V4ALPqbhoFVkZqv80iEMAfbk4CdQ==
X-Received: by 2002:a05:6a00:3d0f:b0:714:24dd:b3ca with SMTP id d2e1a72fcca58-715dfccb2d1mr6894479b3a.24.1724995094788;
        Thu, 29 Aug 2024 22:18:14 -0700 (PDT)
Received: from fedora.. ([106.219.166.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e557b960sm1973127b3a.41.2024.08.29.22.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 22:18:14 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: vme_user: changed geoid data type from int to u32
Date: Fri, 30 Aug 2024 10:48:07 +0530
Message-ID: <20240830051807.4397-1-riyandhiman14@gmail.com>
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


