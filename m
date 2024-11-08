Return-Path: <linux-kernel+bounces-402237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017E89C2555
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE73228530A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEFD1AA1DB;
	Fri,  8 Nov 2024 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doccP7Eh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533061A9B30
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092958; cv=none; b=Wf8kSJz8CiVEHzrsgP9gwJ4qUmWPl7+hy1tAEuYt8B25dc5OHVXEc6j91ivP1HNufdd3Ii9TDDfLSHUhGre92pyZ3BSVt4XYqM0PgiGqXB+RP68HV3tw5EHifr6qNccS6fWvyIDQ9dX4DQr0eEwaO4EL5cGtbEAQFKQMsSPDnLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092958; c=relaxed/simple;
	bh=rwwosAKimaPwhyH4sdeWFLHFBMJM2OHG3T65u1bo5qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr10cRp1EHcForYAj5XX1un4ud29dIBXmgDft0ynTnU95i9ojvvF44eDviP3a0NETtOu6E/qYt5l3r5IS9DsUpW5OXpt++w49qVSS4IP7Xw4pbIRFQ/i0mYrvZDH3y5r4zDUnWET5cNHVT3xUcmB58q+jHOgp9ndBnktPaPtEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=doccP7Eh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731092956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZO6tQpLz0l4NPwKS50T4h+tYVqN5P9s+m/oOgxbcGc4=;
	b=doccP7EhudYxnRRk1q8i162bdqmPTUxKE1h1oZrT26eaUJuk5CBbm9+f31Vp/UkvcwLaPD
	7hwv4bBg0sDJBC3L8+jlhLykugOK7JoDiDYkPpSuo8Ygy273kQMn6Z6iWmqsGVwWpItjNf
	7lOo/evDpbv0devtxwyuRv/gNYpCzxo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-KjNLVrMOPfuv0pKvCgfwjw-1; Fri,
 08 Nov 2024 14:09:12 -0500
X-MC-Unique: KjNLVrMOPfuv0pKvCgfwjw-1
X-Mimecast-MFC-AGG-ID: KjNLVrMOPfuv0pKvCgfwjw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6889019792DA;
	Fri,  8 Nov 2024 19:09:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.64])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C893B196BC2A;
	Fri,  8 Nov 2024 19:08:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  8 Nov 2024 20:08:45 +0100 (CET)
Date: Fri, 8 Nov 2024 20:08:36 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <20241108190835.GA11231@redhat.com>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
 <Zx9Losv4YcJowaP/@ly-workstation>
 <Zx-B0wK3xqRQsCOS@localhost.localdomain>
 <20241029172126.5XY8vLBH@linutronix.de>
 <20241030140721.pZzb9D-u@linutronix.de>
 <ZyJUzhzHGDu5CLdi@localhost.localdomain>
 <20241107144617.MjCWysud@linutronix.de>
 <Zy4OFlxoRK2jM5zo@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy4OFlxoRK2jM5zo@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Sorry, currently I don't have time to even read the emails from lkml.

Plus I wasn't cc'ed so I don't understand the intent at all, but ...

On 11/08, Frederic Weisbecker wrote:
>
> > @@ -232,13 +222,24 @@ void task_work_run(void)
> >  		 * But it can remove another entry from the ->next list.
> >  		 */
> >  		raw_spin_lock_irq(&task->pi_lock);
> > +		do {
> > +			head = NULL;
> > +			if (work) {
> > +				head = READ_ONCE(work->next);
> > +			} else {
> > +				if (task->flags & PF_EXITING)
> > +					head = &work_exited;
> > +				else
> > +					break;
> > +			}
> > +		} while (!try_cmpxchg(&task->task_works, &work, head));
> >  		raw_spin_unlock_irq(&task->pi_lock);
>
> And having more than one task work should be sufficiently rare
> that we don't care about doing the locking + cmpxchg() for each
> of them pending.

Please see
https://lore.kernel.org/all/1440816150.8932.123.camel@edumazet-glaptop2.roam.corp.google.com/
and the whole thread.

I don't think raw_spin_lock_irq + cmpxchg for each work is a good
idea, but quite possibly I misunderstood this change.

Oleg.


