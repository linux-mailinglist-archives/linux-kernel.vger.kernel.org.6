Return-Path: <linux-kernel+bounces-525990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90F5A3F846
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CEB42189D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCA8210F6B;
	Fri, 21 Feb 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="If+Hh8Te"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532C1FECD9;
	Fri, 21 Feb 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151176; cv=pass; b=WKAFckhRPuXq9qGS5VykgT6PXYnPrVW8QVcEnCmFZF60cqzme3uNqS4gikp8NuCPbjAzfsboO+Nu3dnc7odP5OTunQZbrQWb0BoKZzm7fNFrjukuspOnnHT+zj+arWuvDEZf3KewEd10nOGJwHs03BR8gq8HppwrtDU6KQDf9oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151176; c=relaxed/simple;
	bh=c11apE4KyetOBxX2ZcYLZYt40rmLUhIJWe6ojYWaWjg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=u0dllSbgi6hggRBmRESnAnH/wcSk065Tn8MZQucjctHfkKUEWy7sYpvY8szotCe4zHwWH9djIGUQKeVkv6faNypAiqSw/4ymsqXKySROxDfHOyLB4AWUJoipfd2aZFN9RPSXkKO0XoJJyDDX1Q2hbJJk7y13U2zKfjcXgBUnCLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=If+Hh8Te; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740151123; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vb/21qAMD7WKHEAE7bihQnNekvu5lHgNF2gLArzbG00Kjoyya93Mmw0W+LxrP0z6eB1nNylQ/D6XAb87EJCEqIqAXTUbQTeWK+P9uopXgZ/0BlFQrs0pKyDFW8nJtwY3KRwbi9y+NurBn4QbeHUkX7HJCoTSWggN1HD0R68OhFQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740151123; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sBwO97KzPhVvIgN0rKIzQNTIANncm1Be9D5nF3F7nA4=; 
	b=RN53GOGQHSXZtbs1bHgcupBL2ShXrshksvJBDsYSTLn+d4DAPCLsvr9VxEZpdUQNmlyGKzf9DI/kbjpDNaJ008hT5brQ9EfKb+3tsQflOqWRfcDKilsJRlIHsYHpzw9ecUtGGBd65kA6LDDnBxnzJQEadukKXHuMiTLyCH8hMgo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740151123;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=sBwO97KzPhVvIgN0rKIzQNTIANncm1Be9D5nF3F7nA4=;
	b=If+Hh8TeMBSQxX+/49eTXO37Dxnih/BeTE5aIulaeuXILIMe1z1CZj7O4g4kOCpr
	4VKBnwYrXxRFIG1Odz0FTyaiuRCzFoE8hHnG/sRFuyhqVsZZNHNEcCbecVBE6i9EQxe
	JoMLd6JlXCh7UNuStlOuIWtfqWO/0ZMnKXd1Ue7c=
Received: by mx.zohomail.com with SMTPS id 1740151120758203.9884280564803;
	Fri, 21 Feb 2025 07:18:40 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v3 0/4] rust: configfs abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
Date: Fri, 21 Feb 2025 12:18:24 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>,
 Fiona Behrens <me@kloenk.dev>,
 Charalampos Mitrodimas <charmitro@posteo.net>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <50E0963F-2CFA-462E-9767-626F0D18C77F@collabora.com>
References: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Andreas,

> On 18 Feb 2025, at 09:57, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> This series adds a safe Rust API that allows Rust modules to interface
> the `configfs` machinery.
>=20
> The series contains an example for the samples folder to demonstrate
> usage of the API. As such, there is no inline example in the
> documentation.
>=20
> The last patch adds a maintainer entry for the Rust configfs
> abstractions, to make it absolutely clear that I will commit to =
maintain
> these abstractions, if required. Feel free to drop this patch if this =
is
> not required.
>=20
> The series is a dependency of `rnull`, the Rust null block driver.
> Please see [1] for initial `configfs` support in `rnull`.
>=20
> [1] =
https://github.com/metaspace/linux/tree/9ac53130f5fb05b9b3074fa261b445b8fd=
e547dd/drivers/block/rnull
>=20

I am trying to test this before reviewing, but I get this error:


```
error[E0308]: mismatched types
   --> linux/rust/kernel/miscdevice.rs:300:62
    |
300 |     let device =3D unsafe { <T::Ptr as =
ForeignOwnable>::borrow(private) };
    |                           ---------------------------------- =
^^^^^^^ expected `*mut <... as ForeignOwnable>::PointedTo`, found `*mut =
c_void`
    |                           |
    |                           arguments to this function are incorrect
    |
    =3D note: expected raw pointer `*mut <<T as =
miscdevice::MiscDevice>::Ptr as types::ForeignOwnable>::PointedTo`
               found raw pointer `*mut ffi::c_void`
    =3D help: consider constraining the associated type `<<T as =
miscdevice::MiscDevice>::Ptr as types::ForeignOwnable>::PointedTo` to =
`ffi::c_void` or calling a method that returns `<<T as =
miscdevice::MiscDevice>::Ptr as types::ForeignOwnable>::PointedTo`
    =3D note: for more information, visit =
https://doc.rust-lang.org/book/ch19-03-advanced-traits.html
note: associated function defined here
   --> /home/dwls/dev/linux/rust/kernel/types.rs:98:15
    |
98  |     unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> =
Self::Borrowed<'a>;
    |               ^^^^^^

error: aborting due to 1 previous error
```


=E2=80=94 Daniel=

