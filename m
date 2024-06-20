Return-Path: <linux-kernel+bounces-222217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E5A90FE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953011F24992
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEBF172BCB;
	Thu, 20 Jun 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GFVwhq9v"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5515251B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871073; cv=none; b=QH5oNQD9VuCKwGHfYqYKr/HVjdqpvLGKq0inwLsgSLeRn7gB65FCEcJwh46RsldCN+VhrwhU3KKmQ92hYySvzMPcjisiCv1YkIiZm2j33uOI4fnfeaDqiH7J3YLWP7+1xjvQx1KW2Whos7cckAvtPIuHwzmXMG3WzuhcOf0KK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871073; c=relaxed/simple;
	bh=Iq+O/VvPJY4UcpXtqyBEMgk+6K5n2GAJhKggQXI2HOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R/pIk3vbfiETwKoVs6vkh2dhwckfxaE3oaCg+9EBGh9M1Pg1DqE+UUB42M7zfsdO6wywLJu8G1QuU+k5M3XVVDqJPY3fwW95nX0rmwb/i/SuPZANNiMNaF0KqmZoRAWanB/ch/P9xpdSePY3pCjwHmcs7mAGiGlCoAhK7PQFK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GFVwhq9v; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718871066; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gLiv3pyD1fElUB0wAQIjj/qFPDkPz4q0no5seMRSoi8=;
	b=GFVwhq9v8AwXDI8sGyvgk9tgICkaugROqblE1QHhymgASGU9fn6sa9B8wKZqryYPEcCoGX8NcS5vaLx0RrW5of5JXZQ2c94yWPVQjEsAhsqz5svAqN+Odcpq3IyPkTUBh4p0A8L7MxXLyMq5gkLKUXSKfDi8O4pqpMlCmB43z3g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W8qf3Sp_1718871054;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W8qf3Sp_1718871054)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 16:11:05 +0800
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
Subject: [PATCH] drm/amd/display: Remove redundant code and semicolons
Date: Thu, 20 Jun 2024 16:10:52 +0800
Message-Id: <20240620081052.56439-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3171:2-3: Unneeded semicolon.
./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3185:2-3: Unneeded semicolon.
./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3200:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9365
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../dml21/src/dml2_core/dml2_core_shared.c    | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
index cfa4c4475821..1a9895b1833f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
@@ -3142,62 +3142,62 @@ static unsigned int dml_get_tile_block_size_bytes(enum dml2_swizzle_mode sw_mode
 {
 	switch (sw_mode) {
 	case (dml2_sw_linear):
-		return 256; break;
+		return 256;
 	case (dml2_sw_256b_2d):
-		return 256; break;
+		return 256;
 	case (dml2_sw_4kb_2d):
-		return 4096; break;
+		return 4096;
 	case (dml2_sw_64kb_2d):
-		return 65536; break;
+		return 65536;
 	case (dml2_sw_256kb_2d):
-		return 262144; break;
+		return 262144;
 	case (dml2_gfx11_sw_linear):
-		return 256; break;
+		return 256;
 	case (dml2_gfx11_sw_64kb_d):
-		return 65536; break;
+		return 65536;
 	case (dml2_gfx11_sw_64kb_d_t):
-		return 65536; break;
+		return 65536;
 	case (dml2_gfx11_sw_64kb_d_x):
-		return 65536; break;
+		return 65536;
 	case (dml2_gfx11_sw_64kb_r_x):
-		return 65536; break;
+		return 65536;
 	case (dml2_gfx11_sw_256kb_d_x):
-		return 262144; break;
+		return 262144;
 	case (dml2_gfx11_sw_256kb_r_x):
-		return 262144; break;
+		return 262144;
 	default:
 		DML2_ASSERT(0);
 		return 256;
-	};
+	}
 }
 
 const char *dml2_core_internal_bw_type_str(enum dml2_core_internal_bw_type bw_type)
 {
 	switch (bw_type) {
 	case (dml2_core_internal_bw_sdp):
-		return("dml2_core_internal_bw_sdp"); break;
+		return("dml2_core_internal_bw_sdp");
 	case (dml2_core_internal_bw_dram):
-		return("dml2_core_internal_bw_dram"); break;
+		return("dml2_core_internal_bw_dram");
 	case (dml2_core_internal_bw_max):
-		return("dml2_core_internal_bw_max"); break;
+		return("dml2_core_internal_bw_max");
 	default:
-		return("dml2_core_internal_bw_unknown"); break;
-	};
+		return("dml2_core_internal_bw_unknown");
+	}
 }
 
 const char *dml2_core_internal_soc_state_type_str(enum dml2_core_internal_soc_state_type dml2_core_internal_soc_state_type)
 {
 	switch (dml2_core_internal_soc_state_type) {
 	case (dml2_core_internal_soc_state_sys_idle):
-		return("dml2_core_internal_soc_state_sys_idle"); break;
+		return("dml2_core_internal_soc_state_sys_idle");
 	case (dml2_core_internal_soc_state_sys_active):
-		return("dml2_core_internal_soc_state_sys_active"); break;
+		return("dml2_core_internal_soc_state_sys_active");
 	case (dml2_core_internal_soc_state_svp_prefetch):
-		return("dml2_core_internal_soc_state_svp_prefetch"); break;
+		return("dml2_core_internal_soc_state_svp_prefetch");
 	case dml2_core_internal_soc_state_max:
 	default:
-		return("dml2_core_internal_soc_state_unknown"); break;
-	};
+		return("dml2_core_internal_soc_state_unknown");
+	}
 }
 
 static bool dml_is_vertical_rotation(enum dml2_rotation_angle Scan)
-- 
2.20.1.7.g153144c


