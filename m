Return-Path: <linux-kernel+bounces-247171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED72D92CC29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985851F237B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F885654;
	Wed, 10 Jul 2024 07:45:04 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE215D535
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597504; cv=none; b=SduJq5tWmE+B36aEtjuEhAwj7aJfejDt05ZE6ejjIHiOfWAAiJiSWoiSv1FPtd7bTF0Hn4Otdo422+NmUNapFUju7ceds0awUtcPo6pxSJcKvDwchlIGoIfEbDA38JJWzXU+hrBxe9L98+3jQc6zATD7SPRbKqrvaFAtC+oUQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597504; c=relaxed/simple;
	bh=d/Jy8u/E1KSQfKo9JxGix6z0rwDf5U76cR/90Da840c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=efD79dSRwG9Ky1ABn8LkGh/XgGqnmoSftSeojc5O0Ml+wF8zWnDB1MXJnLte7/80NBgLUDAwZKW+iwBJZayZVb1Zziq1bdizpquwhH3DUCgNn78nqw8Gn3AucIvx1GwPd/yrqvhcR/SxlMk047wpTC09qjrrEjhVnJqVM9OCazU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2340:18a1:4138:37d2])
	by xavier.telenet-ops.be with bizsmtp
	id ljkt2C0024znMfS01jktRR; Wed, 10 Jul 2024 09:44:53 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sRS0F-001b1I-Bk;
	Wed, 10 Jul 2024 09:44:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sRS0S-00Bv7Y-Tp;
	Wed, 10 Jul 2024 09:44:52 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dio: Have dio_bus_match() callback take a const *
Date: Wed, 10 Jul 2024 09:44:52 +0200
Message-Id: <20240710074452.2841173-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

drivers/dio/dio-driver.c:128:11: error: initialization of ‘int (*)(struct device *, const struct device_driver *)’ from incompatible pointer type ‘int (*)(struct device *, struct device_driver *)’ [-Werror=incompatible-pointer-types]
  128 |  .match = dio_bus_match,
      |           ^~~~~~~~~~~~~
drivers/dio/dio-driver.c:128:11: note: (near initialization for ‘dio_bus_type.match’)

Reported-by: noreply@ellerman.id.au
Fixes: d69d804845985c29 ("driver core: have match() callback in struct bus_type take a const *")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/dio/dio-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dio/dio-driver.c b/drivers/dio/dio-driver.c
index 2d9fa6011945d88b..12fa2d209dab9d3c 100644
--- a/drivers/dio/dio-driver.c
+++ b/drivers/dio/dio-driver.c
@@ -110,10 +110,10 @@ void dio_unregister_driver(struct dio_driver *drv)
  *  and 0 if there is no match.
  */
 
-static int dio_bus_match(struct device *dev, struct device_driver *drv)
+static int dio_bus_match(struct device *dev, const struct device_driver *drv)
 {
 	struct dio_dev *d = to_dio_dev(dev);
-	struct dio_driver *dio_drv = to_dio_driver(drv);
+	const struct dio_driver *dio_drv = to_dio_driver(drv);
 	const struct dio_device_id *ids = dio_drv->id_table;
 
 	if (!ids)
-- 
2.34.1


