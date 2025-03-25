Return-Path: <linux-kernel+bounces-575373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A68A70121
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A96C7A5D28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E32265631;
	Tue, 25 Mar 2025 12:54:04 +0000 (UTC)
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B426562D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907243; cv=none; b=S5WZSogWa8VU4rBESheBQPG4xUq2BMIMsN6F4QowNDC0HH+ig37kz5iKNAJeJm1XS89YdHnBVxoqx++g9NOQXW4YFTimKVEuBH8JJskCBQ9P81hdkUNA+f6NEjbhmqvhzfT4iPBFIH8cGfDYtMz/yIrPD5KbTTMbg0smgbtCDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907243; c=relaxed/simple;
	bh=ZpCiPmapm0mpAWY6CbQBtSI41bLQoEKJWma6xyMNXQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KPD5I9hhipZdPXVk/hikItB0dPiNCyWPp4r2cMblu6MzuolvHZdUeTFxTkh0CDPHe5qTXMoO7Zs8ZxyTKmgpNfd25zZ1TiynV3L15DERF1h3RctNzJ1s3O37YeqzIMNxO1Sj6Ft2J9IOPtXVdXu66bPEG5zDo52EBj10Wnas4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.0.1] (dynamic-2a02-3102-8418-1620-0000-0000-0000-04cc.310.pool.telefonica.de [IPv6:2a02:3102:8418:1620::4cc])
	by rudorff.com (Postfix) with ESMTPSA id DA59C406DA;
	Tue, 25 Mar 2025 13:45:50 +0100 (CET)
From: Christoph Rudorff <chris@rudorff.com>
Date: Tue, 25 Mar 2025 13:44:36 +0100
Subject: [PATCH v2] drm/nouveau: fix hibernate on disabled GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-nouveau-fix-hibernate-v2-1-2bd5c13fb953@rudorff.com>
X-B4-Tracking: v=1; b=H4sIADOl4mcC/4WNTQ6CMBCFr0Jm7ZhSCv6svIdhUWCws7A1U9poC
 He3cgGX38t731shkjBFuFYrCGWOHHwBfahgdNY/CHkqDFrpVjXKoA8pk0048xsdDyTeLoTaXM6
 6m4w+DQOU7UuoFHbvvS/sOC5BPvtNrn/pP2OusUYiY5qmNV0p3iRNQeb5OIYn9Nu2fQFtPSRSv
 AAAAA==
X-Change-ID: 20250304-nouveau-fix-hibernate-249826d427bb
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Christoph Rudorff <chris@rudorff.com>
X-Mailer: b4 0.14.2

Hibernate bricks the machine if a discrete GPU was disabled via

echo IGD > /sys/kernel/debug/vgaswitcheroo/switch

The freeze and thaw handler lacks checking the GPU power state,
as suspend and resume do.

This patch add the checks and fix this issue.

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
---
I got an old MacBook having a defective nvidia GPU

So I put this in the initrd scripts to turn it off asap:

mount -t debugfs none /sys/kernel/debug
echo IGD > /sys/kernel/debug/vgaswitcheroo/switch

which powers down the nouveau.

Suspend and resume works,
but hibernate locks up the machine.

The handlers are not checking the GPU state.

This is a good candidate for backport.
This patch applies down to 6.12.y
---
Changes in v2:
- EDITME: use my real name, my nick raised bugs
- Link to v1: https://lore.kernel.org/r/20250304-nouveau-fix-hibernate-v1-1-ee4433546030@rudorff.com
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5664c4c71faf1ced30f38d9874244db80d58194a..0958d1b940c2533bfadc29e098045db6f0170c79 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1079,6 +1079,10 @@ nouveau_pmops_freeze(struct device *dev)
 {
 	struct nouveau_drm *drm = dev_get_drvdata(dev);
 
+	if (drm->dev->switch_power_state == DRM_SWITCH_POWER_OFF ||
+	    drm->dev->switch_power_state == DRM_SWITCH_POWER_DYNAMIC_OFF)
+		return 0;
+
 	return nouveau_do_suspend(drm, false);
 }
 
@@ -1087,6 +1091,10 @@ nouveau_pmops_thaw(struct device *dev)
 {
 	struct nouveau_drm *drm = dev_get_drvdata(dev);
 
+	if (drm->dev->switch_power_state == DRM_SWITCH_POWER_OFF ||
+	    drm->dev->switch_power_state == DRM_SWITCH_POWER_DYNAMIC_OFF)
+		return 0;
+
 	return nouveau_do_resume(drm, false);
 }
 

---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250304-nouveau-fix-hibernate-249826d427bb

Best regards,
-- 
Christoph Rudorff <chris@rudorff.com>


