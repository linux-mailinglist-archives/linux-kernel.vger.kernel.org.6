Return-Path: <linux-kernel+bounces-260487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2D693AA1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC96B228FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713DB2595;
	Wed, 24 Jul 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ofG0/hpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879B23A9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721779802; cv=none; b=Do/8+WiVB8izJ9FfbVJXBSlVyRU5i1ZeU65e+/WX672DlLEdQLpf3SgEXVVa5D2gk/qtGokgkgsYWh+EBznkGXBGgKPr0tN4X+A4FdZoA6UbUZiKMwL/R9grMQ3y6bcdFmcjKA2ESZjrFeLtzwz3zKGx1VCsQeej5IL8hxm2vOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721779802; c=relaxed/simple;
	bh=9CN/RY4vfRdpsQn9GxNUWkqYSbCQ29VfUME3WRQQBF0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YGfrDjTvyllO/mGjr0h1KYNB+jwl/qZjun/PxagkUoFPiqfA+5luuAICGmE/1Tw8A7bU0291ZPlurXcanNdmQn2SmNPf4skY8HwCuQCHS7MNdjbf6qT3KCe5Gj9SVqPJyzCuEhOYwID4kCHs8ljEs1VORev092VjyVYFeUyXn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ofG0/hpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE322C4AF0A;
	Wed, 24 Jul 2024 00:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721779802;
	bh=9CN/RY4vfRdpsQn9GxNUWkqYSbCQ29VfUME3WRQQBF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ofG0/hpM+KYsG271zku1f35HqiIkqLg/+sWaFtvXG/hvDZf8fmfu/6xkZutI5NjEG
	 ncinuBc6bsLQoblI+p8ntHWR12ZdZZxkSCKcfhSSHkMf6a3FiIXxtopKpQ6DZkFDjq
	 iWWSl4zDt12PtPYDIV0i1TIJHA7ECh8ZyuE4T50Y=
Date: Tue, 23 Jul 2024 17:10:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, jpoimboe@kernel.org,
 kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com,
 cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com,
 willy@infradead.org, vbabka@suse.cz, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] vmstat: Kernel stack usage histogram
Message-Id: <20240723171001.b06f0a8053efaa7ec40e400e@linux-foundation.org>
In-Reply-To: <CA+CK2bB4RELLHExbkL444ArTtUnqiYVYKJ1rLQGarLyenY6WxQ@mail.gmail.com>
References: <20240718202611.1695164-1-pasha.tatashin@soleen.com>
	<2fbbxcsjs7vtzpb6a5wudbppcr2wgc2xwdw3cgs6ejzx6rioze@z2sct6rbulng>
	<CA+CK2bB4RELLHExbkL444ArTtUnqiYVYKJ1rLQGarLyenY6WxQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 22:55:17 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> >
> > > +{
> > > +     if (used_stack <= 1024)
> > > +             this_cpu_inc(vm_event_states.event[KSTACK_1K]);
> >
> > Why not count_vm_event(KSTACK_1K)? Avoiding header include recursion?
> 
> I could not include "linux/vmstat.h" into "linux/sched/task_stack.h"
> because it introduces some dependencies such linux/mm.h and
> linux/fs.h, uapi/linux/stat.h, and when all of those are added it
> still fails to compile on some architectures, so it was just simpler
> to stop resolving the conflicts and use this_cpu_inc() directly.

Presumably uninlining stack_not_used() will permit this
to be cleaned up.

