Return-Path: <linux-kernel+bounces-521525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E671A3BE77
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 887607A5F49
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4207B1E1A18;
	Wed, 19 Feb 2025 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d+yRAW2T"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD311B4253;
	Wed, 19 Feb 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969257; cv=none; b=GNpMO/9JjFN2bv9AW+9l2idmmxYRdo67m9nOPFH7bFk/9yuXImM82z7g38gCkNtgj+5EulDhHBNwB8RnaxzmFAinr7Q6+qsbmkq2e+fTNfTdxTAdP4OrIIyq+l9RKIO3pq2HVed3MKsXnGhsTEzxPVDb7VKN/HUEG06wmBFTzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969257; c=relaxed/simple;
	bh=Uwbq7SofPTdMDDfuuhRfIIEXeKZlCYxMVfeiTo4dmR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S66eGCohfgQK93mf/1Bk37Ybab8K0lUkdvBq4yqEFOcbd8bgCs8LqkHUcVr2Z4ZmzCoc9ULfTpdCfpRYf3p3KnVfCVObPbSKDmBZetrc/t/sDTzM1hwFQNJJE50/kmaeMremKEG9T3tg5112YTzZh2L+swh8KG9ullofIh5djDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d+yRAW2T; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7De9c
	1YYCDKrVXvirdDhHSniVE6NBJ2sqrVR0/tlexk=; b=d+yRAW2TdSfG9MGeXyQek
	buund3bfZIiU4BQO1YmjvKC1z3AqMId0+XhGpnpC9+JSBorjTTvW4UH81E9mKnVk
	1IYLAZKGGcTiY0OkzrigCTFeUOjz/Dkr89AoiA/6aelRyUu0v2N39p6cwFS8UIwW
	tMkzmak1vCPjUnHum52ih8=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnz8e30rVnzkamNA--.60716S4;
	Wed, 19 Feb 2025 20:46:48 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/display: Add check for alloc_ordered_workqueue()
Date: Wed, 19 Feb 2025 20:46:45 +0800
Message-Id: <20250219124645.2631945-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz8e30rVnzkamNA--.60716S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr18CFWfCryxtFWxZw18Xwb_yoWDJrbEkr
	17ZrnxWry0k3Wvqw1UZr4furySvr1Yvan7X3yS9a43try7Wa1ftry8t345Xr4UZFy2yFZr
	u3W8WanrZws7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRJpndUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0hX4bme1wrXnDQACsc

Add check for the return value of alloc_ordered_workqueue()
in xe_display_create() to catch potential exception.

Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index b3921dbc52ff..b5d6ae05d936 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -97,6 +97,8 @@ int xe_display_create(struct xe_device *xe)
 	spin_lock_init(&xe->display.fb_tracking.lock);
 
 	xe->display.hotplug.dp_wq = alloc_ordered_workqueue("xe-dp", 0);
+	if (!xe->display.hotplug.dp_wq)
+		return -ENOMEM;
 
 	return drmm_add_action_or_reset(&xe->drm, display_destroy, NULL);
 }
-- 
2.25.1


