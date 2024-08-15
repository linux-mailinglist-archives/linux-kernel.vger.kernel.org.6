Return-Path: <linux-kernel+bounces-287519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 844E69528B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106EFB246FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D467757CBC;
	Thu, 15 Aug 2024 05:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bCGcCOg5"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986254FAD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698311; cv=none; b=WvHRvgOj+OILMrCQV8axT4/AD16DnnvCpfNyUO8+EcEQH+8GePeCMlyyVBpOGacmNKLHIwRvieWLsBzD1Zl3prd2zUB1XUaQ+kyy3Km9fN/NeGQgwxAi8gw2PtyoNyS9pACd0Ftsg/YaUJdZ3goU+ovUdr2HVY9xCRedDWiW2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698311; c=relaxed/simple;
	bh=LrBuYIrNVyvc/a4PtDOHQMG9EF1u8fdHBBXdbM3uW4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kM+4EE/kQwugHL3AuV0r1yVSvnyLThi2tMZWKgNWU538FFK5GmhvHK9Oiqi9twHsvj/Rdvo2sa9Z+QQ4FAa8QW6gnKcvXp05IA8q0OvAstwYVW+X35UY+7x57eTgAApTHeixU1KPUHY6OyccI3zLySGnaXZhaLprmal1G3nCA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bCGcCOg5; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723698306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D58nFpaqSMRLKkIYvncf4Ob2vSOSs5JPjgWaC1bRt4w=;
	b=bCGcCOg5Ji7uu9jlb1gb72XrxnifG17s/R+mLnh50F5X/mkyxeZJ3cEvg399uHFhMxa49b
	9vcnT1mITRgou44jlu1o0iIMqcrcBTkRU2oe8ZI4rnQvJfwIeBdj8srgncE1hCK3JVAqmv
	rz9doJJ9sihYffdvmbPAKGhPV4KUDQw=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 0/7] memcg: further decouple v1 code from v2
Date: Wed, 14 Aug 2024 22:04:46 -0700
Message-ID: <20240815050453.1298138-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Some of the v1 code is still in v2 code base due to v1 fields in the
struct memcg_vmstats_percpu. This field decouples those fileds from v2
struct and move all the related code into v1 only code base.

Shakeel Butt (7):
  memcg: move v1 only percpu stats in separate struct
  memcg: move mem_cgroup_event_ratelimit to v1 code
  memcg: move mem_cgroup_charge_statistics to v1 code
  memcg: move v1 events and statistics code to v1 file
  memcg: make v1 only functions static
  memcg: allocate v1 event percpu only on v1 deployment
  memcg: make PGPGIN and PGPGOUT v1 only

 include/linux/memcontrol.h |   3 +
 mm/memcontrol-v1.c         | 110 +++++++++++++++++++++++++++++++++++--
 mm/memcontrol-v1.h         |  24 ++++++--
 mm/memcontrol.c            |  87 ++++-------------------------
 4 files changed, 139 insertions(+), 85 deletions(-)

-- 
2.43.5


