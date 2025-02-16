Return-Path: <linux-kernel+bounces-516663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C63A37583
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9965416F0F9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6F3199E8D;
	Sun, 16 Feb 2025 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="PlHTgw5T"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391519258C
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722367; cv=none; b=Tyl2WQ/PZVub8vaMFwaVlcA5oTdBQLodhX040l0sgI3mbLSLwRnB6d020X9EfTLiSAeNrTYS5TJuwL5mCNRze5HbQgx0DwWwsXYKXAt0Ngxw+opZBc8vIyvUtgywxAa0I0ee87ik5L8SORmW7t8jV2z1MIT+FIv6m2Ql4ksZF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722367; c=relaxed/simple;
	bh=723XmAli1Pr4klnTxzebdDpR93Vg/3V7DVZwDO2NZ1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UM24NxLpmpFFPxNHiV6HF7tsOGWvyBqdXjC2kWK5nMrLemVFXziYjp847MBwHNjG2zSONDejeEpkxu1ExZ38yUT1XQ/vKZmfHNXKUuW/UUjOem69Ig6jf9mugr5Iwk6MhP7lexXLidnc7LACrVvOc4oVqcbEYPrxl1K8uU14UbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=PlHTgw5T; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4ABE5240101
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 17:12:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739722364; bh=723XmAli1Pr4klnTxzebdDpR93Vg/3V7DVZwDO2NZ1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=PlHTgw5TK4JZbwxe1lIKjtI0c9nZ5fEPypUgrfkJl07xkXaOUs4Ug86RsVzQ8ftXM
	 m/J2UmS9yACzkYa/cM1hbKaq4+CBYbNMyJDjarmiiFVjbe1Ny0kZKDbHIVGv0YDenU
	 ZAgViUjFT83abrfNSK8EEAhElpvz9Lk8yD92IRhKMLKPbP++a34tXs7xOZPpba8DkX
	 hqpIZAP3I4EzS6Nn7E2N9uW6k99kTJbePYSbFOJGF3jghMyeSPM1CiE34Mwz3fiMqR
	 FXzyq6L8jYpVlCPnqG8I2KYcLlo4wNxdMy7xlgvnW1GS1wdI4T9ny2iN2T/g9lp07L
	 QrsDh4TI7BNKA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YwrRF0Cbnz6ty5;
	Sun, 16 Feb 2025 17:12:40 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>,  Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,
  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Benno Lossin <benno.lossin@proton.me>,  Alice Ryhl
 <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,  Joel Becker
 <jlbec@evilplan.org>,  Christoph Hellwig <hch@lst.de>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Will Deacon
 <will@kernel.org>,  Waiman Long <longman@redhat.com>,  Fiona Behrens
 <me@kloenk.dev>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: configfs: introduce rust support for configfs
In-Reply-To: <20250207-configfs-v2-2-f7a60b24d38e@kernel.org>
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org>
	<20250207-configfs-v2-2-f7a60b24d38e@kernel.org>
Date: Sun, 16 Feb 2025 16:12:40 +0000
Message-ID: <m2pljh7ts7.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Hindborg <a.hindborg@kernel.org> writes:

> diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
> new file mode 100644
> index 0000000000000..fe896e66efb41
> --- /dev/null
> +++ b/samples/rust/rust_configfs.rs
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust configfs sample.
> +
> +use kernel::alloc::flags;
> +use kernel::c_str;

[...snip...]

> +impl Configuration {
> +    fn new() -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            message: c_str!("Hello World\n"),
> +            bar <- new_mutex!((KBox::new([0;4096], flags::GFP_KERNEL)?,0)),
> +        })
> +    }
> +}
> +
> +impl kernel::InPlaceModule for RustConfigfs {
> +    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
> +        pr_info!("Rust configfs sample (init)\n");
> +
> +        let item_type = configfs_attrs! {
> +            container: configfs::Subsystem<Configuration>,
> +            data: Configuration,
> +            child: Child,
> +            attributes: [
> +                message: 0,
> +                bar: 1,
> +            ],
> +        };
> +
> +        try_pin_init!(Self {
> +            config <- configfs::Subsystem::new(
> +                kernel::c_str!("rust_configfs"), item_type, Configuration::new()

Hi Andreas,

One more nit I found, "kernel::c_str" is already imported in the
sample. So this can be changed to "c_str!("rust_configfs")".

C. Mitrodimas

> +            ),
> +        })
> +    }
> +}
> +

