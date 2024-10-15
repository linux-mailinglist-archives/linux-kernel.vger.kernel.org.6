Return-Path: <linux-kernel+bounces-365379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B0C99E178
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085F91C20F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80EC1CFED9;
	Tue, 15 Oct 2024 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck5P7Vw2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079091CC8B1;
	Tue, 15 Oct 2024 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982039; cv=none; b=hrVtUV3UQ7l4vYhbZ/LX91q1eCuV/1o98gjuib+G2lsYHQMIo7yK+xIfS990t9kIuEW2rchs+6zIL+oGyeoP7eD6T3QkFKJpfGX6qrmqNUtIXwe6IXCdPPTg0UUfJaZyOKJARZ0MaKT5qIMPNMj69vjr8p1dDcRK1xQLyhjjm4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982039; c=relaxed/simple;
	bh=GSyH1y44mWS97cSZ26SGIRn8xE87mpkD/PDkcLOGKQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RemlK7z5skSnJTez47f/kuQ++GBUg3bUXjk82YLX4g5F0AHQqzfBjXdeCUui2ktU83mw5CzCLOUdevA4Fot6Md2pN9gFqsiR/CaCUlzibtwRi6igUh4m4ETV3k1rW3EZXCSlhwUJQFE2QWDEgoEnjUmlrQ9MekQAprfTxeHLL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck5P7Vw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7265FC4CEC7;
	Tue, 15 Oct 2024 08:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728982037;
	bh=GSyH1y44mWS97cSZ26SGIRn8xE87mpkD/PDkcLOGKQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ck5P7Vw2PAigQOtG4ojaNsD2l8NyFMxB91eLFVrszA+pYRZfnTRoallMY9J9W42dS
	 Ll2SRpXaNFhpB4e6QjMjwyZ30ugvUT3iale79Msj/DI4NQjdaFq73BEwgTDNH1m2M7
	 p+75V0Ao2Bb7fBPqL4NzbI+QhJvmQA5UAo9+HiSYaMTQa5a5gJPYr6hbQ/Viq/tEtO
	 D3U/0XTFhIgjCUDzirTYzAzo44nT/b4uG2SPQtq6ftn9zYRKnsmXFYpJrpYEdxvFdA
	 xvbqbSBq/QLnXUexWIGDiDRLHbySI+iNJ7aiU1TQPnd8wgb8WNq3FJRy7cmqU6ymSH
	 JyTX7n9IocinQ==
Date: Tue, 15 Oct 2024 01:47:14 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Aleksei Vetrov <vvvvvv@google.com>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, llvm@lists.linux.dev
Subject: Re: [PATCH] mm/vmstat: Fix -Wenum-enum-conversion warning in vmstat.h
Message-ID: <20241015084714.GA1546610@thelio-3990X>
References: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>
 <ZwRA9SOcOjjLJcpi@google.com>
 <20241008005136.GA241099@thelio-3990X>
 <ZwevGZHiXOBqoslA@google.com>
 <a2e8a76a-9fad-4e3e-bce1-bf8a9d180464@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2e8a76a-9fad-4e3e-bce1-bf8a9d180464@app.fastmail.com>

On Fri, Oct 11, 2024 at 02:05:00PM +0000, Arnd Bergmann wrote:
> I'm fairly sure I saw users mix up 'dma_data_direction' with
> 'dma_transfer_direction' and unrelated enum-enum mixups in
> amdgpu. There were probably more.

Yes, those have definitely happened but those are -Wenum-conversion, not
-Wenum-enum-conversion.

> I think what happened is that in clang-18 and earlier, the
> warning option caught mistakes of passing the wrong enum 
> to a function and a few others, but it did not catch arithmetic
> operations between enums, so clang-19 now produces a lot more
> output than older versions, and I don't think we can
> control those independently.

A contrived example: https://godbolt.org/z/Ydx6rxsvb

We should be able to disable -Wenum-enum-conversion without impacting
the ability to catch the cases that you mentioned above. It also helps
that GCC supports -Wenum-conversion, but it does not seem like they have
an equivalent for -Wenum-enum-conversion.

Cheers,
Nathan

