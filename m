Return-Path: <linux-kernel+bounces-182694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B88C8E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D7C1F21FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A2141991;
	Fri, 17 May 2024 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="XNVySUsQ"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2C43ACA
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988959; cv=none; b=i7X8QjIr8ArJ91Zkl52aihtVVZSKr93PBfhW0JZuBLoJqkZGACIZs6rdBVk0PhsrWSoStN6I0o92113QuBjo2kTzWDct9trxN6Fh6r7YvNhfK0J8dkoG67YLSZchUnGAogD8kOIyg88yuSKfyR91yegYRIloT0VnHIyneYPVecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988959; c=relaxed/simple;
	bh=PzZiWbf0Qtm6SqD8o4OKkzXp87MevQH5LRuBjxxCNwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taKHt3jFCWvEnkNxP6eRF1VDXhAOIueHTpz65X1HrAjgOL/LBs2B8W0grm/5T5rKIMdujGH499ef9Wc1KV2xE5sZszRs50GprdMG25aKy/NVXoscINWK3zB1Oy2TYfUFke2ScDCnp/DduY2HyGACzIoGPdC/WONW4cwXRPPWREI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=XNVySUsQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=LvtRfjS2hxOURJcIdMjVVgisf5I/X5Frx5qJPUGE7P8=; b=XNVySUsQ3TsJCAr8
	Msgt+rSgCOU4aa1KXWSWdzCvF2x1MgkC/4KzUkJcv0LP23aGSiRHQWScc7y6lEkmy2KAOt9mhutPv
	Eoccs3tc7WMDsF8nr3GfXR+RqxKTPvQ++bhEE4SvlX+awvcMJg2ayxp0utLOeIzoeBsd0M4I/Si0Z
	h7MFmHlJi87RHXlNafyZVY0wj8hYe0piWsLNVd2+6yymAIrHzU/KHc79d7cNIMszqCBxW3UXLVXnk
	OP8g/Xlyq0YYCtFMNQM1mfzkx0gIJDeKlhNJyUN0zHmc7fT+4AyvVvf9a3cOGgihi+XiD3fMQk/8Q
	ZgwBryAWK7RALhwEpQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s877B-001TpV-10;
	Fri, 17 May 2024 23:35:53 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] drm/amdgpu: remove unused struct 'hqd_registers'
Date: Sat, 18 May 2024 00:35:46 +0100
Message-ID: <20240517233548.231120-2-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240517233548.231120-1-linux@treblig.org>
References: <20240517233548.231120-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'hqd_registers' used to be used in a member of the 'bonaire_mqd'
struct. 'bonaire_mqd' was removed by
commit 486d807cd9a9 ("drm/amdgpu: remove duplicate definition of
cik_mqd")
It's now unused.

Remove 'hqd_registers' as well.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 38 ---------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 541dbd70d8c7..f3544f02ffb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2757,44 +2757,6 @@ static int gfx_v7_0_mec_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-struct hqd_registers {
-	u32 cp_mqd_base_addr;
-	u32 cp_mqd_base_addr_hi;
-	u32 cp_hqd_active;
-	u32 cp_hqd_vmid;
-	u32 cp_hqd_persistent_state;
-	u32 cp_hqd_pipe_priority;
-	u32 cp_hqd_queue_priority;
-	u32 cp_hqd_quantum;
-	u32 cp_hqd_pq_base;
-	u32 cp_hqd_pq_base_hi;
-	u32 cp_hqd_pq_rptr;
-	u32 cp_hqd_pq_rptr_report_addr;
-	u32 cp_hqd_pq_rptr_report_addr_hi;
-	u32 cp_hqd_pq_wptr_poll_addr;
-	u32 cp_hqd_pq_wptr_poll_addr_hi;
-	u32 cp_hqd_pq_doorbell_control;
-	u32 cp_hqd_pq_wptr;
-	u32 cp_hqd_pq_control;
-	u32 cp_hqd_ib_base_addr;
-	u32 cp_hqd_ib_base_addr_hi;
-	u32 cp_hqd_ib_rptr;
-	u32 cp_hqd_ib_control;
-	u32 cp_hqd_iq_timer;
-	u32 cp_hqd_iq_rptr;
-	u32 cp_hqd_dequeue_request;
-	u32 cp_hqd_dma_offload;
-	u32 cp_hqd_sema_cmd;
-	u32 cp_hqd_msg_type;
-	u32 cp_hqd_atomic0_preop_lo;
-	u32 cp_hqd_atomic0_preop_hi;
-	u32 cp_hqd_atomic1_preop_lo;
-	u32 cp_hqd_atomic1_preop_hi;
-	u32 cp_hqd_hq_scheduler0;
-	u32 cp_hqd_hq_scheduler1;
-	u32 cp_mqd_control;
-};
-
 static void gfx_v7_0_compute_pipe_init(struct amdgpu_device *adev,
 				       int mec, int pipe)
 {
-- 
2.45.1


