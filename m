Return-Path: <linux-kernel+bounces-575821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E878A70791
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618E016B605
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7225C716;
	Tue, 25 Mar 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="M3yZMJSr"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B491F78E4;
	Tue, 25 Mar 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922065; cv=none; b=d1thVuWrh39a4tHpSchyG5OhcubXpLG5dYf4lfiuRQhiqfiZ2Qubo/drKUWu1cX41F2UtX6+uKtgUQ9cNkxKGRXPeFljChNiSbP/+2WjEB0PN6oBEnaRDjXvGVe3Im1wifynvy0uZufaeImJX/mvX73zMECE+Az3Z2GaR23G8rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922065; c=relaxed/simple;
	bh=PwpIbtsMKdklh7mU8DSqzL9BZfqOSwkmWcxfEyJc++8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kfi5a98C6+zHG0cgmI+mfj1bPYDyCvVsaCrguR3ROlr4eHhbJ/uW4n++mZyfviGc/2ghTcRWOW3654/rO9MkwZg9K3ZyUCCuDv8e0FuMB4dQTUDM0++FJD5oFbH07j3J5qIdPtJ8LowWKO+OpTKMDoHgziareo3qdDc6kdyK4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=M3yZMJSr; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1742921478; bh=0RJLNZjqqj5cxoZcag+7ikIRbyKubwxWsq91NsxmA38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=M3yZMJSrPY0t0QhRXIsfJdRr0Bce4dQOJrFmJqVZJOnxDzCeQbGviQH6FHUdAruNB
	 ZLrqDxJCHtcXOl2QgEaXacuMMt0aySgv9y1Mezqq27R4LB99FI43NTasvatYKFeNTq
	 OdRZ4SbedxxmECBQgN5SJPQ7xurujal4WCdtltMw=
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
Subject: Re: [PATCH v4 04/11] scripts: generate_rust_analyzer.py: extract
 `{build,register}_crate`
In-Reply-To: <20250322-rust-analyzer-host-v4-4-1f51f9c907eb@gmail.com> (Tamir
	Duberstein's message of "Sat, 22 Mar 2025 09:23:39 -0400")
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
	<20250322-rust-analyzer-host-v4-4-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 17:51:17 +0100
Message-ID: <m2iknx9hq2.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Extract helpers from `append_crate` to avoid the need to peek into
> `crates[-1]`. This improves readability.
>
> Suggested-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  scripts/generate_rust_analyzer.py | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index e997d923268d..03f55cce673c 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -35,7 +35,14 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>      crates_indexes = {}
>      crates_cfgs = args_crates_cfgs(cfgs)
>  
> -    def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
> +    def build_crate(
> +        display_name,
> +        root_module,
> +        deps,
> +        cfg=[],
> +        is_workspace_member=True,
> +        is_proc_macro=False,
> +    ):
>          crate = {
>              "display_name": display_name,
>              "root_module": str(root_module),
> @@ -54,9 +61,26 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>                  stdin=subprocess.DEVNULL,
>              ).decode('utf-8').strip()
>              crate["proc_macro_dylib_path"] = f"{objtree}/rust/{proc_macro_dylib_name}"
> -        crates_indexes[display_name] = len(crates)
> +        return crate
> +
> +    def register_crate(crate):
> +        crates_indexes[crate["display_name"]] = len(crates)
>          crates.append(crate)
>  
> +    def append_crate(
> +        display_name,
> +        root_module,
> +        deps,
> +        cfg=[],
> +        is_workspace_member=True,
> +        is_proc_macro=False,
> +    ):
> +        register_crate(
> +            build_crate(
> +                display_name, root_module, deps, cfg, is_workspace_member, is_proc_macro
> +            )
> +        )
> +
>      def append_sysroot_crate(
>          display_name,
>          deps,
> @@ -116,20 +140,21 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>          display_name,
>          deps,
>      ):
> -        append_crate(
> +        crate = build_crate(
>              display_name,
>              srctree / "rust" / display_name / "lib.rs",
>              deps,
>              cfg=cfg,
>          )
> -        crates[-1]["env"]["OBJTREE"] = str(objtree.resolve(True))
> -        crates[-1]["source"] = {
> +        crate["env"]["OBJTREE"] = str(objtree.resolve(True))
> +        crate["source"] = {
>              "include_dirs": [
>                  str(srctree / "rust" / display_name),
>                  str(objtree / "rust")
>              ],
>              "exclude_dirs": [],
>          }
> +        register_crate(crate)
>  
>      append_crate_with_generated("bindings", ["core"])
>      append_crate_with_generated("uapi", ["core"])

