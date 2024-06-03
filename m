Return-Path: <linux-kernel+bounces-199113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D759D8D824C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92094288B30
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F92812BF3E;
	Mon,  3 Jun 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g55rAM0t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851A64F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417941; cv=none; b=q7pos18ZOgE1XwWxbRr5DWoPVeBBzLFJlqaMzGSbgwzOAMHYagaKne1zlCoSX5CgO8uS/PY0d244ppAM+KFv98bkdMHLA42GgaDIsqdi72+eavQwVCelI24H7Mig1CykYr1I4g00cT8qc0ZeoJkZsKXUlYX/XT5nmZJJhdwDukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417941; c=relaxed/simple;
	bh=Z6gzK40Tr5pMhZZtIC99f8/GM2gQz6amBeERw55iMko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgoeOrrHFrQTe2mk7ixq2rnaj+OzeDMi0TTpjG/INJCwaNBm5eNnQSEnF9WDH6SIxxtbTbOt/0huwMg4B2WbjDuY5Mwyf3jcdJY0qX9mbC7u7In9/j2Ox2FR/4L1OqLve5s6q1HX52v4P/CXSf9mRWB0iDhwGXiQOovUAaJOa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g55rAM0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F299C2BD10;
	Mon,  3 Jun 2024 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717417941;
	bh=Z6gzK40Tr5pMhZZtIC99f8/GM2gQz6amBeERw55iMko=;
	h=From:To:Cc:Subject:Date:From;
	b=g55rAM0txzQDEHqkYAlVenCl0JcFw7yKN3UQBi7w6P5ksgu8lF8AhRLjwKl2/5ywK
	 fHnLpr2OliQwr+DMWr1xPFs0asqAl7m4BC+jaOP02u8oqaLSS6AXO9839HSjuWl5W+
	 jHbHIp/UOJJRI0MzWNowB/uVfgXCRttePyDIS+/vQD56Hjxw2CvDw6oFs/CDf/3Hcb
	 B4yl1PYdkWS7Ysk/AL7mgHpnZpbRBTi/ZCRXZ+Jw8AuL/y7WCCqXkKZAQ261qvpviR
	 ei18VbdJvrAXNMcaj2QqkMCrPsLpDmLFEjZS7hEjjhIfFjBYkbHvgmnAbtzYO5SbHM
	 JBmnDLsWUT5xg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sE6rL-000000007wp-204Q;
	Mon, 03 Jun 2024 14:32:19 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] soundwire: bus: suppress probe deferral errors
Date: Mon,  3 Jun 2024 14:31:27 +0200
Message-ID: <20240603123127.30477-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dev_err_probe() to avoid logging errors on probe deferral:

	wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -517

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soundwire/bus_type.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index c32faace618f..8c3746f0d527 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -112,9 +112,9 @@ static int sdw_drv_probe(struct device *dev)
 		if (!name)
 			name = drv->driver.name;
 
-		dev_err(dev, "Probe of %s failed: %d\n", name, ret);
 		dev_pm_domain_detach(dev, false);
-		return ret;
+
+		return dev_err_probe(dev, ret, "Probe of %s failed\n", name);
 	}
 
 	mutex_lock(&slave->sdw_dev_lock);
-- 
2.44.1


