Return-Path: <linux-kernel+bounces-280888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A441A94D082
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A3328395D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302E194158;
	Fri,  9 Aug 2024 12:49:06 +0000 (UTC)
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2346318C93F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207745; cv=none; b=QwB4FD/62eKN38lJ6mM3EK1kF1MhJN/Tn97qBW0FDUtxbZenGfVqKSTXKDDzI01l8YdLuezjPqSBUx/UgsJ49PAAysBRofn6OuUsY72+60LxWkZ9/NiqRzfgSQT084W9LhtlGm4LKOdc51AyZ4qEu99ULlG7Rjt8I+JtjlvD8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207745; c=relaxed/simple;
	bh=N6/eCpICsmuS5TXltHiq8wjL58QfEzcqMtXoHSiBLh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pGyO4HFHvbaf1Ej+42on5z+dBgXSRYgAsbCo3fXOjv4ijRYGtvaHdhv8dMCcbv//cAzPUW00wJsMWvl2UPA2e6VMEVDddLrdLupIJ6lxLuqWG0f6t5AT8nLZUbGe2Lviw9UtjlWLd908Q3anxBUa+cf9jDETOT25svy0vD+TfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.111] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <abelova@astralinux.ru>)
	id 1scP22-005QHg-1S; Fri, 09 Aug 2024 15:47:46 +0300
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.198.34.249])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4WgNxf2fL2z1c00g;
	Fri,  9 Aug 2024 15:48:22 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] drm/meson: add check to prevent dereference of NULL
Date: Fri,  9 Aug 2024 15:47:25 +0300
Message-Id: <20240809124725.17956-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhgrshhtrghsihgruceuvghlohhvrgcuoegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeffvddvueehvedvgfeivdeuvdduteeulefgfeehieffgfehtedutdfgveefvdeiheenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudelkedrfeegrddvgeelnecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqddutdeitdeivddrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedutddrudelkedrfeegrddvgeelmeefkeelheekpdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtth
 hopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopegurghnihgvlhesfhhffihllhdrtghhpdhrtghpthhtohepkhhhihhlmhgrnhessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepjhgsrhhunhgvthessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdgslhhumhgvnhhsthhinhhglhesghhoohhglhgvmhgrihhlrdgtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehlihhnuhigqdgrmhhlohhgihgtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1723192777#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12096493, Updated: 2024-Aug-09 11:03:54 UTC]

If devm_kzalloc gives NULL instead of allocating priv,
execution goes to free_drm where priv is dereferenced
calling meson_encoder_dsi_remove, meson_encoder_hdmi_remove
and meson_encoder_cvbs_remove.

Add NULL-check for priv.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/gpu/drm/meson/meson_drv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 4bd0baa2a4f5..3d143340e3f7 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -373,9 +373,11 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 free_drm:
 	drm_dev_put(drm);
 
-	meson_encoder_dsi_remove(priv);
-	meson_encoder_hdmi_remove(priv);
-	meson_encoder_cvbs_remove(priv);
+	if (priv) {
+		meson_encoder_dsi_remove(priv);
+		meson_encoder_hdmi_remove(priv);
+		meson_encoder_cvbs_remove(priv);
+	}
 
 	if (has_components)
 		component_unbind_all(dev, drm);
-- 
2.30.2


