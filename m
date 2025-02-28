Return-Path: <linux-kernel+bounces-537930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B47A49290
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D733AE575
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA831CEAD3;
	Fri, 28 Feb 2025 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E2SKyJN0"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647201C701E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729509; cv=none; b=lXmheNTRasnzkMUHPvAd7sY+g1XJ4u9m+Z7jqht8HrlxLbiw20yE62+cUarov/vDYYbhmOucKv8/IMcCsri1k2e+YJtnuS40L48KE4sgBRMdLk0DpSgOyuiZL7ddAXkGkmau7B90yUNUn7OE7yRb4jFK3fcCaIDVTWZxHkDqYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729509; c=relaxed/simple;
	bh=YbxiJgh//V6HS62UyIXWJH2MQ2ulVcmvIDjZqAr4BEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFuk+fw80mSJBoMi1DNpIkgzyjc+wcTwdyjsK3Oq4PHdf9mXMZStNslsFSTmdHfqPc5CbviJDHlkr1Cwwrtlrj3xLsbYK5EA12I3bBd4tWeKn9CYEkkjAUjySh/8kWGiYwtRtGH5xckP3bYx43sO4N/okQ3qOY4qHH9GjxVHaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E2SKyJN0; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740729505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O7F/3Ya/AEmguVMS5nHCW+NuZ60GHkFjlot2gy9xy64=;
	b=E2SKyJN0ia87HJuoz5mh6QnWLq0XPUQ96/PWMYOUQM2oqqFp0zsnTltRm47VUTh6ZKVujc
	PXWmEDyRR4QfePpIiKUAC1pjFBLDyIdmszdFbwxzhUE3gcC4dTu5KmoH/UmXBFv81hgIKi
	GikJ3LORmiv+1HSBtiR3OVAbxS4zavc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 0/3] page_counter cleanup and size reduction
Date: Thu, 27 Feb 2025 23:58:05 -0800
Message-ID: <20250228075808.207484-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit c6f53ed8f213a ("mm, memcg: cg2 memory{.swap,}.peak write
handlers") has accidently increased the size of struct page_counter.
This series rearrange the fields to reduce its size and also has some
cleanups.

Shakeel Butt (3):
  memcg: don't call propagate_protected_usage() for v1
  page_counter: track failcnt only for legacy cgroups
  page_counter: reduce struct page_counter size

 include/linux/page_counter.h |  9 ++++++---
 mm/hugetlb_cgroup.c          | 31 ++++++++++++++-----------------
 mm/memcontrol.c              | 17 +++++++++++++----
 mm/page_counter.c            |  4 +++-
 4 files changed, 36 insertions(+), 25 deletions(-)

-- 
2.43.5


