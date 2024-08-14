Return-Path: <linux-kernel+bounces-287132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 619BB95235F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E117AB22872
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7461C3F1A;
	Wed, 14 Aug 2024 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AJfNgRYr"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB8F1C37A4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667324; cv=none; b=uaJYjj1OZXbB79hcl2VuHeCFYK2gWvtH6UJdgBP0kw5KGwxWl2psRy53dWqpu6nKIDAE6ijMCut32bzN4dL/9Hm1WbKfkUr5qaoRjubNGlh5429ncW6QzxR6fpXHboJyg/yJ9635a+gdn7wZZqffM71CCUd9vQBE1y0WIta9ijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667324; c=relaxed/simple;
	bh=XzE1ETz+K8hWzd8XuZBOx9nJvyzMkZFbTiv9VgDNEYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/pqZimtRG9UK8BYAaCjuNlvTjYxRwyADa71osrmA9Haw/OvalRj/ELSUKOOgqCBZwZBg7etktJnP6yE1sbIrCJRd0VB82ciLmf0Ntxe3bBlOQTTndDc7jF+NwqJR/OXUNo13GCpXJx5DsTIVtPuyJ+pHQAsObQfJyU/twmxWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AJfNgRYr; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723667318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8gT4k+nD+2NAHDmmysXrg4dME6CJs31TJGIKLth2C9I=;
	b=AJfNgRYryjyvLTKl8nFxk2llPbLLEUCbVoJ0Bg7PZVSavwWkDL0LoYgAucyExysKC9SObv
	rztZzgdpsRVbWzlbdQhf3c4VChzNm8G1DVKJ46tDNN/ijscZTmOiEvTfd8ak3X5ig6olV0
	cQZuYGhMKOAxwvUuJV6WKJdBWehWelo=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 0/4] memcg: initiate deprecation of v1 features
Date: Wed, 14 Aug 2024 13:28:21 -0700
Message-ID: <20240814202825.2694077-1-shakeel.butt@linux.dev>
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

 .../admin-guide/cgroup-v1/memory.rst          | 32 +++++++++++++++----
 mm/memcontrol-v1.c                            | 16 ++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.43.5


