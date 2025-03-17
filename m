Return-Path: <linux-kernel+bounces-564442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B19A6550A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFED718884F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E022459E0;
	Mon, 17 Mar 2025 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SUN/e+Em"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AAE143748;
	Mon, 17 Mar 2025 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224021; cv=none; b=Evk726JEGRPdiSLupmKIbb/HvHkFFAHBzFQ/ScblDamKwgLBef6SWVNr+AWTavyzTXYb9WDXC8tbXVjrxYvh7gMjkbBRRltbXxdbFwx0f7R38asJZX+o7AkBief2BgJDQyXLKlgfuYXOTCoMw8CtOrXSDnTS8tml4GHyiX2V0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224021; c=relaxed/simple;
	bh=SnfkXWnpxDUvaevMyD1OEmjq28ap9kFJGa4zZ0H+LVo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYlZsQVIMNJmkYmde4L9zyrVQVedZBh/ARyN9hJmDhTk4qO5IjbgaKW2GGDkcjqRrnMpAlzNrEp7iNIzvqRhduwtuSRW9iBcZouSJEASYeqCvBhFdxqo3UZcG4dclcR0M29KZj3+iZsj9+4OIn3eVD2uuMFBVzKZW2b//KNzImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SUN/e+Em; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742224018; x=1742483218;
	bh=SnfkXWnpxDUvaevMyD1OEmjq28ap9kFJGa4zZ0H+LVo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=SUN/e+Em6PY0C4IgZtPNyXcgBju87M0js2sq7QjSugEWRp4J5TI2mlG/K8PiDkZBy
	 oWW0s+l5+IPPOYXOGB8dz73vSvrfu8qBlBfYCQg+YM4tKSbhhXAwlJ8ci3hmrzBkfd
	 iLsFTB+doCNTsrsw5oY9A+sVLhDaCzaNZ519zj2muvspv1uDb8kUbYtIRYjDQA3fxZ
	 kpZf04IqIFFVHlDG1y48H0I2xfBGx3rrYeRsc8h2zlBvLq85ipEplXYPg+4v0NdigR
	 4bSCypgahAdecC3+Tu4Bj0Zf/lkK5uhRA8JDe4KpzJLbda+JS0zNCSJsFXIbyk5wCr
	 DqMMKhAR0w9qw==
Date: Mon, 17 Mar 2025 15:06:51 +0000
To: Antonio Hickey <contact@antoniohickey.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, gary@garyguo.net, justinstitt@google.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v2] rust: uaccess: mark UserSliceWriter method inline
Message-ID: <D8IMV6MH4EVX.3BWHLLY5UGLC0@proton.me>
In-Reply-To: <20250316185439.913013-1-contact@antoniohickey.com>
References: <D8HVNR3Q3UL8.1007IZIZTQ0XB@proton.me> <20250316185439.913013-1-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: cb721d3e4912cf4cfc2f0722b4ac03cd556c493c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 16, 2025 at 7:54 PM CET, Antonio Hickey wrote:
> On Sun, Mar 16, 2025 at 05:47:40PM +0000, Benno Lossin wrote:
>> On Thu Mar 13, 2025 at 3:57 AM CET, Antonio Hickey wrote:
>> > When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
>> > toolchain provided by kernel.org with ARCH=3Dx86_64, the following sym=
bol
>> > is generated:
>> >
>> > $nm vmlinux | grep ' _R' | rustfilt | rg UserSliceWriter
>> > ffffffff817c3390 T <kernel::uaccess::UserSliceWriter>::write_slice
>> >
>> > However, this Rust symbol is a trivial wrapper around the function
>> > copy_to_user. It doesn't make sense to go through a trivial wrapper
>> > for this function, so mark it inline.
>> >
>> > After applying this patch, the above command will produce no output.
>> >
>> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> > Link: https://github.com/Rust-for-Linux/linux/issues/1145
>> > Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
>>=20
>> What about the other methods (like `write` and `read`?) in this file?
>
> Hey Benno,
>
> The other methods in this file were handled with the patch
> linked below. This was one of my first patches, so I was
> unaware of patch sets and did 2 seperate patches.
>
> Link to other patch: https://lore.kernel.org/all/010001958798b97c-4da7647=
e-d0bc-4f81-9132-ad24353139cb-000000@email.amazonses.com/

Ah I see.

> Do you think it would be best to send these as new patch which
> includes both of these patches? also if so would it be ok to
> start that new patch set at v1 ?

I don't 100% know what to do here, maybe Miguel can help. Personally,
I'd think that another v1 is confusing, but I have seen people in the
past add patches to their already existing series (while incrementing
the version number). I think it's a good idea to merge the patches into
a single one that handles the entire file though.

> Sorry for the confusion I'm new to kernel dev and patches,
> but starting to get the hang of it now.

No worries.

---
Cheers,
Benno


