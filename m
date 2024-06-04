Return-Path: <linux-kernel+bounces-200182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD118FAC87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A437CB2157E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092051420A0;
	Tue,  4 Jun 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+XYvvT5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6981411CA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487555; cv=none; b=WpgBq3iey6TrsnOO1bYUJTCPqK0A8qIYL2loCqW3a0krxnxN7YnYdgN3ILDHfiXcQq7TjoA9/KkSJclRfc4Gjy7l++4MYg5muHZpQZvHpQgCS7XKnFhG2+5HqfgekF5qN3j4KBFkFP8J2od/XBcvOJv+ftNNK0cpohiV8GyCjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487555; c=relaxed/simple;
	bh=hi7PWtwphuTNKYoU1XS9MRhf81ClVkiQ1xJd4IkXUsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2fuReHtgAD2ByQy97DoWBS8D6F5XE52pKU0GrX8q8qWI8a2e2I5s5A0HEci913MCNJMK1/3xh1d93t0FMvGYLb3WaUgyIwfcg1T29Kcu5iGpW4ncSUWJCFjlfs40PnS6/svchnESeKIJuPj/m50+biLE1jfnIDvIQ2ZqllnP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+XYvvT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C508C4AF08;
	Tue,  4 Jun 2024 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717487555;
	bh=hi7PWtwphuTNKYoU1XS9MRhf81ClVkiQ1xJd4IkXUsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+XYvvT5XpJaP1NvyduzcIpGyiIREifzDW8WqTsMx0GDH02HpxMjUk3CSQeKZdFKd
	 t6M3E9lDRO2KpOhZnl5YykJXmipfY+cUhmbRUZ3ODgSdU+KlyUJWU5cEsGSUQh3x1t
	 9f2dZyUNLuVAi51/X6yolNV9BNrJwC3filbeBTn3uZqeJQe4I/W2pEwB1inZIc6CDK
	 bR6VclVvYeys2vfTgdnwxf+4lbhXORPWyzBQY1rUvy4G8pUeYnSG8JbjFxkpMg6Cwh
	 fr4htXNh5ciBZybh02rmJB23kcbTzmgQkanCtTOJTyKt4pqlSvvLN9w7IInp2WNuWJ
	 x1LPpQnfVpmYQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sEOy9-000000005QT-3oXW;
	Tue, 04 Jun 2024 09:52:33 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 4/4] soundwire: bus: drop redundant probe debug message
Date: Tue,  4 Jun 2024 09:52:13 +0200
Message-ID: <20240604075213.20815-5-johan+linaro@kernel.org>
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

Drop the redundant probe debug message which is already provided by
driver core. Whether probe succeeded can also be determined through
sysfs.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soundwire/bus_type.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 43e732ca73c0..5b9b129badff 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -152,8 +152,6 @@ static int sdw_drv_probe(struct device *dev)
 
 	mutex_unlock(&slave->sdw_dev_lock);
 
-	dev_dbg(dev, "probe complete\n");
-
 	return 0;
 }
 
-- 
2.44.1


