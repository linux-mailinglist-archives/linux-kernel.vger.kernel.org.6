Return-Path: <linux-kernel+bounces-530338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB0AA43235
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6820C16E543
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FF11CAB3;
	Tue, 25 Feb 2025 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IfjXErYg"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E393D6F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445358; cv=none; b=KC1CUZIs++SRURASscU20cyBri+D1XKfMy8bZA2PYQp0E/2o/9n9ec25E4jEQ3to2xhmE+SxQwJs9PbNqCKPqMPugZ50EthFMPH1C87L0MpVnKg9QZhB5vTzPmnSsJDbnyBPu39I8O7Qqn7OKmbNAm9s7Iozfd4x1KrWeG7E5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445358; c=relaxed/simple;
	bh=BLF89FTJgLtqVPy5ZQ78HKhffkNe+07YlFwdyQtRWgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nCLSSV5Fc4KR5HCjaQIBm5FRNc1vWhX+YzFSS6W7FJegRqjyIj3j88qR+1aglFPO4Xolwt098Ng2yBfJnZ+0sxMYZgi/mZP0NGU4ekKLcN1OhCTnG2jtzRqyk7BPkyYPd59FwQFpqPcQC5TZZFhbk3JhuXw4q83oQEiPVlBAbWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IfjXErYg; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0+Y4hJZRDmSs2b1VJTCcj1/rup869Y150tqh1F9h3YY=; b=IfjXErYgZF2s8h42o9Jyyt5NKt
	GF/Loj8aTJZuz7jfhvaYqp9AttTkY5cAuHBsOsYyuP7QpK7sCE8uMi4hGuDz3R2yWa1ASZnRZP/Ub
	zvBIOh7q9VS+NQF/iTY6d72qoZgYZf+8yLHgZlP8E0nxL7saAXTgpgq+OClKuK7GSvcIbYzydh1h5
	rzGa+HUvaJMqNiGKh4QqVFejW875vCs8iEj03o2qO260JdDwDon7W6/ewkgZTx/WIVRH092TviQ9L
	VIaTgU6RO2zw++UDoVO9wEKzY4WTKyLBxg9xt8MJLZjhUxIlGaDe34loRwYhtEtGNz3cdyrAaFlQ+
	3OBXAm+A==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tmjL5-000B7k-CR; Tue, 25 Feb 2025 02:02:29 +0100
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
Subject: [PATCH v3] drm/amdgpu: Trigger a wedged event for ring reset
Date: Mon, 24 Feb 2025 22:02:21 -0300
Message-ID: <20250225010221.537059-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of only triggering a wedged event for complete GPU resets,
trigger for ring resets. Regardless of the reset, it's useful for
userspace to know that it happened because the kernel will reject
further submissions from that app.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v3: do only for ring resets, no soft recoveries
v2: Keep the wedge event in amdgpu_device_gpu_recover() and add and
    extra check to avoid triggering two events.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 698e5799e542..760a720c842e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -150,6 +150,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_start(&ring->sched, 0);
 			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
 			goto exit;
 		}
 		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
-- 
2.48.1


