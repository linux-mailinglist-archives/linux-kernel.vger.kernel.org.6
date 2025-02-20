Return-Path: <linux-kernel+bounces-523849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F397A3DC10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133B619C10D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D61ADC9B;
	Thu, 20 Feb 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RbfhZuK3"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C91BC4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060268; cv=none; b=pgreUPR0XHeKv6t02i/Uu7CE1QtOL7huIj3q197swPwGCQfh7kwdgYFZXZrhrkk61nGZpYD2xHT2gxGzG2AAT4Nrudll1eD/stVJBlkXNvjKGRIwip3urniWd6jlN+SlFnL63HGOItiyuAZPXvHF7HQ6mMy8sY8S2WXYUoqDfXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060268; c=relaxed/simple;
	bh=PdXGpwciH2KKcjqO+eDRk5FybnpIbqniD95DakSqNGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWfI0MhfdTcojM3Ug/w6O9AHxvet/Qu6OHQts4rVm38F0/9hv1Ytktu3i8GRbsQ6qna2Zaesw46hDa3kGRNq17zul8NopJ5zUzRtTVJe2DjC8d+jzKJLNyFRYJgZbub77bu11Y1ci+P+Zx6G3pLmlh/R9HxH6XjyY9US7zNzpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RbfhZuK3; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 51D54432FB;
	Thu, 20 Feb 2025 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740060259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EAC7somYu40e739WtHAsjHHX4fz3//xMHDippmmZA38=;
	b=RbfhZuK3S6WTwQrsoUQA8hR1Oy/O7cmkgNSG+oO6W8xIvH6huW+KbACQC3d8ERrkoM8+2v
	sAIQB3fPkzNywVproY/xA4dCcrkLwtUD2ofoCdHOk4Ul6Mc1mz4r8ttJARjbsgujA9jwhb
	6ATM2pak6yqJK/mmXS6Ng4Of0lzGepChGKjUlBPFRB2xvA/D9+h2NlNUMpKdhewfJcSr2+
	ByXiocR6/Ri4ABrrXjEMnAnRyi1UVCudSWjvj0FRqKpwCXL5v+y+kTiJuMi/Cd9iJi7KqF
	BnIbPzJtmalA0HZcsgDZ+aOh+2ivxEBxPyCQYB0m7OBjaJaEDBr2js5n7cv5yA==
From: Herve Codina <herve.codina@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH] drm/atomic-helper: Add a note in drm_atomic_helper_reset_crtc() kernel-doc
Date: Thu, 20 Feb 2025 15:04:06 +0100
Message-ID: <20250220140406.593314-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeefffffgeduueefhfegfedutddtjeejteegveegtefguddvlefgjeefueekvdetveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgdphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvr
 hhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

As suggested in [0], add a note indicating that
drm_atomic_helper_reset_crtc() can be a no-op in some cases.

[0]:https://lore.kernel.org/all/Z7XfnPGDYspwG42y@phenom.ffwll.local/

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 This patch applies on top of the following commit available in drm-misc
   ab83b7f6a0c1 ("drm/atomic-helper: Introduce drm_atomic_helper_reset_crtc()")

 drivers/gpu/drm/drm_atomic_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 0a636c398578..1f93b0a855de 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3371,6 +3371,10 @@ EXPORT_SYMBOL(drm_atomic_helper_disable_all);
  * This implies a reset of all active components available between the CRTC and
  * connectors.
  *
+ * NOTE: This relies on resetting &drm_crtc_state.connectors_changed.
+ * For drivers which optimize out unnecessary modesets this will result in
+ * a no-op commit, achieving nothing.
+ *
  * Returns:
  * 0 on success or a negative error code on failure.
  */
-- 
2.48.1


