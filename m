Return-Path: <linux-kernel+bounces-324461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3D974CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26441282245
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF3E5339F;
	Wed, 11 Sep 2024 08:35:46 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540E413B5A9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043746; cv=none; b=QzKJusOgzb0ZwgdJlAXBd6D8CGbnJdqX7BcSF961rjFAXD5VcOIx/5q0JVSJQRCQYwjdqlgMVjmu++tW/CpRnxMR+cF+pbXVN+VZQ/7SsADCC/aOX2Rv+vAUB1zeSGXZt+Vr+fls4o8RQzoDRxi+UU/0+UBQQzCJhv8kOi6GU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043746; c=relaxed/simple;
	bh=alghjBsHv30tqzJ3vmmNhuuL+m8hJwp/Vnyh38omt7M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M4mIo8L2dvNJqdo6mGYQjqwGgiyvtTWe7q8wmK8Jq8SCjY4+NugJPneFJcTT4ZGPj0yi4Ci4I5tFVvYJhbTHyUZPtOdyIWxsh3+KQrdsodfXjpPVUbIo//QJ5q+CwO2JMtOq2zNr7c9xcY9kKuyUoepL27CP2XiT6CQMAzSFh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X3Ylz2kPDzyRk3;
	Wed, 11 Sep 2024 16:34:55 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A425140156;
	Wed, 11 Sep 2024 16:35:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 16:35:40 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 0/3] debugobjects: Do some minor optimizations, fixes and cleaups
Date: Wed, 11 Sep 2024 16:35:18 +0800
Message-ID: <20240911083521.2257-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)

v2 --> v3:
1. Use the lockless mode to fill the pool.

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

Zhen Lei (3):
  debugobjects: Delete a piece of redundant code
  debugobjects: Use hlist_splice_init() to reduce lock conflicts
  debugobjects: Reduce contention on pool lock in fill_pool()

 lib/debugobjects.c | 105 ++++++++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 35 deletions(-)

-- 
2.34.1


