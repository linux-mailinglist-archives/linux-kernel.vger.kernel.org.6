Return-Path: <linux-kernel+bounces-569661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B235EA6A5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C56188E381
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A85E21D3D6;
	Thu, 20 Mar 2025 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="nAWRDq1Y"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971AD21CA10
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472090; cv=none; b=MYtkhlv9cFRAsnbcmiFHydd08/LeY5LHJZox2YB/BB9kwju+e8d2fDQ6tKrg408WvgR5QFsx4D8DQ/lvVD0+cPZ2kQYluIOKmxdv3Jq4QG6lvhaUyquX1+bWG8UiEImy43C9cZX5NwctLl4HdedWHV+9V3mEVFwAF+yCV9P4h50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472090; c=relaxed/simple;
	bh=G390ayVAeJLNqsYi8OOBX8AsMHvZT1+q2T2m/GCKkcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsE81umapRqQ9AGEmwf+es4LO1WfP52YXoGgX5k/7qlajsWsGIttLBfOxPcN0+SqwEGBZuiigo8K4B52cdAqm4MIUBXGbdLVlx0iNzhrvJ8QNcPUh7x96bZYa0n60ihpl/m9Mrpet/Fme7qZpRoVjBDU0/Yggmss2lFjb5mSSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=nAWRDq1Y; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1742463330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Um6DJdCZsfO6iMseqDk5neXt8a8oIsDXItojtZ5OxA=;
	b=nAWRDq1YfDoB5lXs0yYrVWyzFT0EcjdpxDB+AbHI4KraBR4mkUVdh7J3qIb2gUJgmnlN+a
	E9MvATib/qnxuQ3R/ZG+Ke9kC+jD45p6tiC5GKM5vyLoZgCuL4m7u++ygjA/PfsA0r+N4J
	K8L3a0JUnIBwvHHqml7pisxW5EUk/hI=
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Ma Jun <Jun.Ma2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] drm/amd/pm/smu11: Prevent division by zero 
Date: Thu, 20 Mar 2025 12:35:02 +0300
Message-ID: <20250320093517.5247-1-arefev@swemel.ru>
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

Fixes: 1e866f1fe528 ("drm/amd/pm: Prevent divide by zero") 
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 189c6a32b6bd..54229b991858 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1200,7 +1200,7 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 	uint32_t crystal_clock_freq = 2500;
 	uint32_t tach_period;
 
-	if (speed == 0)
+	if (!speed || speed > UINT_MAX/8)
 		return -EINVAL;
 	/*
 	 * To prevent from possible overheat, some ASICs may have requirement
-- 
2.43.0


