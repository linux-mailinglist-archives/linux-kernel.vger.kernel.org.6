Return-Path: <linux-kernel+bounces-190286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6488CFC6F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A01F22D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77123763EC;
	Mon, 27 May 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iEOAw9qe"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78E6A357
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800753; cv=none; b=SejIsCuc21p5rZEEIPw1DqlDq/It2f/1+aXtDscyVsbUA98IbQM/D0EC1JweNM9iYQ14OEOWw3Cp52pzV5QYL1WCvqEuO5XAEa2yxkHrpvFK+/aAuEGyDonKjqCsXwgYhj4BqTI/qbdZmzyeXN6Ls2AbKC7arv//syzuK6NTV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800753; c=relaxed/simple;
	bh=6HascMYOkFkuQtYLQ9eeZm6r9t6P/M/iXsDNN7DFtkk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wgyf+Ei6RmzMZhakbQ8ss0LTxDNGr4i0x8+YZjnJfzKJcvKanO5CEXqXMrFsQRaCggPiOnvQpidQZYpWNUJlOUDMP7Hajvyq5ZczgcVaY7ScdaMzFEDwyJ9BLwcgVhprTpej8WdK9W5JZ7LM4vCWcCKUHdlt7WZrGrGYns0whFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iEOAw9qe; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=s7sakbwcgrhzfdh7vyosr47e5y.protonmail; t=1716800743; x=1717059943;
	bh=eWYAa62mplnIee/PxwqE9tQ+/yU4Kvz6fi5bUurZVcE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iEOAw9qeFwIc5CxABtDYxWkNq1aNje0ZtEH1FVggmHGmD2OCLWTWs3H82yerWuHr/
	 ZycWOaj49sUO3IZhjeXvn3h5c90mYvIrfZSxHitbWmIuemuwQZOJPJm7wQQSjx5eym
	 Zz3vwQeIKU4cPkz60aDKWGmAajvDY1EqlxS85b0IcflD5ykKCSo+ifuirFVagSb3do
	 WUHeNWi8XCX9SnqIsywtMqJXBvzISev5AzpfudUBVDAM3Sm3fPyRQh+dEVbKE8mLT7
	 VnI5+rlv1F/EOCP4x71l+L7b3qsBzv0pfvK1VIFwTwq/mFdWc7fFIpKfKLhKAFMGd3
	 rZPxPJrvJpN9g==
Date: Mon, 27 May 2024 09:05:38 +0000
To: Alice Ryhl <aliceryhl@google.com>, mu001999 <mu001999@outlook.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, boqun.feng@gmail.com, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: kernel: make impl_has_work compatible with more complex generics
Message-ID: <d11857f1-bd9f-4cc5-ab33-44d021315796@proton.me>
In-Reply-To: <CAH5fLgiL7EdnzRL79x4zX0pXrtb8OjVkRib+qkoi=TyzHzEc4A@mail.gmail.com>
References: <ME0P282MB48901A79E405F9CF615FF2F1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM> <CAH5fLgiL7EdnzRL79x4zX0pXrtb8OjVkRib+qkoi=TyzHzEc4A@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 54dc41b8a922308e1de60a831883488517210686
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.05.24 14:37, Alice Ryhl wrote:
> On Wed, May 22, 2024 at 2:27=E2=80=AFPM mu001999 <mu001999@outlook.com> w=
rote:
>>  impl_has_work! {
>> -    impl<T> HasWork<Self> for ClosureWork<T> { self.work }
>> +    impl{T} HasWork<Self> for ClosureWork<T> { self.work }
>>  }
>=20
> I ended up doing something similar for the generics in some of the
> linked list patches. Does anyone know if it's possible to support this
> without giving up the <T> syntax?

I tried to come up with something some time ago, but it was not really
nice. You have to parse the entire generics manually, which ends up
looking horrible. I have been thinking some time now that a `generics`
fragment would actually be really useful in declarative macros.

I also thought that if we get even more `Has*` traits for intrusive
datastructures, we could add a unified derive macro that allows you to
just do:

    #[derive(Intrusive)]
    struct MyStruct {
        #[intrusive]
        work: Work<Self>,
        #[intrusive]
        timer: Timer<Self>,
        /* ... */
    }

But I thought that as long as we have only two intrusive structures, we
don't need this.

---
Cheers,
Benno


