Return-Path: <linux-kernel+bounces-353968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723D99355A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0801F22B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669AE1DD54A;
	Mon,  7 Oct 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYq6L/BV"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76150156E4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323356; cv=none; b=rolbhI1ZyfkjyUrlu9jV0IWpesRR2IqXHyAyQ2+77wbuDoNpBavuMTJTMGzHy5QEwRbdiouBFVShYFTCmeQLPwbiS/aXnQq1+PDLEbOEAinSbD+3IWh3SPVqn9YAXpB7ZQlIe8o+KMwUMUQAq8x0G/ADfl1j7Sr5pQaWjCKr4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323356; c=relaxed/simple;
	bh=+RFjh4DaD8GuFlHlEz3OwTe7B0oj9cRJI8XK9+fCTOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gksXEEC/rO0UsvTigLFUQBUELOo2JRq2YC1tqbf+D5V07VM5WLvE9UXuSeq9N3mQBmHd030x8ao/TjLVPzLPqaVLHBZ8RMZWJ/D9yYyZIrItYmVzQVPNQQvJ1OHsI0wtDjjXBV2kpSUnGVb3VjWIe3xgleg2UH9gnaQFsaITVEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYq6L/BV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71def8af0d9so471458b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728323355; x=1728928155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFIN27AG3WgjOnmH18Fk8WaAPf1pZ2KMgetkW6A+4t0=;
        b=mYq6L/BVoDldDc85n24ZaF1etosfm8Jh+oNmZJJlLeL3lxyctB+l4baQhZ+/iWMAeK
         E8oTrAI2UUFob3pIzHu8iDLkOtQOraZxXYjxWUOmAcDyRdR9MhJyagmpWTMAE61Yw0BT
         SyYO95tvMeeBzT22C/n1gYnkhQyY6ggHNXQCHhj9SyiD63LlqussEEfFFvmrPeT1j0E3
         5O1yqHHuCzizvuEd4z1oFhuRWagd5H+oLG36S2NO642mpapsVuADdDKxKNl8KBL5Nqhq
         Vak/JQSPZYyMBAp1zrpPf8o+NC3X3D6qhnoBO4iXZs/CP2C8NmRsjyLFGVD47ZbWsYSj
         Br6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728323355; x=1728928155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFIN27AG3WgjOnmH18Fk8WaAPf1pZ2KMgetkW6A+4t0=;
        b=Dztwoe89SXCu6aMRhv5dSnw2MMG09AYKjQPyAjjawpBAzqKQWiejN7gCy7lebbMnBc
         eOGK/Og5bHE5PT6ti0EuZK+0zhRI1MVI1koPu9gkL6HGZcnBDjCgV4JJMoWZ6xmk7KeP
         MGN4zqedTIZXAEjXyuRycMKnbVX8Z+HMNQHOBgwmIb93ET9ygPdXwvcz4l56wCLLv68M
         ZuzgtOefhNd084b0/oAEpbvoVK1E/pJKulhY5RONjVwk1yFuNEbCXGdLtripW8+MG8Tm
         dtscZfwpHPUMZHJrNTSxju0RWANgcn9gEO0lBxbDBSIVbHnV58tKhzrxb+YepdYfR97w
         D6OA==
X-Forwarded-Encrypted: i=1; AJvYcCWEgkLO7SACq+R4eBANl8mbJawESb4/p2QxDOEhCqE5QY4fYyDa7YGtFhkFbihAfMNzGWYXxsjfZjdgErA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLmow8tTMe4kBOnqSdpWCUfYt4pp5rQumx3ZBSv5v8NwSRjTG
	eK/45Q1mEt6YLfEGYl20Ey9kRaD2+7VZ10zimBgvIR/YJfzPYv3F
X-Google-Smtp-Source: AGHT+IH236XZqVh5kSYznYvuShbIvj5woyfy5XKiXBwQQoAWzcu2Nl7W5TjR15p5S8ffsQdMMGim+g==
X-Received: by 2002:a05:6a00:2e24:b0:71d:f744:67 with SMTP id d2e1a72fcca58-71df744011amr4789204b3a.7.1728323354725;
        Mon, 07 Oct 2024 10:49:14 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:a843:852f:eac4:ff92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd0ae9sm4649923b3a.82.2024.10.07.10.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:49:14 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	imre.deak@intel.com,
	ville.syrjala@linux.intel.com,
	R Sundar <prosunofficial@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH linux-next] drm/i915/dp: use string choice helpers
Date: Mon,  7 Oct 2024 23:18:57 +0530
Message-Id: <20241007174857.85061-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use str_on_off string helpers for better readability and to fix cocci
warning.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202410071252.cWILJzrH-lkp@intel.com/
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---

Reported in linux repo:
tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/i915/display/intel_dp.c:2243:6-9: opportunity for str_on_off(dsc)

vim +2243 drivers/gpu/drm/i915/display/intel_dp.c

compile tested only.

 drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index fbb096be02ad..733619b14193 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2475,7 +2475,7 @@ intel_dp_compute_config_link_bpp_limits(struct intel_dp *intel_dp,
 		    encoder->base.base.id, encoder->base.name,
 		    crtc->base.base.id, crtc->base.name,
 		    adjusted_mode->crtc_clock,
-		    dsc ? "on" : "off",
+		    str_on_off(dsc),
 		    limits->max_lane_count,
 		    limits->max_rate,
 		    limits->pipe.max_bpp,
-- 
2.34.1


