Return-Path: <linux-kernel+bounces-342329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B98988D9C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30591C2189A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02FE1917DE;
	Sat, 28 Sep 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ls3uGU9J"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0B3190671
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727491239; cv=none; b=AdyvhGY6/TTsDFF/4Z6yqtKgSf0RpWFuB/uaoV3QAZXH4vFDyDx0uHkKMKsV1sXfFhs/UlLplCakhGr+aZmUrRaC1xEMsvEZs8UaV7G1ASQxTSEbDZ5VsS01bq59VGWdkQwgdelTPIO0TW+OaeWB9xzp7a7nfIS2Rgkh1ERrjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727491239; c=relaxed/simple;
	bh=64qfS1EE5wjBUpQHKrIT9D7kQLs6UILsGxCkIIwJe10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fucNDLeN/kFrc4V9b4Y2V9ybKN8afGrj/5vLZSSGrPpPqeF44FNdbKorByTuuSv2TLprqkgGDC6DNxaQxxYlYB3F+CWkB5Ycox+e8+oytRCBnk6buxmRR0eFAJIGpAx0GF3RotdpyaluKBdVUDRo+oDFi+Cs09uVpvjWsiis5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ls3uGU9J; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2054feabfc3so26762445ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727491237; x=1728096037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LnTsq4VEfa3DVUeX5+2WsJ45Yn/L9lDZxQSrrKE2Knw=;
        b=Ls3uGU9JSRq6povHEOpxNtIZ6X7mVXizE1AnwF5aOK7P+GNOmzJnm4HRn7qAdZE5UY
         KYLkkcd0p73Oevl2cNwDBWF5u0NXYQYXakJgF4jgUEQbPt3hmM/PFq6u+IhtjHw0a+Ki
         GSKDajsz02LjOu0zdGRSYbzPfSNOCiTjX9x5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727491237; x=1728096037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnTsq4VEfa3DVUeX5+2WsJ45Yn/L9lDZxQSrrKE2Knw=;
        b=AQC/+vi8crh6e5i0TEML0Zvr3A+K75dk8C9WOCcmq7e6hJWilN/EkbJ5KVdj038ojh
         iguGu0W2uN1eMmLT2pEJVhw2/3iIt9UkRTt0aG6u7+Rwoq8/nSwRxdGC/vNaF2hJ34DF
         GgwR23zKFvp3gCLuIcTDSugN4YFBwOP8FYAMzWsECqHgMowsOD1mlwY0ZizGjdIV0Bsr
         ezo/h4E7/LgONyAs+M07IVFI1Zq04f5OwhkGjaRKpeU9MG/kIXygepLjaBYyZ4tPCmGu
         zNnInO9AcDP5y7W9rKCfLUzCiToYtdjxrdLLa2+JWRTLCnFf/YqQJF6FA9oxXJSHEHbu
         nDpA==
X-Forwarded-Encrypted: i=1; AJvYcCWvt1mPc2ePQVqGjuboHoA2Mjd3WYAEf4igY7pddqQenfT/tOgmYx/Db6DT47mJEErG/8hboBWNSxZVh5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OekyAf0UzBkIP6ATCeW3JigeY1AxE5g2fUPcQigOOfvc2ayD
	D05PNW2UumMB9Ej8PmosguCyXjTXU3RwqBP2VnVL5aShgFEUBlRj9Nd2ZTp+AQ==
X-Google-Smtp-Source: AGHT+IGMtSlIL5dzrEwafO9gPcWiqC1NF4q8PhLQ4Zacu1bMXW87bbHAECMzRgIokClUg8/fjODRog==
X-Received: by 2002:a17:902:e884:b0:201:efe7:cafc with SMTP id d9443c01a7336-20b36ad291emr91904655ad.23.1727491236778;
        Fri, 27 Sep 2024 19:40:36 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e50c2esm19434185ad.235.2024.09.27.19.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 19:40:36 -0700 (PDT)
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
Subject: [PATCH v6.1] drm/vmwgfx: Prevent unmapping active read buffers
Date: Fri, 27 Sep 2024 19:40:27 -0700
Message-Id: <20240928024027.154907-1-shivani.agarwal@broadcom.com>
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
[Shivani: Modified to apply on v6.1.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c  | 12 +++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |  3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index c46f380d9149..733b0013eda1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -348,6 +348,8 @@ void *vmw_bo_map_and_cache(struct vmw_buffer_object *vbo)
 	void *virtual;
 	int ret;
 
+	atomic_inc(&vbo->map_count);
+
 	virtual = ttm_kmap_obj_virtual(&vbo->map, &not_used);
 	if (virtual)
 		return virtual;
@@ -370,10 +372,17 @@ void *vmw_bo_map_and_cache(struct vmw_buffer_object *vbo)
  */
 void vmw_bo_unmap(struct vmw_buffer_object *vbo)
 {
+	int map_count;
+
 	if (vbo->map.bo == NULL)
 		return;
 
-	ttm_bo_kunmap(&vbo->map);
+	map_count = atomic_dec_return(&vbo->map_count);
+
+	if (!map_count) {
+		ttm_bo_kunmap(&vbo->map);
+		vbo->map.bo = NULL;
+	}
 }
 
 
@@ -510,6 +519,7 @@ int vmw_bo_init(struct vmw_private *dev_priv,
 	BUILD_BUG_ON(TTM_MAX_BO_PRIORITY <= 3);
 	vmw_bo->base.priority = 3;
 	vmw_bo->res_tree = RB_ROOT;
+	atomic_set(&vmw_bo->map_count, 0);
 
 	size = ALIGN(size, PAGE_SIZE);
 	drm_gem_private_object_init(vdev, &vmw_bo->base.base, size);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index b0c23559511a..bca10214e0bf 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -116,6 +116,8 @@ struct vmwgfx_hash_item {
  * @base: The TTM buffer object
  * @res_tree: RB tree of resources using this buffer object as a backing MOB
  * @base_mapped_count: ttm BO mapping count; used by KMS atomic helpers.
+ * @map_count: The number of currently active maps. Will differ from the
+ * cpu_writers because it includes kernel maps.
  * @cpu_writers: Number of synccpu write grabs. Protected by reservation when
  * increased. May be decreased without reservation.
  * @dx_query_ctx: DX context if this buffer object is used as a DX query MOB
@@ -129,6 +131,7 @@ struct vmw_buffer_object {
 	/* For KMS atomic helpers: ttm bo mapping count */
 	atomic_t base_mapped_count;
 
+	atomic_t map_count;
 	atomic_t cpu_writers;
 	/* Not ref-counted.  Protected by binding_mutex */
 	struct vmw_resource *dx_query_ctx;
-- 
2.39.4


