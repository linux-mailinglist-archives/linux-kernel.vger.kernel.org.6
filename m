Return-Path: <linux-kernel+bounces-539547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60426A4A5BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C291A7A3E78
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C83F1DE4DC;
	Fri, 28 Feb 2025 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ldpreload.com header.i=@ldpreload.com header.b="k9256Um+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lAG6U0T+"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B48823F363;
	Fri, 28 Feb 2025 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780867; cv=none; b=Q0JN4m+PWxo0g8SF2cQKa2dBn/9BT+o5boVQae2VivS0iUOgnmYktzrvgwGuDvv8rW0newQYMYkZ6lXneuWoWh5w5xMG/CBgRxj7iC0fA0fGczZE2d21W7OmA9O1ArKpraWfjoUmzmWvheqiRIh9nTUT3Nmj/3GPQEC34WPfQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780867; c=relaxed/simple;
	bh=mNvEFEtW/fa5wrdClafbWeeXRslcK6meO8MAvKmIqY8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DEXxM9jLMfZNj50HbzlEyqO2LCYeiGnp2WFQvB2EKLGg86U4e5QnCSOeR7U3ydaLUbCqTGH1GhECG8ITAf2DFwWy8zQuR0kyDXnFC6+16nPxBnqWmkExtGmPGUgiGAkmvOdo3bd2gJnOnYsWPlV94/zHjDMFscbN+TLs5II1iTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ldpreload.com; spf=pass smtp.mailfrom=ldpreload.com; dkim=fail (0-bit key) header.d=ldpreload.com header.i=@ldpreload.com header.b=k9256Um+ reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lAG6U0T+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ldpreload.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ldpreload.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE0A325401AF;
	Fri, 28 Feb 2025 17:14:22 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-11.internal (MEProxy); Fri, 28 Feb 2025 17:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ldpreload.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=
	2016-12.pbsmtp; t=1740780862; x=1740867262; bh=gvS8nbGLHB7GVv/m5
	YUS0JEbKDjqKaspSnwPW5NgrbI=; b=k9256Um+1243F3Y8hJnKUmzeuH7n8ATwO
	lxe86vbmqm+P7dcoE6nOeLKW79tnc1H02NkswVXGhCOp4+ZBmsJisa7aFKNWDq1r
	liRwi2o/+eT/c3vzibqSu0MLbxoQnlodqsOSkOhaYshy62fzrPQcujEruW3iejk6
	vQ4xmBupBY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740780862; x=
	1740867262; bh=gvS8nbGLHB7GVv/m5YUS0JEbKDjqKaspSnwPW5NgrbI=; b=l
	AG6U0T+T9Z7G4Sae+hh9kIThYOjS1KOBbMQlORUwI4/0nJpBpgfKRbJGEopaPH4F
	FgbsvDVN2ik1Yn/loL5w7Bk3g/c0wme18ew9pAaBejtMhnEnmF8zQPJVhYYQ3pNq
	8lLmEJtSLvMeFNdpHfid8sAe9WjRILtRjSPVgU5O3FOp/gAcTFlHI+KqnOIk6V+x
	6ocaquUSFHTbrK/UpVsQdhih3lJDoAcp9IM88HLZ3JJYQfXcfwqPFAr0Fk9J6Yom
	b7GT2YOYYg5kT6Gho31+QcItv87zoJCAmudAAOQU59TwXyg5SvKHdks2H/2P/vMA
	+hlOUGkfUu9NPJtIxcUPQ==
X-ME-Sender: <xms:PTXCZzLuWc4cgmvP46umNVEl17bmOw0ys00bezSb_2dswus6-Cyohw>
    <xme:PTXCZ3JzWeJ-gj4JyJM_ql4JRp30oZsWdlGrR1CiZ12lSTw04e8Za86rslpCJSY0i
    G7srJ8pnY6QC6TnqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeludehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfivghofhhfrhgvhicuvfhhohhmrghsfdcuoehgvghofhhftheslh
    guphhrvghlohgrugdrtghomheqnecuggftrfgrthhtvghrnhepieefffehtdehffeftdff
    teegfeethfdvgfeguedtvddttdelgfejkeehtedtgedvnecuffhomhgrihhnpehgihhthh
    husgdrtghomhdpfhgvughorhgrphhrohhjvggtthdrohhrghdphigtohhmsghinhgrthho
    rhdrtghomhdpshhtrggtkhhovhgvrhhflhhofidrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgvghofhhftheslhguphhrvghlohgr
    ugdrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrihhrlhhivggu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesgh
    hmrghilhdrtghomhdprhgtphhtthhopehvvghnthhurhgrjhgrtghkkeehsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepvghjsehinhgrihdruggvpdhrtghpthhtohephhgthhesih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidq
    fhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:PTXCZ7vrRv5i-kF-uqer-uVXWDDLn3pF5024FaFcRXilTXKj8EINgg>
    <xmx:PTXCZ8bMQ7tzjpLIEuDLOoxGqgvWpWCth_k7p93r71PlOJOeJFJtWg>
    <xmx:PTXCZ6bYo1xZGtC3YNemMJ0mboj-4NpuHXRG-dFU0URzwsBm1X-ryQ>
    <xmx:PTXCZwD_VtTUDSs7LaMaj1umYShwgurbJO8WOECIpPy2f5hJyipZ5A>
    <xmx:PjXCZ2JHLb6AHgMPL7lR25pNtNN5eaxnfVqEmaVk83A0LdBJAcot_cuN>
Feedback-ID: ia7a14449:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E76D12E60088; Fri, 28 Feb 2025 17:14:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Feb 2025 17:13:57 -0500
From: "Geoffrey Thomas" <geofft@ldpreload.com>
To: "Ventura Jack" <venturajack85@gmail.com>
Cc: "Ralf Jung" <post@ralfj.de>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, torvalds@linux-foundation.org,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Message-Id: <09acd087-ba88-4b8e-950b-dfede2f8bec3@app.fastmail.com>
In-Reply-To: 
 <CAFJgqgRFEvsyf9Hej-gccSdC-Ce8DbO5DgHatLoJ-aYi1_ZcyA@mail.gmail.com>
References: 
 <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
 <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
 <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
 <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
 <d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de>
 <CAFJgqgQ=dJk7Jte-aaB55_CznDEnSVcy+tEh83BwmrMVvOpUgQ@mail.gmail.com>
 <651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de>
 <CAFJgqgRFEvsyf9Hej-gccSdC-Ce8DbO5DgHatLoJ-aYi1_ZcyA@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Feb 28, 2025, at 3:41 PM, Ventura Jack wrote:
>
> I did give the example of the time crate. Do you not consider
> that a very significant example of breakage? Surely, with
> as public and large an example of breakage as the time crate,
> there clearly is something.
>
> I will acknowledge that Rust editions specifically do not
> count as breaking code, though the editions feature,
> while interesting, does have some drawbacks.
>
> The time crate breakage is large from what I can tell. When I
> skim through GitHub issues in different projects,
> it apparently cost some people significant time and pain.
>
>     https://github.com/NixOS/nixpkgs/issues/332957#issue-2453023525
>         "Sorry for the inconvenience. I've lost a lot of the last
>         week to coordinating the update, collecting broken
>         packages, etc., but hopefully by spreading out the
>         work from here it won't take too much of anybody
>         else's time."
>
>     https://github.com/NixOS/nixpkgs/issues/332957#issuecomment-2274824965
>         "On principle, rust 1.80 is a new language due
>         to the incompatible change (however inadvertent),
>         and should be treated as such. So I think we need
>         to leave 1.79 in nixpkgs, a little while longer. We can,
>         however, disable its hydra builds, such that
>         downstream will learn about the issue through
>         increased build times and have a chance to step up,
>         before their toys break."

There's two things about this specific change that I think are relevant
to a discussion about Rust in the Linux kernel that I don't think got
mentioned (apologies if they did and I missed it in this long thread).

First, the actual change was not in the Rust language; it was in the
standard library, in the alloc crate, which implemented an additional
conversion for standard library types (which is why existing code became
ambiguous). Before v6.10, the kernel had an in-tree copy/fork of the
alloc crate, and would have been entirely immune from this change. If
someone synced the in-tree copy of alloc and noticed the problem, they
could have commented out the new conversions, and the actual newer rustc
binary would have continued to compile the old kernel code.

To be clear, I do think it's good that the kernel no longer has a copy
of the Rust standard library code, and I'm not advocating going back to
the copy. But if we're comparing the willingness of languages to break
backwards compatibility in a new version, this is much more analogous to
C or C++ shipping a new function in the standard library whose name
conflicts with something the kernel is already using, not to a change in
the language semantics. My understanding is that this happened several
times when C and C++ were younger (and as a result there are now rules
about things like leading underscores, which language users seem not to
be universally aware of, and other changes are now relegated to standard
version changes).

Of course, we don't use the userspace C standard library in the kernel.
But a good part of the goal in using Rust is to work with a more
expressive language than C and in turn to reuse things that have already
been well expressed in its standard library, whereas there's much less
in the C standard library that would be prohibitive to reimplement
inside the kernel (and there's often interest in doing it differently
anyway, e.g., strscpy). I imagine that if we were to use, say, C++,
there will be similar considerations about adopting smart pointer
implementations from a good userspace libstdc++. If we were to use
Objective-C we probably wouldn't write our own -lobjc runtime from
scratch, and so forth. So, by using a more expressive language than C,
we're asking that language to supply code that otherwise would have been
covered by the kernel-internal no-stable-API rule, and we're making an
expectation of API stability for it, which is a stronger demand than we
currently make of C.

Which brings me to the second point: the reason this was painful for,
e.g., NixOS is that they own approximately none of the code that was
affected. They're a redistributor of code that other people have written
and packaged, with Cargo.toml and Cargo.lock files specifying specific
versions of crates that recursively eventually list some specific
version of the time crate. If there's something that needs to be fixed
in the time crate, every single Cargo.toml file that has a version bound
that excludes the fixed version of the time crate needs to be fixed.
Ideally, NixOS wouldn't carry this patch locally, which means they're
waiting on an upstream release of the crates that depend on the time
crate. This, then, recursively brings the problem to the crates that
depend on the crates that depend on the time crate, until you have
recursively either upgraded your versions of everything in the ecosystem
or applied distribution-specific patches. That recursive dependency walk
with volunteer FOSS maintainers in the loop at each step is painful.

There is nothing analogous in the kernel. Because of the no-stable-API
rule, nobody will find themselves needing to make a release of one
subsystem, then upgrading another subsystem to depend on that release,
then upgrading yet another subsystem in turn. They won't even need
downstream subsystem maintainers to approve any patch. They'll just make
the change in the file that needs the change and commit it. So, while a
repeat of this situation would still be visible to the kernel as a break
in backwards compatibility, the actual response to the situation would
be thousands of times less painful: apply the one-line fix to the spot
in the kernel that needs it, and then say, "If you're using Rust 1.xxx
or newer, you need kernel 6.yyy or newer or you need to cherry-pick this
patch." (You'd probably just cc -stable on the commit.) And then you're
done; there's nothing else you need to do.

There are analogously painful experiences with C/C++ compiler upgrades
if you are in the position of redistributing other people's code, as
anyone who has tried to upgrade GCC in a corporate environment with
vendored third-party libraries knows. A well-documented public example
of this is what happened when GCC dropped support for things like
implicit int: old ./configure scripts would silently fail feature
detection for features that did exist, and distributions like Fedora
would need to double-check the ./configure results and decide whether to
upgrade the library (potentially triggering downstream upgrades) or
carry a local patch. See the _multi-year_ effort around
https://fedoraproject.org/wiki/Changes/PortingToModernC
https://news.ycombinator.com/item?id=39429627

Within the Linux kernel, this class of pain doesn't arise: we aren't
using other people's packaging or other people's ./configure scripts.
We're using our own code (or we've decided we're okay acting as if we
authored any third-party code we vendor), and we have one build system
and one version of what's in the kernel tree.

So - without denying that this was a compatibility break in a way that
didn't live up to a natural reading of Rust's compatibility promise, and
without denying that for many communities other than the kernel it was a
huge pain, I think the implications for Rust in the kernel are limited.

> Another concern I have is with Rust editions. It is
> a well defined way of having language "versions",
> and it does have automated conversion tools,
> and Rust libraries choose themselves which
> edition of Rust that they are using, independent
> of the version of the compiler.
>
> However, there are still some significant changes
> to the language between editions, and that means
> that to determine the correctness of Rust code, you
> must know which edition it is written for.
>
> For instance, does this code have a deadlock?
>
>     fn f(value: &RwLock<Option<bool>>) {
>         if let Some(x) = *value.read().unwrap() {
>             println!("value is {x}");
>         } else {
>             let mut v = value.write().unwrap();
>             if v.is_none() {
>                 *v = Some(true);
>             }
>         }
>     }
>
> The answer is that it depends on whether it is
> interpreted as being in Rust edition 2021 or
> Rust edition 2024. This is not as such an
> issue for upgrading, since there are automated
> conversion tools. But having semantic
> changes like this means that programmers must
> be aware of the edition that code is written in, and
> when applicable, know the different semantics of
> multiple editions. Rust editions are published every 3
> years, containing new semantic changes typically.

This doesn't seem particularly different from C (or C++) language
standard versions. The following code compiles successfully yet behaves
differently under --std=c23 and --std=c17 or older:

int x(void) {
    auto n = 1.5;
    return n * 2;
}

(inspired by https://stackoverflow.com/a/77383671/23392774)

-- 
Geoffrey Thomas
geofft@ldpreload.com

