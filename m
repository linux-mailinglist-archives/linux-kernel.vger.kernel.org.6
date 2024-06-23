Return-Path: <linux-kernel+bounces-226144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63685913AD3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 15:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FD3281E1A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEA2181334;
	Sun, 23 Jun 2024 13:33:16 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889034CE5
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719149596; cv=none; b=I2B1TjKrvv3hN1pKqltXBfegyPhu7lGgzdXfF8/eyPlpBpP4UYJhFCIeBKDv27nbXil8fVhP1qWOuSrUGo1vjbzzYUu8G5uKTys2j3BEOXgKu7NTmDDKz72O2RVCOQi0z7S8lzWZiwVkREJTkiDaLS61FUp5IiXYouTpHlWsPyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719149596; c=relaxed/simple;
	bh=lAiX4AliWgXOS+Asoz1B8ZJEc8tbyqaIwEUGnT3zxOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pJXrk0TSgjn/6oj82ZdLlziMHPkucf1IsXJ/WHKboMwFLGyNtxwHorg0PRFwAmD2O4kOGmXajxkogj7WKIVPWNPwjINP1tuQpb4XLsNVTYD8jO40oQtWNyw9BjKd0HGHTCAQ3dcorTi+OqOGbqCKVt+yAf4jXXlZ+8k0KlnuHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAA3PQEGJHhmcC1VEg--.47951S2;
	Sun, 23 Jun 2024 21:33:06 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	wenjing.liu@amd.com,
	chaitanya.dhere@amd.com,
	hamza.mahfooz@amd.com,
	sohaib.nadeem@amd.com,
	samson.tam@amd.com,
	austin.zheng@amd.com,
	Qingqing.Zhuo@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] drm/amd/display: Add otg_master NULL check within init_pipe_slice_table_from_context
Date: Sun, 23 Jun 2024 21:32:52 +0800
Message-Id: <20240623133252.2136231-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3PQEGJHhmcC1VEg--.47951S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur48Aw1kZrWDAr4UAFyftFb_yoWfCrc_Kr
	1qvrZ5tw47uF1DZr1jvrn5ur10v3yj9w4kX3WxtayI9r17ArW7uryru3yDWr1YyF17GayD
	Aws5Krn5C3sFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUby8BUUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

To avoid reports of NULL_RETURN warning, we should add
otg_master NULL check.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index f6fe0a64beac..20f0951b00f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1177,6 +1177,8 @@ static void init_pipe_slice_table_from_context(
 		stream = context->streams[i];
 		otg_master = resource_get_otg_master_for_stream(
 				&context->res_ctx, stream);
+		if (!otg_master)
+			continue;
 		count = resource_get_odm_slice_count(otg_master);
 		update_slice_table_for_stream(table, stream, count);
 
-- 
2.25.1


