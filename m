Return-Path: <linux-kernel+bounces-212320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E03B905E74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1B71F25C05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3409912DD8F;
	Wed, 12 Jun 2024 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TyGaBUem"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC712D1ED
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231097; cv=none; b=nmNSwSP7FYj3WrwRbN8XJ7ufMuDUFX9SbmWC2fHgDTuYxvPqzL4482tO6C4G93mmzjvNZT+576uowz/6pgLk+z/0+k7zW5hlwAZOiW9+e0TAHrPhAnW9UfcpUi/apeGLbgqVT/S6P+gprNudDBf3PQZ39RmK/HWpzPDkhlzKmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231097; c=relaxed/simple;
	bh=NRArsyGf8TAn/F8FIKbUDBSYg38BW5LqqhcOU6lhGSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClyFFLF6NmB5PopTc77J1txP9Vk5th0wbQ6lEPMzJQeGfdE9nFBxApJEoh1bV9IbxOJ6fYTdzDtAZRQOUplGBuoudEAqMb60Zui902kWTv7CkKTBKPNeEz8W8y3M1fNp2rJkzFWiZiWomj8HV92GczxcpWTGCBhW4COls1GHogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TyGaBUem; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f4a5344ec7so2679185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718231095; x=1718835895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moW+vuchPBzwhuLa9D90CyqT2Qzy5nveIbqumh1IepQ=;
        b=TyGaBUemiF8mB0SmycQkbC7KPJmVJgGqAxux2xx7yKhZLCDlYcMYxt9i9AkVDP6VFg
         4iUtGR+uVUWam8l9KeERsrF3HD/XXcQ+ptI5BpdVS7NcFnb4LLGso3Ph8j3gcvA4Imlc
         2467oEyWhfTrEBZ5vu9gALeyO+D8Y56eN1sLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231095; x=1718835895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moW+vuchPBzwhuLa9D90CyqT2Qzy5nveIbqumh1IepQ=;
        b=d/bpq23BLinpSbChzGV4sMA8fwCmWOWxs7S4qS9Q3Sxfl7aHCGlG4uVHMuVXFZeUSF
         wxNuxsd1qeVgUyO6i7PY9zUAoZSGj+xTmrrjLTWv++mFIQB7FyMG0qE7jbzd0uq2HbDK
         q8XP5eUhd8fLBxkVjXFvhIvWXGiT06uzWKf2mk61HdMFL49kbqWeSEdpMmo0yF1qzCbj
         LVwXJVfoLpVoVTGQHUFTanx7lTWUOy951ZMBVswzLxSP1GkDwOVBljX7Pmal7tNsWzEq
         N8jfkD3sd3/7crMd740hqMH4NDnJn+g/VHll/DH2G46QrrzGNqyd5AdgJQnW16UtHCCs
         p94A==
X-Forwarded-Encrypted: i=1; AJvYcCXmsPBJhBdrUuWwv9o+4U+bH6gbP+wEgU1HymR1XCyuDfVmCAQ4Oy1GuFKFdxYmCt1cUdSgaf3cbXkSUmbe0j5OUnDxIXGYbK2jSDap
X-Gm-Message-State: AOJu0Yw57NAtm4Ee+753f7/QAjdTXh7BNxJzm/w7JpaLc1xo3Z2HNnZN
	8+7MXvtHwzWwZB9/21Az1nZmw854wkhs0/eA2NWPCVjEDsNQwqziXdZnLaHSBQ==
X-Google-Smtp-Source: AGHT+IHBAtSsNRsCiipiSSmdPtxdIvkO4DzXuXDcDLjyV0KBNSghL6hedDrLySr08oXr7dCUGUp9XA==
X-Received: by 2002:a17:902:fc46:b0:1f2:fee2:82ed with SMTP id d9443c01a7336-1f84e425a39mr11905935ad.30.1718231095482;
        Wed, 12 Jun 2024 15:24:55 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2816:6a42:9074:18cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f30acda9sm87914105ad.198.2024.06.12.15.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 15:24:54 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Steven Price <steven.price@arm.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] drm/sprd: Call drm_atomic_helper_shutdown() at remove time
Date: Wed, 12 Jun 2024 15:23:45 -0700
Message-ID: <20240612152336.v2.5.I7a2dd349cb52bae53280d0a49e22cc27b923274b@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240612222435.3188234-1-dianders@chromium.org>
References: <20240612222435.3188234-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on grepping through the source code, this driver appears to be
missing a call to drm_atomic_helper_shutdown() at remove time. Let's
add it.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS driver remove comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

While at it, let's also fix it so that if the driver's bind fails or
if a driver gets unbound that the drvdata gets set to NULL. This will
make sure we can't get confused during a later shutdown().

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

While making this patch, I noticed that the bind() function of this
driver is using "devm". That's probably a bug. As per kernel docs [1]
"the lifetime of the aggregate driver does not align with any of the
underlying struct device instances. Therefore devm cannot be used and
all resources acquired or allocated in this callback must be
explicitly released in the unbind callback". Fixing that is outside
the scope of this commit.

[1] https://docs.kernel.org/driver-api/component.html

(no changes since v1)

 drivers/gpu/drm/sprd/sprd_drm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index a74cd0caf645..d4453430dd1f 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -114,6 +114,7 @@ static int sprd_drm_bind(struct device *dev)
 	drm_kms_helper_poll_fini(drm);
 err_unbind_all:
 	component_unbind_all(drm->dev, drm);
+	platform_set_drvdata(pdev, NULL);
 	return ret;
 }
 
@@ -122,10 +123,11 @@ static void sprd_drm_unbind(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 
 	drm_dev_unregister(drm);
-
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
+	dev_set_drvdata(dev, NULL);
 }
 
 static const struct component_master_ops drm_component_ops = {
-- 
2.45.2.505.gda0bf45e8d-goog


