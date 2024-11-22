Return-Path: <linux-kernel+bounces-418710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E229D6496
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C657C2831C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7901DFE1E;
	Fri, 22 Nov 2024 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KUzvgbhN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7881DFE0B;
	Fri, 22 Nov 2024 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303817; cv=none; b=fzAt2SiaRA+Yk1SX+xRMNP6z1Z43q/2ZQWj0drAaBeGZAZtSvgU2KdRmKCR8Q+bKn7cx0t96Smu1/H9Ef+y0p81y98RvGZL4F/qU3mFTXPMN5hK2Gf3Zm7B4bxuBQKeHi87T6YGc4VMEOGuffTDt/hdjmeQOlz7MHJhDRZtj660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303817; c=relaxed/simple;
	bh=+3m/sqMbk7e8r3shpL/2EOX5ejSAqRdgfUos4mMz5zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhQJcJva2rHbjZSWhoUsIgBXTn0DpZGKIYR1cd5untMV1AZekWRJJ6ywPD7vVl85e+/y3+SI+4SSWSxcKCwrAAODpL1ckBRbweFNfqAlLmsJPPCAtaWtGepDR+PdHGYx4nmstg3VDIrjUBTOuI1l6zfHM74dQEeOI6X/CoY9nlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KUzvgbhN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ztkprX5jutqocexXLVcqCzsyxKcO7uHAEhhsDp96C+s=; b=KUzvgbhNAlUBEtmaF9e4fBqURz
	bj0bnFo2mdNxSrXng3M5tESIzY+Xfb82vMLtJggPntlwQz5KCvMraF69t/rhIjlFLuXR5S7tvgD7O
	H/d72p7KYqb4jVL20MxK9IUW9VNlWzF/ltkWuIdfBdjiik/JQwArwsOMATy7FHrUiK0waEZG8+/6d
	gkygLH4TOPF8Xpe1TOtXcyoGX8p0/IKZlMv/b8toURshIUMP/J/onyX5RRqOZIqsxoobqLuzX+PoY
	z3YI60k7aNV4MKiyDhxG32b7TF3ZZWJ4zG1dthPjm8ZljWQFPahIK9qt1WO0QoyG9G1Gw2S7pms5h
	aCDtvD5w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEZLx-00000008CQ6-40BA;
	Fri, 22 Nov 2024 19:30:05 +0000
Date: Fri, 22 Nov 2024 19:30:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <Z0Dbvbj39c87EQTq@casper.infradead.org>
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
 <20241122-vma-v9-8-7127bfcdd54e@google.com>
 <6740c786.050a0220.31315a.5363@mx.google.com>
 <CAH5fLgiiCgcPRkdeGX7LJcaGN5Y5E=zWOXuwqo+GU-tTt63PzA@mail.gmail.com>
 <6740d8be.050a0220.30b282.4f2e@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6740d8be.050a0220.30b282.4f2e@mx.google.com>

On Fri, Nov 22, 2024 at 11:17:15AM -0800, Boqun Feng wrote:
> > I don't think this is a problem? As long as a thread exists somewhere
> > with `current` being equal to the task, we should be fine?
> > 
> 
> I think I had a misunderstanding on what you meant by "operations
> that are only valid on the current task", you mean these operations can
> be run by other threads, but it has to be *on* a task_struct that's
> "currently running", right? BTW, you probably want to reword a bit,
> because the "current" task may be blocked, so technically it's not
> "running".
> 
> Basically, the operations that `CurrentTask` have are the methods that
> are safe to call (even on a different thread) for the "current" task, as
> long as it exists (not dead or exited). In that definition, not being
> `Sync` is fine.
> 
> But I have to admit I'm a bit worried that people may be confused, and
> add new methods that can be only run by the current thread in the
> future.

I agree, I think CurrentTask should refer to "current".  Or we'll
confuse everyone.  Would ActiveTask be a good name for this CurrentTask?

