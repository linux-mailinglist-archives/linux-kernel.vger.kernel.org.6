Return-Path: <linux-kernel+bounces-185710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4510F8CB996
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AE61C21340
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C912A1AA;
	Wed, 22 May 2024 03:16:01 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DD933F9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716347760; cv=none; b=WAazrb0W8eTNyzsElGEciUsJe6iuYgzYkwJmSPwr8GC7nt2r6/XPEEUTltsSZcLlm2i8flez/fuXBi7bwjxMZ5AjXpmbnz8SK7vQc/5LdOMom08XgtxhNOpnuP9rscAPGb+8boK/Rig461R0QpJWs9pdlrevMo2+tzFR076jZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716347760; c=relaxed/simple;
	bh=a9dlj3+o6HToo+8tpB6GNpm4eF+qX0LQAyNolfb61Fg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dw1VXawhH7zTHyxfdpJClB6w14MPE+rgZSV8xFfjLFT+NqFk/6KzozOS2ssQEIVqe0wn/6RvHAg5Snrm9y89LRyz2i3eOQEzg5ENodIqJRXDCrol5qsd1Dd/C7g2wWgi1jA2vU0FGN8Iu/+JP6S4sO9ow5eWvWSOjM60HMtaMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VkbvZ1jsZz2Cj39;
	Wed, 22 May 2024 11:12:26 +0800 (CST)
Received: from kwepemf500005.china.huawei.com (unknown [7.202.181.243])
	by mail.maildlp.com (Postfix) with ESMTPS id E3D0D1A016C;
	Wed, 22 May 2024 11:15:54 +0800 (CST)
Received: from huawei.com (10.67.174.161) by kwepemf500005.china.huawei.com
 (7.202.181.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 11:15:54 +0800
From: Cheng Yu <serein.chengyu@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>,
	<changhuaixin@linux.alibaba.com>, <shanpeic@linux.alibaba.com>,
	<dtcccc@linux.alibaba.com>, <tj@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <zhangqiao22@huawei.com>, <judy.chenhui@huawei.com>,
	<yusongping@huawei.com>, <zhaowenhui8@huawei.com>, <liaoqixin@huawei.com>,
	<serein.chengyu@huawei.com>
Subject: [PATCH 0/2] cgroup cpu: set burst to zero when cfs bandwidth is
Date: Wed, 22 May 2024 11:10:05 +0800
Message-ID: <20240522031007.643498-1-serein.chengyu@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500005.china.huawei.com (7.202.181.243)

In the cgroup cpu subsystem, when we remove the restriction on cfs
bandwidth, the burst feature is also turned off. At that time, we expect
that the value of burst is zero.

Patch 1 fixes it in cgroup v1 by Zhao Wenhui and patch 2 fixes it in
cgroup v2.

Cheng Yu (1):
  sched/fair: set burst to zero when set max to cpu.max

Zhao Wenhui (1):
  sched/fair: limit burst to zero when cfs bandwidth is turned off

 kernel/sched/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.25.1


