Return-Path: <linux-kernel+bounces-315170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD55096BED1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A731F24828
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C681DA31C;
	Wed,  4 Sep 2024 13:41:36 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E7146013
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457296; cv=none; b=s+s5YSzGmHfPD+Nxlq7Lg8aXxqzlLsmZJHCo3eWu56hKsXA9v5Dpvkk1PirXVcrpNOd6wt2GprR4tKl5anGrDpj6MWuC97WYj2Ie6l0rVvMErcmhHBHr/dm/qNHPVqUJfnNouBs97RxWhzFIPYrw8x3EjakS1WxykVACWzWxz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457296; c=relaxed/simple;
	bh=q5VbUnoTKKfKLTWDHFxEmI8BkAl+0M2ZszC4nBc4N28=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=igFDM7KnhMBnnlxx7wc22LOZ9QElzEAhiJ5v5a0EwfzHq/fmA5/woU08DAcRsJyTHon54lCsphFxihIArqlgA7vBArk3pj6GA4Gfd8yFamN1Fk5HXYxrGDULWuT7HCVpiiKjt72tqu+8WI4RkSkEoJBBhx/Dp1oAzuuwNjTZDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WzNtY3ZNqz1S8X5;
	Wed,  4 Sep 2024 21:41:09 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 929A81A0188;
	Wed,  4 Sep 2024 21:41:30 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 21:41:30 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/6] debugobjects: Do some minor optimizations, fixes and cleaups
Date: Wed, 4 Sep 2024 21:39:38 +0800
Message-ID: <20240904133944.2124-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)

v1 --> v2:
1. Fix the compilation attributes of some global variables
2. Update comments and commit messages.


v1:
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

Zhen Lei (6):
  debugobjects: Fix the compilation attributes of some global variables
  debugobjects: Fix the misuse of global variables in fill_pool()
  debugobjects: Remove redundant checks in fill_pool()
  debugobjects: Don't start fill if there are remaining nodes locally
  debugobjects: Use hlist_splice_init() to reduce lock conflicts
  debugobjects: Delete a piece of redundant code

 lib/debugobjects.c | 58 ++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

-- 
2.34.1


