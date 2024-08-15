Return-Path: <linux-kernel+bounces-288407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38CA9539CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217281C2349C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFCB52F70;
	Thu, 15 Aug 2024 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgJAUwqi"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6529533997
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745918; cv=none; b=eXfaEEGzqEGqOTqe5nEg9YtpA6CD0rQtAKiy4ZcGjPAI434N7TqB0FrSSrg76lSaVZdHG3olKj8rd/GRjCTGVICMzxlMB4dsu+t4aZIpv3PFDaa6tRExEXJBLKJ12/bhut0Otb7Wi/+1HyIpvG90Z17MNVRNq9fbD6FX6MpeIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745918; c=relaxed/simple;
	bh=0wyvGe+JV0V3SRioczmMV4iTQtfWk6g81SRtviAJFnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phAP6gLqyNo8XCVObz7MjH5CQFOnsgDruII06m1bdf8CY88CO67dEXkeywl4s2QxxAqGVGv2LOovvnchNhr5SAF5sJ4GR0X/8Z1b5YmPm6V1yGQm9xUqVkAtY8CL3IGRelY395WyNgKx8UGaTIcwWUtqEmJ9Xp3DWMdAqhM5cMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgJAUwqi; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso991881a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723745916; x=1724350716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FnL/caHC6IiZNXlhX4kwijSLCsO2WfzCGQwXH3dcl5Y=;
        b=LgJAUwqiXMZmjU6tBnFf9k7NACRwfA6qMRMt0zaegzDOUr5q0BCQQc1wpYM6QOAfTb
         lO1La4fOtFy/Omor4SVARA3mU0FaQWr2Gs4yJK7y4CdcBbTS9g6peiefnGslEH6XMnb8
         3CaWLY66Z4+rpeqqsZ1a3eMc/DfQfZxixHSkwheJloklKD48hxoR0mcFFWn/ekQHNRTX
         OIdgFqpEdWd5JZItszrtOBHkYt1EuSDsB9UfgL6egFpGg1oWF7I/mVGec8RYUJkKSv63
         2BR8+PXHUpQlgPb1qqd8+evLZcB6X7ID+P+K7jH4LN6sIf0PnO7D21tLY+xiCqDBddW/
         ba4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723745916; x=1724350716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnL/caHC6IiZNXlhX4kwijSLCsO2WfzCGQwXH3dcl5Y=;
        b=ucToGioNYrUxS5lnvR7Y0pcXhivrgfmtyKYbDWwjqEnG/wzgHMkC/uFS19WeTshp0h
         pT9TtqHgxo5bvUMkY3NpxzpQRJDxVeUcLlr3K/UDSVJn9cAzDH14YgLid4YiI8gLLyKm
         +ZqD6jAPqXVpQPHkLaEUTZOhNQrEw+zh8tZExYHldZw46VmURBO/VkWVQCBT/zqHKx9a
         7bojQUHpDtGF4lIM8efjsw8YwKte52/mpfZOhBsRSBu5ItrjEqqBvMMPjR9ZssY7nmBQ
         SlhK2ND42IL0WDpjSrmmBRdJBfKItzB9qE3eM+y8lYuhW16V/YpoahqOpEaz67QjaPh9
         A+DA==
X-Forwarded-Encrypted: i=1; AJvYcCVxx+7ClW1VGSic8sNYoDca2i+TR48i0O/DGL3o53KvpawX9UIb8AD3iV38zeH3nG3S+XrzBZj1CgrTOuZtVrquWvAP82vOdUD5kZ++
X-Gm-Message-State: AOJu0YzE7/gdqO1zW8kJ9o2/+i94Awuyphsf4f3gv11K3vu/pS3EudxH
	9UZoMh76IngteQwcaXtzPKJE/DeFTJo6B9QzGVexo04aGNcXi+M9
X-Google-Smtp-Source: AGHT+IHaWEF1sYe8fMDJJTy289IrVf+ene0AoBSSVJSdnZ0unYrhGoYRiXtaEVTlDXcbZZOme7pISg==
X-Received: by 2002:a17:90a:ea07:b0:2d3:b976:e30e with SMTP id 98e67ed59e1d1-2d3e00f091emr563041a91.37.1723745916391;
        Thu, 15 Aug 2024 11:18:36 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c89b8fsm77093a91.35.2024.08.15.11.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:18:36 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	airlied@linux.ie,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	Xinhui.Pan@amd.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix warning: Using plain integer as NULL pointer in dml2_pmo_dcn4.c
Date: Thu, 15 Aug 2024 18:18:25 +0000
Message-ID: <20240815181827.65159-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparse reportef following warnings:

'''
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c:614:53: warning: Using plain integer as NULL pointer
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c:615:58: warning: Using plain integer as NULL pointer
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c:617:53: warning: Using plain integer as NULL pointer
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c:727:52: warning: Using plain integer as NULL pointer
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c:728:52: warning: Using plain integer as NULL pointer
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c:729:57: warning: Using plain integer as NULL pointer
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c:788:52: warning: Using plain integer as NULL pointer
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c:789:55: warning: Using plain integer as NULL pointer
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c:790:57: warning: Using plain integer as NULL pointer
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c:958:67: warning: Using plain integer as NULL pointer
'''

This patch changes zero to NULL.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c
index 8952dd7e36cb..6d524e528491 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c
@@ -611,10 +611,10 @@ static bool subvp_subvp_schedulable(struct dml2_pmo_instance *pmo, const struct
 	int max_microschedule_us = 0;
 	int vactive1_us, vactive2_us, vblank1_us, vblank2_us;
 
-	const struct dml2_timing_cfg *svp_timing1 = 0;
-	const struct dml2_implicit_svp_meta *svp_meta1 = 0;
+	const struct dml2_timing_cfg *svp_timing1 = NULL;
+	const struct dml2_implicit_svp_meta *svp_meta1 = NULL;
 
-	const struct dml2_timing_cfg *svp_timing2 = 0;
+	const struct dml2_timing_cfg *svp_timing2 = NULL;
 
 	if (svp_stream_count <= 1)
 		return true;
@@ -724,9 +724,9 @@ static bool validate_svp_drr_cofunctionality(struct dml2_pmo_instance *pmo,
 	int drr_stretched_vblank_us = 0;
 	int max_vblank_mallregion = 0;
 
-	const struct dml2_timing_cfg *svp_timing = 0;
-	const struct dml2_timing_cfg *drr_timing = 0;
-	const struct dml2_implicit_svp_meta *svp_meta = 0;
+	const struct dml2_timing_cfg *svp_timing = NULL;
+	const struct dml2_timing_cfg *drr_timing = NULL;
+	const struct dml2_implicit_svp_meta *svp_meta = NULL;
 
 	bool schedulable = false;
 
@@ -785,9 +785,9 @@ static bool validate_svp_vblank_cofunctionality(struct dml2_pmo_instance *pmo,
 	int vblank_stream_count = 0;
 	int svp_stream_count = 0;
 
-	const struct dml2_timing_cfg *svp_timing = 0;
-	const struct dml2_timing_cfg *vblank_timing = 0;
-	const struct dml2_implicit_svp_meta *svp_meta = 0;
+	const struct dml2_timing_cfg *svp_timing = NULL;
+	const struct dml2_timing_cfg *vblank_timing = NULL;
+	const struct dml2_implicit_svp_meta *svp_meta = NULL;
 
 	int prefetch_us = 0;
 	int mall_region_us = 0;
@@ -955,7 +955,7 @@ bool pmo_dcn4_init_for_pstate_support(struct dml2_pmo_init_for_pstate_support_in
 
 	struct display_configuation_with_meta *display_config;
 	const struct dml2_plane_parameters *plane_descriptor;
-	const enum dml2_pmo_pstate_strategy (*strategy_list)[4] = 0;
+	const enum dml2_pmo_pstate_strategy (*strategy_list)[4] = NULL;
 	unsigned int strategy_list_size = 0;
 	unsigned int plane_index, stream_index, i;
 
-- 
2.43.0


