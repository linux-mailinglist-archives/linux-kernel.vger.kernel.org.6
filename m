Return-Path: <linux-kernel+bounces-553827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C5AA58F51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C573AB8D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0998D224AEB;
	Mon, 10 Mar 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOyXETUk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCC224896
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598464; cv=none; b=bqmz0NkVH9qMi9flP+mWiJ50EJpGXciiUWFgWnCdkoLkr+FwM9r0Sou5nk2R7dfe504Prc/6DZaVXojG46P3UyVLg8mYX5mEozV9ISVtdhtx3zmbo0+An8KpOvZn5MKOWeva9QJ0s4/rIWgVFhMscnkY/dMns0lWbFLlV6oRpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598464; c=relaxed/simple;
	bh=X2P8BmFaIfr6ljYnPxqVzE0dAYgml35bG8jKsbvO9OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBN0oAji38TPqdQVsT97vPtAnMESnqY40DIwyD2Yb5iDgQjTqvjlNzWybHsFErwY8h6sj5Yq5bGFqecsEoranCb0zs/AYiveqQ0/mzn1chnvHIAUj5bx9EQ/ykwFz1x89GiS55UjWyrBDkHLQbSYgCeqHYj5cgpee6GaXbKPKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOyXETUk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741598461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LgP9YNR9e/J52BmiorQfd082BVFSTbBL5ZmjdHK0AhI=;
	b=SOyXETUkOa8UFSZKYOJN8aZ0C3JMH6cHQ602iiWHrxWPHWoanfVYuBXI++PTasHHruGnzQ
	jjzvp2cGXsFhJ1Gvrdi0F0Vp59VUA1cfmZo8w5/dVF7Wd/bV9FNQ8wCtJekqqPb10Cx1aO
	zriNTDSNPpZKI/QUBSp/+sRVuJco8cc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-HdEWECgyOw2uud-B7VHrHg-1; Mon, 10 Mar 2025 05:20:59 -0400
X-MC-Unique: HdEWECgyOw2uud-B7VHrHg-1
X-Mimecast-MFC-AGG-ID: HdEWECgyOw2uud-B7VHrHg_1741598459
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913037ac4eso2101883f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598455; x=1742203255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgP9YNR9e/J52BmiorQfd082BVFSTbBL5ZmjdHK0AhI=;
        b=YPAnv7rnT93bI5qBmaTfJ8RsdVkgwHwuX2odtRaaNc3tyEyrOSIVujq8dBZ0dYrKjj
         t3ed+FlFLTYg6VtncxXquYYRjLBZk80N36ikU/pI37a9ouYB58QotzYSRfWj2EUrzXv8
         MgDf/GrllcIv1/QC7GpGCsjqwy4kNFCFl4X6zyMd6iUiV/dTTghElg+T1TbYt9PEaz7h
         NjMC6NyHrcEHb88+E9MIZeyRjStgoTTx510LWzlsqMkRkbtSsJ6Hr+0jkDclDLcxSxv7
         Tno1qLGK+YhV85HUUZ3PzsP6yCSB/zJaFFjKhwKmibnRImu54xwH6h/ZeJ2rEomKEIeU
         F20g==
X-Gm-Message-State: AOJu0YzppUViZcNRTmoJnA4l6mr1/F4o6IgcB24QbjAW+GzpWqljGQqz
	sUWue1ze5KZxbjXQLPjTVR4eVmCDNLAzDK6cDOOBEsFq/rVnm02Bs2dn934tgCHn9JMrIKnMV0j
	GNQrXbERuZA1zEjDspJc2XNvuszmrlFDzmKUVgfnPWZ3r5eOt612p5gPEPwVhZ7MKYhCcUMeGZ0
	1kb54Vqd/8yPHuyry0xA+hLtw4EzJ6iOQIIQC2SOPanfJ3yrLgktM=
X-Gm-Gg: ASbGnctJjjHlvfSz0P6pUCadFILZDNVwe/uNWdT9IQ3osA8zO7oz58fcGNVJ806uYlM
	zc9gL0SoUu+cWb8A6THRKQsLar+VSL9GgPepBst7u9omrQ7M5KbCNRz4DCdQH+s9zbdzutscoyX
	u2WGnJ2rGWOlMAsdo0J9tcIX/duqeDMCFiZLcuM90FMWHF7U/lpbm+cj3ag8lKObsiAMbTK420P
	MlwSFo0jvp6XCTC4UJY2S32nHxZ7/DQTM3hciY9KVfyASpF/W6BiyDgZJRZsvvHvYwnNI1VnFCR
	qBVs5A1Kad8SGSwVcOqw7mAg6hTXbExaIrP5zdheOvU=
X-Received: by 2002:a5d:59ae:0:b0:391:3cb0:3d8d with SMTP id ffacd0b85a97d-3913cb045f0mr3096434f8f.19.1741598455007;
        Mon, 10 Mar 2025 02:20:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG77GRbumECCswGopxMwYWJkr98+oUnHKkACcHSO3X9YysXmuX/ZXJS9Id41zSkwFxD762oBw==
X-Received: by 2002:a5d:59ae:0:b0:391:3cb0:3d8d with SMTP id ffacd0b85a97d-3913cb045f0mr3096405f8f.19.1741598454605;
        Mon, 10 Mar 2025 02:20:54 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce715731csm78442415e9.2.2025.03.10.02.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:20:53 -0700 (PDT)
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
Date: Mon, 10 Mar 2025 10:20:42 +0100
Message-ID: <20250310092050.23052-1-juri.lelli@redhat.com>
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


