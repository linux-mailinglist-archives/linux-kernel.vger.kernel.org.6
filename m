Return-Path: <linux-kernel+bounces-328541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE53597857E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D4E1F244A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33F6F31E;
	Fri, 13 Sep 2024 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zhnPs8Ke"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8A4778C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243820; cv=none; b=rQrLafTGzijPjqxrttiZfxLvyjiInKNoHarcJW6xT9m0lyUlDRqfSZuRbWoVAjawwb9BY4nASS9d1NGgKGYdjO41Vxwj0CQcOsLWq5ysDqNueVP7YuRvo1FIcQOz8oLwA88XdJlL6nBMPbqeGiaIjBDmAsd7W+mMRy4LvZtuDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243820; c=relaxed/simple;
	bh=HzQHtI71T5x1HZfq4p6DIhs51q2q8ed5NmcYQ1uusi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Qppi2DEUeaZE//AafH+jJgqKk2iWRRSVt2vsi51xTDhFVfbwXjB1V0nkG1zY7FYOiDNjRruinC7+uTqPIfIry2nAi3IFmEe0SldRrkZeYUYd3Bn9/25Dp6AK/H3+CRM97HUQ1R6eSpZnxJxkQqeHkVDDd6USd6liWDV6Snk1B3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zhnPs8Ke; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb2191107so19195415e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726243817; x=1726848617; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7T9luSAaVlIhA7d3UIw5fj7z6n4alRbZ0/XmzJrXd4=;
        b=zhnPs8KePGYa75HGCzn/1sEm8/SttLBH1qYnc1dBP457E9XgFh8EYaz+gx19EabbDe
         zDrtnxDnrmSAR6K/nkqjhy23KNjDTxoPUT+60UvEtBW+KkhMoPk/KKpca7JxSi0U55ec
         6GOC3c2oK3YfO/6Xw3RMobrxgzD94gvQleqJCrrop4o7ml7cTJTQGVUH0RBzTKH1ngH4
         WdIcZVom0RjDjt3GaFlGaUGx2ra1ePpnD0FRKoqt6iH5vN9Lgb6938B3hxGt8A7O7oVM
         jkyzUvwKPT2TCWEW1UlChpj+r8PFCUN+ZqBrrk3vRkv7NWm3fmbzLbeO6bdRZ3UBPhQp
         /a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726243817; x=1726848617;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7T9luSAaVlIhA7d3UIw5fj7z6n4alRbZ0/XmzJrXd4=;
        b=qVs+HxaBjZiYuP3t/PJJ5pwmXFaAA9ctC9sXcxTpnGPV8MM1o1GigvNYTU4oh/nIeu
         Mh0gxQl9rridHJK47baPzV6y6fra5GRGXzEScL8gTePhP/RynHzlkOiKtEWHDK65NCC9
         83hp73GslpA2bLn/DDUsVCJlRJFDeao5lgiJsRY4Z7dmYE8D0NeIc63Y8QBlAaVx4I0s
         GtafWFW4sgEBWHtVXK3tGZ0lIWyoISiowIW9ru3l+ecAQ+fVBW1Ezk2K0DRToRRZF3l6
         pWmd9ubbmPX6ez8s3j/ZWXW4muXzTjjMOo/I9Lmd568gzOZpweo3L0KkJBTqHWNYMXBN
         QeJw==
X-Forwarded-Encrypted: i=1; AJvYcCVkcgG755MG5651uCIYOXP+2OBcnxvnuhl92BiAQvjDq7ZoFzU5S7pDOr1R71OrHpvty95P9mylwnkvkVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysG4+CfLmum6ytxZj/JqcIBK2pT57YCLAn1EoD7jVDysMvscXl
	JM6T+6FTUz3dv53PKpsciWfl9lR5xjoCRR0LRialszjZCVhtFc6N30YJFuiSLMY4fxttbyCiDI9
	Twi2ZgwHcL2PQBgnYuacIk2gylVe7I4HHp+tj
X-Google-Smtp-Source: AGHT+IEMwzNhctE9Vd9/CQYgxczVUSiLZZlsHvPsvGiy+jwNnDlHpegTFJ26ElB32Zjjaug66jZzt7atNwESuScYM+4=
X-Received: by 2002:a5d:4dc6:0:b0:374:c581:9f4f with SMTP id
 ffacd0b85a97d-378c2d58d9cmr3887507f8f.55.1726243816503; Fri, 13 Sep 2024
 09:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910-static-mutex-v3-1-5bebd11bdf3b@google.com> <ZuRh9niSrX6E5CWq@phenom.ffwll.local>
In-Reply-To: <ZuRh9niSrX6E5CWq@phenom.ffwll.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Sep 2024 18:10:03 +0200
Message-ID: <CAH5fLgiaPYphXE-Azfb0MU1EzsNpAMFntDeAt8YAMj5KAxS_xA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: add global lock support
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 6:02=E2=80=AFPM Simona Vetter <simona.vetter@ffwll.=
ch> wrote:
>
> On Tue, Sep 10, 2024 at 02:23:34PM +0000, Alice Ryhl wrote:
> > Add support for creating global variables that are wrapped in a mutex o=
r
> > spinlock. Optionally, the macro can generate a special LockedBy type
> > that does not require a runtime check.
> >
> > The implementation here is intended to replace the global mutex
> > workaround found in the Rust Binder RFC [1]. In both cases, the global
> > lock must be initialized before first use. The macro is unsafe to use
> > for the same reason.
> >
> > The separate initialization step is required because bindgen refuses to
> > expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a compile-time constant. It
> > just generates an `extern "C"` global reference instead. In the future,
> > we could expose the value of __ARCH_SPIN_LOCK_UNLOCKED to Rust in a way
> > that Rust can understand. This would remove the need for a separate
> > initialization step.
>
> Yeah it's just a raw C struct initializer, I wouldn't even know how to
> move that to rust.
>
> An absolute horrible idea, and I didn't try whether it's even possible:
> - put all the global locks of a type into a special linker section (we
>   need a macro anyway for them).
> - patch them up with a horrible linker script objtool patching with an
>   example lock initialized by the C macro.
>
> Even worse idea, on most architectures/config it's all zeros. Iirc the on=
e
> I've found that might matter a bit is CONFIG_SMP=3Dn with some lock
> debugging enabled. We could make rust support conditional on those, and
> then maybe a build-time check that it's actually all set to 0 ...
>
> Requiring the unsafe init just feels a bit disappointing to me, when the =
C
> side (including lockdep annotations) tries really hard to make global
> locks a one-liner.

I actually have a prototype lying around that gets rid of the
initialization step. The idea is to define some new macros:

 #define __ARCH_SPIN_LOCK_UNLOCKED      { 0 }
+#define __ARCH_SPIN_LOCK_UNLOCKED_TYP  unsigned int
+#define __ARCH_SPIN_LOCK_UNLOCKED_INT  0

Rust then uses the two new #defines to initialize the raw spin lock to
the right bytes. As long as __ARCH_SPIN_LOCK_UNLOCKED and
__ARCH_SPIN_LOCK_UNLOCKED_INT are represented by the same sequence of
bytes, it should work.

Alice

