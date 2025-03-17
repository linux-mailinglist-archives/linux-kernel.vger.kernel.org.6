Return-Path: <linux-kernel+bounces-564581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45F0A657B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CB1188E6BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57219D8A2;
	Mon, 17 Mar 2025 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmSjNK47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681741922D3;
	Mon, 17 Mar 2025 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228221; cv=none; b=G4cJ93PkNs/cP29LY8qMFReoPZr2TB0j7oBYVFYZ1BMoGKG64yuwrNKeBvAkem5gj2Kuk/EWR5lD09dMWOov+jqTUKtoA9MqcEyj6zvtS97VmMk+ehFnySN2xWQm7ftyIVRAO/CYxqi11KKrUwFKsMxrD1r5ygsI7FwN88F12Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228221; c=relaxed/simple;
	bh=3nLJh160QmzXnmlwT9c83fok8ylSn9nGD1m5ScL+J7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGxY5/bHlSxqxeJrW3hBmxmBu1aQmbEjPuYCdfrFgSTX/d99hnYHzLeQYUCK31ZrkEwW5Gk5/g8f8/emnOob1zwY/di7rTFiH5+f9/f+dYxA7X/WdWJh0RCjur3p/W1VzoWWpcPYiRPX48B4/ZEeRTKRa+DQT/BqHcdkXGodwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmSjNK47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E22BC4CEE3;
	Mon, 17 Mar 2025 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228220;
	bh=3nLJh160QmzXnmlwT9c83fok8ylSn9nGD1m5ScL+J7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmSjNK47xIfKhoPiz22nCRMD8HYwX4zBP3o6A4S2CZxSjpbK3O8Zyb5Vb5WdzP0o5
	 IOFEyP+heAucZhbDS/GA8tVn59/GHPlkGcASa/zn2IOONdZSYEyxJsWpsoBI4PwUfb
	 nQlN2djuJAvB48Zz6pUGbEqSjTdGps2BoAQYjGo/UIM5KeFILjCsGMixygFGm0dPgN
	 WYGbWSn8TFK4dMwyCYyERsW7WiNhweNEgf+uRVATRBAmWJvovmYgU6nkwjr0Lnr4Is
	 BW3StaiXwpi5zydlCvVEmQBc9Ca9ntyt5U4mz4OqwoVErUYPz/WfYCl5GHBps4s0Ry
	 FZRnXBIprGTiQ==
Date: Mon, 17 Mar 2025 17:16:55 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Message-ID: <Z9hK9_zFqnH5XQC-@cassiopeiae>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
 <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <Z9gL5hQWvCNy5XNH@google.com>
 <Z9gcqHihXLg6kcZb@google.com>
 <D8IMCFZJ2G7C.28DHUZGDB596P@proton.me>
 <CAJ-ks9kEpC=7jK9CLNKBWYpoOyAo_Wr8eyvaYf0ZSiC8m-VREQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kEpC=7jK9CLNKBWYpoOyAo_Wr8eyvaYf0ZSiC8m-VREQ@mail.gmail.com>

On Mon, Mar 17, 2025 at 10:44:25AM -0400, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 10:42 AM Benno Lossin <benno.lossin@proton.me> wrote:
> >
> > On Mon Mar 17, 2025 at 1:59 PM CET, Alice Ryhl wrote:
> > > On Mon, Mar 17, 2025 at 11:47:50AM +0000, Alice Ryhl wrote:
> > >> On Mon, Mar 17, 2025 at 07:34:44AM -0400, Tamir Duberstein wrote:
> > >> > On Mon, Mar 17, 2025 at 6:04 AM Benno Lossin <benno.lossin@proton.me> wrote:
> > >> > >
> > >> > > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> > >> > > > Add `Vec::dec_len` that reduces the length of the receiver. This method
> > >> > > > is intended to be used from methods that remove elements from `Vec` such
> > >> > > > as `truncate`, `pop`, `remove`, and others. This method is intentionally
> > >> > > > not `pub`.
> > >> > >
> > >> > > I think it should be `pub`. Otherwise we're loosing functionality
> > >> > > compared to now. If one decides to give the raw pointer to some C API
> > >> > > that takes ownership of the pointer, then I want them to be able to call
> > >> > > `dec_len` manually.
> > >> >
> > >> > This is premature. It is trivial to make this function pub when the need arises.
> > >>
> > >> Normally I'd agree with Benno, but in this case I think having it
> > >> private is preferable. The function is safe, so it's too easy for
> > >> end-users to confuse it with truncate.
> > >
> > > Thinking more about this ... I think we should have `set_len` and
> > > `inc_len` instead. That way, both methods are unsafe so people will not
> > > accidentally use `set_len` when they meant to use `truncate`.
> >
> > I agree for this on the public API. The way I usually saw `set_len`
> > being used for decrementing was truncation without dropping the old
> > values. And that is going to be `vec.dec_len(vec.len())` with the
> > current design. `vec.set_len(0);` is much clearer in that respect.
> >
> > But for the internals, I'd say that `dec_len` is nicer, so for `pop` one
> > would then use `self.dec_len(1)`.
> >
> > How about we keep `set_len` and make `dec_len` a private, safe helper?
> 
> This discussion is _way_ too speculative for my taste. If you'd like
> to do this kind of thing, I'm happy to drop this patch or the series.
> I'm not comfortable adding API whose usage I haven't seen and don't
> understand.

Seems like setting the length of a vector is a hard thing to do. :)

I advocate for a middle ground.

(1) Let's keep dec_len() a private and safe helper, it clearly improves the
internals.

(2) Introduce set_len() as a public API and defer the question on how to support
dec_len() in a public API once the need arises.

