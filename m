Return-Path: <linux-kernel+bounces-390623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4775E9B7C69
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793781C2095E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290C119DF99;
	Thu, 31 Oct 2024 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="amrSdQ4v"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4427483
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383671; cv=none; b=bzdi+EZtphPdBA2FNv4eEhl/DkLrJN/mL4dd0R7pr1rXDuCDxoxj/kX/dKWtefeGbxei5TXl7UL3Fv04LdBqAqyWoVXmG/4c6j5wx8KwdYAdBK57kbiUA5UXCiECbYhrO18p0xYjWfjhdRqikhUV3PtTg+tmrexIiH6EMiPky3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383671; c=relaxed/simple;
	bh=PbXrV50VmBOhRRoF05yp8g7L4tvtb2HeMZrOVURfQss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tvL0VdU15vJJnad0HK5NPmXc3i5RJVQ6x93ZoJgvmST080OVOEbWIH8nt785MFH1Jw2WI1/Lgf6En5eP/na+cq2MYkA5VL/5zcgNpnWZ/x8rXmvNBnPeeHK0tPIQjxfjVba/bPiO9gFLJfLs+5FSECmekvQER7XotmeZ7KzNwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=amrSdQ4v; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730383666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BoHAg1qZYHX6lePa8/xhJEWiDV/Xqyk+i/wwaWiTk98=;
	b=amrSdQ4vTWalw+ipnhMrH/fVousg6iNhB05fsg39QegkSui6545BLh9vUwtK+k8sBCSTOT
	Z7sIxb+NHD8Fd6/qVZ9GL5ifUyKe4VabUXMdB2YR/8+GfeheTtN3poEoDSgYcf6T4AhrjL
	yJQQ5tgRpk0WpxDORQYC19ZmE3lgmbc=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/prime: drm_prime_sg_to_dma_addr_array(): Return -EINVAL on error
Date: Thu, 31 Oct 2024 22:07:30 +0800
Message-Id: <20241031140730.2406181-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

'-EINVAL' stands for invalid argument, while '-1' will accidently be
interpreted as '-EPERM' by the potential upper caller. Which does not
describe the error case accurately, since such an error can happens when
the caller pass a smaller number than actually needed size to describe
the array passed-in. Such an error is invalid argument.

Take drm/vmwgfx driver as an example, the function call trace is:

|- ttm_bo_vmap()
|-- ttm_tt_populate()
|--- bdev->funcs->ttm_tt_populate()
|----- vmw_ttm_populate()
|------ drm_prime_sg_to_dma_addr_array()

While ttm_bo_vmap() requires its callees return '-EINVAL' on invalid range,
similier for other users or call path. Let's meet the requirement.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 0e3f8adf162f..3f1d516a90b6 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -1055,7 +1055,7 @@ int drm_prime_sg_to_dma_addr_array(struct sg_table *sgt, dma_addr_t *addrs,
 
 	for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
 		if (WARN_ON(a - addrs >= max_entries))
-			return -1;
+			return -EINVAL;
 		*a++ = sg_page_iter_dma_address(&dma_iter);
 	}
 	return 0;
-- 
2.34.1


