Return-Path: <linux-kernel+bounces-564361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6599FA653A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFDA171A36
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F423CF11;
	Mon, 17 Mar 2025 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="O+T4daLR"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5E239595
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221980; cv=none; b=hPrPEu+mNKMlAX/NU1+5dqxm7ow5u9bvPvG7miQqaoFxUa39iXgKX0XcPqvkPG5AJP7CfdMgA67H5OIyGG6BQZaYufaTbLZcKpKQtmr4a798YwNvyT9kF0pqAV0hJhi+bnV9rmM1ToooJ7jb435XminMvIQf2lgnOVnyZqcDHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221980; c=relaxed/simple;
	bh=TVKK/j14D3wpA3c9J4ywxNEtSc68PYgo9aW5OzMIDhY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0P9eF6KFtYbXeubToE+Y1EB0mWXVWxega4dLpSdbnSBqggXifFZEaEOGJBVx8D52zsFa3aDkuXcAjeUNQjRPoeUjEhwTAJGlZco9FG7BIG0U3tMQd3lJRJ0Ni7uBoKG8RS9XAPMNFrDui3aHlgBXMLlY0CPtS7WRz9BJAu822o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=O+T4daLR; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=dngnbettsvhcvpi7th2bifctzm.protonmail; t=1742221976; x=1742481176;
	bh=eCEXGHds/HURmPH33bYhQdeMJFhNM2yF/567CQG5upM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=O+T4daLRPJQ9nUKvkX6IaLD9Nmebo16KY7r3a41NE/2QVPOWy+hLOSNN5hWsDac6J
	 n2VTzB7BhLZBNReZIXoiLO5yLYlA30T/ahBqLRzgodX5CxVshnp5yddBKcd4lWELal
	 DxzPzkfhDHlDlalBvyK6HsW2Qyb/GqGGYQYp4NJkdeDX0Gwrrd0EdG2eP76G/hxG5p
	 6Y6Dx5c7r2jKi7HRrch9IDqjQ0SRcwWQaYk6ErB4tGTWijPxCJMzVsgrCqpBsnw05A
	 3C8RfftBEWI5jEUYL5RM1GU4Y/rZHq++G7toWauGxDlh04sW2OuHADHzkkBOEaldsm
	 KZ1QvI8H7mJbQ==
Date: Mon, 17 Mar 2025 14:32:53 +0000
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: uaccess: name the correct function
Message-ID: <D8IM57J2C4NB.327CD9GTJ2SMR@proton.me>
In-Reply-To: <20250317-uaccess-typo-reserve-v1-1-bbfcb45121f3@gmail.com>
References: <20250317-uaccess-typo-reserve-v1-1-bbfcb45121f3@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 456dbc246db6179d66d907dc5ee5a2ff71430259
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 12:43 PM CET, Tamir Duberstein wrote:
> Correctly refer to `reserve` rather than `try_reserve` in a comment.  Thi=
s
> comment has been incorrect since inception in commit 1b580e7b9ba2 ("rust:
> uaccess: add userspace pointers").
>
> Fixes: 1b580e7b9ba2 ("rust: uaccess: add userspace pointers")
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/uaccess.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 719b0a48ff55..80a9782b1c6e 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -285,8 +285,7 @@ pub fn read_all<A: Allocator>(mut self, buf: &mut Vec=
<u8, A>, flags: Flags) -> R
>          let len =3D self.length;
>          buf.reserve(len, flags)?;
> =20
> -        // The call to `try_reserve` was successful, so the spare capaci=
ty is at least `len` bytes
> -        // long.
> +        // The call to `reserve` was successful, so the spare capacity i=
s at least `len` bytes long.
>          self.read_raw(&mut buf.spare_capacity_mut()[..len])?;
> =20
>          // SAFETY: Since the call to `read_raw` was successful, so the n=
ext `len` bytes of the
>
> ---
> base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
> change-id: 20250317-uaccess-typo-reserve-87f20265e6e2
>
> Best regards,



