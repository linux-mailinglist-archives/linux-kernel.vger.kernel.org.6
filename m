Return-Path: <linux-kernel+bounces-281529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69494D7D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CB3282EFE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C1516133E;
	Fri,  9 Aug 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1+kkYuRF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CE6yzdfj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59881148823;
	Fri,  9 Aug 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233795; cv=none; b=Muq/bM1+6McEXs1k56x5Se0ejk7BqJ4rIUzoyXMvY02fm0wMwYjdI2c5+5p1uuj9ZPatXpMGaHVxVFDLQx3dwO8B3ZoOGJKLdfReSbZ2mgI4gDFGLAH12HnNxX5UESfh60yIDzaNLyx34BWCPVFDyEBJt+r6ICyOMam8i3PpbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233795; c=relaxed/simple;
	bh=LG8Ns60rkZ9TEGMvWXSzSwegnDK/QRz0oNQ4pvH+c/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DV6yqmti6tthSdUyGt+VvuFQh2w30XtlDWwoTbUj6QFfj2oFdKovCKSsPjzKNko5Dpiihte3qzUgs4u6jXgXPfZtuYlpBwdECa6y/wOrBPyKZXb4CzzWYJImDdtjt82cL68h0TU297/+oWVH9F9jIsv3gU1wbKu2N8bt2ZWxhLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1+kkYuRF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CE6yzdfj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723233792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SAenBF1tV06rGeHucatp5EtQEE3rHSANcRq/1fCXLc=;
	b=1+kkYuRFDPFoZ1EoGlgoMZFFDIeP5eU55vwXs84Wm73d1MiQZIK28ljZ0kWDCgFDcyFllw
	1098UhmFtAZ5XeyjBFDgHSAg3zeafhpMSelJH8UN17CSy2pk9mCgcgPOmwEvYH5srOUnsK
	Eycx1hj+pfm5UEEpnVmTsAug6nW+WinD+2gmuEqLhRnXVsuLq7U9TIAFW5XmSUg9mOEa/q
	QmSu7aN96LUyOQ8O5eAyYXnWtYFZejgtwyPFiaFl6rdfRVsrCZh3NjgORigaMtltKQpvIK
	A6SCBLk0vlOlLD8RprJRbeNinF+1CfjiZkVoQhFY3TOKUTCvQOw9ZG6G2RweIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723233792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SAenBF1tV06rGeHucatp5EtQEE3rHSANcRq/1fCXLc=;
	b=CE6yzdfjBNwz7TG7z1VJdGSbRYJhneuMxpyNAFBwBHJMG/itKESMire811flDMRs2Gih35
	ct6Ko1uMU1CSiOBA==
To: Miguel Ojeda <ojeda@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Masahiro Yamada <masahiroy@kernel.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda
 <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg
 <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Subject: Re: [PATCH v3 3/6] x86/rust: support MITIGATION_RETHUNK
In-Reply-To: <20240725183325.122827-4-ojeda@kernel.org>
References: <20240725183325.122827-1-ojeda@kernel.org>
 <20240725183325.122827-4-ojeda@kernel.org>
Date: Fri, 09 Aug 2024 22:03:11 +0200
Message-ID: <87bk21tqf4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 25 2024 at 20:33, Miguel Ojeda wrote:
> The Rust compiler added support for `-Zfunction-return=thunk-extern` [1]
> in 1.76.0 [2], i.e. the equivalent of `-mfunction-return=thunk-extern`.
> Thus add support for `MITIGATION_RETHUNK`.
>
> Without this, `objtool` would warn if enabled for Rust and already warns
> under IBT builds, e.g.:
>
>     samples/rust/rust_print.o: warning: objtool:
>     _R...init+0xa5c: 'naked' return found in RETHUNK build
>
> Link: https://github.com/rust-lang/rust/issues/116853 [1]
> Link: https://github.com/rust-lang/rust/pull/116892 [2]
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

