Return-Path: <linux-kernel+bounces-349072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5554698F06A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013BA1F21907
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC661199936;
	Thu,  3 Oct 2024 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="HjbGyVF8"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDF86277
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962272; cv=pass; b=pUpLPXs/yZcUASKu+lDyP4W4qnjxs66P4aG01DZ+l60fvj/rwNZsXD/fQkc+9Gk3g+NAfv0SxvAd949bQBHIwVNpCyuR5nIHqYRfNT0fJvEWkKvTz4pWYx/zDfnR68ZkoyyPYEibTffqHx5py+FpkPNZSPrx09QA1L0zE+e5n3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962272; c=relaxed/simple;
	bh=S1rPAAVIn0comlCzV6HQf2XkXBEBo2fuQaXvsK/x6U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M71GNsFDwdv7McM1tuMr8/yy8nOMAEtpQf2qoABiVp9ubGD6/qIpSIYBBi/3COWnFLTHmgrNzoX20/C4SPs0Enw9O1yZXrmEUTLq/W26Hak/9hk9+X73sVJ+YobOgchkpTWMWbxees5WcDKV+363YG/oCAA14UWMfP/uEVUiVpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=HjbGyVF8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727962252; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U2PwFjUvF1MrjQeDpe5NtTQrzvJaB+roYvoJnJK9vqI0Y0vBNIqxpaxuC/+dCMemBBVtXrQB5cq/s2kLpL+DO0sm7vQXPxF8l1yk9FCafF4jg7bf2OTk5RneE5o62qej3wpfd+wta4GSHX232/vvPO00CZwNzqbIV/sN7iaGXuQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727962252; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d6UuXdqkeRkP/vowaYIwAQPyT6dc3CyA0URjr+Pa01I=; 
	b=b9zU+zLWLPl6dg12y+D5F/8X2ok8uplSPfoKyS+i5waHzo36cTU/Jq8uT/inGw52BbyZB7uFqEIiPUxfzYF6LXYhzfpOWGuKXQERqZiKF2EFUtAlyfk2rPEYcYRxnwuiWpXu3hecM571JQFEpqvBssmnbTA+l5i3TI++MEc614I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727962252;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=d6UuXdqkeRkP/vowaYIwAQPyT6dc3CyA0URjr+Pa01I=;
	b=HjbGyVF8jO/YWIsqj5jldq+KRiPyzFtwDbf6rWUZahLEmzOTBASaHMKa47mrMO8o
	GvuExp4YcQlGFhIuwl6dF6nr+9FUXVgavjjJ6u+zxNYfHpUSqscI2QPZKwmA0NUaYBe
	+huZzclPNQQw71EbBGH/VhhDdPXKInFozVBRISJE=
Received: by mx.zohomail.com with SMTPS id 1727962249782554.8900083809897;
	Thu, 3 Oct 2024 06:30:49 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/panfrost: Add missing OPP table refcnt decremental
Date: Thu,  3 Oct 2024 14:30:28 +0100
Message-ID: <20241003133037.3398144-1-adrian.larumbe@collabora.com>
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

Fix it by putting OPP objects as many times as they're retrieved. That
includes putting the OPP object in case setting it fails.

Also remove an unnecessary whitespace.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 2d30da38c2c3..4b8840a41779 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -38,7 +38,7 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 		return PTR_ERR(opp);
 	dev_pm_opp_put(opp);
 
-	err =  dev_pm_opp_set_rate(dev, *freq);
+	err = dev_pm_opp_set_rate(dev, *freq);
 	if (!err)
 		ptdev->pfdevfreq.current_frequency = *freq;
 
@@ -184,9 +184,12 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	ret = dev_pm_opp_set_opp(dev, opp);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
+		dev_pm_opp_put(opp);
 		return ret;
 	}
 
+	dev_pm_opp_put(opp);
+
 	/* Find the fastest defined rate  */
 	opp = dev_pm_opp_find_freq_floor(dev, &freq);
 	if (IS_ERR(opp))
-- 
2.46.2


