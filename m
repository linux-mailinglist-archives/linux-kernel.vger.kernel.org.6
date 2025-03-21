Return-Path: <linux-kernel+bounces-571099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2820A6B91F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225EC485CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95331221F0D;
	Fri, 21 Mar 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="FpBOv7pr"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788921DE3CE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554367; cv=none; b=kpqKLSWr0mwT61g5k6dV6PEPvW8hyFgQvOERvOeOhhF3gi69yA62mbXwzzM4IeayUqnUhlUqFgciifPFMns8Ght/2kQgPW2Snl7b0TGb5dq5j3F3WLu/5kUzxHKckCVLHtIzGH2f0jptjDrFZh33QuO+UhNRhWOPQkvMlzMgu1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554367; c=relaxed/simple;
	bh=RsWXoOY3HuTMJh9XWhJMQLkhJWmH+r/OeG3dx7qLpbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GijAyKm5GoECP77ZLNtiRWqCNcvasMSp/719CTdCkRCOA2NCxqm7h+9LMNCMHOUYcjnTSoQSq4Quywz9EoDE5cZdCjsBYBEopiF+dc035i/i27lsZAqxddpmbOx31Qw1XYKEg7ThykcDJmKdM12mgUjJjoqj1EqSz0i0i0LbKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=FpBOv7pr; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1742554360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvpqCQCTIL/irkBTCko20zB4MVQJhWO59Civqx8GygI=;
	b=FpBOv7prCJ7GYfuNLDXHhV8cZcGnZmmoHghZBJUJpXY0ZIekQMkG48ktfMqCajLm4ZjTAM
	MhdtAk5gbdKgPgUb7YX4CapZpKikLZWt4JSl6zCy16oNN9RuehZ+TVGjHU0vdxqRv0gyAr
	VBv12wunqtvnQ34EfPhaKbiFyoDMGn0=
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/amd/pm: Prevent division by zero
Date: Fri, 21 Mar 2025 13:52:33 +0300
Message-ID: <20250321105239.10096-4-arefev@swemel.ru>
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

Fixes: 031db09017da ("drm/amd/powerplay/vega20: enable fan RPM and pwm settings V2")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index a3331ffb2daf..1b1c88590156 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -191,7 +191,7 @@ int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 	uint32_t tach_period, crystal_clock_freq;
 	int result = 0;
 
-	if (!speed)
+	if (!speed || speed > UINT_MAX/8)
 		return -EINVAL;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl)) {
-- 
2.43.0


