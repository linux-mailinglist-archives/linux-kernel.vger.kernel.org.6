Return-Path: <linux-kernel+bounces-546812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE370A4FEFD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8293ACC60
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8570245026;
	Wed,  5 Mar 2025 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iis593OP"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFBD13633F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178967; cv=none; b=Ueta956iAlxWSiL4cpTMhCRMiqkUexIUZzgg7nVj7jN35vYKnyXIsHw6w+4AbiZDT7FjORP26UsAzgkigOMUdiwD1wpBD2DhZUvwOcsuBDYQbuufi6baSomS4UOGhga2QTOxcl92UuQQOKW/1E2lJUpgkvsivw5G1p089HY0Jok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178967; c=relaxed/simple;
	bh=fjNiQj1up3UtD6oAEJDLwd+TL5daw60X6bYFkikPsCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCcGu+GxRfydF0HwWG9SQSwsLdWaMuuaxkV4QrJWanGcfKBD/3StodVi/njdNIGqvkEIX175q02FYuaYiKJTJdpEveYVLZyO2AxmW53/Z/afzjtGvC9zQu/NYtp/deQk00lP0CHrwK2zrXRPOvtLruVz625sfDblzPI/sZT0/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iis593OP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39127512371so92036f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741178963; x=1741783763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeTGLIYwZYxU2OO7kc88Ztq6BwjVRTNie/kfgVgGpOc=;
        b=Iis593OP+YFxwIxCAuL8PTRJsEhur6CyYEmadyeYwQFBwTOmBw+/1StIzjeE5I+68Q
         X7c14HQQqDy2DiU04KpBZ+BHYRlz4pm/sKC7jfzmitwh0feRZmH/w2HO/gjH/evRSLvS
         rG0j0R0jRXe3G5m8ocQSnzHA1CgIK16rqfLFN7I3mlhhr3zDcgahynzeBvM+aKQABP7O
         bVCRm+vWviX60sV6cLdHVoWdkx+zxT5GaBc+foL49W05ATGB4+ngC2m3Ui9depyJ7Nni
         r/OMaamsp1MZ6LgqK1kRenQ6HWr4QXPNwhleJAUwsu7v8MEQlJQ3VOL5VIgsjQxy4Uf0
         sj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178963; x=1741783763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeTGLIYwZYxU2OO7kc88Ztq6BwjVRTNie/kfgVgGpOc=;
        b=LN988gU5b/yFMkzd2uQtRI7nYwGCKG9XnXt4uYSfFOfHKf2zm0alBcvixuq8bIF1+C
         NYH7YnRCvIusmDgcg8q67sc+jyp0wLMJAvRXeJ6creJDqDPPQbYfkGtj2QnaGf/NRuWy
         8OaVQoYQ5ee4nR6bGnjrbhaKhUbipjk6v/+UbsUqre+2cfOcMrq841ddBBEfhRXHxK7s
         EdF3m7+vCPsO7YI9y+vaepA2tKw59uyZEUrCWgvgRZL8Fmt+mznYDlkY2yK1bK0UYKWT
         h9b0peTnYeXHN87vzbfw0NFWGHo7rbDENWFGy9KZ/B1xZ40VO9dwGvOIBHQOEZ/NVM/F
         fy+g==
X-Forwarded-Encrypted: i=1; AJvYcCVc1nX959lIaIS/iyWRTb7CZwRp/q3TtpJqcSqSQovr7vS5d6jfe8NlKov41EicfOOO9/VMq2PqQ5F3Oms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzN1Q6q0gCdrrQDz/w5sxp1LU5CHmWLXS2Zdr2GLJWDtXG90ja
	4XjAP7hdejPwCPj6txaH1KQmmDQA2TppnFf/zona43Kbvn1OKh5xR1P6L09veahezJ4HA7LudUp
	V10rnCf2rck1CfMXdo80d94us0SegYoewA85O
X-Gm-Gg: ASbGnctttYrejpY7X8BIuBCAlaoi6hxv6LuojHnBlwuqHNuW9JsLPsuJqz4JL6TTt+P
	KGkSoUC2/q9cqIcb0DEcxO8JxpwyZxRCE6apDdCg/qehX1OxyTTc/d1T/IEIq323d+06T7CfOGg
	Lr24hfKG2e480vQ5yLEpU1BwJd6x3KwXn9No2YlrRaxvebHUnShKi+frHJ
X-Google-Smtp-Source: AGHT+IG6XlwrrJIODlxzdXuTV+TRFzZiNT/es6W8I4NpTAkPMycC2XucCIhVUyAaVpTA5Gka85eIjgw+UzEgME3FMsE=
X-Received: by 2002:a05:6000:1885:b0:391:1388:64ba with SMTP id
 ffacd0b85a97d-3911f7c9fedmr2484336f8f.53.1741178963393; Wed, 05 Mar 2025
 04:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304225245.2033120-1-benno.lossin@proton.me>
 <msi970CObD4bpxAIjK__fZnRG2q-BXd4FHuA1U1NR80D_dTqSXuQ-0-4R1TS7-7CglN6StcS3Os-IumgWcVLqw==@protonmail.internalid>
 <20250304225245.2033120-10-benno.lossin@proton.me> <87a59zen0l.fsf@kernel.org>
 <D88BHSCKZ8MO.10J627BIF6I97@proton.me> <CAH5fLghL+qzrD8KiCF1V3vf2YcC6aWySzkmaE2Zzrnh1gKj-hw@mail.gmail.com>
 <D88BQVG0KLC5.27DTUSDE9D8C6@proton.me>
In-Reply-To: <D88BQVG0KLC5.27DTUSDE9D8C6@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 5 Mar 2025 13:49:09 +0100
X-Gm-Features: AQ5f1JpcVp3x5vljGCZs6sDDieon_cUMpzP03TaXU7txkXZFjR7zY1Zh6kltwEs
Message-ID: <CAH5fLgh4aH36QUi4T36U3NeOOL3X_bt+y5ce7DU1j-+DMcV+jQ@mail.gmail.com>
Subject: Re: [PATCH 09/22] rust: pin-init: move impl `Zeroable` for `Opaque`
 and `Option<KBox<T>>` into the kernel crate
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 1:17=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On Wed Mar 5, 2025 at 1:11 PM CET, Alice Ryhl wrote:
> > On Wed, Mar 5, 2025 at 1:05=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
> >>
> >> On Wed Mar 5, 2025 at 12:26 PM CET, Andreas Hindborg wrote:
> >> > "Benno Lossin" <benno.lossin@proton.me> writes:
> >> >
> >> >> In order to make pin-init a standalone crate, move kernel-specific =
code
> >> >> directly into the kernel crate. Since `Opaque<T>` and `KBox<T>` are=
 part
> >> >> of the kernel, move their `Zeroable` implementation into the kernel
> >> >> crate.
> >> >>
> >> >> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> >> >> ---
> >> >>  rust/kernel/alloc/kbox.rs | 8 +++++++-
> >> >>  rust/kernel/types.rs      | 5 ++++-
> >> >>  rust/pin-init/src/lib.rs  | 8 +-------
> >> >>  3 files changed, 12 insertions(+), 9 deletions(-)
> >> >>
> >> >> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> >> >> index 39a3ea7542da..9861433559dc 100644
> >> >> --- a/rust/kernel/alloc/kbox.rs
> >> >> +++ b/rust/kernel/alloc/kbox.rs
> >> >> @@ -15,7 +15,7 @@
> >> >>  use core::ptr::NonNull;
> >> >>  use core::result::Result;
> >> >>
> >> >> -use crate::init::{InPlaceWrite, Init, PinInit};
> >> >> +use crate::init::{InPlaceWrite, Init, PinInit, Zeroable};
> >> >>  use crate::init_ext::InPlaceInit;
> >> >>  use crate::types::ForeignOwnable;
> >> >>
> >> >> @@ -100,6 +100,12 @@
> >> >>  /// ```
> >> >>  pub type KVBox<T> =3D Box<T, super::allocator::KVmalloc>;
> >> >>
> >> >> +// SAFETY: All zeros is equivalent to `None` (option layout optimi=
zation guarantee).
> >> >> +//
> >> >> +// In this case we are allowed to use `T: ?Sized`, since all zeros=
 is the `None` variant and there
> >> >> +// is no problem with a VTABLE pointer being null.
> >> >> +unsafe impl<T: ?Sized, A: Allocator> Zeroable for Option<Box<T, A>=
> {}
> >> >
> >> > Could you elaborate the statement related to vtable pointers? How do=
es
> >> > that come into play for `Option<Box<_>>`? Is it for fat pointers to
> >> > trait objects?
> >>
> >> Yes it is for fat pointers, if you have a `x: *mut dyn Trait`, then yo=
u
> >> aren't allowed to write all zeroes to `x`, because the VTABLE pointer
> >> (that is part of the fat pointer) is not allowed to be null.
> >>
> >> Now for `Option<Box<_>>`, this doesn't matter, as there if the normal
> >> pointer part of the fat pointer is all zeroes, then the VTABLE pointer
> >> part is considered padding bytes, as it's the `None` variant.
> >
> > The standard library only guarantees that all zeros is valid for
> > Option<Box<T,A>> when T:Sized and A=3DGlobal.
> > https://doc.rust-lang.org/stable/std/option/index.html#representation
>
> Oh! That's a problem then... I'll remove that then (and I can also get
> rid of the `ZeroableOption` trait).

Don't you still need it for KBox?

Alice

