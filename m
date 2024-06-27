Return-Path: <linux-kernel+bounces-231749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9BC919D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BE9282740
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBEED51E;
	Thu, 27 Jun 2024 02:27:51 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C37322B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455271; cv=none; b=eUGNn9uo8rU3gS1AhF95ujXMSTZk5wPgrboafjA8EJFLDSZrAYFWxFX6Rc7jWzEu5B5D9Qwtb/SBz64PyqIAv9EervRN1cx5hMbOcjgMlvCKGyvC/p+ci8M8D3P0dyWj/ikLOpNCHV4lXoqqJ4Wq2TzWop21AaeMikRSNvn6mDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455271; c=relaxed/simple;
	bh=1FPjS3P1RWiqwll41JdaKHsMBDK9I3xaceJ2WKaOnqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hFbU/IZ6/aHJLJvWVSBKBeUwMfbER1KVjlmM72I1etk/pV6zHbm2shn0PUY396YKMufyTDr0D8bqljMCZEWKRTjD5lBwHstXnG+d/YrLyNaw0fywYXHUCwsmdhG8ugJCMshRMcBpvyI6A3/vCqlCz61OG/wzgChviI/SjIWMxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADX3+cVznxmSQEhAA--.8512S2;
	Thu, 27 Jun 2024 10:27:40 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	airlied@redhat.com,
	bskeggs@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v2] drm/nouveau: fix null pointer dereference in nouveau_connector_get_modes
Date: Thu, 27 Jun 2024 10:27:32 +0800
Message-Id: <20240627022732.2978601-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADX3+cVznxmSQEhAA--.8512S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw13Ww4ruw48Jw1xuF47twb_yoWDuFc_CF
	1kZa9rGrsYgw10ywsrAa18Ary29w1UZrs7AFnYqFZavrZrJw1akry7tr1YqFy7Xry8WryD
	t3Wq9F98Crn2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In nouveau_connector_get_modes(), the return value of drm_mode_duplicate()
is assigned to mode, which will lead to a possible NULL pointer
dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.

Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch according to suggestions.
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 856b3ef5edb8..0c71d761d378 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1001,6 +1001,9 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 		struct drm_display_mode *mode;
 
 		mode = drm_mode_duplicate(dev, nv_connector->native_mode);
+		if (!mode)
+			return 0;
+
 		drm_mode_probed_add(connector, mode);
 		ret = 1;
 	}
-- 
2.25.1


