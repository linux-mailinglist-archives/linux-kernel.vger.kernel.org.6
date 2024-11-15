Return-Path: <linux-kernel+bounces-411093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37A9CF2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2326D291DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E300B1D619D;
	Fri, 15 Nov 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NZ2hqJNv"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C8184D02;
	Fri, 15 Nov 2024 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691583; cv=none; b=Mnf62Y3fY7N+PnVLXPvVq7Q8ipAfOYK1ms9tYIs40LM1m5BCstwzCCDFTQL2dCfgGAPCC1s3C64GmP87WAC76j1OVDynU2y+bJ4qIOY66okZTk/r6JdYMlWAGty2/9Mk7PR3Pf4HqQYk7yAd6Fc4DPtAKEKEtxR+bEzukgoAv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691583; c=relaxed/simple;
	bh=SfQYjl64402cRIHcYRSF8hREmjASTugCRFUUgfkXnUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPdytyQarJ6rTp9ifI/rUxmAiM0yCML/mRHxtmwl5hoj1Lie7o0N7Oix8RU/UpkjMQCsOBz3HkWlVOyMXgXupQjDcfaCIBGputFjC1aM/RNI9zL+VicWXoGvwVYv9swJfjqiiqmnQ8jdQe/Y46H6LM4nPlHWCnvf4s1Wf567EeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NZ2hqJNv; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id C05Jt9hymPqyaC05Kt0Z2L; Fri, 15 Nov 2024 18:26:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731691578;
	bh=Ce50d8CDL8pg9VTVcidQUBBsONObBsW+KaLtOOzdVmw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NZ2hqJNv2eCYVEVfD1tsEf/FLmfCewP29Mf1t2i3jQsyTkXpfwRDcyiuxyS54v9Fh
	 dvq4IRHa/tZ/EG8KpTtW5HAbiCA8bqT7DcdGeKpDlfv5gEcfMlCLfVhMTA0M221cT2
	 5s54yS9WbD+hknJcqgrfEPNPUg4vFQlfPK8tufcmFEDIQ4xg1bWyA9rdYb/68nSUbS
	 g5WpsvA309ZWjRAIl2m5sbmK0cck8tZ3sAGOlbB20Gubj7OEzPvnx+dVoiXLY/ev4/
	 4R2VEdBbOMmICY/dzLmckO2wv85NLHloMdPYj55kOP0rkyMzrR6Kzz0WktBWhxFFcf
	 h8yE2eOY1kodQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Nov 2024 18:26:18 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: linux@weissschuh.net,
	broonie@kernel.org,
	lee@kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/radeon: Constify struct pci_device_id
Date: Fri, 15 Nov 2024 18:26:06 +0100
Message-ID: <039846c0278276e7c652395730f36051216fd4c3.1731691556.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct pci_device_id' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  11984	  28672	     44	  40700	   9efc	drivers/gpu/drm/radeon/radeon_drv.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  40000	    664	     44	  40708	   9f04	drivers/gpu/drm/radeon/radeon_drv.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/gpu/drm/radeon/radeon_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 23d6d1a2586d..5e958cc223f4 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -248,10 +248,9 @@ int radeon_cik_support = 1;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
 module_param_named(cik_support, radeon_cik_support, int, 0444);
 
-static struct pci_device_id pciidlist[] = {
+static const struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
-
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
 static const struct drm_driver kms_driver;
-- 
2.47.0


