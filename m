Return-Path: <linux-kernel+bounces-322183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BCA972565
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5381C2274B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6BA18CC1B;
	Mon,  9 Sep 2024 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYA3xRZL"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F4E18C35A;
	Mon,  9 Sep 2024 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921697; cv=none; b=tBWjIN8mDs9ME1F6QiPIpYPIzA+HHk1eSajOkO95fQhQfjSO5z4X5215ZInG+Udyxuo13G87QdyVLSjlXozRL7aRYjNlPDYYp3WQdedsF3nKPb21Xf/tp06leu7rjfEL7boeamdDpihOOfcWnGeC75LGb4vTTEKh0AZIDnnaPic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921697; c=relaxed/simple;
	bh=rU6TMkAvyYHwCKbTi+qGusCsU16Mu89jy4D5rlAvExE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOki7LhF920pntq/XT0p+ZP0W1dLpU9hNkouD+lpOJjsumBbNgwnwnF8E+JRGAj5U+xXBOb/3lDYIibfPkfbgysswNPm5ilut0yBh7qQrFl2iUe3ipzjdd86cIZ36Xqh6NlpjlSA0xIu8PTeWon7u7diMKtaZbV/cnu6TtUCgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYA3xRZL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so1582365e9.3;
        Mon, 09 Sep 2024 15:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725921694; x=1726526494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Czccy5fQseI/IqoQS9L/TpwH/mxQYjj8nomGHBFfYmk=;
        b=TYA3xRZLbmUMwRUbpm94+tzW2waKtqXuWBzAIjmrAYhz5kU815k8NkK0JGF+QhqhM9
         S1q52chEOYju5rI+uIvPBJZaT1pQOstaccWChXmSs81BYuSgB9SaHr1pq2A5lO8HA2KV
         03TqwRGzFAo2Qb7yBdltrr+TzRsM9weyjvtTey6cjRv8gi3VLxMnGICeLcjAbcDmq31V
         JNtExwXUIJiYiimAfJtWRHppMqln6mdfLArFxbhsctFU6Vy5RE/jA03Uuz1dXlOPgF0A
         nTEy9XsAbuFlv4ouOwcJBq2x3/6A3/zvXJgnvBS2n8leGM75KucRsXGCaHe2Yfjaxh5V
         DRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725921694; x=1726526494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Czccy5fQseI/IqoQS9L/TpwH/mxQYjj8nomGHBFfYmk=;
        b=GQS3DavmcwEEeGxNCLTi2SqiY8vEbmnlGweVk2TNoewIVVj4g63/QpPuAyt5FP3ArS
         qTddAwXtzfJ/u4dLVPq9LW2n2dKevtEE+QrZ07htXgk5F7eUiX5YEPAHQZZZCl/auISV
         Qx+aEHRm9I6LbfsCQDAAs+1yiBpnwAnFbi0webTaxGkSFXaOHy8KBskKgh13GZGF7yQM
         eNAnzn+JvYtbMfE2jyNEL2nQlSXoZU365ozmk1zTHHjzEcxeYdGybXaN66nvK7cjiSVK
         +w1BRE0LVVUOwUHbHr3sfNGhA8k1eDBDe21dqykRjtbjtJy6Oo6+EoeVnk/ROg7N2K2V
         Lcrw==
X-Forwarded-Encrypted: i=1; AJvYcCUSUJTJxtLaGrGHjdXZUlgunvofL3XiSYPV9QmSUjDj9K56LSX19jQHoMU+eFqvV/fIhUvA/sYZWfEwKod2Yl4=@vger.kernel.org, AJvYcCVF3ceBPJ92aBRGJIdX1gveztI569vuwrD5ResNSqrxVKKU8c/X2Uq9wNJASrJr3dOU0fj9Em98Rt53kswW@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8wyo7DxdBIvq9EX3DhpAXqy5K4K3KX/NMLYpTFTg8jcqYqt/
	7sXW+4N2tiBj2BMIDBU9/wRk0CAWMDydG+1n5q93j5FtosISw9yQIZJwZJSO
X-Google-Smtp-Source: AGHT+IG66+N4aswIJh7BoLAZq9oScW41fFewcBVIDHfk1+X70Qo4RhWHc9z3rRKiXcZ0ip/VIixKQA==
X-Received: by 2002:adf:9b89:0:b0:374:b363:2dea with SMTP id ffacd0b85a97d-3789229bc11mr6426973f8f.10.1725921693172;
        Mon, 09 Sep 2024 15:41:33 -0700 (PDT)
Received: from void.void ([141.226.14.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653c6sm7098887f8f.32.2024.09.09.15.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 15:41:32 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Candice Li <candice.li@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	"Stanley . Yang" <Stanley.Yang@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] drm/amdgpu: Fix a typo
Date: Tue, 10 Sep 2024 01:41:05 +0300
Message-ID: <20240909224122.14780-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index aab8077e5098..f28f6b4ba765 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -58,7 +58,7 @@
 #define EEPROM_I2C_MADDR_4      0x40000
 
 /*
- * The 2 macros bellow represent the actual size in bytes that
+ * The 2 macros below represent the actual size in bytes that
  * those entities occupy in the EEPROM memory.
  * RAS_TABLE_RECORD_SIZE is different than sizeof(eeprom_table_record) which
  * uses uint64 to store 6b fields such as retired_page.
-- 
2.46.0


