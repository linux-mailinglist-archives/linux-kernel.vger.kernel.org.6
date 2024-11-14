Return-Path: <linux-kernel+bounces-409447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 812649C8CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B24284E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35C3C466;
	Thu, 14 Nov 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm0WSSkA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6428E0F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594504; cv=none; b=vBUbODLK89fP6MDdlHlN3qB/Oqfug6SxpLneGBIMIzGbeceX16bUp1bHViba6hMNzIFFUAx/V94qv5L0iqtbR2rOO5CH612SjcEvRWFBm03PVNdJLqsdQ6gmlSLw5MyfZqkjl1Z42lG16ziIWP4rbDo/M9VH8KMF8w9qBRck1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594504; c=relaxed/simple;
	bh=/eKazXLVtSPaYf0sX7MMPvYjCAMY67KExHC+j/+iso4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1oY5Gx6Zur+kVJ6RVvns3RHOmvs1Jw9C34pwimh7+RSDsKnb4EtMeBljin0imcsheJ5qRZbc9xYWZ3NyvC4bD1mdPkclil6Hcc95Nji2Y4/+mfoSALbQ/wXiFIgGh3+u3wAvSIUOqrdujP0i9TpBuSXG9JpdVJ0b4ZNiyeSAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gm0WSSkA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731594501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0G/uRB+rJtznj3wYDeTJiqXomumDBwMcsOhatNik3L8=;
	b=gm0WSSkAU/S76EpKqgP94h7FqflyyWOg3uFdm8jrGaeaYO9YVndQLLAdQjOEBIqcSN8oy6
	PVjAPt+enih0RUm4Kl0QiYmcP5DD7mOhuxtMdIgTq96sstK0T2tPQUK+u9QU2mydNrGZCN
	eTYNINleHBD/ECImptmNtZcKgEcTF8M=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-NVV0sknRNu-h_QiZjAMpGA-1; Thu, 14 Nov 2024 09:28:20 -0500
X-MC-Unique: NVV0sknRNu-h_QiZjAMpGA-1
X-Mimecast-MFC-AGG-ID: NVV0sknRNu-h_QiZjAMpGA
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7181a10a0bbso646171a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731594500; x=1732199300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0G/uRB+rJtznj3wYDeTJiqXomumDBwMcsOhatNik3L8=;
        b=lcegKnDzR4KZ4rtkFyXNvp3JQrKFwtQHZUE28g6oqK5kREiQ6ROqLaUHOTCqxvEEJY
         Q+xspa0OSDWAsoM0es6+uzctAoDUg+ehCJLmLT0umPIRRmNOe1oJ4347D7FevqybEKAT
         zlMc+N28jG9hsVE7V+P+hBJVq53yWwsrDrxwXodCATY3zyqAm9ymv1u/mtKhMORyt4M+
         v5P5A9K1lZncTn+C5VrJeTeccgRmiKIzeA7m8/xcaiqFU71s1Sydkjlqp8Yrfj5//XnJ
         5aIfYw3Bm3sR8JnVadMrsvSS8tOyjW4sOVOPXfXqViq6NTv0vpHLVuNBhD2tanU0jm/M
         8/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy8zQOVt8F92sqYZm7REb5FjvRV6DhQgknIF4NYdKcqC4Z7zu1vx6mJXl9f/4ESL5sEzTBWRrlyR5Dmjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVIowBfL4Ys/TXQOQSDGlLpiMzpgOJ8i18Qpn8opK0E/iCRy+P
	BuidMaSZQB/7KHE1Nie/J0lvvJPH59XrvBHB0U6vw5PxY+4A0AZjYw4Pwf60Q0TJC6H02iVVlhV
	65j7LPC1oGvNdtw/Upe456yxJmv7M2Y1Q65eW8CIwrNfQ/TMB2X9019BFnkxQBQ==
X-Received: by 2002:a05:6358:5b0d:b0:1b3:9b15:ac01 with SMTP id e5c5f4694b2df-1c68b87c614mr106214855d.3.1731594499857;
        Thu, 14 Nov 2024 06:28:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9ZX0TMClNeQhbPmMX4mOLuebK1pNziVzob3I+vcgmkcMVhgcZnjQBO7jgnmz+I+HlK931Lg==
X-Received: by 2002:a05:6358:5b0d:b0:1b3:9b15:ac01 with SMTP id e5c5f4694b2df-1c68b87c614mr106209755d.3.1731594499481;
        Thu, 14 Nov 2024 06:28:19 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab25bc8sm6068211cf.69.2024.11.14.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 06:28:17 -0800 (PST)
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
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>
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
Subject: [PATCH v2 0/2] Fix DEADLINE bandwidth accounting in root domain changes and hotplug
Date: Thu, 14 Nov 2024 14:28:08 +0000
Message-ID: <20241114142810.794657-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

v2 of a patch series [3] that addresses two issues affecting DEADLINE
bandwidth accounting during non-destructive changes to root domains and
hotplug operations. The series is based on top of Waiman's
"cgroup/cpuset: Remove redundant rebuild_sched_domains_locked() calls"
series [1] which is now merged into cgroups/for-6.13 (this series is
based on top of that, commit c4c9cebe2fb9). The discussion that
eventually led to these two series can be found at [2].

Waiman reported that v1 still failed to make his test_cpuset_prs.sh
happy, so I had to change both patches a little. It now seems to pass on
my runs.

Patch 01/02 deals with non-destructive root domain changes. With respect
to v1 we now always restore dl_server contributions, considering root
domain span and active cpus mask (otherwise accounting on the default
root domain would end up to be incorrect).

Patch 02/02 deals with hotplug. With respect to v1 I added special
casing when total_bw = 0 (so no DEADLINE tasks to consider) and when a
root domain is left with no cpus due to hotplug.

In all honesty, I still see intermittent issues that seems to however be
related to the dance we do in sched_cpu_deactivate(), where we first
turn everything related to a cpu/rq off and revert that if
cpuset_cpu_inactive() reveals failing DEADLINE checks. But, since these
seem to be orthogonal to the original discussion we started from, I
wanted to send this out as an hopefully meaningful update/improvement
since yesterday. Will continue looking into this.

Please go forth and test/review.

Series also available at

git@github.com:jlelli/linux.git upstream/dl-server-apply

Best,
Juri

[1] https://lore.kernel.org/lkml/20241110025023.664487-1-longman@redhat.com/
[2] https://lore.kernel.org/lkml/20241029225116.3998487-1-joel@joelfernandes.org/
[3] v1 - https://lore.kernel.org/lkml/20241113125724.450249-1-juri.lelli@redhat.com/

Juri Lelli (2):
  sched/deadline: Restore dl_server bandwidth on non-destructive root
    domain changes
  sched/deadline: Correctly account for allocated bandwidth during
    hotplug

 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c | 65 +++++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h    |  2 +-
 kernel/sched/topology.c |  8 +++--
 4 files changed, 60 insertions(+), 17 deletions(-)

-- 
2.47.0


