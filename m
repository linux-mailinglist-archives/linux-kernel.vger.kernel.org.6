Return-Path: <linux-kernel+bounces-359605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165D4998E08
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3619BB26E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9285C199FAB;
	Thu, 10 Oct 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="A0ZHSi2e"
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3151319992D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579564; cv=none; b=pCbD8bbIx85TNLjPWm6y9VI7doKJTAYa9E5m15Yzndr7i6TTFYXcfsf9j0k2uUOIwAeg3Uo+pBUN1s+bdGe9pcL8y5yIgZ0sRVJXGZpyirnsegzU7yg1csLNpNiQ3r+hI/xF7np/eerQqAsSJ40n3sLM8wV6WyRa5spMdmtOqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579564; c=relaxed/simple;
	bh=KWHcT982DYDGFB/gQdzNCBlUMvMAGFMVeTv80N7sStc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRWp9qTrkaNe+LXrJaxz7hCc29C9FBiXV/UhAYU+rUTOs5yMV9co1gGhLP7M7jCGuuocOCRPS9s3cPpSvW3kaxI4UeSsKcgPMDy4cDv+zuQCXXuIhMiZWke6qkfwtRP9OO2npb6ChdwNVJBvUml4wwCbhuWORo4GNIFdxmZthjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=A0ZHSi2e; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3e3e7ada8c7so705552b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728579561; x=1729184361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2O3NkkjIemIsAieDahgo6WCW7UZHnrJROVrMuNKxroU=;
        b=A0ZHSi2eomUHDZDBHFDgyLnWpi6w3N2EL5sO2MZGntL6E0WB7nZASMQFOtxG18TdhA
         79987QvIPfux23qRM2mkoNKEymFMAO5gCXEeNmFisevD+0RvbwA/YI44q0i563t0a3XQ
         IrX0KEp4Wpol6QCWwol816pQOb89mmKugMqGriW9IO3htLMdwsM/pM35po5p2HIApcma
         yj6pozKfeUrna1MctJ9OhbKhlouGFT8Hb7uFiZspvcL1eEeRq+HBNJFNv+r0FwuSPJK4
         orHe6orGg/7b7g8le+PmawxX1pJeVe9PMZzKwAH4NK/XvE2Dh5Dl44+4zioefiyEp6oj
         naSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728579561; x=1729184361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2O3NkkjIemIsAieDahgo6WCW7UZHnrJROVrMuNKxroU=;
        b=bL68qqGbqLCFpAixCmWXJh+TPm2jbqvtajhv0ux6JXIycfUNDgR3l9jpZbJZov18L4
         1X4Uk5cUq4lQJ/QJBIvuG14Jr14gWNI500Px2RG+TqA5wAl6ij0nCIlekgqiRkonH5Hx
         znkfUlAMgXvjpxUCcOUEc+u2UB31KSezWdyn/sodFlUhee9XLmUpJDCD3NJEy2WNGqqX
         ZXvZxUR0bL6HGjBnU3IrjE9pmuEgrq79UOz0lKho/4r5pOsdn/w4tJNSshd4tVKucOjA
         eHo6DEGKdOtdqNEkhhEtkhWX0k1Mibi6SBSR8Zh0xTNYZ0aBWKXLKCfXZPT+izjKUNTk
         M8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWkUtsHaB3tiC+NE2w+CDKFlDuK2OP8/PclB624btq9/Rprm+9WoWXHRKBTrl4nTRWC/1Rq/ZMry2AGnXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vBA6jxYKXMgV7Rbix/kY/M3vQ0u7gfgXze5anX+iOj511DEk
	+woVlwiIxugfz+5Tu4gvpZ1Ep13ZvpzQ/cioovUkkChi0yDJEC3cjL9u01oqjoc=
X-Google-Smtp-Source: AGHT+IEQECyAfbtTxECBBfSegcXyiHPvb+HbTmNxdnj/9M9cty89n8mvsWrqwn4N/Jko0Uax4nMEPA==
X-Received: by 2002:a05:6808:19a0:b0:3e3:9ba8:5af0 with SMTP id 5614622812f47-3e3e66cc39dmr4801528b6e.22.1728579561189;
        Thu, 10 Oct 2024 09:59:21 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.16])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ea449688e3sm1238289a12.87.2024.10.10.09.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 09:59:20 -0700 (PDT)
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
Subject: [PATCH V4] drm/xe/guc: Fix dereference before NULL check
Date: Thu, 10 Oct 2024 10:57:59 -0600
Message-ID: <20241010165801.3913-1-everestkc@everestkc.com.np>
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


