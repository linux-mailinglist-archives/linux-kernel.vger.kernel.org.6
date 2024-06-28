Return-Path: <linux-kernel+bounces-233708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB74191BBDE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706481F221B4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07998153519;
	Fri, 28 Jun 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zFZUKFBD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5hz3Z5ll"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776015278C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568189; cv=none; b=ckwnTJK4KeIcSEnYzv6ZjNRjS5A90ZJjlGc2BPDoN6O5Gg53L6339Uw5QftOUzPnqAhaBSFppG6D9iirfkUnSfYyqBhOYOOToS3Tiipga/vmyd78vXIrs6XQYjS8+LQPH1jyiB+e4NSLiivPV46OSuTpCnVjQU/7M+UYCpN/VIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568189; c=relaxed/simple;
	bh=hP2esbqwbSfw80i/Jbzy0M1Ko0/3HN1DJ4B3HcGWSlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4I9riSXYOVu4o9FTO48BSwnoyK+QDQ4VZuLHaychIm4diydzj7TiiWvioMXMM+zOw75i6Q2n62yS+7bJT58Rs1un/K8DeyvdomVl/VSSfU6DIKiPhY7LxaaXauMrEcPwPuEE3LCMT7frX2uQGcmB0CdwgUXix0ZpL4jFtykLHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zFZUKFBD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5hz3Z5ll; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Jun 2024 11:49:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719568185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRTTaQMWsKNu0RAP3ZI6MFRNxnChl+5ZQXlF75X+APs=;
	b=zFZUKFBDBKe8wJAVPU3rtJndgnbfwdk4iOY0YDtlGBoje+5TtFtm++Jh3weufcYuiK56LB
	KQh5vG447NbYrW4NhN8y6TfQb+Vn3GEKOWT67ojj9nbJE5wJMCB2fwIgarzq7B9D9nToVf
	e73isXlIBp2cX+0Zn2iOpE9L/ruEOMYncYPayHtNctEHce/iJK1/sq7dB2E6NxUyJ/3lNK
	sWksUD+qXTPegSHh/SBMcajqyKSab2o2z6lRV28I6G7lWK/R/U3CWqkuc9ueyYoM+n2Ljz
	iQ3P67dMEctnN1cKzirkOuqmw+cBr127Dx3GVlafSkO+ICYxs4evbSUEIlurWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719568185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRTTaQMWsKNu0RAP3ZI6MFRNxnChl+5ZQXlF75X+APs=;
	b=5hz3Z5llDJwqxv2R+8ZK/iuAI/paKRwd/5drxPDCxhTiq4aUXCLKVmW9A9mJ2wb8aUa03g
	iM7H7Pt3Pb8mqaAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <20240628094944.QwcHkf8J@linutronix.de>
References: <20240621102750.oH9p1FQq@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621102750.oH9p1FQq@linutronix.de>

On 2024-06-21 12:27:52 [+0200], To linux-mm@kvack.org wrote:
> The alloc_tag member has been added to task_struct at the very
> beginning. This is a pointer and on 64bit architectures it forces 4 byte
> padding after `ptrace' and then forcing another another 4 byte padding
> after `on_cpu'. A few members later, `se' requires a cacheline aligned
> due to struct sched_avg resulting in 52 hole before `se'.
> 
> This is the case on 64bit-SMP architectures.
> The 52 byte hole can be avoided by moving alloc_tag away where it
> currently resides.
> 
> Move alloc_tag to the end of task_struct. There is likely a hole before
> `thread' due to its alignment requirement and the previous members are
> likely to be already pointer-aligned.
> 
> Fixes: 22d407b164ff7 ("lib: add allocation tagging support for memory allocation profiling")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Could we please get this merged and worry about possible performance
regression later? Or once there is a test case or an idea where this
pointer might fit better but clearly the current situation is worse.

Sebastian

