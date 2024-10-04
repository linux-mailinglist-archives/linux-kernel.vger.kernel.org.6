Return-Path: <linux-kernel+bounces-351323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21D5990FB7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AC5281F3E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8AF1D969C;
	Fri,  4 Oct 2024 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR70dpsT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9BC1ADFFD;
	Fri,  4 Oct 2024 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069750; cv=none; b=Nqu2YCW7nVWMYQixsyp6UCrVZ1UESLKpD4bKTuJtwDeC1shYk/OPrR9FkvCMjs2gyUm04COn2qFP5YTTgVFpdNNR2PhMIA3zmwQF5OiHOan9RwjIQoPKCMq/RhHXhHiXjT5T3lkWt8QD42J366kc9zuCVPmPt4oJdt62s/Evz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069750; c=relaxed/simple;
	bh=kQbYsiubcJYPxuhS8I8lXYb38RwK12E+ZpIJ4OhX2Yo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sEXqJY5V43j5lvPnp61/J/JXUOlHcmQGznZCDUpY/P6pvW2EtoBTm2ePFakXcxxc56u8kW1GwuKoeBv/pHna9BZ12Vxt9UgHPv5naJb80/2l7t9hs2Glr4v68z6K2LtRl1RBOTWguQWwxJFWY9fwe19O66vyE1m5129qPGqGoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR70dpsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D61C4CEC6;
	Fri,  4 Oct 2024 19:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069750;
	bh=kQbYsiubcJYPxuhS8I8lXYb38RwK12E+ZpIJ4OhX2Yo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OR70dpsTXkiO2guh5U2MKHtzOQHfyHVrHUHnbpL6e2kqf2r9kr3c12i3pcSiPKrAZ
	 ujBSRoa4tEhxnZqIRyoI+zzTo8UBEcmOaPOwPGUYsqOyBldLR30cYiKwPqnDpeY5mI
	 VGbqYmqOBd1xO8Rh5dl7pg/fGaQGUYfVlHTB4QyjjCJ71wOT8tKvtxq4HTYw+wkjeg
	 NsSTTPXSVY+8KG9cp+Ed123opC5F5DVi7bh3pb8xchhNwYno5KzQxGDCzZJ6xc3qTx
	 gzK5GNAKtLHVs+kfg0zqKkPlfELsy71lYEI1PycDs+MYgjat7lSxvWItCv4ZoUf72o
	 8l67IrzHFkjwQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  "Benno Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Martin Rodriguez Reboredo"
 <yakoyoku@gmail.com>,  "Will Deacon" <will@kernel.org>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,  "Dirk
 Behme" <dirk.behme@de.bosch.com>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: implement `kernel::sync::Refcount`
In-Reply-To: <20241004200836.137ce41f.gary@garyguo.net> (Gary Guo's message of
	"Fri, 04 Oct 2024 20:08:36 +0100")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<pKZ-hxxNoouLWnfXzFGWvcgGgfjpEixPzJ--cZeEufWI9_MoG_mpToSPflheyUhYmZ4qTKLVypVLRuvX7rfyxg==@protonmail.internalid>
	<20241004155247.2210469-2-gary@garyguo.net> <87cykfpuqd.fsf@kernel.org>
	<43jTvIdx45orxSQV8Dh7xtNySNAVtiXAq4eiVbM2q39vrRfqdsUYf6CZLaoUVc3LzWC771s314egGcXkB01UCg==@protonmail.internalid>
	<20241004200836.137ce41f.gary@garyguo.net>
Date: Fri, 04 Oct 2024 21:22:00 +0200
Message-ID: <874j5rptbb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Gary Guo" <gary@garyguo.net> writes:

> On Fri, 04 Oct 2024 20:51:22 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> Hi Gary,
>>
>> "Gary Guo" <gary@garyguo.net> writes:
>>
>> [...]
>>
>> > diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
>> > index f47afc148ec3..39649443426b 100644
>> > --- a/rust/helpers/refcount.c
>> > +++ b/rust/helpers/refcount.c
>> > @@ -8,11 +8,26 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
>> >  	return (refcount_t)REFCOUNT_INIT(n);
>> >  }
>> >
>> > +unsigned int rust_helper_refcount_read(refcount_t *r)
>> > +{
>> > +	return refcount_read(r);
>> > +}
>>
>> +EXPORT_SYMBOL_GPL(rust_helper_refcount_read);
>>
>> > +
>> > +void rust_helper_refcount_set(refcount_t *r, int n)
>> > +{
>> > +	refcount_set(r, n);
>> > +}
>>
>> +EXPORT_SYMBOL_GPL(rust_helper_refcount_set);
>>
>> BR Andreas
>>
>
> Helper symbol export is automatic after
> e26fa546042a (rust: kbuild: auto generate helper exports)

All good then =F0=9F=91=8D I was applying to 6.11 and got some build errors.
Downstream `rnull` is still on 6.11.

Benchmarks will run next week.

BR Andreas


