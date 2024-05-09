Return-Path: <linux-kernel+bounces-174098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C948A8C0A3B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5926B284770
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A56147C8B;
	Thu,  9 May 2024 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KM41Ypk5"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86313BC3C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715226136; cv=none; b=KhmNdtAvTvjwTc4xsh3MQreYBwvxBNLc4PlcfSmpQ2p7KS6bwj3MpFePEAi3dhiRUeESOqalYYNmKPc4hBrn5rOe+I7C0a+mpVIZ9qYnF40ql5QFoXNY81p+smiSDKzROwO6m0CBFt1qjbZwbJiWl5dxupMc1bja70uSmvyGzx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715226136; c=relaxed/simple;
	bh=s1jHLTX+qOUiCWG0IBp9G7p0M3D1urBxEf2o8nhwOdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WycByeA0nb1ZG76Os6uvF/vvI8i/UrUbXRcrFXMv9VZmx2yRISSDR3PjwXvhzRIxmiqqP/pK5VsAXB6lPXwA/SHkhWNbX28x9D+lvzf9lo31RiCNjJlYl1x15yda/+WGNOHfrzAPb6xCUKdEq0AFGl1it1eNidzLVywSU0tbgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KM41Ypk5; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715226129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aOzHyI83zs0yARPQLHmu0dTTl11iaaEJdBLCPGzT9nI=;
	b=KM41Ypk56xmIB122yjsznS4X6hO16Qd+qsnf4bwOZeuvVrKwEwDLJ3SconmZf2FldpLZSB
	BHe11kAOakOuo9xdlUbOT2ZII3yA1hMSaW5bov1mlcx3/+0QtqedtW34sd+BSuo1DWYLCK
	qgw0pfiOtL9HL99kJhZ2U+8iRUhqaw8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and put under config option
Date: Wed,  8 May 2024 20:41:29 -0700
Message-ID: <20240509034138.2207186-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Cgroups v2 have been around for a while and many users have fully adopted them,
so they never use cgroups v1 features and functionality. Yet they have to "pay"
for the cgroup v1 support anyway:
1) the kernel binary contains useless cgroup v1 code,
2) some common structures like task_struct and mem_cgroup have never used
   cgroup v1-specific members,
3) some code paths have additional checks which are not needed.

Cgroup v1's memory controller has a number of features that are not supported
by cgroup v2 and their implementation is pretty much self contained.
Most notably, these features are: soft limit reclaim, oom handling in userspace,
complicated event notification system, charge migration.

Cgroup v1-specific code in memcontrol.c is close to 4k lines in size and it's
intervened with generic and cgroup v2-specific code. It's a burden on
developers and maintainers.

This patchset aims to solve these problems by:
1) moving cgroup v1-specific memcg code to the new mm/memcontrol-v1.c file,
2) putting definitions shared by memcontrol.c and memcontrol-v1.c into the
   mm/internal.h header
3) introducing the CONFIG_MEMCG_V1 config option, turned on by default
4) making memcontrol-v1.c to compile only if CONFIG_MEMCG_V1 is set
5) putting unused struct memory_cgroup and task_struct members under
   CONFIG_MEMCG_V1 as well.

This is an RFC version, which is not 100% polished yet, so but it would be great
to discuss and agree on the overall approach.

Some open questions, opinions are appreciated:
1) I consider renaming non-static functions in memcontrol-v1.c to have
   mem_cgroup_v1_ prefix. Is this a good idea?
2) Do we want to extend it beyond the memory controller? Should
3) Is it better to use a new include/linux/memcontrol-v1.h instead of
   mm/internal.h? Or mm/memcontrol-v1.h.

diffstat:
 include/linux/memcontrol.h |  165 ++++---
 include/linux/sched.h      |    5 +-
 init/Kconfig               |    7 +
 mm/Makefile                |    2 +
 mm/internal.h              |  124 +++++
 mm/memcontrol-v1.c         | 2941 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c            | 4121 ++++++++++++++++++++++---------------------------------------------------------------------------------------------------------------------------------
 7 files changed, 3765 insertions(+), 3600 deletions(-)

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>


Roman Gushchin (9):
  mm: memcg: introduce memcontrol-v1.c
  mm: memcg: move soft limit reclaim code to memcontrol-v1.c
  mm: memcg: move charge migration code to memcontrol-v1.c
  mm: memcg: move legacy memcg event code into memcontrol-v1.c
  mm: memcg: move cgroup v1 interface files to memcontrol-v1.c
  mm: memcg: move cgroup v1 oom handling code into memcontrol-v1.c
  mm: memcg: put cgroup v1-specific code under a config option
  mm: memcg: put corresponding struct mem_cgroup members under
    CONFIG_MEMCG_V1
  mm: memcg: put cgroup v1-related members of task_struct under config
    option

 include/linux/memcontrol.h |  165 +-
 include/linux/sched.h      |    5 +-
 init/Kconfig               |    7 +
 mm/Makefile                |    2 +
 mm/internal.h              |  124 ++
 mm/memcontrol-v1.c         | 2941 +++++++++++++++++++++++++
 mm/memcontrol.c            | 4121 ++++++------------------------------
 7 files changed, 3765 insertions(+), 3600 deletions(-)
 create mode 100644 mm/memcontrol-v1.c

-- 
2.43.2


