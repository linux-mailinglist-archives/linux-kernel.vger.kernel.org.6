Return-Path: <linux-kernel+bounces-360996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E851A99A22D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D431C234F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071BF2141B9;
	Fri, 11 Oct 2024 11:00:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9BE20CCFF;
	Fri, 11 Oct 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644415; cv=none; b=q9yfG+xZuZIsSqCxj/pfctVpwq0D8VyHA1vJzz4EVGuNCiATV34UJW2tReiRwVqNnbgJTSBDzAYZUNHHkxRiBrpgjHsyutK2ODDGa5Xd415kotsVIbiUXPnwk3LxX10/NkYbf0yaPHQYb0IRd7sBpNocuqP2gq+RMDodyYcGYwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644415; c=relaxed/simple;
	bh=RxdFfURp4DVVbggHDyIydBPy3bJ53n5Pq28zhpRzZn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab5MjC7DQ1h2HZmIPOkRy1JClbaw5KUTczIwXsJ3o6IBng2cnv292zoJaAZoKz8ZAJtaVyZEVOAPcXCHtvtq0IqGmvVkfwBFFqEYZen6QG9/LyPF7O2Zxhi/TMvfox/DeB0PKtP7pNOVzZosvdWqwylUrIrVIjhPgrtBdrdq9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7B40497;
	Fri, 11 Oct 2024 04:00:42 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49D773F73F;
	Fri, 11 Oct 2024 04:00:09 -0700 (PDT)
Date: Fri, 11 Oct 2024 12:00:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Matthew Maurer <mmaurer@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all
 architectures
Message-ID: <ZwkFNjPcmqqGPuEg@J2N7QTR9R3>
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
 <ZwbAvEnrzu6UUgGl@J2N7QTR9R3>
 <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
 <ZwewMw8jBh6OU-L_@J2N7QTR9R3>
 <CAH5fLgi_Dg_a+-+KfKgzoo0z8vF5h7JT9DrFccx9C80qitsg7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgi_Dg_a+-+KfKgzoo0z8vF5h7JT9DrFccx9C80qitsg7Q@mail.gmail.com>

On Thu, Oct 10, 2024 at 02:29:18PM +0200, Alice Ryhl wrote:
> On Thu, Oct 10, 2024 at 12:45 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > AFAICT at the moment this isn't necessary for CFI, so can we drop this
> > patch for now?
> 
> I'm okay with dropping this patch for now.

Cool; thanks!

Mark.

