Return-Path: <linux-kernel+bounces-348147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F87298E349
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1221F239E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755913CFA6;
	Wed,  2 Oct 2024 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Yx3mYK4t"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D283433A9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895894; cv=none; b=A7qs5aFB73Kg6zmy9mp0euwWxODiTL1PWRPu+GKm7ncwBu11Vi16x52tTwfQFpeG/ki2oDqApU6+nNStNc8By3/IN7Y18L8gjaVe8SxCIwWIIFwtsfFZ0Z9vv+FaPvShBun017QuCyq+FvbM66GjaZo/eXgF6SYCl5AlcfzEebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895894; c=relaxed/simple;
	bh=cjxMzazOMipcM1jz60XF22yUskV+jYMT+TfbytHMFL0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YF2z5bYbT3Yz+UZbbqPbhf3tT1HnrxeJuqZ1RcoEn+cQ/XORky4h322qaa17LvtkqaUn1pdbOtWFe7AFCAH0obuw0pIJTcUdbOD+vjrwBiJZlmlQVbcZfHmQbTcugiEUmtPR7/fZBH+pEBMgFI7nXyzZIOT0k0RXmXtPh7OuivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Yx3mYK4t; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727895889; x=1728155089;
	bh=9akIb4qnOADzLJh2oi1jZDxi/cwQ564uVPZn/qtrwfk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Yx3mYK4t7DSc4JRjFsOCtvopyfL9b56ZuDSYue7b2uOOFfEGwM9w2PSeIzxZ9i+0T
	 WQHoNPirjdlnZqb9q2pYlTVrd0mQqtYs9SqfUsZosZsFT9eXFVo/6/v/1Uf57rx1Xr
	 V9nmd5mI3FP3/ymbyF1LeO4r5O5GVc6ITj65XPRJso4udIwKaMn3rRdOD2CbjaYdID
	 eXoefn8hKDviJhJVDoDHl6dinS8Kg334ApC4GAWFjZcRwHLRby8fzv21/oTOns4WZ9
	 TvB8M0bMdjL5bPFnKuRcNLCBGtXkz9kAK7x3gHUpSFy3IbjIuNQ+Ddb/9pkryo2cOv
	 vTXspNFZXSxRw==
Date: Wed, 02 Oct 2024 19:04:42 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 16/29] rust: alloc: implement kernel `Vec` type
Message-ID: <c7d82c56-9632-4987-aadf-7df861a490d9@proton.me>
In-Reply-To: <Zv1kpqCihqrlCo6f@pollux>
References: <20241001150008.183102-1-dakr@kernel.org> <20241001150008.183102-17-dakr@kernel.org> <977af809-71f5-4a5a-8006-a283f8a6fc25@proton.me> <Zv1kpqCihqrlCo6f@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 528b097b375c393c59da8090d105ccdbc39165f4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.10.24 17:20, Danilo Krummrich wrote:
> On Wed, Oct 02, 2024 at 03:02:18PM +0000, Benno Lossin wrote:
>> On 01.10.24 16:59, Danilo Krummrich wrote:
>>> `Vec` provides a contiguous growable array type with contents allocated
>>> with the kernel's allocators (e.g. `Kmalloc`, `Vmalloc` or `KVmalloc`).
>>>
>>> In contrast to Rust's stdlib `Vec` type, the kernel `Vec` type consider=
s
>>> the kernel's GFP flags for all appropriate functions, always reports
>>> allocation failures through `Result<_, AllocError>` and remains
>>> independent from unstable features.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> ---
>>>  rust/kernel/alloc.rs      |   6 +
>>>  rust/kernel/alloc/kvec.rs | 637 ++++++++++++++++++++++++++++++++++++++
>>
>> Any reason against naming this `vec.rs`?
>=20
> I think I didn't rename kvec.rs and kbox.rs because we'd need to escape "=
box" in
> various places, e.g. in rust/kernel/alloc.rs:
>=20
> ```
> pub mod r#box;
>=20
> pub use self::r#box::Box;
> pub use self::r#box::KBox;
> pub use self::r#box::VBox;
> pub use self::r#box::KVBox;
> ```

Yeah, that's why `std` uses `boxed.rs`.

> And it's a kernel specific implementation, so kbox.rs and kvec.rs still m=
akes
> sense. :)

Fair.

---
Cheers,
Benno


