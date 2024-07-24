Return-Path: <linux-kernel+bounces-261304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE0A93B579
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946271F23DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0A015F301;
	Wed, 24 Jul 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="myGZ76LE"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807A15ADB1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840391; cv=none; b=vENpyJ9Ft7Q7DWeVIxpo3q2MWKfMphZRDM2f2aaihjGtONr0F5qXbD3DKUg5rGNhQcGcJeV6z+pqJLdka2gwNO7f+Tyqw7/Bm0+DCgZJdHIll2FgFsvpo8Re110ueOEubNSFjX+vtsKkBsClXXHOddWDmJKUCNzL/w/RA/dRWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840391; c=relaxed/simple;
	bh=ok9snOYzKfsKkCXrT2iQcc6neV+34YDJgbTOLBwhnuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnHco5/i/Kii1oQS5mUMae5nglKpv1cbU7MCnhsWoOnhuwCm59y0kCDA0B8l2Xpz8edU3Jizea7LSEmPk6FL3RNEAVFgqRsoIEzwJ4wgms0/9uS7IGQuPR+/2i/6yIXPnDRy+KAPWzn9KJiw2i8y0RZpnVQzlW5e1HuHPrCZ7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=myGZ76LE; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 09:59:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721840387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=anlDKMLkZcgUI4vplw8kTnoSMhJcwAjX082W+0ru/8c=;
	b=myGZ76LEVmyQmlm1mpsq0MdwnJoq2wYQNWaal9vHy+hiQQMLShCjM5PBvJntSVfEaqzSJ0
	vH6TbX89iEN8GSL5fSDNGkvRo1OAzXROdkTe1/4TdN2QMsyxhZwRX1/+ML4uWrE5eEUg3L
	a1V8eL5J81kOCxQmfMAGTbGDslvb6Ms=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, jpoimboe@kernel.org, 
	kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com, 
	cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] vmstat: Kernel stack usage histogram
Message-ID: <xdumlsfpg3v6hoqdco4acpaudsk2edhgtrabhqdon5lc4nekix@hejsxuay75pr>
References: <20240718202611.1695164-1-pasha.tatashin@soleen.com>
 <20240723234600.d05817293ec1eb2d4ad87be7@linux-foundation.org>
 <CA+CK2bB2fiAGHpD5dsSdxCgPjx7OBra5K8Vn_a4wytPa2U6UjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bB2fiAGHpD5dsSdxCgPjx7OBra5K8Vn_a4wytPa2U6UjA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 10:43:59AM GMT, Pasha Tatashin wrote:
> On Wed, Jul 24, 2024 at 2:46 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 18 Jul 2024 20:26:11 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > > As part of the dynamic kernel stack project, we need to know the amount
> > > of data that can be saved by reducing the default kernel stack size [1].
> > >
> > > Provide a kernel stack usage histogram to aid in optimizing kernel stack
> > > sizes and minimizing memory waste in large-scale environments. The
> > > histogram divides stack usage into power-of-two buckets and reports the
> > > results in /proc/vmstat. This information is especially valuable in
> > > environments with millions of machines, where even small optimizations
> > > can have a significant impact.
> >
> > x86_64 allmodconfig:
> >
> > In file included from <command-line>:
> > In function 'init_memcg_events',
> >     inlined from 'mem_cgroup_css_alloc' at mm/memcontrol.c:3616:3:
> > ././include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_2305' declared with attribute error: BUILD_BUG_ON failed: NR_VM_EVENT_ITEMS >= S8_MAX
> >   510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >       |                                             ^
> > ././include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
> >   491 |                         prefix ## suffix();                             \
> >       |                         ^~~~~~
> > ././include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
> >   510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >       |         ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
> >    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >       |                                     ^~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
> >    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> >       |         ^~~~~~~~~~~~~~~~
> > mm/memcontrol.c:444:9: note: in expansion of macro 'BUILD_BUG_ON'
> >   444 |         BUILD_BUG_ON(NR_VM_EVENT_ITEMS >= S8_MAX);
> >       |         ^~~~~~~~~~~~
> >
> > This looks legitimate - is it time to switch to int16_t?
> 
> I am looking into this, and will also uninline stack_not_used() and
> kstack_histogram() as discussed earlier in the thread.
> 

Let me take care of this specific build error.

