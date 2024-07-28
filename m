Return-Path: <linux-kernel+bounces-264829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BDD93E8DF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A1C1F21733
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458506F067;
	Sun, 28 Jul 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mKJ18isf"
Received: from msa.smtpout.orange.fr (smtp-83.smtpout.orange.fr [80.12.242.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9AC2E859;
	Sun, 28 Jul 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722191416; cv=none; b=Y1K1LPaFAQ6JaKa4EsLJqIJPaqn7ad3swl2/oRgbtBEk3NlgNAdCXxSUqgfpOrIdhDOG6TDkjSgT5UIf/TDWOtmV2kjG79CDHzl29lUBWd7I3YilMhRMU3RgN6L2UtOHUjDhLFQKsvtvd1cvfTiLG9ApMn3JIPGmF2oIk77BQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722191416; c=relaxed/simple;
	bh=Po+jf59OgWZe7ga6gwE7Q3SbHfhVlVjb7CMLEJgb/90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRJnB1EMKp5tCemcqE48vZpuo9B02ADKgPYbBj8x+lgAXACXO+rFLPYihPeIKyseMjhltDqn9L+6VXgSKkz44r/QWBVNRUdgkLH+Dx9yPVTTzJMcv7TKslSBF8ejYAmPEX1xy5VwRgN4fF167sVQEhbC8KTh+EGbG4MUPwT9ZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mKJ18isf; arc=none smtp.client-ip=80.12.242.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Y8ehskV3jYjQzY8ehsdEJs; Sun, 28 Jul 2024 20:30:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722191406;
	bh=aHRr46GwE+uyksv7tBA8rAadSHSqFFR/MCO6+hVj1uk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mKJ18isfp/UdJbLq8eTjt5hzxV/dfxabgAVcoQ2rAdaQF3R2TphCNVVEvEyk7Crnq
	 Qa47ZnqQyvVssPt0mh70NxxDhTdVxbh6U5Kq+q8Om4oYsNuLzV7hJyUqhjUfjVGYjh
	 ktORbHXZsHJjr88ahzm48Wztm+4qlsNiUEYicMzECtX6+dXg6vVy1kDBAo/tzDMtMa
	 XWacCL7jCB+tYoz34cMJRn68ge5VqW7guGKORGI4/2+z96jdEG0wINVC/J3H/u5D/8
	 zw6jamr2TE3F4WOQOc8EE0z73bxTWSBhNYe63fqPJm4NxNCbZ1nHY4KjXg4W4k1KZ9
	 3cuLhiiu6jpoQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 Jul 2024 20:30:06 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev/hpfb: Fix an error handling path in hpfb_dio_probe()
Date: Sun, 28 Jul 2024 20:29:47 +0200
Message-ID: <dc4fe3d857849ac63131c5620f1bacf1a3d7172e.1722191367.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after request_mem_region(), a corresponding
release_mem_region() should be called, as already done in the remove
function.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
*Not* even compile tested only.
I don't know on what architecture it relies on.

So it is provided as-is
---
 drivers/video/fbdev/hpfb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/hpfb.c b/drivers/video/fbdev/hpfb.c
index 66fac8e5393e..87b8dcdc1cf3 100644
--- a/drivers/video/fbdev/hpfb.c
+++ b/drivers/video/fbdev/hpfb.c
@@ -342,12 +342,17 @@ static int hpfb_dio_probe(struct dio_dev *d, const struct dio_device_id *ent)
 	}
 	printk(KERN_INFO "Topcat found at DIO select code %d "
 	       "(secondary id %02x)\n", d->scode, (d->id >> 8) & 0xff);
-	if (hpfb_init_one(paddr, vaddr)) {
-		if (d->scode >= DIOII_SCBASE)
-			iounmap((void *)vaddr);
-		return -ENOMEM;
-	}
+	if (hpfb_init_one(paddr, vaddr))
+		goto err_unmap;
+
 	return 0;
+
+err_unmap:
+	if (d->scode >= DIOII_SCBASE)
+		iounmap((void *)vaddr);
+	release_mem_region(d->resource.start, resource_size(&d->resource));
+
+	return -ENOMEM;
 }
 
 static void hpfb_remove_one(struct dio_dev *d)
-- 
2.45.2


