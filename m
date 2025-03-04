Return-Path: <linux-kernel+bounces-545605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 092F7A4EF29
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536CC16B264
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C06264FBD;
	Tue,  4 Mar 2025 21:08:47 +0000 (UTC)
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A441A203704
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122527; cv=none; b=LwRBtW/38rwM7w+29CFKbNsbwtFuXp7pqcv7fPUQ00x4rleHDpZlGTyyITuphyohyU5me+zBiMTAwepdAJXa/28svKc/NQIdtrpziUgv0Nv4CBvureeVXvfyxFonEnUPQgvdB7vKF992PZzPoKiut5l3OH97PJBTPuVbP+0+xrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122527; c=relaxed/simple;
	bh=ULr4MECwJ/XrhUKr7X65hWSM7QCs171QCPElAAKAZ9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GpZGKvR4pBkHSbqQ/bmibZjO+5UTf5AyWNWvmxtZGJBwwaSVnwV/lFY2S/zJOUVTnTAr5k5vDJbGVjieavaOP0BFjp7p0O40dlsIZQFJgqow8F71K95Y6sSHoQSWwni/4l/O/+OdSfKlhd5P4UMawwBEi0JEEJqtcjJjAww8SBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.0.1] (dynamic-2a02-3102-8418-1620-0000-0000-0000-04cc.310.pool.telefonica.de [IPv6:2a02:3102:8418:1620::4cc])
	by rudorff.com (Postfix) with ESMTPSA id 06AF5406E5;
	Tue,  4 Mar 2025 22:08:40 +0100 (CET)
From: "chr[]" <chris@rudorff.com>
Date: Tue, 04 Mar 2025 22:08:19 +0100
Subject: [PATCH] drm/nouveau: fix hibernate on disabled GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-nouveau-fix-hibernate-v1-1-ee4433546030@rudorff.com>
X-B4-Tracking: v=1; b=H4sIAMJrx2cC/x2MSQqAMAwAvyI5G6ixrl8RD61GzaVKa0UQ/27xO
 DAzDwT2wgH67AHPlwTZXYIiz2DajFsZZU4MpKhSpdLo9nixibjIjZtY9s6cjKS7lupZU2MtpPb
 wnIT/O4zv+wFYq6LKZwAAAA==
X-Change-ID: 20250304-nouveau-fix-hibernate-249826d427bb
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Hibernate bricks the machine if a discrete GPU was disabled via

echo IGD > /sys/kernel/debug/vgaswitcheroo/switch

The freeze and thaw handler lacks checking the GPU power state,
as suspend and resume do.

This patch add the checks and fix this issue.

Signed-off-by: chr[] <chris@rudorff.com>
---
I got an old MacBook having a defective nvidia GPU

So I put this in the initrd scripts to turn it off asap:

mount -t debugfs none /sys/kernel/debug
echo IGD > /sys/kernel/debug/vgaswitcheroo/switch

which powers down the nouveau.

Suspend and resume works,
but hibernate locks up the machine.

The handlers are not checking the GPU state.

Signed-off-by:
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
chr[] <chris@rudorff.com>


