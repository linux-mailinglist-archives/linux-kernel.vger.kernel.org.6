Return-Path: <linux-kernel+bounces-517480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88537A38165
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0AA188F45A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6026E218AC8;
	Mon, 17 Feb 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwsScI6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF96218821;
	Mon, 17 Feb 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790531; cv=none; b=RzgWakfLPimJMDTscxUI3Ho5r/+jThq04RyBaV4V2Tsb97fXngqv2WMmVUaXAa4Nibj5QrkEsrVZkU2jFpgKSaZuejhGfKjhW47+wW7g2tEl03ayNzXtZOyjUNlJmHm0w6Q/Zsb9buSL3F16Q7oBuSmKjgzn6IMFtqng7giUR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790531; c=relaxed/simple;
	bh=tpxHyucI/EuHXDZR7LszqoBtoY5UfFfiM1Pz5WQc7G8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VrgAoQmpbBtJKXD48n4gKY9MQfGlSHb+rh4aUA18RW/2PomkYinws1fAtY2tOfRDA1+MHzkn/MiS7rV1snF+jHjNroU2a4+tIkAOxnh66ThqQchQEl9BXmkJXcunAaffPME1WBi552uL1vRoSDE4SRW6qIsSU5V9+l+77/sWuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwsScI6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D77C4CED1;
	Mon, 17 Feb 2025 11:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739790531;
	bh=tpxHyucI/EuHXDZR7LszqoBtoY5UfFfiM1Pz5WQc7G8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JwsScI6qd4SK7crYC7cccnVBnpf1sTMBpAmp1Y9ejNa/DFy7lOzDMrzmlCnuLrJBo
	 /oc5yScbJbuICXWueBxvKmegly0AYA8PpiGJW9MvWZS+rC29Qt/T3GqukQdu251G8j
	 J9KAHpgmOw5suWWWPQCoBOM7hVa0HfWkyXszW/pnWXwlBWcSGpuOxkmXy+C14F95dE
	 qtuCUfWMRsbrCx/CUckiM3lJb+g/cKW8oGPxggqxCc6w3uKcgkawso8bYlWrOoBdbw
	 4OdPa1Oesi+TB3Voj7BCKxvxDb/Vkmrb4t9wPJbo0C54VO6tcGRhQMJSwmGiKkm4eK
	 rPtVFzmvfB4Rw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Joel Becker" <jlbec@evilplan.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Peter Zijlstra" <peterz@infradead.org>,  "Ingo Molnar"
 <mingo@redhat.com>,  "Will Deacon" <will@kernel.org>,  "Waiman Long"
 <longman@redhat.com>,  "Fiona Behrens" <me@kloenk.dev>,  "Charalampos
 Mitrodimas" <charmitro@posteo.net>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] rust: sync: change `<Arc<T> as
 ForeignOwnable>::PointedTo` to `T`
In-Reply-To: <CAJ-ks9mDNptodHEPPd+TPZGT1Cs9EtyUKa9+ciAK9c4pge9M2A@mail.gmail.com>
 (Tamir
	Duberstein's message of "Sun, 16 Feb 2025 21:03:58 -0500")
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org>
	<20250207-configfs-v2-1-f7a60b24d38e@kernel.org>
	<MEPE3sDIIRAUkgSrIXxPHwwwtsGF4pvjDXznrV9Uu7xt9e3JTxdjX-rtoGSQ9Gd6jUB4xtcrBbA18Wf6li9ZIQ==@protonmail.internalid>
	<CAJ-ks9mDNptodHEPPd+TPZGT1Cs9EtyUKa9+ciAK9c4pge9M2A@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 17 Feb 2025 08:34:43 +0100
Message-ID: <87y0y5t46k.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Fri, Feb 7, 2025 at 9:50=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>>
>> Using `ArcInner` as `PoinedTo` in the `ForeignOwnable` implementation for
>> `Arc` is a bit unfortunate. Using `T` as `PointedTo` does not remove any
>> functionality, but allows `ArcInner` to be private. Further, it allows
>> downstream users to write code that is generic over `Box` and `Arc`, when
>> downstream users need access to `T` after calling `into_foreign`.
>
> I stumbled upon https://github.com/Rust-for-Linux/linux/pull/1036 the
> other day. Boqun, are there any plans to revive this work? It might
> obviate the need for _this_ patch.

I don't think it would help configfs. The configfs patches rely on
getting access to a `T` pointer from `ForeignOwnable::into_foreign`.

In fact, thinking about this, I should probably mandate this in
`ForeignOwnable` API requirements in order to not have soundness hinge
on the implementation of `ForeignOwnable`.

Also I would appreciate that if we want to use a reference to `ArcInner`
rather than a special borrow type, maybe let's do it down the line and
not stall this series on that work.


Best regards,
Andreas Hindborg




