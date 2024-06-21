Return-Path: <linux-kernel+bounces-225213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC6912DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12161C22196
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807C217B419;
	Fri, 21 Jun 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wwkrM4GI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JEVCOytz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3DA4644C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996844; cv=none; b=Bvi+1/+xYkq2G/8ljQae0hGCYv7Ow74LTORKDbpBKFP7t5w/TEiIggcCtSYCN5p01nsgpE9xVBLnXt7yEEnq/ryXWsenpbX/RNRwNkfktccwINEw/Zy92GFtAqXHIN0k8FCNfbkYATAZuVTNtOEtEWm+xd6gF74fazGBs5A62cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996844; c=relaxed/simple;
	bh=WpdDCLSWpeah/VuUAMtfv28UPenBu9uLrfYHAz6IAi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNhLB58ryzVOYVd/bpOXtKT450AOJ9RWjWhbtitmOvupYvSBvm/vdbH8vnozljQwZFYXesHXnkVehjFfkZTnAsgR/+qlrGOjVuwxrQxfTSOqhPAIvbQCgSDkpdb/uhaX7jSTF1qhlQCzssqTTqJXeTJsq0YTGWoAoaQ7YG0AOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wwkrM4GI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JEVCOytz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Jun 2024 21:07:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718996841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WpdDCLSWpeah/VuUAMtfv28UPenBu9uLrfYHAz6IAi8=;
	b=wwkrM4GIw9Or/b6wteE5g6xVW6K9S89n/g0BIMmPs4lVMKi0XsIKoo8y5tH2K4gin77H2v
	VXet5JzPjpM0Ncqxk8xGyhT90f85bj3Td8MYV5kq1EOs4Y++Balf9in9Ph3nUaFEtmI9vk
	b5rvJzSLSM3mcMA6FyFMw+ofEA4J82WXuRZzUd44twZ+qqvuZ2veLCknVk1B9sFBRufZg4
	Iq1bBE3D3MKuC67tN+aMZqpL9JZMs3Fn47a5Fb5/pR5gELf0bJWQ/LiDgu8ZAwPqKKaSEY
	Wp/hl8wINh8w3vI3Bt3zBp3o1e2bckRpBGaVH+wT6tK9qrPFnutFV5L+Fw+++w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718996841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WpdDCLSWpeah/VuUAMtfv28UPenBu9uLrfYHAz6IAi8=;
	b=JEVCOytzpOb/hy0/DrBqCBtA7xpFAN8ePUV0tIOTSxtb6kK2HDGNeI272x6vmXbefgTLH2
	xBi1dtGZBAeeo1Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <20240621190719.TeLTxI9M@linutronix.de>
References: <20240621102750.oH9p1FQq@linutronix.de>
 <7zretxxixkpfxt6lr7x64n67ql2v2qpb7abbbjklclwlu4u2kx@22o5sdlnpkea>
 <20240621182915.S-ULWn0O@linutronix.de>
 <yjkte7jz6meaon4tvtwrefvhegwthnxorj3vrz5so6h6kftukv@azvug3smbd3p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <yjkte7jz6meaon4tvtwrefvhegwthnxorj3vrz5so6h6kftukv@azvug3smbd3p>

On 2024-06-21 14:49:23 [-0400], Kent Overstreet wrote:
> On Fri, Jun 21, 2024 at 08:29:15PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2024-06-21 10:20:58 [-0400], Kent Overstreet wrote:
> > > On Fri, Jun 21, 2024 at 12:27:50PM +0200, Sebastian Andrzej Siewior w=
rote:
> > > > The alloc_tag member has been added to task_struct at the very
> > > > beginning. This is a pointer and on 64bit architectures it forces 4=
 byte
> > > > padding after `ptrace' and then forcing another another 4 byte padd=
ing
> > > > after `on_cpu'. A few members later, `se' requires a cacheline alig=
ned
> > > > due to struct sched_avg resulting in 52 hole before `se'.
> > > >=20
> > > > This is the case on 64bit-SMP architectures.
> > > > The 52 byte hole can be avoided by moving alloc_tag away where it
> > > > currently resides.
> > > >=20
> > > > Move alloc_tag to the end of task_struct. There is likely a hole be=
fore
> > > > `thread' due to its alignment requirement and the previous members =
are
> > > > likely to be already pointer-aligned.
> > >=20
> > > We sure we want it at the end? we do want it on a hot cacheline
> >=20
> > Well, the front is bad.
> > Looking at pgalloc_tag_add() and its callers, there is no task_struct
> > touching. alloc_tag_save()/restore might be the critical one. This is
> > random code=E2=80=A6 Puh. So if the end is too cold, what about around =
the mm
> > pointer?
>=20
> Not there, that's not actually that hot. It needs to be by
> task_struct->flags; that's used in the same paths.

But there is no space without the additional 52 bytes. Was this by any
chance on purpose?

Sebastian

