Return-Path: <linux-kernel+bounces-304766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD484962492
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4D3286831
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FA816C69A;
	Wed, 28 Aug 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RCJ+PYzO"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF416BE30
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840167; cv=none; b=img2T9s8XzpShy8SXoGrNXlqcI1wlor7GdgdF0hPD3K2sy4aAiRbOmYngH0++7O9r9U4Wbci9XKJhO9mEs8xlEaUeIZfG7tRPJqRk0PS+yKHE5cLAjQm2A0F+/X8NvrW2tycqS0AbF4aCG30gZOXODD7m5cyiGKQGRk/CKj3oZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840167; c=relaxed/simple;
	bh=W7Gao614ZJjufIy403XuYO7C32HLuO+N9crucIL/k8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOVK+kLJxTrhUFZJpBU60EC4fyc3WoUn/Xbx0zBVOA/yxUTDXzAUU4oJa1I2/xBTa0YuYbOqJwSOk1qgt0KvE719/g9RLiLbjxDxeZIXVhVk9O+wyiXL86QRK+unKbAuQj+CXJXP41osr2XSjNl2i5Rl28LRE1fg1JIoF0LfFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RCJ+PYzO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201d5af11a4so58486525ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724840163; x=1725444963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l6EEmhk9Y5reOAFsAV+HEJlc3gS52f19SksxotmeIlc=;
        b=RCJ+PYzOujmeLxwJQILLzMH4+ZUotHpW1tUAR3Zs6rfL7ABCad0/aG2kM92j8FQozJ
         AaZrLXr5uIzek/eKHOmunpFhEmNjLWZmmYYjxJwRfPKMN5aNOafat3le/FKOe95sMXQM
         NJtwRLVrb6bWnS8HukFaMv1QWEtA7Zg3ApL+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724840163; x=1725444963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6EEmhk9Y5reOAFsAV+HEJlc3gS52f19SksxotmeIlc=;
        b=es1MQ4i3EyYOQvlygfu3twcXSoFsfGYPFPs8EEmeWhEQe+jWIXVRMQZ0tRpdpPVsp6
         fREVHmPs6KGLbDf1xX50oI+fvSX8LwrnsU+ATxFivzhrNljoSgyEmYX60s30Miuv/Wdh
         0Pf9KedJnhhG5+Xp6KbAQm97TKMXpJsdWUgNvxb3g1cV4Do9ToLoMVHZLolrfg0K0hdJ
         uPf9vw0XiqMz502X5mRloSV/JUorHJvAHMhogpQpu3dkYtbiBQhbBQbJ9fTSZjLtKeT0
         CIk2Qqq/KC2NsSoCT6rBVjAMlZ+XleyQi+eHAK+jIsC4koEKIwJj7nqUZ59bHIGy28LW
         FUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCULmG3q4PDQkJEBtSz/F1IlCFy+osafv3m4umvogaPK8UgADYeZqcSbSyum5TDqZn8XLT/wD2pfNmJbrJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BeJh+/zz/d/XZ4wDMA9VkBuWvb/qQFzpA2MTyf3DEwiBYeu3
	pKCcpNKLcBTyj4ijGx4GtceQ0g8k23LRWtGuXx9iyoLRuPtkD9fJftwcIMKFww==
X-Google-Smtp-Source: AGHT+IGtCtgGflkPLcIWz63EIUUuX6MMYmWQAYa+kWCCehY2yI9ZV21P39BGDfxsdsq/CdkR0IzgFA==
X-Received: by 2002:a17:902:fa88:b0:202:100f:7b99 with SMTP id d9443c01a7336-204f9b7f065mr15103095ad.22.1724840163370;
        Wed, 28 Aug 2024 03:16:03 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:e0f3:8e32:ef17:cdd9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560dfd1sm95645455ad.206.2024.08.28.03.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 03:16:02 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bibby Hsieh <bibby.hsieh@mediatek.com>,
	CK Hu <ck.hu@mediatek.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] drm/mediatek: Use spin_lock_irqsave() for CRTC event lock
Date: Wed, 28 Aug 2024 18:14:47 +0800
Message-ID: <20240828101511.3269822-1-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the state-aware spin_lock_irqsave() and spin_unlock_irqrestore()
to avoid unconditionally re-enabling the local interrupts.

Fixes: 411f5c1eacfe ("drm/mediatek: handle events when enabling/disabling crtc")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/gpu/drm/mediatek/mtk_crtc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 6f34f573e127..42f47086f414 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -449,6 +449,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_crtc *mtk_crtc)
 {
 	struct drm_device *drm = mtk_crtc->base.dev;
 	struct drm_crtc *crtc = &mtk_crtc->base;
+	unsigned long flags;
 	int i;
 
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
@@ -480,10 +481,10 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_crtc *mtk_crtc)
 	pm_runtime_put(drm->dev);
 
 	if (crtc->state->event && !crtc->state->active) {
-		spin_lock_irq(&crtc->dev->event_lock);
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
 		crtc->state->event = NULL;
-		spin_unlock_irq(&crtc->dev->event_lock);
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
 	}
 }
 
-- 
2.46.0.295.g3b9ea8a38a-goog


