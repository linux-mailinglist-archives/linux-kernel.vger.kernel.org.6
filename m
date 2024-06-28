Return-Path: <linux-kernel+bounces-234540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C51191C7BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E41F22332
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A8C7BAEC;
	Fri, 28 Jun 2024 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cgwe8JnE"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2EA78C71
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608633; cv=none; b=DOs0hPmc0JopFvhLu+EwH66VQMk6+syc1EFYgjutvh4lvIeerFA01LdB72H6HBuzE9WHrf8WEuq9tsPgCUkxf5vMmCGk39V4vqBWcL8zgBzaZjz6mbc7sLS7AKyLOHlWLXOlkq0bUyVe6gLuh1LJNFlg630lZw930vsOiYMmDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608633; c=relaxed/simple;
	bh=a0v/Aw7khz0nzNZ6SxQ9nxurOL28C0qwtBPU6ZP9CPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iz01DX3XClh0vm8+dqYYXnDLjFljZWUaTbzLD7JUPWZeGvuu/qtG31yN6fk0srURcrr2rENyfDIlrenxjYf5fvWwPz+2i9MP5iu7ybZYzVF5sEux296JjlykbNGMVFEOw3DvLl+LaF7R3DGC/dCSbM4WS8WljglbH+VALP7M/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cgwe8JnE; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UgbnkHx82nflf7HlsUPTfmPWNgaY3AQgPh+QDBth92w=;
	b=cgwe8JnEU4blDvdwwiVvVRbGuFQkvFfgcEO1UxQSS9ooOq3Ori39dsZ1s5pn8Ilfs30eK9
	vL3UUD1o0tttKe1k/v2eMlJERnS1DGPzhvtsOHUXPtFu9QXLfdLRbdPMjQNaWpUhsgBXym
	u2LWNo2rvzoJpA6KVXLB5tYp3OUYSi4=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 0/9] mm: memcg: put cgroup v1-specific memcg data under CONFIG_MEMCG_V1
Date: Fri, 28 Jun 2024 21:03:08 +0000
Message-ID: <20240628210317.272856-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patchset puts all cgroup v1's members of struct mem_cgroup,
struct mem_cgroup_per_node and struct task_struct under
the CONFIG_MEMCG_V1 config option. If cgroup v1 support is not
required (and it's true for many cgroup users these days), it
allows to save a bit of memory and compile out some code, some
of which is on relatively hot paths. It also structures the code
a bit better by grouping cgroup v1-specific stuff in one place.


Roman Gushchin (9):
  mm: memcg: move memcg_account_kmem() to memcontrol-v1.c
  mm: memcg: factor out legacy socket memory accounting code
  mm: memcg: guard cgroup v1-specific code in
    mem_cgroup_print_oom_meminfo()
  mm: memcg: gather memcg1-specific fields initialization in
    memcg1_memcg_init()
  mm: memcg: guard memcg1-specific fields accesses in mm/memcontrol.c
  mm: memcg: put memcg1-specific struct mem_cgroup's members under
    CONFIG_MEMCG_V1
  mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node
  mm: memcg: put struct task_struct::memcg_in_oom under CONFIG_MEMCG_V1
  mm: memcg: put struct task_struct::in_user_fault under CONFIG_MEMCG_V1

 include/linux/memcontrol.h | 147 +++++++++++++++++++------------------
 include/linux/sched.h      |   6 +-
 mm/memcontrol-v1.c         |  38 ++++++++++
 mm/memcontrol-v1.h         |  20 +++++
 mm/memcontrol.c            |  70 +++++++-----------
 5 files changed, 164 insertions(+), 117 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


