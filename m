Return-Path: <linux-kernel+bounces-263755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB493DA2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98FD1C23345
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27143149E13;
	Fri, 26 Jul 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KnmBAoEq"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825C149E06
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722029416; cv=none; b=Ik6wXXMOR+VieZpx4xoiC98RHMGjfOfB9CYE9eSZfQsQNFQ8z86j59F0Mzm2gWEEvpugmWRByw0o1HACEwFMMijsWiZ1cxBPGFjMPteKyd9PF+WSzoXSUJwCF0XrHL7N78+dmjUO991hp1kQKaXGZVCzbBfF/j+8/wKCG0cFGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722029416; c=relaxed/simple;
	bh=TazJz5DuIy70P9F4AIkG+gYscTAZ4DJnFp342oDsZ3U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAbeZREq7ZaPOBTqv5gjtkHavOivNuOMWQtZ9W2o/w/TuyD3GqFnvM4gc8lUlckZioWp8jNR/AoT7GhM43x+gyZF9gSGwPQVUZhYddN/uuHQeZkTQX5Yi6F9JfChcs6ylqCbVgduUDN6oaFlW+B+ZGXd7Je+bR4wcwhcAz1nyjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KnmBAoEq; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722029407; x=1722288607;
	bh=TazJz5DuIy70P9F4AIkG+gYscTAZ4DJnFp342oDsZ3U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KnmBAoEq774sWlpBt9Vk2FT/I+OIj6TmATo3eR3g9mQOvfRSfSz2WGHIxhL+eTGq9
	 phSqHCH+u1XvkjYCKUQLHd3He2NJrZ9gzNnrJvQQV0eFVjGbWlv21aIvadO8BBV/z5
	 wh+HI42Qw3UW0b2omFDSbIYqIMcdqIHXxGUH0G4U4MoqZ6LbWsjRi/01n+qzmnbChj
	 ghoOJx+w7/JL7cqRdwzO7h69c+4tvwvsr6ZpTmlEaVCFJD/pdBu1YbFWeteSHwJs6x
	 okW+LJJ2xCvponbQ6uHYCRmsvh/YyUOx8aRLhhUosIlwFfCuRrwz/VVlnJAsplHJNc
	 aD6eBfAbCviHw==
Date: Fri, 26 Jul 2024 21:30:00 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Lyude Paul <lyude@redhat.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Aakash Sen Sharma <aakashsensharma@gmail.com>, Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: Introduce irq module
Message-ID: <e46d6e12-144f-47fe-9db4-d7d04914f265@proton.me>
In-Reply-To: <ZqQTXUl4w6LRPqLh@boqun-archlinux>
References: <20240725222822.1784931-1-lyude@redhat.com> <20240725222822.1784931-2-lyude@redhat.com> <ZqQTXUl4w6LRPqLh@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 67cf4481c52eddca5d086a82b0eb77c95d794ba7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.07.24 23:21, Boqun Feng wrote:
> On Thu, Jul 25, 2024 at 06:27:50PM -0400, Lyude Paul wrote:
> [...]
>> +pub struct IrqDisabled<'a>(PhantomData<&'a ()>);
>=20
> I think you need to make this type !Send and !Sync (because you are
> going to make it Copy). Otherwise, you will be able to pass the irq
> disabled token to another thread on a different CPU which doesn't have
> irq disabled.

Oh yeah this is a good catch! (although it should not matter at the
moment, see the end of the note below)

Just a note: it is not because of making it Copy, this problem already
exists in the current implementation. One could have sent the reference
to a different thread using a "scoped spawn"-esque function [1]. IIRC we
currently do not have such a function, but it should be possible to
later add such a function. (and it is much more accurate to make this
type not be thread safe)

[1]: https://doc.rust-lang.org/std/thread/struct.Scope.html#method.spawn

---
Cheers,
Benno


