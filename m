Return-Path: <linux-kernel+bounces-546366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D31A4F9B8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1C53AE999
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A5720409A;
	Wed,  5 Mar 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="UiiRt7dg"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7182202C45;
	Wed,  5 Mar 2025 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166258; cv=none; b=CZHNR/y7mh/bpaUr+P07sS9Z9VdnXtdUfm83tbmKg28eYnG6OI/CUTAj5I1QQHHoPer98fTH3L9msQjhWbfirkU8L71w2cZ3hqkRDwbmYkArMLiThT7of3Dvnyj43R/zjKvqUUuHwil6KHeLFFoTIixf828Ygxj2k6ZaDrte4fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166258; c=relaxed/simple;
	bh=T0MzszHaIunjUYngwxcMkvvj3RW/T6fgFCka8uF0JmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=evz2rQ0Scds9ZGia7B693ZqqRX8YQRI9JwnGcAjrTxbxg7sxvB+H2ek8CW1btTX22/60+xZs72T02HIxBMSXhvLm7c64Mi1NkZKXAxbpbfrxdfWOwdq5D94iUffElwzQIQxrcGCdOCV6HR0RqjlRVjj48kx0/M9iLntac2CQQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=UiiRt7dg; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166252; bh=T0MzszHaIunjUYngwxcMkvvj3RW/T6fgFCka8uF0JmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UiiRt7dgE9FmdR3lgZjXn2yxdxUQTP4nbUIHIEjppFAfjqtIVEZ/yi6P+b6Wo81pH
	 WVKvkgJFrYqPEGrsHtE6MeIDu7egl3IKmech2bd7+zA+xVqSpzUHZhkIR+Xmce/We1
	 HT3KM+yinoBoyW41Pda+JajGbjvy6+nLogq2Q+bU=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,
  linux-kernel@vger.kernel.org,  rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 02/22] rust: move pin-init API into its own directory
In-Reply-To: <20250304225245.2033120-3-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:16 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-3-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:17:32 +0100
Message-ID: <m2jz93j0pf.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> In preparation of splitting off the pin-init crate from the kernel
> crate, move all pin-init API code (including proc-macros) into
> `rust/pin-init`.
>
> Moved modules have their import path adjusted via the `#[path = "..."]`
> attribute. This allows the files to still be imported in the kernel
> crate even though the files are in different directories.
>
> Code that is moved out of files (but the file itself stays where it is)
> is imported via the `include!` macro. This also allows the code to be
> moved while still being part of the kernel crate.
>
> Note that this commit moves the generics parsing code out of the GPL-2.0
> file `rust/macros/helpers.rs` into the Apache-2.0 OR MIT file
> `rust/pin_init/internal/src/helpers.rs`. I am the sole author of that
> code and it already is available with that license at [1].
> The same is true for the entry-points of the proc-macros `pin_data`,
> `pinned_drop` and `derive_zeroable` in `rust/macros/lib.rs` that are
> moved to `rust/pin_data/internal/src/lib.rs`. Although there are some
> smaller patches that fix the doctests.
>
> Link: https://github.com/Rust-for-Linux/pinned-init [1]
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

