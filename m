Return-Path: <linux-kernel+bounces-281973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B9B94DDAD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 18:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5571F2187C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AF15FCED;
	Sat, 10 Aug 2024 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVFv2VKm"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C767C8D1
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723308472; cv=none; b=cp70ML1i2sm00P/lGhf4hVBRk4uNtcKwMLJYx1AkB1retiadzeYiv1ni6+F4wBTzFBSfcRmCnT8TK/5ZzBMdc6nPL/a1vmlPwABLHVn2b97sPN1UIa1+NX1LpR8Na15tlmyQWXk7GvHlPEaRnwu//3v1gBNF99Wzz4R3+YQtgbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723308472; c=relaxed/simple;
	bh=KEKBkS8OQGlVzmCvH3VAGpyB9NOC2i1C8cgXMsQIAXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvwQx9ea6nePyP3VJrTKEKlyQzf3Jo8AqsnQXVrtMGQI4E5/Ci0dJTFB3jnmTA7AuFMGUEl5WfUGVO44BDP2BJUnXFeWegMNJkd72qTGlKqaM05qqAghKw7vyqmFOQ/9k+ISt+KbOK0zM1iPjif+eo57C9tfRq6NERkvnF85MiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVFv2VKm; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b7acf213a3so16761556d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723308469; x=1723913269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSrIqckjKKhZLuz7xVD/WDlvau1h+4xDYADVj4tSgBw=;
        b=nVFv2VKmUunnoERxJFs5nthNILcgBq1MGLU5VKsyzcaqrD1eExzqne6gVyq/ltzkf5
         6xq4rMC3/p1lbBmSqj6wFwkULGF2cPjjcEoZisDvBlAlDV4aGPsqOhhVBLLbzGA9MoZ4
         iK1J7Hf2rAbgm/GVxki9Zass/E+Wu7YkZFNhikFr3NPZfJFA6eRgdswtuXmwwhNXGvCa
         xOqpz38NZfVkHS2qpGlB2ydQj64cNwYAUh27pi8UGdzJ6WLclgUod7Tr4cG9oIZnjFk9
         IMgxnzOQumOs/fq3XNsk8eH+bAC3MbfC4DnCmEe8H+3ixzLoiC5NgfVEM9DZMCTAi0Im
         lDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723308469; x=1723913269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSrIqckjKKhZLuz7xVD/WDlvau1h+4xDYADVj4tSgBw=;
        b=G+75TtlJJjVxkvOVTs2pLwrd1gwe+zo+bpAUt17qcCxwV+aN0Yu/TzjF9LVzRxSrjr
         g77Amdikcvk52gMEcOtG7wfaCPX8kB4x6ue23yyw+kb+T2MUaCA82VRmzPQ7uDX+g7hW
         uWLt8Pid8NZiJdE9YvgenqNfF6MPE6MacKzJzzL3hSMVd1xFf2OWmsWzkvKkw9YzLhLj
         AaiJnDUettPbZxCQ9VkJ0BmUgAXzkWx7otePDmdhZlIyayG9ea45bCOIPKNUIRNvnJL0
         7aB/ttrk6LKlANBnnq9y8Rm9Qlzp5xUKI5cjTao4iAbIWxMPJKMHaCvvJsubkk9acMhr
         s97Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdwRyhO3GIoeYpbgP6EMiCBcuWUcEgakJ+ge+HYdrz+YkaFOpdTXfWdjPOMigY6OKwM7cLULdr2i4HcIVIt2zHXUBOIFR5ep+BEY6S
X-Gm-Message-State: AOJu0YwKI8ZFAl6Ubw6q39puZFZgMDvGdqX8XTexNsZLQmFmTA0TJEtn
	sUYqqeWywcg6QLSgNNj/sC8cf3za59k8vJz9SSTGLDBvSNRAIIM7
X-Google-Smtp-Source: AGHT+IFz2Jshgrpl5KOEjXozayq/D+WVuWsjHGFvNc9h56XVAzz8cP2NFCkykpIgeToGOCoLvQrejA==
X-Received: by 2002:a05:622a:2446:b0:446:5d60:5cff with SMTP id d75a77b69052e-45312517759mr64685411cf.10.1723308469335;
        Sat, 10 Aug 2024 09:47:49 -0700 (PDT)
Received: from archlinux.cogeco.local ([2001:1970:55e8:2e00::a73f])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-4531c291a06sm7722471cf.85.2024.08.10.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 09:47:49 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: christian.koenig@amd.com,
	ray.huang@amd.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: Dennis Lam <dennis.lamerice@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs:mm: Fixed typos/spelling mistakes in drm translation table manager documentation
Date: Sat, 10 Aug 2024 12:45:20 -0400
Message-ID: <20240810164637.39436-1-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <dennis.lamerice@gmail.com>
References: <dennis.lamerice@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
Spelling errors fixed: successe, inistilize, and ddestroy.

 drivers/gpu/drm/ttm/ttm_pool.c     | 2 +-
 drivers/gpu/drm/ttm/ttm_resource.c | 2 +-
 include/drm/ttm/ttm_device.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 6e1fd6985ffc..b6bad150aab6 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -423,7 +423,7 @@ static void ttm_pool_free_range(struct ttm_pool *pool, struct ttm_tt *tt,
  * Fill the ttm_tt object with pages and also make sure to DMA map them when
  * necessary.
  *
- * Returns: 0 on successe, negative error code otherwise.
+ * Returns: 0 on success, negative error code otherwise.
  */
 int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		   struct ttm_operation_ctx *ctx)
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 4a66b851b67d..ec76151bc070 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -174,7 +174,7 @@ void ttm_resource_move_to_lru_tail(struct ttm_resource *res)
  * ttm_resource_init - resource object constructure
  * @bo: buffer object this resources is allocated for
  * @place: placement of the resource
- * @res: the resource object to inistilize
+ * @res: the resource object to initialize
  *
  * Initialize a new resource object. Counterpart of ttm_resource_fini().
  */
diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
index c22f30535c84..3e8f7f74f7b6 100644
--- a/include/drm/ttm/ttm_device.h
+++ b/include/drm/ttm/ttm_device.h
@@ -247,7 +247,7 @@ struct ttm_device {
 	struct ttm_pool pool;
 
 	/**
-	 * @lru_lock: Protection for the per manager LRU and ddestroy lists.
+	 * @lru_lock: Protection for the per manager LRU and destroy lists.
 	 */
 	spinlock_t lru_lock;
 
-- 
2.46.0


