Return-Path: <linux-kernel+bounces-527309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C67A4097B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E597A824D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B4D19D092;
	Sat, 22 Feb 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uxCA2qTa"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567814F9D6
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237717; cv=none; b=o9heOIukg6O7QbEYWTNtfxQb6AF6JTmyeNIJWSQ9bmBSESDjy0YNVwE668E+V5ZRFnjLyDix7npSkj5YK7ydJlqfAn3hME55nHYNL+LxAWUPs8MNTdkC/gNG0lUhxR0yIVWGBSDxGOvv96cIRHc04G5TD/sGdL3Pe5IVNmFrSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237717; c=relaxed/simple;
	bh=0RQL9RDIa/a10b73LeMPQ07MYqfKsWcK7om94Ma9j3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhAviawx78cKCnNIQ0sZpm/Wj6z2bUlpSikbtA+KRKL6JR5INhczdR9PGQkpZ/qkYD+OZgsGF0bb919ugozwQl7G4ZAW96e2IJsDSQQ/uwJ/B3/wTZ9adffqsTKSs4zrTeChpSgvPXbjSNMiBYEImKuxKE2RJ3TyXg5Wrub01sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uxCA2qTa; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 10:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740237703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFVisseoGUDFJLItKPqXUKJ5q5lMT6Dx6imnkdSreQQ=;
	b=uxCA2qTaWEvAo6Je5Wz2xpLD1bnSSDYfoDlgUibR4iU6QvfC+u/WpcluUiwtubAJXRD8M1
	wO82fMVIdNVg4w2op6nHJLmasIHInjEh0AtCgmOBcqLIoVxdScd1v++stszLZT+UwOsTct
	Nto0UaYnfI+tHSgDb6+UpIj7NRD3bw4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <nptg4kade7gjjggphsbltu6t42wpqhppvgmraezcuhqvt2plnw@pjgwgwtmwovs>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <785A9F60-F687-41DE-A116-34E37F5B407A@zytor.com>
 <CANiq72nwouotAqJh_cm=9RG3Ns4wxX0LWXcVwp_bswE29kCrYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nwouotAqJh_cm=9RG3Ns4wxX0LWXcVwp_bswE29kCrYA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 21, 2025 at 12:42:46AM +0100, Miguel Ojeda wrote:
> On Wed, Feb 19, 2025 at 8:34 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > a. The apparent vast gap in maturity required of Rust versus C. What is our maturity policy going to be? Otherwise we are putting a lot of burden on C maintainers which is effectively wasted of the kernel configuration pulls in even one line of Rust.
> >
> > This is particularly toxic given the "no parallel code" claimed in this policy document (which really needs references if it is to be taken seriously; as written, it looks like a specific opinion.)
> 
> There is no "no parallel code" in the document, and I would like a
> clarification on what you mean by "toxic" here.
> 
> I tried really hard to avoid misrepresenting anything, and the
> document explicitly mentions at the top that this is our
> understanding, and that the policy could change depending on what key
> maintainers and the community discuss. (If it is put into the kernel
> tree, then that solves that.).
> 
> Anyway, I can only guess you are referring to the "Are duplicated
> C/Rust drivers allowed?" point. If so, since you want references, here
> is one:
> 
>     No, don't do that, it's horrid and we have been down that road in the
>     past and we don't want to do it again.  One driver per device please.
> 
>     https://lore.kernel.org/rust-for-linux/2023091349-hazelnut-espionage-4f2b@gregkh/

I think we need a more nuanced rule there.

When you're rolling out something new of a nontrivial size, you always
want to stage the release. You don't want everyone to start using
10k-100k lines of new code at once, you want it to first hit your power
users that can debug - and maybe the new thing isn't feature complete
yet.

If a big driver is being rewritten in Rust (e.g. if we went all the way
with the nvme driver; that was one of the first prototypes) I would want
and expect that we ship both in parallel for a few cycles and make sure
the new one is working for everyone before deleting the old one.

And tends to be what we do in practice, where appropriate. blk-mq was
incrementally rolled out. No one's even contemplating ripping out
fs/aio.c and replacing it with an io_uring wrapper.

Wholesale rewrites of entire subsystems in the kernel are rare (because
we can refactor), but with Rust we'll be seeing more and more of that -
because most of the really tricky safety sandmines do occur at FFI
boundaries.

