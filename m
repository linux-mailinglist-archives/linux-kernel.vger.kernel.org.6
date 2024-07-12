Return-Path: <linux-kernel+bounces-250747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B8792FC3F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A1E28169E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19EE171678;
	Fri, 12 Jul 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnDTtrTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7CC16F856
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793319; cv=none; b=DsEib82UgZhet42B/SHdR9jQnis/pFGi7/JS74BYRi+SoPYKHDdpW06bm952VWHf+VLOHHcarrQJGEonMI4Utv5U5g0Zxv2NwFFiInZ+/8q9oT1sPzRLmX6i2LOL8//aQl0bjGKWxakWd6qSuN2OzwcRDNvG2NHHCD+cU5E5Hsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793319; c=relaxed/simple;
	bh=d6yyoRJi3R7yLXIYWh6FukyOXX8Ng8iIFRGZyBMCrXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvuVTUmKJptpuDM8q6rJ7eHurxHLIj+t6z4f7rCTFC94NVXJFn+HbhhfOD5hYfZtoevlAgj8AKYJN6WIXEsGgoAxbrn4BaLgdGD8TpZksJLpPmC6jnM8J6SPqyea0YiJIa1G5yo7bIZvk61kVsJgieQSGfY7iglYRLJ/Mcw/i7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnDTtrTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F70C4AF0C;
	Fri, 12 Jul 2024 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720793318;
	bh=d6yyoRJi3R7yLXIYWh6FukyOXX8Ng8iIFRGZyBMCrXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HnDTtrTVCPk95Zr6JsIUWD3Cm2jUSrQTDVV7VSJSR+G6Y0J8PExnHlOhBGExpz+TP
	 acrxF8PmDPQ52yA50xcbEEKzYOtvaTtPuxPQM7d2f/4F19BoFpyUD4L8LWdNNJIYIH
	 0lIzNGb3PWHO8cVAm3isOou6Wo+1lvYkXgruQD/KWyM1u3Ei+aRLpix5yFv67564Ox
	 4913kyPvgObMRIriJfAML5rGzl+Vsjw5FJK7dLWi4olahVkKd6/rh8ZVRydVO3XbWz
	 BOfg1yvGjaXlmfxlx7SOzSkhoZflX0kKXyIhkQ1tLBDfF9eGps/QPB0hTtK34JjXa+
	 BnnkmwjwvBJeA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sSGww-000000006KH-2R4B;
	Fri, 12 Jul 2024 16:08:38 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 3/3] soundwire: bus: clean up probe warnings
Date: Fri, 12 Jul 2024 16:08:01 +0200
Message-ID: <20240712140801.24267-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240712140801.24267-1-johan+linaro@kernel.org>
References: <20240712140801.24267-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the probe warning messages by using a common succinct and
greppable format (e.g. without __func__ and with a space after ':').

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soundwire/bus_type.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 3979be0f8b65..3930b245008d 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -123,7 +123,7 @@ static int sdw_drv_probe(struct device *dev)
 	/* init the dynamic sysfs attributes we need */
 	ret = sdw_slave_sysfs_dpn_init(slave);
 	if (ret < 0)
-		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
+		dev_warn(dev, "failed to initialise sysfs: %d\n", ret);
 
 	/*
 	 * Check for valid clk_stop_timeout, use DisCo worst case value of
@@ -147,7 +147,7 @@ static int sdw_drv_probe(struct device *dev)
 	if (drv->ops && drv->ops->update_status) {
 		ret = drv->ops->update_status(slave, slave->status);
 		if (ret < 0)
-			dev_warn(dev, "%s: update_status failed with status %d\n", __func__, ret);
+			dev_warn(dev, "failed to update status at probe: %d\n", ret);
 	}
 
 	mutex_unlock(&slave->sdw_dev_lock);
-- 
2.44.2


