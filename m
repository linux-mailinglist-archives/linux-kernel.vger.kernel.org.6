Return-Path: <linux-kernel+bounces-241048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E8927645
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1199728474F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0F41AE871;
	Thu,  4 Jul 2024 12:47:47 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EB13BADF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097267; cv=none; b=uSQKYO5xSYIY0jU4FbN+66WAblFhHh8Bxr+xvNplHJFcmUXHSBB+DGHHBXMsT8PRpCIdHJkJrzpa/czZodJDEVT4byy+N+/0reDb2OXj2jRCwHi1EQNCLNyck1zon7jPJC3739tF5wkpgq9FFxx3f7yxJCxuBxIHfM4zmrN1Z4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097267; c=relaxed/simple;
	bh=FQcR6Q/k7iZAhzSbf6kb0v3aYcS6WAbiTLZb86m1TVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bfLwflTZdwqaHVFSP0TGzlW3Ct95fK476xhikEKECMZ88alvuJQvl9EsXC7qp/Eo3FqhmJALMHbK7HFqW6yR6UYRmFJXjKv2kGuLw8HYnxnwsNBmrf+zuDWEYiNSlznakOjnz5fb2SReXlyLGPWoGj9f2k0jjWD6hF6WlDitb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAA3GU7imYZmzOuMAQ--.7965S2;
	Thu, 04 Jul 2024 20:47:38 +0800 (CST)
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
	Qingqing.Zhuo@amd.com,
	dillon.varone@amd.com,
	stylon.wang@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH RESEND] drm/amd/display: Add otg_master NULL check within init_pipe_slice_table_from_context
Date: Thu,  4 Jul 2024 20:47:27 +0800
Message-Id: <20240704124727.293701-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA3GU7imYZmzOuMAQ--.7965S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWDXw1UCw1kArW5Kr48WFg_yoWDCrg_Kr
	yvvFZ5tw47uF1Dur1jvrn5uFy0v3yj9r4kJ3Z7tayI9r17ArW7uryF93ykWr1YyF17Ga98
	Aws5Kr1kC3srKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUOrcfUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

To avoid reports of NULL_RETURN warning, we should add
otg_master NULL check.

Fixes: c51d87202d1f ("drm/amd/display: do not attempt ODM power optimization if minimal transition doesn't exist")
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


