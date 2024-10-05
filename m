Return-Path: <linux-kernel+bounces-351976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70968991889
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2626B215BE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CBD158845;
	Sat,  5 Oct 2024 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hOcCtGSO"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED822F5B
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147407; cv=none; b=XBsTa4tCYmLo0t07OzR2aXkwP52ue+lYYASQpu//+IrNpanGAqKZcZFmkw37p6LKA/XJ5rvqxDwMoLkcvIAuq5kmqvpCc74DYNGgF8aOdc4OtVQUXDSllsUbqY8YBLRLooUBtbNGpkmAF4m1vVYYksCSOnwbRWqLBdhGBDPglPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147407; c=relaxed/simple;
	bh=npbBU4EB/OXQqg6L/gxKG9dBNz36EJLnuqdFFqttzZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5zgIz7z7oZuux2cErLwP22O+bNs4d1XFLQyFfKOTejIH6pRe0hdSppj1sBRFYrEjjZVIa+eEAyzHLtIOUSgDLLmvkQWSwGAwd2xH7IqoXnJ2W4d3G5i0eBpE0XQomywMmBxC6XbTcRBGVqarZn1J3om4xMZGPvvgs9N6X6P+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hOcCtGSO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c87c7d6ad4so4308059a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728147403; x=1728752203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lhvgt4CNXD6VdyhO1ydmmdT8s9FGMYClv5PenKYrbxg=;
        b=hOcCtGSOrzuV4caIrhrAYIXP9swaKe9X/BNvLMYuPm6gj3TlERWceY7aQGaoyAUsgY
         8iaA9es8N8No1/hImcuf+pyTI0Un171avgOVcUD5k1RvphXdvoXVKPkKw/tk8wNoD4Ty
         D3zNySsbf/u2XD0q1nTlBd80qa5RreTBIWYAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728147403; x=1728752203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhvgt4CNXD6VdyhO1ydmmdT8s9FGMYClv5PenKYrbxg=;
        b=Kf3dZeYxNFqosGhlqceZHq8H7FHUILIJfwQgL8KaEno7ejsnnm2oSk6VUY6H1QOReW
         g3UG/q+d90ZI6XocIlkJCK9SRrJFeKzcFfFEXsv2/E26Y+x5Az1I8YRs0O8ryTTu9A6K
         R1tq0Mrn/g8FMaHBWWuuHYse7wi616lfcvMfJxLSucuVybSTWdioXL/JXeXtWpYbQ9aY
         XuKnfQUFJH9Y5al4XdFfpqwh8U8ZtNKUX8GwIxDBP+waa70f1kA7+MwwoPxhKZp9HiG2
         heHBqu5j1ywEeXxLcxxCZeALuo2w3zj3ih7NZkr6WTgP9umv6vl0ybtF4vPYQ/UmWAi2
         OB8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3nTygJ0efrSVWqfxIVbs4aIJaLoL8tbAksvv+dmPHVUx6SxjIzQIWyoZH+V2wCbLJY5wF/bxcx9YD5CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0zZVhANyqpMKC1icgCVdz2q77CGdy4223OheT7b2qQx/mG34
	cL1u/0mxURcCmvKV8SfsF84wwB1uGTindY3OnUdky0r7YkX5Ngqza4e/EqlBLUHqDH0Fbfz85+F
	O
X-Google-Smtp-Source: AGHT+IHmKFExC38DoHqSJt6Co/DEUUsFyj5Vv+cxEmL2/SFpjZIuet+9dZq+mGwkwzbbHWeRLZqH7g==
X-Received: by 2002:a17:907:1b88:b0:a99:35eb:1301 with SMTP id a640c23a62f3a-a9935eb1502mr187036366b.18.1728147403117;
        Sat, 05 Oct 2024 09:56:43 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5bb275sm155267666b.11.2024.10.05.09.56.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 09:56:42 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d43657255so498876266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 09:56:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdHN1K95Ol7u1YxiqyIqzUS1UiSRG7YQDJlvbazRX+Ydu5uBFuXRrNU4MF95CE1aOKX+Q2v8MFPRw++FU=@vger.kernel.org
X-Received: by 2002:a17:907:3e05:b0:a93:d5d3:be4 with SMTP id
 a640c23a62f3a-a991bd16c3fmr599542466b.13.1728147401876; Sat, 05 Oct 2024
 09:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgztWbA4z85xKob4eS9P=Nt5h4j=HnN+Pc90expskiCRA@mail.gmail.com> <20241005161537.GB18071@noisy.programming.kicks-ass.net>
In-Reply-To: <20241005161537.GB18071@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 09:56:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvxq3378vOn++=ZiOQc9=4N-3ejUWr+dXEJ5ti43kT6w@mail.gmail.com>
Message-ID: <CAHk-=whvxq3378vOn++=ZiOQc9=4N-3ejUWr+dXEJ5ti43kT6w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] sched+mm: Track lazy active mm existence with
 hazard pointers
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 09:16, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 02, 2024 at 10:39:15AM -0700, Linus Torvalds wrote:
> > So I think the real issue is that "active_mm" is an old hack from a
> > bygone era when we didn't have the (much more involved) full TLB
> > tracking.
>
> I still seem to have these patches that neither Andy nor I ever managed
> to find time to finish:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/lazy

Yes, that looks very much like what I had in mind.

In fact, it looks a lot smaller and simpler than what my mental model was.

I was thinking I'd do it by removing "active_mm" entirely from 'struct
task_struct', and turn it into a per-cpu variable instead, and then
try to massage that into some global new world order. That patch
series you point to seems to be much simpler and clearer.

Of course, you also say "never managed to finish", so presumably
there's something completely broken in that series, and it doesn't
actually work?

                   Linus

