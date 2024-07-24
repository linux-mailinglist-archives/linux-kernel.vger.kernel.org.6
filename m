Return-Path: <linux-kernel+bounces-260673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2C493ACC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2D62832FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 06:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B734149647;
	Wed, 24 Jul 2024 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1qF4aD/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404554660
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803561; cv=none; b=XetCwM5t8YkzhuOIIVWE5qzE6bQfFoieMeoNMzNHeApkjliGW/VECl+lHw3gAiVV86rlvMbkUG7QDoUECMXcB+Oq8KmZLkKhFw7qzuWdH2lAlfUW3n8FOeMKkeeVkIMUNFOGrY/XSzHfg1SzZFupGKHFwvMwd7HvXbkptfpCKpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803561; c=relaxed/simple;
	bh=LCa3FNdLHMQhm1dzYf+3q6mxVUca3DiNoiCEw0omxhM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=auZOdLY7a/4nkUVDGB5V1bxU2Cbmd9q2KnModMqYkLqpYk6IY5Yuir4kNfiyZKrLR/DVPUzQlo+5lpBp37xveJhC1JQcB3iuAsBegWkPuPgjS8nIhO2yopNboCK13krQ7tsuQQygwlrTBQ0ksLaMagkz+wtPUvtm9L6u1eBqyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1qF4aD/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F05C32782;
	Wed, 24 Jul 2024 06:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721803561;
	bh=LCa3FNdLHMQhm1dzYf+3q6mxVUca3DiNoiCEw0omxhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1qF4aD/hieYUCwc61HpYfOJSBPUv1Yqk6NoPwArkZig80qt9HoxzSMm7q71whm3Cr
	 pflZtKoVBdNtUYUMMIMAvWVAwvTDQDUtehzRHbcnMSaUqn4J4Pe5stp4mE3lAC7U9v
	 fKRYxAjKmWzezttvCgFwJaKKTUJMNjInQnOUdSkY=
Date: Tue, 23 Jul 2024 23:46:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: jpoimboe@kernel.org, kent.overstreet@linux.dev, peterz@infradead.org,
 nphamcs@gmail.com, cerasuolodomenico@gmail.com, surenb@google.com,
 lizhijian@fujitsu.com, willy@infradead.org, shakeel.butt@linux.dev,
 vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v4] vmstat: Kernel stack usage histogram
Message-Id: <20240723234600.d05817293ec1eb2d4ad87be7@linux-foundation.org>
In-Reply-To: <20240718202611.1695164-1-pasha.tatashin@soleen.com>
References: <20240718202611.1695164-1-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 20:26:11 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> As part of the dynamic kernel stack project, we need to know the amount
> of data that can be saved by reducing the default kernel stack size [1].
> 
> Provide a kernel stack usage histogram to aid in optimizing kernel stack
> sizes and minimizing memory waste in large-scale environments. The
> histogram divides stack usage into power-of-two buckets and reports the
> results in /proc/vmstat. This information is especially valuable in
> environments with millions of machines, where even small optimizations
> can have a significant impact.

x86_64 allmodconfig:

In file included from <command-line>:
In function 'init_memcg_events',
    inlined from 'mem_cgroup_css_alloc' at mm/memcontrol.c:3616:3:
././include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_2305' declared with attribute error: BUILD_BUG_ON failed: NR_VM_EVENT_ITEMS >= S8_MAX
  510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
  491 |                         prefix ## suffix();                             \
      |                         ^~~~~~
././include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
  510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |         ^~~~~~~~~~~~~~~~
mm/memcontrol.c:444:9: note: in expansion of macro 'BUILD_BUG_ON'
  444 |         BUILD_BUG_ON(NR_VM_EVENT_ITEMS >= S8_MAX);
      |         ^~~~~~~~~~~~

This looks legitimate - is it time to switch to int16_t?

