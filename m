Return-Path: <linux-kernel+bounces-544088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B86A4DD43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6C43A5192
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D37F20102D;
	Tue,  4 Mar 2025 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBVXUo/y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03A1FFC68;
	Tue,  4 Mar 2025 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089585; cv=none; b=D/k94OBhUusstm0ulZKrd2pesMPab75p9KpRkoe7NwjOhzQ7ANi/7bXUCuo6spyMAU690dku0udS6h4P4vmgMAAVbxEtLV9LXPeYFAwy6VmMRAyY1zZScHezXf7ABW1q4Hm1MlMWqQpaSBmbsWO9MG1XB1xnmWXwLkOLGKmNi2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089585; c=relaxed/simple;
	bh=m5bq3Xf/xvV68SMVybU/9ISlIyZAHVSbtdVtn0t/d3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lpf/WU9X07wgkv4NAuoUqtC5l2YkiFT8ElIAlv6Rea8zL44i731ia4+BedoyvD5aia6Wgo/z7fJfnCjrxyruTCq67nKCpV2hphUGLGq7Rv38pG9tPx8RSMo+iol6cYbYL0WisXnZWqH/etQidoiWVTo4efwgJuOhOpt1S2R61ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBVXUo/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790D1C4CEE5;
	Tue,  4 Mar 2025 11:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741089584;
	bh=m5bq3Xf/xvV68SMVybU/9ISlIyZAHVSbtdVtn0t/d3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TBVXUo/y1SMGgl9VJVdCQWdPuJUpANtODXJriLe+xWjFkxtSmC4Ye3P5SLtVpMeCs
	 XbZw74R1ZAwrxyAngwliAcddxiJZvzGlpyskJUgRQZJur+sssdJsfXHIjOqPEo/EhW
	 VC1vSV77IMoW+vkhQvJH/0w84N/gcj+RFAO1CUqxEZGC2mxNNhNPrgd63pKSe263xm
	 5aNhKA5+nj9xFiJAKnBQ3Fxc+bmcSKME83HfoCEg5df1mOEmKiV7AIyCh/1s2DKQMZ
	 6y45YLLdK2t0BboTuWn+IhYtnhw/u7E2rlFd3hn3fwMUUEqJcQn0S6e+JWmnjHvmm8
	 U1DkbK+4bjVYA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com>
Cc: <alex.gaynor@gmail.com>,  <aliceryhl@google.com>,  <apw@canonical.com>,
  <arnd@arndb.de>,  <aswinunni01@gmail.com>,  <axboe@kernel.dk>,
  <benno.lossin@proton.me>,  <bhelgaas@google.com>,
  <bjorn3_gh@protonmail.com>,  <boqun.feng@gmail.com>,  <dakr@kernel.org>,
  <dwaipayanray1@gmail.com>,  <ethan.twardy@gmail.com>,
  <fujita.tomonori@gmail.com>,  <gary@garyguo.net>,
  <gregkh@linuxfoundation.org>,  <joe@perches.com>,
  <lukas.bulwahn@gmail.com>,  <ojeda@kernel.org>,  <pbonzini@redhat.com>,
  <tmgross@umich.edu>,  <walmeida@microsoft.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 0/2] author field in module! macro should be a array
In-Reply-To: <20250223174205.48404-1-trintaeoitogc@gmail.com> (Guilherme
	Giacomo Simoes's message of "Sun, 23 Feb 2025 14:42:03 -0300")
References: <GQqgXevDlPrbDVqybjdBe8eWBr-bsr56Nmbydqom2kJLDE2mrH7hfWC0ORBSY3Qz7yaBd3mIoy9TcKjNz96hzA==@protonmail.internalid>
	<20250223174205.48404-1-trintaeoitogc@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 04 Mar 2025 12:59:34 +0100
Message-ID: <875xkphuqh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com> writes:

> In the module! macro, the author field is currently of type String.
> Since modules can have multiple authors, this limitation prevents
> specifying more than one.
>
> - Change the author field to Option<Vec<String>> to allow creating
>   modules with multiple authors.
>
> - rename the field from author to authors to make it explicit that it
>   can refer to multiple authors.
>
> - In modules that use the author field, update its value to an array of
>   strings, and also rename it from author to authors.
>
> - Change the checkpatch.pl to find poorly formatted arrays in the macro
>   module!
>
> ---
> v6 changes
> - Use consistent style in warn messages
> - Improved the commit title for checkpatch changes
> ---
>
> Guilherme Giacomo Simoes (2):
>   rust: module: change author to an array
>   checkpatch: check format of Vec<String> in modules
>
>  drivers/block/rnull.rs               |  2 +-
>  drivers/net/phy/ax88796b_rust.rs     |  2 +-
>  drivers/net/phy/qt2025.rs            |  2 +-
>  rust/kernel/net/phy.rs               |  4 +--
>  rust/kernel/pci.rs                   |  2 +-
>  rust/kernel/platform.rs              |  2 +-
>  rust/macros/lib.rs                   |  6 ++--
>  rust/macros/module.rs                | 12 ++++----
>  samples/rust/rust_driver_faux.rs     |  2 +-
>  samples/rust/rust_driver_pci.rs      |  2 +-
>  samples/rust/rust_driver_platform.rs |  2 +-
>  samples/rust/rust_minimal.rs         |  2 +-
>  samples/rust/rust_misc_device.rs     |  2 +-
>  samples/rust/rust_print_main.rs      |  2 +-
>  scripts/checkpatch.pl                | 43 ++++++++++++++++++++++++++++
>  15 files changed, 66 insertions(+), 21 deletions(-)

What is the base commit for this one?


Best regards,
Andreas Hindborg



