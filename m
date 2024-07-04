Return-Path: <linux-kernel+bounces-241108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897DA92771C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6BB1C23116
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B77A1AE85C;
	Thu,  4 Jul 2024 13:25:01 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E4846F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099500; cv=none; b=Q99YE8iCa1MrYaYZadxbEwqICn25MyQTeQBtjHFYi6UjJZTH/IcwiSAKRFlG/14EG/7WiNx9PFHslXBkpg4FxzGmK0NJCFjUIOAdNgOuennWN+PhL1gsM1Ms3CmV85S2+T3l3kr7Ub031em0Y9DUf+8vepNp/zIZYQDoGJL8SJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099500; c=relaxed/simple;
	bh=CRRg/SQ8OTxdPTkd/uzCUZaSGZqMSVHW0vsJ1UfRGUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p26bTYorAdrQnQseImQPPnLb/xgVoLh81Hb9elP14+GLJyAPe/inttfAuIOEIr2/QgiCPUdNP3y0vF2Elv1NYtmB3mklqQyh6fvVIda3IZ7D+OTrSvkBj9IykDX6+X7KbBujcbhEMUFbCkuzUKYrr27j3dBIfkuT0VsJPt6BqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAAH6U2CooZmXzyOAQ--.1294S2;
	Thu, 04 Jul 2024 21:24:29 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sam@ravnborg.org,
	noralf@tronnes.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH RESEND] drm/client: fix null pointer dereference in drm_client_modeset_probe
Date: Thu,  4 Jul 2024 21:24:16 +0800
Message-Id: <20240704132416.299319-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAH6U2CooZmXzyOAQ--.1294S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4DZw18XFyUuw4xtw4Dtwb_yoWDCwb_GF
	yUX39rCrsxWa4kCanI9a1xAF12ya4UCr48AF12vayFy3s8J3ZxZr9rJr1rZ3W8XFyUAryU
	tasruFnxAr4IkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUFYFADUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In drm_client_modeset_probe(), the return value of drm_mode_duplicate() is
assigned to modeset->mode, which will lead to a possible NULL pointer
dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.

Fixes: cf13909aee05 ("drm/fb-helper: Move out modeset config code")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/drm_client_modeset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 31af5cf37a09..bbe21522dc6a 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -880,6 +880,8 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 
 			kfree(modeset->mode);
 			modeset->mode = drm_mode_duplicate(dev, mode);
+			if (!modeset->mode)
+				continue;
 			drm_connector_get(connector);
 			modeset->connectors[modeset->num_connectors++] = connector;
 			modeset->x = offset->x;
-- 
2.25.1


