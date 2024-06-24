Return-Path: <linux-kernel+bounces-226600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD19140C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CC71F22F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E38748F;
	Mon, 24 Jun 2024 03:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p2rJNopE"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C244C96
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719198727; cv=none; b=AXRHA9eg+MSUPTBDMSR+7szGwNCWP28eA5b81tmzQymIhwfXL1Teg3+8aXnHYu1YpReebw8uEpzBaJrSuJVkLf73n/cCWj80Qi+C2pIbFKNE2VjznmvEN3GEhih3D9XeqvvdbF5sM5dwTdjyzBjW68tO3wPLlw2ivUAVla7IMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719198727; c=relaxed/simple;
	bh=s5eSxh3w5ru8v9B7MPhDa91a374easaRZEOALaDA1so=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dtPdIKRK/yo+dHnpRT/31vG4j+9kal8FV9sjBXPghrcFf9Lqxraouysfa/68/GyqyxyiGSY+/HCb3bB4OmMT1WxK8s3n89VFmjqSNztw1cgQ46qWCVf12yMqh9vW1dkqsOOIWbaeqfBYri6kbyWjN50rrBtMjEPN6kK9p1XdAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p2rJNopE; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719198722; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=h/k/C2qs1pKcv+sRC2nv2zMOr9MwmxizBcFEz86gVOo=;
	b=p2rJNopEd7iWvJly9K0f5VwSwixke9OHgrAbWTVrPH8EZkR9sUtt5KEeqKMLDgcA2U4YI+UgDvGWI4qkYDXSKD+kd0pmZvjHP0AR3pHbmYhl5oU6U6NYwfJV7mIVqy03vey+QnWpG6ErHvZjdAKhJEC+5usIAZxjscPdkjuAUCI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W916qKp_1719198719;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W916qKp_1719198719)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 11:12:02 +0800
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
Subject: [PATCH] drm/amd/display: Use ARRAY_SIZE for array length
Date: Mon, 24 Jun 2024 11:11:58 +0800
Message-Id: <20240624031158.98502-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of macro ARRAY_SIZE to calculate array size minimizes
the redundant code and improves code reusability.

./drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c:164:45-46: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c:183:47-48: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c:237:45-46: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c:257:47-48: WARNING: Use ARRAY_SIZE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9405
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 1b2df97226a3..7ecf76aea950 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -161,8 +161,7 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 		return MOD_HDCP_STATUS_DDC_FAILURE;
 
 	if (is_dp_hdcp(hdcp)) {
-		int num_dpcd_addrs = sizeof(hdcp_dpcd_addrs) /
-			sizeof(hdcp_dpcd_addrs[0]);
+		int num_dpcd_addrs = ARRAY_SIZE(hdcp_dpcd_addrs);
 		if (msg_id >= num_dpcd_addrs)
 			return MOD_HDCP_STATUS_DDC_FAILURE;
 
@@ -180,8 +179,7 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 			data_offset += cur_size;
 		}
 	} else {
-		int num_i2c_offsets = sizeof(hdcp_i2c_offsets) /
-			sizeof(hdcp_i2c_offsets[0]);
+		int num_i2c_offsets = ARRAY_SIZE(hdcp_i2c_offsets);
 		if (msg_id >= num_i2c_offsets)
 			return MOD_HDCP_STATUS_DDC_FAILURE;
 
@@ -234,8 +232,7 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 		return MOD_HDCP_STATUS_DDC_FAILURE;
 
 	if (is_dp_hdcp(hdcp)) {
-		int num_dpcd_addrs = sizeof(hdcp_dpcd_addrs) /
-			sizeof(hdcp_dpcd_addrs[0]);
+		int num_dpcd_addrs = ARRAY_SIZE(hdcp_dpcd_addrs);
 		if (msg_id >= num_dpcd_addrs)
 			return MOD_HDCP_STATUS_DDC_FAILURE;
 
@@ -254,8 +251,7 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 			data_offset += cur_size;
 		}
 	} else {
-		int num_i2c_offsets = sizeof(hdcp_i2c_offsets) /
-			sizeof(hdcp_i2c_offsets[0]);
+		int num_i2c_offsets = ARRAY_SIZE(hdcp_i2c_offsets);
 		if (msg_id >= num_i2c_offsets)
 			return MOD_HDCP_STATUS_DDC_FAILURE;
 
-- 
2.20.1.7.g153144c


