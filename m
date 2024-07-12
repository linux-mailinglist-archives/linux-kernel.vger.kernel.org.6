Return-Path: <linux-kernel+bounces-250749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8097892FC40
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B28DB21ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1994171677;
	Fri, 12 Jul 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDHcw8kb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80D171075
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793319; cv=none; b=qVjSjSmiMqdb+sKPOu35RJBK1Bte9or/P8Q7OQTbDvrp8cXZRFW1QSd1rMe7LQjYp0FUyt0km9LFBk0FlaDHh6O+oMVYOpHBv6h/NfqjBMunri+m0m/6bhojRQw15E8vCMz3vIA7Oy/fqx+N8ZyRs+EqQKUBhUBUcxwLbUyNZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793319; c=relaxed/simple;
	bh=b+g0wkurwgHAuPLw7DhPBo/ti/dMGUAaoXVnZGKEE8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkxVCzpgcTgMaibKj5ihZNqw9rdgDGKem0CfUwDqe+/jRVpTifcHRo2DOTYDLd3Dl+UknZ+f/cO+l7Wo6h1aGYseU96NuxseX/sbriqZmidTRpQ7EcTqR87fPiBgd/c2jSjBlBreH/6jcPrOyGoOfuGhj/JFkNrE5AGDLYNOAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDHcw8kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1904C32782;
	Fri, 12 Jul 2024 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720793318;
	bh=b+g0wkurwgHAuPLw7DhPBo/ti/dMGUAaoXVnZGKEE8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDHcw8kbCQHMIjLRnqnjXcU7HVZ0TKlGr5Bi7s5XAO8/IOO+lLNTfrv6X3MjU9pHg
	 q3Zgj0sP590L1hPn6uo9KzHt9vE2ToiAiM/s4a+KlCF78+kx2kCw0+iM52A48JdEdI
	 VcnJkmcCg20taxvNyzfdSwoXe0J37rN9My2cR5ENAIB3LFNL12zwQslIvEulpTf7I5
	 0BuC0NupQoW9Lt9SCqqlPiGPEOyqYn4qer7U1sZmcHKs/N9+gLENLfJTkY82mw0hz2
	 ATeNoA7WtgmOPnmhj75ijOEERE9e8X34vjy1/yaCpBJxa5bt9og8EPV6jdq7/1tCS0
	 bbCOaS55eu75Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sSGww-000000006KF-244e;
	Fri, 12 Jul 2024 16:08:38 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 2/3] soundwire: bus: drop unused driver name field
Date: Fri, 12 Jul 2024 16:08:00 +0200
Message-ID: <20240712140801.24267-3-johan+linaro@kernel.org>
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
2.44.2


