Return-Path: <linux-kernel+bounces-298569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E34E95C8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362981F22FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A5014A0AB;
	Fri, 23 Aug 2024 09:13:23 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8A9149C79
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404402; cv=none; b=PeRArwvRHhNU1MyPJ9cNQemDbnE+SNkMkLwNzVq3hWg10XPfs23qaWlb736ev/pztDGq7wDgT4UXTk3D0otjHF0A94YKYJ8bV/+AysZ3NiWCcEx512uetPrx/NEGBfdalK6FA327FOaAUMM7AH2DvGtu9k2I2XPsbjS5C5hNhvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404402; c=relaxed/simple;
	bh=e1twytteX/d4utZs5HouDSOdQddz6ApwYk5bW0yMMIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ujTAAo4g1gGYrm1zxB4cQQiDhAF+qtsxB2fi9lpRLaFCxLEoJx9kd/9CUMMPUIPRjbCri/KdgGDCHyIxU0boLlHNH1wfimNJz3aqGqo046hckA1oTDgaPLsTKGMrbl9n9SE+RoH4H90xK5MSCWJIOEmhkafvBbLfEkEOPXioiKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WqvRJ1BfVz1HGjl;
	Fri, 23 Aug 2024 17:10:04 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5657714013B;
	Fri, 23 Aug 2024 17:13:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 17:13:17 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/5] drm: Use for_each_child_of_node_scoped()
Date: Fri, 23 Aug 2024 17:20:48 +0800
Message-ID: <20240823092053.3170445-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use for_each_child_of_node_scoped() to simplfy code and fix a bug
by the way.

Jinjie Ruan (5):
  drm/rockchip: Use for_each_child_of_node_scoped()
  drm/mediatek: Fix missing of_node_put() for mtk_drm_get_all_drm_priv()
  drm: of: Use for_each_child_of_node_scoped()
  drm/nouveau: Use for_each_child_of_node_scoped()
  gpu: host1x: Use for_each_available_child_of_node_scoped()

 drivers/gpu/drm/drm_of.c                    | 11 +++--------
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 10 +++-------
 drivers/gpu/drm/nouveau/nouveau_connector.c |  5 ++---
 drivers/gpu/drm/rockchip/rockchip_lvds.c    |  8 +++-----
 drivers/gpu/host1x/bus.c                    | 11 +++--------
 5 files changed, 14 insertions(+), 31 deletions(-)

-- 
2.34.1


