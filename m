Return-Path: <linux-kernel+bounces-414929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 168B09D2F69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F72B23BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1241D358B;
	Tue, 19 Nov 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FsQhm00q"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D11D3195;
	Tue, 19 Nov 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047815; cv=none; b=HIq3dRr/q5JRDhrTGLcn/08Uto3/bHutVFGXGkm33fHxn7HzYwTjr2nsuwXg5zFr8ocvl8sc7U+t4uyqPiri3xQFzsuxGDcst3CG2uWcusxxQTT/JzHIrLbohWLo6cGxktTfaLtdejR8TdnOxsGljsbDE5IGOLFnGP6f12V9AGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047815; c=relaxed/simple;
	bh=CnuOZ+G3ThNNEmasSHzxM8ld9x27BcMXZ1h5gE+H0XE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uonmLPMNotnAM9eaMP1c1Hw2YB1K7QdQ78hzu0Sqsb6R6yMB86BAu1MP+ZU3PhY50qfZBvt2a4/pYItbfuTF195GLOhF3eIsY9RvxMzLAoJiNnyG4yB961Q27ng28C9TLJ5fZdD8Tvj7vDSyEtCoifl2AC3zQGk6qB/UorBKg3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FsQhm00q; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id DUkytck50PqyaDUkytUMqx; Tue, 19 Nov 2024 21:23:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732047809;
	bh=FN6W5Nw0/usd3+xzvpL3gptGh1Ltab0zPDw2vSLmM4U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FsQhm00qozxXMgu3E5JGxbABbzt50IvAJAzpPbzgcdWXod5n4B3Ej/vwbAQc42RkN
	 B59AU0DqbFTjU7n5LI1f9X2KWTzOhClBsVAPyaN7AXxYQti0mLhoul3ymr3cvvSVSq
	 XwqmiV5tp71HIShDQy5PPEjTCSmaSnhZrGxXzJmO3JWNxVX0O8N39CYdK9MC3HI9v5
	 FG24hYfByBMrPFvNAhQ7eoFiv4rZdCvMAsd6fOvJh5eF/YLvLt2qCJ1mEklcZGWmUC
	 S+KcGm0+3q7k7A0XqTOhOAHXBZpTeHW50lMNXqZjkHz5uLfpmWHCzi+9WTGPdq+oiz
	 3t/JhfMmq3f1g==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Nov 2024 21:23:29 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Evan Quan <evan.quan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Fix an error handling path in vega10_enable_se_edc_force_stall_config()
Date: Tue, 19 Nov 2024 21:23:18 +0100
Message-ID: <6584a62da5436ffd726d68e5dbdaf5eadde8af9d.1732047767.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of error after a amdgpu_gfx_rlc_enter_safe_mode() call, it is not
balanced by a corresponding amdgpu_gfx_rlc_exit_safe_mode() call.

Add the missing call.

Fixes: 9b7b8154cdb8 ("drm/amd/powerplay: added didt support for vega10")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
*Not* even compile tested only because of missing "hwmgr.h". I've not
checked on which arch it is supposed to run in order to cross-compile.

This patch is speculative, review with care!
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
index 3007b054c873..776d58ea63ae 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
@@ -1120,13 +1120,14 @@ static int vega10_enable_se_edc_force_stall_config(struct pp_hwmgr *hwmgr)
 	result = vega10_program_didt_config_registers(hwmgr, SEEDCForceStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
 	result |= vega10_program_didt_config_registers(hwmgr, SEEDCCtrlForceStallConfig_Vega10, VEGA10_CONFIGREG_DIDT);
 	if (0 != result)
-		return result;
+		goto exit_safe_mode;
 
 	vega10_didt_set_mask(hwmgr, false);
 
+exit_safe_mode:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
-	return 0;
+	return result;
 }
 
 static int vega10_disable_se_edc_force_stall_config(struct pp_hwmgr *hwmgr)
-- 
2.47.0


