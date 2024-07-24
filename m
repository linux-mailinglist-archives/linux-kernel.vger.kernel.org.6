Return-Path: <linux-kernel+bounces-261514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D793B821
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8851C21253
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ADA84E1C;
	Wed, 24 Jul 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V+mhmNy+"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C72136E18
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853638; cv=none; b=d0hjh+WXpSBSrrXvRyOx0fVt+VngQ6gbQjlvDLTeEkCpWjWHeh11W3a0ME75zijuWsNC15ZgAI+AyuwBAp96EKHqkA4dzkrfuJxGMfLgGbkvNllqr3dt+gEJOVxlTYLdJjfUgJZDyRNyw6lLbUA5g6uR/yxvPHaLBPWOnUtRvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853638; c=relaxed/simple;
	bh=yFtyoT4mO34dHtEP9TanLfp4otE7QMz6p2aNXgyK+T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS6Tw+iWECWlrLxdqD8RykmiN9mC4yTnlLmiRWiMesmaadidCbFP3I/qbZ0lEUfskzEQl93ee9vWJ1+uBvxi8gI02lz0e6LEbbJvBskZEqaBfX8mI4Qxrz3a1EL+A+dI88YXzVPS9lBPNM3/uvQMv7ke/j58aPpFFg0BNGpzbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V+mhmNy+; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 20:40:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721853634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ha7l7RvxkIY9Rxs/G2PnfM+aRb65nGpjufHF5ej1pwE=;
	b=V+mhmNy+jV8uCID2sGrkU65R/Kcov5jsj/UihWlB5gRrjSsG3y95MfsRnn1lHEBibPQnpI
	XzSuPT0Cmx78wpyGkqz2U3EordmcudDK9aGd4z3yVCsJisP7j6VOXsMLDkNYC5jlgF+zNK
	fO7gU/G1majWGM5gXalyeawanEfgqlM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 0/5] This patchset reorganizes page_counter structures
 which helps to make
Message-ID: <ZqFmu9qmRiVJfRg3@google.com>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724202103.1210065-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

Ooops, there was a formatting error in the cover letter, my apologies.

Here is a fixed version:

--

From a08acc7e656d279b461a645309745bca5218d7d2 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <roman.gushchin@linux.dev>
Date: Wed, 24 Jul 2024 20:38:13 +0000
Subject: [PATCH v2 0/5] mm: memcg: merge page_counter trees

This patchset reorganizes page_counter structures which helps to make
memory cgroup and hugetlb cgroup structures smaller (10%-35% depending
on the kernel configuration) and more cache-effective. It also eliminates
useless tracking of protected memory usage when it's not needed.

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



