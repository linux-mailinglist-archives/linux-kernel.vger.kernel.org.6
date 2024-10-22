Return-Path: <linux-kernel+bounces-376602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9CC9AB3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8751F22954
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872341B14FA;
	Tue, 22 Oct 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhrT3cZZ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0E136345
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613925; cv=none; b=QkCtvPltf8H8BZxhc3Mv1mk/DYxXCbI9svod0BMMniGtVX2to1wHBmiZtE9au1nCDdlFw8J5ZjLh7/Mbn9uu6Q1SkWAZDn390+U0bRvV8FOS/HUMf6AnsFODpWWNPYgxIqRaemPk7VhpJGvk7+Zec+7zOxVRnl3w6+LbR170QAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613925; c=relaxed/simple;
	bh=5DF4+/ZWmhv5I5biiLVNcoyN7Q3dxQulKY9UzYfUC1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sztr+5m4WZ+N/0NxiceYbiYn48NINn+Kw/gSIOa23dIAKg5OgtfcSc851XG1qYanv3S4Ji4y/4h3Fg88pzrN2GDSiKPAMsiypfT5hEV6r1npgycSUbXk6X0H9iOJxmC4rPNaTbV27zw4tDFllC+mxH2aanKFr75k69hSVX86i+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhrT3cZZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so4164772b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729613923; x=1730218723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSXH4Gm2YkCG5jqOLZfgl1YXuWNP9Yfv+roVsfCw4LI=;
        b=WhrT3cZZMsVwB2ZzBbcZUb47gDVYPApyLCF4T23rH3/0sRo6MgAgooprThSiyEkc0I
         sAPkpRMMOT3Rn/6HBftY7ARscaqlCqsKFDE5A5Caj4rIvfAekmRVou1bP954dXcr/h96
         MY+a2WbZ05pnUfi+buekdAD5IkbIWpgUC8GStPj2gg5hWprGyk2Vtt/dpoURSaHf9JRm
         9H6nhND7ariWvI95d0u8h64K91cVrLlK3Bq3tZpsisDDibXG6Vplvk/8XW6PHpxYGsWB
         bS2Du3ykHhMn8eyKLrD8nhoL3ItQUNMblO5jesmR6JfBjao+Lk7ymnSMP7Rq9osLE+8U
         dXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729613923; x=1730218723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSXH4Gm2YkCG5jqOLZfgl1YXuWNP9Yfv+roVsfCw4LI=;
        b=Ebp1pWBkFmLf6L3BHKzJVm/l9sA9t//wSG2Eu05QWj/5lUu3+jteZPNCARF8bCa0qX
         BFN+IFWsj+zcPxzlWd9NiHMlug25xgPVXdxdIXjM1iOxphlkMC0LK3F3tZczdwjpW48V
         IT4q0yeN7thBFrTqhNJOGmncU1q+blBF5Fr4/H5MXURMZVBPNkqj9My5imY1/zkihJjM
         98ZSOxhqICV4ChXA8QN1hy4Qn0wybOfWVmUmRxAdW1jSjrpDp/5NCdSJL5opdHuuWvEr
         ywFEGvAi81zow4mBFk7hQFAV3liXD0hIZaf3lMsOWhaExZoOrSi+Z1kZoA89woABoyfF
         MANw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7leLvMilr8wC5DDWc0yptzQCixgF9t7okhNWdocAm5+iICfNSneWQn3BQlmwTqxCry5WB8MrGEXhCBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxEqpWFtVxon/4uGTFj5Wrerq8620chquE+z/Ar3tiDPMNd+u
	dU9mIA92Y/sA/+Gr2zMQ993kACOrKYLcuc1HwIMCHp4v0rup/qcm
X-Google-Smtp-Source: AGHT+IHQyzAjc0meceXpnMSob+rxgdiAsthihq0A0o40myz27LC+W3+w2lz2hV72240cPH71b29JYA==
X-Received: by 2002:a05:6a21:350d:b0:1d9:ea5:19da with SMTP id adf61e73a8af0-1d96b6b6ed5mr3806414637.17.1729613922722;
        Tue, 22 Oct 2024 09:18:42 -0700 (PDT)
Received: from localhost (134.90.125.34.bc.googleusercontent.com. [34.125.90.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec14088fesm4894285b3a.200.2024.10.22.09.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:18:42 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: boris.brezillon@collabora.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Chunming Zhou <david1.zhou@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: faith.ekstrand@collabora.com
Subject: [PATCH v2] drm/syncobj: ensure progress for syncobj queries
Date: Tue, 22 Oct 2024 09:18:24 -0700
Message-ID: <20241022161825.228278-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace might poll a syncobj with the query ioctl.  Call
dma_fence_enable_sw_signaling to ensure dma_fence_is_signaled returns
true in finite time.

Fixes: 27b575a9aa2f ("drm/syncobj: add timeline payload query ioctl v6")
Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

---

v2: add Signed-off-by and Fixes tags
---
 drivers/gpu/drm/drm_syncobj.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 4fcfc0b9b386c..58c5593c897a2 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1689,6 +1689,9 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 			    DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED) {
 				point = fence->seqno;
 			} else {
+				/* ensure forward progress */
+				dma_fence_enable_sw_signaling(fence);
+
 				dma_fence_chain_for_each(iter, fence) {
 					if (iter->context != fence->context) {
 						dma_fence_put(iter);
-- 
2.47.0.105.g07ac214952-goog


