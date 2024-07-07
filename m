Return-Path: <linux-kernel+bounces-243557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B209297A8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 13:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7E41F214B9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 11:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158D1C286;
	Sun,  7 Jul 2024 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kzIORbiS"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44156FBE
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720352351; cv=none; b=XqupCcKwKj6E8JX+VAFYO0Y3ZNycAtn5ebKJqaqwkYUJoUnTjkKhPlP+ZkarQ24skBAqxCAANK/oVeDN6Zn0mlNufMTp5TnGjmjrt2TQerfJDoQc55xYbmCUt8HmzO8iNOcOfn3VDXZvxd8b9GGyiBEDZzOVuYoN8nfhhgyI1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720352351; c=relaxed/simple;
	bh=T2whgI8NzRKziduaNUYQ4B8mIs4io9Ikg5vI65VVnOI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oX4vrwdadCH04cbEcjDYfTOqfNw/oP+0Fe4THpMf4dyXmGfeU/tHGSPm16vrJo4odLqrglRwe0s9KcglKxRak3YeZ1q3maz6yzuQSq+7uIbAOycpTiHkkV92YI5iA1uJpqfhVt7x2ivmiKAIQ7hO67SQ9R5orwWFRYwjh9ZU4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kzIORbiS; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=lW9P4fE4UgSQNq0AWC
	mprAyHMH36OOKG3BU4YsESyUw=; b=kzIORbiSCgDipLvTCPFrlyeR2FsRM31XEX
	nVLHGC6AD5vmCoz64JVS+JrTnp6YnNifEFg5eWyYN0OyaGlTT5Pex0z53STUGVzE
	LCC7J873CdS1ovTJL3+SJoKy8mQoUe93tNnrOaWR9TJdxY/j1JsxVZxj5EOx/17W
	ZE9jkpylI=
Received: from localhost.localdomain (unknown [114.92.56.131])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wD3_7aMeopmv1HcBQ--.57812S2;
	Sun, 07 Jul 2024 19:23:10 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] driver:core: no need to invert the return value of the call_driver_probe()
Date: Sun,  7 Jul 2024 04:22:36 -0700
Message-Id: <20240707112236.3187-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3_7aMeopmv1HcBQ--.57812S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr13tw4DCF4DWF13AF45Awb_yoWkZwb_Cw
	17ur9ru347Kan7Wr18XrsrZrZFkF4xWrs8Zr40qas3tFyUJ34Y9F4DWr98Jr45W397CrWD
	Cry2grW8ur13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKkucJUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiSB8Vq2XAmJL2-QAAsN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

If drv->probe() or drv->bus->probe() returns EPROBE_DEFER,
then there is no need to invert the sign. Similarly,
if it returns -EPROBE_DEFER, no sign inversion is needed either

In the probe function (either bus->probe() or drv->probe()),
there is no return value of EPROBE_DEFER.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/base/dd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 83d352394fdf..d047919d1f5e 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -664,11 +664,6 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		if (link_ret == -EAGAIN)
 			ret = -EPROBE_DEFER;
 
-		/*
-		 * Return probe errors as positive values so that the callers
-		 * can distinguish them from other errors.
-		 */
-		ret = -ret;
 		goto probe_failed;
 	}
 
@@ -826,7 +821,7 @@ static int driver_probe_device(struct device_driver *drv, struct device *dev)
 
 	atomic_inc(&probe_count);
 	ret = __driver_probe_device(drv, dev);
-	if (ret == -EPROBE_DEFER || ret == EPROBE_DEFER) {
+	if (ret == -EPROBE_DEFER) {
 		driver_deferred_probe_add(dev);
 
 		/*
-- 
2.17.1


