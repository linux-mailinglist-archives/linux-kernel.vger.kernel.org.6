Return-Path: <linux-kernel+bounces-356359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6671995FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8EA1C21FD2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB6C1714AC;
	Wed,  9 Oct 2024 06:42:58 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2019722EEF;
	Wed,  9 Oct 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456178; cv=none; b=h5FYmFk2DOmHGlqT13mskKtG3H6v/3P75Yq+SFpf8n03kshCAxDq3GV2ClfFZlWntNLMEWSUIrq2woLbcsOH+9dqa9bY7GHKGcKqIY/88CXg8Zy3+AGk/VhNfCUy+240HYQPUUxz4t3sA68G7iQJGLKRzwfrh/cc06xzz7GDus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456178; c=relaxed/simple;
	bh=4Nt/BN0aKKGqM8bm78Pel72e+ku3bJ7zm67JWmsfAYQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HnwSexCru/UiUR1XtQQPtAG6wlNmWA8qxx1yzcY/N6OBCnjXufIJl+ZVoWxB3X0e7nB8DZJDzLXDFTHiv8MI2XNQmEytgilFf0M3irHYUzbNdf5Y7mYHwHJuqpuy0MvvDC5s6V8KuYGKPEiZSoX6f7qv5F0YH9cDstxpkTRU2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4670625e6e49-bb747;
	Wed, 09 Oct 2024 14:42:46 +0800 (CST)
X-RM-TRANSID:2ee4670625e6e49-bb747
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5670625e469b-dafd9;
	Wed, 09 Oct 2024 14:42:46 +0800 (CST)
X-RM-TRANSID:2ee5670625e469b-dafd9
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: olivia@selenic.com
Cc: herbert@gondor.apana.org.au,
	zhujun2@cmss.chinamobile.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] hwrng: histb-rng: Fix the wrong format specifier
Date: Tue,  8 Oct 2024 23:42:44 -0700
Message-Id: <20241009064244.6420-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The format specifier of "unsigned int" in sprintf() should be "%u", not
"%d".

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes:
v1:fix the subject line, it has to be in the subsystem style

 drivers/char/hw_random/histb-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/histb-rng.c b/drivers/char/hw_random/histb-rng.c
index f652e1135e4b..1b91e88cc4c0 100644
--- a/drivers/char/hw_random/histb-rng.c
+++ b/drivers/char/hw_random/histb-rng.c
@@ -89,7 +89,7 @@ depth_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct histb_rng_priv *priv = dev_get_drvdata(dev);
 	void __iomem *base = priv->base;
 
-	return sprintf(buf, "%d\n", histb_rng_get_depth(base));
+	return sprintf(buf, "%u\n", histb_rng_get_depth(base));
 }
 
 static ssize_t
-- 
2.17.1




