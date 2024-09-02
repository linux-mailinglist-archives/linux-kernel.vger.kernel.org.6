Return-Path: <linux-kernel+bounces-310950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD4296832E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC32D283FA2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636FE1C3F01;
	Mon,  2 Sep 2024 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RuhltjrZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7AB/F6G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0001C3311
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269190; cv=none; b=kpXnhE8zsFpZ97noGldhPRwElAvp5U30h/euixdO3pQKkNhYRkl/I0+z8paZ1fTWWRQjrn3qAXjb56fT3rdxWI6eMIHs0pKGGwYMJBxMJcfcRtMMZ/tEAAHIQ76S5gr7f7UFAVliDpU5cVVQ0/79MCL87g/tYmxjmUE+JKAGVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269190; c=relaxed/simple;
	bh=eSHFani8ArvDeQSL87YQmn6EkZgH9PDAch15/qpmdAU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pEXZamoBqrr/a4nnpKyuqilf5Mr1wx8bF8x3zebW66vvND/p/7MtxBwcb56vbVuOn8/OhWGQmm4T1P+jywRnIJ+T/ICeXYnPJnVRwHuzxfIlm71KUQ376GRKpIbP9zbP1WP/B8Qa69haJUVP5OBh/gMFIebmp4L9wScjibEP7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RuhltjrZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N7AB/F6G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725269187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3XsePS91xsi6XROLfLhvymOx7wWvh+T1BBd+IapLi0=;
	b=RuhltjrZisza+eAvJ9sJu9YugDwt+4erismnWid44XBCK4zyA5pm+wkbuHpdVZNY+aBeIn
	aXQvHFFm4y0xf1zBXX7pR18NtJng+DZFGp+YQRGWqop0+0e5HolGPcLhcekgz0S7d9Opap
	4MmKz3h0zohPQlsqQapYK1LqXjql/ag+YcwyifPdA1fh0OeS/EWHS/CeU+SpkHBwOZuMim
	jRYMJw6CM93PkT8hTsOjeR0hqgF8J8t1xIOI2JAAaPWcNxECPzPnIwpsvCT+Z0d8X8N4Xc
	uE/b5+uuIJyBrQIUfY8BkTHbkTWUAtcnFRjvUqyTp8wHLi7oQ+9kLqcQ2Pn17A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725269187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3XsePS91xsi6XROLfLhvymOx7wWvh+T1BBd+IapLi0=;
	b=N7AB/F6G3OxaLjyRczP0ozWFPqT7putrpDdkkzj/GTmcItlENuSnguN7/vAw1tXzZIreRu
	YexhMLzo2lk2eNCA==
To: Xingyu Li <xli399@ucr.edu>, anna-maria@linutronix.de,
 frederic@kernel.org, linux-kernel@vger.kernel.org, Yu Hao
 <yhao016@ucr.edu>, Tejun Heo <tj@kernel.org>
Subject: Re: BUG: INFO: trying to register non-static key in call_timer_fn
In-Reply-To: <CALAgD-5cKJnWRsS_2rjL1P9pC0dbNX66b8x09p=DUx1kD+p6PQ@mail.gmail.com>
References: <CALAgD-5cKJnWRsS_2rjL1P9pC0dbNX66b8x09p=DUx1kD+p6PQ@mail.gmail.com>
Date: Mon, 02 Sep 2024 11:26:26 +0200
Message-ID: <87cylm76f1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 28 2024 at 17:16, Xingyu Li wrote:
> We found a bug in Linux 6.10 using syzkaller. It is possibly a
> corrupted list  bug.
> The reproducer is
> https://gist.github.com/freexxxyyy/4c465c7d81957779d8bdea44f6cb8977

Again. Without exact kernel version, config and reproduction
instructions this is not really helpful.

> The bug report is:
>
> Syzkaller hit 'INFO: trying to register non-static key in call_timer_fn' bug.
>
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?

That's simply not possible.

> list_add corruption. prev is NULL.

> Call Trace:
>  <IRQ>
>  __list_add_valid include/linux/list.h:88 [inline]
>  __list_add include/linux/list.h:150 [inline]
>  list_add_tail include/linux/list.h:183 [inline]
>  insert_work+0x114/0x320 kernel/workqueue.c:2212
>  __queue_work+0xb61/0xce0 kernel/workqueue.c:2360
>  queue_work_on+0x18a/0x2d0 kernel/workqueue.c:2411

So that looks similar to the other unexplainable report

  https://lore.kernel.org/all/CALAgD-7TsMdA7rjxfpheXc=MNqikEXY9TZNxJt4z9vm6Yfs5qQ@mail.gmail.com

and smells like memory corruption of some sort, which then triggers
non-sensical issues in other code.

Thanks,

        tglx

