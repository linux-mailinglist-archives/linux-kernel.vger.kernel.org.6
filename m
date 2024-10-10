Return-Path: <linux-kernel+bounces-358831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E7399845C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8991C21492
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BC81C2336;
	Thu, 10 Oct 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jhJjvP3D"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191B29AF;
	Thu, 10 Oct 2024 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558233; cv=none; b=nInJC64wWy8xZRI6MWGx57KnWzniIA4FVoifUUha1K83s0KI1MkwrZp2CnsW4sOG8E1GOQZshQoLU+oU7H2spLmTOtYRBRsDzeFpWwBBImLgvkODDCb/jP3tWC2RVhcAMgWN3aA52mADfZtzpwY1SvrdUCRpvNKpZpW9QLWexTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558233; c=relaxed/simple;
	bh=DYvkZ2vUGSAZbVyOfVMNm2kuUZQ1E+txfCU8aXfYNEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFq55wPk38SoeCIs7sJfLx/qyBa6a4gGEwstSgBv3GEjujf01z8yA5M5vhYTBUKtdyWDlo+aXwidp05k+jFe2uXQsvslNmr5AziXBwXVpdOglm8d/lZuzZJUoqZfcniQXeNBjxgTybolnt7L2IpEZ8VbelIlbKvrRXqyO4luYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jhJjvP3D; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DYvkZ2vUGSAZbVyOfVMNm2kuUZQ1E+txfCU8aXfYNEM=; b=jhJjvP3DbEkCBmzUl3hpIVmzms
	mpT9IUEnM1KI0iW40ApHc531hjmlNo1agLYtYU4xcixTpF6gQDomNRgHE+yawTHq/xkfw5odBa1fN
	S2VFTgh1mobq7kXEeJmBtA//bFrJr8e4A34lOx3NsVJh0Z6Dfn35ypEXXUVlwJhdCS/rCJSxAiB5b
	d0fpFO94SMjQ2YSvxxsSX/6BssJA2eB4T0OFebLSENQoo7EOu/fE5A0cWXCBONata2FTBvM+4TT5T
	G5New8Zv7CWIOjCyrn8REp8vgM9wcPk/HRlzt3L2O8VWFON7CGqkHCbmpRAIBfOUGvCK9+Rtk+/pN
	2RBO6UnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syqxM-00000007S3m-2zmd;
	Thu, 10 Oct 2024 11:03:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4DF9930088D; Thu, 10 Oct 2024 13:03:44 +0200 (CEST)
Date: Thu, 10 Oct 2024 13:03:44 +0200
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
Message-ID: <20241010110344.GL14587@noisy.programming.kicks-ass.net>
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
 <ZwbAvEnrzu6UUgGl@J2N7QTR9R3>
 <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
 <ZwewMw8jBh6OU-L_@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwewMw8jBh6OU-L_@J2N7QTR9R3>

On Thu, Oct 10, 2024 at 11:45:07AM +0100, Mark Rutland wrote:

> What happens on x86 for ftrace and rust?

I can't seem to enable CONFIG_RUST, so I can't tell you :/


