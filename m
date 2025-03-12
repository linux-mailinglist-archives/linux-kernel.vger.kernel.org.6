Return-Path: <linux-kernel+bounces-558307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB63A5E424
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534941796A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3A825745C;
	Wed, 12 Mar 2025 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="jVoZ+e40"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68FC1E5B71;
	Wed, 12 Mar 2025 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806574; cv=none; b=DQw5wLbztj4Tl4JYbi5LWKzSVvGXCNnC3EklR4ftHsc8FmWWlL6YD+zf10+zzMeaD1DURNC78L8mf2Y9/Bslgq5vvE7QY7txXhbTiX/6MynOsS5bHXuICqUAXnQ9D7hZBOD45jFGOhVLS2G4ouLkneN4bSxpw4ZVOaLylFKS+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806574; c=relaxed/simple;
	bh=Zjr+p94Ms+qEOumlrsyplJ+IzA+XZ5EGez4FBJy0I38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YwZ/kPyLsVe4KQUAkEPRzydvd52GJb0pWuLRQ0CT1RAf1b95bXKJmKbDm5IHl+jzqlY8J1Ue5Tu8litOIW1ZalU4i073qHUsvV0Wtyp3NvDA+kQZ9OO8ezKR1O0XkbuSIUGjbHtps+7URz9FxPNjwiSOzV4c0f0k9SuRwGn5ptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=jVoZ+e40; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741806570; bh=7MDZ/FQtrPpKNszUddqvpvcb6OpHOBdq1f05MOwaCfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jVoZ+e40R/jxk5bcBKumN2qB2eWyOSSYDzA3QHksadwBRq96jihnyWjaoQV9pn2zm
	 e/gxWEuWt0Fr0Qk64nMllk+ufRa6aVKLilOYbjTNaics6F1fBpaUIyP72df+JPnpy/
	 NBTZpB17tUf4nNcrkuaCSdvk6/ifAXPhwPujx40M=
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Danilo Krummrich <dakr@kernel.org>,  Boris-Chengbiao Zhou
 <bobo1239@web.de>,  Kees Cook <kees@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,  Lukas
 Wirth <lukas.wirth@ferrous-systems.com>
Subject: Re: [PATCH v2 7/7] scripts: generate_rust_analyzer.py: define host
 crates
In-Reply-To: <20250311-rust-analyzer-host-v2-7-30220e116511@gmail.com> (Tamir
	Duberstein's message of "Tue, 11 Mar 2025 21:17:28 -0400")
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
	<20250311-rust-analyzer-host-v2-7-30220e116511@gmail.com>
Date: Wed, 12 Mar 2025 20:09:29 +0100
Message-ID: <m25xkeysk6.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Define host crates used by the `macros` crate separately from target
> crates, now that we can uniquely identify crates with the same name.
>
> This avoids rust-analyzer thinking the host `core` crate has our target
> configs applied to it.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://lore.kernel.org/all/CANiq72mw83RmLYeFFoJW6mUUygoyiA_f1ievSC2pmBESsQew+w@mail.gmail.com/
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  scripts/generate_rust_analyzer.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index e1002867735b..4832a4901c94 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -128,10 +128,12 @@ def generate_crates(
>      # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
>      # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
>      # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
> +    host_core = append_sysroot_crate("core", [])
> +    host_alloc = append_sysroot_crate("alloc", [host_core])
> +    host_std = append_sysroot_crate("std", [host_alloc, host_core])
> +    host_proc_macro = append_sysroot_crate("proc_macro", [host_core, host_std])
> +
>      core = append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []))
> -    alloc = append_sysroot_crate("alloc", [core])
> -    std = append_sysroot_crate("std", [alloc, core])
> -    proc_macro = append_sysroot_crate("proc_macro", [core, std])
>  
>      compiler_builtins = append_crate(
>          "compiler_builtins",
> @@ -142,7 +144,7 @@ def generate_crates(
>      macros = append_proc_macro_crate(
>          "macros",
>          srctree / "rust" / "macros" / "lib.rs",
> -        [std, proc_macro],
> +        [host_std, host_proc_macro],
>      )
>  
>      build_error = append_crate(

