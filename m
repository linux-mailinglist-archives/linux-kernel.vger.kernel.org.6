Return-Path: <linux-kernel+bounces-537502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7878A48CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A0F87A829E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729BA272924;
	Thu, 27 Feb 2025 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ChcZOHPr"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D111EB194
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698338; cv=none; b=e1NZ3TnQE0IkdWP28whuBTIzh99xoq7/gOIX8s81HTWrungaIvJfwa/4PghcmNQQgt6HfjqBnWNBKnoUUXQmCei35RALkeFHNrqt7FibpAZPTBL4A1r9kB3sQgHqwplqAfDoBT7TuT0lGgRimNZqXKW6u57P7veUpRPSsZC8gQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698338; c=relaxed/simple;
	bh=2KNho80fRUQmyvFM4uum3byTlGYESRBfiUdgSNrDgpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITm1Ru0lLNGgE26YoE0yjP3K9pwI2Tgb+Ftdkjq/YfhmapCyghbArEMua3vzQrGX92Yxcn4p0KecKvltGpmTsgYx65KUdeq9iZJJ3w4+sq2zEyjmAfiXbjhh2LGPhFJj0ZfBW83s3P5oSz0ia8VpMgqcpYsBEQV3d96S6GqHTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ChcZOHPr; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 18:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740698324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Px9iU/bSTKRb95c4IADUmmmmBlA3gmjsTnQHWKRdExA=;
	b=ChcZOHPrfKwq3ks2zO3MP6ETkhbpBuF0UTuxyjWqRsyIUpFHP6Ov3tV7WLqfOlkQfmpY/W
	Dxy+6AY7NHIc5gvq1ciI3EStujR4KU6s8jkvcVgaunm6th1WvPY/6g1ejY+1uenytOfExQ
	U9K7bFU1WHAFU+OBLYZPxJ0Q+dj5J/k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ralf Jung <post@ralfj.de>, Ventura Jack <venturajack85@gmail.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, torvalds@linux-foundation.org, 
	airlied@gmail.com, boqun.feng@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <smghtqj4gnlo7dxo4t6u74c25e2qukhogsi5fysddputbuwbmg@lwuh2nipypqf>
References: <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
 <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
 <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
 <d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de>
 <CAFJgqgQ=dJk7Jte-aaB55_CznDEnSVcy+tEh83BwmrMVvOpUgQ@mail.gmail.com>
 <651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de>
 <rps5yviwyghhalaqmib3seqj62efzweixiqwb5wglzor4gk75n@oxki5lhsvhrf>
 <20250227221801.63371d19@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227221801.63371d19@pumpkin>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 10:18:01PM +0000, David Laight wrote:
> On Thu, 27 Feb 2025 15:22:20 -0500
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > On Thu, Feb 27, 2025 at 08:45:09PM +0100, Ralf Jung wrote:
> > > Hi,
> > >   
> > > > > > If C was willing to break code as much as Rust, it would be easier to
> > > > > > clean up C.  
> > > > > 
> > > > > Is that true? Gcc updates do break code.  
> > > > 
> > > > Surely not as much as Rust, right? From what I hear from users
> > > > of Rust and of C, some Rust developers complain about
> > > > Rust breaking a lot and being unstable, while I instead
> > > > hear complaints about C and C++ being unwilling to break
> > > > compatibility.  
> > > 
> > > Stable Rust code hardly ever breaks on a compiler update. I don't know which
> > > users you are talking about here, and it's hard to reply anything concrete
> > > to such a vague claim that you are making here. I also "hear" lots of
> > > things, but we shouldn't treat hear-say as facts.
> > > *Nightly* Rust features do break regularly, but nobody has any right to
> > > complain about that -- nightly Rust is the playground for experimenting with
> > > features that we know are no ready yet.  
> > 
> > It's also less important to avoid ever breaking working code than it was
> > 20 years ago: more of the code we care about is open source, everyone is
> > using source control, and with so much code on crates.io it's now
> > possible to check what the potential impact would be.
> 
> Do you really want to change something that would break the linux kernel?
> Even a compile-time breakage would be a PITA.
> And the kernel is small by comparison with some other projects.
> 
> Look at all the problems because python-3 was incompatible with python-2.
> You have to maintain compatibility.

Those were big breaks.

In rust there's only ever little, teeny tiny breaks to address soundness
issues, and they've been pretty small and localized.

If it did ever came up the kernel would be patched to fix in advance
whatever behaviour the compiler is being changed to fix (and that'd get
backported to stable trees as well, if necessary).

It's not likely to ever come up since we're not using stdlib, and they
won't want to break behaviour for us if at all possible.

