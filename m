Return-Path: <linux-kernel+bounces-261009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F8D93B189
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D638B22BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41459158D94;
	Wed, 24 Jul 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RegnbWXS"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A370158D69;
	Wed, 24 Jul 2024 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827474; cv=none; b=mnpJuNROvKpiFL2aWnjpdLvSuG2gZAiY7vanqHvC3YBDJEz+9h5Zbc/8dODafVNIO2yt4SkwClu2K+pNft7FlBplafiA5i6GrX/+OFbF2NykceOjv4izz4Xms1cCxNyUaqAO8HvANn7xZoXL0opvnZ/usIeu1EhqvCW3ibrRdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827474; c=relaxed/simple;
	bh=ZpJ0uZhkYWLik28S/oC8SR9YTOz1pjFNpUFti1LkesM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SXVqiUq7Qd//DbG9SsGjAex3NuhWdojKyA9thbWpbnp7zCmpYuIRhhpwbTtgaWkaIDAZwXm15RV7wMva4qFk87IUPl8c1nImoSYQK9xwfdgxcKQZr/S4yZFZzr41pNncf/4dwBJJ07NyWnYygOBBMPoI2cgZ8J9uEG/syLXVHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RegnbWXS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266fcb311cso50939085e9.1;
        Wed, 24 Jul 2024 06:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721827471; x=1722432271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56EW1ghreVxrFRUF8L89H7cqgKAc3/kmAPxfhIquFsg=;
        b=RegnbWXSIFOLwn/fBf4Bjz5RY86ereLZVIY7Fetn2vOr6gk6oQ41TUnpGOwptkTJ+9
         tqqIpi4Xg6AIPapjooYtZRz9Z7boN+tmfkTHroaKWlVPeDtTEP+BL0YTVy0VkqQ+mxQY
         kWgl2AFD0uYSpybKKaroh6O6+LJ5sszOnoFHfMwilyO9tb83DdDWwGzhFLCJL/rtTwQt
         EFbhcIb5KznSpFYZYlQMKmlSLG2Eld8Kqq06v8IGD6UMrfJ/JW+6a3nhWKkrWOaZUrUx
         v0vZCRXxxhwnPuOY+n84DW6ikqHSyjodkHpqAq1G4lUCTJa2JdvjwcevW2aCyx8JF+DE
         /WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721827471; x=1722432271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56EW1ghreVxrFRUF8L89H7cqgKAc3/kmAPxfhIquFsg=;
        b=h4Vk2TaUBED7iEfHHAyzUMfMVZLKW2rdvZTn6T9Voa/pc4H7yGPMuJiBiP261WxAVs
         sCAf5OvZVkE6nGOO4kgIZJ9SWGgc12Ad2T+58Q9USSmcynJ/eLbYMBvU71S/wojYmYdV
         YM2S0nfRxXiYVaHuk1wHGMcL76+nwHz41ppV+p+pRWkn2VSnN4QMwhTpfCYNpsejGBWd
         EqhtI8Kb6ZkezwFwt3FvakkGdl8x7h3rIpja1or3jXk9nAhzpJbp4dyMAgQBRFKJCNws
         O8QWlg+h/y1XQoejwWSdioKnSYLoc71tFhHvE3p2JPW2ueS3Kua8NhWgO09PBy/m8ZVa
         TGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUm01qjVBD7DCBP7ohfKGsTp4tRwvOu+loWQ5qWKZI+CLPmwpGPkHg6J+xv0nAXN2XB7bTouiWt3/R72JDt4sGCBmDx30OYPX4t9NQ
X-Gm-Message-State: AOJu0Yzlgen4DsFOFs2fOyq3MMEqo1LLWWylA1d195c2gviTqPY8RYZd
	qrLTymKJjwjIIjN6gGCld6CEVc6LnJvDVpBLGqGE86DCpIr1+y3+
X-Google-Smtp-Source: AGHT+IHQ/85EhTrpuufNo5wWg0jwh8u7SIp1MIxenQ7z0d+vfqpSBcNI9sqN2s1gmw4N+9HuBR2EIA==
X-Received: by 2002:a05:600c:1e1f:b0:426:629f:1556 with SMTP id 5b1f17b1804b1-427f95b2bb6mr15003705e9.31.1721827469893;
        Wed, 24 Jul 2024 06:24:29 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868bc91sm14351050f8f.45.2024.07.24.06.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:24:29 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Leo Li <sunpeng.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix spelling mistake "tolarance" -> "tolerance"
Date: Wed, 24 Jul 2024 14:24:28 +0100
Message-Id: <20240724132428.2468883-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dml2_printf message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 0b671c665373..5ba38d51382f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -8267,7 +8267,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	dml2_printf("DML::%s: mode_lib->ms.DCFCLK = %f\n", __func__, mode_lib->ms.DCFCLK);
 	dml2_printf("DML::%s: mode_lib->ms.FabricClock = %f\n", __func__, mode_lib->ms.FabricClock);
 	dml2_printf("DML::%s: mode_lib->ms.uclk_freq_mhz = %f\n", __func__, mode_lib->ms.uclk_freq_mhz);
-	dml2_printf("DML::%s: urgent latency tolarance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
+	dml2_printf("DML::%s: urgent latency tolerance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
 #endif
 
 	mode_lib->ms.support.OutstandingRequestsSupport = true;
-- 
2.39.2


