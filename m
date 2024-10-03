Return-Path: <linux-kernel+bounces-349073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B4D98F06C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B839282D80
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5821199936;
	Thu,  3 Oct 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="fKX8rtSx"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB7C86277
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962279; cv=pass; b=QBsw6bp6jdp2L/4SQ13KTiziNZqtsUiH/jel43gWmwsPfwoMQAiycNBd/7drqCMM05orxfUsd9fQuUBOPt2jIyMIr/sZ+aWmXcIpCAoBDijDkR0zHTG3mVJPZdF7XY/2vFH0v5F/aJEyA9ncWBDp8eXY598keG/91631/sMvs4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962279; c=relaxed/simple;
	bh=C+YwU/eiRj5kv9ChEtNj6TjSgCIDwjwsaoiuu5QYprM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqd5io316UU1whmBUkBbgJPPQEpm+3HCfg8PESSsdV/5M8JboVUCZnxoS+atV1vGE2aCiz2Nz95gUmflcWknC4CqrBSNZQnXWlX32y4n+/UIU/685OiT+d33m6zYNKjNeVxZMHrryT0KivOORnTk+Gnk7r5QV3AqI2wJdp+6CBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=fKX8rtSx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727962254; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RtCuQjkb4ImmOrs9F5OU9PpeLiqS0rm9TzjibjiQRWR0ZkSLSXQbgqr4DihjV4A9+6Ca/bDniTKkW/C7bbabNTVmP0kp90CYzYrdM/RT3nyxOON62FQpEx4Oe93LPX39Omqk9IAakCLTwGOjZLQtpRo1CG95HItq6Z4XhWV/1Ic=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727962254; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u3hkyLMMRDkXtwRu8SNsIhsLIlGy1TJE8XWYuhk2/yA=; 
	b=MFUGGHRxojnhQcdB93EfDl4j1/8X1IibIlgkfdsT7s4UM/T8eC+HgOCydlNQsxTCI++tgBumbQYpB4IzgfVA2Prfa94Pl6adsmfiJZobOTthRauVP52AnL58NGMW4Y6wrYWkbr3iaytMM7FYKiXwOO3nuqGhetPflMi8n1pwFfk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727962254;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=u3hkyLMMRDkXtwRu8SNsIhsLIlGy1TJE8XWYuhk2/yA=;
	b=fKX8rtSxSyVJ1u69UoRXm/uTNy9DM9czkjbHjwQS3cP38vY1dar28o+3vsxyjPIT
	/YuCBUpZiMAWEWB8C7UXmQDRfXiphxt6kWJjuSfC5TAtNC4l+r2kYLDgeVUJFwiNPzk
	dM83FBK4TGPUvoSsr3hvTVebn0ycTF1CbGMLSqOc=
Received: by mx.zohomail.com with SMTPS id 1727962253296545.6382302905259;
	Thu, 3 Oct 2024 06:30:53 -0700 (PDT)
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Grant Likely <grant.likely@linaro.org>
Cc: kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/panthor: Fix OPP refcnt leaks in devfreq initialisation
Date: Thu,  3 Oct 2024 14:30:29 +0100
Message-ID: <20241003133037.3398144-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003133037.3398144-1-adrian.larumbe@collabora.com>
References: <20241003133037.3398144-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make sure in case of errors between the first fetch of an OPP in
panthor_devfreq_init and its successive put, the error path decrements its
reference count to avoid OPP object leaks when removing the device.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: fac9b22df4b1 ("drm/panthor: Add the devfreq logical block")
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 9d0f891b9b53..ce0ac4563f65 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -197,7 +197,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 	if (ret && ret != -ENODEV) {
 		if (ret != -EPROBE_DEFER)
 			DRM_DEV_ERROR(dev, "Couldn't retrieve/enable sram supply\n");
-		return ret;
+		goto opp_err;
 	}
 
 	/*
@@ -207,7 +207,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 	ret = dev_pm_opp_set_opp(dev, opp);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
-		return ret;
+		goto opp_err;
 	}
 
 	dev_pm_opp_put(opp);
@@ -242,6 +242,10 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
 
 	return 0;
+
+opp_err:
+	dev_pm_opp_put(opp);
+	return ret;
 }
 
 int panthor_devfreq_resume(struct panthor_device *ptdev)
-- 
2.46.2


