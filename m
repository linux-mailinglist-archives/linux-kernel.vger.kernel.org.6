Return-Path: <linux-kernel+bounces-525234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880C5A3ECD0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC3C19C44AC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43861FCCE9;
	Fri, 21 Feb 2025 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqBH5Wu7"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2501D89E4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119253; cv=none; b=IgNw0wfja2uAEsq1BKgPOTmZIeJFGIY6DfjeSdXvSGyxONU2jFao5wTsmhUliArZA7VOqUwStaRAXJSMBZAPtUlRdTPdA2uzVEwjcGkLygW+AvJj8vRtfirlINrMA1zKjqeH6nE5gxm9AEcWapkh0MxJ5D3VVOke3JjfYYyHFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119253; c=relaxed/simple;
	bh=32Tz4rTPm3s+S8fVY2YDix25mUAA4UMUZGfRiiqhHNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sKRn3kdHhuHp0fHsGfzkGdbeHZg180HIKg7JOw1xUHVxuIXfudYrpyjrA9RwExsZexOjViN48INvTP7CeUGHhAFLKr42xD5j4D3M36ZVOiglQPA5Hf63pStuMb0JyjjsxRR1RgEH0Xgl2Z7f+0Z0038ISaHcAbZM0fcwbNNS7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqBH5Wu7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa8c788c74so443111a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740119251; x=1740724051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5PUlkILcaVGQL/e6xHLxhEm/6slgd71dKud2+gLheo=;
        b=dqBH5Wu7qrpuRR8R4iXmXA+7lZ15mRaJv7/GLe8ZwtGUCFRoVUedUx9D0SJbEpQz2u
         bKb//KdioBhC7epnxEeJjGVAM4fny4h5bBlV/8FnhjO+nsbzcFCr+Egj31ZaL2ACIZLH
         hoZ3/8930z+fvaUB2Xwc2z2sSYZ4jP/fMjkPtQtt6L0pO/tdfbusMTsbOiUq+1QpBJTS
         ASQirRWJCHh3COZK9STR0pS1JjeVvevmHeA3mSpmXNQjmr3gosbzFMMN+/jmppXbNmD2
         sn+P4GXQE+j2f+fGcCYh4MeH4ob5tIcbRc0Yx+Q9HkXp+aISl8suxyMgsqbQVNbzuYn8
         I/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119251; x=1740724051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5PUlkILcaVGQL/e6xHLxhEm/6slgd71dKud2+gLheo=;
        b=jpHJwsg1Lou9wRqFbyLIgv9Z+H41WYB/EnGkFKnJnvoaqnIataV+4S6nLnhSapD8eS
         2Xbfz9sP7iF+BF+dBJNSOsWpdROZp4UNyvynr6V2Gjc/3SXEizjOOo1P6x9e7MkIZzpz
         HcHFmw7Jd++jz1SgyHbD5MVL31LK6JFOcphnCSqhdCQuQDlQjtzh1ufyNmecAx6UeCcr
         4Vuew9uP5o8d8gya4yTLKySJHjNlWMoQ9fgR55wXLPCaGzQLZvUOSIaXbn3lMZyjxXss
         WcwkKudmIEYhtjLF6VUxdARoVq6CXWsr2tuhxN0Qq+05Y+Jdt7YcXYZ15nUDk2v4H4z2
         S+cg==
X-Forwarded-Encrypted: i=1; AJvYcCURfy+o9SkcIrSoU9KpkLrwIAoSpSKQFWQ9ar1Slp8R2IEXQnOcJ59Z5HV7uPmU87mrnwXNiVl0kvY7DI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3899dX5r0EAmhTlkmdi5v5XNU7Zr5x8awyxrplS53bYjM836r
	2otrvA/un07HkMjA9w1+4xkx5xRVD81WPf2ivS8IGwrgpSCg9EW6zNd0z2GebP/xVw==
X-Gm-Gg: ASbGnct3DehcPyAG8nu9nDaCx2Q2rulZW2m6Ht66PVyxaXL+b8jI8Up+hvA/qF/So8s
	oTOjX5x6NHH7FJmFKWbgid9VjF9UNd4POgMdFcgMZU3foH7wzZjdkaT/Xq7sxEQul+7ThKbgcQp
	zSfhig8bc0Y8w/3Wr3VWtV8y/RPlrNaZndkdAJhrrT+xrwnuLMROwCN8sQ21jpEs4vd/of2XsB4
	VQIFylsHLMEMFsHkjLbgDDprQbIquBrVnFX9g+7ckIAnsoaZcyTm3l80Frw2c8gUFJB+QNXslgF
	NAyY12Kx/OnGU6FJWhgyzYvRAKoH+yRIE+0FoyXb3mA=
X-Google-Smtp-Source: AGHT+IHd2gCWe8oAr3s+MMnLxjBGDFBvdc4Lu1UIZ3GzVVQeCS76/zsPHEsRIOs4vDSz8aWvvFD/7Q==
X-Received: by 2002:a17:90b:38c3:b0:2f4:465d:5c91 with SMTP id 98e67ed59e1d1-2fce7b4f242mr1239593a91.8.1740119250695;
        Thu, 20 Feb 2025 22:27:30 -0800 (PST)
Received: from localhost.localdomain ([182.148.15.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb10fb21sm508197a91.39.2025.02.20.22.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:27:30 -0800 (PST)
From: qianyi liu <liuqianyi125@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com
Subject: [PATCH] drm/scheduler: Fix mem leak when last_scheduled signaled
Date: Fri, 21 Feb 2025 14:27:02 +0800
Message-Id: <20250221062702.1293754-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem: If prev(last_scheduled) was already signaled I encountred a
memory leak in drm_sched_entity_fini. This is because the
prev(last_scheduled) fence is not free properly.

Fix: Balance the prev(last_scheduled) fence refcnt when
dma_fence_add_callback failed.

Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 69bcf0e99d57..1c0c14bcf726 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -259,9 +259,12 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 		struct drm_sched_fence *s_fence = job->s_fence;
 
 		dma_fence_get(&s_fence->finished);
-		if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
-					   drm_sched_entity_kill_jobs_cb))
+		if (!prev ||
+		    dma_fence_add_callback(prev, &job->finish_cb,
+					   drm_sched_entity_kill_jobs_cb)) {
+			dma_fence_put(prev);
 			drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
+		}
 
 		prev = &s_fence->finished;
 	}
-- 
2.25.1


