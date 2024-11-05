Return-Path: <linux-kernel+bounces-397142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A79BD748
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A71E7B2197F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383C215C50;
	Tue,  5 Nov 2024 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="AtPb5s9i"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A43D81
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840123; cv=pass; b=jQ3lj1wR5hgb2vDAUNL0BOuf96D8n0Ri9SWC/My9rNbPN7hszKJOKGdMZrEiVfDJEHxHOtttCYgDB582IWhyr6c0sRtFXwxZ2r9UlQzbD7SEFXevDr1kUP9+li1aDaWqiIPh0+WuIcXhfnK4Fb6kg+4NJTHxt+afoq3IOuWxspQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840123; c=relaxed/simple;
	bh=NY387hNJNWbCTfR5FpSJqMa4iL6pcVJZU42zdO8CaSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lWzIHNH1ILoVHd8xw/Hf4j7nkNI4tb3MFOBhnZus3yo1msWYE7gKvJRAwec4mt7RTJ1CT++3fUAuY6U9pVzUFr1/WRZXttB6mCw2DnA6mDuxpKWTbIeT8KFcKiTDTUEEC6spJoFBGWzkSk4oPSxm6hysxWd8ltzJa8rlqz+zXx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=AtPb5s9i; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730840109; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R4URFRu68qMBbJlAKi9VTm1Ne07Q1ZI9slaTrkvjkTvxySPKS6/5uiiyl8A1r4jHm/FThTKQvxjH0FjjFt9JWt3J1lB+AldwPgpgZtzTvt3l1eVMRD0eKlDMbwMi5VF1+GK1/fBiGkv/JCB7JP2hQZ9Y97SD/Xh6oAshhFU1RzA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730840109; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nj7nP9zQoF3AEa+3/reQIoPhVeubnSxEu3NbYWDKKx4=; 
	b=G7Q5CrCYp1rB+jO88ETsFDFvBKNygFgeVb8T4UL8VZPpw31xtkUtQH+1IUHyEoS0IJArGjym+wJl9OQ1ehFZdQlxQwYsLdHHrc2F6z/Q2rksfddi4opgq8KceaO59tLumTQkreDCm+pM1rnII5NwAgKR4ifQLQyXDghnPw2lVH4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730840109;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nj7nP9zQoF3AEa+3/reQIoPhVeubnSxEu3NbYWDKKx4=;
	b=AtPb5s9iyVHf5cVM1C4rChxIAD/jXlty83NGkwb4qef0johFykNflbVKICQ9JTA0
	Ki7K53IZwGqds8TkACcJwWrk+5uBGRb/pcT6itQ5fUYcNG1dgZe1Lqv/35RPNeDfBe/
	ZCU4coechi/n4O9zwsX3Pmd+nY7F07mHGIUKnPSo=
Received: by mx.zohomail.com with SMTPS id 1730840108167855.385300677661;
	Tue, 5 Nov 2024 12:55:08 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: kernel@collabora.com,
	Liviu Dudau <liviu.dudau@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] drm/panfrost: Add missing OPP table refcnt decremental
Date: Tue,  5 Nov 2024 20:54:55 +0000
Message-ID: <20241105205458.1318989-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
retrieves the OPP for the maximum device clock frequency, but forgets to
keep the reference count balanced by putting the returned OPP object. This
eventually leads to an OPP core warning when removing the device.

Fix it by putting OPP objects as many times as they're retrieved.

Also remove an unnecessary whitespace.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 2d30da38c2c3..3385fd3ef41a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -38,7 +38,7 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 		return PTR_ERR(opp);
 	dev_pm_opp_put(opp);
 
-	err =  dev_pm_opp_set_rate(dev, *freq);
+	err = dev_pm_opp_set_rate(dev, *freq);
 	if (!err)
 		ptdev->pfdevfreq.current_frequency = *freq;
 
@@ -182,6 +182,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	 * if any and will avoid a switch off by regulator_late_cleanup()
 	 */
 	ret = dev_pm_opp_set_opp(dev, opp);
+	dev_pm_opp_put(opp);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
 		return ret;

base-commit: aadcf584583ca9833b4fb2140a4f437569ddbcd7
-- 
2.46.2


