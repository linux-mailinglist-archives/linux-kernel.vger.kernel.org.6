Return-Path: <linux-kernel+bounces-378766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8EF9AD53E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D861F23471
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0861E0DBF;
	Wed, 23 Oct 2024 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AbpLzDL5"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338813AA2F;
	Wed, 23 Oct 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713147; cv=none; b=X7iw+uFXCDIIVwNE65NFQqRrFVdOmsSHuPfxgMNzOBrfJ/hBb+hjMPlq2jfwpATZJkyA+RTo2fmhgpPLe9muGqEBQO6ysFu6Y2Zsia9Y/VO5PI3aeboBLHrGpnBLdf2n4XISsiLbAGjbSU4xGOLX4ZZAXGoFFNKF6Xln1LeYWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713147; c=relaxed/simple;
	bh=O+zehsLqoh4JYaQs/FYh0KngRH9Ood+BEx4/xBJQ++c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9vygxWWGm5YeyFlUz/+HiAF+U8ZD4zN6U3OV6KGRrqExNCmxidfwCWDAvmxNdcQ0cQEvxGIUQaNKjGBKcpGkSvOJaclLERnk/8KAn0RvnI5BVdp8RNvQRqbNUg8lXfEzzed2+5ooFtYopptp0hcYDrizmccEl0kdS08DfyrDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AbpLzDL5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O+zehsLqoh4JYaQs/FYh0KngRH9Ood+BEx4/xBJQ++c=; b=AbpLzDL52Y6pbMKkz7kk8+MfbS
	p/xLyIwnriSP/7R1dd8viQNV9aAfZHPN27VbuO6c0pStB+P8esSBWk3+nXozIyw08IOAOooNg2XLY
	jtc3gZSch+lp8JrQrILsoN9+BgnvNov67zxRFV/WLFwsCQm3bnviv+3SyKn3ugo1kNQKVyErHDY8i
	/EpCSs4xBmxd5WkhgkcSPGntw8a6TsKqHy5ciye8rlH1srh3mlY16Mr15B4ymOMXFP2mRnZ9eyNG3
	ET2sjKDtZPvTtqSWJZfFiODDz7vLszxCnlAtyGHQ6v/OhVOOR7hb6dHwTT791uT3WI9GQe7TESoWT
	wYMBrTgg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3hOa-00000008XTm-34pI;
	Wed, 23 Oct 2024 19:51:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5216130073F; Wed, 23 Oct 2024 21:51:52 +0200 (CEST)
Date: Wed, 23 Oct 2024 21:51:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Dirk Behme <dirk.behme@gmail.com>,
	Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>, will@kernel.org,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>, aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <20241023195152.GE11151@noisy.programming.kicks-ass.net>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
 <87a5eu7gvw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5eu7gvw.ffs@tglx>

On Wed, Oct 23, 2024 at 09:34:27PM +0200, Thomas Gleixner wrote:
> On Thu, Oct 17 2024 at 22:51, Boqun Feng wrote:
> Ideally you make that part of the preemption count. Bit 24-30 are free
> (or we can move them around as needed). That's deep enough and you get
> the debug sanity checking of the preemption counter for free (might need
> some extra debug for this...)

Urgh, so we've already had trouble that nested spinlocks bust through
the 0xff preempt mask (because lunacy). You sure you want to be this
stingy with bits?

We still have a few holes in pcpu_hot iirc.

