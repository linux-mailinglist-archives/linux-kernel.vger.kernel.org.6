Return-Path: <linux-kernel+bounces-226514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEC5913F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7187EB21770
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6C02107;
	Mon, 24 Jun 2024 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i9qXaJFI"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DF710E9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719188832; cv=none; b=i0XJO4UWzrbym4UGw+/PAy3Zy1VCL/6D514mlay8DpxMc7BjfmZhACcecB8cuCwa5KuqyTn6ltq08UqmpxqlfJ7vQ9hAiCoa7Jy5EVfrgI0QY/j6ogYHH+z0K5xWnWDjAJ9lvbc2FjUoVb+JpZQV1IzLIp6cVi3JBTmgKJEj5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719188832; c=relaxed/simple;
	bh=52OxxuazX+R/Vnm0vYC5sNNoL62RwHytLf89hQ79Yng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdJKkVx4TMwna5Q9kAEu71T7LP2WfmrqeTDOci91+pmKFPksmU3f51/MvyvTbOYzHTY3th5Bdz7zrN4gfprGln2RSVs0lpzCREH5UgmGvh2RMb9GKJDQ//CV2X8eGbNQzwC2LZqz8gZOqUgdGHn7YajhR8m8wwPQtAylwl4/W0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i9qXaJFI; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tglx@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719188826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sfBODeRMCmHf0D59NB4VFxImeuRpP9l3RcbtejptEbM=;
	b=i9qXaJFIM037T4xJ2YTfT/z1sFypaAX41vPyefFqjROA2U0FvkOU9mjNkciQ+op4EqykLT
	mXQVlR/F/JG53YyNBNkOu22V26tWM/DuU/lfe/t904NMtmelY1lrxVWT1RJiJtZK0tCADG
	ZrZYAJXQzjiO0WmGgTM6fRvtKpKVbQM=
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: brauner@kernel.org
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: bernd.schubert@fastmail.fm
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: josef@toxicpanda.com
Date: Sun, 23 Jun 2024 20:27:02 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, linux-mm@kvack.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/5] fs: sys_ringbuffer
Message-ID: <imwmkwctn3req47oreiyyfw5s2o6o656utadjmu4w7f2thqjhs@ho5ifk5wlkqt>
References: <20240603003306.2030491-1-kent.overstreet@linux.dev>
 <20240603003306.2030491-4-kent.overstreet@linux.dev>
 <87frt39ujz.ffs@tglx>
 <odohwdryb2yhzi5kzvlwv65kazbhzqyps6fzr2wukksdewukmr@gono7fdsth5d>
 <87a5jb9rnk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5jb9rnk.ffs@tglx>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 24, 2024 at 01:16:15AM +0200, Thomas Gleixner wrote:
> Kent!
> 
> On Sun, Jun 23 2024 at 18:21, Kent Overstreet wrote:
> > On Mon, Jun 24, 2024 at 12:13:36AM +0200, Thomas Gleixner wrote:
> >> > +	/*
> >> > +	 * We use u32s because this type is shared between the kernel and
> >> > +	 * userspace - ulong/size_t won't work here, we might be 32bit userland
> >> > +	 * and 64 bit kernel, and u64 would be preferable (reduced probability
> >> > +	 * of ABA) but not all architectures can atomically read/write to a u64;
> >> > +	 * we need to avoid torn reads/writes.
> >> 
> >> union rbmagic {
> >> 	u64	__val64;
> >>         struct {
> >>                 // TOOTIRED: Add big/little endian voodoo
> >> 	        u32	__val32;
> >>                 u32	__unused;
> >>         };
> >> };
> >> 
> >> Plus a bunch of accessors which depend on BITS_PER_LONG, no?
> >
> > Not sure I follow?
> >
> > I know biendian machines exist, but I've never heard of both big and
> > little endian being used at the same time. Nor why we'd care about
> > BITS_PER_LONG? This just uses fixed size integer types.
> 
> Read your comment above. Ideally you want to use u64, right?
> 
> The problem is that you can't do this unconditionally because of 32-bit
> systems which do not support 64-bit atomics.
> 
> So a binary which is compiled for 32-bit might unconditionally want the
> 32-bit accessors. Ditto for 32-bit kernels.
> 
> The 64bit kernel where it runs on wants to utilize u64, right?
> 
> That's fortunately a unidirectional problem as 64-bit user space cannot
> run on a 32-bit kernel ever.

Ah! Yeah, that's slick.

Your code doesn't quite work though; with this scheme, we can't just
subtract the 64 bit head and tail to get the curretly used space in the
ringbuffer, that'll give the wrong answer if the other end is 32 bit.

But we just need to mask off the high 32 bits (after the subtract,
even), and we can still use the full 64 bits for ABA avoidance.

I think I like it...

