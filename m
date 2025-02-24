Return-Path: <linux-kernel+bounces-530156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AFEA42FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7F2189C38B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E427A1EF0B4;
	Mon, 24 Feb 2025 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="asekGxe/"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE971C84AF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434832; cv=none; b=BagIaXUzQ6ZriaPqehlSUJLkQSwtPq/aKQc5qOh/+Qg+nF6JvVAEUThGS/sDgel03ZOMO1ZkrN4j4ar7HGAWvcNMC9Jsuv/SFlRjcpZGxmlHIT8h4maExAa5eJGvHRhktSto6sNuG3CCgjKwYIgh8JI9QBF3sCbGra7mEt5tPpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434832; c=relaxed/simple;
	bh=lh72fUHnQKCu8U2uloovD2z3Vs2Q0L9/A46WrO7JrkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UxdT6G02m2ydnVxW/noMpJOob/CqjBcO9vY94+yEKrudykO7HEveeW5mxkp8nqeSlDRLl0u3VtzyTvXCSb2N9QUWPULpvqfBLEFzvpeKx+F3nFLnzssZNl+ZoZN3frkIMs2yoOxF1+//BwDpx7dzOX3Mzt8GpIL/5hmsVsDc2Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=asekGxe/; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 15F16240101
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:07:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1740434828; bh=lh72fUHnQKCu8U2uloovD2z3Vs2Q0L9/A46WrO7JrkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=asekGxe/NAGwP8HjIvxV8I4HULlcZob4e0JSUZAixbPjjygSNbrBOIE5D/zunhMkl
	 mYuvIeGV4CLe2z40ygmPGKDYs4qXMui61DeP+3vLdtXE87kZq3Zn5gMueicDelgVgd
	 OSyfPcbKNIAPCFTEo4iqrlGKt5Y+KEqG+twKIqNw44O58bbPFJNuu4EU3HKQ2tDTLw
	 efgWFHTg6FI3dIcBnl2aHSWyGl8gyehwjX7hU6qZfcL6H8kQVsDIRG7eDqqv1nHLjy
	 GGY4AS8PaWfuQSjWKk6gWIrGsMDENO6Y3WzEpxEptu5zKrlap9urrD2JQRIY5JLcwt
	 qcgAtMbCBqbng==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z1vwP06cHz9rxL;
	Mon, 24 Feb 2025 23:07:00 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org,  alex.gaynor@gmail.com,  aliceryhl@google.com,
  apw@canonical.com,  arnd@arndb.de,  aswinunni01@gmail.com,
  axboe@kernel.dk,  benno.lossin@proton.me,  bhelgaas@google.com,
  bjorn3_gh@protonmail.com,  boqun.feng@gmail.com,  dakr@kernel.org,
  dwaipayanray1@gmail.com,  ethan.twardy@gmail.com,
  fujita.tomonori@gmail.com,  gary@garyguo.net,
  gregkh@linuxfoundation.org,  joe@perches.com,  lukas.bulwahn@gmail.com,
  ojeda@kernel.org,  pbonzini@redhat.com,  tmgross@umich.edu,
  walmeida@microsoft.com,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH V6 1/2] rust: module: change author to an array
In-Reply-To: <20250223174205.48404-2-trintaeoitogc@gmail.com>
References: <20250223174205.48404-1-trintaeoitogc@gmail.com>
	<20250223174205.48404-2-trintaeoitogc@gmail.com>
Date: Mon, 24 Feb 2025 22:07:00 +0000
Message-ID: <m2wmdfov3v.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guilherme Giacomo Simoes <trintaeoitogc@gmail.com> writes:

> In the module! macro, the author field is currently of type String.
> Since modules can have multiple authors, this limitation prevents
> specifying more than one.
> Change the author field to Option<Vec<String>> to allow creating modules
> with multiple authors. Additionally, rename the field from author to
> authors to make it explicit that it can refer to multiple authors.  In
> modules that use the author field, update its value to an array of
> strings, and also rename it from author to authors.
>
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/244
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  drivers/block/rnull.rs               |  2 +-
>  drivers/net/phy/ax88796b_rust.rs     |  2 +-
>  drivers/net/phy/qt2025.rs            |  2 +-
>  rust/kernel/net/phy.rs               |  4 ++--
>  rust/kernel/pci.rs                   |  2 +-
>  rust/kernel/platform.rs              |  2 +-
>  rust/macros/lib.rs                   |  6 +++---
>  rust/macros/module.rs                | 12 +++++++-----
>  samples/rust/rust_driver_faux.rs     |  2 +-
>  samples/rust/rust_driver_pci.rs      |  2 +-
>  samples/rust/rust_driver_platform.rs |  2 +-
>  samples/rust/rust_minimal.rs         |  2 +-
>  samples/rust/rust_misc_device.rs     |  2 +-
>  samples/rust/rust_print_main.rs      |  2 +-
>  14 files changed, 23 insertions(+), 21 deletions(-)

Rust side looks good to me. Thanks!

Reviewed-by: Charalampos Mitrodimas <charmitro@posteo.net>

