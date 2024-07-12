Return-Path: <linux-kernel+bounces-250233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2522C92F586
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C341F21FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FEA13D603;
	Fri, 12 Jul 2024 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSdNAIg8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E813D2B5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765595; cv=none; b=VQlRMICFsTGtmTdDb9VcNIm98nTeHO1mNL0y8dsf8KSXAhx2v+fP/Plp69S+asV5DXxkvutFOMgrM6/OZJsiE12azoYfqI1buVg6zMU0tUfrviM+FQ1Dr97pqvXLbEnczKZzJ9a5DJTmdWWc8gdxL5PgUNpikJUr65uxm8x6ZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765595; c=relaxed/simple;
	bh=u6FNmlZeQMto0upixwU3exVMCHI8HT2oAnTcwPvWRSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQKvOFHpwHPb72O1hNsX7MsQ6VZCkNvJDicWqBrgPbCamwCL6h0NPvxPT6/ZBYXQiLcQjJLnCzFyXZKmxKAjpKotejYxylXfomSgsidXuZpEfVjGzzBoDPNHfxshb87voftiXviHnnyWW9LhgqPA7JUBzFzSTlGliYa+XxMxAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSdNAIg8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720765593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9a5IayKbXBKJrNi/QMZz5s0Prw5V2adYI5z3/V5xH40=;
	b=CSdNAIg8KOETOlz1x/TX16d1L93YNSyEDD4uj38DEjjL9wP2RIKskPubZDohHVt10oYJur
	nNcevPFAJE3vmkaH+7nd4kOgE47VWPduZVc46YM1KdF8GsaUqOCHLBM9J4h0xaECdSPXmo
	6vrRNRJEqb8bdZYrycZZyNgjbHbpHcU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-r2lohZS6PbKmIl5snPI1bw-1; Fri, 12 Jul 2024 02:26:28 -0400
X-MC-Unique: r2lohZS6PbKmIl5snPI1bw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4266fcb3166so730635e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720765587; x=1721370387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9a5IayKbXBKJrNi/QMZz5s0Prw5V2adYI5z3/V5xH40=;
        b=T0LggSUTW/z95BhRh1pEH1GYl/xwMYOnjQAjDn1ku4Oqb+E+YFZPctTJh/rv3uU1nQ
         rdKoTfryCB7ZPVW4AQeVc366tDYPFi3VX5nddGPxICteJvW3rXfGmkzRXPSI5RHJtR5e
         N3uopK/RVOjssf7nK/5+jS2VhFGGGvq/OjSHFnR1Fcd1y2vDV+DEl2/59djyoH4uhsaS
         YvBjxTAFWZVZVCx/Sh6J5TLYeCb2vaaSQdxOZqLIf/yutWDKWmF+Eb2p3ULExnmWoiDS
         LtPpa3ggqbE/Z1lEq9+pc5akSI/0unjMtQnhBfWCvfWagRyTKHM64qshZwhRXg2EjdEq
         dfbw==
X-Forwarded-Encrypted: i=1; AJvYcCXPAvD0VcL9Ynm4+8NLS/6MqJwDceE8g1gSKPDhtSvlBVpWhaKIbmKCjrVVSj/vO0hOwn7QNfVaJ/434WFe00HRFID/rNKFfWFjwy84
X-Gm-Message-State: AOJu0YwvxeljqkHDgBXOg5CqJU/w8L9fA/nddzpQr/df66aPSkm36XxS
	jVB8hlMBWoCeSGNCOTDg9HShXgQnZ/YV1kaUYS2OLbZlQElzd4jWZGHxm4ytL2f158hrUYzdJ1L
	pRowVQJ0Kc5q98Se204oufn2uwHv60gJ5x31h4hNhQqCfbrsyKOUD2b9TBs5m+Q==
X-Received: by 2002:a5d:64cb:0:b0:362:1322:affc with SMTP id ffacd0b85a97d-367ceac1af6mr7196236f8f.5.1720765587436;
        Thu, 11 Jul 2024 23:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKURcKatRXBWbit8UsmQ0Qm94LXmqPcy3DdNqKx6medY7O8ZyGlJX5YS/xZ14HpSQcyTLjgg==
X-Received: by 2002:a5d:64cb:0:b0:362:1322:affc with SMTP id ffacd0b85a97d-367ceac1af6mr7196220f8f.5.1720765587025;
        Thu, 11 Jul 2024 23:26:27 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box (200116b82df8b300fbf278adc06b342f.dip.versatel-1u1.de. [2001:16b8:2df8:b300:fbf2:78ad:c06b:342f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde891a3sm9322535f8f.61.2024.07.11.23.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 23:26:26 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2] drm/nouveau: Improve variable names in nouveau_sched_init()
Date: Fri, 12 Jul 2024 08:26:18 +0200
Message-ID: <20240712062618.8057-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nouveau_sched_init() uses the function drm_sched_init(). The latter
function has parameters called "hang_limit" and "timeout" in its API
documentation.

nouveau_sched_init(), however, defines a variable called
"job_hang_limit" which is passed to drm_sched_init()'s "timeout"
parameter. The actual "hang_limit" parameter is directly set to 0.

Rename "job_hang_limit" to "timeout".

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
- Remove variable "hang_limit". (Danilo)
---
 drivers/gpu/drm/nouveau/nouveau_sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index 32fa2e273965..ba4139288a6d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -404,7 +404,7 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
 {
 	struct drm_gpu_scheduler *drm_sched = &sched->base;
 	struct drm_sched_entity *entity = &sched->entity;
-	long job_hang_limit = msecs_to_jiffies(NOUVEAU_SCHED_JOB_TIMEOUT_MS);
+	const long timeout = msecs_to_jiffies(NOUVEAU_SCHED_JOB_TIMEOUT_MS);
 	int ret;
 
 	if (!wq) {
@@ -418,7 +418,7 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
 
 	ret = drm_sched_init(drm_sched, &nouveau_sched_ops, wq,
 			     NOUVEAU_SCHED_PRIORITY_COUNT,
-			     credit_limit, 0, job_hang_limit,
+			     credit_limit, 0, timeout,
 			     NULL, NULL, "nouveau_sched", drm->dev->dev);
 	if (ret)
 		goto fail_wq;
-- 
2.45.0


