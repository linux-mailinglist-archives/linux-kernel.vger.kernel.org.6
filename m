Return-Path: <linux-kernel+bounces-270323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA12943E77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4EC284271
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0421BBE7C;
	Thu,  1 Aug 2024 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Icxm2NPP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805131BBE6A;
	Thu,  1 Aug 2024 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472442; cv=none; b=cihQpIJi7uY7ghOAnHOyxXDVGuh8g0Bq6q/QU1hR6UCzD+dix5PBWS5ayCgcTp6htf/nRTbA1HGkESUcoLAApu3pNMKKgO8suXujhOMUbP445MlmGdqZ3dGYmNXY3IBkcjhqkDXyMy1n6FkOOYgMv+QxzNH0GpjIDji2/3TigWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472442; c=relaxed/simple;
	bh=CwkFyvuaoQvwfXqay87ZjHh586avz4GUIz6FJLmfe7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhJ4X4ZXXMuC9TIfU+/69sQ4AJArzw5huu1Ew+ClFr3YdNjlN2o8xcd3rXjCUNJezvm0hr6/s/FQlSk9A3EPEc6ttIN8AyAcPbsZUGjnzJSx4/pzDqF3Psq4o+S3HiqIuv9lNCt4dsTvqTn8ivDL3aUziL64cX6ht1mhXCGYBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Icxm2NPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F88C32786;
	Thu,  1 Aug 2024 00:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472442;
	bh=CwkFyvuaoQvwfXqay87ZjHh586avz4GUIz6FJLmfe7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Icxm2NPP/WLJZDgRcOgWPRE07NkO4wPdzhs5fX9MkkoJMgfVP1MVa/RnHdYXm1a95
	 brVFC4tOH6cJuMEl5NW3ia1jsHvwe8+QOk+FlMTO46cbK6itOXkX+F9SJPfda/bceY
	 ZDH+tWKP1whHZ70OS6g5O/4pLTPIqkAwP4yJbUkGGl2/7FwMcGWXS4LSHHPsffbQmD
	 wNEI3yo+qXDxmG+av1HfsTx8M5jACaT/8TgDYM2gFaDwyROWqybbhLxg2c8OkdniXI
	 j1QXXiqh/piu+tNwRleEWB3jHioZy5tshpVgeZ0HT46WBEXq6r3EfhafmGWCyq9LBe
	 iTAOD9UN91iZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	vitaly.prosyak@amd.com,
	shashank.sharma@amd.com,
	hannes@cmpxchg.org,
	andrealmeid@igalia.com,
	friedrich.vock@gmx.de,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 14/47] drm/amdgpu: Fix out-of-bounds write warning
Date: Wed, 31 Jul 2024 20:31:04 -0400
Message-ID: <20240801003256.3937416-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit be1684930f5262a622d40ce7a6f1423530d87f89 ]

Check the ring type value to fix the out-of-bounds
write warning

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 294ad29294859..de05b7f864f2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -263,7 +263,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->max_dw = max_dw;
 	ring->hw_prio = hw_prio;
 
-	if (!ring->no_scheduler) {
+	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
-- 
2.43.0


