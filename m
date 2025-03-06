Return-Path: <linux-kernel+bounces-549089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F7EA54D0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE7B1671B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160DB14F9C4;
	Thu,  6 Mar 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hqg+ipeA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41C13C80C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270249; cv=none; b=F5M3JoawmyR61tFYGETMsJqE+GoMrtwueas1/1mqopMhNeCVnlKzU7lqCJYTGHkj2uGjgDMaTQQSCh5WpgYo3SnFlqXFjHz0/bQxfTnLUHfTYYih5yFutMMwm/EI6xZ1KWroMQwCtdCyH7H4XXmF9Twep1MQpQtE/sABO41wwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270249; c=relaxed/simple;
	bh=vb1yMpDVAEn02NbneTokVcFGISNeAl4CsozM6DNbXrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5c1T6ZRay8D/fuaxBlmYKE+fd4j1kBITBOO/kd1Mj2FMs1t6WacqdGTi063wpBNiXzxvR0rVvubP5Grw51jPFY6FrHWuWZXah7d0iZhetrJWKT0DIeOHG3en+asLjYaoc8yYazH7SD18W4aPcS4nVCmluXSVvrMPdxStXWu/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hqg+ipeA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OREnm9aUBj2V96zq2XupaDSMV0AJ0BW+JRJEQM5qOOs=;
	b=Hqg+ipeAhpbMVvEVUs96wnye+seq4fYTDTRcsv8EbE1dB51/q2BDf/rWY6NlIN+EY7rXNN
	gq0LtbL36Avccblul5nqa/jv472NcgH3Yp61fK456WZ58V1R3oMA5qjgj8lrr187uAlhpu
	8dcFdURYxtQ22tr7Qu3gE9voYIIKROY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-4JXTr0G1OkGJ9NIKV9HLAw-1; Thu, 06 Mar 2025 09:10:40 -0500
X-MC-Unique: 4JXTr0G1OkGJ9NIKV9HLAw-1
X-Mimecast-MFC-AGG-ID: 4JXTr0G1OkGJ9NIKV9HLAw_1741270240
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3b53373faso124945785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270235; x=1741875035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OREnm9aUBj2V96zq2XupaDSMV0AJ0BW+JRJEQM5qOOs=;
        b=FH2PFfmuy1Q1aof0g+8iKQ6QvQJVyL7sAN8LnGREylBz30aNqbdaPxh6TcBtTCR+rv
         GsLF+MeCIqQ60j5Rpv8NvRHmJ1RjIRdvIzZptdWkdmqqCIXbt9Gc9rH/o+m9XkHH6CLL
         3tehnITWmIcjKZtlbBcAbyBJpFh0rSuszYG1nho4KP2p4sg3+s36hlT+fWce8jqL24AE
         yMnhtwH+WYDnfcfBQTKxNkQ/yDZWe1zqMolB4/5KtxkbpyBL70l5ECvUBNATYab45Ac1
         zQw2PutRrVPCxraldQlpECExBcX70QmEH3abZ4Dw0t3IPNNxHFCXh+JHjvA9YYKqG0LJ
         tW4g==
X-Gm-Message-State: AOJu0YzKao3iHfJq2IGgE6Plmixxh7GBPJJhQgPiGsqPq5vTsPAtbNtK
	BzPj27eRiVhEekN/LHn7KoCezvkKjD6mU6IyAlKSEiDSHGKpkW+liYkB3INR1SHYYLR33aAiw6J
	JHeHbhdOeHWOasSL31vLk3icBRRssrYhAd3G7xXMLO1SvuJGCcAXSUhupiDd6M+CvjhwpYI3tjB
	VhPMmcNmwky/hdJI1ihpElfSnF/FkZdMs/lx5ULboRaQdtIF4iTF4=
X-Gm-Gg: ASbGncuTcBZKwRp1q8BHg7JcciLGvvcOfJEivaqhZb7EY+hvdc7igMN523Vk/MTonDM
	ERTSv0s/WfB8Ak/WQNokhovupbxaKGSSBI2jwcGhilvWzVoFQEe4jNQD03j5YI34/Mi1v4FXWkN
	2qxiV0xP8r7C16CMoOmKgSVMAnS7Nbmm91SbGIbOziUEI7SH3ebx/AJV0XbFjxbRfhP4hdy2Aev
	Am0Ydl2ZcVo8ZAnGYmIcrI7+FvjmcuNZm2FhFyKSLPFGrARjdew7MKeV8okVVeVNDSw5GmvWqrZ
	SM7Ln4BJs44S2oBUg0Sw/GkcgfNxM5eJUoPh/Z8Pf+x6n3c+XbBmzCPhFqoPHzL3Kp+k49aRCiI
	6qwg6
X-Received: by 2002:a05:620a:8908:b0:7c0:c650:e243 with SMTP id af79cd13be357-7c3d8dec097mr1160591785a.30.1741270234989;
        Thu, 06 Mar 2025 06:10:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4KmIqhzBVjcz2IYjNdsy7lmCjF1K/BOG8oys1LjVuBp57JX/6tNcFHNRLX3rFOWSlP/72JA==
X-Received: by 2002:a05:620a:8908:b0:7c0:c650:e243 with SMTP id af79cd13be357-7c3d8dec097mr1160585085a.30.1741270234427;
        Thu, 06 Mar 2025 06:10:34 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:10:33 -0800 (PST)
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
Subject: [PATCH v2 0/8] Fix SCHED_DEADLINE bandwidth accounting during suspend
Date: Thu,  6 Mar 2025 14:10:08 +0000
Message-ID: <20250306141016.268313-1-juri.lelli@redhat.com>
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

This is v2 [2] of the proposed approach to fix the issue. With respect
to v1, the following implements the approach by:

- 01: filter out DEADLINE special tasks
- 02: preparatory wrappers to be able to grab sched_domains_mutex on
      UP (remove !SMP wrappers - Waiman)
- 03: generalize unique visiting of root domains so that we can
      re-use the mechanism elsewhere
- 04: the bulk of the approach, clean and rebuild after changes
- 05: clean up a now redundant call
- 06: remove partition_and_rebuild_sched_domains() (Waiman)
- 07: stop exposing partition_sched_domains_locked (Waiman)

Please test and review. The set is also available at

git@github.com:jlelli/linux.git upstream/deadline/domains-suspend

Best,
Juri

1 - https://lore.kernel.org/lkml/ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com/
2 - v1 https://lore.kernel.org/lkml/20250304084045.62554-1-juri.lelli@redhat.com

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
 include/linux/sched.h          |  2 ++
 include/linux/sched/deadline.h |  7 +++++++
 include/linux/sched/topology.h | 10 ---------
 kernel/cgroup/cpuset.c         | 27 +++++++++----------------
 kernel/sched/core.c            |  4 ++--
 kernel/sched/deadline.c        | 37 ++++++++++++++++++++--------------
 kernel/sched/debug.c           |  8 ++++----
 kernel/sched/rt.c              |  2 ++
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        | 32 +++++++++++++----------------
 11 files changed, 69 insertions(+), 67 deletions(-)


base-commit: 48a5eed9ad584315c30ed35204510536235ce402
-- 
2.48.1


