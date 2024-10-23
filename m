Return-Path: <linux-kernel+bounces-379000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4ED9AD87B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326CA1F22C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8DF1FF021;
	Wed, 23 Oct 2024 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="WapHcoDt"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991F91CCB31
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729726575; cv=none; b=rqh4JsHDaPmhJD+RNlaFrAz65X4mH6vSrmaLGZqc02haI1zAGO8fX94mh7h5INofzWsIyX/73XLJJFtSJLFJLpWVgr+scxxhCeapYSXcj7r3yOL345rG3ceB8Gnq2vMYqpEDGMEKtanY70qBmX/lNjs9gAwV9BL/8F/zssH8YtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729726575; c=relaxed/simple;
	bh=KWHcT982DYDGFB/gQdzNCBlUMvMAGFMVeTv80N7sStc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+Urj8e9uAjjvmUCAOBuNGkaL9QSCxMenh/BmzBZbsxe+XuadUdh5D129eIQ56nftTmRXrGbJ5rTaK3AyP+nb+PLr6HYB0sq//vQHnClr4mTpKRnNzdhIYOAMnMH0fOrAVdwLL8apsIfjeuohg6rep99mc1BAVelDtusUD3UuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=WapHcoDt; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20c803787abso2800225ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729726573; x=1730331373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2O3NkkjIemIsAieDahgo6WCW7UZHnrJROVrMuNKxroU=;
        b=WapHcoDtRQB+CBC1NYmZjoVHWlX31y+ERb2nIk/xcDMZeVfSQSSdYzyEiUNuPffnWU
         Oqp/qx1ZPKUMDc/FGbpDHd4anR3Ytn8Dx67hRLtmJC4MXTPY5Z2xr91SNCMmtGf1zIR+
         Dq6Scct7Ws/ff1Sw8OQgqtE2+uc0HWIMShxmisRdFygHkIPX2u4xkDszn2NNTfTmQwBn
         ZFoLjoWHbSRHctxM/Fb2YexTUwC1PQsr8/pMSa0gEYwfSoTMlOUDiqhZsqPVGXPiQuFD
         Fr5DAQL3mRPkz0I574ZxcLX3roxU/W70q/P6YZZpYNcqzLUGsbbt7p+Mj0IOjjhEGu/5
         iOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729726573; x=1730331373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2O3NkkjIemIsAieDahgo6WCW7UZHnrJROVrMuNKxroU=;
        b=DNNWyNhTyy2DHywlOfcwoxB7m9LFFZF1pz/RO1AbrWoEOtRhPs/U0IX/dQ8WtUIcjh
         z/oK8mLOXY6R2ZArrr2lFhVaWJzeZnBPSiqB+w7AD1KqSx+Hm74aAW56uXLGc8pKO+SB
         yl4/wuuPjajOi+NX5K7eT+eGR9tYiyOp8b2xS15NLXYN3un30Cb+aYY9XMTZn+tbyT/+
         kLAGOK4G7kSfoha3fIOareeFTjFP7DiTh2P4toYP3ecRN/6iu93DScV+jeFN0iIoX6X5
         CrDjWUHqt5g6yLOM1JUZElEqGKke1aedIOGEGSAPJZI0cMSJWrB20sx899c1DwCvRhaW
         HGVw==
X-Forwarded-Encrypted: i=1; AJvYcCVYL1EknmkVpDXa7Spt/IqDwCsfbzJKN1+0v1YNO/jRDlSNRrV1yUypg2MA8ukEht+XCtLJM/qV3pALFPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAYRwKyJKkjSvJvfrFnElWKJeQG54lIYlUBjNHVmGjX7T5PZE/
	AGcYR7TRZk0ZDu/b6cZq2O6VwRkx5JAEi+t5l1TiD5tjOzGHkDOhhX8h+LbAdOQ=
X-Google-Smtp-Source: AGHT+IHwaFUU21df+imHVfe6pTP9I9aELH11EYkAeXYd/RsFrtAI3BUr3gcBnM47ZiLm1gigdv3+Ug==
X-Received: by 2002:a17:902:ce8d:b0:20c:ea22:3317 with SMTP id d9443c01a7336-20fb89ffc5bmr2049015ad.29.1729726572793;
        Wed, 23 Oct 2024 16:36:12 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.70])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e7eee89bfsm62534695ad.29.2024.10.23.16.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:36:12 -0700 (PDT)
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
	michal.wajdeczko@intel.com,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 RESEND] [next] drm/xe/guc: Fix dereference before NULL check
Date: Wed, 23 Oct 2024 17:33:55 -0600
Message-ID: <20241023233356.5479-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer list->list is dereferenced before the NULL check.
Fix this by moving the NULL check outside the for loop, so that
the check is performed before the dereferencing.
The list->list pointer cannot be NULL so this has no effect on runtime.
It's just a correctness issue.

This issue was reported by Coverity Scan.
https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600335

Fixes: 0f1fdf559225 ("drm/xe/guc: Save manual engine capture into capture list")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
---
V3 -> V4: - Corrected the Fixes tag
          - Added Reviewed-by tag
V2 -> V3: - Changed Null to NULL in the changelog
          - Corrected typo in the changelong
          - Added more description to the changelong
	  - Fixed the link for Coverity Report
	  - Removed the space after the Fixes tag
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

