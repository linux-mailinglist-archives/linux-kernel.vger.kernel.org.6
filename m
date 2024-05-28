Return-Path: <linux-kernel+bounces-192115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117028D1897
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF53A288C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD82516C45D;
	Tue, 28 May 2024 10:27:24 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA016B72D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892044; cv=none; b=JrSbHaKHXae8u7c0V3OzYXT20oe/M8l5/JwwyQR87/Imvyp2D8Pk5s3/lJpGQFWp2jSRjYpRoAT+pV082kqB9EW8nVpiKkm8/M1a2pwXyX3OrAU19SU+quokO0QpmTfkXcv9wJAVDz6b69g4GCgNt8nDQyVC+lGpCuVOS5FB4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892044; c=relaxed/simple;
	bh=GZc8x9iHuY9Px/1rUVgjFt08MsDSpXrXnuf9QEySDXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXVHMZws+2bQbwGo3r3U1KCsyHwU3diQTO6z3lqQvZXp67lB+196wN1BqQGYA2ULuPFAswE2QIuVt9e1Pbfvm9f7C0Te3T9dgd/bNevgw6Ibq17SbjPFNl/6MX+krXShh0uyg3wzrT997cCZXhHNLPn/swnWmUHlqMJP1YdNyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id dce6d4f4-1cdc-11ef-80c1-005056bdfda7;
	Tue, 28 May 2024 13:27:19 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guanbing Huang <albanhuang@outlook.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	Christoph Hellwig <hch@infradead.org>,
	Woody Suwalski <terraluna977@gmail.com>
Subject: [PATCH v2 1/2] PNP: Make dev_is_pnp() to be a function and export it for modules
Date: Tue, 28 May 2024 13:25:02 +0300
Message-ID: <20240528102708.1451343-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528102708.1451343-1-andy.shevchenko@gmail.com>
References: <20240528102708.1451343-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we have a dev_is_pnp() macro that utilises the address of the
pnp_bus_type variable, the users, which can be compiled as modules,
will fail to build. Convert the macro to be a function and export it
to the modules to prevent build breakage.

Reported-by: Woody Suwalski <terraluna977@gmail.com>
Closes: https://lore.kernel.org/r/cc8a93b2-2504-9754-e26c-5d5c3bd1265c@gmail.com
Fixes: 2a49b45cd0e7 ("PNP: Add dev_is_pnp() macro")
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pnp/driver.c | 6 ++++++
 include/linux/pnp.h  | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index 0a5d0d8befa8..3483e52e3a81 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -266,6 +266,12 @@ const struct bus_type pnp_bus_type = {
 	.dev_groups = pnp_dev_groups,
 };
 
+bool dev_is_pnp(const struct device *dev)
+{
+	return dev->bus == &pnp_bus_type;
+}
+EXPORT_SYMBOL_GPL(dev_is_pnp);
+
 int pnp_register_driver(struct pnp_driver *drv)
 {
 	drv->driver.name = drv->name;
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 82561242cda4..a8def1cea32c 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -469,7 +469,7 @@ int compare_pnp_id(struct pnp_id *pos, const char *id);
 int pnp_register_driver(struct pnp_driver *drv);
 void pnp_unregister_driver(struct pnp_driver *drv);
 
-#define dev_is_pnp(d) ((d)->bus == &pnp_bus_type)
+bool dev_is_pnp(const struct device *dev);
 
 #else
 
@@ -502,7 +502,7 @@ static inline int compare_pnp_id(struct pnp_id *pos, const char *id) { return -E
 static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
 static inline void pnp_unregister_driver(struct pnp_driver *drv) { }
 
-#define dev_is_pnp(d) false
+static inline bool dev_is_pnp(const struct device *dev) { return false; }
 
 #endif /* CONFIG_PNP */
 
-- 
2.45.1


