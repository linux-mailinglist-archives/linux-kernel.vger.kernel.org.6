Return-Path: <linux-kernel+bounces-341050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE58987AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4858D1C21346
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B0018871D;
	Thu, 26 Sep 2024 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YvribKNh"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6749E188718;
	Thu, 26 Sep 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727386830; cv=none; b=FiLxjTG7TDNovdqK5wb6vHl4YrcypxCpmNc7RtXaU8oNl7MObYvt6ZG2/MQv9RACce8E/4DDCHbC5Jnow6GBSLgaZ6hOnhngYP5V7jJM7HxbVXqi+jWhlAqg64AA03eu2Dh+FMgKqINXkCiOrFkbR4qjjfM7VYrw9Q4yXfN/p84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727386830; c=relaxed/simple;
	bh=B7vVPtZ0skY5FAludoXro885xOLXk8EAwxQticUA94c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo4WuA0vBQwHRIk+6WvST0zLqm6CcWRLC3Q8Cmgbvisfi9VbWi3Ym3TVadNh4ZcEfZr7eJ2Ki+GW3ye1MA3dBbpp20xiWoYUXIjkLLGE434OBsna05V1afJwqcsxS1qz+Cx8kcazan1pe3T1KLslkH2m97K1zfuae9HcRTq9ULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YvribKNh; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727386825; x=1727646025;
	bh=8JZiwTNKPdrlm0PpRytCP7gUnAE5sqgqBO+t6Ghc4o8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YvribKNhRHHF3+aARNb+CloZhudPnB4aPPPmYT4gN2L96f23wXEhx+aeWlGXaucwN
	 Z4PTIXwUlmfFXi9a+VZiXLRIvD3wLpF+1Z4v3IHcU5+gJtUO3oyRh5CHclGV1WjeR0
	 GY3rzBFiKldzqTkLAntQAzoZcRzNICZaxePQ8rQYYtOQf2APAp+1eP0JIn9NPZpQTj
	 6eFBO6/0sofebcqx0ouKp13RGLlepYcUzw3ynwrvV8BsICxaA5WsEqG/wOxz2/tVd4
	 4/eLfK7PuDUXYSIRmvQJaTjovXcYq7CumAUlGIdXvz3Y41C4DmWvSv3+wELAbQpUBI
	 DoP/jmZ+sIOLg==
Date: Thu, 26 Sep 2024 21:40:20 +0000
To: kernel test robot <lkp@intel.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, Greg KH <greg@kroah.com>, Simona Vetter <simona.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add untrusted data abstraction
Message-ID: <42d17306-1ac6-4fc7-ab1b-69ef045039ac@proton.me>
In-Reply-To: <202409270303.kUIAmOmY-lkp@intel.com>
References: <20240925205244.873020-2-benno.lossin@proton.me> <202409270303.kUIAmOmY-lkp@intel.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e840ec57a19f56c25884f431c181eaf12177f3e5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.09.24 22:31, kernel test robot wrote:
> Hi Benno,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on a2f11547052001bd448ccec81dd1e68409078fbb]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Benno-Lossin/rust-=
add-untrusted-data-abstraction/20240926-045445
> base:   a2f11547052001bd448ccec81dd1e68409078fbb
> patch link:    https://lore.kernel.org/r/20240925205244.873020-2-benno.lo=
ssin%40proton.me
> patch subject: [PATCH v2 1/2] rust: add untrusted data abstraction
> config: x86_64-buildonly-randconfig-002-20240927 (https://download.01.org=
/0day-ci/archive/20240927/202409270303.kUIAmOmY-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b=
5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240927/202409270303.kUIAmOmY-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409270303.kUIAmOmY-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>>> error[E0004]: non-exhaustive patterns: `Err(_)` not covered
>    --> rust/kernel/validate.rs:188:15
>    |
>    188 |         match unsafe { value.__init(ptr) } {
>    |               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ pattern `Err(_)` not cove=
red
>    |
>    note: `core::result::Result<(), Infallible>` defined here
>    --> /opt/cross/rustc-1.78.0-bindgen-0.65.1/rustup/toolchains/1.78.0-x8=
6_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/result.rs:502:=
1
>    |
>    502 | pub enum Result<T, E> {
>    | ^^^^^^^^^^^^^^^^^^^^^
>    ...
>    511 |     Err(#[stable(feature =3D "rust1", since =3D "1.0.0")] E),
>    |     --- not covered
>    =3D note: the matched value is of type `core::result::Result<(), Infal=
lible>`
>    help: ensure that all possible cases are being handled by adding a mat=
ch arm with a wildcard pattern or an explicit pattern as shown
>    |
>    189 ~             Ok(()) =3D> {},
>    190 +             Err(_) =3D> todo!()

I didn't include the `Err` variant here, since on nightly it would give
me this error:

    error: unreachable pattern
       --> rust/kernel/validate.rs:190:13
        |
    190 |             Err(i) =3D> match i {},
        |             ^^^^^^ matches no values because `Infallible` is unin=
habited
        |
        =3D note: to learn more about uninhabited types, see https://doc.ru=
st-lang.org/nomicon/exotic-sizes.html#empty-types
        =3D note: `-D unreachable-patterns` implied by `-D warnings`
        =3D help: to override `-D warnings` add `#[allow(unreachable_patter=
ns)]`
   =20
    error: aborting due to 1 previous error

I can reproduce this error locally in a Rust project, but am unable to
do so on play.rust-lang.org. That seems very strange to me, anyone else
on 1.83 or 1.82 can confirm? AFAIK, it was stabilized in 1.82, see [1].

I would like to use `#[cfg("rust version <=3D 1.82")]`, but I don't know
how to do that. Do we already have support for checking the version in a
cfg? The alternative would be `#[allow(unreachable_patterns)]`, but I
would like to avoid that.

[1]: https://github.com/rust-lang/rust/issues/119612

---
Cheers,
Benno

>    |
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


