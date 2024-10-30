Return-Path: <linux-kernel+bounces-389323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210BD9B6B61
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACA41C23B32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FA61A2564;
	Wed, 30 Oct 2024 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEF/z7vt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498511BD9DD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310819; cv=none; b=malJnvRl3pX/eHTM2zbthEbtcQByNVOHFRKUOMaK/WHCOOLabSDUBOjQvys5DfkXewKiWzjMAkHZ+1ELM9+ENcZSCklKzax4ug7UhwO7mfQR1XKIkYTD+6DryCzslYgcT1bSSLc9daCVk+DHcTi3/WBjZdvTgtII5SnZY1gRQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310819; c=relaxed/simple;
	bh=pyaCrcHB/Mr5VF2u4W6E8iy8EGG7VcpVDbY8a1Z1+Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AONPHRB0mkZ0B5LYq+axJCigu0ve7dyYpFwALAi0xlEfnT/zMgNfwDMCV7RLUdshGxSDlqP7wnQeOrytqSguQqqOGeP+1xOGT37ofBw2hJq488kNvfQCLxmthyJL87yDgU5QDuUdMu8flYgHv86CpLStWOnzoA17WbnPRGviTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEF/z7vt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730310816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LRRxfCp9iMgUROo0MKIcSdudEZHsVNL3LfcU6gReA8=;
	b=ZEF/z7vt4ZiWj9IUk48v2gIhrdZX3IqkJBAC36ZbgppRT+XSizKGwwtHAziJqca3nPVAfY
	XJzvzYz1m/Baa9uizBD4KUAN85segW/UvQt2ufdPZwRWoHw7Mi3A6QIAI2yMFkVc73MwLE
	+VYzUdnmuCY6Mn60iZMAsv20bDHGGlI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-EQ6zFdYrMca6J1AxLZUT0w-1; Wed,
 30 Oct 2024 13:53:32 -0400
X-MC-Unique: EQ6zFdYrMca6J1AxLZUT0w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 469121955F10;
	Wed, 30 Oct 2024 17:53:31 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.200])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB53019560A7;
	Wed, 30 Oct 2024 17:53:27 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RESEND PATCH v4 0/4] sched: Miscellaneous isolation related cleanups
Date: Wed, 30 Oct 2024 13:52:49 -0400
Message-ID: <20241030175253.125248-1-longman@redhat.com>
In-Reply-To: <20240921190720.106195-1-longman@redhat.com>
References: <20240921190720.106195-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

 v4:
  - Make "isolcpus=nohz" equivalent to "nohz_full" as suggested by
    Federic.
  - Update the scheduler code to use HK_TYPE_KERNEL_NOISE.

 v3:
  - Fix incorrect housekeeping_nohz_full_setup() flags setting.

 v2:
  - Remove HK_TYPE_SCHED and related dead code
  - Change consolidated name from HK_TYPE_NOHZ_FULL to
    HK_TYPE_KERNEL_NOSISE as suggested by Frederic and update
    isolation.c as well.

This series contains a number of miscellaneous sched/isolation related
cleanups. Other than reducing the number of cpumasks in the housekeeping
structure, there should be no other functional change.

[v1] https://lore.kernel.org/lkml/20240818234520.90186-1-longman@redhat.com/
[v2] https://lore.kernel.org/lkml/20240904171441.1048072-1-longman@redhat.com/
[v3] https://lore.kernel.org/lkml/20240904183650.1053708-1-longman@redhat.com/

Waiman Long (4):
  sched/core: Remove HK_TYPE_SCHED
  sched/isolation: Make "isolcpus=nohz" equivalent to "nohz_full"
  sched/isolation: Consolidate housekeeping cpumasks that are always
    identical
  sched: Unify HK_TYPE_{TIMER|TICK|MISC} to HK_TYPE_KERNEL_NOISE

 .../admin-guide/kernel-parameters.txt         |  4 +++-
 include/linux/sched/isolation.h               | 21 +++++++++++-------
 kernel/sched/core.c                           | 12 +++++-----
 kernel/sched/fair.c                           | 19 +++-------------
 kernel/sched/isolation.c                      | 22 ++++++++-----------
 5 files changed, 34 insertions(+), 44 deletions(-)

-- 
2.43.5


