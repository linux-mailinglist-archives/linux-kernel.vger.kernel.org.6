Return-Path: <linux-kernel+bounces-336012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 772E397EE03
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160CA1F224D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DA719D07F;
	Mon, 23 Sep 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dFnDf6sp"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C919E97D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104863; cv=none; b=JkyMW/xNJik2qcEhJXPoSEzzWGfF5LlOG84OGnbcULG4yohhyYU/HPv0KQLKKsrMudGx7XU2EJpG34nwbKgqD1dLagy8A0IKfWWodt0rZGwQUPSBHhEFveGU/wjz5wzo2T9b3Ql3iV7fIBy2onHfYqW3ZhwQ5Kzp0L/ZAmnDp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104863; c=relaxed/simple;
	bh=qRK8erESDoj/VGuxUkzCOARJof2dyb53GE6yLTCVJFI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5GxjX91NaK1Fzc/kXelKEJ/mRtzPPZgWpGa0ETDe91QQGdw7SckdAL4nHZVgrwdTyfctiym5445Bh47mtC7l+4W1W8HFIQWJsJjwyIN3hBRNEziJj2CSFgLqXf2vyCdajnSU9WqgAdXaFQFhvFOdwx1yLhqbDGhk6q+3iqVokY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dFnDf6sp; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727104853; x=1727364053;
	bh=0JfDey84iUMift6zk9vaR/CUHVMn8iF7HIi/NrhHSk0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dFnDf6spcQaDgTLolhxQWtRgOJLbrQ4uHwF093qDyE7QZ91aizMj90HjGa/IUKOZc
	 gg2VfRTXEIEFxvTKXQ711EDk/af6XJYLhQcHnZbevhTa8sS6O0feP0cl/miVlofKLL
	 ahPUx49s6ixRn449ArOnLXUo0p7Ra86xT7r9RmesQtmEvohmRJsMKlv1wrEH22STWl
	 hqpp5x/imm3OupKk4kIaXsCrDkX23zzQH+s4a+SioNeaXMPtyLWpd6Xey0xiYiXLUp
	 X3M1mRcEG7gauKhavMqRFc0TeBRFAWrnZfisje5GaroqOZPN2z515v+aqnKpZ1wEhv
	 JnurBrAoKcG3A==
Date: Mon, 23 Sep 2024 15:20:43 +0000
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] rust: alloc: pass `old_layout` to `Allocator`
Message-ID: <eaad9eb3-dca9-4943-a58e-06824e8811c2@proton.me>
In-Reply-To: <CAH5fLgievsJOe7QET+Wh2c0upygv-nhSnOuTN8K_QkruLwOPgA@mail.gmail.com>
References: <20240911225449.152928-2-dakr@kernel.org> <20240921153315.70860-1-dakr@kernel.org> <CAH5fLgievsJOe7QET+Wh2c0upygv-nhSnOuTN8K_QkruLwOPgA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 87f1742c4bb8bcf29568e811e3ed5914f8c136ea
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.09.24 15:56, Alice Ryhl wrote:
> On Sat, Sep 21, 2024 at 5:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>> @@ -84,11 +92,18 @@ unsafe fn call(
>>          &self,
>>          ptr: Option<NonNull<u8>>,
>>          layout: Layout,
>> +        old_layout: Layout,
>>          flags: Flags,
>>      ) -> Result<NonNull<[u8]>, AllocError> {
>>          let size =3D aligned_size(layout);
>>          let ptr =3D match ptr {
>> -            Some(ptr) =3D> ptr.as_ptr(),
>> +            Some(ptr) =3D> {
>> +                if old_layout.size() =3D=3D 0 {
>> +                    ptr::null()
>> +                } else {
>> +                    ptr.as_ptr()
>> +                }
>> +            }
>=20
> This is making Allocator work with zero-sized types, which deviates
> from std. We should not do that without a reason. What is the reason?

The global allocator doesn't support it, but the `Allocator` trait from
std handles zero-sized allocations. For example, this code runs as
expected:

    #![feature(allocator_api)]
   =20
    use std::alloc::{self, Allocator, Layout};
   =20
    fn main() {
        let alloc: &dyn Allocator =3D &alloc::Global;
        let ptr =3D alloc.allocate(Layout::new::<()>()).unwrap().cast::<u8>=
();
        unsafe { alloc.deallocate(ptr, Layout::new::<()>()) };
    }

https://play.rust-lang.org/?version=3Dnightly&mode=3Ddebug&edition=3D2021&g=
ist=3D0a2d12ee6dabf16f2ebd67cc6faa864e

---
Cheers,
Benno


