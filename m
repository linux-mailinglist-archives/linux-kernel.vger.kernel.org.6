Return-Path: <linux-kernel+bounces-425081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720329DBD40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40063281B69
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20701C879A;
	Thu, 28 Nov 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="De3vQalX"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BF1C75F3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828391; cv=pass; b=JTSlAvsVcVt9lP92Ja+1YaugqBWC34phf8EgQGtcTx8GlvX5s9Wh570vmAUYuEcn42oLNbH7DACclaFYvrJFu2pnBUBZppwgl2urZst99epGusujJxzm3aNgXsV03eSE1zDwMGMsunaOcsvKViLkXVVVpzeNIjinBS0oCeyfFwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828391; c=relaxed/simple;
	bh=7ZvAM8LeNcGpYnaIV8kS8sxsDHLAn+pHpFcHTHCn05g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2159KVt6pldMs/sbjVX22XWRdzG+7tMM9XzxPFsFjeDr+Luy2B0y236Ju43OJTR+u1GXNjDBRvmSo6r57wGEOyuF/eTjBCm30Ga5q0mEdTvJfA0sgg8Blet3lzEsFR9vje/iKkBR9JQMrms0ktzqGgSdA0rohxOaeeLaQSBD88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=De3vQalX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732828374; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Iqt1iX2INO98N3AvbhmT0ROJ2qvAKHwItoX4py5bL+Dxse0P21aOy0Zgpm6XFfFR8A4A12WX6pYpY0zcICWLgeEmaux2bIL11/13UlJ3LohlV5NlHF3Zb19GBX1SQYKr5I5X3Azom2EsyX0Dy/d2uwX9Y+vYQ6HnKj5BgOLqka8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732828374; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tOVwrrlUZ2MlE+48s7qwMLmhwjK5xM0tNaJsi4iUz2U=; 
	b=OQR9EWPgZ42ZbPvIrFiU0OAvHAzMCQPaf+3EtJ0SWdGfNYioIpjqgCdZcp3gwXSdXRO3gcIqp8idv8Ov3/0xNzWV6D0gqC/PmOkwRi3CvklgHTuAtA0/rDpwX0Dyjby3hlvpNPBQVVBe0B7+KfoQK25iQr+j5Wh9kTDXLKt/Mvs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732828374;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tOVwrrlUZ2MlE+48s7qwMLmhwjK5xM0tNaJsi4iUz2U=;
	b=De3vQalXNmNn99Xw3ePAZim89tn6R5nYeUD6Md7ZEgC4nYFWhMd3YshLrAOqMPaT
	MrqaEm99mLNXKfESEtPK/fQ1j4bDncQp4zDKpwcz8yTt5171/UdzFG67cnVjXUHcsYW
	JK8PU5VWAkeSAdOSnYucvEYxeNBCICu2AHXta2wQ=
Received: by mx.zohomail.com with SMTPS id 1732828374531886.7951127970854;
	Thu, 28 Nov 2024 13:12:54 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] drm/panfrost: Remove unused device property
Date: Thu, 28 Nov 2024 21:06:23 +0000
Message-ID: <20241128211223.1805830-9-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
References: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The as_in_use_mask device state variable is no longer in use.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 -
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index fc83d5e104a3..b91957f886ea 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -117,7 +117,6 @@ struct panfrost_device {
 	DECLARE_BITMAP(is_suspended, PANFROST_COMP_BIT_MAX);
 
 	spinlock_t as_lock;
-	unsigned long as_in_use_mask;
 	unsigned long as_alloc_mask;
 	unsigned long as_faulty_mask;
 	struct list_head as_lru_list;
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 5e30888bea0e..95df39b463d8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -604,7 +604,6 @@ static void panfrost_mmu_release_ctx(struct kref *kref)
 		pm_runtime_put_autosuspend(pfdev->base.dev);
 
 		clear_bit(mmu->as, &pfdev->as_alloc_mask);
-		clear_bit(mmu->as, &pfdev->as_in_use_mask);
 		list_del(&mmu->list);
 	}
 	spin_unlock(&pfdev->as_lock);
-- 
2.47.0


