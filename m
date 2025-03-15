Return-Path: <linux-kernel+bounces-562688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D8A63104
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8675B7A4123
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96935205AA8;
	Sat, 15 Mar 2025 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ed6qPZeI"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F62054FD
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742060992; cv=none; b=H58vKZGi6cD4dGv6Umh3rWgHT46ydQmkxoFNMCO6ryylK9A9UMODWWLYLFcxLB04Hvu0Kbm81OW24klZlIz8MmUGoAL/jvWLVBNuIA5akamYcwRhRCUmEIlZrUUXDc/8Z5g5UJjKR9/EgTQgi9MAOh9Hr7g7LzFHLkYaoTjsEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742060992; c=relaxed/simple;
	bh=8cNdWdSYzMhrZrBVVbo1LE44oP+rPuUJujztZ+GXkGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JiKSs/215u0SpEHao3pfuSgMXoMwXOUULAiDMcLhtVt6ef0QOgcBheINVDUpH7b1qCi2634w2q6PGnrjvJdHlevsxxYCqLUVRV4q1OxrYiySg+D0JlfR5slanxBZtXTHYsGadicavaDVGtKNP9qVlG+udI0SeCwlBZ+LqPZVgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ed6qPZeI; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742060978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ejPqcS6XBEDW+h9V+Y9XW4HLbyin3ylhe+1eBvNG0us=;
	b=ed6qPZeIiPSadtsqQbti2BDAvMuGVp+62JrK8640TmWLwWGFfew+bL/75pqV9ke0yiBbXS
	Fo+ndr5s/72UPECrjGjiTRietDubx7nZAtVIxRb0edimC5YSM1+foZr/mmQBiUBOhuJnV8
	hkDYkWeeSM59NTfVL3C1eQlUo3DIIEg=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 0/9] memcg: cleanup per-cpu stock
Date: Sat, 15 Mar 2025 10:49:21 -0700
Message-ID: <20250315174930.1769599-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This is a cleanup series which is trying to simplify the memcg per-cpu
stock code, particularly it tries to remove unnecessary dependencies on
local_lock of per-cpu memcg stock. The eight patch from Vlastimil
optimizes the charge path by combining the charging and accounting.

This series is based on next-20250314 plus two following patches:

Link: https://lore.kernel.org/all/20250312222552.3284173-1-shakeel.butt@linux.dev/
Link: https://lore.kernel.org/all/20250313054812.2185900-1-shakeel.butt@linux.dev/

Shakeel Butt (8):
  memcg: remove root memcg check from refill_stock
  memcg: decouple drain_obj_stock from local stock
  memcg: introduce memcg_uncharge
  memcg: manually inline __refill_stock
  memcg: no refilling stock from obj_cgroup_release
  memcg: do obj_cgroup_put inside drain_obj_stock
  memcg: use __mod_memcg_state in drain_obj_stock
  memcg: manually inline replace_stock_objcg

Vlastimil Babka (1):
  memcg: combine slab obj stock charging and accounting

 mm/memcontrol.c | 195 +++++++++++++++++++++++-------------------------
 1 file changed, 95 insertions(+), 100 deletions(-)

-- 
2.47.1


