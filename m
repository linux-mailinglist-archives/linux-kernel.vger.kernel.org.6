Return-Path: <linux-kernel+bounces-357907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 188E09977AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4864F1C2217A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACA31E2831;
	Wed,  9 Oct 2024 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="uAQmhduh"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48981A0AFA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510044; cv=none; b=K+eY/q7Ry1yfOVSTABCoBLDrEXBULfgSj1O0DnoUD9gRs3TwZzF6JGewYK50v804rFK1BNRPQrbWjVX/n8Xjqnq8PNKOoOYngXe20xLa3gFvgexjPWDgPFB+VUUQ/AtEMyBd2kSAfHI0GfyyHsi7x5iyoPxgyWoLugvOKVi7rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510044; c=relaxed/simple;
	bh=xmvB2RyLMa1YACntjup38BYSkXAwWiROYL+k31jpxMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f167NMjKN6AKzWj6sduoeq5whNkD55QV/pF8H7v9uyH7V0LVro0luDD0iKVsku3nkUzD+XICq1aLbG8NgHeNxGBSVFKN4/Q/xXUo5Q7nYIiUkk5ke4DnbX1hyFt2KTNkYXzSgZV+jjzVvIQZqrho/02CPsBit9f4yjE11mQNG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=uAQmhduh reason="signature verification failed"; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71df0dbee46so214896b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728510041; x=1729114841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/X1R7jziJAUOGlYud471jpMxA58653P4VmVwYBUwEFw=;
        b=uAQmhduhmCgiK8mphc+5rGOcy0OI65zm+XEVegUjogxzxO5R668XxLOsR/XC7I5gvL
         tpQdQ5XALzCHqy0bXCY/bUB2hV7qa2A0IDwHvHMgXKsOMJ1gqcnYIjyWqrHlLCDtSRxM
         xyFoTUw1d0CQYx4Wff+6ZPRj8RWcY4sDQ43GiUx+pO/7FXJwNpC5sucMHLPCqrokpH6S
         0oeL/pmEMG+LzraxwZYstbZwkAhC7b4YtVH6HMvsYQcdpjiNNRZf/0d0bJZflhM8NMJx
         v8X4urvCvTk5RfhuQzZkP7GLd1qCME2+7sAN3OH3B1vNdAf25dX2+0JZfTBu8VpWBeVQ
         W3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728510041; x=1729114841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/X1R7jziJAUOGlYud471jpMxA58653P4VmVwYBUwEFw=;
        b=l2KVLPKn5QsmYtvNh3dyYSn2mQcTJ+enUBH7c47dgsCrlXkmo+Wkhw3wvkrQuGTG93
         07DZWOhY28LKKd8NtA/MluGE3YP7HDzy+bpgEhB/sDwMdkNhoxKFbUbFSALvM37sC6YM
         JjleNp5bBHdOKJRo+V7Mc4E5mSYMDxIrOnMwRjcdD9RDFpgTPSmEAyoC5HvvpEE2hZyX
         AfHYCvYrRdCaw9E4GGq6mngQNuK9MlQ52DfuK+8GWJ5NZZ6N4ySO7J5m31LeCImJylQy
         k9YPASgDmN95T6HRtUHhhIlZuVKCS/jxtv/QdLpieQia9VpbIcUuDGFtCCRtVxkyFp9b
         zhcA==
X-Forwarded-Encrypted: i=1; AJvYcCXznVoqCL9dwNaGA4S+vZQVpdnsV3shmcbVa7QOeKcXNM2z3hZP6XaJjb60q0rv9rbvjTe4bpWx5nzYaBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3R2h/MxkpoaDsI/+EDQvm1xJndZCJE4LwOptLYUcM/g7p1KU
	4WRwQFDjZmS/gs6HDK47rIR+K4essazzc1eMjPVTRMUIfdw/lbPeF2Mb75a24k8=
X-Google-Smtp-Source: AGHT+IEVjxb8q3sxQHY7BRbeLePk3SvJC2jHMCY+loRxISySa+TSK3hZmXPkiAMN30Y1g+VBgiK0xw==
X-Received: by 2002:a05:6a00:2394:b0:71e:1b6d:5a94 with SMTP id d2e1a72fcca58-71e1db64896mr6487949b3a.5.1728510040550;
        Wed, 09 Oct 2024 14:40:40 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.158])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71e03288a37sm5717000b3a.155.2024.10.09.14.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:40:40 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	dan.carpenter@linaro.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] drm/xe/guc: Fix dereference before Null check
Date: Wed,  9 Oct 2024 15:39:20 -0600
Message-ID: <20241009213922.37962-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer list->list is derefrenced before the Null check.
Fix this by moving the Null check outside the for loop, so that
the check is performed before the derefrencing.

This issue was reported by Coverity Scan.
https://scan7.scan.coverity.com/#/project-view/51525/11354
?selectedIssue=1600335

Fixes: a18c696fa5cb ("drm/xe/guc: Fix dereference before Null check")

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
V1 -> V2: - Combined the `!list->list` check in preexisting if statement
	  - Added Fixes tag 
	  - Added the link to the Coverity Scan report 

 drivers/gpu/drm/xe/xe_guc_capture.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
index 41262bda20ed..947c3a6d0e5a 100644
--- a/drivers/gpu/drm/xe/xe_guc_capture.c
+++ b/drivers/gpu/drm/xe/xe_guc_capture.c
@@ -1531,7 +1531,7 @@ read_reg_to_node(struct xe_hw_engine *hwe, const struct __guc_mmio_reg_descr_gro
 {
 	int i;
 
-	if (!list || list->num_regs == 0)
+	if (!list || !list->list || list->num_regs == 0)
 		return;
 
 	if (!regs)
@@ -1541,9 +1541,6 @@ read_reg_to_node(struct xe_hw_engine *hwe, const struct __guc_mmio_reg_descr_gro
 		struct __guc_mmio_reg_descr desc = list->list[i];
 		u32 value;
 
-		if (!list->list)
-			return;
-
 		if (list->type == GUC_STATE_CAPTURE_TYPE_ENGINE_INSTANCE) {
 			value = xe_hw_engine_mmio_read32(hwe, desc.reg);
 		} else {
-- 
2.43.0


