Return-Path: <linux-kernel+bounces-524219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1EA3E0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B0C189EB13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67920FA98;
	Thu, 20 Feb 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qjEAszV0"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8CDF58
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068886; cv=none; b=JsjN8PnCdRjeHZ6j7xnG2ArQu0MzdkBMg8vN9MM2A9NCFNUbSUwou2QSpUpTQOrKvk8K8zZEhEq0s6rCwD1vTJfJh3E/+a06/NgOAiX2I5iqtIZBFZI2Sy9jROGryKIyeVR8FtPwTw6QMqY5x2pc2ISE7fnCgZps/kFs2De3OGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068886; c=relaxed/simple;
	bh=EuSanmI/JMLVqwXkEWfAfRYUMX8hKTjSivcvZls0EbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foawpJA9bpxgYIR6oTK+k0mF5GCZDsOJVq0yymGbU5RdlO44wqN1E7/6znYtXovuNhqiN/UAkDm21oH2rM8sOWAhgctfGCUqba1AbBv/oGcAfbDch8bckB+kMGnH6D4rHfmPhhK83+Le/b5LZ0kU+8FtFZkhKnzUW4+HTS4+ogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qjEAszV0; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bp0PWENFDQt4d1lhlNW9z0EZ975rNKseh6asfm0CJ28=; b=qjEAszV0qxkvupuuBpEC/x95Yw
	BgElk3REL5tfygvk0ppu5z4PIY93VrJykZWhF9gkh3K4qfFZpQt+Vc0x7uzz1NrQGMCleFEoBUJPK
	thLpzegtH0Y7lXGEwM0G+8a8zycCzuz4msrbP/GzbpB1rQueXNG3611D7V8gqyF802mzgKZYHq2Gk
	ceU/QlLbC2xXfztiE1BNBUeF/u9HbskCt97h22g6+llmPKPhjFCRn3MKF0I2LxoNQhsNi6V2UWypG
	PMkf+yjtAphlWZL1uVLQYt61hEoreVWYl/0xCUStIJ8k84MiH9ySIbfd9EkGCgbSAAaJoh5TQDWuV
	SL4xsCtw==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tl9Oz-00FS04-HF; Thu, 20 Feb 2025 17:27:59 +0100
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
Subject: [PATCH v2 1/3] drm/amdgpu: Log the creation of a coredump file
Date: Thu, 20 Feb 2025 13:27:48 -0300
Message-ID: <20250220162750.343139-2-andrealmeid@igalia.com>
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

After a GPU reset happens, the driver creates a coredump file. However,
the user might not be aware of it. Log the file creation the user can
find more information about the device and add the file to bug reports.
This is similar to what the xe driver does.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 824f9da5b6ce..7b50741dc097 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -364,5 +364,9 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
 		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
+
+	drm_info(dev, "AMDGPU device coredump file has been created\n");
+	drm_info(dev, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
+		 dev->primary->index);
 }
 #endif
-- 
2.48.1


