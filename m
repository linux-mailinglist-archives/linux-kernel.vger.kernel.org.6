Return-Path: <linux-kernel+bounces-342328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A33988D9A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688B91C20B74
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2D41917DE;
	Sat, 28 Sep 2024 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WQ0QUphe"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D5190671
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727491160; cv=none; b=Q3zOo8XKdHrhWGx5lUfVTZLE/sfEPdphbAeV5xqIjUNPxm+cyG40abRtAwgrz61crGfSEcsXSFZaGTa4rYrK8ElNM7NFT/mxzrmQirB51zV9oD7H/oGjyCi07WGyRt0MPuCmGoffKzoI2HZ4PTHgWzX+wTAz/Un/oPOmplpA8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727491160; c=relaxed/simple;
	bh=jBnmVpBmqA3KYcLiWyYPQdvDA0CZoBzVKsSxJ4WRCb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k/9Xsjq4lWukbrqI20ifkdZsYTCmmuLt3i7/kxj8FXFiuxzSxnyD875UrCRXDHsXuJ5otFcBTvPMEusNbgn+c0t1MQjm3/3thzrPSUclcyEDej8Pgd6QiHOJmRw2fO8dIbCpW8/P0UL16xvEcA/XI2grUedrPiVrSY0DcWZKwyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WQ0QUphe; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-719b17b2da1so2077393b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727491158; x=1728095958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZT9Gm3S6q8DxsqjZ2Rp3vkP4roxjo+MNxY+Zln4d6o=;
        b=WQ0QUphecT7p7S65ZXVf8QaU9mfbZMU/M8ZUNwx4kqTqawH9q1CL/+ckU53uiehxE3
         5tifNcrIKeyq/g0zUh+TCpWrNjdxeYxKBNrjhkN9B8SF4xrLDylVML7BNt5XdpgQx7Xr
         UAfWEWWZ/mFKMaYsWhT+C+0N4fFU6Pta/WpHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727491158; x=1728095958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZT9Gm3S6q8DxsqjZ2Rp3vkP4roxjo+MNxY+Zln4d6o=;
        b=cBGXCJsv4h2uQUXzO8EGN/XV1en7QGfS1VEKI6W5qA/tV4C0nD6ISf9z1p1InN4yjb
         dObziRlsODH+mIVk+2pelfGVLdJIbIAJVakZfPTpwm3LQ55dcyhhiVDVNPswnWpeWNec
         ExTmhf0qMmCWXnPAE9LP/gzkj2tg/riKMmLeGYt/NaDtwKBU9lzM5fsvykFzaZ+qAz/M
         N0QNFR6ubUfsKt3a8bMiNyrFVu7odjqroaW5c2o6uJKlSnFqsHkRz9f05mADgbcyyida
         aYKorMDLMazSXgV8EB/RvRkKs5aeBlfb/puL9kIxvYWo7wZh/UEaMZAFTu/iT4cWnNhG
         P45A==
X-Forwarded-Encrypted: i=1; AJvYcCWY1ABtDfws3DRH3JBUwQPsavKTPRYxYH8B/QVl1c3ZFXsHjQTSPzWsjVrUXRvA7d204mAJGnTWNhJwc4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gTkPn8nR1VHv30RwqvyDeHRyXAFBz0azXiAhuHoNQ5BXwSpC
	vuzVSDvWjyQusrGdawx8Tbw82mTIb27voISnMmt+KwpqOsA0jdJfiA89i470sQ==
X-Google-Smtp-Source: AGHT+IFKS7D4fABzjLCVOL0jPF/qivnq4j2bKZDUVAsulCQwvpOLfV216FHbRIKYyK6JEesnwc2drw==
X-Received: by 2002:a05:6a00:c88:b0:710:6e83:cd5e with SMTP id d2e1a72fcca58-71b25da6fb2mr9431095b3a.0.1727491158092;
        Fri, 27 Sep 2024 19:39:18 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b7dbdsm2267550b3a.53.2024.09.27.19.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 19:39:17 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.c,
	krastevm@vmware.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Martin Krastev <martin.krastev@broadcom.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.6] drm/vmwgfx: Prevent unmapping active read buffers
Date: Fri, 27 Sep 2024 19:38:55 -0700
Message-Id: <20240928023855.154766-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zack Rusin <zack.rusin@broadcom.com>

commit aba07b9a0587f50e5d3346eaa19019cf3f86c0ea upstream.

The kms paths keep a persistent map active to read and compare the cursor
buffer. These maps can race with each other in simple scenario where:
a) buffer "a" mapped for update
b) buffer "a" mapped for compare
c) do the compare
d) unmap "a" for compare
e) update the cursor
f) unmap "a" for update
At step "e" the buffer has been unmapped and the read contents is bogus.

Prevent unmapping of active read buffers by simply keeping a count of
how many paths have currently active maps and unmap only when the count
reaches 0.

Fixes: 485d98d472d5 ("drm/vmwgfx: Add support for CursorMob and CursorBypass 4")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.19+
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240816183332.31961-2-zack.rusin@broadcom.com
Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>
Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Shivani: Modified to apply on v6.6.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 13 +++++++++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index ae796e0c64aa..fdc34283eeb9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -331,6 +331,8 @@ void *vmw_bo_map_and_cache(struct vmw_bo *vbo)
 	void *virtual;
 	int ret;
 
+	atomic_inc(&vbo->map_count);
+
 	virtual = ttm_kmap_obj_virtual(&vbo->map, &not_used);
 	if (virtual)
 		return virtual;
@@ -353,11 +355,17 @@ void *vmw_bo_map_and_cache(struct vmw_bo *vbo)
  */
 void vmw_bo_unmap(struct vmw_bo *vbo)
 {
+	int map_count;
+
 	if (vbo->map.bo == NULL)
 		return;
 
-	ttm_bo_kunmap(&vbo->map);
-	vbo->map.bo = NULL;
+	map_count = atomic_dec_return(&vbo->map_count);
+
+	if (!map_count) {
+		ttm_bo_kunmap(&vbo->map);
+		vbo->map.bo = NULL;
+	}
 }
 
 
@@ -390,6 +398,7 @@ static int vmw_bo_init(struct vmw_private *dev_priv,
 	BUILD_BUG_ON(TTM_MAX_BO_PRIORITY <= 3);
 	vmw_bo->tbo.priority = 3;
 	vmw_bo->res_tree = RB_ROOT;
+	atomic_set(&vmw_bo->map_count, 0);
 
 	params->size = ALIGN(params->size, PAGE_SIZE);
 	drm_gem_private_object_init(vdev, &vmw_bo->tbo.base, params->size);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
index f349642e6190..156ea612fc2a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
@@ -68,6 +68,8 @@ struct vmw_bo_params {
  * @map: Kmap object for semi-persistent mappings
  * @res_tree: RB tree of resources using this buffer object as a backing MOB
  * @res_prios: Eviction priority counts for attached resources
+ * @map_count: The number of currently active maps. Will differ from the
+ * cpu_writers because it includes kernel maps.
  * @cpu_writers: Number of synccpu write grabs. Protected by reservation when
  * increased. May be decreased without reservation.
  * @dx_query_ctx: DX context if this buffer object is used as a DX query MOB
@@ -86,6 +88,7 @@ struct vmw_bo {
 	struct rb_root res_tree;
 	u32 res_prios[TTM_MAX_BO_PRIORITY];
 
+	atomic_t map_count;
 	atomic_t cpu_writers;
 	/* Not ref-counted.  Protected by binding_mutex */
 	struct vmw_resource *dx_query_ctx;
-- 
2.39.4


