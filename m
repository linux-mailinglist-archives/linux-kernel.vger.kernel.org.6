Return-Path: <linux-kernel+bounces-248849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6751B92E2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D6A1C22E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D5152533;
	Thu, 11 Jul 2024 08:45:27 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3C4F1E2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687527; cv=none; b=tuhOUYCJZF87XchMGKWg3gESTE62u7pbY6L0CFPv4+a7oz4V6IZLXnPkps/sgaoKXADFXC+Gb9Kw8ZMbkt9Z2f8tjPZXmbzjbcd/nr6m2lTTlM3+ekoz71/9wqGTUJ0dA+gtTK+bp+h3TsJ/TS+cV64TcBkHUyZftxK8xthZYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687527; c=relaxed/simple;
	bh=IS4sZjlIbsHkMT8tbcQGLv09+Y4M+/UZ4yxhx//V6Pc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GWrklpwBjTljIfyUU9OgUSl8ySV4y2ZvcFSmj+QrfcvjsVBVz9umlzsRWnv1Nl3IjRy7qk8iF7ILwI9Y3odCtWGE0+P6WefUTCN3Rk25UIX2QGNiOJaGOKLWEUUJHSKtMQzGV/NejWQjb6YHj8eFWbZrYIg4UF1kOP+dFHyaONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAC3veWVm49mlSy3Ag--.57394S2;
	Thu, 11 Jul 2024 16:45:17 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	asad.kamal@amd.com,
	lijo.lazar@amd.com,
	make24@iscas.ac.cn,
	le.ma@amd.com,
	kenneth.feng@amd.com,
	evan.quan@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/amdgpu: Fix uninitialized variable warnings
Date: Thu, 11 Jul 2024 16:45:09 +0800
Message-Id: <20240711084509.2432392-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3veWVm49mlSy3Ag--.57394S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtryrZr45Zr4rWw43Xr1DZFb_yoW3GFX_Kr
	4UJasrGrn2yF1q9r1UZayFqa42yF98uF4vqas3ta4Fv3yxX343Xr93WrykXF1ruF43C3Zr
	A34UWry5A39IkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Return 0 to avoid returning an uninitialized variable r.

Fixes: 230dd6bb6117 ("drm/amd/amdgpu: implement mode2 reset on smu_v13_0_10")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index 04c797d54511..0af648931df5 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -91,7 +91,7 @@ static int smu_v13_0_10_mode2_suspend_ip(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.hw = false;
 	}
 
-	return r;
+	return 0;
 }
 
 static int
-- 
2.25.1


