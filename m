Return-Path: <linux-kernel+bounces-188226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF538CDF73
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7788B1F222C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B421103;
	Fri, 24 May 2024 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EqDofpJM"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9A3C0D
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716517183; cv=none; b=KFMcN/TkMSpIitRwzwzEdLxTPzRcj8J96e9SLltAoIYJl+eJ79vG6tF63YP1JvmwJmYDD1IP37kJ9d4/vT1iz6OXGZw6l9tcFPPdMCGo7gEYGyhBpemujSan46p+OU7Fl/SuU3Ud9aoVckvmxMzIAzUJzssddc7ETRr7MUgwqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716517183; c=relaxed/simple;
	bh=YMkvIdyK1FPzFcy7+m5rYTwS6JxxCwYLzZESggupPcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O9zZC1VFXnPEwhmY4PVEQk8c6EVjeHKseNjkuWB/9g6i8J09NG2COtBeVYba+/gRgYgsNMGkyaR50uR6eAIeG+G0oaSrvNIGDFQE6Fc5CEyeLh4I++r7ADnFmNqyXtUtP0CzajMPXc4ICbgICGPVVh1mLvPqIqUm9rAte0P8dbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EqDofpJM; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716517173; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=94kUBT2aVe0wVa4KACbP+/C6frYVHrHe3SSopoWJigE=;
	b=EqDofpJMCHtpjwOjKn3PHFZKKtjj9ws6SpmRsed0BRtMt2DfUL4/qctGL55zxwk2UTMdfxemyRbIx8h9HWdHjsWV74bYSYlnzLy85C6a6pki0QOL2AAlQI5LWgIwE1F9+y7Oa5RXbYiyBnw4/MTP5IWjIxF8Kzh0km3dhRI5gVo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W74Oeos_1716517162;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W74Oeos_1716517162)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 10:19:32 +0800
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
Subject: [PATCH] drm/amd/display: clean up some inconsistent indenting
Date: Fri, 24 May 2024 10:19:20 +0800
Message-Id: <20240524021920.95328-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:5200 dc_power_down_on_boot() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9166
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3a2101b052ea..4612c60edebd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5194,9 +5194,7 @@ void dc_power_down_on_boot(struct dc *dc)
 	}
 }
 
-void dc_set_power_state(
-	struct dc *dc,
-	enum dc_acpi_cm_power_state power_state)
+void dc_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
 {
 	if (!dc->current_state)
 		return;
-- 
2.20.1.7.g153144c


