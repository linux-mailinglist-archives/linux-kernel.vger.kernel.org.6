Return-Path: <linux-kernel+bounces-208002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9B1901F28
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85046284C49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3F78B4C;
	Mon, 10 Jun 2024 10:21:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F8A28EA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014883; cv=none; b=FfubsA9gsmU+fqxQGcLoXD1DFsFp64CMxHGtUjwKRF851NIaCNfSD9Al+N7GEJ5MWhJf8tvsPu82h6i6N8qoeXjd0FBp8JjDN8O7tdEgGk4wbPAPR5obxVsWT8trQ1p3qXfeMfLO79Lep0lw0XnUNVxUMzAcWh0byAYm4JzL0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014883; c=relaxed/simple;
	bh=89e8j3AIVoF+lup8Sg4ho+WBC6fyTJidQaEDObyz5Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MlsDevRxrkwBWkHH5d2QxLZhjPiUvspu7y7/uNqGwgbBFcC2jXz7TNDv1602wv28tUQNn9jG47Z8rxFpCcCzBsRmqcX5aeyYs/VbBBj8WDz2smTTQBnO/3/YqFo+MAR23ZLNvK2xnngeMw7a4MZulqK1rSyIZc0Onm2omw/Incc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06B9C12FC;
	Mon, 10 Jun 2024 03:21:45 -0700 (PDT)
Received: from e127519.cambridge.arm.com (e127519.arm.com [10.1.32.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 455343F73B;
	Mon, 10 Jun 2024 03:21:18 -0700 (PDT)
From: Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Smitha T Murthy <smitha.tmurthy@arm.com>,
	Deepak Pandey <deepak.pandey@arm.com>
Subject: [PATCH] drm/komeda: check for error-valued pointer
Date: Mon, 10 Jun 2024 11:20:56 +0100
Message-Id: <20240610102056.40406-1-amjad.ouled-ameur@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

komeda_pipeline_get_state() may return an error-valued pointer, thus
check the pointer for negative or null value before dereferencing.

Signed-off-by: Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index f3e744172673..f4e76b46ca32 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -259,7 +259,7 @@ komeda_component_get_avail_scaler(struct komeda_component *c,
 	u32 avail_scalers;
 
 	pipe_st = komeda_pipeline_get_state(c->pipeline, state);
-	if (!pipe_st)
+	if (IS_ERR_OR_NULL(pipe_st))
 		return NULL;
 
 	avail_scalers = (pipe_st->active_comps & KOMEDA_PIPELINE_SCALERS) ^
-- 
2.25.1


