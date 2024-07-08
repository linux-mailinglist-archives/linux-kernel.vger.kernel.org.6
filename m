Return-Path: <linux-kernel+bounces-244407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC9892A3D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9731F227E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ED11386C6;
	Mon,  8 Jul 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JOPtNYSE"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7251D137756
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446108; cv=none; b=FD9/OOLTgHyhqIflFroX10EynUGOBQVi2nIZZpbvMjfbuiPlui58ZAR8JoqM3Yqe/LrncKCqGoQob+GPj/Bv/RRSZIjvtgSigS2UxjtZvueQYD/F6RGGl1P0TmBuXZi6cJzw6Tczgi/n5QTV7bN5MG4Ah/EpX7JjMVnlqmNQUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446108; c=relaxed/simple;
	bh=Zc8wsCIQE4QkcpxF2KwUhLk6aeniGtxftQtx16r6/tY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CCZwzoCevNpJUXUCJo/kTugXXocFq9fanYC3SUiRv+YBknxSS7J7RgC/nenMGs3FlH2A8wgRGcR9E5+1GLo4B3NV6bvHBPYyiO6dQPoiXGJOSq2xvMIyT0p+SNBoQAuz4s5mWhaL31t/T9q7r3hr+nWaXRFR/0chrRTdt+N/lqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JOPtNYSE; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=9uM3U88wltXFJ7XyMg
	8j/4gf8aCYXSRp+GUIrje91R0=; b=JOPtNYSEJ/ZLAeCExnPqzyUviqVxBzoivN
	ZVU8RnZkcj7yQBRfd+8TojIWeMFEn5k0Po2jJ9B3p2/M5fhLLDnkM6qtF0I7NzIw
	Q67vtLI6CmujAkU9ua7gDRMwFrmAT09RnMuewYiQSkfP5HCEekUl7rOYmUkrjwhs
	1hqZmGSEo=
Received: from localhost.localdomain (unknown [114.92.56.131])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDXf2lY7ItmLIiECA--.681S2;
	Mon, 08 Jul 2024 21:40:58 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH v2] driver:core: no need to invert the return value of the call_driver_probe()
Date: Mon,  8 Jul 2024 06:40:28 -0700
Message-Id: <20240708134028.3508-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXf2lY7ItmLIiECA--.681S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1DGr4xXrW5CFy8AryxKrg_yoW8GryxpF
	4DAFWYvFZ8uayvkFWUGry0yFyFya1xCrW09F18G39a9w17Jry5GayxKrWYqr18XrW09FWr
	tFW5Z3yrGFWUAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pix9NxUUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiSAoWq2XAmKXSVwAAsi
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
v2:
        Delete the judgment with the return value of EPROBEDEFER
        from the _driver_probe.device()
v1:
        Add the judgment with the return value of EPROBEDEFER
        from the _driver_probe.device()

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


