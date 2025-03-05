Return-Path: <linux-kernel+bounces-547383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C0DA5066C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE03A5428
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836B92505D3;
	Wed,  5 Mar 2025 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8slCI8w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1FD1A9B2C;
	Wed,  5 Mar 2025 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196071; cv=none; b=ME4QUDWdpIDa9fxMj82enEra+xhc0Vd3jVwKqtFMaFVO6mZlY/bBBIvM/cqy+aZnI3oGel2SMHv4TAAv0Jzg6njXJMeFPE+KY54peGnTm7QOgx6B8nMlI3lqESeFLjTjl2V3vRgHX9IiQmWpXQ1KRIv3MUCTshPFC6rhxydQhHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196071; c=relaxed/simple;
	bh=Q7tZdGiz//alVM/39HNaFeqFv5iOuMH45TZOP69sPZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0RZe85hrRPVpYzOCppEwKeqsYxkLf8hzxGxzSWro/dnhqofD2tyoDclKC1nvhq1LoZE91FVYVdsTKI5OaEEsTiNAIAzuNYNqBkZOC2NoXbGfSR3sqeVb6BlsjyAYnymtEMaGTsoZN/qYNq3vZTML4Ag1lEk9yJpP9EuGOZp0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8slCI8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5CBC4CED1;
	Wed,  5 Mar 2025 17:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741196070;
	bh=Q7tZdGiz//alVM/39HNaFeqFv5iOuMH45TZOP69sPZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8slCI8webvsNko6Qht67wOJqNXeDy9d/AdScjQSNtzDlZ38aJ/3F8uj2Cb8R1scg
	 AgFvRae2Dtp5v+YOB2y8PzvyFzFm/0/jw4gzk9Eh5TGfcHZc9NXlnrNBDCWuaQk79z
	 qpqg+gd0Z3nBnAPcgnU+QVs47QLh3JGmtU1AldkqwXBuDahh0ANgP9QHNaTFEQzpEg
	 KVeHcJzxB+M/pY6bQmloITS+/b37SPTVqfcjqQ+lDzl6P/X63ffHErqpakMy6bTMeq
	 3lrdfAgQtpeugssSPQS0QybY5Jewvs3hPaPpMw0vA0fOBt1AgBqG0tf9QBZrjE1PKx
	 kABHWIld3GiQA==
Date: Wed, 5 Mar 2025 18:34:27 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/14] hrtimer Rust API
Message-ID: <Z8iLIyofy6KGOsq5@localhost.localdomain>
References: <aIJ0ymzdUceCN05hwJpth4erH5u2SHYzYl52wGeT3uiO9bdk92ZkEmEEq9a9NXsInJYSz9uziwq-1fvdsXoeDA==@protonmail.internalid>
 <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <877c5mci3p.fsf@kernel.org>
 <5kF-NYTBZbEqnnQud5LKnRXO0lfM0i6I2PoeFrpKDhCYwUuk_bG2Li1T1Nuv82r3VFD8adTcdx7yenXSIfTwmw==@protonmail.internalid>
 <Z7eYp_vZo5yDVOdI@pavilion.home>
 <87frk7hera.fsf@kernel.org>
 <Z7hheOSAuKdhq-1C@pavilion.home>
 <CANiq72mpYoig2Ro76K0E-sUtP31fW+0403zYWd6MumCgFKfTDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mpYoig2Ro76K0E-sUtP31fW+0403zYWd6MumCgFKfTDQ@mail.gmail.com>

Le Sat, Feb 22, 2025 at 02:04:16PM +0100, Miguel Ojeda a écrit :
> On Fri, Feb 21, 2025 at 12:20 PM Frederic Weisbecker
> <frederic@kernel.org> wrote:
> >
> > I was thinking the patchset would be better routed towards the Rust tree?
> >
> > How do you guys proceed usually with bindings tree maintainance?
> 
> So far, what we have been doing is ask maintainers, first, if they
> would be willing take the patches themselves -- they are the experts
> of the subsystem, know what changes are incoming, etc. Some subsystems
> have done this (e.g. KUnit). That is ideal, because the goal is to
> scale and allows maintainers to be in full control.
> 
> Of course, sometimes maintainers are not fully comfortable doing that,
> since they may not have the bandwidth, or the setup, or the Rust
> knowledge. In those cases, we typically ask if they would be willing
> to have a co-maintainer (i.e. in their entry, e.g. like locking did),
> or a sub-maintainer (i.e. in a new entry, e.g. like block did), that
> would take care of the bulk of the work from them.
> 
> I think that is a nice middle-ground -- the advantage of doing it like
> that is that you get the benefits of knowing best what is going on
> without too much work (hopefully), and it may allow you to get more
> and more involved over time and confident on what is going on with the
> Rust callers, typical issues that appear, etc. Plus the sub-maintainer
> gets to learn more about the subsystem, its timelines, procedures,
> etc., which you may welcome (if you are looking for new people to get
> involved).
> 
> I think that would be a nice middle-ground. As far as I understand,
> Andreas would be happy to commit to maintain the Rust side as a
> sub-maintainer (for instance). He would also need to make sure the
> tree builds properly with Rust enabled and so on. He already does
> something similar for Jens. Would that work for you?
> 
> You could take the patches directly with his RoBs or Acked-bys, for
> instance. Or perhaps it makes more sense to take PRs from him (on the
> Rust code only, of course), to save you more work. Andreas does not
> send PRs to anyone yet, but I think it would be a good time for him to
> start learning how to apply patches himself etc.
> 
> If not, then the last fallback would be putting it in the Rust tree as
> a sub-entry or similar.
> 
> I hope that clarifies (and thanks whatever you decide!).

Yes this clarifies a lot, thanks for the detailed options.
I think it's preferrable that you guys maintain it because you
are the experts with these Rust bindings and you'll be much
more flexible committing and pushing to your own tree instead
of waiting on us lagging to comprehend the content of each
pull requests.

Just keep us in Cc so we stay in touch with what's going on.

Thanks a lot!

> 
> Cheers,
> Miguel

