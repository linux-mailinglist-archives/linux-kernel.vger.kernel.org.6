Return-Path: <linux-kernel+bounces-364065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF49799CABA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0DD1C21594
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFAC1A76C8;
	Mon, 14 Oct 2024 12:52:56 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8D16FF25
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910376; cv=none; b=lJR1nrWZXh0HlOnxNImcute0qpuSCbMW6JyqjFxEOaqu2lKa73ceBUvWrqlpPX56M7pzS90L61tX5yZ60qDL+NoYRBbY+wQ0VZyUT31k+olT9NePrDzJoLo+6MFLXhTNNnfyjKASFZFq4EnhMf1mvOzeLYoZuf1kGvIBRE6Dz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910376; c=relaxed/simple;
	bh=xW9oEo5DehtY5VokJce8Mi0GTqMebgcZ+RXMVa3dgxA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A6oEGt1VX9bHm+EtzEJksviJYnJ0k54XB7TKH/LRzYJXRG0ebNUYvkkjer4HImwVHlY6rJJ1jy+TQCPSWFvtdSjzjF2xBemu6oWFgSKXZvc7pWgTfBEj8kgw5sO0PMuJPyvnDNrWCnFqg4QKIUvDAM0mnssSaMAzg3u6L+YkCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XRxtD4dsCz10N3c;
	Mon, 14 Oct 2024 20:51:00 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E06BF180106;
	Mon, 14 Oct 2024 20:52:50 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Oct
 2024 20:52:50 +0800
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
Subject: [PATCH v2 0/4] drm: Fix some memory leaks
Date: Mon, 14 Oct 2024 20:52:00 +0800
Message-ID: <20241014125204.1294934-1-ruanjinjie@huawei.com>
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

Fix some memory leaks in drm.

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
 include/drm/drm_kunit_helpers.h               |  6 +++
 5 files changed, 63 insertions(+), 16 deletions(-)

-- 
2.34.1


