Return-Path: <linux-kernel+bounces-250748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6092FC3E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9A41C21BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1674171675;
	Fri, 12 Jul 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK3m/Myd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76815B13D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793319; cv=none; b=aBBtLZQT1anih2r+B+ljQN6dj3cAymYYwPDMRDGujL4vTTJywMIfOIacRTWzdWrBBsy54Fi1J0fpsFGzFZVVaWPueGPSRJ5qGnWCjYy9MyhEAQOfd9rGHN4f0pBl4htIJhq3XzZARZE140gVpv7/VYdLXRohMwIt57YXbq1uvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793319; c=relaxed/simple;
	bh=1tdVOay90qKoOBtZsqzjMTRYxUTqdTqLiJ2eTqVl8pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzdOY4jUGogkw689Nn4c6lhRJDVVULX2awnMUsA07e49ErvTnZvBEWCB4H7Ln9Kt9kLYwNGoAhKO9wOMBhIKl3akQYZ+MN8FNbO07H1bc8NhanA0kQV2oLplYMFKAB3IJgBpwY3oyfMgJM71XJAby36tOKlTMdMUVGByO34jyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK3m/Myd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1950C32786;
	Fri, 12 Jul 2024 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720793318;
	bh=1tdVOay90qKoOBtZsqzjMTRYxUTqdTqLiJ2eTqVl8pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GK3m/MydnKsOO1mz/qpTsUU9Nr0bk06clrR4al/JiC6cqzmPsBG5Hg/HbrJB6V5p/
	 VfO1OeNQUzdM+OAukBXhVBcVRSp5SB+3n5uLIFzmDi3kBmFiZEqg9NVVvYSbC5VVoc
	 eoyXCcg3bLYTzGi26SRde1JghliDd10PABRONJVZC2NJ9XUN2ijKT90rpaFnI7/sK5
	 jtgGc+IwwfRZqgutxUkGBICwFtSEUcLruWvBq6auro1SmcJ7J3HlBcVUK+8MKfgMhb
	 /dMLabtmPad37/NGQduHsN/yIc9xDE/Cr8JDp731IT3AI/lwsZXg+aPNrmSpKGjpV1
	 36B76Ub7UWTQg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sSGww-000000006KD-1grC;
	Fri, 12 Jul 2024 16:08:38 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 1/3] soundwire: bus: suppress probe deferral errors
Date: Fri, 12 Jul 2024 16:07:59 +0200
Message-ID: <20240712140801.24267-2-johan+linaro@kernel.org>
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

Soundwire driver probe errors are currently being logged both by the bus
code and driver core:

	wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -12
	wsa884x-codec sdw:4:0:0217:0204:00:0: probe with driver wsa884x-codec failed with error -12

Drop the redundant bus error message, which is also incorrectly being
logged on probe deferral:

	wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -517

Note that no soundwire driver uses the driver struct name field, which
will be removed by a follow-on change.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soundwire/bus_type.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index c32faace618f..85fa5970d98a 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -83,7 +83,6 @@ static int sdw_drv_probe(struct device *dev)
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
 	const struct sdw_device_id *id;
-	const char *name;
 	int ret;
 
 	/*
@@ -108,11 +107,6 @@ static int sdw_drv_probe(struct device *dev)
 
 	ret = drv->probe(slave, id);
 	if (ret) {
-		name = drv->name;
-		if (!name)
-			name = drv->driver.name;
-
-		dev_err(dev, "Probe of %s failed: %d\n", name, ret);
 		dev_pm_domain_detach(dev, false);
 		return ret;
 	}
-- 
2.44.2


