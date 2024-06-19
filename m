Return-Path: <linux-kernel+bounces-220551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2783990E38F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBF0282ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F91770FA;
	Wed, 19 Jun 2024 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="O8YH0G0k"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C8376413
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778903; cv=none; b=n3uO4wxX56868sMaaGza8RtMLERjSG0QIxCoxq1Ug2+Ul3cpfwMlSBfYVh+fWwSaHKf7yWnTKQrY9FSptCkTgdqft30iIxgcS5VuJOXs9gtZXPc19Qd+eRrC61eaZ3i9+4+cVZnWTXWWit9MzaGgsr3a8h2A2eThPkAg25plhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778903; c=relaxed/simple;
	bh=WmGwTdZ13Z8IYOL25S14t4gDqP3Y6eNfWVJIbC6SN+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZUrRTJ2Q8B1rlaSaC3T3ZIMi8zQzLtU0e2clNkE2g0QkTmChfS/jdF457WmH8XipN25KUlIEsirk30KixtkPqry1Ljico8OcbXRqmM1tqjPcEpuqXTGCg3EqlUhqCeCvP5xOp7fCGrSkMDiXJ/dEItQ5gSKAgcTv96TJk7p8uLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=O8YH0G0k; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1718778906; bh=WmGwTdZ13Z8IYOL25S14t4gDqP3Y6eNfWVJIbC6SN+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8YH0G0kyvX/V85a+M29ZhwxTrsZOR6+qjlJgz1IbDCYaljs61qgao/LEpVrn1Gdp
	 1uF2CSNK/I17BTFlZq1UFKxpiPW/7WR14oBg906VTWEGO/Uv6p6xHkfuXo1MN0KYF5
	 Xn+N6wOrbrCF4V0rDwEBZ/5bRq+7NO6cXRPJHirNxuKZccM3gt/TiQJf/5vda3DSZG
	 tHQfE6rfhUGeeQkHM4m5FtmGRe0VEy/yGEDRPeTvUJtJCHkv236iO/sV1tVmPaM8uF
	 56UvbRgi3UnwH64So5Enh9TnGtC+Zrf3VNLFHDDTl+9MYhXLJAjIRpKiLLPWYoVPY3
	 QHUsCVSj6YvOQ==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 45J6YQB81377354;
	Wed, 19 Jun 2024 09:34:33 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 8/9] accel/habanalabs: move heartbeat work initialization to early init
Date: Wed, 19 Jun 2024 09:34:24 +0300
Message-Id: <20240619063425.1377327-8-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619063425.1377327-1-obitton@habana.ai>
References: <20240619063425.1377327-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomer Tayar <ttayar@habana.ai>

The device heartbeat work is currently initialized at
device_heartbeat_schedule() which is called at the end of
hl_device_init().
However hl_device_init() can fail at a previous step, and in such a
case, a subsequent call to hl_device_fini() will lead to calling
cleanup_resources() and accessing this work uninitialized.

As there is no real need to re-initialize this work every time it is
rescheduled, move this initialization to device_early_init() to be done
once and early enough.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 050c278e5ddb..e0cf3b4343bb 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -30,6 +30,8 @@ enum dma_alloc_type {
 
 #define MEM_SCRUB_DEFAULT_VAL 0x1122334455667788
 
+static void hl_device_heartbeat(struct work_struct *work);
+
 /*
  * hl_set_dram_bar- sets the bar to allow later access to address
  *
@@ -963,6 +965,8 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_cb_mgr;
 	}
 
+	INIT_DELAYED_WORK(&hdev->work_heartbeat, hl_device_heartbeat);
+
 	INIT_DELAYED_WORK(&hdev->device_reset_work.reset_work, device_hard_reset_pending);
 	hdev->device_reset_work.hdev = hdev;
 	hdev->device_fini_pending = 0;
@@ -1604,8 +1608,6 @@ static inline void device_heartbeat_schedule(struct hl_device *hdev)
 	 */
 	hdev->eq_heartbeat_received = true;
 
-	INIT_DELAYED_WORK(&hdev->work_heartbeat, hl_device_heartbeat);
-
 	schedule_delayed_work(&hdev->work_heartbeat,
 			usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
 }
-- 
2.34.1


