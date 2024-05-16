Return-Path: <linux-kernel+bounces-180753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9368C72AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD331F22729
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A638D80031;
	Thu, 16 May 2024 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rKEBNzkG"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0ED3D967
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847747; cv=none; b=rMoBPO1ZuC1fFrBh/Mj08wRdPTb5KCuhfPb3pyvDoGSzNAbJuO2bh7xuPJSmJYDM1PjQ+NUcBWo5Vyb3FzBrHOnjz9uR1DGoqtll4hM911Uhb9AHInhKwju9tRnJRuwSPz+kUzAoBo6+5pWgFUU77f6xHFfUO23/Z4mvGDI1ZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847747; c=relaxed/simple;
	bh=+xdKdUJGo+5OV1dRsOqF59gGrLXOvPdhrRKAtaXJPKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mSuHK91Elu68YlaVjfCctRYvFhlQipb5H5FjAyuYxAXhmSDF+F8YawbXCvB8lXJ8lnxYDPqZE+qbFTpAhBtMN1aw1HFmWuAPTgyCSy2Q610DQfaSsjZw+mWi7iFV5o85gTbx9L59wjIOsFi6uilQURB6J2kPc2gfy6Ken0uF2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rKEBNzkG; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715847742; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Rn8X2ZcroC9rYW7bPabg6ynfGxjz9SeFEr4CBKg7Ggs=;
	b=rKEBNzkGAoMsfncSJH6DvE5UVC3ICgARC8BBE+TLSnBlkFKAgYqRvtp29v3k7oriEeLQtEf0DvZTvBvaoPCX5OB1HDZzPt15sF807gQSOrEZZO1Uv5yvnC+ZfrOH206xinZLrYBZmv6ejzr/mSHmClC6Wo7ryLvGm8Tpjt8IWv0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W6aiyKM_1715847721;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W6aiyKM_1715847721)
          by smtp.aliyun-inc.com;
          Thu, 16 May 2024 16:22:21 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu: Remove duplicate amdgpu_umsch_mm.h header
Date: Thu, 16 May 2024 16:22:00 +0800
Message-Id: <20240516082200.73480-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/drivers/gpu/drm/amd/amdgpu/amdgpu.h: amdgpu_umsch_mm.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9063
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1a14e0101dac..bfae3c17e9bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -112,7 +112,6 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
-#include "amdgpu_umsch_mm.h"
 
 #define MAX_GPU_INSTANCE		64
 
-- 
2.20.1.7.g153144c


