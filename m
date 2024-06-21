Return-Path: <linux-kernel+bounces-225220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F9C912DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3F71F22111
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0817BB1B;
	Fri, 21 Jun 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E1WGfEEj"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314DB67D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718997210; cv=none; b=oHg/rUGzDYsfL901hZMJKs7zj9IvTM2lodj1pepqKBYIqDnEtiiuHl/+ucE6dkQPJ4MyotWRHcqjYsiDiuGV19okchha0CAGA5X37FDbTh8ozl4qNy/yNRXcMipPq+INb8hf5HcmAMdEcd1RvNrDr13C1t/6VNDsxFVo0RYTD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718997210; c=relaxed/simple;
	bh=8ouQf0DJKbUjW5devzdFPROugjQXPSwE949WmlYAltw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7iAO/HGNTGmOD8B/anWZAUlPqgSJ9l7EBlNJIisBxrs7HcfqkjcidDinyu8IxJ1S062QwfOCUrvSmY1GnV7eS7I+sezc4IbCt+cVCf4vsfLgVvshKwHtxn87UqcwOPnYHMZhuJLl4X5W+k9bj58DmiXlggjO9z8lnxbYmeAT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E1WGfEEj; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bigeasy@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718997205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Oujy0oSP3uMXwSsfsYtQmtVOILqUaJG66ZF3sUiG6E=;
	b=E1WGfEEj1m0wKQeguY0KV1azICuphvzSpxbDM8sLHVh/NVTwXM3rsCocq/4ne8YjCVZNN1
	hOUVX2cqWpda6Gd4kEaQkK75gKKW01vUljXvYYn+lmf/VzZ/knK4rOYqyNsRB1A4nZELd5
	6MQQQp5avQjjaVb+YspAv/CA/Zp2YAo=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: bsegall@google.com
X-Envelope-To: bristot@redhat.com
X-Envelope-To: dietmar.eggemann@arm.com
X-Envelope-To: mingo@redhat.com
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: klarasmodin@gmail.com
X-Envelope-To: mgorman@suse.de
X-Envelope-To: peterz@infradead.org
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: surenb@google.com
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: vschneid@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
Date: Fri, 21 Jun 2024 15:13:19 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <elqyw2tofbojh6rfkfyrjaz6dpwpq4vfd3ni5r3cgkwdumginc@ctizxnu4jkff>
References: <20240621102750.oH9p1FQq@linutronix.de>
 <7zretxxixkpfxt6lr7x64n67ql2v2qpb7abbbjklclwlu4u2kx@22o5sdlnpkea>
 <20240621182915.S-ULWn0O@linutronix.de>
 <yjkte7jz6meaon4tvtwrefvhegwthnxorj3vrz5so6h6kftukv@azvug3smbd3p>
 <20240621190719.TeLTxI9M@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621190719.TeLTxI9M@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 21, 2024 at 09:07:19PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-06-21 14:49:23 [-0400], Kent Overstreet wrote:
> > On Fri, Jun 21, 2024 at 08:29:15PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2024-06-21 10:20:58 [-0400], Kent Overstreet wrote:
> > > > On Fri, Jun 21, 2024 at 12:27:50PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > The alloc_tag member has been added to task_struct at the very
> > > > > beginning. This is a pointer and on 64bit architectures it forces 4 byte
> > > > > padding after `ptrace' and then forcing another another 4 byte padding
> > > > > after `on_cpu'. A few members later, `se' requires a cacheline aligned
> > > > > due to struct sched_avg resulting in 52 hole before `se'.
> > > > > 
> > > > > This is the case on 64bit-SMP architectures.
> > > > > The 52 byte hole can be avoided by moving alloc_tag away where it
> > > > > currently resides.
> > > > > 
> > > > > Move alloc_tag to the end of task_struct. There is likely a hole before
> > > > > `thread' due to its alignment requirement and the previous members are
> > > > > likely to be already pointer-aligned.
> > > > 
> > > > We sure we want it at the end? we do want it on a hot cacheline
> > > 
> > > Well, the front is bad.
> > > Looking at pgalloc_tag_add() and its callers, there is no task_struct
> > > touching. alloc_tag_save()/restore might be the critical one. This is
> > > random code… Puh. So if the end is too cold, what about around the mm
> > > pointer?
> > 
> > Not there, that's not actually that hot. It needs to be by
> > task_struct->flags; that's used in the same paths.
> 
> But there is no space without the additional 52 bytes. Was this by any
> chance on purpose?

No, that wasn't, and it doesn't have to be the exact same cacheline, but
we do want it near current->flags; we store PF_MEMALLOC flags there that
are converted to gfp flags and used exactly where we're using
current->alloc_tag.

