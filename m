Return-Path: <linux-kernel+bounces-287231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B0952521
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA1C1F22EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4201A1494BC;
	Wed, 14 Aug 2024 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZEahO8ce"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60662139CFF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672831; cv=none; b=gkmsQBCv9Zh1uahBM+VXqW0Vvplg/oA6rdILVzioJDPz52JFz5Zel5oeKT4mpcr21rrmwXi+2mDu0I0eKz+V5m9pb+8RxUZFsHMJ4LsXzrV6LNV9vLu4PiyjG+JHYSMSx/1n/3xgpjuk+X3hDYQHJmzomHABMiYLCJtpXHiN1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672831; c=relaxed/simple;
	bh=Hy2l3Kd5vIwYKC14jEEHBL6OIlOn3yABUUqjBVOB1g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCBZNCa01cg627LR8cAk6PBb2GE/jfYmc/1xx+hXr8FoPEpuXcp+rI7eB553ngreohUy6K5MRm/gMBemLjaKEKHjRmH7p5YBtBE8c1O+lTG46prz3eD0sl0ClI2mZ7D67z1S8RmqWd3cNjDBIwo8xUfZ1r1o1lAMLXbTIIK+N48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZEahO8ce; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723672825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RykrRFaWygVplCfW2DFKnLZ0ZDIXWFKLYuy58Z4lhbY=;
	b=ZEahO8ce1aa/WeNbU8zA/ORH4wa9+aHg+yIhsqdMFKaR8b5q40Dj9XV+JCY6rNpQyQnswY
	gRfttltGnLqTpVVcKjowhfCMDeqZB5Ruz4/8DHEOYKGel1XTe+UfQORbGBoQUUoTeDpsL+
	nq690nUKpVtlz1ItMcJxvOwpHSPZaDA=
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
Subject: [PATCH v2 0/4] memcg: initiate deprecation of v1 features
Date: Wed, 14 Aug 2024 15:00:17 -0700
Message-ID: <20240814220021.3208384-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Let start the deprecation process of the memcg v1 features which we
discussed during LSFMMBPF 2024 [1]. For now add the warnings to collect
the information on how the current users are using these features. Next
we will work on providing better alternatives in v2 (if needed) and
fully deprecate these features.

Link: https://lwn.net/Articles/974575 [1]

Shakeel Butt (4):
  memcg: initiate deprecation of v1 tcp accounting
  memcg: initiate deprecation of v1 soft limit
  memcg: initiate deprecation of oom_control
  memcg: initiate deprecation of pressure_level

Changes since v1:
- Fix build (T.J. Mercier)
- Fix documentation

 .../admin-guide/cgroup-v1/memory.rst          | 32 +++++++++++++++----
 mm/memcontrol-v1.c                            | 16 ++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.43.5


