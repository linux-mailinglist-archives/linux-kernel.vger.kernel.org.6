Return-Path: <linux-kernel+bounces-364449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A73699D4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318631F23BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F71B4F24;
	Mon, 14 Oct 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cVhrqnpb"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C9231C92
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923855; cv=none; b=QXuC9f6E6wfA45dHidpebuWFqX8ksWfOTJYhuVI8UqM+KYQXFOSkt3tmkCwrHib2RjzTb54hhDOG8cGs57xiWCKCfK3on9/ObTWnN9W4iQ130b+rS1RGETF59pFEBn+7fCjEPqWVNGrcFCkRS/kr6cz96wTVGTG1dTWydlVUGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923855; c=relaxed/simple;
	bh=bTtG4MB3yjrdSPMsQ2e3jywBt+U40h9Vr1j3XOPrBNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DvrDTp25bOnE74I16RtyDkUNRvO96ZOQ3/Bdj1X5jJ1Muf/5REmXyCdiLJ4wF8JYvQMhj9BwNvTvgD8wQKEDxP4IPLJuXLU23C64izaUerUnMNMVDcSrQyZEx+sOv4AejJbHOYOWZgvWYM1hFV3n3ja7LwCkACmi6hWiBQitQAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cVhrqnpb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so2032118b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728923854; x=1729528654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq6RmtQgXylpaIuQSD/eFivfyV/YbUHAedXEkzzSSXc=;
        b=cVhrqnpbKclAuARyWtF73cvf6JxI6cb5Oal04gv5+1y3HofmxXUZ66xOdXJFwoaaL2
         LurlygUEHq922C31Mw36x8UxXZShejvxwOFvD8F3MxMcrQTRhyaAcZYPHaZKsbtZ3DSc
         W/hsR8r/ElkhXQvAYnLSEE/MuPpaGpjarGESc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728923854; x=1729528654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eq6RmtQgXylpaIuQSD/eFivfyV/YbUHAedXEkzzSSXc=;
        b=GjnhjTka+vod5RzGxFhlA/Gp+egrceJTbrGiwdOF8LsMjfXgMiwiWJUncom3JEHrHR
         wKvA789qzixgtz2VM5TKu/aZnIvlEOAWllFZSmRlWtyePNmHv6lKwPZ4Pm14/6pl2lii
         fHHq8hFwBxIkMY5MgTsiZckxpM3MI4woGIp1e+FBW5M1Zw1Gw+0RBfUULMspfJRdENue
         pft69b92tQtf//tJAnL3c9xNueua6BnUVUJqu0EPuNo+OeFFz75M5DE6feNvmRB0DnhN
         byRQOtOArcRiaTKgqSs63WKQdq3O/4LAOUaILNE/eCkLk4MGnDlYwakgNyJkoxsKP4ja
         +DUw==
X-Forwarded-Encrypted: i=1; AJvYcCXrGF9bFo3f6d/kySDuZxqY/fGGFxwfjilbZxYl0VqT67XsE52RpamNcTpM81C4KtKFczVmxYoA0VS0t9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWCD7gxR/ROC7lSmZJIe6mW/nZI/cN+B6CN0bwqKWKNNUsubw
	imjLxAW/z26aHyI/sIlz8aCXyG5YuhSVbXhT4rRSxhsQTuJXEPi3LHqF3F2TmQ==
X-Google-Smtp-Source: AGHT+IFrI6AyFlAD+rPt6sq8RJjzjcPvxnHIHU5bh4fmZllt0MuEFWzqp3sZJTWGMBx/myacl4Lxew==
X-Received: by 2002:a05:6a00:9282:b0:717:9154:b5d6 with SMTP id d2e1a72fcca58-71e37f4ed89mr19746704b3a.22.1728923853741;
        Mon, 14 Oct 2024 09:37:33 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1e71:8a09:a3b:1e00])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e51dc0617sm4383693b3a.165.2024.10.14.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:37:32 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Sean Paul <sean@poorly.run>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/msm: Avoid NULL dereference in msm_disp_state_print_regs()
Date: Mon, 14 Oct 2024 09:36:08 -0700
Message-ID: <20241014093605.1.Ia1217cecec9ef09eb3c6d125360cc6c8574b0e73@changeid>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the allocation in msm_disp_state_dump_regs() failed then
`block->state` can be NULL. The msm_disp_state_print_regs() function
_does_ have code to try to handle it with:

  if (*reg)
    dump_addr = *reg;

...but since "dump_addr" is initialized to NULL the above is actually
a noop. The code then goes on to dereference `dump_addr`.

Make the function print "Registers not stored" when it sees a NULL to
solve this. Since we're touching the code, fix
msm_disp_state_print_regs() not to pointlessly take a double-pointer
and properly mark the pointer as `const`.

Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index add72bbc28b1..bb149281d31f 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -48,20 +48,21 @@ static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *b
 	}
 }
 
-static void msm_disp_state_print_regs(u32 **reg, u32 len, void __iomem *base_addr,
-		struct drm_printer *p)
+static void msm_disp_state_print_regs(const u32 *dump_addr, u32 len,
+		void __iomem *base_addr, struct drm_printer *p)
 {
 	int i;
-	u32 *dump_addr = NULL;
 	void __iomem *addr;
 	u32 num_rows;
 
+	if (!dump_addr) {
+		drm_printf(p, "Registers not stored\n");
+		return;
+	}
+
 	addr = base_addr;
 	num_rows = len / REG_DUMP_ALIGN;
 
-	if (*reg)
-		dump_addr = *reg;
-
 	for (i = 0; i < num_rows; i++) {
 		drm_printf(p, "0x%lx : %08x %08x %08x %08x\n",
 				(unsigned long)(addr - base_addr),
@@ -89,7 +90,7 @@ void msm_disp_state_print(struct msm_disp_state *state, struct drm_printer *p)
 
 	list_for_each_entry_safe(block, tmp, &state->blocks, node) {
 		drm_printf(p, "====================%s================\n", block->name);
-		msm_disp_state_print_regs(&block->state, block->size, block->base_addr, p);
+		msm_disp_state_print_regs(block->state, block->size, block->base_addr, p);
 	}
 
 	drm_printf(p, "===================dpu drm state================\n");
-- 
2.47.0.rc1.288.g06298d1525-goog


