Return-Path: <linux-kernel+bounces-414950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F299D2F99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDBEB284AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886BC1D3562;
	Tue, 19 Nov 2024 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="P57nhXr3"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2B1D2796;
	Tue, 19 Nov 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048620; cv=none; b=SJX4z74d7X04yINoCJVdnw5BO6VsLQdkhLBvIUSvBvTThfEN+9ShYsBqT3yA5LtYMJRbGIO3dxfjx6lXSZKzIqXTfCYxayfD+H6QYlkkPkYDF0JsZAP73LuXbdZZpdQvpip0xhEOiQQyFuQca/DvqGE6gGsnrltqN0UH9Erq6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048620; c=relaxed/simple;
	bh=E7H4D9XjCwSSdzBU3c/DR11h3IehoLN6uHcPSFcznUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqyuqHsjridBd53ciBPLpuDNnFN721CBVHTSr9C0BRF6nxAMn85Eozg3UhNo3VvXoy5fa2PwYXP2FBlmy5ZTCsKGBaPGWrJ7/x1DPL+Ada95n43NAx7zqszsouo0TinyXFRwusgYWPRYwO9wvMIvf1YwFizG4VBLWowRskHhMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=P57nhXr3; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id DUxytSUZHgiuVDUxyt3ul2; Tue, 19 Nov 2024 21:36:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732048615;
	bh=ZhEWScZ9cqnOnTV9yj0gNXc3fVhx21n0ePBE8U68IHM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=P57nhXr38pLvajtcxUwpyqtxVAZnB3p7P873TOjBwuUwX2eTr9aw0DTGzJulbMwms
	 B6RqDI5XSi8xi+YjRLToHCFNSusSJ3RooJBgwq1RInVrUuNMHriQ66D5yuJIMTAN07
	 MIlTtWSqUA48jR1Rak662jtiUSWbGDWp1jsAM7ZwjkZkH/jj78KeBv3l2+1RBHobx5
	 z7O1tT6WOIZJ4q94OdrRbuomYk2ceHa55IOK0lKC3UfnZ9iKdBotJV5NRVB9HJjXf9
	 ooLVsD4qqPhS+/LJnj8t1JJfVl7Uuawy0kpdIL6nwyB0qMC70RqhY/4aqljtCkiZPi
	 ukkbxXnUm+mLg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Nov 2024 21:36:55 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Le Ma <Le.Ma@amd.com>,
	Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix an error handling path in amdgpu_device_xgmi_reset_func()
Date: Tue, 19 Nov 2024 21:36:43 +0100
Message-ID: <59760ee9c40003b50eac7fd08f20a6c3e3acf5d0.1732048587.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of error after a amdgpu_gfx_rlc_enter_safe_mode() call, it is not
balanced by a corresponding amdgpu_gfx_rlc_exit_safe_mode() call.

Add the missing call.

Fixes: c6a6e2db9945 ("drm/amdgpu: Redo XGMI reset synchronization.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This patch is completely speculative, review with care!

It is only based on naming where an _enter() function if not followed by an
_exit() in some paths but is in other paths.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0171d240fcb0..facb35249da0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3933,11 +3933,11 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 
 		task_barrier_enter(&hive->tb);
 		adev->asic_reset_res = amdgpu_device_baco_enter(adev_to_drm(adev));
+		task_barrier_exit(&hive->tb);
 
 		if (adev->asic_reset_res)
 			goto fail;
 
-		task_barrier_exit(&hive->tb);
 		adev->asic_reset_res = amdgpu_device_baco_exit(adev_to_drm(adev));
 
 		if (adev->asic_reset_res)
-- 
2.47.0


