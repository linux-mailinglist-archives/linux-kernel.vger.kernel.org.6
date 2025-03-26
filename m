Return-Path: <linux-kernel+bounces-577076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A63A7180D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B8F3B81AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024A11A2381;
	Wed, 26 Mar 2025 14:03:28 +0000 (UTC)
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7061E1DE8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997807; cv=none; b=fwa87fBIz4in3HxeSgswrOt+7FQa8EVSDtB48SUYT6zldXVEr3uwmZPaSCo9MSCcrHtjggvUhoaqtthJPle2Oeh5Kox3zsCm9/sdoUttVmAKun0byLtXv/eY5Ck9ZZDhKk7aEivc5vPgBQrZVdnoau3DqnxpSSeco/ERLt+YHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997807; c=relaxed/simple;
	bh=zXYAwsu8jRZm0KhpIS84+TXFUfhPlTHAYfS6K4f4U7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TXEF+rQrjy6ufqEfqVnvZZtZcLpjBp/kDIOjvtWVMuKbmdSN828ONfsNihQDAu1TZB+nO+opgrGmp30k1kWEHj7/bfjfD0oLL1YwHcVsPqSGeBUvDgs6n/AC28HGLTkJTG1T5BNsBOKRmHXdIi6CrE2H/09SRbeXEInEA+9/o3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.0.1] (dynamic-2a02-3102-8418-1620-0000-0000-0000-04cc.310.pool.telefonica.de [IPv6:2a02:3102:8418:1620::4cc])
	by rudorff.com (Postfix) with ESMTPSA id 9C887401B2;
	Wed, 26 Mar 2025 15:03:16 +0100 (CET)
From: Christoph Rudorff <chris@rudorff.com>
Date: Wed, 26 Mar 2025 15:02:48 +0100
Subject: [PATCH BACKPORT v3] drm/nouveau: fix hibernate on disabled GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-nouveau-fix-hibernate-v3-1-893271fdcb59@rudorff.com>
X-B4-Tracking: v=1; b=H4sIAAcJ5GcC/4XNvQ7CIBQF4FdpmMWUC1Tr5M/ooDFuxqGUW8tgM
 dASTdN3lzDpYBxPzrnfHYlHZ9CTVTYSh8F4Y7sY+CwjdVt1N6RGx0wgB5nzXNDODgGrgTbmSVu
 j0HVVjxREuYRCC1goReLtw2EcJPdCtpvd/ng4nck1Nq3xvXWv9DCw1P+xA6OMIgrBuRRFHK7do
 K1rmnlt78kM8OGA/OVAdEBpWTPeqFLyb2eapjdI59LMDgEAAA==
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

This is a backport and applies to v6.6 and below.

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
This patch applies to v6.6 and below
---
Changes in v3:
- Backport for v6.6 and below
- Link to v2: https://lore.kernel.org/r/20250325-nouveau-fix-hibernate-v2-1-2bd5c13fb953@rudorff.com

Changes in v2:
- EDITME: use my real name, my nick raised bugs
- Link to v1: https://lore.kernel.org/r/20250304-nouveau-fix-hibernate-v1-1-ee4433546030@rudorff.com
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index ac15a662e06042e2c133da9c17fcd53000a98650..a05151b557dac6860e07fe7147aa81b7b15e6f4b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1026,6 +1026,11 @@ nouveau_pmops_freeze(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+
+	if (drm_dev->switch_power_state == DRM_SWITCH_POWER_OFF ||
+	    drm_dev->switch_power_state == DRM_SWITCH_POWER_DYNAMIC_OFF)
+		return 0;
+
 	return nouveau_do_suspend(drm_dev, false);
 }
 
@@ -1034,6 +1039,11 @@ nouveau_pmops_thaw(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+
+	if (drm_dev->switch_power_state == DRM_SWITCH_POWER_OFF ||
+	    drm_dev->switch_power_state == DRM_SWITCH_POWER_DYNAMIC_OFF)
+		return 0;
+
 	return nouveau_do_resume(drm_dev, false);
 }
 

---
base-commit: 4b6a8fa777d29785c7ddb51dcbb2b5411deefaca
change-id: 20250304-nouveau-fix-hibernate-249826d427bb

Best regards,
-- 
Christoph Rudorff <chris@rudorff.com>


