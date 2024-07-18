Return-Path: <linux-kernel+bounces-256366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291E934D11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BA81F23205
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8BA27448;
	Thu, 18 Jul 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmMWVg/S"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A22762DF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305232; cv=none; b=r+LmDKP7MnAt/OFxlqU09Zsb64BTSR0/pLtseH1WnnamzmUGxt+LzAkT7ibBTvLJHigmElZAUlk+aQNdk1MjQ7LlMCWZ+IcBfANCeV3c729LUhnjSkjl4WhG5nmKyh5TdELXvBknqckICs9++lOFCD0dOdjskLJ8x0Aw6FBHLgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305232; c=relaxed/simple;
	bh=wbKJhMIleA8lfTJZrvt/KjGa8g+uwTZDE+I13K98uQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqwkrMxbeDkhGoLbgPCkeTUwDMPXuYYCKOhLRnc2WzeTddiMJvShUwYOhKC6tBeX9eqVjpJXxtPaqXbknKt5oOAF60qkp3bNhp5ccQHPhyoa4KOGsVzkPOX/CkNj40HOCNea51LBnPyS+OM47oIPbsXaoRQYLN/dAcUS6m849SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmMWVg/S; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3684e8220f9so362512f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721305228; x=1721910028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcnNlnLKzSsTcE/GmmIB9OL2PzwcGV5Vix9M/mA0UzY=;
        b=xmMWVg/S0eBCWPDQ6lt3Ew6m1j9Mv4bcIYk4PLiqG/Bm/o9fivBIpP/cZNbYH9k7Jl
         ivsfYo1rAuuJaWRaww39m7F3v5RxYY7DHbxCMgn4w6x35+3xpexzNTwN0l06PptQQrLG
         H4DuKae4UiWSpHK3jetocD6PY3gblWdFThjZQxukozHZ1wbccV/pMY2OhZAt45JBFdyX
         bYtwa9dzV16k5MS+pTyon9joUYLT5AcWCJuBs1PEMIqyVICudOhQ33Qyp5cBNMoCCsbn
         UzgR2m4qD1EiPRJHcfpdJWKxPcASDfRwtPBrLm7vP/63koAonNDMEQfgUD3n29C+2yqS
         3nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721305228; x=1721910028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcnNlnLKzSsTcE/GmmIB9OL2PzwcGV5Vix9M/mA0UzY=;
        b=TXc2p5lK4iUF5OW8agTcJ+9N936Cnvju9m8QHrALL8cnW5Wy/DWYHgoychMxmw+wN+
         7oqjyEmS7WH2m7P7Lqjax61Jp313aZqDgyYrnSUa2vgoC7w29X/Mvt2OP1Xs6VYWJJVY
         4QZZ9LkgQcUrW3EtenuKSpEjHjbr5o3ZyvE6ATUWT2qG2WPciPk6lDvlx2xBvR4bUWh3
         Yi1HUvTlLkfLnObtdii3OKEsFzsQeQW+qQdfMW2ct+vhL2OBVErtpyr6nDHzqYBB22X9
         imr0HG1Avd+ziqzWfOYsCqvAJd6XXZlTmQyQ6Gf7lCjJgn0cGIWKOnvCndKqkjk5jhru
         9KnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuADaV2VovTmynvUvcv1Yp5ccMIqMtun2QVrClA0gh9pH3XDINQgqnu+e6clBNS0BABtjoKQeQLKPjbhrtsdllL+MOlcXwwjvA8y/v
X-Gm-Message-State: AOJu0YxubkWODkTpWge/CGr5lx8rZ82WjGdk7Hc7nhsX2TaqMlGaF9n6
	O2OxwFXJ19EpoQeGkTPL8PB1UhLBcnDq4IOTQBDKJ14lFU9EXrOAYfQCmS74NW2ecKf+52A41At
	otShEJsvPogr+DZSkMvWMu7Igxy3PLiGEz4Mp
X-Google-Smtp-Source: AGHT+IFq9duOgNwQLu0gkyGvUZVw6R86dCETUZhi16vwKrj+wkGzq6dSMDkpbgZJuOSq82x7jRHC/sgftwOXxXrFgmI=
X-Received: by 2002:adf:cd8d:0:b0:368:6bb:f79e with SMTP id
 ffacd0b85a97d-3684b378746mr1969552f8f.4.1721305228089; Thu, 18 Jul 2024
 05:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717221133.459589-1-benno.lossin@proton.me> <20240717221133.459589-2-benno.lossin@proton.me>
In-Reply-To: <20240717221133.459589-2-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Jul 2024 14:20:15 +0200
Message-ID: <CAH5fLgg0O=t2T2MQH2hvm4eZnCOa_NffzRw=XZPi9+7+=XsmRg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:12=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
> +Soundness
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +``unsafe`` operations (e.g. ``unsafe`` functions, dereferencing raw poin=
ters etc.) have certain
> +conditions that need to be fulfilled in order for the operation to not b=
e UB.
> +To evaluate if the ``unsafe`` code usage is correct, one needs to consid=
er the API that wraps said
> +``unsafe`` code. If under all possible safe uses of the API, the conditi=
ons for the ``unsafe``
> +operation are fulfilled, the API is *sound*. Otherwise it is *unsound*. =
Here is a simple example::
> +
> +    pub struct Data {
> +        a: usize,
> +    }
> +
> +    pub fn access_a(data: *mut Data) -> usize {
> +        unsafe { (*data).a }
> +    }
> +
> +    fn main() {
> +        let mut d =3D Data { a: 42 };
> +        println!("{}", access_a(&mut d));
> +    }
> +
> +While this example has no UB, the function ``access_a`` is unsound. This=
 is because one could just
> +write the following safe usage::
> +
> +    println!("{}", access_a(core::ptr::null_mut()));
> +
> +And this would result in a dereference of a null pointer.
> +
> +In its essence, a sound API means that if someone only writes safe code,=
 they can never encounter UB
> +even if they call safe code that calls ``unsafe`` code behind the scenes=
.

I think this section on soundness could be more clear. You never
really give a definition for what soundness is; you just jump into an
example immediately.

It may be nice to talk about how a sound API must prevent memory
safety issues, even if the safe code required to do so is silly or
unrealistic. Doing so is necessary to maintain the "safe code never
has memory safety bugs" guarantee.

> +Because unsoundness issues have the potential for allowing safe code to =
experience UB, they are
> +treated similarly to actual bugs with UB. Their fixes should also be inc=
luded in the  stable tree.
> +
> +Safety Documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +After trying to minimize and remove as much ``unsafe`` code as possible,=
 there still is some left.
> +This is because some things are just not possible in only safe code. Thi=
s last part of ``unsafe``
> +code must still be correct. Helping with that is the safety documentatio=
n: it meticulously documents
> +the various requirements and justifications for every line of ``unsafe``=
 code. That way it can be
> +ensured that all ``unsafe`` code is sound without anyone needing to know=
 the whole kernel at once.
> +The gist of the idea is this: every ``unsafe`` operation documents its r=
equirements and every
> +location that uses an ``unsafe`` operation documents for every requireme=
nt a justification why they
> +are fulfilled. If now all requirements and justifications are correct, t=
hen there can only be sound
> +``unsafe`` code.
> +
> +The ``unsafe`` keywords has two different meanings depending on the cont=
ext it is used in:
> +
> +* granting access to an unchecked operation,
> +* declaring that something is an unchecked operation.
> +
> +In both cases we have to add safety documentation. In the first case, we=
 have to justify why we can
> +always guarantee that the requirements of the unchecked operation are fu=
lfilled. In the second case,
> +we have to list the requirements that have to be fulfilled for the opera=
tion to be sound.
> +
> +In the following sections we will go over each location where ``unsafe``=
 can be used.
> +
> +.. _unsafe-Functions:
> +
> +``unsafe`` Functions
> +--------------------
> +
> +``unsafe`` on function declarations is used to state that this function =
has special requirements
> +that callers have to ensure when calling the function::
> +
> +    unsafe fn foo() {
> +        // ...
> +    }
> +
> +These requirements are called the safety requirements of the function. T=
hese requirements can take
> +any shape and range from simple requirements like "``ptr_arg`` is valid"=
 (``ptr_arg`` refers to some
> +argument with the type matching ``*mut T`` or ``*const T``) to more comp=
lex requirements like
> +"``ptr`` must be valid, point to a ``NUL``-terminated C string, and it m=
ust be valid for at least
> +``'a``. While the returned value is alive, the memory at ``ptr`` must no=
t be mutated.".
> +
> +The safety requirements have to be documented in the so called safety se=
ction::
> +
> +    /// <oneline description of the function>
> +    ///
> +    /// <full description of the function>
> +    ///
> +    /// # Safety
> +    ///
> +    /// <safety requirements>
> +    unsafe fn foo() {
> +        // ...
> +    }

I would love to see a proper example here.

> +.. _unsafe-Blocks:
> +
> +``unsafe`` Blocks
> +-----------------
> +
> +``unsafe`` code blocks are used to call ``unsafe`` functions and perform=
 built-in ``unsafe``
> +operations such as dereferencing a raw pointer::
> +
> +    unsafe { foo() };
> +
> +In order to ensure that all safety requirements of ``unsafe`` operations=
 are upheld, a safety
> +comment is mandatory for all ``unsafe`` blocks. This safety comment need=
s to provide a correct
> +justification for every safety requirements of every operation within th=
e block::
> +
> +    // SAFETY: <justifications>
> +    unsafe { foo() };

I think it is worth explicitly pointing out that the safety comment
must explain why the preconditions are satisfied, *not* what the
preconditions are. It's a really really common mistake to mix up
these, and it probably even makes sense to include two examples
showing the difference.

> +For transparency it is best practice to have only a single ``unsafe`` op=
eration per ``unsafe``
> +block, since then it is more clear what the justifications are trying to=
 justify. Safe operations
> +should not be included in the block, since it adds confusion as to which=
 operation is the ``unsafe``
> +one. In certain cases however it makes it easier to understand if there =
is only a single ``unsafe``
> +block. For example::
> +
> +    // SAFETY: `ptr` is valid for writes.
> +    unsafe {
> +        (*ptr).field1 =3D 42;
> +        (*ptr).field2 =3D 24;
> +        (*ptr).field3 =3D 2442;
> +    }
> +
> +In this case it is more readable to not split the block into multiple pa=
rts.

It would be nice with an example of a completely normal safety comment
example. Also would be nice to call out that the semicolon goes
outside the unsafe block to improve formatting, when it's a single
operation.

It would also be nice with an example that shows how to reference the
safety requirements of the current function. (That is, an example that
combines unsafe fn with unsafe block.)

Alice

