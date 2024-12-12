Return-Path: <linux-kernel+bounces-442468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF619EDD30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDA1161DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7257042A82;
	Thu, 12 Dec 2024 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MraSIfeh"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B73C38
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733968058; cv=none; b=RqtYwYDbERzDHDbccEWn4rIcPlIpM0Dfhtz+7+7tA0SQY9wUE4n/qcZnjuvTMAuXCaWMCNxKOqj8j+25nLTb3VYDlpLwV0aF3B+Tu5RtI7owPJTTpHbCCIx5ak87N/mdyBnfD/ZsGLTPiGumQY2YIRtJ3Oc0zX4Ha+tFdJ7ldnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733968058; c=relaxed/simple;
	bh=H2oOdkgf1KHP3tRs/kLe5rjuaHPg/00+31UJttts1qg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fj7oTDp0dNOa+JnvYf7rHd9XQw7VDOlCdOv/Z+ntARiaXzsJIj1Ter/SpR/vE3Go5iTnrKP4rt6Mei7i/g5ad6x3ykrUmArlr6jUJjCtj43a6rmy5Y0FKToJQtGw2v1JGChwEaxyGBpvpabMeAUNlKolW15txmUOtfEqEnB9/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MraSIfeh; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733968048; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Kqj9qK6jIh62y524FbW8f6U5KVgY1gRKxB0ZmR0iD0E=;
	b=MraSIfehPygJ3PGrLe81JW317bt3RLjGjsypmIzXUIVg4jWvEZw9/TMQ6rnZTCa+vvBRUydeQ2K+mpVmjSIeHnH/ePngiDqAhYvHAgpYd1q11hONWNNf4VkR4lBl+sWQtUrRgZMTjl4YiiiKEFgr5eTgyoJsBSmZtxicPgKGa8c=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WLJtAS3_1733968038 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 09:47:27 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: use swap() in update_phy_id_mapping()
Date: Thu, 12 Dec 2024 09:47:17 +0800
Message-Id: <20241212014717.14286-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing swap() function rather than duplicating its implementation.

./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c:185:47-48: WARNING opportunity for swap().
./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c:125:53-54: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=12335
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 309c7999faa6..6fdc306a4a86 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -120,11 +120,8 @@ static void update_phy_id_mapping(struct amdgpu_device *adev)
 	for (idx = connector_cnt; idx > 1 ; idx--) {
 		for (idx_2 = 0; idx_2 < (idx - 1); idx_2++) {
 			if (sort_connector[idx_2]->dc_link->link_enc_hw_inst >
-				sort_connector[idx_2 + 1]->dc_link->link_enc_hw_inst) {
-				aconnector = sort_connector[idx_2];
-				sort_connector[idx_2] = sort_connector[idx_2 + 1];
-				sort_connector[idx_2 + 1] = aconnector;
-			}
+			    sort_connector[idx_2 + 1]->dc_link->link_enc_hw_inst)
+				swap(sort_connector[idx_2], sort_connector[idx_2 + 1]);
 		}
 	}
 
@@ -180,11 +177,8 @@ static void update_phy_id_mapping(struct amdgpu_device *adev)
 						}
 					}
 
-					if (swap) {
-						aconnector = sort_connector[j];
-						sort_connector[j] = sort_connector[j + 1];
-						sort_connector[j + 1] = aconnector;
-					}
+					if (swap)
+						swap(sort_connector[j], sort_connector[j + 1]);
 				}
 			}
 
-- 
2.32.0.3.g01195cf9f


