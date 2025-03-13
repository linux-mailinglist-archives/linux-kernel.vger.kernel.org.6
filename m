Return-Path: <linux-kernel+bounces-559002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84806A5EE37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379701899E39
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15921261566;
	Thu, 13 Mar 2025 08:40:37 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C361EA7FC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855236; cv=none; b=IDrMRi/UAo2+zODzOeR5mlih07ftKEPtzQxC0q4JPwZ2YNAPFHrmmlk9NWN4oHXc5LisAqPJRcEIrgOs2G0knBjym2z6kG5rwRt0lfF2W6SktTtpcPYsofVvF9SSHy0hHPj3cXHW8HShoRLndVBPQkLszjmoweLpWPaWuRFQRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855236; c=relaxed/simple;
	bh=/UnOtOyXolEONVcwhuDAvAWAW3FkdEDQOLvBaBK8tJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N3e6NfWfgI/YsIaLPx9539zxTCF2eiPkMjH0UJ+ZehwlNAWMBZoCo26rhB0f0cMUUzcCYWn4xtP57oKKQpzyMWlSYqf1FTV0TN0W9hQw7dB6nEoV2qP1ztynodYjgiviHDiLGWGtUzbNZZ5BpYmd1hQphm9dlaVzRnIb2p3djDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowADHztL3mdJno3fUFA--.2900S2;
	Thu, 13 Mar 2025 16:40:24 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: tomi.valkeinen@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] drm/omap: Remove unnecessary NULL check before clk_prepare_enable/clk_disable_unprepare
Date: Thu, 13 Mar 2025 16:37:56 +0800
Message-Id: <20250313083756.2481659-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHztL3mdJno3fUFA--.2900S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4kZF43WryfJr4kZFW3GFg_yoWkJFb_GF
	4DurZxWFW5G3Z2yw15Aw1UZrZ2yFn2vFWFgr1IvayrKFW7Xws8Zry2vrWfAwsrGFWxtF1U
	A3ZrWa47Ar1xujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUrr
	WFUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

clk_prepare_enable() and clk_disable_unprepare() already checked
NULL clock parameter.Remove unneeded NULL check for clk here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/gpu/drm/omapdrm/dss/venc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/venc.c b/drivers/gpu/drm/omapdrm/dss/venc.c
index aaeef603682c..7d521840d4f6 100644
--- a/drivers/gpu/drm/omapdrm/dss/venc.c
+++ b/drivers/gpu/drm/omapdrm/dss/venc.c
@@ -882,8 +882,7 @@ static __maybe_unused int venc_runtime_suspend(struct device *dev)
 {
 	struct venc_device *venc = dev_get_drvdata(dev);
 
-	if (venc->tv_dac_clk)
-		clk_disable_unprepare(venc->tv_dac_clk);
+	clk_disable_unprepare(venc->tv_dac_clk);
 
 	return 0;
 }
@@ -892,8 +891,7 @@ static __maybe_unused int venc_runtime_resume(struct device *dev)
 {
 	struct venc_device *venc = dev_get_drvdata(dev);
 
-	if (venc->tv_dac_clk)
-		clk_prepare_enable(venc->tv_dac_clk);
+	clk_prepare_enable(venc->tv_dac_clk);
 
 	return 0;
 }
-- 
2.25.1


