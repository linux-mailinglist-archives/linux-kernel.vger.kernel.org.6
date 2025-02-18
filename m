Return-Path: <linux-kernel+bounces-519814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D28F0A3A239
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A881897353
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E3326E176;
	Tue, 18 Feb 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vvXoi6Rq"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443C1779B8;
	Tue, 18 Feb 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894902; cv=none; b=i8TLY926CQlbtWoCA3q9NxUSRNnFc77ik3a0Gq3/eyu2lK1ZlKfxWPazrLkvekufqYai/l4Yb2whudi5/4dI4ugDUSevfGDlVrr3uhgr6TnNN8aaJ3oPYBbyG2Zvgn1WrPA+7ZFEXyePBb1olLy2SatgJE4Io1NxA8oDngLiZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894902; c=relaxed/simple;
	bh=Ar43CwdCRmCaVipaXBSUFI/s0uXR7F77JPuCLWSSxxY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=t62w51CvMu35KynOEQgvpM+RY14VfioJf1My/ihZ5RjQMZO/Hd/BTm/80zVPtUMmsjtjTzGkc5O8MZD+NHAYmJmCRMNzfCW7vEIHXq9BlCQYB2xNEalUBX3PcmIBcSiSB9gAh/44cjfi0qV3Kx5wt3Yu/4MS0xwezIQS9JINx34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vvXoi6Rq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=9ddc9DCFXCayEdKH/c7/U+it8NB/dGaAi7b6YfBjejI=; b=vvXoi6RqXVhrBN6uHS1FprrQAH
	l7jgjAOb541F+Ugf+i01Tve/HlgxTbcfIMYKDByozXAUBUi0sjRUxVMNuTbYO1VBLrdbVNan34Lr8
	72hiwWq90eGRj1LqbARnKZTbKWzI9DJ628c5uK3vFf4+2iJuAUAxFXkIyGkUP+eRVGuCDzWw/n38f
	NIdLMk5yy7gwBsnwHdJNqCCRUT6hH5ZCvWeNKnf3DxBQvuG1BdqLAYWSTd+6x+tZjULxAoCrR6lkD
	6/pUjf+VrlsoL0tP54EXJFOrgB5y1u9UGSiCianFjUXcKjYXYyeMBzxDvz/idG5+vlOruMNcvlNpY
	OQ9glKSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkQ8w-00000008tKN-2syO;
	Tue, 18 Feb 2025 16:08:18 +0000
Date: Tue, 18 Feb 2025 08:08:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <Z7SwcnUzjZYfuJ4-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Feb 09, 2025 at 09:56:35PM +0100, Miguel Ojeda wrote:
> Hi all,
> 
> Given the discussions in the last days, I decided to publish this page
> with what our understanding is:
> 
>     https://rust-for-linux.com/rust-kernel-policy
> 
> I hope it helps to clarify things. I intend to keep it updated as needed.

I don't think having a web page in any form is useful.  If you want it
to be valid it has to be in the kernel tree and widely agreed on.

It also states factually incorrect information.  E.g.

"Some subsystems may decide they do not want to have Rust code for the
time being, typically for bandwidth reasons. This is fine and expected."

while Linus in private said that he absolutely is going to merge Rust
code over a maintainers objection.  (He did so in private in case you
are looking for a reference).

So as of now, as a Linux developer or maintainer you must deal with
Rust if you want to or not.

Where Rust code doesn't just mean Rust code [1] - the bindings look
nothing like idiomatic Rust code, they are very different kind of beast
trying to bridge a huge semantic gap.  And they aren't doing that in a
few places, because they are showed into every little subsystem and
library right now.

So we'll have these bindings creep everywhere like a cancer and are
very quickly moving from a software project that allows for and strives
for global changes that improve the overall project to increasing
compartmentalization [2].  This turns Linux into a project written in
multiple languages with no clear guidelines what language is to be used
for where [3].  Even outside the bindings a lot of code isn't going to
be very idiomatic Rust due to kernel data structures that intrusive and
self referencing data structures like the ubiquitous linked lists.
Aren't we doing a disservice both to those trying to bring the existing
codebase into a better safer space and people doing systems programming
in Rust?

Having worked on codebase like that they are my worst nightmare, because
there is a constant churn of rewriting parts from language A to language
B because of reason X and then back because of reason Z.  And that is
without the usual "creative" Linux process of infighting maintainers.

I'd like to understand what the goal of this Rust "experiment" is:  If
we want to fix existing issues with memory safety we need to do that for
existing code and find ways to retrofit it.  A lot of work went into that
recently and we need much more.  But that also shows how core maintainers
are put off by trivial things like checking for integer overflows or
compiler enforced synchronization (as in the clang thread sanitizer).
How are we're going to bridge the gap between a part of the kernel that
is not even accepting relatively easy rules for improving safety vs
another one that enforces even strong rules.

If we just want to make writing drivers easier a new language for that
pushes even more work and increases the workload on the already
overworked people keeping the core infrastructure in shape.

So I don't think this policy document is very useful.  Right now the
rules is Linus can force you whatever he wants (it's his project
obviously) and I think he needs to spell that out including the
expectations for contributors very clearly.

For myself I can and do deal with Rust itself fine, I'd love bringing
the kernel into a more memory safe world, but dealing with an uncontrolled
multi-language codebase is a pretty sure way to get me to spend my
spare time on something else.  I've heard a few other folks mumble
something similar, but not everyone is quite as outspoken.


[1] I've written and worked on a fair bit of userspace Rust code, but
I'm not an expert by any means, so take this with a grain of salt

[2] The idea of drivers in eBPF as done by HID also really doesn't help
with that as much as I like eBPF for some use cases

[3] Unless Linus forces it onto your subsystem, or Dave decides anything
touching Nvidia hardware must be in Rust of course

