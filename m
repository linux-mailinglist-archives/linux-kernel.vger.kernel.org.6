Return-Path: <linux-kernel+bounces-225599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A89132BC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 10:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995C32848B8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 08:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A910A14C596;
	Sat, 22 Jun 2024 08:22:59 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8328376E7
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719044579; cv=none; b=nBkzcTnM0SZEDfI1O0driI5hShZ2ctME+16ECVdkhy2lASw10HEYI5/QjUWPmDSrJVc0ZLtpMa0Xi+aEJNK37DFztf+xA97zDd1jOsjtFlXxYPaxB3IO6o9SxUuRXn532z7Zmgtd5AudVJ+UFc04V90cEZ/4FL1DAC3tBgIujSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719044579; c=relaxed/simple;
	bh=jXT9RZT/xCDvTb6TSx+XI1QaURBdDeeVCPy99XHf3Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tB+7Rt8Z6cd5E2bkrNgAgctsKdfsdUqAR3i2guJ3yaUbbeBFe6Dpmi3or9qdLcCHLnkuAPUsAImXWYBh4zBKT9M/Sh3TYd3YCbqxfvLcJ1LKZwJe0mL7hYDI7mDaSsrjr8HyzHyarnmN8tRNBNUEzrnbojg0qF/b3H9fz9XnoOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAA3PhK9iXZmIKwQDA--.10106S2;
	Sat, 22 Jun 2024 16:22:33 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	aurabindo.pillai@amd.com,
	make24@iscas.ac.cn,
	guchun.chen@amd.com,
	chenjiahao16@huawei.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix a possible null pointer dereference
Date: Sat, 22 Jun 2024 16:22:19 +0800
Message-Id: <20240622082219.1876200-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA3PhK9iXZmIKwQDA--.10106S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4UAFy5KF45CFykXw4fKrg_yoWfurg_CF
	WUZFZrXw43AFyFyr17Zw4Sv3sIv345Ar4ktr1Sqa9av34xXw17XryUJr1FvF1fuFWfCFnF
	q34Yg3W5A3Z7CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In amdgpu_connector_add_common_modes(), the return value of drm_cvt_mode()
is assigned to mode, which will lead to a NULL pointer dereference on
failure of drm_cvt_mode(). Add a check to avoid npd.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 9caba10315a8..6cf946adb6fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -458,6 +458,8 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
 			continue;
 
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
+		if (!mode)
+			continue;
 		drm_mode_probed_add(connector, mode);
 	}
 }
-- 
2.25.1


