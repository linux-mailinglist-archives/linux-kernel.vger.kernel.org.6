Return-Path: <linux-kernel+bounces-306037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7568E963849
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187D31F237DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67638FA6;
	Thu, 29 Aug 2024 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FTQlL2lA"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46431F94C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899347; cv=none; b=cQKih7hxX7uSuDak5tZlLcvzRXTQAlzT8V7AEueLLoFaivh012NxVA3tj1JA1VitZbRNhcs/hkbk2CWcTFugUp3s8nxy/rrgcQuN8iAzXBSJ2cCsMlvGaeiCofuP7EnNIQYGE+kmjQ/IvNApQ4DrhH3UJhaiGfdQkLFQuO77B0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899347; c=relaxed/simple;
	bh=wNwCA+QfjEzwl1Z3eviD6tmcBkbFGyEvDqAQKeeWnhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pxdi8pZaLH+vrDcBsEl8djBpBH4YhIHXpZsUpbjnL5dfFiw3dn+cFnNyMDB5j8EL6+Fo0BpFPtEjGXfno2TsNXn5makU1/CWXoL+vj3FI0qqOmqH9peeMkRGTaIarLg1oV3qVDCnh4Q5VF1DNxBdGkkCsn7TXSlqnJrWNkXVxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FTQlL2lA; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724899336; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wMQwFo6g6tszV+9ZlBCy+iOoyHhp9U9JGEfN9QAnmGc=;
	b=FTQlL2lA8oD2EEQOWzmx5ouFI8NRivbuPMFDk87VinvRlbxbGNN5QzMZFerwg42ZDldkTaamVlqKo+wrea6MC6zMrS8n+0TfWGV+nccrsvO9Dpz83mXsmj35zHW3pthUk59wR4ps4X1/NAci9G7zO77rGlmPY33BBf3eSboJra8=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WDrLx0U_1724899015)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 10:37:05 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: Remove the redundant else if branch in the function amdgpu_dm_init()
Date: Thu, 29 Aug 2024 10:36:54 +0800
Message-Id: <20240829023654.20884-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assignment of the else and if else branches is the same, so we
remove it and add comments here to make the code easier to understand.

./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1871:6-8: WARNING: possible condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9829
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e14c0c060e1b..71624917c475 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1868,9 +1868,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		init_data.flags.disable_ips = DMUB_IPS_DISABLE_DYNAMIC;
 	else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS2_DYNAMIC)
 		init_data.flags.disable_ips = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
-	else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
-		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
-	else
+	else /* The branch cover "else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)" */
 		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
 
 	init_data.flags.disable_ips_in_vpb = 0;
-- 
2.32.0.3.g01195cf9f


