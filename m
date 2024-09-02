Return-Path: <linux-kernel+bounces-311458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF22968984
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7D21C223F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE8210186;
	Mon,  2 Sep 2024 14:09:48 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829022101B9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286188; cv=none; b=Sa8+ARIzJ/Mg/ULE44/Az63H9vom+5MUefQlyJyhAD2sqzEjtr4jTw+QOnB0j70lKdcqred66aSMZefy5WZ+yKdIefAGCIeEf9H0xX84yQbGvIoH4IA55HOyT0zFbwo22rTRzh1ZvvKHWU9q0hf3NP347PRiJtJSVwL6H2Ecxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286188; c=relaxed/simple;
	bh=ywJR/hW8fn3tAmq6sJYige11GgWOf7pc16QAJcigBB0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Grah2ya2MeTnx3+U1PQTK0LbXNnzIpqvML8rBpOZveEpYOo7e7pj8Tmos2JJO97zeepe8ygd50IvkoXYogmSSNycrUHhFye1+XvH/puygehnuUQfJNXh90/gUAOnOxlKHjtNMF6sGMDxJwypL70Xa2Ere63DLB1B3+WQbWXwGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wy9Vk2Y4mz20nKB;
	Mon,  2 Sep 2024 22:04:46 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 642A31400D4;
	Mon,  2 Sep 2024 22:09:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 22:09:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/5] debugobjects: Do some minor optimizations, fixes and cleaups
Date: Mon, 2 Sep 2024 22:05:27 +0800
Message-ID: <20240902140532.2028-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)

The summary changes of the first two patches is as follows:
 if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
	return;

- while (READ_ONCE(obj_nr_tofree) && (READ_ONCE(obj_pool_free) < obj_pool_min_free)) {
+ if (READ_ONCE(obj_nr_tofree)) {
	raw_spin_lock_irqsave(&pool_lock, flags);
-	while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
+	while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
		... ...
	}
	raw_spin_unlock_irqrestore(&pool_lock, flags);


Zhen Lei (5):
  debugobjects: Fix the misuse of global variables in fill_pool()
  debugobjects: Remove redundant checks in fill_pool()
  debugobjects: Don't start fill if there are remaining nodes locally
  debugobjects: Use hlist_splice_init() to reduce lock conflicts
  debugobjects: Delete a piece of redundant code

 lib/debugobjects.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

-- 
2.34.1


