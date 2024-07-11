Return-Path: <linux-kernel+bounces-249355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5392EA82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C0D281BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CF6163A9B;
	Thu, 11 Jul 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDXr80P2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0215AD99
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707599; cv=none; b=sXGOGYEMiAB79zBGHUX9zbGlngFkURfWSm2DQsK+UOXRdm3Bi6Mk0aI1ZmrzqEHbmdE7sXOyV9HTDxdkDiTGZG9Ck+PbEKE20aa1mXjOL67Z1Siu2wUueMAC9MC8DNbavgzLQEa5kiE/p3xIJxa0yDCNI6BPVALUgHLCf3aweKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707599; c=relaxed/simple;
	bh=qrV6+4ZCF3OixAZZujCLOOjC3Rusfjp8nvA6R12ZCL4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=asQ9NahAZWk+qfiPLao37Xxc/odue5wr3j8LtYfsQh2/sjtlBntbzqUk6wqQbuEXWFCC7pEcHVVcfDxMFzcbkRMFjnAA/oLpldedVgjwApGdvs+xtvWmN6tlUJYqTiKgveNktFq8QT86LfSYMtKA7W+2UmAdzsiWjOkV0OgmSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDXr80P2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C4CC116B1;
	Thu, 11 Jul 2024 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720707599;
	bh=qrV6+4ZCF3OixAZZujCLOOjC3Rusfjp8nvA6R12ZCL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oDXr80P2cAJSvgn9Na3o5WMk5c2H9NXPx9y6nhuIUsDEoF6/OVokgOX4RLvdC1puX
	 sJWly0zPBdc44TYsFzrZDY1UFJX76PadOD/FhUXNzgL/g3qu6Rk8G1Vdq6oQ3kom2Q
	 ErL5HBsEL0UF9goOJZ4R0IM+HFx+YGPDE30pipF7OcEnJHu5aF1xJc9Ik6Caj+iKZw
	 HzsdyV/emMkYDVXzVv1VvUb4LtnSrN9ArQXocJGG/iL1TP6RHzdzd44FjI+ue3WAfk
	 fgqLqk1hvO5I4wyzHC5h5y44bnMD5mB8t56QwshresC/LLWvW79MExWrQf67MW71ar
	 eJbtLk5ND3kjQ==
Date: Thu, 11 Jul 2024 23:19:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, peterz@infradead.org, clm@meta.com, jolsa@kernel.org,
 mingo@kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] uprobes: document the usage of mm->mmap_lock
Message-Id: <20240711231954.b84844bd4b329791ba4c643e@kernel.org>
In-Reply-To: <20240711094940.GB16902@redhat.com>
References: <20240710140017.GA1074@redhat.com>
	<20240710140045.GA1084@redhat.com>
	<20240710235159.23b8bc0f5247c358ccea699d@kernel.org>
	<20240710151006.GB9228@redhat.com>
	<20240711090704.556216a0bca595ad44ee9dbf@kernel.org>
	<20240711094940.GB16902@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 11:49:40 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/11, Masami Hiramatsu wrote:
> >
> > On Wed, 10 Jul 2024 17:10:07 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > > >  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > > > > @@ -1046,7 +1046,12 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
> > > > >
> > > > >  		if (err && is_register)
> > > > >  			goto free;
> > > > > -
> > > > > +		/*
> > > > > +		 * We take mmap_lock for writing to avoid the race with
> > > > > +		 * find_active_uprobe(), install_breakpoint() must not
> > > > > +		 * make is_trap_at_addr() true right after find_uprobe()
> > > > > +		 * returns NULL.
> > > >
> 
> ...
> 
> > OK, but it seems we should write the above longer explanation here.
> > What about the comment like this?
> 
> Well, I am biased, but your version looks much more confusing to me...
> 
> > /*
> >  * We take mmap_lock for writing to avoid the race with
> >  * find_active_uprobe() and is_trap_at_adder() in reader
> >  * side.
> >  * If the reader, which hits a swbp and is handling it,
> >  * does not take mmap_lock for reading,
> 
> this looks as if the reader which hits a swbp takes mmap_lock for reading
> because of this race. No, find_active_uprobe() needs mmap_read_lock() for
> vma_lookup, get_user_pages, etc.

OK, so it is for looking up VMA. (But in the end, this rock protects both
the VMAs and uprobes, right?)

> 
> > it is possible
> >  * that find_active_uprobe() returns NULL (because
> >  * uprobe_unregister() removes uprobes right before that),
> >  * but is_trap_at_addr() can return true afterwards (because
> >  * another thread calls uprobe_register() on the same address).
>      ^^^^^^^^^^^^^^^
> We are the thread which called uprobe_register(), we are going to
> do install_breakpoint().

Ah, yes :)

What about this?

	 * We take mmap_lock for writing to avoid the race with
	 * find_active_uprobe(), which takes mmap_lock for reading.
	 * Thus this install_breakpoint() must not make
	 * is_trap_at_addr() true right after find_uprobe()
	 * returns NULL in find_active_uprobe().


> 
> And btw, not that I think this makes sense, but register_for_each_vma()
> could probably do
> 
> 	if (is_register)
> 		mmap_write_lock(mm);
> 	else
> 		mmap_read_lock(mm);

Agreed.

Thank you,

> 
> Oleg.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

