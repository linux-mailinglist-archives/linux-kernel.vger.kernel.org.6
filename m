Return-Path: <linux-kernel+bounces-200183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3748FAC86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7821C20F87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2279E1420A9;
	Tue,  4 Jun 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzG99Qw5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211D1411CB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487555; cv=none; b=aFyVBphwLqkbjbTJDLAp3hLJO7CBMSxm2pxG/0vMRJWCWQ1gqijvxB5A2jBeA6SRbOZPjoti5RPyoiFB33ps3ed2J3O1S7DK9CQoz3XeTd5oX8c1JIMoYHU2JipvKXYOVxCaluV90gV0HUOpHii6TPCV9mVqfZvjWoQvcNM9n0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487555; c=relaxed/simple;
	bh=0miAYvpRkAOFP1cMzY2sUokznCRDxVUYD0uECgu4qUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sB/VZmm368SD7oDDQpqsNIjpG9SFpzFKF2dQ0SLg4n48as/S1/cBENdBNmjVbQf+hfLXeVncUzjtNFtQ8hYx63eJwS8hhwsfxxntFZQUeo7xypyIKe9OneYdkuQrG1Y8n4/Eh6Nw0GD0FMG1Vz+ZwpozFUndipS1fWLlXg/ALLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzG99Qw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21677C4AF0A;
	Tue,  4 Jun 2024 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717487555;
	bh=0miAYvpRkAOFP1cMzY2sUokznCRDxVUYD0uECgu4qUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzG99Qw5ODW1xQLiR9KG29aXCAfNttYdbB7UcPyeZbQXgW5vYcm8NJ5P4THgJvH51
	 9lMrayaJzfHdKb3ToFEsMtdbCJSaZwy3zX9QsB0OdoH8ZGCtkeW7LuCgyR4hhBIAxw
	 YH6GDZstjwzBBekAPGDGIXxvqDLgTjBUIRQ40llXpFKk9VxNJTjc+xKmh1llyGpGx4
	 900dvTibDCfD0Ps9P7MC3PDkoWBmaCwNeLcJBSTHWaj502R9hAsrrTNI8Y9jufk4LQ
	 mgU8nzwf5BVJIvOpFW5BSaEkmC0j2k6yeBAmqBekTrHFA01NFoKLhRZr8zKds1+0RH
	 fsnDSM0N1kamA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sEOy9-000000005QP-3637;
	Tue, 04 Jun 2024 09:52:33 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 2/4] soundwire: bus: drop unused driver name field
Date: Tue,  4 Jun 2024 09:52:11 +0200
Message-ID: <20240604075213.20815-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240604075213.20815-1-johan+linaro@kernel.org>
References: <20240604075213.20815-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The soundwire driver name field is not currently used by any driver (and
even appears to never have been used) so drop it.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soundwire/bus_type.c  | 9 ++-------
 include/linux/soundwire/sdw.h | 2 --
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 85fa5970d98a..3979be0f8b65 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -198,16 +198,11 @@ static void sdw_drv_shutdown(struct device *dev)
  */
 int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
 {
-	const char *name;
-
 	drv->driver.bus = &sdw_bus_type;
 
 	if (!drv->probe) {
-		name = drv->name;
-		if (!name)
-			name = drv->driver.name;
-
-		pr_err("driver %s didn't provide SDW probe routine\n", name);
+		pr_err("driver %s didn't provide SDW probe routine\n",
+				drv->driver.name);
 		return -EINVAL;
 	}
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 13e96d8b7423..5e133dfec8f2 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -704,8 +704,6 @@ struct sdw_master_device {
 	container_of(d, struct sdw_master_device, dev)
 
 struct sdw_driver {
-	const char *name;
-
 	int (*probe)(struct sdw_slave *sdw,
 			const struct sdw_device_id *id);
 	int (*remove)(struct sdw_slave *sdw);
-- 
2.44.1


