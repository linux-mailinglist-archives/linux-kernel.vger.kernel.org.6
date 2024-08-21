Return-Path: <linux-kernel+bounces-295653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB4959FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056741C22033
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EE21B1D4B;
	Wed, 21 Aug 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffMzvZGt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277621662F8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250244; cv=none; b=ukFAlZBuqDf59sJjndT206Z7BTg6zwnvfYlvS+eFafPjssUr35fGoVKFzxXeMlIrJeqfxkgAinRkJlvV3Th1zjkqoBViAzTW5JhigBfYPXgoiwXOGuy1As7dtUAvQAzjnzX0Ki6hZX2dj7rTvKoBb/KrWyRMHxEIp1ceQ+ypYc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250244; c=relaxed/simple;
	bh=kwjAfkQ1SQl2IccDcZCBAKSpIIcKlFhOwFsw96Fk0FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVH8A0qgZybWvgGgEmLi68U9d26rZU2e46ULmQV7vVNkHh3E7rrbr06l2hLqMzWPg2d0UYPLfyh8pYqqVk2Zx2w6xmNnI1l5viSMMqdPHfMgJ07ttiizxqMGdmwZu9tFRaIHTZnGwuA+OQ/czFwsfwF/VTX/y5gA0NFH4GK+C9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffMzvZGt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724250241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kW1kqXkjmjB16PeBN6etICCuzfHKbAWEkOeBe7oty7M=;
	b=ffMzvZGtibV1gxU+47cdoii86Sev/gMw6DDv66+aagDbKxAlKriizRzT1muHOL1UldsFzg
	jPk2R2qsBtaZ1GGgYy1kKa15lsKQ+UE977FWIbD1Oct0nkhpT4tyZcA4tbapN5u8czpHEJ
	p90+Hc8QVbEzJCyLYMN3j0ePYcMxIO8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-ZAV2ryprPqOaqHQLVVYXrA-1; Wed,
 21 Aug 2024 10:23:58 -0400
X-MC-Unique: ZAV2ryprPqOaqHQLVVYXrA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA79C18EA8AD;
	Wed, 21 Aug 2024 14:23:55 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.124])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A61D19772CD;
	Wed, 21 Aug 2024 14:23:26 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
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
	cgroups@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] isolation: Exclude dynamically isolated CPUs from housekeeping cpumasks
Date: Wed, 21 Aug 2024 10:23:10 -0400
Message-ID: <20240821142312.236970-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

 v2:
  - Add a TODO comment on overriding boot time housekeeping masks setting
    in the future when dynamic CPU isolation is good enough to deprecate
    isolcpus and nohz_full boot command line parameters.
  - Only save one copy of the boot time housekeeping mask as the CPU
    list used in isolcpus and nohz_full must be the same.
  - Include more housekeeping masks to be updated by cpuset.

 [v1] https://lore.kernel.org/lkml/20240229021414.508972-1-longman@redhat.com/

The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
boot command line options, are used at boot time to exclude selected
CPUs from running some kernel housekeeping processes to minimize
disturbance to latency sensitive userspace applications. However, some
of housekeeping CPU masks are also checked at run time to avoid using
those isolated CPUs.

The purpose of this patch series is to exclude dynamically isolated
CPUs from some housekeeping masks so that subsystems that check the
housekeeping masks at run time will not see those isolated CPUs. It does
not migrate the housekeeping processes that have been running on those
newly isolated CPUs since bootup to other CPUs. That will hopefully be
done in the near future.

This patch series updates all the housekeeping cpumasks except the
HK_TYPE_TICK and HK_TYPE_MANAGED_IRQ which needs further investigation.

Waiman Long (2):
  sched/isolation: Exclude dynamically isolated CPUs from housekeeping
    masks
  cgroup/cpuset: Exclude isolated CPUs from housekeeping CPU masks

 include/linux/sched/isolation.h |   8 +++
 kernel/cgroup/cpuset.c          |  34 ++++++++--
 kernel/sched/isolation.c        | 112 +++++++++++++++++++++++++++++++-
 3 files changed, 146 insertions(+), 8 deletions(-)

-- 
2.43.5


