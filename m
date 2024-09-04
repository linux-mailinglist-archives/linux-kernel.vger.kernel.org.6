Return-Path: <linux-kernel+bounces-315805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FEC96C730
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E35283F08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DC31E2036;
	Wed,  4 Sep 2024 19:09:05 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E2E1D0166
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476945; cv=none; b=cFRU5MVt0DGCzbh8CkPCQffMexJD/KziiyzsOt3VEurh9I8z1dTZjxjbxYRUuwq6ByS/Y7hH7+l2Z87coNMjwM7rkXVa4Kj9MmbDR5jyyCyyIaBKR1n6l4NIy3+V2OfpZcWbXoHYlq+uUN0Mq8LHtoZZ6lyagHdm9+gCOGfn0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476945; c=relaxed/simple;
	bh=uRaIZ9Gpw69kwLXIQPRm+mnYl4pgZGIAUJVF/jZaOZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZJmenzv96K5ITt8egHNdN+VIBNvaDz/+C+6lFNEZvU3co5bSkBfg3QKefN3aD45nwcEv072S5KgySjF/WnhtdEASogMccjHfcXkJ27nOTINQkp/Dk38IID4Q3vsJ/83JNVxe4GCs172NVrijCPhZpTNYCizQrp37iM1kPUlCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 24590992-6af1-11ef-825d-005056bdfda7;
	Wed, 04 Sep 2024 22:09:00 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] regulator: of: Refactor of_get_*regulator() to decrease indentation
Date: Wed,  4 Sep 2024 22:08:56 +0300
Message-ID: <20240904190856.1221459-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor of_get_*regulator() to decrease indentation and increase readability.
No functional changes intended.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/regulator/of_regulator.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index d5dd7a9e577b..3f490d81abc2 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -572,14 +572,12 @@ static struct device_node *of_get_child_regulator(struct device_node *parent,
 
 	for_each_child_of_node(parent, child) {
 		regnode = of_parse_phandle(child, prop_name, 0);
-
-		if (!regnode) {
-			regnode = of_get_child_regulator(child, prop_name);
-			if (regnode)
-				goto err_node_put;
-		} else {
+		if (regnode)
+			goto err_node_put;
+
+		regnode = of_get_child_regulator(child, prop_name);
+		if (regnode)
 			goto err_node_put;
-		}
 	}
 	return NULL;
 
@@ -607,17 +605,15 @@ static struct device_node *of_get_regulator(struct device *dev, const char *supp
 
 	snprintf(prop_name, 64, "%s-supply", supply);
 	regnode = of_parse_phandle(dev->of_node, prop_name, 0);
+	if (regnode)
+		return regnode;
 
-	if (!regnode) {
-		regnode = of_get_child_regulator(dev->of_node, prop_name);
-		if (regnode)
-			return regnode;
+	regnode = of_get_child_regulator(dev->of_node, prop_name);
+	if (regnode)
+		return regnode;
 
-		dev_dbg(dev, "Looking up %s property in node %pOF failed\n",
-			prop_name, dev->of_node);
-		return NULL;
-	}
-	return regnode;
+	dev_dbg(dev, "Looking up %s property in node %pOF failed\n", prop_name, dev->of_node);
+	return NULL;
 }
 
 static struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
-- 
2.46.0


