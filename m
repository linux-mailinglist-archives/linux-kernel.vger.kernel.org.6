Return-Path: <linux-kernel+bounces-527524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBDCA40C52
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C583B2472
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCED929A9;
	Sun, 23 Feb 2025 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VXa1MgMd"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CD136E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740269220; cv=none; b=qM9QPS8ZVWlAvPsWYAkmYZuK6YPZQk09ZqqoQg/q0VYWMKIHsf5qG/RmNAXcsQaqjCs3brEltQukzIRpWlJzOy/sbbk9M7Zq7Kj9omYtSfM7lCKulHgku26FMwqE0TjACNBe/MkzGDJxC7Ky9otdemLIGPjn4JhjDPsINT2ST0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740269220; c=relaxed/simple;
	bh=/lSSzPKxoAJu5DwXnJJ0A+YSVM3HiSpRukpgeNbo8ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYXFB7OR8YKtLZkDH/aQqGgWqTfwDvfmzlg9HvMlZuRl1mIFZL1Vyuv6lM/Ohquln44MZCZwMKtnfrJ/aTL4mpCqNBHkfH+3Ux7a2Aj2BweGj+S7/yNWhi5/t11daoAPVoOKE9tOZiMdn7zNK8zpZReaRs6jm5DoRjRPb2e7Olw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VXa1MgMd; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 19:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740269205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKTPTuyvyBhE8Bn0zpm823GERSVhnC8VUl8s32U/kO8=;
	b=VXa1MgMdlh7qegY06eEfy9EPaZuGLIpOmyKN07NsWfv7TL947nYXBJlC6QApwKMeRMEdS/
	yBwGfsrfWriCvExugJsErsQeDghAb9lKeDCeZ85KBABcUkepv8S6iK6OrRgmMvcGVgB8M0
	J01mUa7uNiaKe2sZD3z6kGN3BC1mW60=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <p3rj67s5hiqcfgneko5ktzxowmrbihdn5tsegjvfbeoc5e7bvs@yanurk7vardt>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <yuwkqfbunlymofpd4kpqmzpiwbxxxupyj57tl5hblf7vsvebhm@ljz6u26eg5ft>
 <6EFFB41B-9145-496E-8217-07AF404BE695@zytor.com>
 <c3spwcoq7j4fx5yg4l7njeiofhkaasbknze3byh4dl45yeacvr@rb6u6j5kz7oe>
 <B8A09E5A-D3A6-4A1F-94F6-9E301EE9BBE4@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B8A09E5A-D3A6-4A1F-94F6-9E301EE9BBE4@zytor.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 22, 2025 at 03:50:59PM -0800, H. Peter Anvin wrote:
> On February 22, 2025 1:22:08 PM PST, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >On Sat, Feb 22, 2025 at 12:54:31PM -0800, H. Peter Anvin wrote:
> >> VLIW and OoO might seem orthogonal, but they aren't – because they are
> >> trying to solve the same problem, combining them either means the OoO
> >> engine can't do a very good job because of false dependencies (if you
> >> are scheduling molecules) or you have to break them instructions down
> >> into atoms, at which point it is just a (often quite inefficient) RISC
> >> encoding. In short, VLIW *might* make sense when you are statically
> >> scheduling a known pipeline, but it is basically a dead end for
> >> evolution – so unless you can JIT your code for each new chip
> >> generation...
> >
> >JITing for each chip generation would be a part of any serious new VLIW
> >effort. It's plenty doable in the open source world and the gains are
> >too big to ignore.
> >
> >> But OoO still is more powerful, because it can do *dynamic*
> >> scheduling. A cache miss doesn't necessarily mean that you have to
> >> stop the entire machine, for example.
> >
> >Power hungry and prone to information leaks, though.
> >
> 
> I think I know a thing or two about JITting for VLIW..  and so does someone else in this thread ;)

Yeah, you guys going to share? :)

The Transmeta experience does seem entirely relevant, but it's hard to
tell if you and Linus are down on it because of any particular insights
into VLIW, or because that was a bad time to be going up against Intel.
And the "unrestricted pointer aliasing" issues would've directly
affected you, recompiling x86 machine code, so if anyone's seen numbers
on that it's you guys.

But it was always known (at least by the Itanium guys) that for VLIW to
work it'd need help from the compiler guys, and when you're recompiling
machine code that's right out. But then you might've had some fun jit
tricks to make up for that...

