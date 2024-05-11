Return-Path: <linux-kernel+bounces-176397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5FD8C2F1F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E67E1C213C9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0A7224F0;
	Sat, 11 May 2024 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="inEFmg9F"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED1374D9
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715395412; cv=none; b=VJRi/mPUnUQg7b/Ndcyjl12QO7sqXSt8e+nNK3KVIftsHwAMG3nziHGA+z5im8ARfzvEM0kZiakSeD1NwnqsW5ornKY3CfhOeS+omZJTwLpg5GtRJYdO6ey2s9vHpITztvQPgC0H/FL+CjNPWTItL3ZNDuEDmUIr8oA8OxyybS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715395412; c=relaxed/simple;
	bh=VSwbUJGChY15TEpAiP+gevIDGX/BalE9kM1SCBLbOEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FlyVd0NUA3h6qmwHIKMCSoNjTwQfI+7549uzLxtCsAJqI2OBxT//UeQ4wHBwokbMcJ/UxxUW2tzHmJ/B21uSx5Iu3nHWWdk603bKeC3jPT4X9NlCqDID/KOKavleOMYE9o+VyqQZiJhc/lA2nOGtnzKggug6kx83rtwNdv8Ij9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=inEFmg9F; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715395400; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xMWB7tcK9lh6tvkjem4+oVbLaB6u7ih0rPhd/ngxidw=;
	b=inEFmg9FitvymYcDonH+TUX3oHAQa3p4885bEAThVSINGDXNR7ZnA+3pbVAlYR9MABP/iW+iFJgIC7NxBOHEgj0UMrvC6KPqtJIIIBJfYPW01fnsKbojl9dnYce4DQ/Chh4zuaau+8eRF0iYcuVMNIlvg+NQI3SR0hHDT4i5t/o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W6BjtCT_1715395382;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W6BjtCT_1715395382)
          by smtp.aliyun-inc.com;
          Sat, 11 May 2024 10:43:19 +0800
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
Date: Sat, 11 May 2024 10:43:01 +0800
Message-Id: <20240511024301.81075-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn401/dcn401_resource.c:792 dcn401_i2c_hw_create() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn401/dcn401_resource.c:894 dcn401_hubp_create() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn401/dcn401_resource.c:1738 dcn401_resource_construct() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9002
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../dc/resource/dcn401/dcn401_resource.c      | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 75e2c62ae792..3e1bfddc6e43 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -784,14 +784,13 @@ static struct dce_i2c_hw *dcn401_i2c_hw_create(
 
 #undef REG_STRUCT
 #define REG_STRUCT i2c_hw_regs
-		i2c_inst_regs_init(1),
-		i2c_inst_regs_init(2),
-		i2c_inst_regs_init(3),
-		i2c_inst_regs_init(4);
+	i2c_inst_regs_init(1),
+	i2c_inst_regs_init(2),
+	i2c_inst_regs_init(3),
+	i2c_inst_regs_init(4);
 
 	dcn2_i2c_hw_construct(dce_i2c_hw, ctx, inst,
-				    &i2c_hw_regs[inst], &i2c_shifts, &i2c_masks);
-
+			      &i2c_hw_regs[inst], &i2c_shifts, &i2c_masks);
 	return dce_i2c_hw;
 }
 
@@ -886,13 +885,13 @@ static struct hubp *dcn401_hubp_create(
 
 #undef REG_STRUCT
 #define REG_STRUCT hubp_regs
-		hubp_regs_init(0),
-		hubp_regs_init(1),
-		hubp_regs_init(2),
-		hubp_regs_init(3);
+	hubp_regs_init(0),
+	hubp_regs_init(1),
+	hubp_regs_init(2),
+	hubp_regs_init(3);
 
 	if (hubp401_construct(hubp2, ctx, inst,
-			&hubp_regs[inst], &hubp_shift, &hubp_mask))
+			      &hubp_regs[inst], &hubp_shift, &hubp_mask))
 		return &hubp2->base;
 
 	BREAK_TO_DEBUGGER();
@@ -1735,10 +1734,10 @@ static bool dcn401_resource_construct(
 
 #undef REG_STRUCT
 #define REG_STRUCT abm_regs
-		abm_regs_init(0),
-		abm_regs_init(1),
-		abm_regs_init(2),
-		abm_regs_init(3);
+	abm_regs_init(0),
+	abm_regs_init(1),
+	abm_regs_init(2),
+	abm_regs_init(3);
 
 #undef REG_STRUCT
 #define REG_STRUCT dccg_regs
-- 
2.20.1.7.g153144c


