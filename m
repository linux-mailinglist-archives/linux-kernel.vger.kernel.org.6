Return-Path: <linux-kernel+bounces-304466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C296E962076
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DC61C2374D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19371158552;
	Wed, 28 Aug 2024 07:15:50 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D614D282
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829349; cv=none; b=ZusS/dgFeXbPKPTfXttXTr6oQY6607be0spBJUu0vgqqrQOh106ePXIt9HIBSLV32YB4/gXH9ru88xHcPxp/yq8fRXyPeNN7MZ0yH6GHZO+ovEbK0lslXeRcUUvJAI6/oSebjGxum2W691XRpQH/frFka2W4ycKK8dUmCblQyaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829349; c=relaxed/simple;
	bh=MuZuQp+uLztFw2q9cNF/Umod0Y5qwAbjwzRmfx6vBgc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dhE1kAUtsZCoYzJGc70yowzrkMq8L4oKbWzMagH37/OQzD3utUzf1FsBiHE+tX5XKujP+jGFdi5vmrqOT3YXXJfeQYbgbuN+FZMohLrjQmtKF2o63FFN0Vy5uLdQ5iOhjX4yMMgLm4oU7drEIoh4JSKQjyOpgZgqcFZlY+t8vrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WtwbD2WV4z1HHdj;
	Wed, 28 Aug 2024 15:12:24 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id EA9D81401F1;
	Wed, 28 Aug 2024 15:15:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 15:15:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <brauner@kernel.org>, <akpm@linux-foundation.org>, <kees@kernel.org>,
	<zeming@nfschina.com>, <adobriyan@gmail.com>, <rdunlap@infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] user_namespace: Use kmemdup_array() instead of kmemdup() for multiple allocation
Date: Wed, 28 Aug 2024 15:23:40 +0800
Message-ID: <20240828072340.1249310-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Let the kmemdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/user_namespace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 0b0b95418b16..aa0b2e47f2f2 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -853,9 +853,8 @@ static int sort_idmaps(struct uid_gid_map *map)
 	     cmp_extents_forward, NULL);
 
 	/* Only copy the memory from forward we actually need. */
-	map->reverse = kmemdup(map->forward,
-			       map->nr_extents * sizeof(struct uid_gid_extent),
-			       GFP_KERNEL);
+	map->reverse = kmemdup_array(map->forward, map->nr_extents,
+				     sizeof(struct uid_gid_extent), GFP_KERNEL);
 	if (!map->reverse)
 		return -ENOMEM;
 
-- 
2.34.1


