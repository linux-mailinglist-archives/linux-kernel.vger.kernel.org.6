Return-Path: <linux-kernel+bounces-524220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D5A3E0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AD63AEE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A552E1FFC6C;
	Thu, 20 Feb 2025 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NnH/72Wv"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F271FECD0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068890; cv=none; b=dbFibmOJS2pczumQCyu03L8lHVEAeOLaG6lp70M/Ie/zREFpNLN2QzxwKYk0KH+4+uv4y/VlRpLkwzKo5k87JpoFd4xs95ETqu56pQFOrWodfZ6aH4FEMWMZtDa6KAGsJpRMRjw2Cq7NjFKices+b7FYo6QzV9RVrrYMNR11RoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068890; c=relaxed/simple;
	bh=J7jOFtCEi3z/7nMpBeWMwvuNyIgS4EfrSDcnyuVTzQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuuASwL4oD58XFxcPNwMh0HySO2lUvaQ9Lm+SWkxmLhxVbAYSW0kc4bbYx8t3wRL8J2ENZZOeAA4CkA2he4uh2+IgSg0RBz7c5lWC9l5Aa7AFDWTFbXWPt1qy6FIUESh9DUh+Rl53K7K7Ju6z1o4bsg/9T4geOgA3I4u13oz/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NnH/72Wv; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ibxwp58rc1qLo1AzHdEATpCd0qbT2QQXNMoY80Fcx+A=; b=NnH/72Wvb9ZbGpv6QXZBaUTTXd
	KEn4vW3q3iART7GCdHNzOgCLxjVHkrxK0VWLNdbmw8G4uLNQ7XJbwLkE1m2lqYEmb2ombWCH89esJ
	wiQBjWmGnGmCSvAEAigaCf4bPwlzalfrI4yiiNLiEiEUjyew+/o+l/jEUGjr1vu29b/7WiAUCsqkj
	4uDaMHV1IaBC4fIc7AyMxvScc9CLJVf0NwYb9KhXDQ+rojzMiS1cHOG1I0Noocd8pYQbmMO4zHGDI
	SxNEhqDSD45a6eF9wJeJZv//3/K2iPBZ0Jur7P4GN7RPXa8pJLxdQiRkIdnmco0GNJe0raGIWI7ih
	5/wHJCcA==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tl9P2-00FS04-Ci; Thu, 20 Feb 2025 17:28:02 +0100
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
Subject: [PATCH v2 2/3] drm/amdgpu: Log after a successful ring reset
Date: Thu, 20 Feb 2025 13:27:49 -0300
Message-ID: <20250220162750.343139-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220162750.343139-1-andrealmeid@igalia.com>
References: <20250220162750.343139-1-andrealmeid@igalia.com>
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

Reviewed-by: Christian König <christian.koenig@amd.com>
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


