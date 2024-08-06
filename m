Return-Path: <linux-kernel+bounces-276089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0EA948E3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256D61F23688
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18E41C3F1E;
	Tue,  6 Aug 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="R714CinT"
Received: from msa.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F71BDA83;
	Tue,  6 Aug 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945576; cv=none; b=CWhIBZoDy1IKfP0NI7N8MReC3ZBeUX9uBwwAIzdbhXligqrsN3bG2mEoviQT/7m10QdGBVAn3KFg7LEwl96Mj6dsWV9R9UINehzm9mYJx6SysRIAnABNhCdl/eDjcCIwIyQIF1BFHoNqWZxxi4G8G0q7kAWy6nURFRsCOS14vhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945576; c=relaxed/simple;
	bh=2RZDRULGNFQPGVSyiQ2Vvu5w8aDnL5CG79Bj6j7jxGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZC3qy0OhtEYM7CidB46oA0TENDl4iMkD01C+mNZJyTOjztKFujE3auSxxVwr34jNpbqpS2XLTFu7Z0MHvYcndjmXMV3fy2x4BeYRUSLBL+fsB8cLeaak9L7sJ7NWcIgitnOTbcvKsYy0cTCwETYFDpQaI8eM8uChYme6xH32Zio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=R714CinT; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bIqZs62idOGeabIqZs47Ch; Tue, 06 Aug 2024 13:59:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722945565;
	bh=mW9ZcWagssNfhkWbLgfoqDnd9YloaoRJ2fJF6CbDTio=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=R714CinTBNFgikHK9WQedEvyWA0fcKeRWugctGMHmpaNM6RiRZeQSYawLWnxCUTMn
	 EDlqGyyO4S3F4OM2/lMb8lnHoG43IYZ85kG78KfIPgN+fmAdX+hdZkmihZj8Be/eZa
	 o0fqmW/9vxkht2Qo1LPqJtm5/WE25rg26IrrLwtH1NTICmBjt36fvV5uMY2cnje5Q8
	 QbACgLu1Dsa1cEtKd1QDvNmOdEAYEU9Sgvwi6YhzSNszYOji2D1JvIclyMfgUJIRaG
	 VWATgQMciqNx5PjPoXjb+W4oxLHd2rtqioTmaYuCvJa2TR18uTXUJ22D0yhKAcpgnI
	 mZPtWLC2Tep1g==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 06 Aug 2024 13:59:25 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/dp_mst: Slightly optimize drm_dp_mst_i2c_write()    (1/2)
Date: Tue,  6 Aug 2024 13:59:10 +0200
Message-ID: <2705cf4c0df41f335cbe91bfd9984fcd95208788.1722945487.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'txmsg' is memset()'ed in the for loop below, before usage. So we can save
another initialization txmsg when it is allocated.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
In case of interest, on x86_64, with allmodconfig, sizeof(*txmsg) is 768
bytes.
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 379a449a28a2..7bf6157eb3a3 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5886,7 +5886,7 @@ static int drm_dp_mst_i2c_write(struct drm_dp_mst_branch *mstb,
 	struct drm_dp_sideband_msg_tx *txmsg = NULL;
 	int ret;
 
-	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
+	txmsg = kmalloc(sizeof(*txmsg), GFP_KERNEL);
 	if (!txmsg) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.45.2


