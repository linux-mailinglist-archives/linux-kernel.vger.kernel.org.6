Return-Path: <linux-kernel+bounces-446278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81F29F2222
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7332165BB8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FAE8C1F;
	Sun, 15 Dec 2024 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="GqLWPWHn"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F928FD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734233993; cv=none; b=FayM71psluGXxA3XoP6Apt2L5dejFAiPOaJnOF7vT+cEdQwQsS4IOslKW1nij48JxPDPO1fUiHtFvlKa4KSW9cTbPWMFCSFTog1WlDRPkVEVLgMDJWObOXIpWiQyyTFD9v79JIpB4sCDh5MmY8cYbINDgfgiREwXUuaXOgcl3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734233993; c=relaxed/simple;
	bh=+RzpPYbczDs0ceaSnAvTSb5HGFXTdODXv8bzFxTnbho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JPjQfPI7HyxzxNrCo8VcmvZNRLo235/tYF8XSXPG2zG2rHNUHjSLTWrXBTIG9h48u6Rw7/TZbRZYmEISXC4AIzQBhuWKgCOcvPIUvycUG6nn5KiXVVLj7jqcQOE/AyT7gLYXA95MHrrViSp7p71t16OkWgCqdLoaIFrE+fJwHHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=GqLWPWHn; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso3214456a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 19:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734233990; x=1734838790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QucYTxoNFIQoZFl7iunkrbcE/LOYPuff6g2uMFrfQRU=;
        b=GqLWPWHnahoe+ZQw8934fbMGXdQUxK5d0RrbDyWEqb89F4uiYstVYCCqBaA3w4vkOy
         k9KK7D6T6RUV1PIXY+KZXX0oq5U8Inq4MvBcGxSilJgiOMVwDdLhd8BDN1J1FBWEY0EU
         XLQ2vO+HSNv8LHwNEvPyA2Czo+b91UrsUGrUMa8Jj7Ie6UuDeQ5XzIH/PsXF4L8PDGUC
         SSngDyToHl6x7hCRR0OxtMcSRxFUXGtRttGvZNuYPK31Tvufkgo15ELos5R8vJeBFCZ0
         KX2GZRrlj8xSkHdPfqwWDZ0NlROrI/FHc0oGrnaBo5umKk+JkMquUbute9/zbI+r/qVE
         UC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734233990; x=1734838790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QucYTxoNFIQoZFl7iunkrbcE/LOYPuff6g2uMFrfQRU=;
        b=rHg8z8VhyAdmb1O51wJ4T/9q2Aw4pgdQ8SW4IpSfBScwLKhbxoFQRkf6gNaQ+VTPMJ
         9Tx/WLrEakW/FgsNsH8/T3w3tl8oZr/48SGMcZ+OSLT64qVxslVcwjNvEba+aufxY31V
         pPbpqTsYPZ4AfdU2q4vouGKwR+TZH2sw1klLuHt2DkxuOjQL7MdV18+E/9wKf6MsYg6N
         PZvnsjmW9Z4d229tsQyLhFboq8yC3eJ5IBnXahH8cDtVkJh3mmSKmDtYeo2FvKwvXD41
         1VGCqumSDG5E4tmOPzTE8Mq88eOywHrq6X4nX21EFnVc7TCFxU9g3tNXgI4xK+f/EAQu
         tngg==
X-Gm-Message-State: AOJu0YzSODA0iQfBOGxexZZK80YoWNGNIhaDFUTudrHdDRKZQQnr6G9H
	p3vQdHDLvs2PC328JRRZwaxPuGvR40Er0uQtkrJVS6Mf6nuFdT3+boKQmgolbPY=
X-Gm-Gg: ASbGncvR0gvpVfLfJ9n7v5ge0mMtoyxSuIOkqPAquTk+LjW5/aWXD7bMjoY8jRn8F88
	Em8S/HX0LPsJf5seFtBO+PDywNZZwFyjqQbZFIfTdzRI19eX/ZK/l8xH6d1p1P90MWI7LdHKB7C
	7ADT7Dw2OdCOsDnF365pxAfHnwhTt8z4Sgg2yGXIIy1ADHhnqq+CMRvHuZjX9NZJFETRnewhLTR
	VyUWXs7oyyStIjJlK17Ap8npLJpfryZYnjzFnlw+1DWgPKKyeQVkEP13VeTzuvdOPIPhcH13dwQ
	ZCUdwNtSLcjtZtvpLmQxqO/kPjqhsJOTIH6KZnaXIxY=
X-Google-Smtp-Source: AGHT+IFcJ4yTXJ05VOqtqIZZVF+mnl1lvAx8yif3hGGbdWc6aJQ44AO8qrMvcQNgRZXUgodNORmx0A==
X-Received: by 2002:a17:90b:3912:b0:2ee:463d:8e8d with SMTP id 98e67ed59e1d1-2f13ac560dfmr19613008a91.14.1734233990279;
        Sat, 14 Dec 2024 19:39:50 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a1ebb737sm2475450a91.27.2024.12.14.19.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 19:39:49 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] irqchip: fix an OF node reference leak in platform_irqchip_probe()
Date: Sun, 15 Dec 2024 12:39:45 +0900
Message-Id: <20241215033945.3414223-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_irqchip_probe() leaks an OF node when irq_init_cb fails. Fix it
by declaring par_np with the __free(device_node) cleanup construct.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: f8410e626569 ("irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/irqchip/irqchip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 1eeb0d0156ce..0ee7b6b71f5f 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -35,11 +35,10 @@ void __init irqchip_init(void)
 int platform_irqchip_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *par_np = of_irq_find_parent(np);
+	struct device_node *par_np __free(device_node) = of_irq_find_parent(np);
 	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
 
 	if (!irq_init_cb) {
-		of_node_put(par_np);
 		return -EINVAL;
 	}
 
@@ -55,7 +54,6 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	 * interrupt controller can check for specific domains as necessary.
 	 */
 	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY)) {
-		of_node_put(par_np);
 		return -EPROBE_DEFER;
 	}
 
-- 
2.34.1


