Return-Path: <linux-kernel+bounces-257697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9236D937DB9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF9A1F21B36
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3331487EF;
	Fri, 19 Jul 2024 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xs3sqVP7"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF8148832
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721426700; cv=none; b=QDZiCcJfUVm8wfOyBA3/vntkUHIIc/i2JTamHMwhkGXSj7isXp8Lc0l7ptqS2dD9ZpD0ku3fKnHdzZ2HQ2I1NrkPadaAlINSh5Y2b4ybOz2V1a+gU7xR8aOVTamTQPmEnrOaP2rWGOYWb1O7NQ1dWGnKrXJVt6A4qsxTp2TrBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721426700; c=relaxed/simple;
	bh=JUPO6eARFcABbF99tiZyanxxjqnwgInQlYtjLK7gX84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJu5tkmATtUoBNpz2BjLw1nfoR+2LetEQAeZrau7y9I8iOCXYjXLW61a3rhqMQVeesGcy6OlWHHZ1kH8ziWktGCqOTMo9i74y9WWV/zWp4MHFsOuMANxCmD+lg8LIXnKMcyJA2V56fjdvgMT0OXWUoX2BU4WyJMT5mZrJ+uwBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xs3sqVP7; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: pasha.tatashin@soleen.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721426695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFYBCysMktN44xqqHXD2HgYrB33axzEkhlU1r9cNdhU=;
	b=Xs3sqVP7knzwsj8riTanFOj+iXGIURj5hv7DMssgxlexRorRu8eiexkf8UFoRP3yKbcAMf
	KtafKxcWm8OhyCLNPXHp3idWSPpbfUPM8nE1cHOiiAF4cZv/lFBj3GDW9lDjTcdryYUj2Z
	JJNt8Ll9dwalECmxFMqLk8Y9OEYivWw=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: jpoimboe@kernel.org
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: peterz@infradead.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: cerasuolodomenico@gmail.com
X-Envelope-To: surenb@google.com
X-Envelope-To: lizhijian@fujitsu.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: ziy@nvidia.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
Date: Fri, 19 Jul 2024 15:04:40 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, 
	kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com, 
	cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] vmstat: Kernel stack usage histogram
Message-ID: <ud5csdd23fjb2gin4uuxsocm4hvsy22bk4plfjv5zvqd2egqri@hpavorxrrprw>
References: <20240718202611.1695164-1-pasha.tatashin@soleen.com>
 <2fbbxcsjs7vtzpb6a5wudbppcr2wgc2xwdw3cgs6ejzx6rioze@z2sct6rbulng>
 <CA+CK2bB4RELLHExbkL444ArTtUnqiYVYKJ1rLQGarLyenY6WxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bB4RELLHExbkL444ArTtUnqiYVYKJ1rLQGarLyenY6WxQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 18, 2024 at 10:55:17PM GMT, Pasha Tatashin wrote:
> On Thu, Jul 18, 2024 at 7:36 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Thu, Jul 18, 2024 at 08:26:11PM GMT, Pasha Tatashin wrote:
> > [...]
> > > diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> > > index ccd72b978e1f..65e8c9fb7f9b 100644
> > > --- a/include/linux/sched/task_stack.h
> > > +++ b/include/linux/sched/task_stack.h
> > > @@ -95,9 +95,51 @@ static inline int object_is_on_stack(const void *obj)
> > >  extern void thread_stack_cache_init(void);
> > >
> > >  #ifdef CONFIG_DEBUG_STACK_USAGE
> > > +#ifdef CONFIG_VM_EVENT_COUNTERS
> > > +#include <linux/vm_event_item.h>
> > > +
> > > +/* Count the maximum pages reached in kernel stacks */
> > > +static inline void kstack_histogram(unsigned long used_stack)
> >
> > Any specific reason to add this function in header?
> 
> For performance reasons to keep it inlined into stack_not_used() which
> is also defined as inline function in this header.
> 

Is this really that performance critical?

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
> 

The above makes me think it is better to move stack_not_used() and the
new function to C file unless we can show the negative performance
impact.

I have another question. At the moment, the metrics are exposed
conditionally through procfs based on stack size. So, based on the
kernel config someone may not see kstack_16k. Why not just output all of
these metrics irrespective of the config?

Shakeel

