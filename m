Return-Path: <linux-kernel+bounces-418723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7419D64B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F13B23529
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A34B1DFE04;
	Fri, 22 Nov 2024 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N6e9o22d"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429691632F8;
	Fri, 22 Nov 2024 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732305300; cv=none; b=qbiNLu99emJ196RTfKSOPD9ANQwZws52DbWrwup+bBQ7s3+kqxP8h7wjr1Qwua7hMTi+T2t6eWaitcFjTatfTJxpgsnrvVOeuOHv+8sen5ppu8FC/IEiwF4so4Zog0lSEwj4joH8Vn/vWOYUiIjNzolTvr5C32/8cYGZp9jAKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732305300; c=relaxed/simple;
	bh=LPRbSwxibhVnKkXtnxJbpTjhUs3fYLIScHI2/AVG37U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqw+GVxg8N0NxvigY5upCHzdRY2G3uQYhyQNiQKfRjj7VUPjVuDPUrMtoYyBTlBQ+LGP4ppxPFoT9YnysrJDgdA8zzvwiAO+uAngX+RLJPMO55KniKLTynTkVs/cE8ThCdCMBp4xuC3H6n5f611BbkWuV/iiw964jbBzozONxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N6e9o22d; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=F4IQQGbkbmf3wjPhz8ksZi8Xqv5qdPwCrcqy196y0rY=; b=N6e9o22dJkp5p6biR6EHC/9n/g
	mnCk6rxI7rFyzdGlvGjqq3alLN3mfMdT/mwTgVDU22PdAC+bp10PqvIdJnSZsb0Ki2022vCpgI1A3
	lLWZ8Lxc/00UkjXAWTwD/xnJyBPxAD+pNaUll0m5O7zOQJ51vUWG+8hPnSG1X2TQq6IbThfwyD0Mz
	D6HOPGAA9na4kOSWc+YjwbzIH70+2fT2Tg/QvZ+vtzGSIlgHGjWQYwciBDMbTG+XV+WCNHGErk8aS
	uLsC/UMd0ejMEzlpSivrnLIA4OzJLixnoLuamB1ZjX8gpkWDnN+puXSLZE+Gk3n5c3wZA9Q/dKWEm
	hJY2Idgw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEZjv-00000008Dxt-2ZgJ;
	Fri, 22 Nov 2024 19:54:51 +0000
Date: Fri, 22 Nov 2024 19:54:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
Message-ID: <Z0Dhi3LDfxFGtAQn@casper.infradead.org>
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
 <20241122-vma-v9-8-7127bfcdd54e@google.com>
 <6740c786.050a0220.31315a.5363@mx.google.com>
 <CAH5fLgiiCgcPRkdeGX7LJcaGN5Y5E=zWOXuwqo+GU-tTt63PzA@mail.gmail.com>
 <6740d8be.050a0220.30b282.4f2e@mx.google.com>
 <Z0Dbvbj39c87EQTq@casper.infradead.org>
 <CAH5fLgippKab6Qarc7go8pz8XPrvEOoi_FvzMNAJXzr8v3qqjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgippKab6Qarc7go8pz8XPrvEOoi_FvzMNAJXzr8v3qqjA@mail.gmail.com>

On Fri, Nov 22, 2024 at 08:43:33PM +0100, Alice Ryhl wrote:
> On Fri, Nov 22, 2024 at 8:30 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Nov 22, 2024 at 11:17:15AM -0800, Boqun Feng wrote:
> > > > I don't think this is a problem? As long as a thread exists somewhere
> > > > with `current` being equal to the task, we should be fine?
> > > >
> > >
> > > I think I had a misunderstanding on what you meant by "operations
> > > that are only valid on the current task", you mean these operations can
> > > be run by other threads, but it has to be *on* a task_struct that's
> > > "currently running", right? BTW, you probably want to reword a bit,
> > > because the "current" task may be blocked, so technically it's not
> > > "running".
> > >
> > > Basically, the operations that `CurrentTask` have are the methods that
> > > are safe to call (even on a different thread) for the "current" task, as
> > > long as it exists (not dead or exited). In that definition, not being
> > > `Sync` is fine.
> > >
> > > But I have to admit I'm a bit worried that people may be confused, and
> > > add new methods that can be only run by the current thread in the
> > > future.
> >
> > I agree, I think CurrentTask should refer to "current".  Or we'll
> > confuse everyone.  Would ActiveTask be a good name for this CurrentTask?
> 
> I mean, it does refer to current. Any time you have a `&CurrentTask`,
> then you know that you got the pointer by reading the value of
> `current`, and that the task you got it from hasn't returned to
> userspace (or otherwise exited) yet.
> 
> But the name ActiveTask also makes sense I guess.

OK, I'm going to be all rust newbie about this (zoea?)

Given that there are operations that we can do on 'current' that aren't
safe to do if we pass current to another thread, is the right thing
to say that we have Task, and you can get a (Rust) reference to Task
either by it being 'current', or by getting a refcount on it using
get_task_struct()?  And I think that's called a typestate?

