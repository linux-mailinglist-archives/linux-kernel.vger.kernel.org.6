Return-Path: <linux-kernel+bounces-213254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BD907326
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C29285DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B93614430E;
	Thu, 13 Jun 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aSWnI0GJ"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CA14374F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284074; cv=none; b=OuL2pc2HDb77l+hYgecyu6WtKkJnaYLG5bBfdtPth1Rk2OJxaoXpn4j8W/SDSLw7j6t7nHselWn3nLZbMx6WKrPnm7TlDHsvF0enDouzfnA9fNhNJbNtL3b8YA7i6s3hayZagtelKWMZ0d+FGaAksZv+dVF44/TRuOuH+zRgzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284074; c=relaxed/simple;
	bh=5v3OteQ+iPtQtwsfpvDZgQXYC34uG2KmvqnZtL5tCmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmNIV4UhfRhVepwn6c8+OwPqcUaTy7KAEqXaSuqMFfpGRCv4uwuv4vK1CDvWMFKVZXejj3b5setvfp4pR0DBwUNzfhmxjXC20Prn3IgHGEHY4dlACbCq3Y6XVcjJrgg8jOTVGA8MjEffo7FeG6kiAp+8p1gA4xUlOJ7krsOmguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aSWnI0GJ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3045D240010;
	Thu, 13 Jun 2024 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718284064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpfOLD3dQlg2lQGCyJu7ICX5/KRhRcQjupadFQHV4Ko=;
	b=aSWnI0GJT5OsyF4/x3DUYccXEeeAlC76BYGQ9IDwjYWAWj/Mh3xZlIJpJg8QW4MshbepBP
	HnXAYNGeJ3Ol3fWYG3RiNPjrLJOw30KwetwhZOYoWe3VtkLsQYI/2n2d89+XGsNhqDaYfa
	S38cw8F3QLbqk/pDR3HuagxBGqZ4oB1jFFbhzfzWTMbVnq527E2s6bjSGjg2AtP39bRMvZ
	Mf6dPd2YiHfkN3GR6rsAhwQBDGA4xYE6bb0RmKKXx5uqpQUIVVEjpyZJtBBVnTNTvIaXIc
	+wzO+eNYrcQePdOgIN8tLRFA1ZT69BxDsbAA5wm98QuskdBBW8bi5TpX8QxXVA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Thu, 13 Jun 2024 15:07:30 +0200
Subject: [PATCH 1/2] mux: add mux_chip_resume() function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-mux-mmio-resume-support-v1-1-4525bf56024a@bootlin.com>
References: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
In-Reply-To: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com, 
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

The mux_chip_resume() function restores a mux_chip using the cached state
of each mux.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
 include/linux/mux/driver.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 78c0022697ec..0858cacae845 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -215,6 +215,35 @@ void mux_chip_free(struct mux_chip *mux_chip)
 }
 EXPORT_SYMBOL_GPL(mux_chip_free);
 
+/**
+ * mux_chip_resume() - restores the mux-chip state
+ * @mux_chip: The mux-chip to resume.
+ *
+ * Restores the mux-chip state.
+ *
+ * Return: Zero on success or a negative errno on error.
+ */
+int mux_chip_resume(struct mux_chip *mux_chip)
+{
+	int ret, i;
+
+	for (i = 0; i < mux_chip->controllers; ++i) {
+		struct mux_control *mux = &mux_chip->mux[i];
+
+		if (mux->cached_state == MUX_CACHE_UNKNOWN)
+			continue;
+
+		ret = mux_control_set(mux, mux->cached_state);
+		if (ret < 0) {
+			dev_err(&mux_chip->dev, "unable to restore state\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mux_chip_resume);
+
 static void devm_mux_chip_release(struct device *dev, void *res)
 {
 	struct mux_chip *mux_chip = *(struct mux_chip **)res;
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index 18824064f8c0..2a7e5ec5d540 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -88,6 +88,7 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
 int mux_chip_register(struct mux_chip *mux_chip);
 void mux_chip_unregister(struct mux_chip *mux_chip);
 void mux_chip_free(struct mux_chip *mux_chip);
+int mux_chip_resume(struct mux_chip *mux_chip);
 
 struct mux_chip *devm_mux_chip_alloc(struct device *dev,
 				     unsigned int controllers,

-- 
2.39.2


