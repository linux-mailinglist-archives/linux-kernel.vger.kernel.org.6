Return-Path: <linux-kernel+bounces-571097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2684A6B918
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4174485AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BED21D3DD;
	Fri, 21 Mar 2025 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="qYsti1BO"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B21F17EB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554365; cv=none; b=NLpqYsgDFci4drRzOb6rNYkwsAijHPnh4JTpEh8fDaRf0wz+YxXv9sK9J3eU8ykwcs4Db+2R8wqhcNSHs9unvGaujBXGOZYC5M2DTiHLTEcF/cYgIjveqUBI+vIMehM2TwQDhCaJ56eIjftIkT6aouLeFS3BIFBjFGYo6bDvCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554365; c=relaxed/simple;
	bh=arM2P0BqqOLwmqD5UyzLygYFgCoLIP9JlIa2W0xeKSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5ODD43pTdclyKO4V3mYtBfWFRn9KLeAUjIA8XsaWMhKP0aGM1WBftY0MtCd2JlQ+ROYjDqlQRsBHz7ZzkLXUhL+ADl6KoneT1XDBS0GWe9DZ3ZysuivmxDUEX29JzeJpyTlHneaRIOAmGxJV47jRyOOJRuVVkw1eH08z+irX/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=qYsti1BO; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1742554360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UU/JcHwDnP3QhY6ZpYqh86qRIlavKskpUsk2dt6mvLU=;
	b=qYsti1BOpbwSEu3jnaF8AotVFXZL95h0urNJC1Spu2nCDYOiGw/g68JvbiQM0VovQQUm4s
	TEOCpsLpokE27ffGL7j7X37pzpCqfuzh9t/e1F49xlX8qdjoxKmxnSQ145TtxMNdofRkTm
	Qu+Vrv4V4E1tJr9tEYoXdzggvFRDlr0=
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Ma Jun <Jun.Ma2@amd.com>,
	Kun Liu <Kun.Liu2@amd.com>,
	Boyuan Zhang <boyuan.zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 2/5] drm/amd/pm: Prevent division by zero
Date: Fri, 21 Mar 2025 13:52:32 +0300
Message-ID: <20250321105239.10096-3-arefev@swemel.ru>
In-Reply-To: <20250321105239.10096-1-arefev@swemel.ru>
References: <20250321105239.10096-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user can set any speed value.
If speed is greater than UINT_MAX/8, division by zero is possible.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b64625a303de ("drm/amd/pm: correct the address of Arcturus fan related registers")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 8aa61a9f7778..453952cdc353 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1267,6 +1267,9 @@ static int arcturus_set_fan_speed_rpm(struct smu_context *smu,
 	uint32_t crystal_clock_freq = 2500;
 	uint32_t tach_period;
 
+	if (!speed || speed > UINT_MAX/8)
+		return -EINVAL;
+
 	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
 	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT,
 		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT),
-- 
2.43.0


