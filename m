Return-Path: <linux-kernel+bounces-364067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9C199CABF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649B01F20EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDFD1AA79E;
	Mon, 14 Oct 2024 12:52:57 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97B1A726B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910377; cv=none; b=Cm6OtCvIeaWhe5zocrtao/RPuajWOSCEs1hPEXVZFlUrXkmpDL94hddAgClXyVNOkv092uKATfQ/M0Tg0hMgMDFi23DjX+LidvWA2kTyeQh/hhRH8wYa4i4YACFJeBxf8rUSRfAXDPq66ukxk/Xe6+73ZaWGWpjinyysf3EZ1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910377; c=relaxed/simple;
	bh=htlXRjKP1CbaIGWRn8PJZGLjByyds0LcGHFb9tP94J4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQkF6rx4ahCAj9zvRHIMAWKIgpN6+c6FAKMeuUv2A4IaT3XMXhphUHtf+od71O4aquHWUpWAIjezotAYqHGymxQPwwUTkDvksZUdJvgWuK8VPXY3iY/orAqyxrIOt2+ssbv+3VYlK3nl1gQIIdJdU2FE0vdBynMFb7xejtXbts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XRxvZ41mjzQrhc;
	Mon, 14 Oct 2024 20:52:10 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id CF98A1400D8;
	Mon, 14 Oct 2024 20:52:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Oct
 2024 20:52:52 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<christian.koenig@amd.com>, <ray.huang@amd.com>,
	<dmitry.baryshkov@linaro.org>, <dave.stevenson@raspberrypi.com>,
	<mcanal@igalia.com>, <ruanjinjie@huawei.com>, <quic_jjohnson@quicinc.com>,
	<skhan@linuxfoundation.org>, <davidgow@google.com>,
	<karolina.stolarek@intel.com>, <Arunpravin.PaneerSelvam@amd.com>,
	<thomas.hellstrom@linux.intel.com>, <asomalap@amd.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] drm/ttm/tests: Fix memory leak in ttm_tt_simple_create()
Date: Mon, 14 Oct 2024 20:52:03 +0800
Message-ID: <20241014125204.1294934-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014125204.1294934-1-ruanjinjie@huawei.com>
References: <20241014125204.1294934-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

modprobe ttm_device_test and then rmmod ttm_device_test, the fllowing
memory leaks occurs:

The ttm->pages allocated in ttm_tt_init() is not freed after calling
ttm_tt_simple_create(), which cause the memory leak:

	unreferenced object 0xffffff80caf27750 (size 8):
	  comm "kunit_try_catch", pid 2242, jiffies 4295055735
	  hex dump (first 8 bytes):
	    c0 1e 3d c3 fe ff ff ff                          ..=.....
	  backtrace (crc 3d11615a):
	    [<000000007f57312a>] kmemleak_alloc+0x34/0x40
	    [<000000008c6c4c7e>] __kmalloc_node_noprof+0x304/0x3e4
	    [<00000000679c1182>] __kvmalloc_node_noprof+0x1c/0x144
	    [<000000006aed0a3d>] ttm_tt_init+0x138/0x28c [ttm]
	    [<000000005c331998>] drm_gem_shmem_free+0x60/0x534 [drm_shmem_helper]
	    [<0000000022b4f375>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000c525d725>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<000000002db94a1f>] kthread+0x2e8/0x374
	    [<000000002c457ad7>] ret_from_fork+0x10/0x20
	......

Fix it by calling ttm_tt_fini() in the exit function.

Cc: stable@vger.kernel.org
Fixes: e6f7c641fae3 ("drm/ttm/tests: Add tests for ttm_tt")
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Add Reviewed-by.
---
 drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
index b91c13f46225..9ff216ec58ef 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
@@ -54,6 +54,7 @@ static struct ttm_tt *ttm_tt_simple_create(struct ttm_buffer_object *bo, u32 pag
 
 static void ttm_tt_simple_destroy(struct ttm_device *bdev, struct ttm_tt *ttm)
 {
+	ttm_tt_fini(ttm);
 	kfree(ttm);
 }
 
-- 
2.34.1


