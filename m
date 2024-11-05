Return-Path: <linux-kernel+bounces-397143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411529BD749
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E88283667
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1D5215F57;
	Tue,  5 Nov 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="NxaUSgXm"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9B1D88DC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840130; cv=pass; b=t8+iMyRumJw0rtrfhlZbkQYr7nbBEzNrmUQtw4ekXQMBduqRm7P0mT0gAEqzTsTVKwOwer50USX0YERzcZx9dr1OI2WfodV74EL/VTTu8HATGybmUmPnDtO3w4bUNyNNzlbUqBxakB6L7S8DbElbN6XNCPiFonD8a2EvNIwtP5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840130; c=relaxed/simple;
	bh=bKzM7r1RF23jGqQ7nfcrb77Qa9NmZUfKl+PtrYmrzWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2dTCy+9EiAjSHf0q7WvlvlFxck/Q+D3MxlShethGFXthu+UiMrjdnNh3LtxqmgAvYezv6r9v8awz5ZbZlw4oCxYorEPKHJIUobAc2TRYEVQPK//xZfJsbcKWBjfOslo1Mkta5qS9xRtsy4u57ECdBHYQvo7RdvdjhGfnjD3dX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=NxaUSgXm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730840113; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q92ZMBTzX2Ovt80kwYpz9CfZB2hnVMAmuq+lC4ecC99Q6Byndqvw/lwYe5dnpaItsjxKp+4nLguCk4DJ3iAn/aOIVuvqHU+jQ6sxCmJxo8RKgs+tRTphngSQHEDfDdpbo+yRHfhokPe9BYarH7XEa9uj7A3yv/zhPR19k9cChg0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730840113; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AwrxtqiIa4mKWF1bEvs38Az3WJm9z6mQPcyAOFFvEs8=; 
	b=TsEr5VLOugB/3IGrwlQlcn54Wz+J34uu38BKDQJF7CkaD6zyWwdMHWFX6eFiQRPpGJxUVPwD8Or3DvG/rw+ypAmLz/QhJKVfiJX2kvajblN1JZ1M308z93F7zzEcZ4PgnYbaZ2wBq1O1N0YU70cMFy/qimCz7V8vN3V7oeOCtmc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730840113;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AwrxtqiIa4mKWF1bEvs38Az3WJm9z6mQPcyAOFFvEs8=;
	b=NxaUSgXmjFfWIK1qjGuGmSupIsgjS1zh0Q/hDgVXFB6ECVl0jR/vcEGLBKamY7bY
	e+o5RU6VK/0oLYEHUq2rDVqJojeLsflH6wKt7V1xJN/H2d+DUhG3IM4oAaHCNDh6epy
	APzvVGXpQLmUtY9ON85MYP6xA9LBcdptWtm30GEk=
Received: by mx.zohomail.com with SMTPS id 1730840111631663.6545608679393;
	Tue, 5 Nov 2024 12:55:11 -0800 (PST)
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
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] drm/panthor: Fix OPP refcnt leaks in devfreq initialisation
Date: Tue,  5 Nov 2024 20:54:56 +0000
Message-ID: <20241105205458.1318989-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105205458.1318989-1-adrian.larumbe@collabora.com>
References: <20241105205458.1318989-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rearrange lookup of recommended OPP for the Mali GPU device and its refcnt
decremental to make sure no OPP object leaks happen in the error path.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: fac9b22df4b1 ("drm/panthor: Add the devfreq logical block")
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 9d0f891b9b53..ecc7a52bd688 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -163,13 +163,6 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 
 	cur_freq = clk_get_rate(ptdev->clks.core);
 
-	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
-	if (IS_ERR(opp))
-		return PTR_ERR(opp);
-
-	panthor_devfreq_profile.initial_freq = cur_freq;
-	ptdev->current_frequency = cur_freq;
-
 	/* Regulator coupling only takes care of synchronizing/balancing voltage
 	 * updates, but the coupled regulator needs to be enabled manually.
 	 *
@@ -200,18 +193,24 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 		return ret;
 	}
 
+	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	panthor_devfreq_profile.initial_freq = cur_freq;
+	ptdev->current_frequency = cur_freq;
+
 	/*
 	 * Set the recommend OPP this will enable and configure the regulator
 	 * if any and will avoid a switch off by regulator_late_cleanup()
 	 */
 	ret = dev_pm_opp_set_opp(dev, opp);
+	dev_pm_opp_put(opp);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
 		return ret;
 	}
 
-	dev_pm_opp_put(opp);
-
 	/* Find the fastest defined rate  */
 	opp = dev_pm_opp_find_freq_floor(dev, &freq);
 	if (IS_ERR(opp))
-- 
2.46.2


