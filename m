Return-Path: <linux-kernel+bounces-272068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D49194567F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D1928823C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2B61C698;
	Fri,  2 Aug 2024 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y436ndEi"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94C1BC4B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567595; cv=none; b=YFisSJYEpfFXqoQuow87K0qU/mwxJ2fM+bIxAC1oBpfLCXYphnB/5orKl0I3wH0CJjd30kDv/VONh/L6qPURevO+sbybuKH8HoEEQuJk7stcPVZcdmZ+HzIT+Si/JwhmPwmf8cB/zmn0g/+4EqDeD4ZdefrD9Y8bgeGO/KWS8Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567595; c=relaxed/simple;
	bh=7YzdKodQalNTaCMpvtdtLnW5bxxelLzotMjh5/LpH+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hz5up9B/si93VoVyTA6s2zsHpNYyU04yp+xQ15FS6NqrsP0m5mFpqxeyQmSaX5ReCEXRrStjIdHrPE64nHmtR7abiQ1/cam5/4xTZciLYbwr9mCEhpxTdflO7oZroRLp8hwQvozJm9Y+H9aqgWp67UcyfqCaQwkfUoebQ/BFS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y436ndEi; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722567591; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0kM025x32/0+5dTxxuOpGxTdKPJ7pjJl/LKjasSay0I=;
	b=Y436ndEi16m6hH5Qdvuq/NSFGni9dKUz9ytdzrrrwLPmoSEu79cFyKq39Cvsx0dT6ridFlDYQ4Zwcl9EO17xdTT3MnXt8M+8XLW/fV3btRGxqk/jwvSRsoz9MOsFNwqE+5QCOIu6ng+jGTSz3be6Ac81mWWFhKEquXbnBOVlmoE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WBvhqXh_1722567582;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WBvhqXh_1722567582)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 10:59:50 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: chaitanya.dhere@amd.com
Cc: jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
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
Subject: [PATCH -next] drm/amd/display: remove unneeded semicolon
Date: Fri,  2 Aug 2024 10:59:42 +0800
Message-Id: <20240802025942.62734-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:6463:166-167: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9633
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
index c54c29711a65..8f3c1c0b1cc1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
@@ -6464,8 +6464,8 @@ static void CalculateSwathAndDETConfiguration(struct dml2_core_internal_scratch
 			p->SwathHeightC[k] = l->MaximumSwathHeightC[k] / 2;
 			l->RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k] / 2;
 			l->RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k] / 2;
-			p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
-			p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
+			p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
+			p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
 		}
 
 		if (p->SwathHeightC[k] == 0)
-- 
2.32.0.3.g01195cf9f


