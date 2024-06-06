Return-Path: <linux-kernel+bounces-204952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C38FF56C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C3E287FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D636E610;
	Thu,  6 Jun 2024 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a735HSmi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012D3BBCC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703127; cv=none; b=siKe7KqrnNrGHJxPHqCSKaNxdBWoKRoCYGQPUFCwIiwRJVn0OmuAQryIwYwNvM+VzgkMsrQyEnBmU4luEO11+ytDsSGlzFkz+odWrJeyyDZjaanNj01/SThDd4uMIGNPgqY41Ul5lI8YL2/Eljqe+QcaAtj/KWqVfiALnqPnprM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703127; c=relaxed/simple;
	bh=U8mfA5xA+fMcGi1rZTOg42lZRg/R+N+3UrY82wiZ9HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFbf1gRm5it5GB7h27JQL0BNRuWW2PNEer5kOYa7sO53abGfCLmTs5fOqka43pbTti3rYV/oyRIcqghbnoFRFKSpEcX1apxgjYoVPACkwlLrx3Aef3oWwjSqcGg7A9FfS4OBMMq4c74XB0ajJyrtzgfoKLjHW5x9mRso0cp89ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a735HSmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7853C2BD10;
	Thu,  6 Jun 2024 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717703126;
	bh=U8mfA5xA+fMcGi1rZTOg42lZRg/R+N+3UrY82wiZ9HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a735HSmizNNfAG+BGmyIGYKEB413vbi/u18+ryWD8ufj48Ss47wWfFaXsUfgU5Jun
	 QK6uXHzIT/Rvr4mvA6UZCzMobnuqbk6MndYh010Q8gR/HsJXAKD1NYq2O2APJEwW2d
	 ywppjix2iJkh8qc8zENNKaSjHdSprHUJf12988/QWF97Z24aYWYBs26AJtI2zHZFnz
	 e1XLh+97GWaEbX5o5CMS0Ip9OdvUJ0NB0uHz/IhDWAClM6tUMn5EeSiHiIMHkk/eyn
	 KjcKF3Oj1MhVdRGgmmDndGcZges6GwlzIYsyYQNEuiZheYRGmgda9AIG6s3sbEyCKE
	 lpFCTJZW2nrCg==
Date: Thu, 6 Jun 2024 12:45:25 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool query: section start/end symbols?
Message-ID: <20240606194525.cdnnidxurejsjtx4@treble>
References: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>

On Thu, Jun 06, 2024 at 11:42:40AM -0700, Linus Torvalds wrote:
> So this is related to my currently very ugly hack at
> 
>    https://lore.kernel.org/all/CAHk-=whFSz=usMPHHGAQBnJRVAFfuH4gFHtgyLe0YET75zYRzA@mail.gmail.com/
> 
> where I'm trying to do "runtime constants". That patch actually works,
> but it's flawed in many ways, and one of the ways it is flawed is that
> I really want to put the "this is the use for symbol X" in a section
> of its own for each X.
> 
> Now, creating the sections is trivial, that's not the problem. I'd
> just make the asm do
> 
>         ".pushsection .static_const." #sym ",\"a\"\n\t" \
>         ...
>         ".popsection"
> 
> and the linker script will just do
> 
>         KEEP(*(.static_const.*))
> 
> and I'm done. Nice individual sections for each of the runtime constant symbols.
> 
> However, for the fixup part, I then really want the section start and
> end addresses, so that I can iterate over those uses for a particular
> named symbol.

That should be trivial.  But ideally the interface would be less magical
and wouldn't need objtool to sprinkle any pixie dust.  Could it be
implemented similar to static keys by making the static const variable
an opaque structure instead of just a "normal" variable?

  DEFINE_STATIC_CONST(dentry_hashtable);

That could create something similar to 'struct static_key' which
correlates the const variable with all its use sites.

-- 
Josh

