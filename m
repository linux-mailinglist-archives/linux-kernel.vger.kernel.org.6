Return-Path: <linux-kernel+bounces-358909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E008998530
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080171F23F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25661C462A;
	Thu, 10 Oct 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J8LlM4R1"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C81C460D;
	Thu, 10 Oct 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560278; cv=none; b=aQuLn9tt6LYgmx98dIZAjHKO5hy8g5TULhtJcVxmUuD1jiYdeT+55chfCHM9O53EAx9HN9p6PrpXhcTz5JhAkXKxm78+bMhXEBxh4Eh9j42qUqJjmBPUMa8WrdejPCJ39hj0a4YzwAHOBEikVEe8+mQhycoWl0QXyyz/S+RgX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560278; c=relaxed/simple;
	bh=ANDjRIA1ZprcU8exVnvEaIqGcwciA1WJ5Bq8psWLXLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6RwVMgoyE98h5zQMW8vZ+JaJ9LUrS+fHLZPS/hzjfDFblCSbbc75bKtBxU1Rr1QwpOwnsM4tC1tnSVsP86B+cEuqNwFQYe9yB/ebCCs5mRTK+P6JgY7R5mmi4zLNcnBQcAaoveVbbusU0ldoSADBBlzogPwwXm48kaVti2IwNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J8LlM4R1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AeP6MXC9HVagnimcA4KeNuLvS+oXfaoCNFU0RDE/p3A=; b=J8LlM4R1b1U+EciwkUe/tANvQI
	8DBT9O/R7KRbKA+73LbRwefXAwtDpcxXrwGZymbwG5BGOFtHRSEZXN3gy3CjHWeOGcPi/uvhfBhLQ
	VHjH1xLXnSAojwoJ8wHciJVFbF7pUGP4vobY/z4lZjc3AHRcdpHjkNsgzhKXcZZyhEUsc3wOcgV3h
	feAUNdCRcLy5m8SYvZjzu64rXgUw+/Ie498vc9Oc4NVLk5u9dZKJ7yrMzX1e7k/+nE/4Gvlm/PbZI
	9J2DUlrccIhdMO+qBZYJBuCBI/TgFSlEouJ+Sv/IPksZtn2f+At0sRUmXiLXlZyE2lgZX+S/Z9qi/
	Y3ozu9rw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syrUK-00000005Mv7-418t;
	Thu, 10 Oct 2024 11:37:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8D65130088D; Thu, 10 Oct 2024 13:37:48 +0200 (CEST)
Date: Thu, 10 Oct 2024 13:37:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Matthew Maurer <mmaurer@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all
 architectures
Message-ID: <20241010113748.GL33184@noisy.programming.kicks-ass.net>
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
 <ZwbAvEnrzu6UUgGl@J2N7QTR9R3>
 <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
 <ZwewMw8jBh6OU-L_@J2N7QTR9R3>
 <20241010110344.GL14587@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010110344.GL14587@noisy.programming.kicks-ass.net>

On Thu, Oct 10, 2024 at 01:03:44PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 10, 2024 at 11:45:07AM +0100, Mark Rutland wrote:
> 
> > What happens on x86 for ftrace and rust?
> 
> I can't seem to enable CONFIG_RUST, so I can't tell you :/

So much for the debian 'rust-all' package actually including all. Thanks
Boqun for telling me about the rustavailable make target.

Anyway, confirmed (x86_64) rust code does not have __fentry__ hooks and
cannot be traced :-(

