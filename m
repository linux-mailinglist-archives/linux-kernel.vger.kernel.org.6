Return-Path: <linux-kernel+bounces-211295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C6F904F97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60EE1C215D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0864A16E863;
	Wed, 12 Jun 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PTLio1Us"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263915BB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185746; cv=none; b=uONUUrcAApm/5TdWaefHKG7lXpwAsdTadsVUNU/zFh19H6BTXDIr17Hwrbi0w9YwNuMuSoXb154Zcbkum8wxE2d475cKoJ3QHs9H1TxXw4scwW+TjsK3a+N49bYE+gehOynF65rk70xNqtIxkwuoB4PNHT5JPWR8yEFu7KfVpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185746; c=relaxed/simple;
	bh=IoFUFoVcf8FvGw1axTtJDXH5ltICWsdnHAd+i+6Sebw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXSrqf4n6EMJw/gBHCYzFRUFBAHVZdXt83FX139h8UV66nUjsShtdZrzdNrp/LrKN7XEaAXNreED8UD2+Zf8nh77UpcJHUD/ZcqLpIA+Jm2IdEMny7PhRBTN6W2UvYUDLSyMuokBr3wImE/FuhufzPj41Fig2Nf5X77JAvZGWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PTLio1Us; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KHhgEZ8iZACa6BanqysyTxl7eWVMUH8NxFVurRQjMlI=; b=PTLio1UsfXb5WfMfWogOu/oalo
	NmfQl5bsdYcgniGo1Nflfuy7EiyPuT3QZM3D/WCYLxoIMEPDdp1SaxV0/x4RS6NMLWpAsSbCEKLpy
	GFOZYfFLyJ735RYFlpDY41B4mOeF0rTLuKNjHqJe8mUdMkn7Zu5k5F8rlPlf7XwbWWLTSSBaluDnz
	8VTkC5IM0yYY0KgM5ZM3yWJd1ft65B6e+egGK6frv98yT1xniPnWoyR07NBk7cNhQ1wY+RvD9Q4GO
	2hlnfUN5wGCiYfzT8gdNmw/Jl/sE/CbtFL6+ZTNCgTWolU07fJF+PkYnV52xJ9R9/KMKmfZ4yJUoI
	5XDe2LMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHKb8-00000002nNB-0sZs;
	Wed, 12 Jun 2024 09:48:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 81DC2300592; Wed, 12 Jun 2024 11:48:56 +0200 (CEST)
Date: Wed, 12 Jun 2024 11:48:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
Message-ID: <20240612094856.GV40213@noisy.programming.kicks-ass.net>
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
 <CAKPOu+9vcAK3ZxB783j5u1MR0YB9WLWjUBGoujZ7+=GZisRh7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+9vcAK3ZxB783j5u1MR0YB9WLWjUBGoujZ7+=GZisRh7A@mail.gmail.com>

On Wed, Jun 12, 2024 at 08:49:02AM +0200, Max Kellermann wrote:
> On Wed, Jun 12, 2024 at 7:01 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > Instead I think what might be happening is that the task is terminated
> > while it's in memstall.
> 
> How is it possible to terminate a task that's in memstall?
> This must be between psi_memstall_enter() and psi_memstall_leave(),
> but I had already checked all the callers and found nothing
> suspicious; no obvious way to escape the section without
> psi_memstall_leave(). In my understanding, it's impossible to
> terminate a task that's currently stuck in the kernel. First, it needs
> to leave the kernel and go back to userspace, doesn't it?

Yeah, this. I can't find anything obvious either. The trickiest one is
read-ahead though, I couldn't immediately track all the
readahead_expand() callers, any such caller must then end up calling
read_pages() in order to land on the psi_memstall_leave(). This is
typically through page_cache_ra_*().

The erofs one is also not entirely obvious, but irrelevant if you're not using
it... the below should make it a little more obvious, but what do I know.

(whitespace mangled)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1698,9 +1698,9 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
                        submit_bio(bio);
                else
                        erofs_fscache_submit_bio(bio);
-               if (memstall)
-                       psi_memstall_leave(&pflags);
        }
+       if (memstall)
+               psi_memstall_leave(&pflags);
 
        /*
         * although background is preferred, no one is pending for submission.


> > I think if your theory was
> > correct and psi_task_change() was called while task's cgroup is
> > destroyed then task_psi_group() would have returned an invalid pointer
> > and we would crash once that value is dereferenced.
> 
> I was thinking of something slightly different; something about the
> cgroup being deleted or a task being terminated and the bookkeeping of
> the PSI flags getting wrong, maybe some data race. I found the whole
> PSI code with per-task flags, per-cpu per-cgroup counters and flags
> somewhat obscure (but somebody else's code is always obscure, of
> course);

It really is a bit tricky, performance and all that.

> I thought there was a lot of potential for mistakes with the
> bookkeeping, but I found nothing specific.
> 
> Anyway, thanks for looking into this - I hope we can get a grip on
> this issue, as it's preventing me from using PSI values for actual
> process management; the servers that go into this state will always
> appear overloaded and that would lead to killing all the workload
> processes forever.

Best case would be if you could somehow find a reproducer, but
I realize this might be tricky.

