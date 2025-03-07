Return-Path: <linux-kernel+bounces-550937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE499A5663B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFF47A55C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486C2153EB;
	Fri,  7 Mar 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMYohYSS"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44402153CF;
	Fri,  7 Mar 2025 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345569; cv=none; b=bPJwXhCLW/4LFr3QHmVAvAyG8zlhu/StbVYjANbLtOhEzNNNIxYTl3p0s3YARirhgK+oazUFPa8vHwNqqTuxRmOq1pT+RYZ9tSQhN+Q49eYpe8Sa4TYItgJYuFI2Z8XGXm7C44222GbLDiyuulsPAhtK0J3+k25f5I6CdtYlEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345569; c=relaxed/simple;
	bh=Y3c1xaFBNvjdfM7CmJTWCACE1BdwUW+rsUdX+Am+YJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwg/SNtG4dU4/geQaK8C93YqdCIcA8Uobunvqd/Ap6M+GG/rKfPFK4TYnhTg1m/hRaenLoSqrVHFgFaeedyxftSmBOZcMxG4iou2anAjXA/x0H2Mebo9X+SUih2Fd7wD1RODb7Ljz27NXEXeZRD5iSZ2KOZkMqpM1rGTB3khJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMYohYSS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30762598511so18881571fa.0;
        Fri, 07 Mar 2025 03:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345566; x=1741950366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6/lu0PuWFwtxqE9OCkmTvscVopIwEhxKjBzyZRwrA0=;
        b=HMYohYSSWHqMj0SMltkJrErWrnFvG+tK9EGInYbARqMFCMjNtrugxCOBcNj0JVPUaW
         k+5MZoEZzwArbpb9jfHC2gJzRJeZ0NwsdvebtNhpGzKijNTr2n6GB/Hf5CDqa7c8D+Im
         PdVPfywh8z3avYp3YIfDkU8Gemou1ktiVjAuqOA+P+J5s0ezLPE4qFgi96Ah6gMov/+9
         bzCYMnV5yAJqfln5iaRXoiAxzww115UiDj5aeiqflrU04ppCu5C17U8vOaJnK61DpvBX
         uZ8vkcV01fU5gToJ8RVJmVZqIhNJm89LuzYFXjpuK9J5KnLaFUgpzd1y1n82Z1VKVAhr
         phRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345566; x=1741950366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6/lu0PuWFwtxqE9OCkmTvscVopIwEhxKjBzyZRwrA0=;
        b=OW0X8Dmh7pdr6QwEc33OVckGhfc7f5TB/sERQpIgCHMo78bDoj1WDnHinSlGfBX6e6
         sd9JYZbFeSF3LGIu+NeFJpnFl6JW0HngHsgaM158tHUTGeFetXoEpx7w0EzaYq+8LnQ4
         Sq496QYva9SOkxYE8Iu8EFi0GVEYnsBHGTS0QN7TmKBIhTio4jK1BgfjP0pN/lLEEFZF
         ax0XLIOpdxn4W9Vo0bx0yFpXpFmroJoQiHwoFGvIgGKIg5kSIMrtVMPzDWiCBxApH61l
         lHyXaie6bqv2LIH/L3/K70Of4B3lztcrIcWxBCKgD6J85n2j05BVq6rSCqTeYDQN6PiV
         j2+w==
X-Forwarded-Encrypted: i=1; AJvYcCW+E8TUkcix6dR4WbE7osfweJ1kr8iwpSEp/WhL9xf6ydyAnOmId7h/Ta9IwZGXd0pSovaeA7RRdTighjctXA4=@vger.kernel.org, AJvYcCXyja1wxpsUetYMCXjr0jJdixnEm17SX7uBM5/HsHF0JmdEbbcRSABgTjbmLC15Uw22cnY3mpqUmkEhxzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuSrNfitjEkOHmewMH29GD2qGYR9v2MltPqbYew0bzhnPV/j8d
	bQLZQWlU+SbO/AEGI2ePkTWwvonOdAm8hQ8PUwOaETMHrgPskzbV0kyQJ0dt19MJy2e4tUqlIF4
	qoFXVLf4BAt9c5/At49+o115XS0k=
X-Gm-Gg: ASbGncs1EUSO3c2iibF1VTO1tnI/vWjKtR2JYebqAxVK+jA1d2FTCsX45wo/sVN4I+4
	/FYfoBfaITC/vmTtolCI4F/ObwcNw/Ma1kBWofyolYqKiu0r01NDTupakJJc7qAl7c80zpZcLoy
	+XfQnkmS6G0Yp1k1s9NJCxd/2zrYg51BSrQTvsfneWI6SQTdy0aP+3xhNtKHVV
X-Google-Smtp-Source: AGHT+IFJxg6rADFBRb55qm7qbREgXVMaA/SWCf0d9xcf6hqoz84f8DFI7T6UPF89zZo8LKwCp15hSsTp6xYmokxzlDc=
X-Received: by 2002:a2e:be9f:0:b0:30b:ba06:b6f9 with SMTP id
 38308e7fff4ca-30bf463b68fmr9089911fa.26.1741345565293; Fri, 07 Mar 2025
 03:06:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6-mv8ahCblqal1f_T1RcVPPPb6QEedsAXlhmcyCNC-lnvAj1USOInn0YNogItuEdy_KthnPdFDElN1F6A9ncwA==@protonmail.internalid>
 <20250210-rust-analyzer-macros-core-dep-v3-1-45eb4836f218@gmail.com> <874j055csy.fsf@kernel.org>
In-Reply-To: <874j055csy.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 06:05:29 -0500
X-Gm-Features: AQ5f1Jr6-m0eAV9GPSpncHM1zoCrIjknINxPjzXii3DP0sMK3uIQjcf4Vr7NWp8
Message-ID: <CAJ-ks9mofNbtGqoYBummkfxZ+zrmEHg5P6viVwwgs9-BuNGbZg@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: generate_rust_analyzer.py: add missing macros deps
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Boris-Chengbiao Zhou <bobo1239@web.de>, Fiona Behrens <me@kloenk.dev>, 
	Kees Cook <kees@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chayim Refael Friedman <chayimfr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:57=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > The macros crate has depended on std and proc_macro since its
> > introduction in commit 1fbde52bde73 ("rust: add `macros` crate"). These
> > dependencies were omitted from commit 8c4555ccc55c ("scripts: add
> > `generate_rust_analyzer.py`") resulting in missing go-to-definition and
> > autocomplete, and false-positive warnings emitted from rust-analyzer
> > such as:
> >
> >   [{
> >       "resource": "/Users/tamird/src/linux/rust/macros/module.rs",
> >       "owner": "_generated_diagnostic_collection_name_#1",
> >       "code": {
> >               "value": "non_snake_case",
> >               "target": {
> >                       "$mid": 1,
> >                       "path": "/rustc/",
> >                       "scheme": "https",
> >                       "authority": "doc.rust-lang.org",
> >                       "query": "search=3Dnon_snake_case"
> >               }
> >       },
> >       "severity": 4,
> >       "message": "Variable `None` should have snake_case name, e.g. `no=
ne`",
> >       "source": "rust-analyzer",
> >       "startLineNumber": 123,
> >       "startColumn": 17,
> >       "endLineNumber": 123,
> >       "endColumn": 21
> >   }]
> >
> > Add the missing dependencies to improve the developer experience.
> >
> > Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
> > Reviewed-by: Fiona Behrens <me@kloenk.dev>
> > Suggested-by: Chayim Refael Friedman <chayimfr@gmail.com>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> > Changes in v3:
> > - Avoid shuffling compilter_builtins; it is not needed for RA support.
> > - Align more closely with the long-term solution:
> >   https://lore.kernel.org/all/20250209-rust-analyzer-host-v1-0-a2286a2a=
2fa3@gmail.com/.
> > - Link to v2: https://lore.kernel.org/r/20250209-rust-analyzer-macros-c=
ore-dep-v2-1-897338344d16@gmail.com
> >
> > Changes in v2:
> > - Change macros deps from [core] to [std, proc_macro], improving
> >   autocomplete and go-to-definition.
> > - Remove Wedson Almeida Filho <wedsonaf@google.com> from cc; email
> >   bounced.
> > - Link to v1: https://lore.kernel.org/r/20250209-rust-analyzer-macros-c=
ore-dep-v1-1-5ebeb3eb60a9@gmail.com
> > ---
> >  scripts/generate_rust_analyzer.py | 30 +++++++++++++++++++++---------
> >  1 file changed, 21 insertions(+), 9 deletions(-)
> >
> > diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_=
analyzer.py
> > index aa8ea1a4dbe5..1394baa5ee9e 100755
> > --- a/scripts/generate_rust_analyzer.py
> > +++ b/scripts/generate_rust_analyzer.py
> > @@ -57,14 +57,26 @@ def generate_crates(srctree, objtree, sysroot_src, =
external_src, cfgs):
> >          crates_indexes[display_name] =3D len(crates)
> >          crates.append(crate)
> >
> > -    # First, the ones in `rust/` since they are a bit special.
> > -    append_crate(
> > -        "core",
> > -        sysroot_src / "core" / "src" / "lib.rs",
> > -        [],
> > -        cfg=3Dcrates_cfgs.get("core", []),
> > -        is_workspace_member=3DFalse,
> > -    )
> > +    def append_sysroot_crate(
> > +        display_name,
> > +        deps,
> > +        cfg=3D[],
> > +    ):
> > +        return append_crate(
>
> Why the `return` here?

It's in anticipation of this follow up patch

https://lore.kernel.org/all/20250209-rust-analyzer-host-v1-2-a2286a2a2fa3@g=
mail.com/

where the return value is used to identify the crate. I developed the
two in parallel so I added this return to reduce overall churn.

> Otherwise looks good to me.
>
> I never had any errors as described above, but I can confirm that go to
> definition in `macros` for items in `proc_macro` work with this patch
> applied. It does not work prior to applying the patch.
>
>
> Tested-by: Andreas Hindborg <a.hindborg@kernel.org>

Thanks!

