Return-Path: <linux-kernel+bounces-346770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E58198C877
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C742862D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414791CF282;
	Tue,  1 Oct 2024 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="he1YoJMP"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0871BD034
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823441; cv=none; b=YgI23GJ/Iu1JhX5PB8UDId5kfqVZuIFn/gk/mL0pK0ALeNP09SBL+mkMFjuftflJb+SIMLpgQzRmFolSPZDR8YhDYk40G/0bS73WMtWPoeTvgu03GelQgGjzbJkcw6JoWR4NRFw2hXNFakDhl34U8TrCDsSlQOXuKv8GSrz8eOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823441; c=relaxed/simple;
	bh=7Ok8CiQ0qQ7Ho86dH0bw0yrBB+LMaKiwyr+0qBoL3p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+IM3aYAmOJ+RIxfIL2YvDG/I5D9XbzVa7ncnfUjTqxrkIPV2aDB/Qf36WoHScOXO4o5/3mPTA/CGwlqy3Ss+gzFZS9UOGTd5FzDdEHCeyr8TMA/ytdXke2+/AiV6Y93dWDmkBWeTMKmqN0nwhRlaBJdp/eRCVqguC5Xq+M6T24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=he1YoJMP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7ae3fcec5feso418709385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1727823439; x=1728428239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rspeAAc+JRCDmaTUx2qdwPB8gp+dYPhnD00JvbaW/TA=;
        b=he1YoJMPQe8U/deahSWd1fs6vf/nCs/fjk3uUV/uKOZBj7ajdK6k64cFTC4hkr4nLG
         T/ImNI7NcsVf1bbbHPEUv52Kxy8rwN4mu+fChr8eflkEcr7KSACmlKwhUb+Bd6OmvEYj
         D33GzudMoItgMPEMsOyl9vJXwUfKlOjQx8u6vzPYtRsHPdyOKmdKqTInMFQn1TnaA3/8
         hjUm97+0SPMC9pag0n+pSbtIT9T00Ipzcwsx1PI7pAz1NjirEE/6ffWfgzZARGcLfapE
         Py2BvU/hHWKE3PQtiLPi/E85BiwCSNAGPaFt4NqjY9HBMzqcwQX3lhmC8BtHkSJs6TNj
         7c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727823439; x=1728428239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rspeAAc+JRCDmaTUx2qdwPB8gp+dYPhnD00JvbaW/TA=;
        b=MF17F7uzwbicGEv5QpEj7IeLJu3cKKxLZY60+jf6qGUhe4aS3RSSs9zOAKI4Z3bzFu
         CIQrSASgF9FZMj/Vn3eJVE6X3SKd9jKQnVFFTWo6z7AYVLh9RsBq2JyLKRNxYxWmfT0l
         xq6lEU0cIJqBXi0iG4xjo3BCWYfw9xsQEmhzqelgGSj92056ghxiAUnJqePok47iBvj/
         vZ8l0+0h4mmttUMzG0QamiBkSkNGDbSPMcNRz9WsGuKrZQ50cNRH3OsCIABBmjIYdn9b
         DP+1v0md/L178zOtrM2PuLhWsq4p45PTEYMhlkV19FsxKlSZNBcRflgmwzIyrH15RNex
         wiYw==
X-Forwarded-Encrypted: i=1; AJvYcCVoVIJodqyibm3d/6vlj1WXRg4fXBjJBykRq6Dj5qQ3tpSNrvzOoXXnBGZeSFLkPWOOgwuNwelvT06xDZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybY6u3raiizm3oGIm2yS62pf3fzpkYBow+SvcHMqEtnGM5d/55
	KEMh2KqkbZYqoNFGtZOxoUoMmOxrKRk2CPCYF8+Ma1qkpuD1ZDLFbwnmnbIYlA==
X-Google-Smtp-Source: AGHT+IGe8hLbudtLqVw4HA3bUOj2VieZ0OvJdesAxdCUKIxBnEyri8YwqF4MHDxHD5sCjFwTNkPfnQ==
X-Received: by 2002:a05:620a:4490:b0:7a9:ada6:86c9 with SMTP id af79cd13be357-7ae626c541dmr193649085a.26.1727823438802;
        Tue, 01 Oct 2024 15:57:18 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::5638])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3782c6c0sm548321285a.88.2024.10.01.15.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:57:17 -0700 (PDT)
Date: Tue, 1 Oct 2024 18:57:13 -0400
From: 'Alan Stern' <stern@rowland.harvard.edu>
To: David Laight <David.Laight@aculab.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	"maged.michael@gmail.com" <maged.michael@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"lkmm@lists.linux.dev" <lkmm@lists.linux.dev>
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Message-ID: <2b1caba3-48fa-43b9-bd44-cf60b9a141d7@rowland.harvard.edu>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <9539c551-5c91-42db-8ac1-cff1d6d7c293@huaweicloud.com>
 <2cdda043-1ad9-40cf-a157-0c16a0ffb046@rowland.harvard.edu>
 <5d7d8a59-57f5-4125-95bb-fda9c193b9cf@huaweicloud.com>
 <82e97ad5-17ad-418d-8791-22297acc7af4@rowland.harvard.edu>
 <ea02ce2ce8a348efa8d461f84f976478@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea02ce2ce8a348efa8d461f84f976478@AcuMS.aculab.com>

On Tue, Oct 01, 2024 at 05:11:05PM +0000, David Laight wrote:
> From: Alan Stern
> > Sent: 30 September 2024 19:53
> > 
> > On Mon, Sep 30, 2024 at 07:05:06PM +0200, Jonas Oberhauser wrote:
> > >
> > >
> > > Am 9/30/2024 um 6:43 PM schrieb Alan Stern:
> > > > On Mon, Sep 30, 2024 at 01:26:53PM +0200, Jonas Oberhauser wrote:
> > > > >
> > > > >
> > > > > Am 9/28/2024 um 4:49 PM schrieb Alan Stern:
> > > > >
> > > > > I should also point out that it is not enough to prevent the compiler from
> > > > > using @a instead of @b.
> > > > >
> > > > > It must also be prevented from assigning @b=@a, which it is often allowed to
> > > > > do after finding @a==@b.
> > > >
> > > > Wouldn't that be a bug?
> > >
> > > That's why I said that it is often allowed to do it. In your case it
> > > wouldn't, but it is often possible when a and b are non-atomic &
> > > non-volatile (and haven't escaped, and I believe sometimes even then).
> > >
> > > It happens for example here with GCC 14.1.0 -O3:
> > >
> > > int fct_hide(void)
> > > {
> > >     int *a, *b;
> > >
> > >     do {
> > >         a = READ_ONCE(p);
> > >         asm volatile ("" : : : "memory");
> > >         b = READ_ONCE(p);
> > >     } while (a != b);
> > >     OPTIMIZER_HIDE_VAR(b);
> > >     return *b;
> > > }
> > >
> > >
> > >
> > >         ldr     r1, [r2]
> > >         ldr     r3, [r2]
> > >         cmp     r1, r3
> > >         bne     .L6
> > >         mov     r3, r1   // nay...
> > 
> > A totally unnecessary instruction, which accomplishes nothing other than
> > to waste time, space, and energy.  But nonetheless, allowed -- I agree.
> > 
> > The people in charge of GCC's optimizer might like to hear about this,
> > if they're not already aware of it...
> > 
> > >         ldr     r0, [r3] // yay!
> > >         bx      lr
> > 
> > One could argue that in this example the compiler _has_ used *a instead
> > of *b.  However, such an argument would have more force if we had
> > described what we are talking about more precisely.
> 
> The 'mov r3, r1' has nothing to do with 'a'.

What do you mean by that?  At this point in the program, a is the 
variable whose value is stored in r1 and b is the variable whose value 
is stored in r3.  "mov r3, r1" copies the value from r1 into r3 and is 
therefore equivalent to executing "b = a".  (That is why I said one 
could argue that the "return *b" statement uses the value of *a.)  Thus 
it very much does have something to do with "a".

> It is a more general problem that OPTIMISER_HIDE_VAR() pretty much
> always ends up allocating a different internal 'register' for the
> output and then allocating a separate physical rehgister.

What output are you referring to?  Does OPTIMISER_HIDE_VAR() have an 
output?  If it does, the source program above ignores it, discarding any 
returned value.

> There doesn't seem to be a later optimisation path to remove
> 'pointless' register moves.

That would be a good thing to add, then.

Alan

