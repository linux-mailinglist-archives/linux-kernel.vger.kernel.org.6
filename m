Return-Path: <linux-kernel+bounces-427665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790049E087D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D50B37892
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4D2036EB;
	Mon,  2 Dec 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aln2wd9b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E871FDE0E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148483; cv=none; b=O+i0fcHoTyxiUGrtr9F4fJlEnQ97A9OIILAlMpfbONM5gzHEaQPXuMO3dJlNJtvtMeBbgat44cRbqK3jeDzUylBkK/lCQ8B209mFbPcoh2pedqXG/NF/kZ7PcLrCFkZLvSuI0EH0mVSQJvWDZYUZzXqMXPUViarSMX9P/4nauyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148483; c=relaxed/simple;
	bh=6iwE6UAQSxsezIeOCWE7R4yuDpAKCe1J8qHFvuHcvmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4cFAiQSqBSnxXCBJyomWkS/vU0NwTEhMDS2MVRJf+xueV44kztTWgqNs17ztuZtjtAPpRQ39MJczSZWBpe5fLf2VrdVRtfb0yVaX6UWUOV7Ixu5DCd+ktjRAxNODr1UPTJVdEHFkljBFW8NOG4Mkk6MFepAgldqvBMc1neysGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aln2wd9b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733148480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Iz4MoWd6Xe+mQiNWo1fYVlGp8t2VPKJ0SVtNsXySOC0=;
	b=aln2wd9bt6OjZK1FX8Q4qc3QU3qq8DUqzO+w/9+N0aYV7fKzTV07MUcJMv4TkvHRl43ktS
	f6WHeZF4Au4hQZI7CpYRikCyIOX6z40VuWEFORRYRmCX/2pLtW5V1u7eKsQ44D5SmfYeJ9
	bkI3DFa1Bxs4YIcxg87Kp/6kae/L4hY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-foZx1-koOT-JBa3l99YeOg-1; Mon,
 02 Dec 2024 09:07:56 -0500
X-MC-Unique: foZx1-koOT-JBa3l99YeOg-1
X-Mimecast-MFC-AGG-ID: foZx1-koOT-JBa3l99YeOg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5E571955D4B;
	Mon,  2 Dec 2024 14:07:54 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DA5C1955E98;
	Mon,  2 Dec 2024 14:07:49 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 0/2] sched: improve task_mm_cid_work impact on isolated systems
Date: Mon,  2 Dec 2024 15:07:33 +0100
Message-ID: <20241202140735.56368-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This patchset introduces two small changes to make the task_mm_cid_work
lighter and less problematic for RT tasks.

We observed moderate latency spikes in a system with isolated cores but
multiple tasks running on those cores (e.g. one stressor and one
measuring thread).

If the nohz tick occurs during the measuring thread's execution (i.e.
the RT task), the task work calling task_mm_cid_work alone can take
around 30-35us, this is above the requirements for isolated cores.

The first patch reduces the runtime of the task by lowering the number
of cores that are checked during CID cleanup. Instead of iterating over
all possible cores, we only check the ones defined by the CID mask.

The second patch moves the work in a preemptible context (RCU callback),
making it harmless towards RT tasks.

We run the benchmark on a 128-core aarch64 box with 4 housekeping cores
and 124 (1-31,33-63,65-95,97-127) isolated cores.

Each isolated core is running an instance of stress-ng:
  # (foreach N in 1-31,33-63,65-95,97-127)
  # taskset -c N stress-ng --cpu 1 --cpu-load 80
And an rtla timerlat measuring thread (besides the first isolated core
running the main timerlat thread):
  # cpus=2-31,33-63,65-95,97-127
  # rtla timerlat top -q -P f:95 -c $cpus -H 1

Our 30min test run without this patch reaches a maximum latency on one
core (say cpu 113) of 48us.

After this patch, we get a latency below 20us on all cores.

Gabriele Monaco (2):
  sched: Optimise task_mm_cid_work duration
  sched: Move task_mm_cid_work to RCU callback

 include/linux/sched.h |  1 -
 kernel/sched/core.c   | 21 ++++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)


base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
-- 
2.47.0


