Return-Path: <linux-kernel+bounces-326447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18DB976877
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2521F2378A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A6D1A0BE9;
	Thu, 12 Sep 2024 12:00:09 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1B1A0BF7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142408; cv=none; b=HoNC/N/OA8OLU2txhJ3cHAIb/z1WfTVFY3q3g9zV4c78yO5qqoeoFhIkHeOWjt2mZS6YNh/ZcC8XZwoLfCLwdCc4W19Pomc6vkraszYqPpt1c6+zjipzDsVZWEa06HJjg0uZkPML3EN8aOGUef1gPZmy9jedIf5vZv9Pa2zm76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142408; c=relaxed/simple;
	bh=8mL4SYV/sc5j7FM0U9gCOlGikh+zeGgHTs1kbs1CkRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuh1PprVjaWCIXNARKzyW2AdnnBGDXeha5avjLfhXtTyik1ywdaNoURgiZiS5FSjynSxsVJHPn8ICiUEAzgCjFmIw7Kbfioz3eEeEIEZlXUK0wgHWO222O7FAxnrAK2gAEnbhYsptVMrjU7Cip3T6U1vEJBfxacL4E7OzurKBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X4GDt5g3szyRTr;
	Thu, 12 Sep 2024 19:58:54 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 13D6B140132;
	Thu, 12 Sep 2024 20:00:03 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 20:00:02 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <apw@canonical.com>, <joe@perches.com>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>,
	<linux-kernel@vger.kernel.org>, <dwaipayanray1@gmail.com>,
	<lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] checkpatch: add del_timer[_sync] to the deprecated list
Date: Thu, 12 Sep 2024 19:56:15 +0800
Message-ID: <20240912115615.1029452-3-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240912115615.1029452-1-liaoyu15@huawei.com>
References: <20240912115615.1029452-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500003.china.huawei.com (7.185.36.200)

del_timer[_sync]() have been deprecated and replaced by
timer_delete[_sync](). But new code still use the deprecated timer
APIs, so add them to the deprecated list.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ca60a2db223a..683f9805adee 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -838,6 +838,8 @@ our %deprecated_apis = (
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
 	"kunmap_atomic"				=> "kunmap_local",
+	"del_timer"				=> "timer_delete",
+	"del_timer_sync"			=> "timer_delete_sync",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.33.0


