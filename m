Return-Path: <linux-kernel+bounces-566887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1574A67DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB32088096C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16126210F44;
	Tue, 18 Mar 2025 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjNsDGtc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482B1AAA1E;
	Tue, 18 Mar 2025 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328951; cv=none; b=ZiL3S89uNxKxPzm1ddZkd+QuSXsXoOyx6sQRv9rhB7TdIF/ln3g9ZV3rk2ZNFT9VVVDRrdPi7ptzNyEEtmMzD3RVo7zbyjSF/6x02ReVhLBpSQvX9nUUjXOeaW0IPQ/WeIqeSzyphyiqhOydJcpOghx+adIy+AO7qhFY4MdR3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328951; c=relaxed/simple;
	bh=JBLmucw5Hq5ebdCg64Hs7l+gUnqHqEik6Ofo4Dq4EN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOGGodRGjBEHQ3dL8wurrvzgiHRbThrW5m13yGE20URoWB4aO9XxlCKwnOnqj9YRkhoMpWg/RnzfjpMrnvZ2nrKK0kkXlNVhyUNR5iyoY9ar5vkRGcMjRI9CSQf5fSjzJpuvUnuBvRwgnpll8PoRRKQyUgFLOD7OBpI6hrAtZ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjNsDGtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356E1C4CEEE;
	Tue, 18 Mar 2025 20:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742328950;
	bh=JBLmucw5Hq5ebdCg64Hs7l+gUnqHqEik6Ofo4Dq4EN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjNsDGtcihGOwuNHkbvSHS0to86ARfj9YWkarm211T/VxNI76PZo8phedSG8Pz63X
	 QiFDRE60+lyYFPYD+i42Q6DC7/wxAa2dD3Quo/i64SG2rr67j0yL4EeOcCYqYrnd1r
	 FilMdtJ3AX9EoTK9lJ+3ND83ITZZPg5LLxj1acnIw3SmujcNoODpBANZpbC9iLw7/2
	 1/NumKqgIgaBK63knrugsf27/FKcm4qrTQRDsvhDuNRrFp26XV/oR8ykOcuaY+0CFv
	 TQXopG/BpRjJeN7xoUbRxWNPcDRti0s6NFTfLHZpqzKPJkvkUSvvJn9oKPGAbmlk49
	 Q2iQrhzEwxcIg==
Date: Tue, 18 Mar 2025 21:15:45 +0100
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
Message-ID: <Z9nUcXc76w5g4_9m@cassiopeiae>
References: <CAJ-ks9n=7fqtNr88co-EU7d9Wo1Dz1Wmp0p3K0b8RQE9mjrbHQ@mail.gmail.com>
 <Z9k9I6mp11Z358vz@google.com>
 <CAJ-ks9kcNvGqGrU1nKjYs_4XPbdxo2cW8Tj9JOGJesGO4StdAw@mail.gmail.com>
 <Z9mGv6ir4c96Of0Q@google.com>
 <CAJ-ks9mHvjPn98mcXh3q18nB5pPH6YBj3jf1YH6510bP-mtFtQ@mail.gmail.com>
 <Z9m_mfg5b0XE_HCF@cassiopeiae>
 <CAJ-ks9=YSN8VRUW6VTfThkN8uh42rbq9pBwvrG=EuW2wpuXx5A@mail.gmail.com>
 <Z9nI_kM6LPELbodm@cassiopeiae>
 <CAJ-ks9=yvF2bV6bQTATZWNxCEtbMmROo5BqY3FmPx1DEkX1g=g@mail.gmail.com>
 <CAJ-ks9mmkm2LT7BYg3ni0v-PsV4Gv57=SOD1xDp1_aeqN7XPzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mmkm2LT7BYg3ni0v-PsV4Gv57=SOD1xDp1_aeqN7XPzA@mail.gmail.com>

On Tue, Mar 18, 2025 at 04:13:43PM -0400, Tamir Duberstein wrote:
> On Tue, Mar 18, 2025 at 4:05 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > On Tue, Mar 18, 2025 at 3:27 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > >
> > > On Tue, Mar 18, 2025 at 02:53:48PM -0400, Tamir Duberstein wrote:
> > > > On Tue, Mar 18, 2025 at 2:46 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > >
> > > > > On Tue, Mar 18, 2025 at 02:28:02PM -0400, Tamir Duberstein wrote:
> > > > > > On Tue, Mar 18, 2025 at 10:44 AM Alice Ryhl <aliceryhl@google.com> wrote:
> > > > > > >
> > > > > > > On Tue, Mar 18, 2025 at 10:12:28AM -0400, Tamir Duberstein wrote:\
> > > > > > > >
> > > > > > > > The methods you're describing are all on Vec, right? In other words,
> > > > > > > > their usage calls for a private `dec_len` or `set_len`. As I've said
> > > > > > > > repeatedly in the course of this discussion: I would prefer not to
> > > > > > > > introduce `dec_len` at all here. It (or `set_len`) can be introduced
> > > > > > > > in the series that adds truncate or your patch that adds clear, where
> > > > > > > > its signature can be properly scrutinized in the context of an actual
> > > > > > > > caller.
> > > > > > >
> > > > > > > Oh I did not see that you said that. Dropping patch 2 is fine with me.
> > > > > > >
> > > > > > > Alice
> > > > > >
> > > > > > Benno, Danilo: are you both OK with this? I'll discard this patch on
> > > > > > the respin and prepend the patch adding the len <= cap invariant.
> > > > >
> > > > > I mean, the whole reason to switch set_len() to inc_len() and have a separate
> > > > > dec_len() was to properly cover things like [1] and Alice' patch by having
> > > > > dec_len() return the abandoned entries.
> > > > >
> > > > > If we now only switch set_len() to inc_len() and drop dec_len() then what should
> > > > > Andrew do?
> > > >
> > > > I'd be completely fine with Andrew (or Alice) taking this patch into
> > > > the truncate/resize series[1] (or the series that introduces clear
> > > > [2]). It can be properly reviewed there in context.
> > >
> > > Sorry, I'm not willing to make this Andrew's responsibility; set_len() worked
> > > for his patches before.
> > >
> > > If you're uncomfortable implementing your proposal without the existence of
> > > truncate(), please rebase onto Andrew's patches.
> >
> > This suits me just fine! I tried applying Andrew's patches locally but
> > I don't have `Documentation/gpu/nova/core/todo.rst`. Do you know what
> > his base commit is?
> 
> Nevermind, I can just specify the patch ID.

Yeah, you can just ignore the nova patch.

