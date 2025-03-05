Return-Path: <linux-kernel+bounces-546375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA3A4F9CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1285C7A42AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2677A2045B1;
	Wed,  5 Mar 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="nADFrSc4"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C820409A;
	Wed,  5 Mar 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166487; cv=none; b=rU0VGHlxfkUwvTgJzGJkPx+jx0dMOO/ZZj+07uxjTBGziWS1tNQn1AaK/fqx0o3eWSyVLjUVvJZ3zjQIDkLoZo/fYtmteRMrwV6NK2r/KZRV9R5QfjamndYhaTO3cqHyRl0MXoHO2ujSnIRGttzfxPfuCjlIImWJXXJxjJzQUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166487; c=relaxed/simple;
	bh=RzH8f+YEeaAxwcY1AsQ3MVt16XmCZfnfjxAuCrf46Ew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hEk8MTsbXZjCV9uGW4RW178oX6wHD77gZZZM/C8/FYy9160x9XHMQQ3/XON0Jb81QSRkFvAWCPgbzSADVuOI+BMvb4bNg4ZT2eVpMIdDHCLzVJtHGyIiyJApibLib31zIRpGFGMt7AZOTkhTyYtVQloQjrEBqN1utDyVqo3mpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=nADFrSc4; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166484; bh=RzH8f+YEeaAxwcY1AsQ3MVt16XmCZfnfjxAuCrf46Ew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nADFrSc4DBqkBzSXaU5G8VJ7FsNLtSnHiykb4VdkA6XKK6VWgN1/Sn+LXfelkLXCr
	 fDYwqEJrkqlVri1O2peNySY/jwQtRlGgACgFfsPkgqkFJDcl2dO9CoWR6u30xmhMcd
	 sqXckrln2gTkqGGkmpase+sKsrYdgi3vgAWtoigY=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/22] rust: pin-init: move the default error behavior
 of `try_[pin_]init`
In-Reply-To: <20250304225245.2033120-8-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:54:07 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-8-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:21:23 +0100
Message-ID: <m2r03bhlyk.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> Move the ability to just write `try_pin_init!(Foo { a <- a_init })`
> (note the missing `? Error` at the end) into the kernel crate.
> Remove this notation from the pin-init crate, since the default when no
> error is specified is the kernel-internal `Error` type. Instead add two
> macros in the kernel crate that serve this default and are used instead
> of the ones from `pin-init`.
>
> This is done, because the `Error` type that is used as the default is
> from the kernel crate and it thus prevents making the pin-init crate
> standalone.
>
> In order to not cause a build error due to a name overlap, the macros in
> the pin-init crate are renamed, but this change is reverted in a future
> commit when it is a standalone crate.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

