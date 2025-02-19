Return-Path: <linux-kernel+bounces-522532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71FAA3CB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE91189A919
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1F2580FD;
	Wed, 19 Feb 2025 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Nuw0LJRZ"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0304C257438
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000941; cv=none; b=k8Aa+1hnDDXxP6BLarnlkzvbFl5vRB917yxBhVrPz3O6bBX63ysyhaqlYDBBkjLPDp0DugV3iAJLXDprljnrpq4s/AqxhCOBzMfFpiHrqb2rA4J1DDwB4kaa+Y9OrRo+WqYQI2k9/QckY8QGaL/oacdcHiKUcX6XcaDo4U4g8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000941; c=relaxed/simple;
	bh=T1erbIKuNvZ1/nMX0Ngy5uAZGIVDqrZP5fNW2Ttm25A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FP6Z7hUUZ22iykdEnPUL29W13He9rlNKLBOfiHGXCh5CNUogpEo7k86FU41zsBUJTRRohpyA6Gj+LGvHIZTU5LjL56ubEOIw28JgsG80q37YaUYryWvtXj/IHaMBNmSx1XYzr5rTC5FckXbMuU7LQE/Oxfur3aDJwqTWmDTT9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Nuw0LJRZ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iwq57pgU5eH9DcXYUU5567uzianHf1TSEbwFS1hNRQo=; b=Nuw0LJRZXEWbexoRiCAkFfNA6y
	3J5+7kNAbe7oTczEBF19sv3aQApDEWnZ/BpE0KHaY5iKnp3ejBdoz9zCMx8HPWJM5q/OzxHiBM4ZC
	WCWmuNnHs4btWDc+HdJXR2+sD7JEUq7YEopM82i9Rbkdj6nzk9p72cDwGmM1PLtahf3ZTA3d8qKKv
	02fsGlfzG0W5uxzOONEqwomkY9hbzEeO3TCWSnciHQuBHfhM0xXslznFhMJbTW9saiBSemf6awjbR
	ENjfCU+KS41Xj3uDj0PXUUxej2s7d3WP5RgUUpiMc1O1v1HSVky7iXOrsFPa7jS724QXbGRk5/MoA
	YN2b/DQA==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkrj6-00F1SN-MV; Wed, 19 Feb 2025 22:35:34 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	siqueira@igalia.com
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 2/3] drm/amdgpu: Log after a successful ring reset
Date: Wed, 19 Feb 2025 18:35:16 -0300
Message-ID: <20250219213517.281556-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219213517.281556-1-andrealmeid@igalia.com>
References: <20250219213517.281556-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a ring reset happens, the kernel log shows only "amdgpu: Starting
<ring name> ring reset", but when it finishes nothing appears in the
log. Explicitly write in the log that the reset has finished correctly.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 100f04475943..698e5799e542 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -149,6 +149,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			amdgpu_fence_driver_force_completion(ring);
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_start(&ring->sched, 0);
+			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
 			goto exit;
 		}
 		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
-- 
2.48.1


