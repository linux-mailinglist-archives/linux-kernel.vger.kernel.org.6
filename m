Return-Path: <linux-kernel+bounces-547036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F25A50204
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C033A522A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7324C077;
	Wed,  5 Mar 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AR63w9Ib"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0609156C74;
	Wed,  5 Mar 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185072; cv=none; b=uL+0XY7oVYOo9mSqiyhiD0bCrQaLMILnesJZqPuViuXwwMYScWYbf0GwjGdOnv0QIk71WJkALFK3rJ+BoJdhBcVokmKaDakjT4SiTYXln1WARHFP2GdMNC3k1zp9E5fOvc7wmSdAmbCicTS9/Jx27ZFEnuyZGsI7w7B0OrIV0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185072; c=relaxed/simple;
	bh=7b5kFmyuKd4PGTAM6dunYR/UaELMhLi7JdawylXPjZo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfGcGirLR2E2oR+g7QlwGJLYDZjSLVYBBEqe5N+bTf3u9RpAoU2LBlV2/2HoFzHL2s0ok90Gv+TqCGkFVEGwT75xd8X7s2yDVy1VWvEPoimgo3vF8fDWcvyrXy6aobLcJTPOqbJepbAA9MtYPTmlaZOruW+OETNe4fFni6ZqKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AR63w9Ib; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741185068; x=1741444268;
	bh=/6JL7Ryq+oLJLabXRnbuuFC76es9XqEv0oiMmPmMiVM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=AR63w9IbA45n9IcpVqvP/VR8cWbF0xBgSyJa3yTue/R48BtqnLMQLyn5aD4EzBLxD
	 s+Gp+CBmFtnS2hfF0/4Zyg0XbKrrN7G8XbXTsuwsms32KarZKbfY3dmhm0J7eVcm6m
	 9bWIh0I1XxHB7+zLa5gbZVLKyPoi8Bu4mOIXBaSPykka6lDrp11vST6FpwDWBA/IpP
	 fu77qWEKQfRzeZ3Punu7s0Q4SgcR2NhZIiQ5f1u8sa6cVXYufW9ZYYlUFKJsNjc60b
	 Zuvm9bpLDTMkfPcalyMsqzb7ZUlgdcVCtrF5R70MloZVpRZxmIRba76rA4UfbDuTaG
	 z0OJVWJDj6Q0Q==
Date: Wed, 05 Mar 2025 14:31:02 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/22] rust: init: disable doctests
Message-ID: <D88EL88V6MX5.3LDSTI2SKEPH8@proton.me>
In-Reply-To: <87h647a7rd.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <sIa0gEFObIVkQIOds6BkLjVFyVpGcJ70lKQ6CC6zAjpKS4xGB0hcKqo170yhITiDQfjg7s2CigwRoJfJ2fFvmA==@protonmail.internalid> <20250304225245.2033120-2-benno.lossin@proton.me> <87plivg8s7.fsf@kernel.org> <LACr2ZSOM2qo2DCApO6HPm_ESyWi3a8IxriVkayJJqTsEftAekzbNB1-Jwq2RxlubW_IlnsfB07ylWy_xU_ftw==@protonmail.internalid> <D88CITPM946W.1O2W73CGF7L6G@proton.me> <87h647a7rd.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bd215d1a508a0ddbc7cd984220c2a5a64666c4d6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 3:09 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> On Wed Mar 5, 2025 at 9:51 AM CET, Andreas Hindborg wrote:
>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>
>>>> This is the first commit in a series that splits off the pin-init crat=
e
>>>> from the kernel crate.
>>>
>>> I recently learned that using imperative mode in the commit message is
>>> preferred [1]. You might want to consider that for next spin.
>>
>> Thanks for pointing that out, any suggestions for this concrete case? I
>> wasn't able to come up with an imperative statement.
>
> I would drop the first paragraph entirely, since the subject is 01/22
> and the cover letter provides plenty of context.

Done.

>   The build system cannot handle doctests in the kernel crate in files
>   outside of `rust/kernel/`. Subsequent commits will move files out
>   of that directory, but will still compile them as part of the kernel
>   crate. Thus, ignore all doctests in the to-be-moved files.
>
>   Leave tests disabled until they are separated into their
>   own crate and they stop causing breakage.
>
> Not sure if it is better? More robot for sure =F0=9F=A4=96

Thanks!

>
> This part from the original is not correct:?
>
>   since then the doctests of that new crate will be handled as normal
>   host doctests.
>
> The build system will not run those tests when they are not in the
> kernel crate?

Yes, that sentence was from an old version when I tried to get them to
work. Removed it in next version.

---
Cheers,
Benno


