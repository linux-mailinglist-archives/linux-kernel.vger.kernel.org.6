Return-Path: <linux-kernel+bounces-350784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C899909AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A37C2836FD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D631CACFA;
	Fri,  4 Oct 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu3xVSIQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2A1C7292
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060415; cv=none; b=NqqO1Js/Qx20yc5iHAC/Cjfee6s9xRGSOp/ww+1aMfCsxO8wjvN1zysuuJ/zfCo6+4WH1FwE0rm6MNCDwMbC3sbSr7r43tLt5chGjIWvd/1Qpit7yi2xKUcy4kW47s4s9MhZR68MLW+KdpyfnljpY00+qG51EVs0BS3ogvsy+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060415; c=relaxed/simple;
	bh=dR5/c0X4960a3eI5xG02YfeHuzOKUkBij6GDWKs7scI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otThWerVR+hItmDSaaRxpzP5lqh6w1dn3wm4JNOO0WcFS6GIKmYp66vyjzd+/N+HRaJ6hXPikP8tr6nCQC54q1C/Pf65cqwIO8XZWxWIS+uJkoZpxBQSTH+KzQ6KTsL3GL8j3P7XhZiWIUIq0B1Vo4D95MlJh6sxyMtzNH4v7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu3xVSIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CC0C4CEC6;
	Fri,  4 Oct 2024 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728060414;
	bh=dR5/c0X4960a3eI5xG02YfeHuzOKUkBij6GDWKs7scI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uu3xVSIQr5W8M6NXpTGWUqBQi2OpJ2sPs/cUoHuYSaZQ0DnnPvqGFDldShKmmphm2
	 S93nAqhGzIZaODnqRVkqLd3Nt78YvNY3nDV7Wy3JfckbxeeOc3AFfxMKWQzYf+QVRQ
	 ALJq8vs6KKJI+ficR0BYEvdyYdxqUIb0gXoY+aPJ/pOLYDCzikOli+HIJkgewivrUR
	 +2ictQE7mghB4WP925Ew/LsSqmDm5Xe5ajbmPYhP4eitgNrMTf0zlQIqvOAfkZ4kp2
	 +w3zhPvRpqL/PNNDTxkQq5eRFFeTauSEbMAA87T/2r2gg5XRHvrgwuBa4f2D5Si3r+
	 Piig1hQ6lU+Kg==
Date: Fri, 4 Oct 2024 09:46:53 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Detect non-relocated text references
Message-ID: <20241004164653.wntzsvsdd27pbcsw@treble>
References: <05fd690797ea4e1ee798b7fa497857519ae840d4.1728001850.git.jpoimboe@kernel.org>
 <CAMj1kXHt3GTVx-Ow0OZaP4WW7k=RVc+jgtC-4qOSZM3js4jo0g@mail.gmail.com>
 <20241004072847.zihm6dw7y5m4e2lb@treble>
 <20241004082029.GG18071@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004082029.GG18071@noisy.programming.kicks-ass.net>

On Fri, Oct 04, 2024 at 10:20:29AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 04, 2024 at 12:28:47AM -0700, Josh Poimboeuf wrote:
> > On Fri, Oct 04, 2024 at 08:54:16AM +0200, Ard Biesheuvel wrote:
> > > On Fri, 4 Oct 2024 at 02:31, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > > However there are some "lea xxx(%rip)" cases which don't use relocations
> > > > because they're referencing code in the same translation unit.
> > > 
> > > input section
> > 
> > "in the same translation unit and section" ?
> > 
> > > > However if we enable -fpie, the compiler would start generating them and
> > > > there would definitely be bugs in the IBT sealing.
> > > >
> > > 
> > > -fpie is guaranteed to break things, but even without it, Clang may
> > > issue RIP-relative LEA instructions (or LLD when it performs
> > > relaxations), so this is definitely worth addressing even if we don't
> > > enable -fpie.
> > 
> > I haven't seen this with Clang either.  Also, objtool runs before the
> > linker so LLD relaxations shouldn't matter.
> 
> LTO might have a few more cases, the input sections are bigger there.
> But even there we run before the final link stage.

Clang LTO uses -ffunction-sections so it shouldn't be possible.

-- 
Josh

