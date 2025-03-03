Return-Path: <linux-kernel+bounces-541443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AC4A4BCFF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766EC3AE682
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0C51F472E;
	Mon,  3 Mar 2025 10:53:32 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B51F2C5B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999211; cv=none; b=ABlruTjvfhNB1cau7Zo80wHogBJp6VuzLQSZE3p2xt+ZldMGQ3wak6BvriXm7vvm1ixYqNdJvyy9WnZG8PtJ+L1hv1MXWj6hTjl7lLMe1K2X0lE97NmyHQHMPM0JqawjSAKn3RrEqc3rXgSZ8zrStKh84LRPgjHlEGDWaRx+zLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999211; c=relaxed/simple;
	bh=LXUxz1eAYTX+ZE8k6XJtrXpRg0wE05yu4Q6GBSQSvRI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gdKydN7ho4Mv6WpMg47A0tDaguL4Qd4psqs9jFhoXjzwWxtH56ye1QW6UFB2bxiqZSwkjm69+cPNDA2eqFCjCpHUE+acrVTmES9oiVFc4dy3EbpSSb1cB5lTVmD9sPnRCCsMdbZ6dwuRwkQb4zq911U0IHtwEMI2/0eZI4D6d60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 523ArAGR091702;
	Mon, 3 Mar 2025 18:53:10 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Z5wX917hZz2K8nM6;
	Mon,  3 Mar 2025 18:48:25 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 3 Mar 2025 18:53:08 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH V2 0/3] sched/fair: Fix nr-running vs delayed-dequeue
Date: Mon, 3 Mar 2025 18:52:38 +0800
Message-ID: <20250303105241.17251-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 523ArAGR091702

Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until its
lag has elapsed. As a result, it stays also visible in rq->nr_running.
However, sometimes when using nr-running, we should not consider
sched-delayed tasks.
This serie fixes those by adding a helper function which return the
number of sched-delayed tasks. And when we should get the real runnable
tasks, we sub the nr-delayed tasks.

Changes sinc v1:
- add cover-letter
- add helper function;
- add more fixes

Xuewen Yan (3):
  sched/fair: Fixup-wake_up_sync-vs-DELAYED_DEQUEUE
  sched/fair: Do not consider the sched-delayed task when yield
  sched: Do not consider the delayed task when cpu is about to enter
    idle

 kernel/sched/core.c  |  2 +-
 kernel/sched/fair.c  | 10 +++++++---
 kernel/sched/sched.h |  5 +++++
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.25.1


