Return-Path: <linux-kernel+bounces-527244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17719A408D0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9887716A0F7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D113137C37;
	Sat, 22 Feb 2025 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1MFNhuq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82F1F5EA
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740232194; cv=none; b=RGeyH/EdFvhlv4T870L+TboCOq1msk7u/SgPtxNMHKkLaPL9+6O7cQ4Hffqvy9JmDk5GYSdtvlUP9L1xcAsBFWZNPiqXnpFawp7W0KPM/qMLhFEdgfFquk65kyqTDfsrlf4RKSvBdSEvsDyV8BswRsT0Pi/uoEKtJ4BQfKUXXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740232194; c=relaxed/simple;
	bh=VposXv0Ap7G54Q5mhaCAseLW8Esk1U9gJmZoNAIYLWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXpTUO8TgepsuUcSz6LrGwr/Umz3uThLOpgyrBSKSYUy907LdJlU2jrhQuHZfMW8ze+hbvKE3zXv2cmh2iT/a+UTQo/E/lNQigg/I/Ptkl3HrHY24/LAmeExYJtZrLU5wckdtVCe0I78AvNezOVjkEUF/A6tOdTW+X0L1B1NE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1MFNhuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B208C4CED1;
	Sat, 22 Feb 2025 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740232193;
	bh=VposXv0Ap7G54Q5mhaCAseLW8Esk1U9gJmZoNAIYLWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1MFNhuqlszHqu1Mp0512tim5Hknt+uJ2QA5xDsl30rkuUzuWUL5dyDfqNZXmKJpN
	 mv8AzheuE/jA61Dxs8/6GGSjmOSNLtOK8xPcNNTyRwsqyhN2rpc+SjaR4Ti/P+evYg
	 sXYkZTub6ul8uypyMi5Kn5l/5TjT8pGPvz6F+Y3q3VqusfUqhkAQyBkH18ejaYLBpi
	 6Py5BL4hU179V4noB6akNleAb4h0bDiLFUN/M++8VnfVZaxuFuzNWn9iAUi1f+NG7B
	 fp7z1nFRwGguSThKKWSdCGUNafG8noab6sXuQoHvkRqhSi0mtuKd3EbPh3eQxBMWii
	 Uiv4mQQPcIuiQ==
Date: Sat, 22 Feb 2025 14:49:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [RFC PATCH 1/2] x86/relocs: Improve diagnostic for rejected
 absolute references
Message-ID: <Z7nV-CBlYKzA8ROV@gmail.com>
References: <20250127114334.1045857-4-ardb+git@google.com>
 <20250127114334.1045857-5-ardb+git@google.com>
 <CAHk-=wgD1TGxZPC0yoiVJb3qDN9vDpzNkcW1z17+6mk_Rh+iFg@mail.gmail.com>
 <CAMj1kXGfgxBM5DJ6vwwGvqPs9hH57h-G4w=-bF51+7cckayPGA@mail.gmail.com>
 <Z6CPFv_ye8aSf320@gmail.com>
 <CAMj1kXHi63vHS7EuZE-frb-nf8P9RV=dPyFR+UU9=NaCHvP=MA@mail.gmail.com>
 <Z7m8i8YC7Mltqcpz@gmail.com>
 <Z7m8-4X0DnPVn-SZ@gmail.com>
 <CAMj1kXHu6yUXoGQJCqfZyBeyvSQ+8k9QEQgJJb1au3P76851Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHu6yUXoGQJCqfZyBeyvSQ+8k9QEQgJJb1au3P76851Bg@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Sat, 22 Feb 2025 at 13:03, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> > > So after another 2 weeks there's been no new upstream regressions I'm
> > > aware of, so - knock on wood - it seems we can leave the die() in
> > > place?
> > >
> > > But could we perhaps make it more debuggable, should it trigger -
> > > such as not removing the relevant object file and improving the
> > > message? I.e. make the build failure experience Linus had somewhat
> > > more palatable...
> >
> > For example, the new message is far better, even when combined with a
> > die() build failure:
> >
> > -                       die("Absolute reference to symbol '%s' not permitted in .head.text\n",
> > -                           symname);
> > -                       break;
> > +                       fprintf(stderr,
> > +                               "Absolute reference to symbol '%s+0x%lx' detected in .head.text (0x%lx).\n"
> > +                               "This kernel might not boot.\n",
> > +                               symname, rel->r_addend, offset);
> >
> > as it points out that the underlying bug might result in an unbootable
> > kernel image. So the user at least knows what the pain is about ...
> >
> 
> Ultimately, it is the die() that results in vmlinux to be deleted. And
> this is actually a result of the slightly dubious way the
> Makefile.postlink logic works: usually, artifacts are created once by
> the Makefile rule that defines how they are built, and if that rule
> fails, no output is produced but the input is preserved. In the
> vmlinux case, the file is modified by a separate rule that executes
> Makefile.postlink in an entirely separate make invocation, which
> splits off the static ELF relocations, using vmlinux both as input and
> output.
> 
> I can have a stab at fixing that instead. That way, we can use the
> improved diagnostic message, and leave the die() in place without it
> resulting in vmlinux to be deleted.

This sounds like the right approach to me too!

Thanks,

	Ingo

