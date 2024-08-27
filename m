Return-Path: <linux-kernel+bounces-302494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB7F95FF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF084283248
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16692C184;
	Tue, 27 Aug 2024 02:56:12 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A31754B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727372; cv=none; b=Qhg9eGMqxmzwyuFiTdnD7m3t7RXIBHq47CMY/Crkcrsckk611D4cSqXRg09OaRM1YY4E0gvcWbrlnLAJjgpKouki1eNP5Hxjx79vt+7+7aitNUg/PaGzV7URNKWAOMipHKGK8zEPeM8uQesxuzOq/L0ReZmRk/b/LkN1LqWDh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727372; c=relaxed/simple;
	bh=f7Zp7cxYV0QzAovQZAlmbsPA6jBYDNsxHfs+9OUB42w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U0yDbgZvuOLmk4pw0NJNE6S5x+iRit+fnxQiD2Jk2boigBlTvGAZJbgk72yY3puzQNvY+Pwz5eCsx76lbCjW7VWI7zXDZVTtK2jx6BfLSNHhOihjhXqCNJzkoNMkHGJIkdduAiUUfF0sONdwQ1nCT2KBprNGYQX69P6ryurH0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WtBxl1q9Wz1j7Nd;
	Tue, 27 Aug 2024 10:55:55 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A4EC1140120;
	Tue, 27 Aug 2024 10:56:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 10:56:03 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 0/3] drm/rockchip: Simplified with for_each_child_of_node_scoped()
Date: Tue, 27 Aug 2024 11:03:54 +0800
Message-ID: <20240827030357.1006220-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use for_each_child_of_node_scoped(), __free and dev_err_probe()
to simplify code.

Changes in v2:
- Split from the patch set.
- Also use __free() and dev_err_probe() to simplify code.

Jinjie Ruan (3):
  drm/rockchip: Use for_each_child_of_node_scoped()
  drm/rockchip: Simplified with dev_err() and __free()
  drm/rockchip: Simplified with dev_err_probe()

 drivers/gpu/drm/rockchip/rockchip_lvds.c | 74 +++++++++---------------
 1 file changed, 26 insertions(+), 48 deletions(-)

-- 
2.34.1


