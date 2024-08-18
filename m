Return-Path: <linux-kernel+bounces-291273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781C6956029
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A13C1C20F68
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E48155732;
	Sun, 18 Aug 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSzTBhqM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAFA79CC
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724024743; cv=none; b=goMgkHheMpcj8g4CK00wkciqp+j8j3PYXB9hpUqL0i5+WBW0ORw8+8P3tJBDwlb4oJmV4++XCw5i1CECDUYp2e0QdoiQFKJYKvij/C9KFa0S/aMGhpYAZl0LkDY7oSH1NPCiSvPY5ZEncvmM3Vtv68CcP4qLa3h6Xnk7bJTe5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724024743; c=relaxed/simple;
	bh=OoxJAVhx6N9tsQBqgeC6trlosi9gZ5KSE76Uz1vgpRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bL51fm/lAQTxTG+jLpMUX2Ag4etGK7DKgYFEz4B97Of7XcwHvqOF2I0lGfG1hLngIm7qrmsY7cuwPu75sps9SjQlVPjyug6ZMUjpiGz2Zs+oMshsDwULqiC4JdaGtSIc6TlC3Ej6nCmXxZCBFCjaJSNF6v9h4rCcxjGXsbWCpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSzTBhqM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724024740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lP9NMDmzXVz95/yrLSAwrJlGfI6BAWY4FaApBUpYsu8=;
	b=OSzTBhqM8eD+XEP9k5a1ACVcYMKzh6qfLX7NCz4d9gcQkO5oOzyMhBjR9r9261KScjJ3ND
	UK+MGd4c7KN0EwnXDfFRKmkALHbcbRYBqMupDcTF3gEVD0prJrnZzXidzS0jHH8Nnt7OI3
	GspsiwW8oE/5BeyOemaM4hMHSvtXbr0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-CaJVFpuBPXuRFufws_m0AQ-1; Sun,
 18 Aug 2024 19:45:36 -0400
X-MC-Unique: CaJVFpuBPXuRFufws_m0AQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F03C19560AD;
	Sun, 18 Aug 2024 23:45:34 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F4DE30001A1;
	Sun, 18 Aug 2024 23:45:31 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/3] sched: Miscellaneous isolation related cleanups
Date: Sun, 18 Aug 2024 19:45:17 -0400
Message-ID: <20240818234520.90186-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This series contains a number of miscellaneous sched/isolation related
cleanups.

Waiman Long (3):
  sched/isolation: Add HK_FLAG_SCHED to nohz_full
  sched/fair: Use HK_TYPE_SCHED housekeeping CPUs
  sched/isolation: Consolidate housekeeping cpumasks that are always
    identical

 include/linux/sched/isolation.h | 19 +++++++++++++------
 kernel/sched/fair.c             |  7 ++-----
 kernel/sched/isolation.c        |  2 +-
 3 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.43.5


