Return-Path: <linux-kernel+bounces-325553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA3975B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6361C21F99
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EB51B9B45;
	Wed, 11 Sep 2024 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAmHSAbA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0F61B9B3C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084895; cv=none; b=tfRdMYgP5znDax0eN+DMhX0pRIWjHTEjuhPxqkc1sI5Roe2wudww/vZym2GqzVK4HNewtFclWVRDkYjQV0pjlOObmFrqbqolEMYrYCpsK+hNzjmfAHfjUJdnykZJ2+000CaoBPQDPCjI2fjm4HlpXY36fKf/vB9EFvc+PkQ3mRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084895; c=relaxed/simple;
	bh=8gQJxasyXdeCaQeqL0TIhYng6/UlVBJxcdQeteEiWis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmSB+WEzgkBjQqZOmtHHLvT30H4OemBzu99eFJwCSKvKKjq49ZzZsnJj2PCblSWdN4c+/wkrLqJxlmYRQYHgyyCAkrtqPSYchiuaYXLlXPa/pnI35v0jMElFLEXB4BssGC9aPqRqZLS57fdWAWJo/Wm0BVVGTMfoT+c9Ou2VzMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAmHSAbA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726084893; x=1757620893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8gQJxasyXdeCaQeqL0TIhYng6/UlVBJxcdQeteEiWis=;
  b=hAmHSAbALLVF+Nob0meVQlZ3O/KZNeupVjBPRpNADwHt2y7PXVzsRzPz
   K17xexAxF2hLtl04xo2/P+EaaLei+5dYRUmgkpdms9wj9qkbhlEYBcvQe
   B30tjz1QSNPDFtQw8UDxaXsEa6NoE4E6WiKB8V8NO2aZ6BhPLB9SAG3VV
   tqh2d8OtVDmQgWEidqyjFKzSPverMog8hRF5WU5nW/xyQ/Y331oaeuOB2
   4slnvzO2CcOeEgB3KgVRXzcWVg2zPLgCLQl1bBA3CybolUCpVlrmRvQe3
   jPgF2hp8MSTvCDDo1ZnOkUS8xXkmFl2cDhmBE3eh14QWWyzoo/DhLJOfb
   g==;
X-CSE-ConnectionGUID: LvVQTjzqTnSpv7XT/XKbog==
X-CSE-MsgGUID: 0Old3Hg+SP2Cjp2m5EAgcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27827551"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="27827551"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 13:01:30 -0700
X-CSE-ConnectionGUID: takfm/xlTKe0vdK+sMGcmg==
X-CSE-MsgGUID: lMDLr+vvRUOyKVrQaAC6Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="71857567"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 11 Sep 2024 13:01:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 800A7170; Wed, 11 Sep 2024 23:01:26 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm/panel: sony-acx565akm: Use %*ph to print small buffer
Date: Wed, 11 Sep 2024 23:01:25 +0300
Message-ID: <20240911200125.2886384-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use %*ph format to print small buffer as hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/panel/panel-sony-acx565akm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sony-acx565akm.c b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
index 217f03569494..d437f5c84f5f 100644
--- a/drivers/gpu/drm/panel/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
@@ -562,8 +562,7 @@ static int acx565akm_detect(struct acx565akm_panel *lcd)
 		lcd->enabled ? "enabled" : "disabled ", status);
 
 	acx565akm_read(lcd, MIPI_DCS_GET_DISPLAY_ID, lcd->display_id, 3);
-	dev_dbg(&lcd->spi->dev, "MIPI display ID: %02x%02x%02x\n",
-		lcd->display_id[0], lcd->display_id[1], lcd->display_id[2]);
+	dev_dbg(&lcd->spi->dev, "MIPI display ID: %3phN\n", lcd->display_id);
 
 	switch (lcd->display_id[0]) {
 	case 0x10:
-- 
2.43.0.rc1.1336.g36b5255a03ac


