Return-Path: <linux-kernel+bounces-200184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F49A8FAC8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6930B21B43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524A71420D7;
	Tue,  4 Jun 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6kfXcCM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908291411E8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487555; cv=none; b=W8UKEy7TjRbVwnnbQYMXe6RdVTTNGtnzNMQehK6KZpr1/HLpWX/QDbe41mpr1u0TjQY422nSwvuC4tozKHE6IHY/KsaUfnl9CYptSL/X5tWbowzr8pp9A4m0biYme4m2n1H6GH/SVh6uv9kcKN8N6X8NEbF4c3aGg2PsS4/FKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487555; c=relaxed/simple;
	bh=4dNTR4z2BJ3pfaXEO6tM9yIxe4LDIns4WgIcbTF2vYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvTBFw+Mr0sR1w7z4LHbfqaUXt/5AnH6WQNoRuUYm4W+Q3zhV/LoOkxsmEWdtmv04Mh5fAP0uS8RFNwzgVvN7M8Kq9OUtoqpUpwfl2oIJqXVUroLd6nUlTsyVWbvH9EXoNFl0OzO+PbSOorr6Ou3cpoqrHeZa3orcBCzsRauyhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6kfXcCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19789C32782;
	Tue,  4 Jun 2024 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717487555;
	bh=4dNTR4z2BJ3pfaXEO6tM9yIxe4LDIns4WgIcbTF2vYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6kfXcCMGKpSuvA2cir2lb03te8T5XAKFF4r3vqHWbHIEqBpJxf5BSJ470hKfvJhe
	 YVcZWSYHuMGm2EjrDlZSTp+sXliB8A3/yOWOiIkTNO93DTMPiZrEQJ99e3tayCENrQ
	 UIbshji7em3n8Dt1ioeo6Vu3gIKIJFd5EfvG8TyTc/XXk4x8AJpyFrgTDP4oftZ5My
	 NuFrKIfD1sf6YV/Alor0ci1o1OjAMElPOw12S8KhdtkDJR2YZmBelK4V/LHzw0oios
	 Rhptz7oVD8CMi3aRBVWCJqcTIkAkgpU7Kl1qkOHyCgPc2BCn7iHJV9teokjCBEASx2
	 nF1PUuyHAiT4A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sEOy9-000000005QN-2ixN;
	Tue, 04 Jun 2024 09:52:33 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 1/4] soundwire: bus: suppress probe deferral errors
Date: Tue,  4 Jun 2024 09:52:10 +0200
Message-ID: <20240604075213.20815-2-johan+linaro@kernel.org>
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
2.44.1


