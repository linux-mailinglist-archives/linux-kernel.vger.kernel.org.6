Return-Path: <linux-kernel+bounces-359072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75230998715
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F601C230F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7251C9DC6;
	Thu, 10 Oct 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cXB7wkFL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67F1C8FC3;
	Thu, 10 Oct 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565473; cv=none; b=YRS02UqU6JY+9LNnLDQC3pVOn/J1xYNFkmPRLXiG6WzpU6Mo7dKtvywsB6TXtpUdUsiXs8jN+uKKqUq7OdsVwR1nw9oLQ1+5xmqlS9znEo9yX3PZQ9KqxylyGBEiv467tEJ8o8bhDAndY9pph8o4GDweG2bY6NdK533LFFsAEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565473; c=relaxed/simple;
	bh=WmQqPMxSNZ6YczRgUz2bES9bcAWOfMKyvH7tdA/rjDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2MSXibyI4F1wa2DMpSeOXaay0QDYDRF4eTAU0vyDFvUNsRO/H8YOV/iQsQUi6lpCnIR9Lw+BiDobgY4yg3KdunuCLZl/zjo2rlh5vN79gBhvJnFqMqC/GNXT4uaAaQlcohH82K9r7j/Q50zSfcttpeVOCL02YrSSDZ2fyoI9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cXB7wkFL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wMnFvbWqz9ropUMoiz6qWqM0+CHEQh7yRoQngEhXc1s=; b=cXB7wkFLBivDS3yBosTgcBVjU6
	lMPFx3K7BkWFhNLTa16uFn6XlZU0eHjss6Ee8gkUFIsapaHNiTK6YpSuHALbpfDhGYjj77gU4bMT9
	pU+GTrH25gyFcySYj67rPaKKI/ZJ7U5VzengieZwvzMk9jmn16Pv6McPaZKwbFfTaYyh9saZTLL3n
	WpiIp+LPfiahsmV19nxBYwB8bJSvJlVuOD+abV1ApyZu26RucMtFLZo+fLh0jIm4v6ga18+kb2Dk1
	FqZGGVAxFR/BjIR82IthqADcUKulfUiQJLcw7mEPBjAR3vOli2BxKdhib0ev/Ra/zJ+THUdNvIxs2
	8sVA23KA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sysq5-00000007dHZ-31rL;
	Thu, 10 Oct 2024 13:04:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 93A3030088D; Thu, 10 Oct 2024 15:04:21 +0200 (CEST)
Date: Thu, 10 Oct 2024 15:04:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alice Ryhl <aliceryhl@google.com>,
	Matthew Maurer <mmaurer@google.com>,
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
Message-ID: <20241010130421.GG17263@noisy.programming.kicks-ass.net>
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
 <ZwbAvEnrzu6UUgGl@J2N7QTR9R3>
 <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
 <ZwewMw8jBh6OU-L_@J2N7QTR9R3>
 <20241010110344.GL14587@noisy.programming.kicks-ass.net>
 <20241010113748.GL33184@noisy.programming.kicks-ass.net>
 <CANiq72=kT9RFcQ3h5U+wAY0pDQQqGU7BTtiPJ-oiHNUG00z3=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=kT9RFcQ3h5U+wAY0pDQQqGU7BTtiPJ-oiHNUG00z3=w@mail.gmail.com>

On Thu, Oct 10, 2024 at 01:44:14PM +0200, Miguel Ojeda wrote:
> On Thu, Oct 10, 2024 at 1:37 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > So much for the debian 'rust-all' package actually including all. Thanks
> > Boqun for telling me about the rustavailable make target.
> 
> Yeah, `rust-all` does not seem to include `bindgen`, which I guess was
> the issue (?).

Also not rust-src, because for some reason you're not actually
freestanding :/

> I guess you have it working now, but for the next time / others, we
> have the `apt` line for Debian at
> https://docs.kernel.org/rust/quick-start.html#debian.

Yeah, but then you have to first know that we have this file to begin
with.

