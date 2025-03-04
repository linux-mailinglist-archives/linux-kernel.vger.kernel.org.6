Return-Path: <linux-kernel+bounces-543522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C1A4D6C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552F63AB1C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B31FC0ED;
	Tue,  4 Mar 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dib75eaW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD641FA854
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077681; cv=none; b=XtMFX0noWbQCUXxpMyBiqoPsEQQFSE+8iqv5IVsEDYISzc2b1t/HtPkoj1BHd3F2s8BDgTcIzkJ3q94e2NJZz+7tX3Fczr5XQUbGMgTpT2UdnDYN0aros6714s8JSPs6PDAAodBqEXGA1hz61Gef/PNQE1Qdean5L4Jk9eS0JGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077681; c=relaxed/simple;
	bh=TLYb6ifcofavLxHlAL0UmIuoJWOOBMKLI8mICFqhYCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJhugUmeQQBYSF2fcrNqW/lH28d3/32l7j4WX79/z/pIWLZLkuFK+OlaPoYjYB7WyY8ulJNjop1HRwHuOyq2WnGc7yiUSnGSJAu7UED9FKwbugx7IKmZRFOHQzNqKLiI2O0F80rjawpGiglEZXcCHL8TTWdiqRWfvaVORK57JNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dib75eaW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741077677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z3fYeTIzRI1z2TyRGuHxMSN4hiWg6QuoQU8pwKzI3WI=;
	b=dib75eaWqEi1WzdZ0F9Ck/IT3jCf0nwoX+JidvRCOry+a2J01tIlbu3Voc9GIdDKvilUz9
	DYNKt66mw0J9yYW+iMMW6VdIehgvO0D02ClrK7/417A3MgyktOqP5IBaqcWii3aeRx6fBG
	tDS/60ioBUawTYwDYSNgRZYt0hMlsfU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-pellPiVnNoKxkocAUGLiyw-1; Tue, 04 Mar 2025 03:41:11 -0500
X-MC-Unique: pellPiVnNoKxkocAUGLiyw-1
X-Mimecast-MFC-AGG-ID: pellPiVnNoKxkocAUGLiyw_1741077671
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0a71aaf9fso799395885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077666; x=1741682466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3fYeTIzRI1z2TyRGuHxMSN4hiWg6QuoQU8pwKzI3WI=;
        b=MSSoXyWlGna/r4la71g/8tXRelc2+XfgPVB7Sfbj5Xgg86qtLFB/HGc1Mm1plcN2Ud
         jR4mSbL4NAmK+mYYVDv68/o1IqNJcNY9UKSblDUxOWUppHBV896VNsu2HjFY71yIBT2L
         3iiVWrbmHAfaGEO6fePtqwWw5Lc+pS9IhyekVvWURIEYTRWBj/ZpFrtstszBP/DNiKFu
         Sy0H7ODQNCSJwL0Z1eZGsAHgukcOo2xt+0c3E6i1AScwK8OS0rsA2BqleSdigMirRv+M
         PVNglFxMkFrkOBVpQ9vpF/maRqEjzD4yEdCoAWygob7vJdLLpoiNFpsNDX2O+iRe7hYN
         bQIw==
X-Gm-Message-State: AOJu0Yyf2fHjAGOpCClxyeN/B+EeK0UDOLXQHwOtl5HrqEXTY1Vh4gim
	LrWu098xXan78F1QniiPHWP2Ia4dR26dFGRUsIIlIL96Pxk8aNQLW3fIf9IMjGEgzcSGs1BRkkM
	ymM0XvmYL5WIP/W4PNaPR/MZ9o6rYueuHLyR5QYEimqm30wvEQWjwsrgSK4tv/ZOt3e1fTvpqPN
	hYtLgL6dQO/3DJSX/K954yL+sBCiFW+sE+caZUlby7hxHc4tSKjWxMJQ==
X-Gm-Gg: ASbGncsBcb7mac1y69BhniVy26iqPXvOKKjeWOBXBKeKjLA0BnzdB+Gosk01acxIvJL
	30dMfGZ69dTmkqrRVO6Iyy2T8BrXdJdA9U8uxWsvWjlNPbTRgU4q85VRsESm0Uc4Iw6a/ppUk/4
	yf+HPVMl4EGx61zCst9IIV+qPlGYKZuBfdeZzN/3i150kt34uEKuHoqOCirSOynuJa3vZZTFqKQ
	5h5HitB9NvyAUhW6X3e3KP0PgYbBuwDOKi8CLKRD+gFJigqpF94UmQXOez/kQfP8YVPcSF+Esvv
	K0JOrsRF9kLCe+0yvPwEvItAFyb5x9eOoe0ike9hjpd06I/nocL4UqWVB7sVQjte6wK1HU3yOtu
	CSCWK
X-Received: by 2002:a05:620a:f04:b0:7c0:a28e:4970 with SMTP id af79cd13be357-7c39c4c6cfbmr2293012885a.29.1741077666105;
        Tue, 04 Mar 2025 00:41:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh1Ar/3n2takoeAU9NBJEIshtRgWQMbkT9RWqfadPHDzU4n7cEE/uqENKwYoR4DzRsJlBuRA==
X-Received: by 2002:a05:620a:f04:b0:7c0:a28e:4970 with SMTP id af79cd13be357-7c39c4c6cfbmr2293008685a.29.1741077665729;
        Tue, 04 Mar 2025 00:41:05 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm218395285a.1.2025.03.04.00.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:41:04 -0800 (PST)
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
Subject: [PATCH 0/5] Fix SCHED_DEADLINE bandwidth accounting during suspend
Date: Tue,  4 Mar 2025 08:40:40 +0000
Message-ID: <20250304084045.62554-1-juri.lelli@redhat.com>
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

The way we currently make sure that accounting properly follows root
domain changes is quite convoluted and was indeed missing some corner
cases. So, instead of adding yet more fragile operations, I thought we
could simplify things by always clearing and rebuilding bandwidth
information on all domains after an update is complete. Also, we should
be ignoring DEADLINE special tasks when doing so (e.g. sugov), since we
ignore them already for runtime enforcement and admission control
anyway.

The following implements the approach by:

- 01/05: filter out DEADLINE special tasks
- 02/05: preparatory wrappers to be able to grab sched_domains_mutex on
         UP
- 03/05: generalize unique visiting of root domains so that we can
         re-use the mechanism elsewhere
- 04/05: the bulk of the approach, clean and rebuild after changes
- 05/05: clean up a now redundant call

Please test and review. The set is also available at

git@github.com:jlelli/linux.git upstream/deadline/domains-suspend

Waiman, could you please double check this doesn't break the cpuset
kselftest? It returns PASS on my end, but you never know.

Best,
Juri

1 - https://lore.kernel.org/lkml/ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com/

Juri Lelli (5):
  sched/deadline: Ignore special tasks when rebuilding domains
  sched/topology: Wrappers for sched_domains_mutex
  sched/deadline: Generalize unique visiting of root domains
  sched/deadline: Rebuild root domain accounting after every update
  sched/topology: Remove redundant dl_clear_root_domain call

 include/linux/sched.h          |  2 ++
 include/linux/sched/deadline.h |  7 +++++++
 include/linux/sched/topology.h |  2 ++
 kernel/cgroup/cpuset.c         | 20 ++++++++++---------
 kernel/sched/core.c            |  4 ++--
 kernel/sched/deadline.c        | 36 ++++++++++++++++++++--------------
 kernel/sched/debug.c           |  8 ++++----
 kernel/sched/rt.c              |  2 ++
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        | 33 +++++++++++++++----------------
 10 files changed, 68 insertions(+), 48 deletions(-)


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.48.1


