Return-Path: <linux-kernel+bounces-537261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDC8A489C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2623B7D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C30827128D;
	Thu, 27 Feb 2025 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GK4Upe8C"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4FC270EC8;
	Thu, 27 Feb 2025 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687759; cv=none; b=IpAnIrPQiEwAOtiiyw3cpJHuMGovVxOW2yEaMgMwOiR1ou43Dy7LI9BhfHFCNAtirVaxb5sBFWfMDMI4DQjYxYee7BCujhokjmk2p1Ql9ovDAalW8eHQ7MqyJlBUUDC83a9FPadoFuZa5j+mgKSiT00mewllsv39AKxCsOJGPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687759; c=relaxed/simple;
	bh=Z45gVQ4/BABMAcmaZRNbhdljY9rJArAfbJeSWnupnBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ/ODKZTzonr/h0TP9iCucGMrrf1FDAMWw1OWNtqQUyPv0N1GahZZ6fhmfPSdNwJXKjgH0b7nQ8eIELOyvBGuoINqYY3IeflY9E42WsVqXGfl4woiszq1CYBgrV5ue6xlZcbVgU0ChA98zzoatXZiHmEktZCN6TJxRfcYabG/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GK4Upe8C; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 15:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740687745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tz5EMPUuI0z3mw5DewhU8kCZLZpqxg/IrSCMDsH6iFk=;
	b=GK4Upe8CRG7OxybdDSfj6SG9Fu4bLkhzWVZopKoOwXkXD4H07gvV0FhgT4SKjz4XTSc2c6
	RnGwlRcet54s8kn75q24aGfZaJl2jKv6/+7exTxVN3lTapKE4niV9XjsAySa/copwsFTmy
	moakBqBwbeG2PkwslHMdF/JTAcoviJA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Ralf Jung <post@ralfj.de>
Cc: Ventura Jack <venturajack85@gmail.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, torvalds@linux-foundation.org, 
	airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <rps5yviwyghhalaqmib3seqj62efzweixiqwb5wglzor4gk75n@oxki5lhsvhrf>
References: <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
 <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
 <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
 <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
 <d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de>
 <CAFJgqgQ=dJk7Jte-aaB55_CznDEnSVcy+tEh83BwmrMVvOpUgQ@mail.gmail.com>
 <651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 08:45:09PM +0100, Ralf Jung wrote:
> Hi,
> 
> > > > If C was willing to break code as much as Rust, it would be easier to
> > > > clean up C.
> > > 
> > > Is that true? Gcc updates do break code.
> > 
> > Surely not as much as Rust, right? From what I hear from users
> > of Rust and of C, some Rust developers complain about
> > Rust breaking a lot and being unstable, while I instead
> > hear complaints about C and C++ being unwilling to break
> > compatibility.
> 
> Stable Rust code hardly ever breaks on a compiler update. I don't know which
> users you are talking about here, and it's hard to reply anything concrete
> to such a vague claim that you are making here. I also "hear" lots of
> things, but we shouldn't treat hear-say as facts.
> *Nightly* Rust features do break regularly, but nobody has any right to
> complain about that -- nightly Rust is the playground for experimenting with
> features that we know are no ready yet.

It's also less important to avoid ever breaking working code than it was
20 years ago: more of the code we care about is open source, everyone is
using source control, and with so much code on crates.io it's now
possible to check what the potential impact would be.

This is a good thing as long as it's done judiciously, to evolve the
language towards stronger semantics and fix safety issues in the
cleanest way when found.

