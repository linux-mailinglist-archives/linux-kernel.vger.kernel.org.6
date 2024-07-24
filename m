Return-Path: <linux-kernel+bounces-261492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE093B7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506DD286717
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6769E16CD00;
	Wed, 24 Jul 2024 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZQrbE+Tp"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C214A18
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852475; cv=none; b=Pe44Bso0yV5c+Ac+VrX3G0vqSRHnLAMnKNCQ1Jp2s1Qa2sv2T0KD2Gq0SVo1lClD/n7ajNVqbb76D7kP3ouAveX/+/de6ArOZODRhASOmyYpgDnsDh2tNaItXsCbGrwtUi3DrZttAAMaQd1VCntHoTIhlU1+bWBToxxjvK4EokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852475; c=relaxed/simple;
	bh=a/eNPzKU/8aR9YRh3LQa5NbeRcfMf4llZbMtBEAXr84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8gnubTjNtmfV8CnvVgL7H+55l/1YBNXAQjYe5kYjLFR69J9ulz+eIDaW/dmTEZQIqHYR8dmgJwmlWGnlBfvYUaKgICfA+lmIy0Hf12HxgFE/an/wfA9P7DPVBPjRWdAn8rUXCfy8miPj5YfXqvSAw9gr1+fjHrSZzsdBUcy4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZQrbE+Tp; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721852471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0npymtNZgz0DBECHygFlaNJtaAtVe0cWcTtFllkCsWk=;
	b=ZQrbE+TpLbYOuwx/UHswY0LFNAm0TWuJ76Rq/Z5W2bjyRNVpnld7tXcbsCieXbqOWLZgR6
	5xCRE+DTg3e1dOccvrAQzPr8A49uhlsa/NSXCBu3rcJzI53AtAaXUD9/fADMlBiRb4nuZ5
	kCbOPr8MNJLTX9e4fFCODt0k9c4//iQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 0/5] This patchset reorganizes page_counter structures which helps to make
Date: Wed, 24 Jul 2024 20:20:58 +0000
Message-ID: <20240724202103.1210065-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v2:
  - two page_counter structures per hugetlb cgroup instead of one
  - rebased to the current mm branch
  - many minor fixes and improvements
v1:
  https://lore.kernel.org/lkml/20240503201835.2969707-1-roman.gushchin@linux.dev/T/#m77151ed83451a49132e29ef13d55e08b95ac867f


Roman Gushchin (5):
  mm: memcg: don't call propagate_protected_usage() needlessly
  mm: page_counters: put page_counter_calculate_protection() under
    CONFIG_MEMCG
  mm: memcg: merge multiple page_counters into a single structure
  mm: page_counters: initialize usage using ATOMIC_LONG_INIT() macro
  mm: memcg: convert enum res_type to mem_counter_type

 include/linux/hugetlb.h        |   4 +-
 include/linux/hugetlb_cgroup.h |   8 +-
 include/linux/memcontrol.h     |  19 +--
 include/linux/page_counter.h   | 128 ++++++++++++++++----
 mm/hugetlb.c                   |  14 +--
 mm/hugetlb_cgroup.c            | 150 +++++++++--------------
 mm/memcontrol-v1.c             | 154 ++++++++++--------------
 mm/memcontrol-v1.h             |  10 +-
 mm/memcontrol.c                | 211 ++++++++++++++++-----------------
 mm/page_counter.c              |  94 +++++++++------
 10 files changed, 403 insertions(+), 389 deletions(-)

-- 
2.46.0.rc1.232.g9752f9e123-goog


