Return-Path: <linux-kernel+bounces-543327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C226A4D44C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6902A1890927
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFA21F5847;
	Tue,  4 Mar 2025 07:11:04 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D819194080
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072263; cv=none; b=pIdoBP/uuxU9UiXJQIiMBaEiM+0sAks+Du+SgkT6bbh6VH2nU25ZZqeITB+7TO7XrCaNoZzfh17t4Z1k9n2RQ6esTt0yff5V5QkJULsQgzjNlEoHE4aBE7I00ueo73umbaUO0P+hIAeE6MPANWGAv1rt80Vx1CaDX+ttuqHPgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072263; c=relaxed/simple;
	bh=2abKyYZj3dPzLLW86axJgj4Tbg9s3rK4r9mLG2cT5lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2NrLp6D4I9qtH75b3MEKqBSxqqmtjxbEwMAjFVtCWvgwU4xyBnSyFFMNwPUbYigGg9nXkcv50cFcZqyPnxO1romDWiUDeJ/ME8gvfCSuU7vDM0h4HiLz1qdcSLMdLlEwB3UQQXfZiBur4s7eys/5wrr2te0D6zo8iwNXghbyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowADHz8t5p8ZnAcjuEQ--.11326S2;
	Tue, 04 Mar 2025 15:10:51 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: kenneth.feng@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: sunil.khatri@amd.com,
	Jun.Ma2@amd.com,
	lijo.lazar@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] drm/amdgpu: handle amdgpu_cgs_create_device() errors in amd_powerplay_create()
Date: Tue,  4 Mar 2025 15:10:30 +0800
Message-ID: <20250304071030.2166-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHz8t5p8ZnAcjuEQ--.11326S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1DtFWrtr1xtr1xtFWxXrb_yoWDuwcEka
	1rJr1Sqr1UKFn8AwnrArs8Zryqyr4a9rWrGr12gwnayrnrJ3srXFyjgry7uF1ruayIgF98
	uF1j9F4rAF97GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoLA2fGdHuqjAAAsM

Add error handling to propagate amdgpu_cgs_create_device() failures
to the caller. When amdgpu_cgs_create_device() fails, immediately
return -EINVAL to stop further processing and prevent null pointer
dereference.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 26624a716fc6..2cb05614466f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -51,6 +51,8 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 	hwmgr->adev = adev;
 	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
 	hwmgr->device = amdgpu_cgs_create_device(adev);
+	if (!hwmgr->device)
+		return -EINVAL;
 	mutex_init(&hwmgr->msg_lock);
 	hwmgr->chip_family = adev->family;
 	hwmgr->chip_id = adev->asic_type;
-- 
2.42.0.windows.2


