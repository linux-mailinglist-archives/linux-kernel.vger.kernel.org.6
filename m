Return-Path: <linux-kernel+bounces-229959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A901B91768C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3304D281D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D93AC16;
	Wed, 26 Jun 2024 02:57:02 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF68BEF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370621; cv=none; b=ororyErJKh0b7ZPMV2QggDtKdyaJy/I+Z+JmwCHO2elvHKsebP559ONdxUjM2i6z/x1GsKn8nkP2HC2EZ/VR+5T6wsjt5suCjc04FF8Grhv+3Sr4Bs0j/VGOzlFaPc8JRBPuQ4FDP9vwRf6U9v256RwUOWDjSBbJaKsJxGsTaXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370621; c=relaxed/simple;
	bh=xkLgjonCYoLvoGrA3RjuKggotryo5PDx24v1KAgeGAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mk3zYJtGfyJgCMwZxYE51PnmxMrphcr3YV8kCfeGkTkUNnyJnkic4vRLJ7aLsYOOfx0ZU7XPVCXYo4z5MnW2tQF9WoH3LTkcDypBxNw9PeF6/2sq+JKWwg5JCKbJLIXJm2S6hbsiGj4D+V+do9stK39nEizVHDCeqlgMuFaGwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowACnr5Nqg3tmU4aEEg--.7679S2;
	Wed, 26 Jun 2024 10:56:49 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] drm/radeon: fix null pointer dereference in radeon_add_common_modes
Date: Wed, 26 Jun 2024 10:56:40 +0800
Message-Id: <20240626025640.2779322-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnr5Nqg3tmU4aEEg--.7679S2
X-Coremail-Antispam: 1UD129KBjvdXoWruryxAF1kZF1kGF17AFWrZrb_yoWfCFb_CF
	1vqa9rXa98XasYvF17u3ZxZr9F93y0ya1kt3Wxta4Sv34IqF1fWFy3tF1Fvw47Xay5AFnx
	J34rKw13AF4xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ2
	3UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In radeon_add_common_modes(), the return value of drm_cvt_mode() is
assigned to mode, which will lead to a possible NULL pointer dereference
on failure of drm_cvt_mode(). Add a check to avoid npd.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index b84b58926106..71ddc4672850 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -520,6 +520,8 @@ static void radeon_add_common_modes(struct drm_encoder *encoder, struct drm_conn
 			continue;
 
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
+		if (!mode)
+			continue;
 		drm_mode_probed_add(connector, mode);
 	}
 }
-- 
2.25.1


