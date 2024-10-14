Return-Path: <linux-kernel+bounces-363343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B7799C10F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6921C2315E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71C014885B;
	Mon, 14 Oct 2024 07:17:31 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C65143890
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890251; cv=none; b=rf1nt00WkK5jzolF4eRgs+O9DxGvBGCaNLnkYYpeAJh6BON5BMWQ007ims/BeiliT8RMQo0ElC54ic0zZz/yLq/l8VFXJUUS+nJTlEATQIvvX6dzms4RS3MTbs2NyOfUGL9SPEaRjYadIb0/LyUrpt8B8mQk6FigQWM5Z3HsT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890251; c=relaxed/simple;
	bh=Z/1qvh0B0ZIYkD7JPvFWR2k2K0E7NMd3fEsOM+6HtZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNLoRwI90rxjt+c+kXI60hIgr2ZRTkHl2i/xCu79aROhSldxBojZ+UriQTluR8BbJ9g9SCU3rZzS50e9nP9BCZsBPwpzRuA4DNHgI0kRLN4IUa81vD9Y5eJbhZLcbSff0cwwS7Vsi97VI8fQlhmrLKL223hkCoJK4e72SHvVR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XRpRz2PCZz1j9rS;
	Mon, 14 Oct 2024 15:16:15 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 97FD71400DA;
	Mon, 14 Oct 2024 15:17:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Oct
 2024 15:17:25 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<christian.koenig@amd.com>, <ray.huang@amd.com>,
	<dmitry.baryshkov@linaro.org>, <dave.stevenson@raspberrypi.com>,
	<mcanal@igalia.com>, <quic_jjohnson@quicinc.com>,
	<karolina.stolarek@intel.com>, <Arunpravin.PaneerSelvam@amd.com>,
	<thomas.hellstrom@linux.intel.com>, <asomalap@amd.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 2/3] drm/ttm/tests: Fix memory leak in ttm_tt_simple_create()
Date: Mon, 14 Oct 2024 15:16:31 +0800
Message-ID: <20241014071632.989108-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014071632.989108-1-ruanjinjie@huawei.com>
References: <20241014071632.989108-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
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


