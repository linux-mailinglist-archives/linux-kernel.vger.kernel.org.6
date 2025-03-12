Return-Path: <linux-kernel+bounces-558306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F997A5E420
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3A63A86DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5002257ACF;
	Wed, 12 Mar 2025 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="o0EUd4mx"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CF205ADB;
	Wed, 12 Mar 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806444; cv=none; b=j84vTcac8cntQUCHsjkYvpv0VaHV0Dc+kMEVfFyug8icC7fsNcuM8IgO9Fe4q370sWwkFAGH9iKZZK14wYjInSDxDwKuefdw5J3GjywLRJcpGa4wsg1iSgH/6P65EwKoB6GuzYgVjBc965ftfDvQLAiSYKoWjS2AMYokhlowN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806444; c=relaxed/simple;
	bh=SyaFTKZ7T03+jJl0W+0s//2hk0DOpMOQ406VM/Anb7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e8VlZs5QeLFe0nbwCTZ7bTfKHgk+scdVkoN+RNB7reADTBph6IwH7Q+ShoyS37u7ILIoWZVFAX5KB/i+zPDQt+psPoEcV0mg2mtAoDsnNV8JBVm34DRZm+PiR2XQB0DcECUhxD/wJq+3qwxo76UN1h565BiunWsZLeeVdgdBdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=o0EUd4mx; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741806440; bh=aOIegVe1qBGkz1Vo5b+Yf5odl6qP2FtFoBd+7/masDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=o0EUd4mx+5ywTDN0A71SdbPtEqwduDhUFxg7AB4cSBzHT8pe3dk1gw6xaTdNJJmHX
	 GP3/oOai770ImbDknLj/od6KzpAJPPPBRLOFw2TlRXjKkTQvn3f1r/RC52hSdQgjmW
	 qPFsTPLjoC9Et5DtXoGunod4E2ekr7oAFGNOGBYk=
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
Subject: Re: [PATCH v2 6/7] scripts: generate_rust_analyzer.py: identify
 crates explicitly
In-Reply-To: <20250311-rust-analyzer-host-v2-6-30220e116511@gmail.com> (Tamir
	Duberstein's message of "Tue, 11 Mar 2025 21:17:27 -0400")
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
	<20250311-rust-analyzer-host-v2-6-30220e116511@gmail.com>
Date: Wed, 12 Mar 2025 20:07:19 +0100
Message-ID: <m2bju6ysns.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Use the return of `append_crate` to declare dependency on that crate.
> This allows multiple crates with the same display_name be defined, which
> we'll use to define host crates separately from target crates.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  scripts/generate_rust_analyzer.py | 60 +++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index 1bb185ae2e87..e1002867735b 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -68,40 +68,38 @@ def generate_crates(
>              line = line.replace("\n", "")
>              cfg.append(line)
>  
> -    # Now fill the crates list -- dependencies need to come first.
> -    #
> -    # Avoid O(n^2) iterations by keeping a map of indexes.
> +    # Now fill the crates list.
>      crates: list[Crate] = []
> -    crates_indexes: dict[str, int] = {}
>      crates_cfgs = args_crates_cfgs(cfgs)
>  
>      def append_crate(
>          display_name: str,
>          root_module: pathlib.Path,
> -        deps: list[str],
> +        deps: list[Dependency],
>          cfg: list[str] = [],
>          is_workspace_member: bool = True,
> -    ) -> None:
> -        crates_indexes[display_name] = len(crates)
> +    ) -> Dependency:
> +        index = len(crates)
>          crates.append({
>              "display_name": display_name,
>              "root_module": str(root_module),
>              "is_workspace_member": is_workspace_member,
> -            "deps": [{"crate": crates_indexes[dep], "name": dep} for dep in deps],
> +            "deps": deps,
>              "cfg": cfg,
>              "edition": "2021",
>              "env": {
>                  "RUST_MODFILE": "This is only for rust-analyzer"
>              },
>          })
> +        return {"crate": index, "name": display_name}
>  
>      def append_proc_macro_crate(
>          display_name: str,
>          root_module: pathlib.Path,
> -        deps: list[str],
> +        deps: list[Dependency],
>          cfg: list[str] = [],
> -    ) -> None:
> -        append_crate(display_name, root_module, deps, cfg)
> +    ) -> Dependency:
> +        dep = append_crate(display_name, root_module, deps, cfg)
>          proc_macro_dylib_name = subprocess.check_output(
>              [os.environ["RUSTC"], "--print", "file-names", "--crate-name", display_name, "--crate-type", "proc-macro", "-"],
>              stdin=subprocess.DEVNULL,
> @@ -112,13 +110,14 @@ def generate_crates(
>              "proc_macro_dylib_path": str(objtree / "rust" / proc_macro_dylib_name),
>          }
>          crates[-1] = crate
> +        return dep
>  
>      def append_sysroot_crate(
>          display_name: str,
> -        deps: list[str],
> +        deps: list[Dependency],
>          cfg: list[str] = [],
> -    ) -> None:
> -        append_crate(
> +    ) -> Dependency:
> +        return append_crate(
>              display_name,
>              sysroot_src / display_name / "src" / "lib.rs",
>              deps,
> @@ -129,34 +128,34 @@ def generate_crates(
>      # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
>      # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
>      # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
> -    append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []))
> -    append_sysroot_crate("alloc", ["core"])
> -    append_sysroot_crate("std", ["alloc", "core"])
> -    append_sysroot_crate("proc_macro", ["core", "std"])
> +    core = append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []))
> +    alloc = append_sysroot_crate("alloc", [core])
> +    std = append_sysroot_crate("std", [alloc, core])
> +    proc_macro = append_sysroot_crate("proc_macro", [core, std])
>  
> -    append_crate(
> +    compiler_builtins = append_crate(
>          "compiler_builtins",
>          srctree / "rust" / "compiler_builtins.rs",
>          [],
>      )
>  
> -    append_proc_macro_crate(
> +    macros = append_proc_macro_crate(
>          "macros",
>          srctree / "rust" / "macros" / "lib.rs",
> -        ["std", "proc_macro"],
> +        [std, proc_macro],
>      )
>  
> -    append_crate(
> +    build_error = append_crate(
>          "build_error",
>          srctree / "rust" / "build_error.rs",
> -        ["core", "compiler_builtins"],
> +        [core, compiler_builtins],
>      )
>  
>      def append_crate_with_generated(
>          display_name: str,
> -        deps: list[str],
> -    ) -> None:
> -        append_crate(
> +        deps: list[Dependency],
> +    ) -> Dependency:
> +        dep = append_crate(
>              display_name,
>              srctree / "rust" / display_name / "lib.rs",
>              deps,
> @@ -174,10 +173,11 @@ def generate_crates(
>              }
>          }
>          crates[-1] = crate
> +        return dep
>  
> -    append_crate_with_generated("bindings", ["core"])
> -    append_crate_with_generated("uapi", ["core"])
> -    append_crate_with_generated("kernel", ["core", "macros", "build_error", "bindings", "uapi"])
> +    bindings = append_crate_with_generated("bindings", [core])
> +    uapi = append_crate_with_generated("uapi", [core])
> +    kernel = append_crate_with_generated("kernel", [bindings, build_error, core, macros, uapi])
>  
>      def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
>          try:
> @@ -207,7 +207,7 @@ def generate_crates(
>              append_crate(
>                  name,
>                  path,
> -                ["core", "kernel"],
> +                [core, kernel],
>                  cfg=cfg,
>              )

