Return-Path: <linux-kernel+bounces-554921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F2DA5A369
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8B116EDBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A3417A2E8;
	Mon, 10 Mar 2025 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwDmoA2o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75923314B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632703; cv=none; b=VHnOqq9W9KqP3G/6NkbcTIoNK7/hhsN2XqN6EawURWETXDdXycL8CDcj/UhEDwERAg1ix1+ECm51JFztv5L2wbBvrpDutoSCSi50RiifgZULtwDhJjLkXfcAaUg4Fwnc/lyIG5C/jmn5hPz4gC+/Ckw0zORtNh8s8KFxoxEQ31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632703; c=relaxed/simple;
	bh=Uucrs3Da6AravsMj5Ta5SDyg2QjHZCLxJyyrQviTodc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD4UnVMtrtLpEUC+4AMK4le3KF8OpTPWeu/GJUhDyhGghqlCT8fPcfbQX4MR/9vtNs+pc6aF4kLl7GX0am04GzxDuvnT1IJCG5sCkm/m/k/l0kW5DzqeSLE2Sz+vAT9UTu28XgyiNmq7v5q9yzktrqMT77gA7j/F/8HBlHsK9aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwDmoA2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4078EC4CEE5;
	Mon, 10 Mar 2025 18:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741632702;
	bh=Uucrs3Da6AravsMj5Ta5SDyg2QjHZCLxJyyrQviTodc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwDmoA2ochhVDF8n6H5jftCxbYymwNIPAaBHzFUr+475fSn9bUCc4psZtLAzkwiZp
	 79ctuEk5Bg5IN5xzybBjfKBikCo2OuZG54lnic2O+aocsBTiLHSILWigivV4vkQOwD
	 Itv5hGTEd4os1//urGpABv5oADNsRJ5D+oCUDdvFWFbLEjcKRbv7F9qVYBaKie76lC
	 VEiyLQdJd/go5QgMQByfgRvDMP2fN81inIydHEzWTRvUX4qv+bkEYUjZfIQmyftrvP
	 trB97/IXZdIkb0lSgQKQz9LJnc71GFtIiPnFDc/rKYUEXN+FwwE/u+qntOUdOhxLWd
	 C+hqFxxTut9SA==
Date: Mon, 10 Mar 2025 19:51:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, aruna.ramakrishna@oracle.com, elver@google.com,
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] rseq: Make rseq work with protection keys
Message-ID: <Z880uLxZn6yfShrB@gmail.com>
References: <cover.1740664852.git.dvyukov@google.com>
 <e534910c51271eebf4055a92f3b1c5ac998988bc.1740664852.git.dvyukov@google.com>
 <CACT4Y+bxV-keWg6-NGnA2k039gzMf_9COCe+zQWpcup8bMhToQ@mail.gmail.com>
 <28358cb6-135b-4126-ab80-f2e2d0cb4389@efficios.com>
 <CACT4Y+Zip7O1gAF9atqib52UnEhs4K7+4hkL2xpnwYt34eqMeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zip7O1gAF9atqib52UnEhs4K7+4hkL2xpnwYt34eqMeA@mail.gmail.com>


* Dmitry Vyukov <dvyukov@google.com> wrote:

> > >> If an application registers rseq, and ever switches to another 
> > >> pkey protection (such that the rseq becomes inaccessible), then 
> > >> any context switch will cause failure in 
> > >> __rseq_handle_notify_resume() attempting to read/write struct 
> > >> rseq and/or rseq_cs. Since context switches are asynchronous and 
> > >> are outside of the application control (not part of the 
> > >> restricted code scope), temporarily switch to pkey value that 
> > >> allows access to the 0 (default) PKEY.
> > >>
> > >> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > >> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > >> Cc: Boqun Feng <boqun.feng@gmail.com>
> > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > >> Cc: Ingo Molnar <mingo@redhat.com>
> > >> Cc: Borislav Petkov <bp@alien8.de>
> > >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > >> Cc: "H. Peter Anvin" <hpa@zytor.com>
> > >> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> > >> Cc: x86@kernel.org
> > >> Cc: linux-kernel@vger.kernel.org
> > >> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> > >
> > > Any remaining concerns with this series?
> > >
> > > What tree should it go into?
> >
> > Usually the rseq bits go through the -tip tree.
> 
> Thomas, Ingo, can you please take this to -tip tree? Or who would that be?

I was waiting whether Dave Hansen would have an opinion on this series.

Also, could you please add all the new Reviewed-by tags for the next 
version, plus there was still a bit of a discussion on patch #4, has 
that been resolved?

Thanks,

	Ingo

