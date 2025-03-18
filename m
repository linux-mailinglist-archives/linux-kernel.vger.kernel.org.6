Return-Path: <linux-kernel+bounces-566766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2CA67C39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4356319C3A79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE9420FA8B;
	Tue, 18 Mar 2025 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iawZOsRJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8481684A4;
	Tue, 18 Mar 2025 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323617; cv=none; b=bFM7a/yjvgKa3KBmXaFHyO1rToCWC5jNo7y3EL+AY1fxsNud/YkjKMQND9j3/+WAgCMT6mJFIBv31LTe57n0ltyVG8gJ63NgXr5H9uazANvD5aWRMVPZavxNZDGTzklB0/NZJrO0At1dGODh4sUtD1Yn/jDW0KqS0ckx6PvmT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323617; c=relaxed/simple;
	bh=NSBssJnRZiwQnK204pCfV02o/49q27Btf6Npr8c8QEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCg2D1mjx1Bi0yxrxd0nQ6fEEzXf6hauwba2WkinXTWlYDOw7ATHozURdlW6ZOtmJvbXpWJcHU+LIF4acpRsJPDWaZoIYskX2qZksdJNxvqu5yz5oXzPTWpvBHyXBM8hM9Fh3k0xJbUHuvahFBvnXFGL3huXyBi1t9uhbcJP5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iawZOsRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEE5C4CEF5;
	Tue, 18 Mar 2025 18:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742323615;
	bh=NSBssJnRZiwQnK204pCfV02o/49q27Btf6Npr8c8QEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iawZOsRJ8I3Be/1Ixj9fuDIBGEXAFLu5BE2mrD9U0oPWX61ygseOfl9xQz9ZdhATU
	 naA3nbEahnTuRLcsjAsLmTv/9w+D0ZV2ulIhCSd5OkUm8YsMcFNyUj8dhEfqxSljcJ
	 ULeI9et657Sk4zwgiAolhb4V18vI8DD493XVwQhCppeMJH1J8tlYu6953mcX3JyfcU
	 zzasjB3DkxY2F1MvxsnZYvYqqAbjSktsPi1XwB3IeBgBA6IVTSm8SxiJt6SuZNKmZJ
	 4g6/kytMXjRckm5RVa4qOGd/5PC6MFtNVkA88gRnNab81FQulYZuJ11d3X3lA5jcIp
	 GMIb3pKHTY6Og==
Date: Tue, 18 Mar 2025 19:46:49 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Message-ID: <Z9m_mfg5b0XE_HCF@cassiopeiae>
References: <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
 <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <Z9gL5hQWvCNy5XNH@google.com>
 <Z9gcqHihXLg6kcZb@google.com>
 <CAJ-ks9n=7fqtNr88co-EU7d9Wo1Dz1Wmp0p3K0b8RQE9mjrbHQ@mail.gmail.com>
 <Z9k9I6mp11Z358vz@google.com>
 <CAJ-ks9kcNvGqGrU1nKjYs_4XPbdxo2cW8Tj9JOGJesGO4StdAw@mail.gmail.com>
 <Z9mGv6ir4c96Of0Q@google.com>
 <CAJ-ks9mHvjPn98mcXh3q18nB5pPH6YBj3jf1YH6510bP-mtFtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mHvjPn98mcXh3q18nB5pPH6YBj3jf1YH6510bP-mtFtQ@mail.gmail.com>

On Tue, Mar 18, 2025 at 02:28:02PM -0400, Tamir Duberstein wrote:
> On Tue, Mar 18, 2025 at 10:44 AM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Tue, Mar 18, 2025 at 10:12:28AM -0400, Tamir Duberstein wrote:\
> > >
> > > The methods you're describing are all on Vec, right? In other words,
> > > their usage calls for a private `dec_len` or `set_len`. As I've said
> > > repeatedly in the course of this discussion: I would prefer not to
> > > introduce `dec_len` at all here. It (or `set_len`) can be introduced
> > > in the series that adds truncate or your patch that adds clear, where
> > > its signature can be properly scrutinized in the context of an actual
> > > caller.
> >
> > Oh I did not see that you said that. Dropping patch 2 is fine with me.
> >
> > Alice
> 
> Benno, Danilo: are you both OK with this? I'll discard this patch on
> the respin and prepend the patch adding the len <= cap invariant.

I mean, the whole reason to switch set_len() to inc_len() and have a separate
dec_len() was to properly cover things like [1] and Alice' patch by having
dec_len() return the abandoned entries.

If we now only switch set_len() to inc_len() and drop dec_len() then what should
Andrew do?

Maybe we should just revert to Tamir's first proposal, i.e. keep set_len() as it
is, but make it return the abandoned entries, if any.

[1] https://lore.kernel.org/rust-for-linux/20250316111644.154602-1-andrewjballance@gmail.com/

