Return-Path: <linux-kernel+bounces-407614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2AC9C6FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9EF1F21C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61041200C8A;
	Wed, 13 Nov 2024 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlF0XT3L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB041DEFF6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502665; cv=none; b=BtoAzJdAYD2fIUcmjv+xKvOtvrUPVCmxzj9+SyP5UrvOKR/UPW5DYGSLde3J7l6VgTQA1RhP0ja/5AuaijESr/G3QKINbx7gKgYhViRWg3nV5jQU2HM37VLuUlFLj2hyX5mVUeGKWpw/uiSz4Gf5AroE43CeXjXIWShCdc64Fa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502665; c=relaxed/simple;
	bh=Z8cHpr28PWqnrAz+oEPF5D6cFNlxTQjd8wjr0NQW91Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DipOJKiyDQ/Z3yf26dq93m53xhv8JtajAgKMfSXRDwYgqCczm3WDFltKh8l/NtuOvwxUQzrJDmGV2sofdl1v4C9tXFUz8OwcZnizZzLSacDZSp+gJ0lPtxJUspfWow3E6yTCWnlz4LmMSlByCb+6bHHsdp9PyGP99CxXiYGzobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlF0XT3L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731502663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DmJ4wu8DbYhc8Pv8vZYpHZ1ZdW4EpmQbe3noGMGjsOA=;
	b=DlF0XT3Lshybk+3t+CskwE732BYeihosSZdpyBAB/Ar0rCv55hEGV2HpK13W9hm3zxKTbD
	+h7zWr0tWMzJP0KbUpEZEdNNxA9DeqF0oVJ7UhsnrArW5FDuZ+OczWBZ2CuLosSPgHE9zC
	6s77MM0HIW1Btg9nX2CMuufuM1XEGAo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-kYQMT5f9NQKHbi4VCxDriQ-1; Wed, 13 Nov 2024 07:57:42 -0500
X-MC-Unique: kYQMT5f9NQKHbi4VCxDriQ-1
X-Mimecast-MFC-AGG-ID: kYQMT5f9NQKHbi4VCxDriQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d5016d21eso3781730f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502661; x=1732107461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmJ4wu8DbYhc8Pv8vZYpHZ1ZdW4EpmQbe3noGMGjsOA=;
        b=erSb4BvA4U5xzJLx6LW76yBEyF3vC/sJTOC+RQ4f1w18kWvd0oHdqnuJ54GXl6SHKz
         n67eQGeoyhbmHIOUjd42hoRp+bEzSPvYRKjjamPK+LWCtEVuEv28qELoqYDrL6FP9WJz
         fbGPhuclqziUzNP4faCcLL8LlRlHvflw2+cPTO2wtZqe2icIC9ogxa1ZhHDkXr6tOUdF
         TiqzE18cihN4d2/ESVcIsN6Aw6p70tWe6X6zZ+PyGZ4sqXrVSBZ5bdmu3P+yLOt/NLtJ
         2xKBAEEhvde9AvLDPKNcXyIrPbrmjgG/sDustRI2QS/r6pJFMWh9HniLp/Hlotk6V6X/
         3qOw==
X-Forwarded-Encrypted: i=1; AJvYcCWcFQVZXzcRGSSN55IafGN+OMLZx4HRvrpbXv286y/7ycpU8xcF/2pwc+qflbadfU8+vw2IemjlCHFSXJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvkLiEvnjfhbXEOsqyJ61IGKosTqTIJyE9IodCjXtzpzTvr3Ry
	VVnq+/SG5550wi06+rbtlxVA+8hYhbSHSQLp6Y6EJ1q7GsXtcqHe5Ff/kBqZHiE5tS4eXfISAmq
	FzHv3bGsx267UoBIzHEfs8eO/SBwnBzI5yS5Ag8WfqYtwqyt74vyJwFfORXU2gg==
X-Received: by 2002:a05:6000:402c:b0:37c:d183:a8f8 with SMTP id ffacd0b85a97d-381f186b35bmr15750521f8f.19.1731502660919;
        Wed, 13 Nov 2024 04:57:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECeneTw0M0UDknUvW+szkOZ4bQp4iqEGGPv+Sz4EG7o+C84HznYrz6JG/tInCizYIUil6JRw==
X-Received: by 2002:a05:6000:402c:b0:37c:d183:a8f8 with SMTP id ffacd0b85a97d-381f186b35bmr15750484f8f.19.1731502660526;
        Wed, 13 Nov 2024 04:57:40 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed997391sm18486834f8f.45.2024.11.13.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:39 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 0/2] Fix DEADLINE bandwidth accounting in root domain changes and hotplug
Date: Wed, 13 Nov 2024 12:57:21 +0000
Message-ID: <20241113125724.450249-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

This patch series addresses two issues affecting DEADLINE bandwidth
accounting during non-destructive changes to root domains and hotplug
operations. The series is based on top of Waiman's "cgroup/cpuset:
Remove redundant rebuild_sched_domains_locked() calls" series [1] which
is now merged into cgroups/for-6.13 (this series is based on top of
that, commit c4c9cebe2fb9). The discussion that eventually led to these
two series can be found at [2].

Patch 01/02 deals with non-destructive root domain changes. Currently,
such operations do not correctly account for dl_server contributions, as
they are only considered on destructive changes (where runqueues are
reattached to new domains). This patch ensures that dl_servers’
bandwidth contributions are properly re-added to root domains that
remain unchanged, preventing accounting discrepancies.

Patch 02/02 deals with hotplug. For CPU hotplug events, DEADLINE
bandwidth needs verification to ensure adequate bandwidth remains after
a CPU goes offline. The current implementation overlooks this check,
potentially leading to overflow conditions. This patch modifies
dl_bw_manage() to correctly detect and handle overflow situations,
special casing dl_servers' bandwidth contibution.

Please go forth and test/review.

Series also available at

git@github.com:jlelli/linux.git upstream/dl-server-apply

Best,
Juri

[1] https://lore.kernel.org/lkml/20241110025023.664487-1-longman@redhat.com/
[2] https://lore.kernel.org/lkml/20241029225116.3998487-1-joel@joelfernandes.org/

Juri Lelli (2):
  sched/deadline: Restore dl_server bandwidth on non-destructive root
    domain changes
  sched/deadline: Correctly account for allocated bandwidth during
    hotplug

 include/linux/sched/deadline.h |  2 +-
 kernel/cgroup/cpuset.c         |  2 +-
 kernel/sched/core.c            |  2 +-
 kernel/sched/deadline.c        | 51 ++++++++++++++++++++++++----------
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        | 10 ++++---
 6 files changed, 47 insertions(+), 22 deletions(-)

-- 
2.47.0


