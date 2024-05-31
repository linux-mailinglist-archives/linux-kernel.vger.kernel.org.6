Return-Path: <linux-kernel+bounces-196584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EEC8D5E52
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163861C212E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0101181724;
	Fri, 31 May 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKqVlq7i"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C04AEF0;
	Fri, 31 May 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147936; cv=none; b=X65tX7Gh6orMOhhsBHoeQoO/9gGM69/SIOB6J9I467sFPCbfr8WAIJPyERkaW7s+GXQsADKsO3F0xT2G/Tt010rLnjUiUR5hxLW0QHgObqe3Qw0mD1YRTbJyKquWXnwjqttBcTCqcn2/6vvwk4n39rPkmc17TiBt+EkYVxUyHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147936; c=relaxed/simple;
	bh=0vwqKpkncSpsCyCyMgQpurm3nWtR24dS2s/8mqJ8EIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=trlHohFsv+zCZm+utUCYFPNbzgzKhME5DEAjCDq0OyCM7QGL7Q+ex/YV1Skm8/aOyGVKLWtgxPEKQITd+EjwsmgBquyVce5VnFDtVbW2Cq4tH2FEbqFFbyPjiS1tVa88+QaW2MEGeM5mxuBPpMRg0vEUyOL7WC6jXZvFgrG8dRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKqVlq7i; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42120fc8cbfso8313515e9.2;
        Fri, 31 May 2024 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717147933; x=1717752733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=plB5SAM6IxvDio+P+8hN6eVaq+FHOovulQhKLCG8UQo=;
        b=fKqVlq7izt1c55qstEHBE2KjAqZjEYifNyvPDWSHYd6A0MXR+Cd2GVuQWebTnj9UjO
         AIAkDXprx1okUt9D/Ro5XqwnCHPthzcetqUrQrc9WGs9g4m44os1iHjgXt2eSvJZ9oTx
         wg8FtoDf7Ia0lbOJSWj3xoKvqiV7GmRjJoPTA4bKP5wfP5QMM4j0IMb3161IUId66ddq
         dTNUOYAn7snf205I+d1V/cG9p4Vb6WIPj4pqE4QGudnm7VRy8OS0dqKiQcpQm8R09qYb
         Iz3z3dHB+pKzB0qLhBPYc5/T2DXxSYymhQJRxe/tvNnXk3WPPNf0B5JDI+0JYOINcAqM
         t0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717147933; x=1717752733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plB5SAM6IxvDio+P+8hN6eVaq+FHOovulQhKLCG8UQo=;
        b=I6gq//6Z/f1Xoi6005JF8Jt+MezzzBaewma05WcZdAJg0otQtqSSI9R6diNkWbmK4o
         nCawdyUU5iyuPpP+F56cfknIkzOtvYeehtzhBvA9fUJrL+q5s77sbrbx1w4ZQlr0Qo1m
         D9we8+E6Gc6oblU/jZFmPTCqPNY23uSECZPn6gDD0w+YlFfZl9k8U909xSR2qpndQOG7
         xoJSyyc7S6F85Q+8SsPSL6SRQe36Q63ysYMDvl6Zw6Z+CamHjaLvw5boXAcobCJa0c56
         D8UbwBY3FMgfR7snuC2+V9fgLUEioEL3cmSUoNksYleke0uXHqEGMSiFDPlpFuR5eqJA
         FT1w==
X-Forwarded-Encrypted: i=1; AJvYcCWzenjyFCsdaJs5etrQhRbbMSkGO8U3wnsvCZchSNjAyE7j3vZsh1vs683bIjwZwC9Q1JoIt19WKvbVxUkfEVfALOOEgimOec5GlKZZ
X-Gm-Message-State: AOJu0Yyo+7Wm7tkM/8iw9Kpd400W8EUWiMRq1or6G29YBXTQiwFhc3Zw
	fOcbfV4w1771R1EO5CpwNLDDdOThWVwH6+r/FtoDpRKH/rKXksYb
X-Google-Smtp-Source: AGHT+IE0bKHCwG5bfyvuPS7N7Apz8rTAjCab6PPLcxedkbysqK6uLhGHr5+E0AiGg3Sxa4fUof6gSg==
X-Received: by 2002:a05:600c:4f95:b0:420:151e:b205 with SMTP id 5b1f17b1804b1-4212e0d30cdmr12779385e9.39.1717147932369;
        Fri, 31 May 2024 02:32:12 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212709d4c7sm49326525e9.38.2024.05.31.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:32:11 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui.Pan@amd.com,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alex Hung <alex.hung@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix a handful of spelling mistakes
Date: Fri, 31 May 2024 10:32:11 +0100
Message-Id: <20240531093211.498880-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a few spelling mistakes in dml2_printf messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 6 +++---
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 8062144a5a6d..e7e6751f4477 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -5731,7 +5731,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 		dml2_printf("DML: Tvm: %fus - time to fetch vm\n", s->TimeForFetchingVM);
 		dml2_printf("DML: Tr0: %fus - time to fetch first row of data pagetables\n", s->TimeForFetchingRowInVBlank);
 		dml2_printf("DML: Tsw: %fus = time to fetch enough pixel data and cursor data to feed the scalers init position and detile\n", (double)s->LinesToRequestPrefetchPixelData * s->LineTime);
-		dml2_printf("DML: To: %fus - time for propogation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
+		dml2_printf("DML: To: %fus - time for propagation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
 		dml2_printf("DML: Tvstartup - TSetup - Tcalc - TWait - Tpre - To > 0\n");
 		dml2_printf("DML: Tslack(pre): %fus - time left over in schedule\n", p->VStartup * s->LineTime - s->TimeForFetchingVM - 2 * s->TimeForFetchingRowInVBlank - (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime - p->TWait - p->TCalc - *p->TSetup);
 		dml2_printf("DML: row_bytes = dpte_row_bytes (per_pipe) = PixelPTEBytesPerRow = : %u\n", p->PixelPTEBytesPerRow);
@@ -8268,7 +8268,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	dml2_printf("DML::%s: mode_lib->ms.DCFCLK = %f\n", __func__, mode_lib->ms.DCFCLK);
 	dml2_printf("DML::%s: mode_lib->ms.FabricClock = %f\n", __func__, mode_lib->ms.FabricClock);
 	dml2_printf("DML::%s: mode_lib->ms.uclk_freq_mhz = %f\n", __func__, mode_lib->ms.uclk_freq_mhz);
-	dml2_printf("DML::%s: urgent latency tolarance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
+	dml2_printf("DML::%s: urgent latency tolerance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
 #endif
 
 	mode_lib->ms.support.OutstandingRequestsSupport = true;
@@ -11089,7 +11089,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 				if (display_cfg->plane_descriptors[k].immediate_flip && mode_lib->mp.ImmediateFlipSupportedForPipe[k] == false) {
 					mode_lib->mp.ImmediateFlipSupported = false;
 #ifdef __DML_VBA_DEBUG__
-					dml2_printf("DML::%s: Pipe %0d not supporing iflip!\n", __func__, k);
+					dml2_printf("DML::%s: Pipe %0d not supporting iflip!\n", __func__, k);
 #endif
 				}
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
index f2e2250d28d3..6eb3fec87ec1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
@@ -1988,7 +1988,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 	dml2_printf("DML::%s: mode_lib->ms.FabricClock = %f\n", __func__, mode_lib->ms.FabricClock);
 	dml2_printf("DML::%s: mode_lib->ms.uclk_freq_mhz = %f\n", __func__, mode_lib->ms.uclk_freq_mhz);
 	dml2_printf("DML::%s: max_urgent_latency_us = %f\n", __func__, mode_lib->ms.support.max_urgent_latency_us);
-	dml2_printf("DML::%s: urgent latency tolarance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
+	dml2_printf("DML::%s: urgent latency tolerance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
 #endif
 
 	mode_lib->ms.support.OutstandingRequestsSupport = true;
@@ -8131,7 +8131,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 		dml2_printf("DML: Tvm: %fus - time to fetch vm\n", s->TimeForFetchingVM);
 		dml2_printf("DML: Tr0: %fus - time to fetch first row of data pagetables\n", s->TimeForFetchingRowInVBlank);
 		dml2_printf("DML: Tsw: %fus = time to fetch enough pixel data and cursor data to feed the scalers init position and detile\n", (double)s->LinesToRequestPrefetchPixelData * s->LineTime);
-		dml2_printf("DML: To: %fus - time for propogation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
+		dml2_printf("DML: To: %fus - time for propagation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
 		dml2_printf("DML: Tvstartup - TSetup - Tcalc - TWait - Tpre - To > 0\n");
 		dml2_printf("DML: Tslack(pre): %fus - time left over in schedule\n", p->VStartup * s->LineTime - s->TimeForFetchingVM - 2 * s->TimeForFetchingRowInVBlank - (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime - p->TWait - p->TCalc - *p->TSetup);
 		dml2_printf("DML: row_bytes = dpte_row_bytes (per_pipe) = PixelPTEBytesPerRow = : %u\n", p->PixelPTEBytesPerRow);
@@ -10959,7 +10959,7 @@ bool dml2_core_shared_mode_programming(struct dml2_core_calcs_mode_programming_e
 				if (display_cfg->plane_descriptors[k].immediate_flip && mode_lib->mp.ImmediateFlipSupportedForPipe[k] == false) {
 					mode_lib->mp.ImmediateFlipSupported = false;
 #ifdef __DML_VBA_DEBUG__
-					dml2_printf("DML::%s: Pipe %0d not supporing iflip!\n", __func__, k);
+					dml2_printf("DML::%s: Pipe %0d not supporting iflip!\n", __func__, k);
 #endif
 				}
 			}
-- 
2.39.2


