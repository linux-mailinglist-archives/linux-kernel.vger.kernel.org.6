Return-Path: <linux-kernel+bounces-357803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3628A997643
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413701F233E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234484207A;
	Wed,  9 Oct 2024 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5ZqYUZt"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC717BB34
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504951; cv=none; b=Tdvd1QZz0Pf9nOZ5oU1G2JVeBZB4iuONeAjNER3Dkb+YSqFbA46tkGMSNUtbgscprir9KjBXwejEGzL7zs9tLL7vJIfuvVia73m+iw+zRIx0A5U5sFfFsUT1RhNkkoI4XIjPf4Tfq5mawlcVNnp/Ryl7/ZhuTF3fibRzyn3ZAAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504951; c=relaxed/simple;
	bh=hDUR54sV7mPX+rddCrnMseo+c7xhgh8efJh15DV0obo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gl/qBbGsJTB9R2O26IbUACkn1S85oiJib/dUiXedllTu/LX5FnvJCQfsm0FAepRLt/fbWd5kAqhg9nCKpwIwzql7hO/gvbiImUwiuUzYYUla/ACp1qI6lBqPcQlabcuubEv8+9eSMxiHPN5G+6u6GZ4sQwNy8FFTH7Pky/HARgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5ZqYUZt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cc846fbc4so97167f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728504948; x=1729109748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDUR54sV7mPX+rddCrnMseo+c7xhgh8efJh15DV0obo=;
        b=I5ZqYUZt4Ml6Cuo0w0FAvqA3/TOTqjhfkFFZTTFi+GQPqOfWNgHWuf2IfeDXk63eVe
         /84pTcJyt6S2BIp/Ngq+h3tQVGzX9CJi+QNNpES/Bh9qvK6JfYR+MJbqk6YxrM29hQlM
         mbaCdVKTAhcIe0qAFHrpUdFBADZd0VxtfUoM9T6LbGv00yGLxJvnCqYUCEgsoIbeKTOB
         UoGOBmW+i3RwNxEBcaVEtMeXGcmuS5G4JKN1prModDM5Kwgr7oSS6sY+YgLimbH9MQnz
         rl3xKwq3LKVEQug45h2mjJX81Y81Y7ea/WWpz5Kics4sM5fAmtFNKoBo+b1q334YyVeX
         1mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728504948; x=1729109748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDUR54sV7mPX+rddCrnMseo+c7xhgh8efJh15DV0obo=;
        b=KRzSLNKfA4Xh7e1y75WKqgOIPspmM3dG8MuS/+3OCBKj4Nwr/isdtMy8lA/IwPV3pL
         /uIb8E/2cmqatmv97YRDSb5Z2dRbXtd8BpbjxaYYz/8SaEZmFfM9/qUvTyHRbYWsZVf8
         nzDy3To5CBB2adrThaMEhDb6H+318hMLKN+T/0a7rCNRAqEOUqXjbn8Z5qo2427sOBZh
         hMkRbEgWpVJtYiDCcZmKF8GpzDEFORMbOBM7puB9Mg0xX14bE+3amtcN0aIOxxadWw1o
         G8Wy2dAl/n6wOvwmQD1hr1fq2p+aEhbXtOcJimonWJ3TxSnW7jsiIKHXEoR1ahTem+Js
         snfw==
X-Forwarded-Encrypted: i=1; AJvYcCVMEQKPeTixJsonXIc5K6JAOYKdIVzufsEFNsvUeL7gmNE8AU/VNW2CLimbikr3DQVe8mKdOapTjkqK8SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycutvC5a22MvTDFrXG3nagGwmOJV1JLinJX7HMkg3RYbgY41TS
	PuitD+rq+WJMlzv4BBG031r39dYc0HQGKDzqwL4BfKMrsDj03XrOJJ4fggToPHPyHs3wUImYJol
	PLIu3vGYqRpmo5K1HU7BZg4sg53Xax3+xkpZ+
X-Google-Smtp-Source: AGHT+IG4D5AOPjh6lAXMstFdrhAhrdd7L2vLhW6l3Khj2c6DWfn6O2lqOxYWrYJyoYoq7CXtYj1MgecC9kXuRRTO+64=
X-Received: by 2002:a5d:4b8c:0:b0:37c:d4f8:3f2e with SMTP id
 ffacd0b85a97d-37d3aacddcfmr2403355f8f.55.1728504947756; Wed, 09 Oct 2024
 13:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com> <ZwbAvEnrzu6UUgGl@J2N7QTR9R3>
In-Reply-To: <ZwbAvEnrzu6UUgGl@J2N7QTR9R3>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 9 Oct 2024 22:15:35 +0200
Message-ID: <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all architectures
To: Mark Rutland <mark.rutland@arm.com>, Matthew Maurer <mmaurer@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 7:43=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> Hi Alice,
>
> On Tue, Oct 08, 2024 at 05:37:16PM +0000, Alice Ryhl wrote:
> > The KCFI sanitizer stores the CFI tag of a function just before its
> > machine code. However, the patchable-function-entry flag can be used to
> > introduce additional nop instructions before the machine code, taking u=
p
> > the space that normally holds the CFI tag.
>
> To clarify, when you say "before the machine code", do you mean when
> NOPs are placed before the function entry point? e.g. if we compiled
> with -fpatchable-function-entry=3DM,N where N > 0? I'll refer tho this as
> "pre-function NOPs" below.
>
> There's an existing incompatibility between CFI and pre-function NOPs
> for C code, because we override -fpatchable-function-entry on a
> per-function basis (e.g. for noinstr and notrace), and we don't
> currently have a mechanism to ensure the CFI tag is in the same place
> regardless. This is why arm64 has CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> depend on !CFI.
>
> For C code at least, just using regular -fpatchable-function-entry=3DM or
> -fpatchable-function-entry=3DM,0 shouldn't change the location of the CFI
> tag relative to the function entrypoint, and so should have no adverse
> effect on CFI.
>
> Is Rust any different here?

Ah, no it shouldn't be. Sami can you confirm?

> > In this case, a backwards offset is applied to the CFI tag to move
> > them out of the way of the nop instructions. To ensure that C and Rust
> > agree on the offset used by CFI tags, pass the
> > -Zpatchable-function-entry to rustc whenever it is passed to the C
> > compiler.
>
> As above, I suspect this isn't necessary to make CFI work, for any case
> that works with C today, due to -fpatchable-funtion-entry being
> overridden on a per-function basis. Are you seeing a problem in
> practice, or was this found by inspection?
>
> However IIUC this will allow rust to be traced via ftrace (assuming rust
> records the instrumented locations as gcc and clang do); is that the
> case? Assuming so, is there any ABI difference that might bite us? On
> arm64 we require that anything marked instrumented with
> patchable-function-entry strictly follows the AAPCS64 calling convention
> and our ftrace trampolines save/restore the minimal set of necessary
> registers, and I don't know how rust whether rust will behave the same
> or e.g. use specialized calling conventions internally.

Well, I was told that it's a problem and was able to trigger a failure
on x86. I didn't manage to trigger one on arm64, but I wasn't sure
whether that was me doing something wrong, or whether the problem only
exists on x86. We already have the flag on x86 for FINEIBT, but I
thought on the off chance that it's not a problem in practice on arm,
it still doesn't hurt to add the flag.

Regarding the AAPCS64 calling convention thing ... rustc uses the Rust
calling convention for functions internally in Rust code and I don't
know whether that changes anything relevant for what you mention.
Matthew/Sami do you know?

Alice

