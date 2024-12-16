Return-Path: <linux-kernel+bounces-446712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DD09F283F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5835164F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614C17BA2;
	Mon, 16 Dec 2024 01:53:19 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DD8821A270
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313999; cv=none; b=nadfMU0tPxOdku9cCCZCZh2bhG9MD6uEt/0JLLEXDxNc8RsoCSnPxtnUSyljdi8YJoySO0H8QsOs/cBvff7H/9BlCVU9rqRs928ZTz93Tsd43KaRWDTfGe9Jx+0XcgOAJsvI9IivGS+ZiPctCZo0BmbFemyfh65SOT6Bv1rO8XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313999; c=relaxed/simple;
	bh=MHExey71DvbX2FzUy+CYbbSC5lBAvMy5xZ3u/UhAsxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ic+LPznZ8g5F7CXvZbywCIkRHjZgKupjjzKTMFxQschg9C/t/VMKm9TKKcl2E2XcD43d67AX53R/Qn6I8BYHnuZIKtcQDx7gB/LJqCRbnYw3aF4lgzxnb2/xfSek2KOwEY3ji9QU7O3zVe/KJDIlcZ0WevlXOKx/CdB1dOahvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.3])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id B1EE860272AA8;
	Mon, 16 Dec 2024 09:53:02 +0800 (CST)
X-MD-Sfrom: zhanxin@nfschina.com
X-MD-SrcIP: 103.163.180.3
From: Zhanxin Qi <zhanxin@nfschina.com>
To: kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Zhanxin Qi <zhanxin@nfschina.com>
Subject: [PATCH] drm/nouveau: Fix memory leak in nvbios_iccsense_parse
Date: Mon, 16 Dec 2024 09:52:46 +0800
Message-Id: <20241216015246.141006-1-zhanxin@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nvbios_iccsense_parse function allocates memory for sensor data
but fails to free it when the function exits, leading to a memory
leak. Add proper cleanup to free the allocated memory.

Signed-off-by: Zhanxin Qi <zhanxin@nfschina.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
index 8f0ccd3664eb..502608d575f7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
@@ -291,6 +291,9 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 			list_add_tail(&rail->head, &iccsense->rails);
 		}
 	}
+
+	kfree(stbl.rail);
+
 	return 0;
 }
 
-- 
2.30.2


