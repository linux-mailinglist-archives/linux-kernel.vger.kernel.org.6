Return-Path: <linux-kernel+bounces-351942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01786991822
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A281C21580
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D1615699D;
	Sat,  5 Oct 2024 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="GcfZ6KZt"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A4374EA
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144564; cv=pass; b=Epp0MrfpO6zDwXWE4ipZxBHS8fuL1YDnJXXeHiyukQvT2EVoWPJ0pN0NkSRSKn6JZb/0KlvB2pleD4GxzcLhNAWnc7Ja6BrfhSg+I+GzJYVzn9b9X15brIomYihZ09yZdPvHORhrf3b3Gbc/jBpW9OyFovge5U+FSOB5dQXkgaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144564; c=relaxed/simple;
	bh=heMnnBLkZ14zM6lVG6M0rsNKFTQBFq+Kn1gmFTVTMLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=feNNlh4wpP7y/3+ynuMG+HiETToSK7SMlpvfrBnDTL45XpNBwL1sNj8E/ksYbVPQF9T5f/qryitTlywiLauZP6EWCDxd699UidmoyI2YniV5M4h6u8e4+Enz2qQBbbLo8roy4+HP/FkZkeNL88735PAMr5fUUwihd/vo/7oRlo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=GcfZ6KZt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728144548; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cGd8u8H830/Y9MO90QueAMSjyO+lDU3OLKxWbV6b1rCR0e588kYZ64v/J2C70fSG5pO5kxyeIDBczyV3nH3SnX/2dW5FOBB6Klcw7dRfStavpdUmmpNg2dxkQXnFZvUhhZD1Tm4P1ZXA14HH5ziwcce4qLzMZt1FF9+1KaQnMZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728144548; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=B/KSYYR1T3gUzqZowAe2+SBTCH+9OFZAP3JPy6LVLtQ=; 
	b=l42G5dDJj4SEepunCXhDsrONYyJw+v/u1dhOc2VWhI4YOysyXNTBFr+KdEX5CVPNhEBa7DfSwJJOtC8gQGYVx7ptsGEGbiQXFa84cE/dAqs18TuJQiDsfdu2z26XM0+83vSX7MiI+bSuqdkQBWIieG/51PQpO3s8ykurWsfBdDE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728144548;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=B/KSYYR1T3gUzqZowAe2+SBTCH+9OFZAP3JPy6LVLtQ=;
	b=GcfZ6KZtDAkZM7DuszAaU5JXvF07NOzzq+M3jAjklI2J37A6kO4PoFw/AsRfyui8
	8QWdDAW0Zf/pHLfmruTHTTqDoLIPoog4CgL3LMvJZQaL8EhQzkdWagPH9Nh6lFN5avj
	C/N3eXCJu/ovNgC1ZgkwQUAtUbZX/3BrKQclYM3A=
Received: by mx.zohomail.com with SMTPS id 172814454763354.29541276121313;
	Sat, 5 Oct 2024 09:09:07 -0700 (PDT)
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
Subject: [PATCH v3 1/2] drm/panfrost: Add missing OPP table refcnt decremental
Date: Sat,  5 Oct 2024 17:08:52 +0100
Message-ID: <20241005160857.347796-1-adrian.larumbe@collabora.com>
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
-- 
2.46.2


