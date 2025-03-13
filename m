Return-Path: <linux-kernel+bounces-559680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF16A5F7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701774209ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E2D267F4F;
	Thu, 13 Mar 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KMEKgBVl"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECAF265CDC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875948; cv=none; b=Q9nnNAfoxfwcz8T4UJ2//J0VkZ4y72WnOLWaOSZ2QT+65IaoJom4iumJgVkpwSV4W1Lb4AsN2NHbnM2Gups6xb89DQzBqjyDikUNFWkMuvrg6kIUean6Xa5JpkRifCjwWm+fk6687XubTQsRt1jBmBNWJX2sseKaEeuBJYAPxMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875948; c=relaxed/simple;
	bh=QJ0RYlYw7SiEQC+4LWZiDgWcZNOAvSBGt8/GVYykKZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m/jsy+87WhdECt1ZYcjKXAZl5ldRb7qFaOVmpij9WFalthOnTaV2inu4xNbqKuLQGqfwtF9XlrraWwhm/K40w3r3Y9vmpRm7j5s4O/DFT6KQBCGCDcN4qJqmBMjuTL/hDX4FXirxD/N6gHf1rtH2+5ttO8QIlFsfdknUqcRICGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KMEKgBVl; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70D27444F4;
	Thu, 13 Mar 2025 14:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741875937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vrsRvrI2fVkzeaX8UjmDzn0XjDjCg6WTOhzziOVkric=;
	b=KMEKgBVls9RbWZlGt4UHN2T0cibIhnQ4oQxSR9n5eSq2UlsemvsVLgxzZtRhUHqGlZk3PO
	pBScKqn59/3RGZdiZmr2bD857dG620+Vjqk3jrEFOoAQAvFDxjDnYF470hoQVgQCmMIwcr
	LpS3qx8TOFzc5hep5vyjXHLNtwZ4piXeh6c9q/ikQeVduy0uG560Jyyj48oTJrWlx6d6aF
	0sj7fHbaojLRTtSdXXsJ8FhGdGTNl+LVZOROCcHV+tMTu2aXAcS8oGDcNx50ID/DFP/go2
	sUMJkoa/UayqKhELoKovvpUjNt7dWfSKOsxjNLterwauL1PrAy+5HeFlnkSWEQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 13 Mar 2025 15:25:17 +0100
Subject: [PATCH] drm/mxsfb: fix missing rollback on failure in
 mxsfb_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mxsfb_probe-fix-rollback-on-error-v1-1-ad2fb79de4cb@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAMzq0mcC/x2N0QqDMAwAf0XybCBaZW6/IjKspjPMNZLCEMR/t
 /h4cNwdkNiEE7yKA4z/kkRjhqosYFrG+GGUOTPUVLfkKoe/PQX/3kw9Y5AdTdfVj9MXNSKbqaG
 jR+Of1FFwDeTOZpzF+9EP53kBBQ8OK3MAAAA=
X-Change-ID: 20250313-mxsfb_probe-fix-rollback-on-error-3074b9080f34
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffgeekhfdtveffheeuudeltefhfeduteekleffvefgfffgkeevfeejtdekkeenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehpdhhvghloheplgduledvrdduieekrddujeekrdejhegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepthhhohhmrghsrdhpvghtr
 giiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghv
X-GND-Sasl: luca.ceresoli@bootlin.com

When aperture_remove_all_conflicting_devices() fails, the current code
returns without going through the rollback actions at the end of the
function, thus the actions done by drm_dev_alloc() and mxsfb_load() are not
undone.

Fix by using a goto statament, as done for the previous and following error
conditions.

Fixes: c8e7b185d45b ("drm/mxsfb: Remove generic DRM drivers in probe function")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
The offending commit is not yet merged into master, and even less in a
released kernel, so this does not need to go through stable.
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index c183b1112bc4e9fe4f3b048a2b6e4c98d1d47cb3..b4273e678d26dbc3dee2014266d61470da4e8010 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -365,9 +365,10 @@ static int mxsfb_probe(struct platform_device *pdev)
 	 * located anywhere in RAM
 	 */
 	ret = aperture_remove_all_conflicting_devices(mxsfb_driver.name);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "can't kick out existing framebuffers\n");
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "can't kick out existing framebuffers\n");
+		goto err_unload;
+	}
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)

---
base-commit: f9f087d946266bc5da7c3a17bd8fd9d01969e3cf
change-id: 20250313-mxsfb_probe-fix-rollback-on-error-3074b9080f34

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


