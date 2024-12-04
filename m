Return-Path: <linux-kernel+bounces-432010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A29E44FA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6268BB81614
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE5202C23;
	Wed,  4 Dec 2024 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="MxDjWDBE"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558BB1F5426
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338253; cv=pass; b=h85m/5+D8V0/bD1Q19gOinpnX22CqerW2x9e2VfoZk4ehgGKKMtk9xaq2tdlTUeu1BGjW7uCBjwRWjhZPxrV6Ss5obvicS3C8I6vupad6TKThQnpFuMKLmeTSqbiIp0epahybmaXc6Br2PhqlsVkjmqIeoyRDMtcVaVjIyPl/wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338253; c=relaxed/simple;
	bh=dplq4x6BedNB5JheFQIXwPZGhbGv4xVl4+D/cXJcX2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaxW9qgALLjsY7fgJtBqKLWdLRMwIW1Nf3IYVI15tPa9USvAT+6srPlPtCBjYbsSd726wxCHgrVwaFTP6Fuo46SDej6JkVgqHMIxItHmZXyUEM4N/cBZXA6MDAsUMKSx8ow9loX+LpmsjCvsv9fCe1NoHcavsHytj3GAbp2PgIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=MxDjWDBE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733338232; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g5ov8K2zqxVSH2Z5IH9nRm+RGq78G57aQffUfuEklFccCLY629g/IsCfXWeY6ejsuDZTbgsYWl2VmTxMy2QimCNbEuWdn2IggM/1DAkaallb97R+scw2eJDwjhQ14eOiyh3sBTHQamvKmmh5mUtRF6EmFo2H+HHxoE5teBBrwFg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733338232; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ows0zJTgSZQ4scHFg0XOpHfquBwwawR0kxgR/lAiOQA=; 
	b=N/i4zihArNbnjW5roW11qwta/gCSQgCHugXLS7LWxjKdUDjCMwiX7yjnBKMRla02eeXjQQDzSoJGNMbEekq+65npAK4Ll3XsxhfeTfckhsgek6NAni33oHHqjaYl/EpkvSMdi609z0agsgtZAyHVRmk+CLGdpFdCCOu7NZOSmDQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733338232;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Ows0zJTgSZQ4scHFg0XOpHfquBwwawR0kxgR/lAiOQA=;
	b=MxDjWDBEMxm2eAtndg1+cEeULnvauw0VZd9aAkzEAIBby/5u7hVKtMWJvqbujQtt
	WKwYEsOtc06+BqjJfaHlShBaC4tACtwOgAcxNBTeZN+2qy+H85O4RqjeOQOD7KqAMc1
	HsBQWa3e4RZudV5JTVVyeylz7LeLuylEb6opWSuI=
Received: by mx.zohomail.com with SMTPS id 1733338231243207.3303468289498;
	Wed, 4 Dec 2024 10:50:31 -0800 (PST)
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
Subject: [PATCH v3 9/9] drm/panfrost: Remove unused device property
Date: Wed,  4 Dec 2024 18:49:38 +0000
Message-ID: <20241204184945.1477677-10-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
References: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The as_in_use_mask device state variable is no longer in use.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 -
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 30ce8cec1aa6..6aea214ca1f2 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -121,7 +121,6 @@ struct panfrost_device {
 	DECLARE_BITMAP(is_suspended, PANFROST_COMP_BIT_MAX);
 
 	spinlock_t as_lock;
-	unsigned long as_in_use_mask;
 	unsigned long as_alloc_mask;
 	unsigned long as_faulty_mask;
 	struct list_head as_lru_list;
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 2a6c60170109..6914018d5540 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -609,7 +609,6 @@ static void panfrost_mmu_release_ctx(struct kref *kref)
 		pm_runtime_put_autosuspend(pfdev->base.dev);
 
 		clear_bit(mmu->as, &pfdev->as_alloc_mask);
-		clear_bit(mmu->as, &pfdev->as_in_use_mask);
 		list_del(&mmu->list);
 	}
 	spin_unlock(&pfdev->as_lock);
-- 
2.47.0


