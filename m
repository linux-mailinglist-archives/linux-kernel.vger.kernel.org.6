Return-Path: <linux-kernel+bounces-339810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B24986ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097E5B212C8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9803170A3F;
	Thu, 26 Sep 2024 02:16:08 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5522EE4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727316968; cv=none; b=KWPeBBUmmKrMgM25mRO2NSZpD5/qZrspwSn5zANRBDhvAmbJAGgBHj7GVvLr4pBNAOIFrka8k7gmlLXatv4ALNTfppoK1hrocC+Qk86TcvLnIUujusE4oWMc8GpJIsMbNZ2kcCM80pMZhkY+dWpRdDMnefD0CBJhGfsrIgtW8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727316968; c=relaxed/simple;
	bh=YG9CIF00k0hX+/pxH5fkRqdnoNn9SAtF0fHsKxJuHEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L6BDEWHu+6O4KPme04vp2AbhK8dzuVmTrcDi1B7iZc7szFF6XA779LFyWXfmNRTS6bseYbSzE1QNSMk6wUEzYnkpuYNTN2FoQUiLioSrcG8XqxirbNomDfSq1TE4dEJ2ptuoj576UdpLSQIEc2zGHKGuVbbf4w1Obuq4I9wbNBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XDcYP2JcGz1HKBv;
	Thu, 26 Sep 2024 10:12:09 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 79B451A0188;
	Thu, 26 Sep 2024 10:16:00 +0800 (CST)
Received: from huawei.com (7.223.141.1) by kwepemg200007.china.huawei.com
 (7.202.181.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Sep
 2024 10:15:59 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tejun Heo
	<tj@kernel.org>, David Vernet <void@manifault.com>
CC: <linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>
Subject: [PATCH 0/2] sched_ext code cleanups
Date: Thu, 26 Sep 2024 10:15:03 +0800
Message-ID: <20240926021506.340636-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200007.china.huawei.com (7.202.181.34)

Zhang Qiao (2):
  sched/ext: Fix unmatch trailing comment of CONFIG_EXT_GROUP_SCHED
  sched/ext: Use tg_cgroup() to elieminate duplicate code

 kernel/sched/ext.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

-- 
2.33.0


