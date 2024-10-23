Return-Path: <linux-kernel+bounces-377986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C449AC994
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1772D1F223D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E2F1AB6E9;
	Wed, 23 Oct 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAGgg5Le"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C581A0AEC;
	Wed, 23 Oct 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684922; cv=none; b=PrRHMqDd0zDuP0mRhpjlJLc0YxpCjDxLnpetxav/EvIzlbvzB6LJVHiCk8x21sLcPGf4M0PWHeaYaKopNZay31mXwRNDdN25ZdW0MkL2orUDrEFIxNRgU46wy9udtD/ZL/dypvrMbeUiV1c614jVpiqDZDP7Snc6OmNglKVy3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684922; c=relaxed/simple;
	bh=YVyxI9zNAkBvLFKPpoMb1qj8toKGLTB4Psq/rpM99gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeoxNbID49KSBSnq+MF385bBVaXEZzBz7/v0HF8IQk4QDd8nNfY/i8m65N4MNB768QKWMtaImB5H0nSMHQCKIGe6a2k8xbrGMfMdnGk5ZsX3jlbKKso6ZuDgWwJfSnQ4EBTqKvEYZcUrDEQTrWXfdr3WwQkQd5B+H+BYFN05O0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAGgg5Le; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BEAC4CEC6;
	Wed, 23 Oct 2024 12:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729684922;
	bh=YVyxI9zNAkBvLFKPpoMb1qj8toKGLTB4Psq/rpM99gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAGgg5LeHEXtyFY2LHADmjnajOLRMcjYqUepM+I++wwP0qee4ITD4qFMILsqzS66p
	 IKEDaCozhWrURldrGlUpSHVPNwpdcXMOiKaWWZ5b/jvwcX9qEETE57jHAAYR7H5ABQ
	 jt8spzIDp8jfaa1m9sxqOh+/V4nyplkGMDlofne6nAzE4fB1IORB4+ileP2DAEa/ll
	 K8xZ7b3esgDcr4ug9TSrqEQcQaEuXZvyWIJTsrzGB+Kpy2tc3c5lxuAuQdrBM/iW3S
	 5yfZKy/ZUCtLFApD5jiT17Qu+M0TcV6MCq9n34qB27EurVB4KKw2tjHIfgudwBptim
	 1CRl8lfr018Ew==
Date: Wed, 23 Oct 2024 14:01:56 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, aliceryhl@google.com,
	dakr@redhat.com, linux-kernel@vger.kernel.org, airlied@redhat.com,
	boqun.feng@gmail.com, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/5] Introduce Owned type and Ownable trait (was:
 "rust: page: Add support for vmalloc_to_page")
Message-ID: <ZxjltAbZmzbjXnKn@pollux>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <Zxitz41uPPeloK0o@pollux>
 <CANiq72nagKRUmHWVOFGNBuiVnqdmgqPm8b6ZtG1edobmrQMr3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nagKRUmHWVOFGNBuiVnqdmgqPm8b6ZtG1edobmrQMr3w@mail.gmail.com>

On Wed, Oct 23, 2024 at 11:51:47AM +0200, Miguel Ojeda wrote:
> On Wed, Oct 23, 2024 at 10:03 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > I wonder if it would make sense to make `CLIPPY=1` the default and only disable
> > it by explicitly passing `CLIPPY=0`.
> 
> That is what I wanted, but when I asked long ago to the Clippy
> maintainers if using `clippy-driver` was guaranteed to not affect
> codegen, the answer was no: for instance, optimization may be affected
> (at least back then), and the maintainers said the intention is that
> is not to be used for normal compiling. So I sent a PR to document
> that. See:
> 
>     https://github.com/rust-lang/rust-clippy/issues/8035
>     https://github.com/rust-lang/rust-clippy/pull/8037

That's pretty unfortunate, I didn't know.

I think for the long term it'd be good to find a way though. Once more and more
subsystems / people start adding Rust code, I could imagine patches to start
slipping through and fixing things up after it's been discovered in -next would
be painful.

> 
> Similarly, Christian proposed running `rustfmtcheck` unconditionally
> on build and offering a way to turn it off instead. I think that would
> be ideal too, but it could potentially lead to problems too, so I am
> not sure either; see e.g.:
> 
>     https://lore.kernel.org/rust-for-linux/CANiq72==AkkqCDaZMENQRg8cf4zdeHpTHwdWS3sZiFWm0vyJUA@mail.gmail.com/

Yeah, that's a tricky one; if not enabled by default I'd be a bit worried about
the same thing to happen as mentioned above.

Additionally, for development trees where things slipped through it'd be
annoying when `rustfmt` changes more stuff than expected.

> 
> So I wonder if we should instead go with a "dev mode" like `D=1` that
> enables Clippy, `rustfmtcheck`, `-Dwarnings` (even if `WERROR=n` and
> applying to everything, not just kernel objects,), potentially
> `rustdoc`-related warnings too, and whatever other tooling/checks in
> the future (e.g. klint), and not just for Rust but potentially for C
> and other bits too (e.g. `W=1`, some important subset of Coccinelle
> scripts...).

I think that'd be great for short / mid term, it'd make it much easier to ensure
that all relevant checks were executed and hence make it less likely for things
slip through.

For the long term, I think it'd be great to keep looking for ways to always
enable the clippy and format checks. Or at least the clippy ones if we're too
concerned about `rustfmt` to break.

> 
> That way, "normal builds" (i.e. those done by users) stay as
> fast/clean/warning-free/bug-free/optimized as possible even across
> compiler versions, potential bugs in the toolchain, etc. And I imagine
> it would be easier for newcomers, too.
> 
> Opinions welcome! I am happy to prepare an RFC, since it seems a few
> people would like something like that.
> 
> Cheers,
> Miguel
> 

