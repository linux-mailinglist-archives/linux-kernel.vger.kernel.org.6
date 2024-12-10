Return-Path: <linux-kernel+bounces-438652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8A59EA3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2701286DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E041C64;
	Tue, 10 Dec 2024 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QF2qhLTh"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426BADF71
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733791884; cv=none; b=Zo0DTw8zfCSsgnVLUF0MxwgfPvGd8zlRiVe/KMT06SQuV/uNTSfRxpk4kF/VP/SXTeVY/0ukQOkBNAUD8ir9/oFGDyMLYulswe8oZNIGlnMb8+Rs/YPQYUHyTl1AuF0d0nb0HSlzh13YlmiEqYN7SAk6JfEOviXDC2Va2VjyeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733791884; c=relaxed/simple;
	bh=nEfEp69NvTTxONDAy+/5voS/7ePa27UpEn4sAPc0fxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8hkZgIwCX6bvxRrVgt6q1L7+8PRwcgVO4hJ2WdSAUixRF+N2F3QL5oEPzaAfRlnlHcGrS3mHNX8bFkSanvICcc5Yk0eqa6YHDQxUS6TQ8Z1arH1xBUKENetI383aOyBmRyyC7ha9QMmq6kghvJ1md/68SdRg2WmYL5u34YVMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QF2qhLTh; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d89dc50927so34199956d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 16:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733791881; x=1734396681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0h2b9mjtuI2QArXe16Gccc3cHk96ybHu37fBVSwW9M=;
        b=QF2qhLTh2ATkD/B72CwX3vipG65Liimb2ulJW2P/FPBPTy/rPQWBPVCV4HRtR/Shdz
         VuuGf3iDzxutnB+rbNE83UCiqHYJLleqwiSMjf5px4YuMZ4fn26hcItpB2l4tm7MzFCP
         W++8gfDNxwkkpq3slSxhIlhB1+2nYIwma6SGSCUchFqcrkVGei7K1eCdAMtjlginR/kR
         ijDjIi2X35nfCPFaigXv8UnPk5EJgfqa9t7S1jQ8DcgM15KgId6DsfiKHOe6Me8WQog+
         UYJjsfYeQUiBYEPt1iiUzE37YCkjKkgMW1U76Q5XCxPkuNDUL7jq+gplJDkoUo5CSWsX
         lDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733791881; x=1734396681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0h2b9mjtuI2QArXe16Gccc3cHk96ybHu37fBVSwW9M=;
        b=qXTykrk5J32AhlUWD2oXMgydytPJG3SR2kRbbuOxeDA6GGWdGZ9sRC0+36sKgAevPh
         Uj3h+XuJgVAT1N78a7kIP5RYdaL/q8JPnyK9G/3O6MvWCR2RN098xtBUPrA8FfLy4lnH
         ZpJl+0/PishgNDQhoKXEIgmfFFJRk9LqqvDxFt54thl6fCpfRuPJXojooY+wda6lz4QA
         SvLVEpnxJAfGKUv+0jtJq4VFjmI6oRAm6WtpY25Nxb1Dao0juIQuuzppo3PxU87TddVB
         7/OxnHPEo+6WBkeen/MGrJfDH+Su0y4NCVEoQA89kfe0J/7rEEgbHoFOM30iCL/d4+yD
         Cpcg==
X-Forwarded-Encrypted: i=1; AJvYcCVYYyVj0F0Ej6GakpIocN9DBho7KkF1HAb7m5VkQZkbSKqPkv/fOGu4YazJsU9+eOz9MR5+TEiZ1ltzISo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCs1aEzMv/AVHgPi9E1USCN3DQZXyKI3SKT+ajzRmaIHGSdvi
	JMNKWaH/r8ERfuB+pdF2hT4XUbwCg640knlW3y3TJ2PAkbnR1tfe1EzlS4VxpHYsl90xZZ95ysm
	Nd0ovf3PBYvUBoLBaljhYOSEfbDma+r4p+Bu1
X-Gm-Gg: ASbGncsGcy7IbTnUcLBIgVYxrDilC9UDyPG7g2Y1c0371c974dayJU2LpwWJypTf9R4
	kkw/En61szEZMlQ7lhwLgztZkofAB27LT58yf/FEJ77J/HHRrnDcVxrrF03kFJshNGk8=
X-Google-Smtp-Source: AGHT+IEv6tYwzZCcY/GOnNZgDCbTNuvBneF8FHhUJ+RFI7vCCo2P0NeWoE+7XRtH4l48ug99YpLfJjAiat491cNQKC4=
X-Received: by 2002:a05:6214:c8b:b0:6d8:b2f2:bcb8 with SMTP id
 6a1803df08f44-6d91e2f23c5mr42708296d6.8.1733791881156; Mon, 09 Dec 2024
 16:51:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112184455.855133-1-ojeda@kernel.org> <CANiq72=BvnriScFay8SpLNe9mNhjvGsBJ9W9UtdzU_6v_i+woA@mail.gmail.com>
In-Reply-To: <CANiq72=BvnriScFay8SpLNe9mNhjvGsBJ9W9UtdzU_6v_i+woA@mail.gmail.com>
From: "Hong, Yifan" <elsk@google.com>
Date: Mon, 9 Dec 2024 16:50:45 -0800
Message-ID: <CAABy=s12gOZadhYC+=6=TbbyN9j5L0B19ZLSGR_VFEdt1jhwEA@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: rust: add PROCMACROLDFLAGS
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 10:30=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Nov 12, 2024 at 7:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> w=
rote:
> >
> >   - Removed "additional" from the documentation and commit message,
> >     since this actually replaces the other flags, unlike other cases.
>
> Some news regarding this: we asked upstream Rust about supporting
> overriding all flags (including e.g. `--edition`, `--target` and
> `--sysroot`) and apparently this was already accepted via an MCP
> (thanks Oli Scherer for the pointer!):
>
>     https://github.com/rust-lang/compiler-team/issues/731
>
> So, in the future, `rustc` will likely get support for this. Thus it
> may be best to go with an "additional" approach (rather than
> "replace"), so that this environment variable works the same way as
> the rest.
>
> We can do that by simply waiting until `rustc` implements it and we
> upgrade the minimum, or by implementing a workaround on our side
> meanwhile. For instance, something simple like:
>
>     $(filter-out --target=3D%,$(s)) $(lastword $(filter --target=3D%,$(s)=
))
>
> would be probably enough to cover Android's use case since we use the
> syntax with `=3D` elsewhere rather than with a space -- the equal sign
> plays well with Make's string functions. We can also add other flags
> if needed.

My original intention was to have PROCMACROLDFLAGS to be a completely
separate thing. That was partially why I used an $(or) there. This was
because "the list of flags to link hostprogs is not necessarily the
same as the list of flags used to link libmacros.so" (see commit
message). The fallback to HOSTLDFLAGS was just to be backwards
compatible so existing users don't get surprises.

In details, here's what Android does with V3 of the patch, roughly:

HOSTLDFLAGS=3D
    -L<paths>... -fuse-ld=3Dlld --rtlib=3Dcompiler-rt
--sysroot=3D<musl_sysroot> -Wl,-rpath,<paths>
PROCMACROLDFLAGS=3D
    -fuse-ld=3Dlld --rtlib=3Dcompiler-rt --sysroot=3D<glibc_sysroot>

With https://github.com/rust-lang/compiler-team/issues/731 fixed and
this idea of appending flags, our --sysroot flag should be able to be
properly overridden. But the -L and -Wl,-rpath's remains, and could
potentially be disturbing.

The reason for this difference is that we build hostprogs like
sign-file, fixdep, etc. with prebuilt libraries (e.g. sign-file needs
libcrypto, etc.) that were built against a prebuilt musl libc. On the
other hand, the Rust toolchain we are using was built against glibc,
and won't need these -L and -Wl,-rpath flags for the libraries.

So if I understand what you mean correctly, with this:
  KBUILD_PROCMACROLDFLAGS :=3D $(HOSTLDFLAGS) $(PROCMACROLDFLAGS)
Android might need a separate mechanism (another variable?) to filter
out our -L/-Wl,-rpath from HOSTLDFLAGS. (Dumb question: We can't take
-L/-Wl,-rpath away by prepending/appending more flags, right?)

>
> I will send a v4 unless someone thinks it is a bad idea.
>
> Cheers,
> Miguel

