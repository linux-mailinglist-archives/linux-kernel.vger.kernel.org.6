Return-Path: <linux-kernel+bounces-545871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F040A4F2E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FB5188FB9F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CCC502B1;
	Wed,  5 Mar 2025 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nifRQEjK"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86E15D1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135408; cv=none; b=Vjxe/K0Rlnq50MPx8ivdM/re02pVGNf9gxuuHm33RU5RtQpxu2LgiiJmtweCrrJN9CAJKzH/OfcBkqu8EUeV+dQwJB276JkmGLCEtiSR6zHOgVuLtiULyaPDgQFNiyf2Vl2FN7lQhmW1t5ngxWVq6+uHXkQtoPTwX7cxvqKcekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135408; c=relaxed/simple;
	bh=OKHDmjwimxOhnW7rYl67IZUwnThMZFxl+dKmmw13jnw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EO05UFVFThVb66326Q4eVzr13+CyUQNirFR1TyMFO29FisdsuMDqHSkTkTnFHbyFWgP0RzW60z9B1ssn/vPlwggQS0nenlGFwQku5AL47x3U/6DxAb6plCRdRBTRB6OcHStfCG4gDseeu/sWesGRLTbl8x6FA+znHoVRKFOIRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nifRQEjK; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3uh6k4mdevdztoqxvfqc4bjqgu.protonmail; t=1741135404; x=1741394604;
	bh=dIrvwY3gB1CriE8+CIS56SQUkbk7cXnqzrPo4rZ63FU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=nifRQEjKdHZaMqLLKkLYXVtrVGLLydNHSVkmWmk1aqksYjIU+rB+D4ediv568XcGs
	 HyjOnHsZT1W2qM+BzGXKtVcs4IHYiwLVSyrOTz6vkY2Ks0QxEoYdK0yY65q4av1xF3
	 fJZB7W5XGIktXCVhZ5iiZ73iN/86kzKRtiVOXe3l8ibhXFy0gYp8CEVlWW51G6fRO3
	 L2530YW10zHZpvbsS+4czTg7GTUkHz+DtjofZ6KrLNHml7oH7KPAClYkKLcl6mnodW
	 5Zdfifn4Jhi4HgsqBmfJ/b00PcKV73Q4VO5+I9bZwLet2s/P1NHiRmWroEUqmDYt9W
	 frN7+SZUpvO6g==
Date: Wed, 05 Mar 2025 00:43:18 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 22/22] MAINTAINERS: add entry for the `pin-init` crate
Message-ID: <D87WZI6NPPOG.EJ4OGCTG4O9R@proton.me>
In-Reply-To: <Z8eYKXCl0co-GLaf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <20250304225245.2033120-23-benno.lossin@proton.me> <Z8eYKXCl0co-GLaf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a090e1ffc9ea20c64209e66d6bd9d552dfa070e0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 1:17 AM CET, Jarkko Sakkinen wrote:
> On Tue, Mar 04, 2025 at 10:56:27PM +0000, Benno Lossin wrote:
>> Add maintainers entry for the `pin-init` crate.
>>
>> This crate is already being maintained by me, but until now there
>> existed two different versions: the version inside of the kernel tree
>> and a user-space version at [1]. The previous patches synchronized these
>> two versions to reduce the maintenance burden. In order to keep them
>> synchronized from now on, separate the maintenance from other Rust code.
>>
>> Link: https://github.com/Rust-for-Linux/pin-init [1]
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> ---
>>  MAINTAINERS | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8e0736dc2ee0..ced7fac4dbbe 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20735,6 +20735,19 @@ S:=09Maintained
>>  F:=09rust/kernel/alloc.rs
>>  F:=09rust/kernel/alloc/
>>
>> +RUST [PIN-INIT]
>
> In some subsystems the order is exactly the opposite. E.g.,
>
> ASIX PHY DRIVER [RUST]

I think that `RUST [PIN-INIT]` makes sense in this case, since it is a
core Rust library. In the example you gave above, the `ASIX PHY DRIVER`
subsystem already exists, so it makes sense to have a rustified version.
With pin-init, there is no C counterpart. So IMO the only other
alternative would be just `PIN-INIT`.

---
Cheers,
Benno

>> +M:=09Benno Lossin <benno.lossin@proton.me>
>> +L:=09rust-for-linux@vger.kernel.org
>> +S:=09Maintained
>> +W:=09https://rust-for-linux.com/pin-init
>> +B:=09https://github.com/Rust-for-Linux/pin-init/issues
>> +C:=09zulip://rust-for-linux.zulipchat.com
>> +P:=09rust/pin-init/CONTRIBUTING.md
>> +T:=09git https://github.com/Rust-for-Linux/linux.git pin-init-next
>> +F:=09rust/kernel/init.rs
>> +F:=09rust/pin-init/
>> +K:=09\bpin-init\b|pin_init\b|PinInit
>> +
>>  RXRPC SOCKETS (AF_RXRPC)
>>  M:=09David Howells <dhowells@redhat.com>
>>  M:=09Marc Dionne <marc.dionne@auristor.com>
>> --
>> 2.47.2
>>
>>
>>
>
> BR, Jarkko



