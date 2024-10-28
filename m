Return-Path: <linux-kernel+bounces-384781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C69B2E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7C21C21EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A821D934B;
	Mon, 28 Oct 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bjvRD+eB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F521D5178
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113243; cv=none; b=ifgZDgItuSBQwmbibMb0mZi810lbYtw651GO5eg5iwqvXtbluHBwwiP/82NZbvkaGXh2t7H2fP1qTWvgPccqbuzAGaSLGK0N9wahxl5ULWQ1TybXpwZRiyi/SA3m4XqfDaUnthgnZbspjEiGDj8SkrjyxRmyzUoLWL9JsBO6Q74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113243; c=relaxed/simple;
	bh=eRfEr9zwUm7vbHvMyY0H8FlB53qrZswMz6+XgVJBQ00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB4WtkEywNIOc3wMSJFZvk3r2gn21G56XkfMOhvFBpbmE9ypu2It/fc1FsaVcTnn0YyIXucOHNV1Na43RYF7g580lWboms4mMeq40ftpsWWoEHXoVXsszPL2m3U4Q6qvaQvmgJufR8Dz487FoVE9xUj3ekCv5egd7dGUz2boLk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bjvRD+eB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KgpX8gHt3MnLKUbanJ6BywCOOxK16uxKEifonmlQ27g=; b=bjvRD+eBQaQ+xT8ZNLh/xdsgja
	rnm2ctfSxcsTbZjdOvqnG8fAeIsqEY3Y6aEYynIUTt45ty3rT8A0OW49FCGZ56xdkNa9QXmY2qtSR
	9oNIkbNn4saBP9HjpYEAvVna/WxYyVUF1J00VyjQ+zdmjQxe2u/uBQquz/NsD2wUpH6C8rVc0ie4u
	OpR021pb+aHOBOVUpJBLY7ri85qnTlUNBMpzjW33UNjx+XQILpR9hVGQGHhixB2kV02Qqxd7VEQk/
	PyjCY6EYMoHUVvKJ5CLr5ZsaRxEpvx3LmYqh/pShCqSjzfPqa8o6y8riTrT85NoirVTeWt1n/cL5q
	eGUgfY6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5NUC-00000009dwe-0qHp;
	Mon, 28 Oct 2024 11:00:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8FBAA300B40; Mon, 28 Oct 2024 12:00:35 +0100 (CET)
Date: Mon, 28 Oct 2024 12:00:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 2/3] futex: Add basic infrastructure for local task
 local hash.
Message-ID: <20241028110035.GQ9767@noisy.programming.kicks-ass.net>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de>
 <87cyjl4u1h.ffs@tglx>
 <20241028103058.tERYBWZu@linutronix.de>
 <87y128335h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y128335h.ffs@tglx>

On Mon, Oct 28, 2024 at 11:58:18AM +0100, Thomas Gleixner wrote:
> On Mon, Oct 28 2024 at 11:30, Sebastian Andrzej Siewior wrote:
> > On 2024-10-27 13:19:54 [+0100], Thomas Gleixner wrote:
> >> So T1 and T2 create their local hash and the subsequent usage will fail
> >> because they operate on different hashs. You have the same problem
> >> vs. your allocation scheme when two threads do prctl(ALLOC). We really
> >> want to make this as simple as possible.
> >
> > So I moved this to struct signal_struct and limited allocation to the
> > group leader.
> >
> > You want automated creation of this? For everyone or with a hint? This
> > is 64 bytes per slot due to the cache alignment but event without this
> > struct takes 56 bytes on PREEMPT_RT and 24 bytes on non-RT. So the four
> > slots are 256 bytes. Assuming 2.5k tasks it takes 625 KiB. Maybe not
> > that much.
> >
> > Let me post v2 the signal_struct and then think about auto ON.
> 
> It only affects actual futex users. A lot of executables never use
> them. For ease of testing, can you please make this automatic so there
> is no need to modify a test case?
> 
> Aside of that for RT we really want it automatically enabled and as
> Linus suggested back then probably for NUMA too.
> 
> Stick a trace point or a debugfs counter into the allocation so you can
> observe how many of those are actually allocated and used concurrently.

Ideally it would re-hash and auto-scale to something like 4*nr_threads,
but I realize that's probably a pain in the arse to make happen.

