Return-Path: <linux-kernel+bounces-236876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCD991E80E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF09283896
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9816F26F;
	Mon,  1 Jul 2024 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CzfXIpYZ"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8810F9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860385; cv=none; b=SMnn+EA19dpDvDQw7paO5qX//6NoFOhsyc+pykbWEpgC9mAHezU8v248BiSy9LSmsoDyJZzKiqqLfpnJa4SU0UWyreKSlGGA5XO+ae/m2gDlSU9R3Va6h01qlS+Hfl9ZCeZ4VfQlljWeCVGU4g1GkNYr6xRTe95Xo4pMIaNXd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860385; c=relaxed/simple;
	bh=j2k61gAftMaGGWRrFIKCZxxflhlus2NrNZOvLCunGVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLYXBPE41TMdgvsOrEgqrG4m8wHduYDAWBDXhkfZPKVcetIZJ8twALKdGB35YDmEPGdrqu4NM+DGak1pctz/+PYt7TivgQjjz8dPTWLTgyvEewEMwDOwck327SqGEdTLEuTV5q0kaIBCec5hJTV+lvO6tcwCfUGKL/0s2TNYTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CzfXIpYZ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719860380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Npw8pvNw25Ks7XJp2oW+XVmk4yIUrowgtJPiLL8fvyw=;
	b=CzfXIpYZM5WBwSRno7JUDjNGOilWl6/wo+Q2Eqc6Bxp+svqQvsID/wz96aaQd34brepaBn
	OSm70+SCGmuZGWFn+igjN94c554AyDcOb8NCLatSMowjUdjhzH4/XhOWmqmPSX9YbIEca1
	SC17iavLKg4a8X3ojigQKDxEuKHXW0I=
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH 1/2] mm: memcg: drop obsolete cache line padding in struct mem_cgroup
Date: Mon,  1 Jul 2024 18:59:31 +0000
Message-ID: <20240701185932.704807-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

After the grouping of the cgroup v1-related fields and the
corresponding reorganization of the struct mem_cgroup, the existing
cache line padding doesn't make much sense anymore. Let's drop
it for now and put back to new places, if necessary.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d0c9365ff039..8b5b3ddeba05 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -220,8 +220,6 @@ struct mem_cgroup {
 	/* handle for "memory.swap.events" */
 	struct cgroup_file swap_events_file;
 
-	CACHELINE_PADDING(_pad1_);
-
 	/* memory.stat */
 	struct memcg_vmstats	*vmstats;
 
@@ -305,8 +303,6 @@ struct mem_cgroup {
 	bool tcpmem_active;
 	int tcpmem_pressure;
 
-	CACHELINE_PADDING(_pad2_);
-
 	/*
 	 * set > 0 if pages under this cgroup are moving to other cgroup.
 	 */
-- 
2.45.2.803.g4e1b14247a-goog


