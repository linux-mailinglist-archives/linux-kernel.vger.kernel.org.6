Return-Path: <linux-kernel+bounces-347539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BE498D407
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FCD28435C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C201D0405;
	Wed,  2 Oct 2024 13:09:43 +0000 (UTC)
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642EB1CF5EE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.5.119.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874583; cv=none; b=Rl95GScuN9N14HeivUBEwSWZeTsSH2m4yCwY3FF1PX48Frcx46VoLCk99s35Yzbd2q4c41FOz059D18f3FuV0CmeexmT37I1P8ZSAvsUQDvBec3TIk6pY0pUXOTf2yA+/c4WbBmURYH32gqzMF4OxnIYrE9dS6D+X7rOTSmLPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874583; c=relaxed/simple;
	bh=aEho/LpSxLiRqY7wdO48P2kGCQ4S0OMz3sMi6CSGFUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLWmKSAq9UYDjGEC0aCc0Gv48rx0k/fJCExw0EtmjspCpck5TgPv53mOqBS6I6ryxhwDHixDvl8NWbWAYjINLqWGHG3Lsnb43IehpoBtX3KlkEViHYrAijzGhUgT6iGFcHoN9vv/5ZmNv9iWlHK6fri7Ge1bGgN76j2Ef8elBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru; spf=pass smtp.mailfrom=mcst.ru; arc=none smtp.client-ip=212.5.119.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcst.ru
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
	by tretyak2.mcst.ru (Postfix) with ESMTP id 36BCF102392;
	Wed,  2 Oct 2024 16:09:28 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
	by tretyak2.mcst.ru (Postfix) with ESMTP id 2FC2C102391;
	Wed,  2 Oct 2024 16:08:38 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
	by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 492D8bmF023602;
	Wed, 2 Oct 2024 16:08:37 +0300
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
        Kenneth Feng <kenneth.feng@amd.com>, Simona Vetter <simona@ffwll.ch>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH v2] drm/amd/pm: check return value of amdgpu_irq_add_id()
Date: Wed,  2 Oct 2024 16:01:49 +0300
Message-Id: <20241002130149.1607979-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <7b3ea9a6-575e-4fe5-98d9-6e53803188fa@amd.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
	 bases: 20111107 #2745587, check: 20241002 notchecked
X-AV-Checked: ClamAV using ClamSMTP

amdgpu_irq_ad_id() may fail and the irq handlers will not be registered.
This patch adds error code check.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
v2: Remove the cast to struct amdgpu_device as Christian König 
<christian.koenig@amd.com> suggested.

 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index 79a566f3564a..50a3085c00aa 100644
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
+	ret = amdgpu_irq_add_id(hwmgr->adev,
 			SOC15_IH_CLIENTID_THM,
 			THM_9_0__SRCID__THM_DIG_THERM_L2H,
 			source);
-	amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
+	if (ret)
+		goto err;
+
+	ret = amdgpu_irq_add_id(hwmgr->adev,
 			SOC15_IH_CLIENTID_THM,
 			THM_9_0__SRCID__THM_DIG_THERM_H2L,
 			source);
+	if (ret)
+		goto err;
 
 	/* Register CTF(GPIO_19) interrupt */
-	amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
+	ret = amdgpu_irq_add_id(hwmgr->adev,
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


