Return-Path: <linux-kernel+bounces-225532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A9A9131D4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2862CB21217
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6529476;
	Sat, 22 Jun 2024 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDGUcx1+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047902119
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719028725; cv=none; b=hdcsMb8nzg79mLC5rqS9QBGBZ8+Rj2c77DkSbiY0UAfZ7DdMsnx3H29uftrMQFNNgrLRL/ub/5pyG6hoc+MeGmI+XqesAIgJKmhKijAXzRxr9TXm49mMRZLLcWOtV5nMZV8iyK+5C2x25c9dER4UliSgprliOhw0PYGfGJKSbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719028725; c=relaxed/simple;
	bh=oCuES5UOotTTeEWk7uHGX6oUQKdCAgtCD8Xmw9EevTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhCDVIBXuAPLtpaQBR7wHQqvOQrqSBBEy0Ad3eabaIrqyYXFCZdIkYoXegAvy/iQJqD5yA50iL3qXvycWjfVjij3bFD2R3DcAYAapxXWpgYBgRLEkqbZ3cxhES/AdO/+brFs4j18YK28mhDZSPRyna9cVlnO+i9e3Jq94MyFVn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDGUcx1+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719028722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=glHWFwF1PVhz6SvXAFFwFqrh96wIoW6X2gSfzajSRBE=;
	b=ZDGUcx1+vpOxV1o3HYYC98s9INI7X41DcidNOD0zIoJcGW2vY/Wd3XCokI95teGf78hJ60
	/F9RB4gtfP5LELxXU9fKQ1iD4nHxb7rcoPnYpZ2nSRrQ3ZhbtWorSmSMqc89Tq3/HztqxE
	M+jIzk4Xo3pzjiamKGwA8iCBphzViMw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-paFXp5xsMlGHo-Pjd_GFZQ-1; Fri, 21 Jun 2024 23:58:40 -0400
X-MC-Unique: paFXp5xsMlGHo-Pjd_GFZQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f9a3831aa9so24151445ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719028719; x=1719633519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glHWFwF1PVhz6SvXAFFwFqrh96wIoW6X2gSfzajSRBE=;
        b=ZW8wiP4H1UO4z0uOVnkYcyEP0nO2MuBAD6GVn5zoiSthUMDZnp2PNEdZByIfrBI2ym
         2jorSR/PuKkt567ScclsnfG1YL/eP2TZbLkX7XiW+pLFuxzHFd/rDNWqf5Y6ka91QgL8
         j5m32J6Ji7KTbNe70pWUArBdCvdD2sAB3mt+l5I+28VzVqPMXWbcT6D5MW+8gKlbxAkV
         y/9JLU1huxSgXR9hnikOlsMhZxxyKSnfZ4bbkczAr1xTtu3jc/DTuVZ7azCvWEPAXitX
         iucLitPetekrDzhJb40Re0aY13d128AK96mlsDg+glUlobmIXoae1fUtgVdqDKCKjxRE
         C2Bw==
X-Gm-Message-State: AOJu0YyQ2wasjyYUpg5NapWAlnEJQVIlRJNquOQSkhGtdwIzTaTGDhso
	Q2hhpPbwsYV0MHIy88J+W22qGIA40aNaFHjQUWuubNI4RjazU1q5asnVU7f5YxOKusgbh7Xmwah
	roARLNoe3qSIs765CqqkfrnoWjCnpzhhsTmFOcnjUf80hpsdYie08HO1/F0V0tw==
X-Received: by 2002:a17:902:d4c3:b0:1f7:3163:831d with SMTP id d9443c01a7336-1f9aa396e3dmr125385705ad.14.1719028719317;
        Fri, 21 Jun 2024 20:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn6jq5za2vXIACul9YEe/UzkN4xzhEvsBbIbTzW3YiVVEm98izqyGGRygyQeD38+tfCNqDdw==
X-Received: by 2002:a17:902:d4c3:b0:1f7:3163:831d with SMTP id d9443c01a7336-1f9aa396e3dmr125385545ad.14.1719028718901;
        Fri, 21 Jun 2024 20:58:38 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:c138:e21d:3579:5747:ad1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb32b9edsm21832365ad.118.2024.06.21.20.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 20:58:38 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Date: Sat, 22 Jun 2024 00:58:08 -0300
Message-ID: <20240622035815.569665-1-leobras@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The problem:
Some places in the kernel implement a parallel programming strategy
consisting on local_locks() for most of the work, and some rare remote
operations are scheduled on target cpu. This keeps cache bouncing low since
cacheline tends to be mostly local, and avoids the cost of locks in non-RT
kernels, even though the very few remote operations will be expensive due
to scheduling overhead.

On the other hand, for RT workloads this can represent a problem: getting
an important workload scheduled out to deal with remote requests is
sure to introduce unexpected deadline misses.

The idea:
Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
In this case, instead of scheduling work on a remote cpu, it should
be safe to grab that remote cpu's per-cpu spinlock and run the required
work locally. Tha major cost, which is un/locking in every local function,
already happens in PREEMPT_RT.

Also, there is no need to worry about extra cache bouncing:
The cacheline invalidation already happens due to schedule_work_on().

This will avoid schedule_work_on(), and thus avoid scheduling-out an 
RT workload. 

For patches 2, 3 & 4, I noticed just grabing the lock and executing
the function locally is much faster than just scheduling it on a
remote cpu.

Proposed solution:
A new interface called Queue PerCPU Work (QPW), which should replace
Work Queue in the above mentioned use case. 

If PREEMPT_RT=n, this interfaces just wraps the current 
local_locks + WorkQueue behavior, so no expected change in runtime.

If PREEMPT_RT=y, queue_percpu_work_on(cpu,...) will lock that cpu's
per-cpu structure and perform work on it locally. This is possible
because on functions that can be used for performing remote work on
remote per-cpu structures, the local_lock (which is already
a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
is able to get the per_cpu spinlock() for the cpu passed as parameter.

Patch 1 implements QPW interface, and patches 2, 3 & 4 replaces the
current local_lock + WorkQueue interface by the QPW interface in
swap, memcontrol & slub interface.

Please let me know what you think on that, and please suggest
improvements.

Thanks a lot!
Leo

Leonardo Bras (4):
  Introducing qpw_lock() and per-cpu queue & flush work
  swap: apply new queue_percpu_work_on() interface
  memcontrol: apply new queue_percpu_work_on() interface
  slub: apply new queue_percpu_work_on() interface

 include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c     | 20 ++++++-----
 mm/slub.c           | 26 ++++++++------
 mm/swap.c           | 26 +++++++-------
 4 files changed, 127 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/qpw.h


base-commit: 50736169ecc8387247fe6a00932852ce7b057083
-- 
2.45.2


