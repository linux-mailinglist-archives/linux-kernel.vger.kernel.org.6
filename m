Return-Path: <linux-kernel+bounces-230260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54995917A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857DA1C237E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4899015F3EA;
	Wed, 26 Jun 2024 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOWiHott"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B0364D6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389362; cv=none; b=eX/5oxRa/+b5fY0TcuZYg4rpP9sXxHAYUgICaBa1eRoGl9SQGFB4Mhr61LluEPc4WLQrAAETLyDmP5wgEad4k/tgHIPNhXZrVWUVIo2WI2FxUN1TF4YAM/jGqvKc/XBKgWE6Havw7+Yvu/qYuaiLOrYxrNsOVAkwmvxO2jEqQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389362; c=relaxed/simple;
	bh=IAj/HyWqF34CBYdNiU2v1M/ZYcANxjkDdMbIT/zo+lM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SRrqBvc0Az2v0bnk98K3CF2mKcnw2M/xcg2OiE0H8awim1a035l0KdI6ubKuUoTFKf+5LCuQvn1HmXg1m/9xoEL8mkbBxwKGqZJPd0DwMYPG5c4bCax7Q8KTsPQSGRDN/SPNt4p1l9I8XEGc4TV+RyWjJv9B7cdX2ZmX32eOfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOWiHott; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f9bf484d9fso1649985ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719389361; x=1719994161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHr65P0G1QIxVEIvdANGC2Rr426XZ8bqusMBD1XEJpA=;
        b=dOWiHottF3Nr4B6uFoexbJHWGyLKlMLnUBq9hExOw8tJLCFakW/Doreb435VK9GsPp
         Lp4rCPGk9/KC/tVNat4zpLQWWoilsPZ3hwWwQxliQVt+FxAs8VCJsYFYP9JyXPoHzBE+
         FnGjit38nRbMPMuYWyB7Mjb4znidZSwGBSkTof4YQ90ECYuaT6CLSULRSUYI643fT2Od
         ew+eGMYujh+zpoaBIOSEd2MHac1G31KnFxUYrt3IB6CD4cvB3+TlzT0duygJQ0aA01DU
         HxLr5e8jd/A/EccpsuIxHATrwm4GhrSb0BURg1qm9B4VR8efI1w8DyhLrEaN99aVhAqC
         SGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719389361; x=1719994161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHr65P0G1QIxVEIvdANGC2Rr426XZ8bqusMBD1XEJpA=;
        b=GL5ifIVZCKU7fO3t+VR9975DGMGVb5tVBKpOhZwni4ONWAFOcQqQCnFJhu1fWNK60N
         aslOBRv8tE1wxcuf2z40q1h3+OcUEUXejk1jVU+ZgcSDUjdP/3IHl8xBAKr40sm6mvUe
         2u2rGe7Iwtfm7RLSssMIOiqcl/R0BJT0kb7N9ViLl47GrTMniA9C7fb23hc8MKwcRKaC
         ceKSPNSgJusY1BucIFMPiO2Y+7ij9nDhCjQKbU8rnFyC+TWebhYJRHMPNxr1bAIr4scB
         JPGHdjo79flzlfLX8GzDirtZwMObhOKNC6WrB8/1v6uBcD8QQMiGFCnfk7xDa2hl6jQj
         p1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUBeHe6AWwNHTxGnGA2tiej5aCSrT2+jB2CoDmc5/srLTORSR6bHWV4Jhangr4iBTjajZLGO2dnfV79La5258rDSjCj5eLMgjQTmAs8
X-Gm-Message-State: AOJu0YxojubEQRbDlEkbUHkgNd9kF9cjK15TgyTzwo76+b+NK7oA6vYV
	8+93HG4RX5gFEVJijZazIM2bI5d9bF5vXL7dTRZjdCxs6nxv3ZibhYC05g6UIz8=
X-Google-Smtp-Source: AGHT+IFSRIZBvzROTW0FmIImtpqxit1LhxMlon6bWdJ346/3jiQERbAZRilUfkforEG3K9JgXiBKYA==
X-Received: by 2002:a17:902:f545:b0:1f9:ec87:284e with SMTP id d9443c01a7336-1fa5e698121mr96305425ad.16.1719389360571;
        Wed, 26 Jun 2024 01:09:20 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb321715sm94358895ad.93.2024.06.26.01.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:09:20 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] phy: core: Fix documentation of of_phy_get
Date: Wed, 26 Jun 2024 12:09:10 +0400
Message-Id: <20240626080911.203630-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_phy_put is used for of_phy_get to release the reference count.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/phy-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index bf6a07590321..f053b525ccff 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -664,7 +664,7 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
  *
  * Returns the phy driver, after getting a refcount to it; or
  * -ENODEV if there is no such phy. The caller is responsible for
- * calling phy_put() to release that count.
+ * calling of_phy_put() to release that count.
  */
 struct phy *of_phy_get(struct device_node *np, const char *con_id)
 {
-- 
2.25.1


