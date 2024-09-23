Return-Path: <linux-kernel+bounces-335925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C89F97EC9E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04389282BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA5A19CC1E;
	Mon, 23 Sep 2024 13:58:55 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF119C571
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099935; cv=none; b=ftvLAqqPrJ+9wyR4PqqBOiJdtKNv9JnRNiF5Cx70gPB+u7n7VAOCgxOToJtOX9veFOM5fl0/syl1s8WQkPmGWLiQYhqV9BXJa8K3wH+NBhBMmBzoIbk6II0UgXnlfdNRjLW+PyEkAAcGoFv5LsnwJvkTN4JrEGh4TjIFbQLhE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099935; c=relaxed/simple;
	bh=5rJBtXQYandVuhHQ4Ou5kmkoNt1W+v7m6bS+0hOc7sA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DBkEtqWnpJZhPhMvvlDvRpJ88SrFsG8EHVMX4/0LvScpSET42Hb9VSB+oY/GvbCGQMxwrFusT/PfwCtQZuoRl4YUd/jJWdJ2UlE8ACmTdtJpz/2zmXCc+DFiN/lCnk9bxG/QeUYQMajjmvDcHP4p4GA1QgIRV0BlZIqS6MIza/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XC4Mq2593z20pLB;
	Mon, 23 Sep 2024 21:58:31 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CFF5140138;
	Mon, 23 Sep 2024 21:58:50 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Sep
 2024 21:58:50 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <tj@kernel.org>
CC: <liaoyu15@huawei.com>, <xiexiuqi@huawei.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>
Subject: [RFC PATCH 0/2] sched: Fix compilation error 
Date: Mon, 23 Sep 2024 21:54:29 +0800
Message-ID: <20240923135431.2440320-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)

This series fix the compilation issues when building with
CONFIG_CGROUP_SCHED_WEIGHT && !CONFIG_FAIR_GROUP_SCHED.

Yu Liao (2):
  sched: Add dummy version of sched_group_set_idle()
  sched: Put sched_group::idle under CONFIG_GROUP_SCHED_WEIGHT

 kernel/sched/sched.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.33.0


