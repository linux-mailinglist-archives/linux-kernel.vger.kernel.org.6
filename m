Return-Path: <linux-kernel+bounces-345737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C298BA92
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49F61C235A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA7B1BF324;
	Tue,  1 Oct 2024 11:05:08 +0000 (UTC)
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309931A08B2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.5.119.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780708; cv=none; b=Hk9TUFYkjPcz6icbCoU1AqpfmeVR99wJYaAX0VcifuCsjkv1WxX1wpNjBiyx6vraB5onVd+Oq1/zLYB7evJb/+R9t4EXsOUkqwOjrNJDcHD4AMhCz3APP5J7Mk631f88S/4UzAeehxYHlHJIqtJm7jlF7bIMixhZjlKku5ds1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780708; c=relaxed/simple;
	bh=+rHmXUJz9yFvw6S5U3VrCkjI9zxfOHt3F8VTxWbRo1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e4rn6kASqcOQorDRED4Sym8iWCBxJTBWNKOMNLvF1ivhgRVRSPOKA0/wOx+LRydU2bb9646h917dmRjsfzGq2cqfctsE8VT9LmkyCACMVofQIlOP2Jy2NZTXmPhSU3brXlORF3C4fORgC/80dWzT09FOoK9G8SDbQsrkyTY5VBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru; spf=pass smtp.mailfrom=mcst.ru; arc=none smtp.client-ip=212.5.119.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcst.ru
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
	by tretyak2.mcst.ru (Postfix) with ESMTP id F3FF5102392;
	Tue,  1 Oct 2024 14:05:00 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
	by tretyak2.mcst.ru (Postfix) with ESMTP id EAC41101765;
	Tue,  1 Oct 2024 14:04:10 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
	by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 491B4AwQ005662;
	Tue, 1 Oct 2024 14:04:10 +0300
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
        Kenneth Feng <kenneth.feng@amd.com>, Simona Vetter <simona@ffwll.ch>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] drm/amd/pm: check return value of amdgpu_irq_add_id()
Date: Tue,  1 Oct 2024 13:57:27 +0300
Message-Id: <20241001105727.1582368-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
	 bases: 20111107 #2745587, check: 20241001 notchecked
X-AV-Checked: ClamAV using ClamSMTP

amdgpu_irq_ad_id() may fail and the irq handlers will not be registered.
This patch adds error code check.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index 79a566f3564a..109df1039d5c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -647,28 +647,41 @@ int smu9_register_irq_handlers(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_irq_src *source =
 		kzalloc(sizeof(struct amdgpu_irq_src), GFP_KERNEL);
+	int ret;
 
 	if (!source)
 		return -ENOMEM;
 
 	source->funcs = &smu9_irq_funcs;
 
-	amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
+	ret = amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
 			SOC15_IH_CLIENTID_THM,
 			THM_9_0__SRCID__THM_DIG_THERM_L2H,
 			source);
-	amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
+	if (ret)
+		goto err;
+
+	ret = amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
 			SOC15_IH_CLIENTID_THM,
 			THM_9_0__SRCID__THM_DIG_THERM_H2L,
 			source);
+	if (ret)
+		goto err;
 
 	/* Register CTF(GPIO_19) interrupt */
-	amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
+	ret = amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
 			SOC15_IH_CLIENTID_ROM_SMUIO,
 			SMUIO_9_0__SRCID__SMUIO_GPIO19,
 			source);
+	if (ret)
+		goto err;
 
 	return 0;
+
+err:
+	kfree(source);
+
+	return ret;
 }
 
 void *smu_atom_get_data_table(void *dev, uint32_t table, uint16_t *size,
-- 
2.39.2


