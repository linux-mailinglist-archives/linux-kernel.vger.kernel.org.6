Return-Path: <linux-kernel+bounces-339918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC37986C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AED1C2229C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B82187851;
	Thu, 26 Sep 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="nS7Zqod2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LUHlaxKZ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E21865F2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727330169; cv=none; b=NoB5AnXw3W7ePbKbLZrtOuUOnnkj5t9VgCvmzQAmBF4UACdX6DUgRZKlv13UFJu2fHQ3nalOnwmKRVl/68BZBIrE2vuvdTj5pWa3G5B/hHYElFX9HDZmL3nsw0OfZkxTzrHIe9H/gQmmvk0/YInfLn2pIlviCZrg8ZH24e8pJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727330169; c=relaxed/simple;
	bh=kDU8VTh+QpT4uXGBVB1w6OZFbPmxBcdAWmuCJKNrgd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WnuQ6y+DcZSU7g4V0U0snzy8QEJUUSwQ1SL0AKg25V4I0v7rRdHp9Az4ZCmJEK0VCeh0HLaFCRRdoCu8IqI1ukM3T8tse4IabevILEAOnQvZxvglXYbPjA55+gPxS2ogrRYHan6e0IdN1OKCUK+j49WEwx0R9dsHoBY5rukNn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=nS7Zqod2; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LUHlaxKZ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1727330166; x=1758866166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dcOUiEE5g3NV+cMDqNVSOiaDkO9NmLB5/4wRl4dB+Xg=;
  b=nS7Zqod2aC0M5qC+4H9DXm0wJmB05htNjUWhpEi3dAPV/CkIKPjqGSkH
   jDTGLZGQH0XeJueFcfako+bCHiACEBbPkbkmVQBX3Qv0skUNTNG/TkzQO
   n9U01q/KvfT1ld67IwR7cLscAUxfoyn/+D3pf3+mIxFXfcfDdodRBmavg
   ru6Jm7oYbBaSHnOru2flkk9yBNVcX8RX0vaxDEd/wtpfBXlPHhm7RPHyL
   92EjMIxyC8wYpt7PstzvgLbLlmLFihqWgjONH87rBszTG4P4ISmXhUlBM
   RE4+ndg0JBee3NNEMILlb18jcrEqG6CR8Gmp+fgmmmL+kYSCx/oO5OTZU
   w==;
X-CSE-ConnectionGUID: K9ZMYA8PQTOcSOikJnf/gQ==
X-CSE-MsgGUID: TbSP+5B2T/ixF8n4hw/wdQ==
X-IronPort-AV: E=Sophos;i="6.10,259,1719871200"; 
   d="scan'208";a="39129814"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Sep 2024 07:55:58 +0200
X-CheckPoint: {66F4F76E-8-D1F0B501-D0091591}
X-MAIL-CPID: 4342E026DBA5EC3A08DE4B8B2B6CDA52_0
X-Control-Analysis: str=0001.0A682F27.66F4F76E.0068,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4C13160A3D;
	Thu, 26 Sep 2024 07:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1727330154; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=dcOUiEE5g3NV+cMDqNVSOiaDkO9NmLB5/4wRl4dB+Xg=;
	b=LUHlaxKZ5SuWy4RwNB2Z0v21/zukRiQGpioZeB0HPEdnHcphzxMGgKFZRlJNN2mNX/tmgR
	BDJjkGjUMJFQ3weQ7YS3wK/YiyTuGBwQrwFGhbZN0fHLQYh4XNi4hVcdA9rdVmJzcd3zFF
	uMD4nuYnBzbkr+nj3dtNPtglJf5KcSRtotD0hPI29ghh9LVixu3Rc89C61SyM5NnJhqsl5
	QxmGwMJ3aNpVpM7fNgydBo1WRlRgaTPHOQHqlv3w3peIw/M9nl+ylczbG3IBwZ8Qp7ebUu
	qg1ilEUhKznPQ7MV/vX4E00k5ugloIwTPw4oAEH60jIVML2YYXyTUGar2Vfrlw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm: fsl-dcu: Use dev_err_probe
Date: Thu, 26 Sep 2024 07:55:50 +0200
Message-Id: <20240926055552.1632448-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

fsl_dcu_drm_modeset_init can return -EPROBE_DEFER, so use dev_err_probe
to remove an invalid error message and add it to deferral description.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* None

 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index ab6c0c6cd0e2e..dd820f19482ad 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -103,10 +103,8 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 	int ret;
 
 	ret = fsl_dcu_drm_modeset_init(fsl_dev);
-	if (ret < 0) {
-		dev_err(dev->dev, "failed to initialize mode setting\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev->dev, ret, "failed to initialize mode setting\n");
 
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret < 0) {
-- 
2.34.1


