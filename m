Return-Path: <linux-kernel+bounces-559205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9169A5F0E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B98F7A20D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8E4265CCB;
	Thu, 13 Mar 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bdQNUlmB"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88265265CBE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861785; cv=none; b=KJt7AG7esE+WY7Mx43r14RlVFvcTb7i6eXPOt8gKeShOPeAt14iDkbCe0voexVxKDURPvToAO9ORVbjAp2+yDEahzq3UHWYF5O8ToiKmvqV6B3VdYz4gMtuNucxK84HjyUxre3YQTql+3iP98lJBdAii5RqIxWKvL8Ejz5ChWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861785; c=relaxed/simple;
	bh=kx3fT1v+s8zGn26DjIZXyTiNRIbzYWcAF0u7mBfjOPQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4ImjrsVBsEoN1kPlxhnQ7ee0XBn15ufHByv7c033OKXQDZP12KWbeGbUaXeaxDqbKu3x8nWqH7j6JTBofSjCvBX45ZCsz9dLZPkMIvMR/DqMlTNeptZPVA/h/rj0z319jfpDG+X4PG9dNdx3Mipi+0g8W7EC2cyGYO1egxHLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bdQNUlmB; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741861780; x=1742120980;
	bh=1l1YD43ep1fYD3ethMW94e1z8mHLgTYZKv75z5Pq3J8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bdQNUlmB2uRwVvRUjh+dMyMaUJTBn4DBUYhK9FLvPjn3/KBsRQof7TcQh6vN+QLBB
	 gX4Scjseu3F0yqeF+GSYGfXuRfXgCTASKzcO3a8lYKixMgVfYJgqioCOOC28JbnzE/
	 OCNgjGhOxTbsvN29U+YYLh0kOausIYBS2HXDRJi2pwG+lTRrVGJIi0InHs58vIhLt6
	 YgwZJNNKjgZ5zmDgOwvyjOSWAsccI7oVZj4dM9RqNs6l1MlWOQVoTH9VZLSU416IGH
	 hZDlAmK5BAmlFtP0FqXmS/jSyLMfwa5ajVxRVXfiKSWWuoPyWJfPbLR0xt0shM4QBe
	 3YDLp3BJTjFbg==
Date: Thu, 13 Mar 2025 10:29:35 +0000
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: device: implement device context marker
Message-ID: <D8F2GQ4WYT7Z.172Z7R7V8BIGR@proton.me>
In-Reply-To: <20250313021550.133041-3-dakr@kernel.org>
References: <20250313021550.133041-1-dakr@kernel.org> <20250313021550.133041-3-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1064acdb2a8582f09ec1586ce41697ae9e397b0e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
> Some bus device functions should only be called from bus callbacks,
> such as probe(), remove(), resume(), suspend(), etc.
>
> To ensure this add device context marker structs, that can be used as
> generics for bus device implementations.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I would have folded this into #3, but if you prefer it being split, then
it's also fine.

> ---
>  rust/kernel/device.rs | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index db2d9658ba47..39793740a95c 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -209,6 +209,24 @@ unsafe impl Send for Device {}
>  // synchronization in `struct device`.
>  unsafe impl Sync for Device {}
> =20
> +/// Marker trait for the context of a bus specific device.
> +///
> +/// Some functions of a bus specific device should only be called from a=
 certain context, i.e. bus
> +/// callbacks, such as `probe()`.
> +///
> +/// This is the marker trait for structures representing the context of =
a bus specific device.
> +pub trait DeviceContext {}

I would make this trait sealed. ie:

    pub trait DeviceContext: private::Sealed {}
   =20
    mod private {
        pub trait Sealed {}

        impl Sealed for super::Core {}
        impl Sealed for super::Normal {}
    }

Since currently a user can create a custom context (it will be useless,
but then I think it still is better to give them a compile error).

If you make it sealed,

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> +
> +/// The [`Normal`] context is the context of a bus specific device when =
it is not an argument of
> +/// any bus callback.
> +pub struct Normal;
> +impl DeviceContext for Normal {}
> +
> +/// The [`Core`] context is the context of a bus specific device when it=
 is supplied as argument of
> +/// any of the bus callbacks, such as `probe()`.
> +pub struct Core;
> +impl DeviceContext for Core {}
> +
>  #[doc(hidden)]
>  #[macro_export]
>  macro_rules! dev_printk {



