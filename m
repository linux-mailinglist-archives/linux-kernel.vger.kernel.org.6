Return-Path: <linux-kernel+bounces-341909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428D7988833
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A17B23A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50BC1C1722;
	Fri, 27 Sep 2024 15:21:52 +0000 (UTC)
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5141C1728
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.5.119.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450512; cv=none; b=EobcbKsL71IhccZP7VeOBflpDf/3orGu4HXYWo+AD3UCvp48cByS/BNP5xO1NSQBJdPlLhiqjOatkLG69o0Qm92jc1fAOicU39iNaXHLvaaPNm6mmf2J9ESpLkOES0sGWecXWVgH4S3vEVvYcniovXcurjGRfHDgkSWpn4ne7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450512; c=relaxed/simple;
	bh=FI9V+wxk/x84eMs2AhP4pnJCI867ACh7mMcOxkq6oYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AJJe3NIHwBEVf9jYvKH1/yVzRxajJ0l/LTlHHWKqhODOTYZwEQVcHZpLXIIQXVdKKUdb6NKRFK6zcq8dHK1Jhl3pE9FOhoEs1z51vyoeMzlHpoYTTyQ+VD4NcJdFlutvOWkVeXIoPUkrpViOkfHAW4/74OlxlJhoxq760q52t04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru; spf=pass smtp.mailfrom=mcst.ru; arc=none smtp.client-ip=212.5.119.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcst.ru
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
	by tretyak2.mcst.ru (Postfix) with ESMTP id 54A76102397;
	Fri, 27 Sep 2024 18:14:43 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
	by tretyak2.mcst.ru (Postfix) with ESMTP id 4BDC0102396;
	Fri, 27 Sep 2024 18:13:58 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
	by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 48RFDvUI004638;
	Fri, 27 Sep 2024 18:13:57 +0300
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()
Date: Fri, 27 Sep 2024 18:07:19 +0300
Message-Id: <20240927150719.1432625-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
	 bases: 20111107 #2745587, check: 20240927 notchecked
X-AV-Checked: ClamAV using ClamSMTP

It is possible, although unlikely, that an integer overflow will occur 
when the result of radeon_get_ib_value() is shifted to the left.

Avoid it by casting one of the operands to larger data type (u64).

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 drivers/gpu/drm/radeon/r600_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index 1b2d31c4d77c..ac77d1246b94 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -2104,7 +2104,7 @@ static int r600_packet3_check(struct radeon_cs_parser *p,
 				return -EINVAL;
 			}
 
-			offset = radeon_get_ib_value(p, idx+1) << 8;
+			offset = (u64)radeon_get_ib_value(p, idx+1) << 8;
 			if (offset != track->vgt_strmout_bo_offset[idx_value]) {
 				DRM_ERROR("bad STRMOUT_BASE_UPDATE, bo offset does not match: 0x%llx, 0x%x\n",
 					  offset, track->vgt_strmout_bo_offset[idx_value]);
-- 
2.39.2


