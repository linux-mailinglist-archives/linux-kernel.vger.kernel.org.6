Return-Path: <linux-kernel+bounces-312168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBBB9692FB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17721C22B5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE31CE6F1;
	Tue,  3 Sep 2024 04:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QkSB7icF"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6A2904
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725339534; cv=none; b=hvCSIKsGpVQyWjWSPce/veBCTX9SaZ+0kTtVVchLNOPwISW6tFrZqruF1/dky7jAw8ebV31A8ce8ckgxHODLbhpnEE5urW3N2iVVfNuYmejZhbvqfKLlgL6ElcXfbrpEIt+iPpZkbKnTcIjAIkhGsAweRE7wdBG/wvtpRqajSxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725339534; c=relaxed/simple;
	bh=8o85C8EbJOznl3BLIG+cQfhkgOXbYiQlzAjPgnN+QnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYR1naN9IHPRVnMdxGavXBUa2wTPcyUoukEP1rSi6c140jpEHASuNYxHMN/ddqZkyXwRxGIyhG2t6dfZJf3nK9WvcwyLXbd8wpGIuyQqqJxquMoRI/E3pyKBZ/zRv/CTN5WznGf8vRmsFCmk7Zb/NcKCJTOHW+uC1X839xFZnzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QkSB7icF; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e017808428so1250550eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725339532; x=1725944332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPhZdW35wA0lKARiWkZjmf+aWFeCFp2ESl8o+4bQ7rQ=;
        b=QkSB7icFuZD4j2OvZYLn0LuHd2Zs//PGbdQKPeb2vTgN82g7rCGDGzx3CVU9L4jfCi
         fVMJVSN6CjXOLxFDwzgfiZIM6mGmbITLyyc9ab9hyxuSzXB7A3ex3YNyxT7NSw8uX0zB
         D6ftEYuvHb++lGwyG4EP0RU38QXEVDUwZUj5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725339532; x=1725944332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPhZdW35wA0lKARiWkZjmf+aWFeCFp2ESl8o+4bQ7rQ=;
        b=RsXpi04wUKwl/rkUL2zlM4CWT776VK8ts0OnwGHI4LF08XYyH/1oDg1S4j6zAbUdzb
         MnznT8ASx4ZLiJYdOkjAPNiLqqDMfXj39WutDF1eg3qpIxO0IKIimZC4fTUPawStyTHO
         7pI0+OM0XmsiQyOMyFzCnTnNBGGkTvxK9uPO0vB2E9cFRHm3ixvh3Y4U4NotJFntbzaD
         I3LUJtH3ihGqF/DAjSnp+XQVnoPfSkxL5JsrgafWJOwxZiuxmRd4XIrcM28VkFv3v8LP
         Ay50G/VetUxy1N9bain9LI5qcD2hgRde10jKWaLVJwaq0aWTMPQOzai4xmvwHK0bSwOF
         r9qw==
X-Forwarded-Encrypted: i=1; AJvYcCVXnLBE99Mh69N/aMlDA857zxmmGXtX4gLPmR28V3706IK1W/+YjHrtXh3NH0xnZXX+ZxL1WA2oExAH5OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPl9V6Jc2MP1Euyzl3jBlQsvui8N3hQn/MIgBoCTQcPUd9qy3B
	PxuwSfFRMM+ft/hCpR61gLGET8nqAcutXP+I1NVJ3/cw0DE7hSzuXuH3SmqkqQ==
X-Google-Smtp-Source: AGHT+IG8me1bSENR4wRx/OKAQejDcXWKY5+HZ/AzEltyhw/WRh8aAe2pXkZG/Vr0P7/zTKqlGwLNxQ==
X-Received: by 2002:a05:6358:4429:b0:1aa:b9f2:a0c4 with SMTP id e5c5f4694b2df-1b8117bccf4mr268303755d.11.1725339531470;
        Mon, 02 Sep 2024 21:58:51 -0700 (PDT)
Received: from photon-a190c64c6e7e.. ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8d06c9340sm3599334a91.22.2024.09.02.21.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:58:51 -0700 (PDT)
From: sikkamukul <mukul.sikka@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: evan.quan@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@linux.ie,
	daniel@ffwll.ch,
	Jun.Ma2@amd.com,
	kevinyang.wang@amd.com,
	sashal@kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Bob Zhou <bob.zhou@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Mukul Sikka <mukul.sikka@broadcom.com>
Subject: [PATCH v5.15-v5.10] drm/amd/pm: Fix the null pointer dereference for vega10_hwmgr
Date: Tue,  3 Sep 2024 04:58:09 +0000
Message-Id: <20240903045809.5025-1-mukul.sikka@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bob Zhou <bob.zhou@amd.com>

[ Upstream commit 50151b7f1c79a09117837eb95b76c2de76841dab ]

Check return value and conduct null pointer handling to avoid null pointer dereference.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Mukul Sikka <mukul.sikka@broadcom.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 10678b519..304874cba 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3391,13 +3391,17 @@ static int vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, co
 	const struct vega10_power_state *vega10_ps =
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	struct vega10_single_dpm_table *sclk_table = &(data->dpm_table.gfx_table);
-	uint32_t sclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].gfx_clock;
 	struct vega10_single_dpm_table *mclk_table = &(data->dpm_table.mem_table);
-	uint32_t mclk = vega10_ps->performance_levels
-			[vega10_ps->performance_level_count - 1].mem_clock;
+	uint32_t sclk, mclk;
 	uint32_t i;
 
+	if (vega10_ps == NULL)
+		return -EINVAL;
+	sclk = vega10_ps->performance_levels
+			[vega10_ps->performance_level_count - 1].gfx_clock;
+	mclk = vega10_ps->performance_levels
+			[vega10_ps->performance_level_count - 1].mem_clock;
+
 	for (i = 0; i < sclk_table->count; i++) {
 		if (sclk == sclk_table->dpm_levels[i].value)
 			break;
@@ -3704,6 +3708,9 @@ static int vega10_generate_dpm_level_enable_mask(
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	int i;
 
+	if (vega10_ps == NULL)
+		return -EINVAL;
+
 	PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
 			"Attempt to Trim DPM States Failed!",
 			return -1);
@@ -4828,6 +4835,9 @@ static int vega10_check_states_equal(struct pp_hwmgr *hwmgr,
 
 	psa = cast_const_phw_vega10_power_state(pstate1);
 	psb = cast_const_phw_vega10_power_state(pstate2);
+	if (psa == NULL || psb == NULL)
+		return -EINVAL;
+
 	/* If the two states don't even have the same number of performance levels they cannot be the same state. */
 	if (psa->performance_level_count != psb->performance_level_count) {
 		*equal = false;
@@ -4953,6 +4963,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].gfx_clock =
@@ -5004,6 +5016,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	vega10_ps->performance_levels
 	[vega10_ps->performance_level_count - 1].mem_clock =
@@ -5239,6 +5253,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 		return;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5261,6 +5278,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr *hwmgr)
 
 	ps = (struct pp_power_state *)((unsigned long)(hwmgr->ps) + hwmgr->ps_size * (hwmgr->num_ps - 1));
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return;
+
 	max_level = vega10_ps->performance_level_count - 1;
 
 	if (vega10_ps->performance_levels[max_level].gfx_clock !=
@@ -5451,6 +5471,8 @@ static int vega10_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_
 		return -EINVAL;
 
 	ps = cast_const_phw_vega10_power_state(state);
+	if (ps == NULL)
+		return -EINVAL;
 
 	i = index > ps->performance_level_count - 1 ?
 			ps->performance_level_count - 1 : index;
-- 
2.39.4


