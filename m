Return-Path: <linux-kernel+bounces-568912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B029CA69C01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665AA3BA4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9388A2101AE;
	Wed, 19 Mar 2025 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJGXJlm1"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA4207E02;
	Wed, 19 Mar 2025 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423165; cv=none; b=dWhpDv0zzMJ0Vv06Pidh4T1AlGuFOdqLUvwHYVm322uXXS92+FnoKdtMSlETQynzMYHSJ1KvW9MtTCmaE00hOAZRRrdQlMmNE44BzTwY+o47gERVopuKSQJnDEdEtk3WIPMDGKUF9oSu6r24MiCS+YjPa6fL0Fnqolz9iBQ+4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423165; c=relaxed/simple;
	bh=vHeOhqNgq/meJjq2uPcUDg6Z/wbCN/9+wvGILdFBDRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvBKdymI/fg9mxX40/trtZkvqiPNrv8WnEiAd8JSVIMcCoMh/Yp6CZp5diUUACJ9Atl8+dqod2A42npVQv4MbhF1IhKEOa3so6cmIO3W6umXA7ZvEGD2AOch7Kuy2rJpH+mc8EEdMv1Z5NG6UP4iLV2l11YNQQ2Id+4tsmsPnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJGXJlm1; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-307c13298eeso2058371fa.0;
        Wed, 19 Mar 2025 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742423162; x=1743027962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gerI+PNlJmeQG4wY6twMwqnZR2NolP/0cDu92I7+9cM=;
        b=QJGXJlm18QeUHow1vUqmOHNdIl4rlUplayiD7ZN2q9G/KAsSk4FGUfHY0p0e9xWlLx
         Sy8+3RQwQ8WlqnyTGmrJBmjoBK/rjep5QB5BOxMcrZ9wZcSEAIOXGQ6h4A0C7UOm+79J
         uplNN8wLh4W+swX238sEbibbaBeG2xAyY2OLo+p0aMoUngLXmONXzTIXlBA9H0TVWbwI
         sHwVHKTGMWhUGDzR1zMfn9f5QVlHqeFzrQkHfNNX3Q+3o6e+WOOTC2Y9qKfPbcS74Ti6
         xZgN5LtZZqw3LJQnwZ1Xqd5XuaGPhha/yKTZ86IQehn4rFOrcRIO3xzZaZf/8+bYbeFj
         jLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423162; x=1743027962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gerI+PNlJmeQG4wY6twMwqnZR2NolP/0cDu92I7+9cM=;
        b=X9exTv7nXOdVu8Wolfaxvqgt64l8EW6+OoSnsLTXmKJsV2exyAtNw/RylRP5XCf/5U
         U3iJolhGgu4bRt9gYkWrGMMn7M4cSl7oiIPdOB1TKO4s3rM8qz7hq/85ylf5hIK86qjl
         SHmgFepG4ue6zanQx+YE9darK78VOg1GEZOBHnJuZljEbsXeNd6EC8dZ5K4NZAT6jYOx
         EXKmkxWAbwuBmWFknMJNuY+1XAkG7DSGTh+JFRGOGfiCz3xGx7IBCLiIWUrxcuLZk3sT
         dhqVPDlUADR+VyrkoQT34CqLzt9N90BJ9tMFLTdOpEa7NHEIZ5pfhOF0FqBPEctLRYlw
         lTgg==
X-Forwarded-Encrypted: i=1; AJvYcCV+dx5ciGnZxG6wQ+emrhJWgoJfDugQqJmGqVBCX1k0TJS4aewRFgR4THBr3+fCaRADBzXiKBxIaK/xQU4=@vger.kernel.org, AJvYcCX3sePZYsnpnZHVYIHwFPcmPx3fjh6KvsnhE/Uq6PmTvK7hk8RjXeUEoVqF9FRyVUlLyaNH4iBYMxo+vLrIEdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5J3Ml6YmC8iRUhskqwnTVttr/XlpFjU9JGWioZoGumWSzvCdD
	aRmoCLTv96+1QSHuQ42HcvycurftF9SmIiXACWh5lgr+vx1xxr8ZT1cQvB46tfBDlQiO0rH3eEV
	fwgu40vMnsPWEmLfCo4xqCpDkZ+Q=
X-Gm-Gg: ASbGncvSag8bL3EQhGe73QU1ZVhQRehGpbk6nSSLRRmqCQ0UR58MKjxOLavtHzF7/zs
	Z0ZqzsrEI1tfHTccpuwT//OJsOP8V14G4Bi6WLrnXjNcllm4vSky/+ZX1YMwpwF0Lfir78bSeW0
	myunGIZ15C+CIdHFIYlkrOUgpRedi/bUSiagnGeM6Y2A==
X-Google-Smtp-Source: AGHT+IG9WiMdORhsWd/YzrUjRSveHnTFkcIg0C5wf+ABvWdm9WbrPXYrJmn6UMhHIonQCrt0lw2RWUZhCMJTdb7enOU=
X-Received: by 2002:a2e:9b4d:0:b0:30b:aaca:9b2e with SMTP id
 38308e7fff4ca-30d7251d6famr4847761fa.0.1742423161857; Wed, 19 Mar 2025
 15:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
 <20250311-rust-analyzer-host-v2-4-30220e116511@gmail.com> <CALNs47tKdnJ1rcC7pAqnxrppQWK4iQpXr3u4n38-RbSDi75yVg@mail.gmail.com>
In-Reply-To: <CALNs47tKdnJ1rcC7pAqnxrppQWK4iQpXr3u4n38-RbSDi75yVg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 18:25:25 -0400
X-Gm-Features: AQ5f1JqdjQWPbmsoUSvi0eycLl9-BPI8yeOw83l5fmMHbH_5If2jj8TXj4QZZJk
Message-ID: <CAJ-ks9nNn753cJrhQkiRA41gXhsFMz5_gWzdGgAqKiGOkUbaDQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] scripts: generate_rust_analyzer.py: add type hints
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Wirth <lukas.wirth@ferrous-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:25=E2=80=AFPM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> On Tue, Mar 11, 2025 at 9:18=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Python type hints allow static analysis tools like mypy to detect type
> > errors during development, improving the developer experience.
> >
> > Python type hints have been present in the kernel since 2019 at the
> > latest; see commit 6ebf5866f2e8 ("kunit: tool: add Python wrappers for
> > running KUnit tests").
> >
> > Run `uv tool run mypy --strict scripts/generate_rust_analyzer.py` to
> > verify.
>
> From the discussion, it may be better to instead mention the direct
> invocation (without uv).

=F0=9F=91=8D done.

> Could you also mention the target min version? Since apparently the
> kernel has a spread. It looks like maybe 3.8 based on what is used
> here.

Added, it is now 3.8 because mypy doesn't support anything lower.

>
> > This removes `"is_proc_macro": false` from `rust-project.json` in
> > exchange for stricter types. This field is interpreted as false if
> > absent[1] so this doesn't change the behavior of rust-analyzer.
> >
> > Link: https://github.com/rust-lang/rust-analyzer/blob/8d01570b5e812a49d=
aa1f08404269f6ea5dd73a1/crates/project-model/src/project_json.rs#L372-L373 =
[1]
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  scripts/generate_rust_analyzer.py | 130 ++++++++++++++++++++++++++++--=
--------
> >  1 file changed, 96 insertions(+), 34 deletions(-)
> >
> > diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_=
analyzer.py
> > index 7e78b926e61f..c73ea8d116a4 100755
> > --- a/scripts/generate_rust_analyzer.py
> > +++ b/scripts/generate_rust_analyzer.py
> > @@ -10,8 +10,10 @@ import os
> >  import pathlib
> >  import subprocess
> >  import sys
> > +import typing as T
>
> Nit: is there any need to keep everything namespaced? I think it
> should be fine to import `Iterable` `TypedDict` etc directly since
> they aren't confusable.

I saw this style in another project and liked it, but I don't feel
strongly. Changed.

>
> Same for `pathlib.Path` since there is no other `Path` (some of that
> is preexisting).

I'll leave this one as is to avoid more churn.

>
> > +    def append_proc_macro_crate(
> > +        display_name: str,
> > +        root_module: pathlib.Path,
> > +        deps: list[str],
> > +        cfg: list[str] =3D [],
> > +    ) -> None:
> > +        append_crate(display_name, root_module, deps, cfg)
> > +        proc_macro_dylib_name =3D subprocess.check_output(
> > +            [os.environ["RUSTC"], "--print", "file-names", "--crate-na=
me", display_name, "--crate-type", "proc-macro", "-"],
>
> Nit, may as well use this opportunity to wrap the line.

I considered that, but when you use git with `-w` this line doesn't
change, so I'd rather leave it.

>
> > +            stdin=3Dsubprocess.DEVNULL,
> > +        ).decode('utf-8').strip()
> > +        crate: ProcMacroCrate =3D {
> > +            **crates[-1],
> > +            "is_proc_macro": True,
> > +            "proc_macro_dylib_path": f"{objtree}/rust/{proc_macro_dyli=
b_name}",
> >          }
> > -        if is_proc_macro:
> > -            proc_macro_dylib_name =3D subprocess.check_output(
> > -                [os.environ["RUSTC"], "--print", "file-names", "--crat=
e-name", display_name, "--crate-type", "proc-macro", "-"],
> > -                stdin=3Dsubprocess.DEVNULL,
> > -            ).decode('utf-8').strip()
> > -            crate["proc_macro_dylib_path"] =3D f"{objtree}/rust/{proc_=
macro_dylib_name}"
> > -        crates_indexes[display_name] =3D len(crates)
> > -        crates.append(crate)
> > +        crates[-1] =3D crate
>
> The unpacking is a bit confusing here, can `crates[-1]` just be set
> rather than duplicating and replacing it?
>
> Maybe the body of `append_crate` should be `build_crate(...) -> Crate`
> (which could then be a top-level function), then `append_crate`,
> `append_crate_with_generated`, etc call that and handle modification /
> appending themselves.

This is a nice improvement. Done.

> > +        crate: CrateWithGenerated =3D {
> > +            **crates[-1],
> > +            "source": {
> > +                "include_dirs": [
> > +                    str(srctree / "rust" / display_name),
> > +                    str(objtree / "rust")
> > +                ],
> > +                "exclude_dirs": [],
> > +            }
> >          }
> > +        crates[-1] =3D crate

=F0=9F=91=8D

>
> - Trevor

Thanks for the review!

