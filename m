Return-Path: <linux-kernel+bounces-261661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E3893BA73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65A5B213E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320297482;
	Thu, 25 Jul 2024 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mzrfesd5"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797863AE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721872658; cv=none; b=JoadvugbNcBOxWKlrrO1oWBraawRWxGR8Bj8dIIxDuu3GGilivePa428JN7QT9uzSQLhGWqptA8LSMzFi7663Q0wF7SsUU/iEoQl7u787FCbXBGnkLWN6V3dDJes+q7JWzm62IGyfC4KjqbVmeX6QTf/8UohoTFJ/6/NFeeqIRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721872658; c=relaxed/simple;
	bh=6Kr6YfDZ+YjgQEtFnSiNty625y77yuPmVgtpxjbMTrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m/dxKzXeVCBmf7gWQuOsDlg/FnmD6LF5tvdNGF+3YKyNUIkkGyTt+Nfjh0qFvzkXe93Mf7HmXKJ1CGGe9LOWUOdgRpI6BN5PLCCT/FNnCiK8MwxLl7Lc+0ZmrmkM2b2cYqwgNSQvZX44UFDWbSMCqBwDKFc2r3deaWH/R4fk1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mzrfesd5; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721872648; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hLBbEcnIh+1oprn+JujqfEAu3/3baKc5GVebY+RN8EM=;
	b=mzrfesd5aLDOJxX5mA9OI5VhkXvAGTgUEESGO8BBQ8Tdxnop8yQVMFjsjrcP+NMAmKqiQBf6Wxt4CIG6+vcYkn1ZIB1YfCftX0mB1N/fxib1Gxme+FWc0C45hwOjzYzbqdAKdHc/jU9Tker7oBiUEil22FCEd4crjuVfChU3z64=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBFtJ-M_1721872633;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WBFtJ-M_1721872633)
          by smtp.aliyun-inc.com;
          Thu, 25 Jul 2024 09:57:27 +0800
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
Subject: [PATCH -next] drm/amd/display: remove unneeded semicolon
Date: Thu, 25 Jul 2024 09:57:12 +0800
Message-Id: <20240725015712.50237-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:481:2-3: Unneeded semicolon.
./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:3783:168-169: Unneeded semicolon.
./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:3782:166-167: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9575
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 0b671c665373..e4a14d41fb85 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -478,7 +478,7 @@ static unsigned int dml_get_tile_block_size_bytes(enum dml2_swizzle_mode sw_mode
 	default:
 		DML2_ASSERT(0);
 		return 256;
-	};
+	}
 }
 
 static bool dml_is_vertical_rotation(enum dml2_rotation_angle Scan)
@@ -3779,8 +3779,8 @@ static void CalculateSwathAndDETConfiguration(struct dml2_core_internal_scratch
 			p->SwathHeightC[k] = MaximumSwathHeightC[k] / 2;
 			RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k] / 2;
 			RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k] / 2;
-			p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
-			p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
+			p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
+			p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
 		}
 
 		if (p->SwathHeightC[k] == 0)
-- 
2.32.0.3.g01195cf9f


