Return-Path: <linux-kernel+bounces-319626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BD896FFDF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0701C21E6E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C63A1B5;
	Sat,  7 Sep 2024 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWHiU7/e"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB284EAE9
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725680232; cv=none; b=GnutU3aO3w65hlYNsl4xuTA0dqadl0YF9cUQbDYbBzaNikvnSs0/Z2aeCq4WISCGltYJkawL/UxQXe9Pd/bYc5U+THz88cJCF9Z5tT/SFMWJo1QKI3J0JYv4gnXOuRncxvD8n7UsZ8K5EYRmqlnw70SfCRsgcetvRLGNNYXxBBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725680232; c=relaxed/simple;
	bh=9IpRdE+iMO3lDZEnFlMi6eq14jHtpDEtJEsroLAxjOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J6j8NmHPUsYjI2Mrg0cy7GlWR91FVCLhnUQkXOQoBmGEpf1ifsksCQb6cco11xhw2f9u3ZJgG7TsfDHpsDX6HSEGQSpSc+c8j478osGtxM5qDgx6VlM9QMqH9RkVnW7EwRSmGkNLSF93Tqowtx3SZSDGTBoaWBOjF7LfVMPRDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWHiU7/e; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-277f0540c3aso1616587fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 20:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725680230; x=1726285030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bdn1vzRRTAxkrY+XEO+BGgWLg/pK8pUQR7KL2TxVAiA=;
        b=KWHiU7/epXS+jv2CGun8ZXff/vc/TO/VUHFWhFys3if8DlslNsi6rss2A/fs/k9h04
         I98Sl9I+3Tc24tKrPMqQ7Or1p2kh2EyI7BRYCRNifimhfNpiisHYG4xbISK7cME6h2TG
         xHxN/tX0cIoZy/GoZOg1Tg9JcgHOG9Y7ugtyvpfYq+7vUyj7Y2OcN+45A8oS9MT0yBvV
         X2gp602dQJ5BjV9ukbBGuJ99bkLE518fLnnzRh8t78E8cu2o4GlvkB1QntB6zzw+/z0F
         lKuoEFb5i8synbg+pxqDvAvU4IA3uySrjXpsncXZduF+Nu5DDLse0aRHPlW3R4pjt/mH
         dsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725680230; x=1726285030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdn1vzRRTAxkrY+XEO+BGgWLg/pK8pUQR7KL2TxVAiA=;
        b=ZrdVoKqPNg+CPL7WbArAGgfvH9tSNZ7TlgZLp7FO4APjHdwTVOPZnwKrC8ihG1idkB
         zIqRjPzUXW/5NFKtdezX8yU8J+bCpZzIDlZtO17/P5rXHIOkz2i03XfG/wMFmRCJFUVF
         tRVJHLAMGQBQEAWt6pKwruag3e3Cdau6o0CJJ5Tyf7EjcTBrEEG2Xekb7aFlyYJqOVk/
         0S1T5GtFHAgVFxCZDI/2OJXZ73ZqkK3L/G4xztFmq6jeezrSR6e78gkGjRZDlJ/MM97H
         Gufhf9WjUdjRq6z/ZWyVkSozXG67dBgpbzMP1B94RYXZvxGXM4X9y0Xvw43vHKxdo1sE
         R4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV6yBELr9jmZYIWKYu6VrX0gwQsDZl+AJjHXMMH5sFOy87IlW+t94cqAT5mhdIu6BuwHB5U4t+/Mn3eOz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGJ+Gw1HIDuisTofMxcE1vcldt91qwEWvtlgIYjPNqjkKCxIi
	gWyMwJltrs9M6MFVe0eJTjT5my0JIZsn9FXQQl7fEO4BLzdVhVc1
X-Google-Smtp-Source: AGHT+IG4gOsQ09yMILSjZI04blubJ9v01hUa3KPBH71rWt2ry/eeQM6gjBxX9uOR2G0GPYSV5n6ALg==
X-Received: by 2002:a05:6870:b294:b0:268:a79a:be0d with SMTP id 586e51a60fabf-27b8302d7f6mr4854143fac.47.1725680229766;
        Fri, 06 Sep 2024 20:37:09 -0700 (PDT)
Received: from localhost.localdomain (111-240-109-89.dynamic-ip.hinet.net. [111.240.109.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e59841fbsm217637b3a.167.2024.09.06.20.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 20:37:09 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH for-next] drm/ttm: make ttm_swap_ops static
Date: Sat,  7 Sep 2024 11:36:41 +0800
Message-ID: <20240907033643.1513301-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make ttm_swap_ops static to fix the following sparse warning:

drivers/gpu/drm/ttm/ttm_bo.c:1142:31: sparse: warning: symbol
'ttm_swap_ops' was not declared. Should it be static?

Fixes: 10efe34dae79 ("drm/ttm: Use the LRU walker helper for swapping")
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 320592435252..1aab30767e41 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1139,7 +1139,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 	return ret;
 }
 
-const struct ttm_lru_walk_ops ttm_swap_ops = {
+static const struct ttm_lru_walk_ops ttm_swap_ops = {
 	.process_bo = ttm_bo_swapout_cb,
 };
 
-- 
2.43.0


