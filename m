Return-Path: <linux-kernel+bounces-363342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9899C10E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878611C22EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BED71474B7;
	Mon, 14 Oct 2024 07:17:30 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902813D243
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890250; cv=none; b=W6xYNnChPJ+8Xk3q8No2j/v+VVp7tIzQ+d099wcSqr8YiGSgo39eMsf1DcqE8/UI1GHdyq/+5vwS7d8DS9VKW4HO7BoYSDQHL+wDZ/rhL1d25R3VofkkyJaf9bVtNKq2zz/5///W5e/i+IflzeZm5QXPT33f2DkxKS4CIPgF0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890250; c=relaxed/simple;
	bh=4s+kUNtlIIB3RXvLK8a7VBUE9QJ7qWBCnG6qcVYkj4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hCoyFQpoHOCDBOi/ilK4SJY8xNkKhtrTXDYxZzeiIE6OWLFaXkCm1E316pcEqX3A3Tubrk+kXBDLU0ZeOEtrqGhxS5cIrir4FbtXA35Iy2sYY3fSt8JmKEPcKTje7zR7q1CS9odknexO/JXHwJ/AJ4difIC6MKb+l6AWUFEE99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XRpSW3pDWz20pLB;
	Mon, 14 Oct 2024 15:16:43 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5433A1400DA;
	Mon, 14 Oct 2024 15:17:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Oct
 2024 15:17:24 +0800
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
Subject: [PATCH 0/3] drm: Fix some memory leaks
Date: Mon, 14 Oct 2024 15:16:29 +0800
Message-ID: <20241014071632.989108-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Fix some memory leaks in drm.

Jinjie Ruan (3):
  drm/connector: hdmi: Fix memory leak in
    drm_display_mode_from_cea_vic()
  drm/ttm/tests: Fix memory leak in ttm_tt_simple_create()
  drm/tests: hdmi: Fix memory leaks in drm_display_mode_from_cea_vic()

 drivers/gpu/drm/tests/drm_connector_test.c    | 24 +++++++++++++++++++
 .../drm/tests/drm_hdmi_state_helper_test.c    |  8 +++++++
 drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c |  1 +
 3 files changed, 33 insertions(+)

-- 
2.34.1


