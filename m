Return-Path: <linux-kernel+bounces-191386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5394A8D0E91
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0366528145F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EBB3BB59;
	Mon, 27 May 2024 20:25:42 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CC17E91C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716841542; cv=none; b=eIvcQVErXFiBYk9yaBdExBT4hMuonTCRGEzrFUMvj3NBy3oiNvLv/cZzEfViRVxFBlUj85XXa2dLKraUXHMxTLi928r2HfL2bZprDJ6+AH4+p/vonmUiUXIwahH9pQFvGvac7hcu6BoWp9AxAzi5K/ljbf7Rwn1XIic2hKJw1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716841542; c=relaxed/simple;
	bh=kzOn/pg9oEMfSMyQo519MSdFHUDCKUEJSi3NgD70QJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GR9Z9ZwaeXXK8qsqVXV7CoUso2/uun1VGMrSQwVtGdW4IRjmhx9HKTgjv6f2RV93Cv9LPeb2icnx267lHYnd2+nhUaosSTLoCOniOh7AE2Yk5lF0rEpVGLciY02I/0GKOjSHjTanWaE9A6kvqHhojS8QtyPyw4OhYTOU//AyleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 1ed924e2-1c67-11ef-8d38-005056bd6ce9;
	Mon, 27 May 2024 23:24:30 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guanbing Huang <albanhuang@outlook.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Woody Suwalski <terraluna977@gmail.com>
Subject: [PATCH v1 1/1] PNP: Export pnp_bus_type for modules
Date: Mon, 27 May 2024 23:24:24 +0300
Message-ID: <20240527202424.1430103-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we have dev_is_pnp() macro that utilises the address of pnp_bus_type
variable, the users, which can be compiled as modules, will be failed to
build. Export the variable to the modules to prevent build breakage.

Reported-by: Woody Suwalski <terraluna977@gmail.com>
Closes: https://lore.kernel.org/r/cc8a93b2-2504-9754-e26c-5d5c3bd1265c@gmail.com
Fixes: 2a49b45cd0e7 ("PNP: Add dev_is_pnp() macro")
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pnp/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index 0a5d0d8befa8..1394d17bd6f7 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -265,6 +265,7 @@ const struct bus_type pnp_bus_type = {
 	.pm	 = &pnp_bus_dev_pm_ops,
 	.dev_groups = pnp_dev_groups,
 };
+EXPORT_SYMBOL(pnp_bus_type);
 
 int pnp_register_driver(struct pnp_driver *drv)
 {
-- 
2.45.1


