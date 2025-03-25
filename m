Return-Path: <linux-kernel+bounces-575798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A458A7074E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4CE97A3250
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16825EF9B;
	Tue, 25 Mar 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmd57MrW"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C519F487;
	Tue, 25 Mar 2025 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921299; cv=none; b=NcTWf21vyAXuIAkxgpCjeLWwPg7eFD37ulJP9+CclFmeCkOl9/ePVWNWzpTzCo8WU7+qlTgHWXmuac7swDEYIY1cJPqUQWUIGg5zGPp/6WXyAqTR0FACv88PQKt/JivMwJNDcKBwVvZ9CEzvB7WrPkIZ0GJwe8r1ycFuaxirjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921299; c=relaxed/simple;
	bh=jm/UIpIa+DRncjCZYMobXTGE/6Cw2CD02HFh7rhjXZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Elz+Jxz+yhTzKOkQzSuKtQCHam8NVSsf98WkegILSbaczvNYnQ+vMuP0xytfbb9ZkC6SGybpe7UtIOSEsomGx/WcfdrC5Es4AVaFT9co5XbquI4a26DvLVJUCL7748qdHPrIne7iKw6zp66xhUaQdRKWrvYNy0i0iNzZb6VRsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fmd57MrW; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3061513d353so62797251fa.2;
        Tue, 25 Mar 2025 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742921295; x=1743526095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZWdVyF1dVP9LR+RLK4qbT+17MdFgmj6SGnm2Ccky2g=;
        b=Fmd57MrWeLj3AurmR4PBcBdvOXRs6QDcz4+uCpdYJn9wSXQcALqzB/Q0hfbG1FXhlW
         I7cvvpzZqs3hD1/TCJ7AL2hq2Vw2ZDq/iGSNdq2xgmYgi//zDl6DSMqjSW9cESgRxmEQ
         U/PsuYx7yWZJB9btEJhWNxt9papAz0kfs78HaC1BkDO8i2byn1SDypm50fdVsEq/QdUc
         Wm2yzFDN+/sbOvCZ8dL7Ce+GvYY18swEjkA2U9c7irsJD7myzDxuUeanCuLaInKx8mop
         hB+Syvhm5+pZGdP0qHkHLT/NLdwbY4LZ57h/w7xeFP0tVAldTIg7qv1/NiBYYX7xH7SY
         Kzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742921295; x=1743526095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZWdVyF1dVP9LR+RLK4qbT+17MdFgmj6SGnm2Ccky2g=;
        b=PKNQjMLssbC6duNMR3mknEtdyvtn39uOqgseN5JH4CSVUe/I3GjONHl7MIVvpONdnu
         MaKbQ6A5tpeu6nxkgdfZ+QwdfQrw2H26rcpy0VYTJXVZSy1QhmdZNYctsu4BLRxGhxqq
         rvkzUey/uC0/RU05XN8n9Wmk3RbuPFeHcArtJWo4OhibTrCaeEMpu2MB2VFY77S+8e7l
         jFQJ+SzRd5lZkhd/9bTUw6zqLPzmgRMr+jgllFRb+mi1VvWGTgUABGd854NgbhYoVohe
         ALUhsHnnWWK94lMILnDAwarqNgi6NUIyJ2tZkqPMoue5MjxgeJcOQXTKmNxKBkvrmBsE
         7ubw==
X-Forwarded-Encrypted: i=1; AJvYcCWtUnZpRTh8HzvWCziRrIBc5hCcwWpSgNTBnuKKk546XEfERshPe2CN7X5T7bwJDWeFZDnynIZ9YvHlnpE=@vger.kernel.org, AJvYcCXvjgEICbzrTY+k3AyhoYKMjAWBwq96JflxWn531lKmJWMBwb4vOARZzFx45j637RLo+to5rPvhzl5jU7bFA+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWjO7sonwgLqLgMdeI3lGGquN/9sLpMp4X4DndYJdKx515/2q
	To30hccrsdmjVROE09/Ns6H1tq5aLpZscnBqz4FvnVcSQxc1DSBE4nhz48NShc2UQBEzua7juDi
	RI3rWEKNQerb84CIBdganhcmx4B+KoArrMIHes/qG
X-Gm-Gg: ASbGncvoX50Az5Y7J0oqUqu4ugcPjnII7F0mzoeWL/oihZJB6t8ZP12NGiOkIU9QtPT
	48qg3XYXjIfoufl7p8rxg2CqWfd/+LBwlobthOdJDs9m2YJknTcumfcLtgsFGSF6BeQWHuT0HyO
	jzfLysjrlbqhiSUEYvOj7/u3KLHsJ2+p/hk6sblVBv2w==
X-Google-Smtp-Source: AGHT+IHQB/czXmiUJiPPMGRL9tAccKmd/a9mxIQ4w9v7vG+SKzccmiaxdxbee2H5ybv2bfBIyRD48J9sKI4ILNucQ5A=
X-Received: by 2002:a2e:9e9a:0:b0:30c:557:72b0 with SMTP id
 38308e7fff4ca-30d7e22179cmr54341211fa.14.1742921294705; Tue, 25 Mar 2025
 09:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-5-1f51f9c907eb@gmail.com> <FB3D0F03-B162-4AD5-B288-4E307421276B@collabora.com>
In-Reply-To: <FB3D0F03-B162-4AD5-B288-4E307421276B@collabora.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 12:47:38 -0400
X-Gm-Features: AQ5f1JrHPsU6rf0AbWqkxFqmSCdpRDdrQs6HDLjbojrrQlzK02_11FN0wzzCcMI
Message-ID: <CAJ-ks9nOY7DaOEO856Xj3g0+54yh5CbVgH=94xV+wG7gs+cMWA@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] scripts: generate_rust_analyzer.py: add type hints
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Wirth <lukas.wirth@ferrous-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 9:38=E2=80=AFAM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hi Tamir,
>
> > On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > Python type hints allow static analysis tools like mypy to detect type
> > errors during development, improving the developer experience.
> >
> > Python type hints have been present in the kernel since 2019 at the
> > latest; see commit 6ebf5866f2e8 ("kunit: tool: add Python wrappers for
> > running KUnit tests").
> >
> > Run `mypy --strict scripts/generate_rust_analyzer.py --python-version
> > 3.8` to verify. Note that `mypy` no longer supports python < 3.8.
> >
> > This removes `"is_proc_macro": false` from `rust-project.json` in
> > exchange for stricter types. This field is interpreted as false if
> > absent[1] so this doesn't change the behavior of rust-analyzer.
>
> Can this be a separate patch? Not sure how this is related to Python type
> hints, but it makes the current patch harder to review.

Yeah, I'll pop it out into another patch.

> >
> > Link: https://github.com/rust-lang/rust-analyzer/blob/8d01570b5e812a49d=
aa1f08404269f6ea5dd73a1/crates/project-model/src/project_json.rs#L372-L373 =
[1]
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> > scripts/generate_rust_analyzer.py | 172 +++++++++++++++++++++++++------=
-------
> > 1 file changed, 112 insertions(+), 60 deletions(-)
> >
> > diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_=
analyzer.py
> > index 03f55cce673c..0772ea309f94 100755
> > --- a/scripts/generate_rust_analyzer.py
> > +++ b/scripts/generate_rust_analyzer.py
> > @@ -10,8 +10,10 @@ import os
> > import pathlib
> > import subprocess
> > import sys
> > +from typing import Dict, Iterable, List, Literal, Optional, TypedDict
> >
> > -def args_crates_cfgs(cfgs):
> > +
> > +def args_crates_cfgs(cfgs: Iterable[str]) -> Dict[str, List[str]]:
> >     crates_cfgs =3D {}
> >     for cfg in cfgs:
> >         crate, vals =3D cfg.split("=3D", 1)
> > @@ -19,7 +21,45 @@ def args_crates_cfgs(cfgs):
> >
> >     return crates_cfgs
> >
> > -def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs)=
:
> > +
> > +class Dependency(TypedDict):
> > +    crate: int
> > +    name: str
> > +
> > +
> > +class Source(TypedDict):
> > +    include_dirs: List[str]
> > +    exclude_dirs: List[str]
> > +
> > +
> > +class Crate(TypedDict):
> > +    display_name: str
> > +    root_module: str
> > +    is_workspace_member: bool
> > +    deps: List[Dependency]
> > +    cfg: List[str]
> > +    edition: Literal["2021"]
> > +    env: Dict[str, str]
> > +
> > +
> > +# `NotRequired` fields on `Crate` would be better but `NotRequired` wa=
s added in 3.11.
> > +class ProcMacroCrate(Crate):
> > +    is_proc_macro: Literal[True]
> > +    proc_macro_dylib_path: Optional[str]  # `pathlib.Path` is not JSON=
 serializable.
> > +
> > +
> > +# `NotRequired` fields on `Crate` would be better but `NotRequired` wa=
s added in 3.11.
> > +class CrateWithGenerated(Crate):
> > +    source: Optional[Source]
> > +
> > +
> > +def generate_crates(
> > +    srctree: pathlib.Path,
> > +    objtree: pathlib.Path,
> > +    sysroot_src: pathlib.Path,
> > +    external_src: pathlib.Path,
> > +    cfgs: List[str],
> > +) -> List[Crate]:
> >     # Generate the configuration list.
> >     cfg =3D []
> >     with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
> > @@ -31,67 +71,75 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
> >     # Now fill the crates list -- dependencies need to come first.
> >     #
> >     # Avoid O(n^2) iterations by keeping a map of indexes.
> > -    crates =3D []
> > -    crates_indexes =3D {}
> > +    crates: List[Crate] =3D []
> > +    crates_indexes: Dict[str, int] =3D {}
> >     crates_cfgs =3D args_crates_cfgs(cfgs)
> >
> >     def build_crate(
> > -        display_name,
> > -        root_module,
> > -        deps,
> > -        cfg=3D[],
> > -        is_workspace_member=3DTrue,
> > -        is_proc_macro=3DFalse,
> > -    ):
> > -        crate =3D {
> > +        display_name: str,
> > +        root_module: pathlib.Path,
> > +        deps: List[str],
> > +        cfg: List[str] =3D [],
> > +        is_workspace_member: bool =3D True,
> > +    ) -> Crate:
> > +        return {
> >             "display_name": display_name,
> >             "root_module": str(root_module),
> >             "is_workspace_member": is_workspace_member,
> > -            "is_proc_macro": is_proc_macro,
> >             "deps": [{"crate": crates_indexes[dep], "name": dep} for de=
p in deps],
> >             "cfg": cfg,
> >             "edition": "2021",
> >             "env": {
> >                 "RUST_MODFILE": "This is only for rust-analyzer"
> > -            }
> > +            },
> >         }
> > -        if is_proc_macro:
> > -            proc_macro_dylib_name =3D subprocess.check_output(
> > -                [os.environ["RUSTC"], "--print", "file-names", "--crat=
e-name", display_name, "--crate-type", "proc-macro", "-"],
> > -                stdin=3Dsubprocess.DEVNULL,
> > -            ).decode('utf-8').strip()
> > -            crate["proc_macro_dylib_path"] =3D f"{objtree}/rust/{proc_=
macro_dylib_name}"
> > -        return crate
> > -
> > -    def register_crate(crate):
> > +
> > +    def register_crate(crate: Crate) -> None:
> >         crates_indexes[crate["display_name"]] =3D len(crates)
> >         crates.append(crate)
> >
> >     def append_crate(
> > -        display_name,
> > -        root_module,
> > -        deps,
> > -        cfg=3D[],
> > -        is_workspace_member=3DTrue,
> > -        is_proc_macro=3DFalse,
> > -    ):
> > +        display_name: str,
> > +        root_module: pathlib.Path,
> > +        deps: List[str],
> > +        cfg: List[str] =3D [],
> > +        is_workspace_member: bool =3D True,
> > +    ) -> None:
> >         register_crate(
> > -            build_crate(
> > -                display_name, root_module, deps, cfg, is_workspace_mem=
ber, is_proc_macro
> > -            )
> > +            build_crate(display_name, root_module, deps, cfg, is_works=
pace_member)
> >         )
> >
> > +    def append_proc_macro_crate(
> > +        display_name: str,
> > +        root_module: pathlib.Path,
> > +        deps: List[str],
> > +        cfg: List[str] =3D [],
> > +    ) -> None:
> > +        crate =3D build_crate(display_name, root_module, deps, cfg)
> > +        proc_macro_dylib_name =3D subprocess.check_output(
> > +            [os.environ["RUSTC"], "--print", "file-names", "--crate-na=
me", display_name, "--crate-type", "proc-macro", "-"],
> > +            stdin=3Dsubprocess.DEVNULL,
> > +        ).decode('utf-8').strip()
> > +        proc_macro_crate: ProcMacroCrate =3D {
> > +            **crate,
> > +            "is_proc_macro": True,
> > +            "proc_macro_dylib_path": f"{objtree}/rust/{proc_macro_dyli=
b_name}",
> > +        }
> > +        register_crate(proc_macro_crate)
> > +
>
> Same here. Is this supposed to be related to Python type hints somehow?

Same here - moved into a separate patch.

> >     def append_sysroot_crate(
> > -        display_name,
> > -        deps,
> > -        cfg=3D[],
> > -    ):
> > -        append_crate(
> > -            display_name,
> > -            sysroot_src / display_name / "src" / "lib.rs",
> > -            deps,
> > -            cfg,
> > -            is_workspace_member=3DFalse,
> > +        display_name: str,
> > +        deps: List[str],
> > +        cfg: List[str] =3D [],
> > +    ) -> None:
> > +        register_crate(
>
> Why is register_crate here now? Maybe this change belongs to the precedin=
g patch?

Good spot, this didn't need to change. Reverted in this patch.

>
> > +            build_crate(
> > +                display_name,
> > +                sysroot_src / display_name / "src" / "lib.rs",
> > +                deps,
> > +                cfg,
> > +                is_workspace_member=3DFalse,
> > +            )
> >         )
> >
> >     # NB: sysroot crates reexport items from one another so setting up =
our transitive dependencies
> > @@ -108,11 +156,10 @@ def generate_crates(srctree, objtree, sysroot_src=
, external_src, cfgs):
> >         [],
> >     )
> >
> > -    append_crate(
> > +    append_proc_macro_crate(
> >         "macros",
> >         srctree / "rust" / "macros" / "lib.rs",
> >         ["std", "proc_macro"],
> > -        is_proc_macro=3DTrue,
> >     )
> >
> >     append_crate(
> > @@ -121,12 +168,11 @@ def generate_crates(srctree, objtree, sysroot_src=
, external_src, cfgs):
> >         ["core", "compiler_builtins"],
> >     )
> >
> > -    append_crate(
> > +    append_proc_macro_crate(
> >         "pin_init_internal",
> >         srctree / "rust" / "pin-init" / "internal" / "src" / "lib.rs",
> >         [],
> >         cfg=3D["kernel"],
> > -        is_proc_macro=3DTrue,
> >     )
> >
> >     append_crate(
> > @@ -137,9 +183,9 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
> >     )
> >
> >     def append_crate_with_generated(
> > -        display_name,
> > -        deps,
> > -    ):
> > +        display_name: str,
> > +        deps: List[str],
> > +    ) -> None:
> >         crate =3D build_crate(
> >             display_name,
> >             srctree / "rust" / display_name / "lib.rs",
> > @@ -147,20 +193,23 @@ def generate_crates(srctree, objtree, sysroot_src=
, external_src, cfgs):
> >             cfg=3Dcfg,
> >         )
> >         crate["env"]["OBJTREE"] =3D str(objtree.resolve(True))
> > -        crate["source"] =3D {
> > -            "include_dirs": [
> > -                str(srctree / "rust" / display_name),
> > -                str(objtree / "rust")
> > -            ],
> > -            "exclude_dirs": [],
> > +        crate_with_generated: CrateWithGenerated =3D {
> > +            **crate,
> > +            "source": {
> > +                "include_dirs": [
> > +                    str(srctree / "rust" / display_name),
> > +                    str(objtree / "rust")
> > +                ],
> > +                "exclude_dirs": [],
> > +            }
> >         }
> > -        register_crate(crate)
> > +        register_crate(crate_with_generated)
> >
> >     append_crate_with_generated("bindings", ["core"])
> >     append_crate_with_generated("uapi", ["core"])
> >     append_crate_with_generated("kernel", ["core", "macros", "build_err=
or", "bindings", "pin_init", "uapi"])
> >
> > -    def is_root_crate(build_file, target):
> > +    def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
> >         try:
> >             return f"{target}.o" in open(build_file).read()
> >         except FileNotFoundError:
> > @@ -169,7 +218,9 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
> >     # Then, the rest outside of `rust/`.
> >     #
> >     # We explicitly mention the top-level folders we want to cover.
> > -    extra_dirs =3D map(lambda dir: srctree / dir, ("samples", "drivers=
"))
> > +    extra_dirs: Iterable[pathlib.Path] =3D map(
> > +        lambda dir: srctree / dir, ("samples", "drivers")
> > +    )
> >     if external_src is not None:
> >         extra_dirs =3D [external_src]
> >     for folder in extra_dirs:
> > @@ -192,7 +243,8 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
> >
> >     return crates
> >
> > -def main():
> > +
>
> What is this extra blank line for? Automatically generated by a formatter=
?

Yeah, this comes from PEP 8. Moved to "scripts:
generate_rust_analyzer.py: add missing whitespace".

>
> > +def main() -> None:
> >     parser =3D argparse.ArgumentParser()
> >     parser.add_argument("--verbose", "-v", action=3D"store_true")
> >     parser.add_argument("--cfgs", action=3D"append", default=3D[])
> >
> > --
> > 2.48.1
> >
> >
>
> Other than what I said above, the type hints themselves are fine.
>
> =E2=80=94 Daniel

Thanks for the reviews!

