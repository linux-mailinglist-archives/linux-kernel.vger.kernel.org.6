Return-Path: <linux-kernel+bounces-560030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C03A5FCDB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1E919C1D70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD3926A0A6;
	Thu, 13 Mar 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEvRE8LP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5515CD46
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885226; cv=none; b=DExo6YE5T4gqZBCAz3IQ2AyZ+swenEtEhIzNZM9CUqFEgBcYkiKr1JkzcH86nNT1o0PA9xEwSE8/SK59ij7YzMeydNdmyylZ0TEwCwJdvspfgCfAq7Nzk2Eg92NqoBFtk6UoQc31k/BTYZrLmweU1K7j8Xkgpjj0opNFTpe8fUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885226; c=relaxed/simple;
	bh=6HcdB0yC5QztkDiCTqXXIdZjL+iu69oXgfTpHtVMkf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQumPUOlH9yMoLhw/ngjsdmO6t1faz7Joj9JijAAUH9AK64HsjReDkA10S1t/VKm8Vn2/5gbMCnuUzDzUgAe8yeArqD4CCoInh6dEiWdBhvLcJWwJCeTj3xu2zIW2Vfh4WGNM00t/W2AijttywOF3dR9DscN5+B7oiXW3rydFvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEvRE8LP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tQXGGsk/p9xyPUC5Ohnbe2+nu4NQL5Uy1PShz3/dYls=;
	b=HEvRE8LPpi/PV1XnEtrsnzBZiPWQoQXi4yJv5mwJw6qFWoJwZlRbKHEx3RYO8xahE8Wt7J
	D3B/PUmSvk5tZ1O1jSxxxxzwzK1rv7fibM8gZfiyL6SIInL6srnukFOO/0kE0e3gzBFLpE
	pjHGU9iCWYeZWTSDjS5unXeJhXstXvk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-XuvbJ5hoNi2D6HWycESx6A-1; Thu, 13 Mar 2025 13:00:20 -0400
X-MC-Unique: XuvbJ5hoNi2D6HWycESx6A-1
X-Mimecast-MFC-AGG-ID: XuvbJ5hoNi2D6HWycESx6A_1741885220
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39131f2bbe5so473825f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885216; x=1742490016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQXGGsk/p9xyPUC5Ohnbe2+nu4NQL5Uy1PShz3/dYls=;
        b=asrtfQfKclYG+QoE7hJsA9RNLTzEN7KdF2L+byWZp+N7iOROz9RWTpaV5ZO2RECEMl
         DvSnukW5eJjIMrVeCELNq2tX57esJk5loJMG/OOAC7Kor51jDMAj+cxWRI+lGgXN5Qqz
         4OTW0X4oDvNRj94hORtZodt5eUksegcQNKzZMSsgHzjxUu0nr6cs54Xl+idbtMPdt8DR
         YvWaqRkf4a+sKpgeyhDKX4dMwpUDybydi5jnlNJ/HMqwCawD5gfv+vWDK/iR5A1faxaC
         cmwJ0s8VS8bgbU0iA0G7mBS7r/lR4Mw27utlBEfEtf36alUaNoyE/V7tilxWdS+KSm+G
         AcHQ==
X-Gm-Message-State: AOJu0YxTCZQdpUIVTZsfVJtPQerczj0vJZUrTKnFVMr4/UPsmVuAYb1B
	L8r8PIeEk773v6xg/o3xNy1fmY7LItWKre0z75v4sxrcZXZvghC85cGuU9V8VluCcuJ9/lJs3ay
	ekivwShtNxy+1r9sb1V9PL42ugBZgZM+HuqnZB/fYeRANyWANd2pZfdC3txQx2z62yuB5CpS9BL
	1Ia52KitsvGZrfdi9Ej+jNuDj8JWB7ui9iNccdFjs+89RL/CdC
X-Gm-Gg: ASbGncsbAS7LsruEMesfNE2ey6PDccvKAIC13Q8WtPw0zTgfKHcE1D241MubehLPcAO
	UcEe5dx1uUy5JEMWk4J5CJGP9trIznjBY0aoQ22KH0DKpybXhV6pCA0o83ifmM96uIpm6Ys6Cqp
	PzNk5mtmtgd4HTiycEJPGkc69x1oLJNQWzhIBGPwuO5w0mRQvR87GIlIDAfeTkpNKctuVDRhY15
	eI4L6SrjSa8qAyKFWPBLwvpz0bHUHkaF6ZeoPlupVSvKE5cPerwiq4ZhY9vempXDcgUCKTm8hNO
	8VCP+h6boCMXXjv6oh3bKvCm7gsqbbMhGxHiYAdOzeA=
X-Received: by 2002:a05:6000:1fa9:b0:38f:483f:8319 with SMTP id ffacd0b85a97d-396c37408efmr361871f8f.51.1741885216095;
        Thu, 13 Mar 2025 10:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo+up8Jifl9tnxH7Tvsg8/H60XKB5L7DPnnIiNvpGW3MJJU4O1SJ2AZt8czPBV4qwDvYPTuA==
X-Received: by 2002:a05:6000:1fa9:b0:38f:483f:8319 with SMTP id ffacd0b85a97d-396c37408efmr361787f8f.51.1741885215442;
        Thu, 13 Mar 2025 10:00:15 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d18a2aaa6sm25912475e9.25.2025.03.13.10.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:00:14 -0700 (PDT)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v4 0/8] Fix SCHED_DEADLINE bandwidth accounting during suspend
Date: Thu, 13 Mar 2025 18:00:03 +0100
Message-ID: <20250313170011.357208-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

Jon reported [1] a suspend regression on a Tegra board configured to
boot with isolcpus and bisected it to commit 53916d5fd3c0
("sched/deadline: Check bandwidth overflow earlier for hotplug").

Root cause analysis pointed out that we are currently failing to
correctly clear and restore bandwidth accounting on root domains after
changes that initiate from partition_sched_domains(), as it is the case
for suspend operations on that board.

This is v4 [2] of the proposed approach to fix the issue. With respect
to v3 only patch 04 has changed as I have added the wrappers Waiman
created to make sure we always call partition_sched_domains() while
holding cpuset_mutex (issue pointed out by Dietmar on v3).

Dietmar also pointed out that the issue at hand is not fixed by this set
for !CONFIG_CPUSETS configuration. But, given the fact that bandwidth
accounting has been broken for such configuration so far (sigh) and that
the vast majority (if not all) distributions have CPUSETS enabled, we
decided to leave fixing the remaining issue for later. I will soon try
to find time to keep looking into it.

Please test and review. The set is also available at

git@github.com:jlelli/linux.git upstream/deadline/domains-suspend

BTW, I will be traveling for work for the next couple of weeks, so,
apologies, but further replies might be delayed.

Best,
Juri

1 - https://lore.kernel.org/lkml/ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com/
2 - v1 https://lore.kernel.org/lkml/20250304084045.62554-1-juri.lelli@redhat.com
    v2 https://lore.kernel.org/lkml/20250306141016.268313-1-juri.lelli@redhat.com/
    v3 https://lore.kernel.org/lkml/20250310091935.22923-1-juri.lelli@redhat.com/

Juri Lelli (8):
  sched/deadline: Ignore special tasks when rebuilding domains
  sched/topology: Wrappers for sched_domains_mutex
  sched/deadline: Generalize unique visiting of root domains
  sched/deadline: Rebuild root domain accounting after every update
  sched/topology: Remove redundant dl_clear_root_domain call
  cgroup/cpuset: Remove partition_and_rebuild_sched_domains
  sched/topology: Stop exposing partition_sched_domains_locked
  include/{topology,cpuset}: Move dl_rebuild_rd_accounting to cpuset.h

 include/linux/cpuset.h         | 11 ++++++++++
 include/linux/sched.h          |  5 +++++
 include/linux/sched/deadline.h |  4 ++++
 include/linux/sched/topology.h | 10 ---------
 kernel/cgroup/cpuset.c         | 34 +++++++++++++++----------------
 kernel/sched/core.c            |  8 ++++----
 kernel/sched/deadline.c        | 37 ++++++++++++++++++++--------------
 kernel/sched/debug.c           |  8 ++++----
 kernel/sched/rt.c              |  2 ++
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        | 32 +++++++++++++----------------
 11 files changed, 84 insertions(+), 69 deletions(-)


base-commit: 0fed89a961ea851945d23cc35beb59d6e56c0964
-- 
2.48.1


