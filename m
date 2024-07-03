Return-Path: <linux-kernel+bounces-239958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B298926742
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD37C1C2153D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B93118508C;
	Wed,  3 Jul 2024 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="AWEb8G1d"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01B17556B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028119; cv=none; b=Gj7kaJ1gjuzgp9K58+ka0rJt8amNSnRxjyqdNUIUjb6/di06CUhdHAdav2e29+l40tiB0qCVzYmFW81i4+A/Y4wDeLObTLEcC2nHfW22qWISURmRzpE4MIzaSSmLz1W75tT1UP0xzlye8aLJjvyOPs5b4Ir2Ia6ODbEE9DFNzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028119; c=relaxed/simple;
	bh=TmV9z1ND2wapaoce+nMP1vO1mkuNVwGThZes7xbSuPw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=f/X1yOrm6lXzzG3qnCrpHZG3yZ0MyzicjSFafTulBmaNoxWS9iLDl9N5ZOGukCPwXYtxjvR8KePTbF/0B5yFTt+3Fmdtq32qypSVEg/4DzOaHrMJI/WJdu8GTnu1eQnzMBmb7Ja0TFZ6r5XXQ4vg8LVXhiIiqfl3UjBBpniNojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=AWEb8G1d; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1720028115; x=1720287315;
	bh=gniYypZ3LP7QAPnNrXZK2ZYj2l0EPUwDaXbCV7MZwL0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AWEb8G1dKw2A6g/Ke2AkSiMEfa6pzWIalqov0scU5XmrYZRMA7RDk9L7zRvAmkVVT
	 FWQ56RAFQg+7KNbUoYji/lqAiGjS+E7xbZ0kb2OnlPVRBZHxV/vLpJ53RHMn1HAHi0
	 R3ieGdz9zZDRlV/ihEbiCWbEajeAsMs0VJ2OWIUb+b+o5naetMO5Nn0roea2eb8QB7
	 tESuFjehiu4lTA782IFQeXUdLapa0a3AeAQLqOU/xUecUNIPdThh01f5ID0Yuv4d+o
	 J526+iYpsK+OlsrOSvcx8Y/SBuZ2n3MBknO+elpKx8ltkJsa0llcwJzKLhP5wCitu+
	 I3X3LxdpCu9QA==
Date: Wed, 03 Jul 2024 17:35:09 +0000
To: Miguel Ojeda <ojeda@kernel.org>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 00/13] Support several Rust toolchain versions
Message-ID: <87a5iy8jlm.fsf@metaspace.dk>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: add2598dfefaf55cc1fdb6f02e421deba54a5cdc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Miguel,

Miguel Ojeda <ojeda@kernel.org> writes:

> Hi all,
>
> It is time to start supporting several Rust toolchain versions and thus
> establish a minimum Rust compiler and `bindgen` version.
>
> For the Rust compiler, we will start with a window of two stable
> releases, and widen it over time. This series keeps the minimum where
> it is (1.78.0), but adds support for the recently released 1.79.0.
>
> This should already be enough for kernel developers in distributions that
> provide recent Rust compiler versions routinely, such as Arch Linux,
> Debian Unstable (outside the freeze period), Fedora Linux, Gentoo
> Linux (especially the testing channel), Nix (unstable) and openSUSE
> Tumbleweed. A documentation adds the instructions for each of them.
>
> In addition, Rust for Linux is now being built-tested in Rust's
> pre-merge CI. That is, every change that is attempting to land into the
> Rust compiler is tested against the kernel, and it is merged only if it
> passes -- thanks to the Rust project for that!
>
> Thus, with the pre-merge CI in place, both projects hope to avoid
> unintentional changes to Rust that break the kernel. This means that,
> in general, apart from intentional changes on their side (that we will
> need to workaround conditionally on our side), the upcoming Rust compiler
> versions should generally work.
>
> For instance, currently, the beta (1.80.0) and nightly (1.81.0) branches
> work as well.
>
> Similarly, we kept the minimum as it is for `bindgen`. `bindgen` is also
> adding the kernel to its CI -- thanks!
>
> Cheers,
> Miguel
>

Applied the series to [1], based on v6.9:

rustup override set --path ../rnull-v6.9-build 1.76.0
make O=3D../rnull-v6.9-build LLVM=3D1

Builds fine.

rustup override set --path ../rnull-v6.9-build 1.79.0
make O=3D../rnull-v6.9-build LLVM=3D1

make[1]: Entering directory '/home/aeh/src/linux-rust/rnull-v6.9-build'
  GEN     Makefile
mkdir -p /home/aeh/src/linux-rust/rnull-v6.9-build/tools/objtool && make O=
=3D/home/aeh/src/linux-rust/rnull-v6.9-build subdir=3Dtools/objtool --no-pr=
int-directory -C objtool
  CALL    /home/aeh/src/linux-rust/rnull-v6.9/scripts/checksyscalls.sh
  INSTALL libsubcmd_headers
  RUSTC L rust/core.o
error: data-layout for target `target-12379853866016577623`, `e-m:e-p270:32=
:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128`, differs from LL=
VM target's `x86_64-linux-gnu` default layout, `e-m:e-p270:32:32-p271:32:32=
-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128`

error: aborting due to 1 previous error

make[3]: *** [/home/aeh/src/linux-rust/rnull-v6.9/rust/Makefile:461: rust/c=
ore.o] Error 1
make[2]: *** [/home/aeh/src/linux-rust/rnull-v6.9/Makefile:1206: prepare] E=
rror 2
make[1]: *** [/home/aeh/src/linux-rust/rnull-v6.9/Makefile:240: __sub-make]=
 Error 2
make[1]: Leaving directory '/home/aeh/src/linux-rust/rnull-v6.9-build'
make: *** [Makefile:240: __sub-make] Error 2
error: Recipe `lo` failed with exit code 2


rm ../rnull-v6.9-build/rust
make O=3D../rnull-v6.9-build LLVM=3D1

same result.

rm ../rnull-v6.9-build/rust
<configure>
make O=3D../rnull-v6.9-build LLVM=3D1

same result.

Maybe because I am on v6.9?


Best regards,
Andreas


[1] https://github.com/metaspace/linux/tree/rnull-v6.9


