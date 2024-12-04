Return-Path: <linux-kernel+bounces-431228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C769E3ACE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F0C28145E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CEE1B87F4;
	Wed,  4 Dec 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5MPXrQL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C491B4152;
	Wed,  4 Dec 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317478; cv=none; b=HekceDc8vCoAUh2ZEEILyi/Ot2c5K3uOdDl8MrPfHKLc4wd6j5sm2QyII9RtKEhFJVU65t9a6qP8h0Nb/VxyhQZhpxPa0zkGcfSQ3zKF7x7yoHS/GWeA448cuxh7s858qZDJHBvql4v7oThmp5G7y1ysMMYGYuBUBIsVCofpCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317478; c=relaxed/simple;
	bh=/llnk6+2Gfz6DE4KivF0hxJpfA6l6MHxiTdlB4n5+3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T7UkUl7diYzXJKlMg3HyW3MK3WOJfVK4Qted3Ey5Ho5D1sGqd7WGo8ye9wYO4njLNRngB9u8+HAfhHEbSMEKFO0l6qFQkSTNo212BCUYHeXc2571YD3NOG51i4lpbjaNeKXEOBtWwojw2RXBOKWZXhr08rTrbX8RYJO8DUXkIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5MPXrQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B17BC4CED1;
	Wed,  4 Dec 2024 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733317477;
	bh=/llnk6+2Gfz6DE4KivF0hxJpfA6l6MHxiTdlB4n5+3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o5MPXrQL0zp4hdTCYK4aPbxMhTZIYqESZFfraD71jbh4I4+jKTGRB8liY9Q7F6JpG
	 ioI8WisZjsXjniQU+7YWXAUrWJByPZxkOs2fNZs4sjl9lJ4r5XrTjzRgbnBb82z56s
	 r4aV+7xgg2iCD4T2oEYVrSW5Fheq/sn0f2VsEc5llu8E9cb2N7ZMOZXJW+H+4d3MpU
	 SItJNN32VdWdyW0ylpBcy0iZG/eY58/tjrSstFn5tXxKA4aBdUDUIVlZO8bMN54Dgy
	 cg1P3VUoodrh+zfOF6PFINCOm47wlJu4WE9CV4InF84nTgIS0uynLF1pFbR2cE58hF
	 avG4UHJgIQZ4w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/2] rust: xarray: Add an abstraction for XArray
In-Reply-To: <20241203-rust-xarray-bindings-v11-2-58a95d137ec2@gmail.com>
	(Tamir Duberstein's message of "Tue, 03 Dec 2024 17:43:51 -0500")
References: <20241203-rust-xarray-bindings-v11-0-58a95d137ec2@gmail.com>
	<qowmgPp19IXvbvPywLeOTTSXFLZ7lwD4WPZStqZa5gI7cits3P_eyxCwu452SAv1iwp5AL3O6izB98-6xl0rHw==@protonmail.internalid>
	<20241203-rust-xarray-bindings-v11-2-58a95d137ec2@gmail.com>
Date: Wed, 04 Dec 2024 14:04:26 +0100
Message-ID: <875xnzfvl1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> `XArray` is an efficient sparse array of pointers. Add a Rust
> abstraction for this type.
>
> This implementation bounds the element type on `ForeignOwnable` and
> requires explicit locking for all operations. Future work may leverage
> RCU to enable lockless operation.
>
> Inspired-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Inspired-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

[cut]

> +// SAFETY: It is safe to send `&XArray<T>` to another thread when the un=
derlying `T` is `Sync`
> +// because it effectively means sharing `&T` (which is safe because `T` =
is `Sync`); additionally, it
> +// needs `T` to be `Send` because any thread that has a `&XArray<T>` may=
 lock it and get a
> +// `Guard<T>` on that thread, so the thread may ultimately access `T` us=
ing a mutable reference, for
> +// example, using `get_mut` or `remove`.
> +unsafe impl<T: ForeignOwnable + Send + Sync> Sync for XArray<T> {}

Thanks, I think this is much more clear.


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



