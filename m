Return-Path: <linux-kernel+bounces-553823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61912A58F49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D390A3ABAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE88170826;
	Mon, 10 Mar 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9PW3tVJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F53224896
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598389; cv=none; b=cILSN3aGCGQ8pYoOJO06VjbQg1CRPTMuoAPLqdL/rOnh8lSASVyNIYV3WOeuJ4wi1G/jGizaOtnJ8PYDt4ZgRFeUnL2uBC+4EUck2rSreKLEHmAn5XfZwxPpjFNmtL9dF0FelS7uVkOaYk9Rh3ks9NZHDbmP012fmTk5agg59Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598389; c=relaxed/simple;
	bh=X2P8BmFaIfr6ljYnPxqVzE0dAYgml35bG8jKsbvO9OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1e78Fa9SgxqWjSAYARkSfq9ONN2+QilJ2eT6DDN1OPDcrMzq6vojVG/dohDQjD8ZndeVm01NTu6WJ6+x6XvRt4x3KKzAmVK3oZaSycMUnLOwhXdd58ZB9s81GuCYcfwHTPxwbkCogAd5i7oONOK6zFOICvCBv+u1UhxT/QmLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9PW3tVJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741598387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LgP9YNR9e/J52BmiorQfd082BVFSTbBL5ZmjdHK0AhI=;
	b=c9PW3tVJtzB/Wn1OX+BSpGAJEyiE+43jRLw0LBKbbTy4xQKVotYbjSPgieMfRmsm3672Bt
	BZpQ48oUiBGtsm6Mt1/juXsCc3gbtxcO4zblhGKcsvfxsFJ3W6GzScOyntXJj2Wz2VJ5iP
	/lx82SqHRyKUrbaJ0vDRspaZGZeGRAU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-aNfwR5DFOjK8EdSVidxNJw-1; Mon, 10 Mar 2025 05:19:46 -0400
X-MC-Unique: aNfwR5DFOjK8EdSVidxNJw-1
X-Mimecast-MFC-AGG-ID: aNfwR5DFOjK8EdSVidxNJw_1741598385
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bd8fd03a2so17632525e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598380; x=1742203180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgP9YNR9e/J52BmiorQfd082BVFSTbBL5ZmjdHK0AhI=;
        b=EbcBzJLmJwonjKHjKYJO1jAPg4EtX2SwFSw2msS4FXhFv6WcUWOs5sQOrqWXsneVcS
         DlVTxSqLJSKnYhc7x9aK/7MggLmbKKneIzVW+uatvrOVHoYjqQ+IngwSlWSVQ6sJuPNn
         m3kzg17ZNlrCRbBThNLHeNtPInPA0egNNgqmRAgWz/EdqBQ1EzI53AK07+xSpuSy0DFx
         +5lrseoEZgo2xM9LI40NUm1huhhKiSCz+oJ4U7ojVDLc+dIO0Zidk2WgHalN09dggEmu
         5iAf1VCzzTndsroU16DabZjJ0Njwko7Wz2xtA1bPn1TcYjmtpk+PpVwGAAb5nZDeSjLr
         XRgQ==
X-Gm-Message-State: AOJu0Yz6uPD4fuvv6VbBdbzOtyoWqlEhwz0nfk95rBztjdmL6/avqB1M
	0/HYd8spFvVPDOILVFK4VvqcPwPb6xF9BnaYpjc1BCIW3CdfED8GvyRXFTZm6tPpuul6kFaDyB3
	geFCTbP8QM2LZAt+EvH44/pkFJjeASlsaPKj4jCyrnAUyhgN003K4gqcBZ82bbSnodsjgBz9I8K
	SUYKKNVXGTczu7rUNcZIiY0hebaifWYjRKMZVGFsXVaoeLx/Ly86A=
X-Gm-Gg: ASbGncvCcZkPb+ibdMmRKDfyH1owabRlfz+WTCQSMIGhqUlRFjnY+mCJF8aZ9QFZJx3
	CDKBBcWXLX3wzU8PCxnonfTtoT/PsDe8HioRJzU1/8Qd11kPPKV0Ac3xIjZZ7fiRvRO5gE86Xdf
	RvZ4WzVVYGcn5NtbTyMmSmwKmfuCAEE1wAUCw4TYuF1uK5WlMO6tdXIyrRD5vWm+TmFlxm8AsgM
	JHKs15h3ZqyUSZXhL+Jqnm4dqacgP2rrUN3fZ906vGlC4q0vePoAwFTG5YyWDbsPDBhEoe+ALQC
	7/9OfO4exmI/NkTN7zbdkehU1EoZqInn49Zfm26qD48=
X-Received: by 2002:a05:600c:3586:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-43cec4c26d2mr35851835e9.23.1741598379909;
        Mon, 10 Mar 2025 02:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK8kDv/kIF5AujcImOZ6FzR7/lxqopu1eD3a3yfv9LuJ8Id2hPzJtux5sr6e0hwrEqeIWN8w==
X-Received: by 2002:a05:600c:3586:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-43cec4c26d2mr35851415e9.23.1741598379425;
        Mon, 10 Mar 2025 02:19:39 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce8a493d0sm77462735e9.1.2025.03.10.02.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:19:38 -0700 (PDT)
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
Subject: [PATCH v3 0/8] Fix SCHED_DEADLINE bandwidth accounting during suspend
Date: Mon, 10 Mar 2025 10:19:27 +0100
Message-ID: <20250310091935.22923-1-juri.lelli@redhat.com>
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

This is v3 [2] of the proposed approach to fix the issue. With respect
to v2, the following implements the approach by:

- 01: filter out DEADLINE special tasks
- 02: preparatory wrappers to be able to grab sched_domains_mutex on
      UP (added !SMP wrappers back as sched_rt_handler() needs them)
- 03: generalize unique visiting of root domains so that we can
      re-use the mechanism elsewhere
- 04: the bulk of the approach, clean and rebuild after changes
- 05: clean up a now redundant call
- 06: remove partition_and_rebuild_sched_domains()
- 07: stop exposing partition_sched_domains_locked

I kept Jon and Waiman's Tested-by tags from v2 as there are no
functional changes in v3.

Please test and review. The set is also available at

git@github.com:jlelli/linux.git upstream/deadline/domains-suspend

Best,
Juri

1 - https://lore.kernel.org/lkml/ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com/
2 - v1 https://lore.kernel.org/lkml/20250304084045.62554-1-juri.lelli@redhat.com
    v2 https://lore.kernel.org/lkml/20250306141016.268313-1-juri.lelli@redhat.com/

Juri Lelli (8):
  sched/deadline: Ignore special tasks when rebuilding domains
  sched/topology: Wrappers for sched_domains_mutex
  sched/deadline: Generalize unique visiting of root domains
  sched/deadline: Rebuild root domain accounting after every update
  sched/topology: Remove redundant dl_clear_root_domain call
  cgroup/cpuset: Remove partition_and_rebuild_sched_domains
  sched/topology: Stop exposing partition_sched_domains_locked
  include/{topology,cpuset}: Move dl_rebuild_rd_accounting to cpuset.h

 include/linux/cpuset.h         |  5 +++++
 include/linux/sched.h          |  5 +++++
 include/linux/sched/deadline.h |  4 ++++
 include/linux/sched/topology.h | 10 ---------
 kernel/cgroup/cpuset.c         | 27 +++++++++----------------
 kernel/sched/core.c            |  4 ++--
 kernel/sched/deadline.c        | 37 ++++++++++++++++++++--------------
 kernel/sched/debug.c           |  8 ++++----
 kernel/sched/rt.c              |  2 ++
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        | 32 +++++++++++++----------------
 11 files changed, 69 insertions(+), 67 deletions(-)


base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
-- 
2.48.1


