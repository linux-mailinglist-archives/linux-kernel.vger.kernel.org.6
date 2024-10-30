Return-Path: <linux-kernel+bounces-388061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1379B5A01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9143E1F246BE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0AF194143;
	Wed, 30 Oct 2024 02:35:48 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0CA19340C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730255747; cv=none; b=BWzG65YTRSRkj5CZtyjbGf7sbEmeV1nLxIs5Cp4/YJDud7i44y7jouNDJB+G+p7JKXH2k4jHUkJfQGy7SIQgvoOH8QSwwBN2oHmzJW//fUo74QvzgR4ZsYCLLC9ilz6f1/KPsu5HcOXiHbLDeisKzrCxEH11tvJKXjct6+I/kBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730255747; c=relaxed/simple;
	bh=mmth8984Ng2fpLg58jZ+9AzNGtKYii9q71cwNfmDp8M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tnkUmHWbDs+Lm6tWne+v7A6xtqnPzY4E1ce1NYTRdpG9UrB1VvCZ8j/dtYS57hWPNX8hOod/+BUShz2eR0rXAfrlRFuU9MDnc3Yf6k4I01vT4l1QFn3iBwBF2wLFUXwjcFgA8wCDehSgUjX5WFyJKgnfjuWPEV6HmSvtY66WBVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XdWQz6P6bz1jw59;
	Wed, 30 Oct 2024 10:34:03 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 629511A0188;
	Wed, 30 Oct 2024 10:35:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 30 Oct
 2024 10:35:34 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<dmitry.baryshkov@linaro.org>, <dave.stevenson@raspberrypi.com>,
	<quic_jjohnson@quicinc.com>, <mcanal@igalia.com>,
	<skhan@linuxfoundation.org>, <davidgow@google.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v4 0/3] drm/tests: Fix some memory leaks
Date: Wed, 30 Oct 2024 10:35:01 +0800
Message-ID: <20241030023504.530425-1-ruanjinjie@huawei.com>
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
 kwepemg200008.china.huawei.com (7.202.181.35)

Fix some memory leaks in drm tests.

Changes in v4:
- Return NULL early if drm_display_mode_from_cea_vic() return NULL
  for drm_kunit_display_mode_from_cea_vic() helper as Maxime suggested.
- Split out the separate ttm test patch.

Changes in v3:
- Adjust drm/drm_edid.h header to drm_kunit_helpers.c.
- Drop the "helper" in the helper name.
- s/fllowing/following/
- Add Acked-by.

Changes in v2:
- Fix it with new introduced helper instead of drm_mode_destroy().
- Update the commit message.
- Add Reviewed-by.

Jinjie Ruan (3):
  drm/tests: helpers: Add helper for drm_display_mode_from_cea_vic()
  drm/connector: hdmi: Fix memory leak in
    drm_display_mode_from_cea_vic()
  drm/tests: hdmi: Fix memory leaks in drm_display_mode_from_cea_vic()

 drivers/gpu/drm/tests/drm_connector_test.c    | 24 +++++------
 .../drm/tests/drm_hdmi_state_helper_test.c    |  8 ++--
 drivers/gpu/drm/tests/drm_kunit_helpers.c     | 42 +++++++++++++++++++
 include/drm/drm_kunit_helpers.h               |  4 ++
 4 files changed, 62 insertions(+), 16 deletions(-)

-- 
2.34.1


