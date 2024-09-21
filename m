Return-Path: <linux-kernel+bounces-334929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DCE97DE70
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A131C20A95
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A32A3B784;
	Sat, 21 Sep 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6ZZWItZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026506FBF
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726945677; cv=none; b=NayiU0IqTaYuVz+6frZLoJAVVgag7puk1jtbuL3NRFT90IrFAJEp9JVOEGK81ELJO6nPNhL2J0lLJZ3ZeS2iogrwDN1VAlgd9cilHOnLQzuJkw5D100Qv3hY1pefM5BEJrQIVH7mvpYEX/NcbWl8JiFMH0XBsi5Whm2p2cZ6BYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726945677; c=relaxed/simple;
	bh=pyaCrcHB/Mr5VF2u4W6E8iy8EGG7VcpVDbY8a1Z1+Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAywYyhUN5Bbv8pb6yoBb1jP5QR5Z4LDlTnet3IGtrlem2aGTXyEeyCiJVGCgyUz4XeymSb4wjVKRUb8lZELu2o1r5kTqUVhNOIjlbrO3XlNHxCupNXtsBeLjj0d2NQdP+d40J3rCmYWNKvoETZzbh7Vf1Gzld0aOvwlx64cRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6ZZWItZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726945674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0LRRxfCp9iMgUROo0MKIcSdudEZHsVNL3LfcU6gReA8=;
	b=b6ZZWItZYaZPKfVScN6mmyy3U05NiNKLXiT7/Sc61cD3adrlISn26rzVxVT8wNzJkqBATq
	Mbt+IrQGRJ/uEryGW7kvJtP3g44NLRc3MUbhMfrUTJR0YPnQdjFbxtvgzIqVpJ0u+CHMJ/
	2c3HXYK0p0DeNCMGkjEmjRIMn/uq4zU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-JfhGa0kZNW6whnrB37FXNw-1; Sat,
 21 Sep 2024 15:07:51 -0400
X-MC-Unique: JfhGa0kZNW6whnrB37FXNw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E55A192E276;
	Sat, 21 Sep 2024 19:07:50 +0000 (UTC)
Received: from llong.com (unknown [10.45.224.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B35AC19560AB;
	Sat, 21 Sep 2024 19:07:44 +0000 (UTC)
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
Subject: [PATCH v4 0/4] sched: Miscellaneous isolation related cleanups
Date: Sat, 21 Sep 2024 15:07:16 -0400
Message-ID: <20240921190720.106195-1-longman@redhat.com>
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


