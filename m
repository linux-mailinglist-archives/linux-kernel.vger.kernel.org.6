Return-Path: <linux-kernel+bounces-235534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D2991D64A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9051C2110A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168CCC147;
	Mon,  1 Jul 2024 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G/iomdoR"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0CE5680
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802252; cv=none; b=pkjg91QHKzBBIQHTwGjFfaQrcFBxqjaeYY1V59MmDQLi6Fh/u3ihCAKcXr1U6SIMYwpkVaNz9ISFL5oSpp001SsRA2fDWmQRnhapXhfVvd29iiZJnyhGedORc2dR1+ccvF+Vyr00TcdzD8pYRebr9DqRaozHms7LmjBNcLaMCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802252; c=relaxed/simple;
	bh=PhxB7h9+rAVsxPxv3weZala7Ei1zrbTh6VfYRngV/3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tjUwV7XWIDt+Eg5AH24Cm6zlPEeLe0J4jwN4d0AKdQfHzYT+w9cdedOM7Nd3mKA+m/Qvi0a6oIRWxHGBD+WaDxggh4vRC3LVDfTvVVPRHdUIfMqzQhs+Cryo8qJmYff9wZNRVichCHqV5shSRturaT2v743E8VpHMVaYv/lIxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G/iomdoR; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719802247; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dKbWEdikIBy/xGxcnPx9urGn8RKhAvsJQ96ZeCNi8Xw=;
	b=G/iomdoRyIt7dc7uaTcSNVJ6bfV0e78xFnPLabezIRjqsfb7kL6/UBLttibp1QHPqzW4ycP/xPThC1QJMXcYhu6q5Zz4X6SYvBJifbOcSHJItQvejK1coKCRDC7xi1ai7cl4StWbEnXhrUdIvBso4OH3apC5yyTCQf526lc4RBU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W9XECIo_1719802230;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W9XECIo_1719802230)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 10:50:46 +0800
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
Subject: [PATCH] drm/amd/display: Fix unsigned comparison with less than zero
Date: Mon,  1 Jul 2024 10:50:28 +0800
Message-Id: <20240701025028.36072-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value from the call to dml21_find_dc_pipes_for_plane() is int.
However, the return value is being assigned to an unsigned int variable
'num_pipes', the condition if(num_pipes <= 0) is not rigorous enough,
so making 'num_pipes' an int.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c:318:6-15: WARNING: Unsigned expression compared with zero: num_pipes <= 0.
./drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c:360:6-15: WARNING: Unsigned expression compared with zero: num_pipes <= 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9454
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index c310354cd5fc..9d96a31419fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -280,7 +280,8 @@ bool dml21_validate(const struct dc *in_dc, struct dc_state *context, struct dml
 
 void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx)
 {
-	unsigned int num_pipes, dml_prog_idx, dml_phantom_prog_idx, dc_pipe_index;
+	unsigned int dml_prog_idx, dml_phantom_prog_idx, dc_pipe_index;
+	int num_pipes;
 	struct pipe_ctx *dc_main_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
 	struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0};
 
@@ -314,10 +315,8 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 		}
 
 		num_pipes = dml21_find_dc_pipes_for_plane(in_dc, context, dml_ctx, dc_main_pipes, dc_phantom_pipes, dml_prog_idx);
-
-		if (num_pipes <= 0 ||
-				dc_main_pipes[0]->stream == NULL ||
-				dc_main_pipes[0]->plane_state == NULL)
+		if (num_pipes <= 0 || dc_main_pipes[0]->stream == NULL ||
+		    dc_main_pipes[0]->plane_state == NULL)
 			continue;
 
 		/* get config for each pipe */
@@ -356,10 +355,8 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 		pln_prog = &dml_ctx->v21.mode_programming.programming->plane_programming[dml_prog_idx];
 
 		num_pipes = dml21_find_dc_pipes_for_plane(in_dc, context, dml_ctx, dc_main_pipes, dc_phantom_pipes, dml_prog_idx);
-
-		if (num_pipes <= 0 ||
-				dc_main_pipes[0]->stream == NULL ||
-				dc_main_pipes[0]->plane_state == NULL)
+		if (num_pipes <= 0 || dc_main_pipes[0]->stream == NULL ||
+		    dc_main_pipes[0]->plane_state == NULL)
 			continue;
 
 		/* get config for each pipe */
-- 
2.20.1.7.g153144c


