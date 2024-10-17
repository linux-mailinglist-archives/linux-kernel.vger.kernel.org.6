Return-Path: <linux-kernel+bounces-369235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F46B9A1AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07342B2166B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727A8190463;
	Thu, 17 Oct 2024 06:32:14 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD0158205
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146734; cv=none; b=V2GUhbNWKR08u1wa6Uy5Hjo29/lAqxz6bEUDBSggokZLy5iIuHoFmGcnI1L+7DELQoJ/wiWynixuvpLL3Vn99fFGsoLG4dcUTtwHuTwmC+VXYYCXFjxmZHuE2xlC6MszmsX3z7QoSehEzAALj9eX5rho1hBuaQgcV0RKIYXTRRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146734; c=relaxed/simple;
	bh=rVdNY6Nw4tkZGctIPWJ5J3NMwQJ95BwpU5KuXCbyCHM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fpjGXZDDOH1aeSBnJ/PHVxd2JbhZqmf8QQQwpXQCuWDs6QyZkgAMdNDvTmDr7moTlVGYqOX3OFGBEhbUwNVIpxZqTxQVHgD6fYlt3jhT9upiYg5d/4QS7gPFrmmi+jVviUtx/tExoQTmGAmQ8FTvhLj7jMjzXVRohvkeAIjF4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XTdJp1M50zQrmH;
	Thu, 17 Oct 2024 14:31:22 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E67D18009B;
	Thu, 17 Oct 2024 14:32:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Oct
 2024 14:32:06 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<christian.koenig@amd.com>, <ray.huang@amd.com>,
	<dmitry.baryshkov@linaro.org>, <dave.stevenson@raspberrypi.com>,
	<quic_jjohnson@quicinc.com>, <mcanal@igalia.com>, <ruanjinjie@huawei.com>,
	<davidgow@google.com>, <skhan@linuxfoundation.org>,
	<karolina.stolarek@intel.com>, <Arunpravin.PaneerSelvam@amd.com>,
	<thomas.hellstrom@linux.intel.com>, <asomalap@amd.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] drm/tests: Fix some memory leaks
Date: Thu, 17 Oct 2024 14:31:21 +0800
Message-ID: <20241017063125.3080347-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Fix some memory leaks in drm tests.

Changes in v3:
- Adjust drm/drm_edid.h header to drm_kunit_helpers.c.
- Drop the "helper" in the helper name.
- s/fllowing/following/
- Add Acked-by.

Changes in v2:
- Fix it with new introduced helper instead of drm_mode_destroy().
- Update the commit message.
- Add Reviewed-by.

Jinjie Ruan (4):
  drm/tests: helpers: Add helper for drm_display_mode_from_cea_vic()
  drm/connector: hdmi: Fix memory leak in
    drm_display_mode_from_cea_vic()
  drm/ttm/tests: Fix memory leak in ttm_tt_simple_create()
  drm/tests: hdmi: Fix memory leaks in drm_display_mode_from_cea_vic()

 drivers/gpu/drm/tests/drm_connector_test.c    | 24 +++++------
 .../drm/tests/drm_hdmi_state_helper_test.c    |  8 ++--
 drivers/gpu/drm/tests/drm_kunit_helpers.c     | 40 +++++++++++++++++++
 drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c |  1 +
 include/drm/drm_kunit_helpers.h               |  4 ++
 5 files changed, 61 insertions(+), 16 deletions(-)

-- 
2.34.1


