Return-Path: <linux-kernel+bounces-558300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33500A5E411
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3543B99A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC8C2566DA;
	Wed, 12 Mar 2025 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="q5hB89+5"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD31DE894;
	Wed, 12 Mar 2025 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806260; cv=none; b=I4MUVyZzsWpD5bSI4LTcs4zAdN7NjJ30RUUyT2+uWNM8ugwfSZl7F3B1WF9tdy3zR4x1gczvWOm5GgdXS07kD7xEULifISiQddjO2TvWmA/8imP81qHJYMGmmyY2qGkdY8jMha3sjl4W1RTLLrjVmmy/RmxJAWv8H3SvYKkUlcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806260; c=relaxed/simple;
	bh=Zk8i5HmfvNJKk8brm4RepmOhkuxCW4tk5l1A+9IAx6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Svhhvng7KO9NF+j8gT+CJTYCAK/u6EY5ctQVIkDOLa5s8fxwUPMjLkvGUa/ujNyfbof3iK+w8LVf2UN1h2ULEgDIOq5LzdGjgQuzWHcbi/MYJz/VqQYowNeTlVUH55sbvRrOdb6HWQqdB0mDNlCLFG22kTSbFSufA/H+bQYjQxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=q5hB89+5; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741806256; bh=N8wuEU6COjQxVv+sgO6yxuYIPBjg4GnzWyiG0P5tB9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=q5hB89+5fkPVmY9OCT2xOeCxUBn4o8DeqqphLMFGaorJjjXlteg02ptft3qw6eAgW
	 DfAwnk9qJtI5JNCFt162u0p5iCouKOK5+5Cdxt/rdvCLGlgmcsuNa7jYsDpCa5DTI4
	 O/pR2qtvsATk4wXFCfxjfELUh7ZA367QzE/etyAc=
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
Subject: Re: [PATCH v2 5/7] scripts: generate_rust_analyzer.py: use
 str(pathlib.Path)
In-Reply-To: <20250311-rust-analyzer-host-v2-5-30220e116511@gmail.com> (Tamir
	Duberstein's message of "Tue, 11 Mar 2025 21:17:26 -0400")
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
	<20250311-rust-analyzer-host-v2-5-30220e116511@gmail.com>
Date: Wed, 12 Mar 2025 20:04:15 +0100
Message-ID: <m2h63yyssw.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Use the `/` operator on `pathlib.Path` rather than directly crafting a
> string. This is consistent with all other path manipulation in this
> script.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  scripts/generate_rust_analyzer.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index c73ea8d116a4..1bb185ae2e87 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -109,7 +109,7 @@ def generate_crates(
>          crate: ProcMacroCrate = {
>              **crates[-1],
>              "is_proc_macro": True,
> -            "proc_macro_dylib_path": f"{objtree}/rust/{proc_macro_dylib_name}",
> +            "proc_macro_dylib_path": str(objtree / "rust" / proc_macro_dylib_name),
>          }
>          crates[-1] = crate

