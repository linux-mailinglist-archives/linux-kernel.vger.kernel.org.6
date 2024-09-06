Return-Path: <linux-kernel+bounces-318076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0363696E809
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65E52851AD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C07438DE9;
	Fri,  6 Sep 2024 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oWna1yMQ"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B60288D1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592389; cv=none; b=FrzqzRUAq3RrkSVJfjiOFhzGb02z+Agl0plpS3+D9yWVatJ019/I8pbrgsM4xQtEBK/jOeFerTZxPfYH2nBsF/fDnMlNVa+40ViBoZjLq+R3ZqODDe2IWymqtYDH51MoNXFLuu6lU6WCXC6nKvQDOZ+VEeFMmsYU4U9oiTwysIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592389; c=relaxed/simple;
	bh=UTVWSXsP54JYzmOxlq1319p7G+NWR7+bLpOVkFG1KSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HIzBdKfA6D+oHHFfDNOtjiU+MC/aJAJefV4vQQPjiG1WJz5UzRQ5mNS5u+dq3kVu2KK466M1lDip8Ge+RDaI7/YnhYK+XRg9FSujpL6Sh+VL37aFBeBpU/JODD+p0S3X8f+ASM4Bd3ntsNG3aMuthFjGZuMDhS5130xDcUvWcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oWna1yMQ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725592378; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bop3mJ2S2jY8OuL0/42nc9QWoYknK6bfWbRN3vylRk8=;
	b=oWna1yMQ3hqxS/MO8sQT9QzK03pFmmYD7cZmc1kkG7GavYVU8/8bDT+K2P1wmq+HF1KD1F4QCAVSmhMRyqo7A+tOlwPMZyduh5CWFWmy8cceN4gLOApDLMoNaWMcmShccLLojoKs4yRyyv85EAMzKYf1THYxK7QTM2W6L8CKQbA=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WENtavF_1725592366)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 11:12:57 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amdgpu/mes11: fix bad alignments
Date: Fri,  6 Sep 2024 11:12:44 +0800
Message-Id: <20240906031244.126285-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:418:3-9: code aligned with following code on line 419.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=10742
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 0f055d1b1da6..ee91ff9e52a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -415,7 +415,7 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 		/* wait till dequeue take effects */
 		for (i = 0; i < adev->usec_timeout; i++) {
 			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-			break;
+				break;
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout) {
-- 
2.32.0.3.g01195cf9f


