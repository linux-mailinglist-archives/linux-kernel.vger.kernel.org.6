Return-Path: <linux-kernel+bounces-517478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B1A38158
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7324E7A1377
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452EB217730;
	Mon, 17 Feb 2025 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srLFFVP4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159215E5B8;
	Mon, 17 Feb 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790521; cv=none; b=hHaxoCKfs+72+kmiukR30Pf14vGXrNOvs9v0YwqNyb9lAVqGlSFewhFDVhIQH5kXKr3VBEey5iIm6LFgh+gRntOsGuKfTHKnYfJ24iIdNxkXvxE012l1rZmo5K/HH8z9wec86I3Jb0iHA5yW6+gnda1YQmH70Dzmi0hD8ojVhqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790521; c=relaxed/simple;
	bh=f7HxxSip1OHtS3snSOSlajm5o6Hp86tWJqoUOgiGvOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c914uwqnqhgIYxVU6LfNTk2ngXwr4GD18Or7HBP6BZ+dmZfNOihc8AqtToeFJJv2Z31zCDPFQX9umz/ZLdFxi/4Jx2ZSryw4tVyIhIiSDWOTW2fazlhBKURNc9KYsc40Sj7C8k7JRTpye0DeJbq6nXxI5PQvC7Y6Vmy500opAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srLFFVP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6494C4CED1;
	Mon, 17 Feb 2025 11:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739790521;
	bh=f7HxxSip1OHtS3snSOSlajm5o6Hp86tWJqoUOgiGvOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=srLFFVP4Kig0hXER8uC7oFhCfEx/Qdaf+ULz1OXPO+SZRTAveubJNzeWXOajKU6zT
	 ltN5fjhdQ6nZwNDT/+VsFJzbzaBGhPU5/VsxULo1zHwVg4qs9QUhcQkMxKdN3kYEpp
	 TvkM8kDexrbUG30akqy6Lw0ASgLBk8M3KwkMt9/K0VcSXQvO71C8udMa2El2n8pDPo
	 xlOIKVx6LuRCauNLgJLZ7NWAJj9e6Chux1ZYoxX/dqaG5F6Aqw8PkfniayVhzvKdlO
	 szSunIXsWMknQxqyggX9WmzQYeWqOnOFzoQY74kTjL+PXMAqkNogEq5Kj7JtsXyfVX
	 qbF474sCmy3hw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Charalampos Mitrodimas" <charmitro@posteo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Joel Becker" <jlbec@evilplan.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Peter Zijlstra" <peterz@infradead.org>,  "Ingo Molnar"
 <mingo@redhat.com>,  "Will Deacon" <will@kernel.org>,  "Waiman Long"
 <longman@redhat.com>,  "Fiona Behrens" <me@kloenk.dev>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] rust: configfs: introduce rust support for configfs
In-Reply-To: <m2pljh7ts7.fsf@posteo.net> (Charalampos Mitrodimas's message of
	"Sun, 16 Feb 2025 16:12:40 +0000")
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org>
	<20250207-configfs-v2-2-f7a60b24d38e@kernel.org>
	<7hDprGyxOMnSaQtcT29L1mkOUHyHbMqY2iiHmxhZMV43YjK5jqY52VPWyqiOtqZgopNrLIYnypGHOrtB4O4qwA==@protonmail.internalid>
	<m2pljh7ts7.fsf@posteo.net>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 17 Feb 2025 08:36:26 +0100
Message-ID: <87seodt43p.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Charalampos Mitrodimas" <charmitro@posteo.net> writes:

> Andreas Hindborg <a.hindborg@kernel.org> writes:
>
>> diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
>> new file mode 100644
>> index 0000000000000..fe896e66efb41
>> --- /dev/null
>> +++ b/samples/rust/rust_configfs.rs
>> @@ -0,0 +1,186 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Rust configfs sample.
>> +
>> +use kernel::alloc::flags;
>> +use kernel::c_str;
>
> [...snip...]
>
>> +impl Configuration {
>> +    fn new() -> impl PinInit<Self, Error> {
>> +        try_pin_init!(Self {
>> +            message: c_str!("Hello World\n"),
>> +            bar <- new_mutex!((KBox::new([0;4096], flags::GFP_KERNEL)?,0)),
>> +        })
>> +    }
>> +}
>> +
>> +impl kernel::InPlaceModule for RustConfigfs {
>> +    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
>> +        pr_info!("Rust configfs sample (init)\n");
>> +
>> +        let item_type = configfs_attrs! {
>> +            container: configfs::Subsystem<Configuration>,
>> +            data: Configuration,
>> +            child: Child,
>> +            attributes: [
>> +                message: 0,
>> +                bar: 1,
>> +            ],
>> +        };
>> +
>> +        try_pin_init!(Self {
>> +            config <- configfs::Subsystem::new(
>> +                kernel::c_str!("rust_configfs"), item_type, Configuration::new()
>
> Hi Andreas,
>
> One more nit I found, "kernel::c_str" is already imported in the
> sample. So this can be changed to "c_str!("rust_configfs")".

Thanks!


Best regards,
Andreas Hindborg




