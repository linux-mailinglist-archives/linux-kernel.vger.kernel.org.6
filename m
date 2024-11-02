Return-Path: <linux-kernel+bounces-393496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39B79BA154
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 17:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFBE28212F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4941A4F1F;
	Sat,  2 Nov 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FPsq+Ibm"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A883C3C;
	Sat,  2 Nov 2024 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730563271; cv=none; b=BH5ndp4HtqEsQ2gNGnLe84xuj00Ggi2ZJioRUrqoUD7ejcp3JCCjDl3oyMfOkfZxwc11eT/VnpGsjv0qAOCW00xhobeasqtmBvjhU92/eOygsiHc95lLOW5Y0sl3uCIvdJpUcvVB5jH8n8yuCqZz54Oz3aNMczEB1KwE2eXUb9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730563271; c=relaxed/simple;
	bh=pWtlMhVEo5sTa10vHdWI3MJ+UdkICdAOYZ77Ui+PqCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B36guDNfBN9/x6k2wTncY7ck8GEzI/qxggU8fD0ccMlmkRvYT6PweZvVEwZlA2AY/FhBU95VkrDpIRKW1BA4/2UY0yGBlREshFWk9QMV6itFX0ev6ZLaBYsTeFN7RIe3b0vtzrhV3sbh77gFED5WeZyPu5Ct+ipL0nxAlBboMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FPsq+Ibm; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 7GXat8EQFNFce7GXatlT3S; Sat, 02 Nov 2024 16:59:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730563197;
	bh=KGKzVWsnOyVtcs0VCIBf32JB3OlZi4k6gGyDSCVIYG4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FPsq+IbmN649gL8GgwbVI/cRjs4BDAzzEO+TIlCYtZBxAgNh9ev/V/hEToE4BL1WX
	 j3crEuh8erPcq6Stva/3Vj1sMb6gvG8wl4jo51yGksnqp2TTKwOC6xxjlVvfy4NT5K
	 yCDkwWGOkOhG+T+VXtJzu22cP0OAE7AXeHAWBSnEEOUMhqZJUpI1Brlng7OO4+wjOp
	 2mEoV+iHW59WG+K7kMAsydg4k/deaZTffGX5ZvXXOrrgqDr9FJv6RhpFgZyMYWsSNi
	 1OjQIeI2ZcfovJit6fcsIpfu9VT4CRBR3ilOLx4a/Ob04lqY7daamNq/OUmq5yttaw
	 1MOWM5wVGIY/Q==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Nov 2024 16:59:57 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: srinivas.pandruvada@linux.intel.com,
	"David E. Box" <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86/intel/vsec: Remove a useless mutex
Date: Sat,  2 Nov 2024 16:59:41 +0100
Message-ID: <ccc08a262304f7f8c2e435349f0f714ebf9acfcd.1730563031.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc()/ida_free() don't need any mutex, so remove this one.

It was introduced by commit 9a90ea7d3784 ("platform/x86/intel/vsec: Use
mutex for ida_alloc() and ida_free()").

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
See:
https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L375
https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L484

Review with care. This patch is clearly the opposite of the one in Fixes
which states that locking IS needed.
IIUC, idr_ functions need locking, but not ida_.

If I'm wrong, could you elaborate why? (because many other places will
need to be fixed and the doc certainly needs updating)
---
 drivers/platform/x86/intel/vsec.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 7b5cc9993974..9e0f8e38178c 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -79,17 +79,13 @@ static void intel_vsec_remove_aux(void *data)
 	auxiliary_device_uninit(data);
 }
 
-static DEFINE_MUTEX(vsec_ida_lock);
-
 static void intel_vsec_dev_release(struct device *dev)
 {
 	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(dev);
 
 	xa_erase(&auxdev_array, intel_vsec_dev->id);
 
-	mutex_lock(&vsec_ida_lock);
 	ida_free(intel_vsec_dev->ida, intel_vsec_dev->auxdev.id);
-	mutex_unlock(&vsec_ida_lock);
 
 	kfree(intel_vsec_dev->resource);
 	kfree(intel_vsec_dev);
@@ -113,9 +109,7 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
 		return ret;
 	}
 
-	mutex_lock(&vsec_ida_lock);
 	id = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
-	mutex_unlock(&vsec_ida_lock);
 	if (id < 0) {
 		xa_erase(&auxdev_array, intel_vsec_dev->id);
 		kfree(intel_vsec_dev->resource);
-- 
2.47.0


