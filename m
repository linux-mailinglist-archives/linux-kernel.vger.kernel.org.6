Return-Path: <linux-kernel+bounces-262001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B25793BF3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4DDB216F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6E19883B;
	Thu, 25 Jul 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYp9Z+9l"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA41741FE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900623; cv=none; b=F2GhLQtzjOCThNMhYQZLwlx/PJAE3g/oQxwejfIkDLyemrDGJoSOLiy9FB0CI6lR5hP5utW1ODXP3sNJyyCA/1ax6uwp4J9jLl5Hp1SiFTFaSXu2VaKxK27P5Ag3sX1vmlP/wmwu/UEuKrzMkemJaURnqybEzzHBYi3FimsKZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900623; c=relaxed/simple;
	bh=OfRkrMGGgNibJB9z9Co5Oyh5Kyaj4J7TqHXMn4wIC+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqHLZ7JT27+GeRejUIxfji8xG4aXHPdJwEgMxmxEMn/BZys6JaVdy40FbtTbVZjfUzs4/cIyaaiKUR1Iayw/A2SV7wx9a2FxBPqUEHFeoKht8Bf6pqK8vyY1FDghDjj76fWPAzd8i+xpa54S/JiW7mozeNXvYkkZClDEfXoIjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYp9Z+9l; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so10212805e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 02:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721900620; x=1722505420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=084GPfdeuP46Jz6Dyrdsi8DzZT3jnbvpNucHJZ1TuaA=;
        b=iYp9Z+9lo2Uo2yb2ZX65AhT1LXOZ7NhKsLiJmlLfttNBUDKPOsLqrm//gEpQfDu5GJ
         ebCGmyojB9bR92eXCaLLdZVgTb03fibtsPRPrIjJ2+pGXCgsZKbZ/mi0989O47IloXmR
         nqaDZpyUbmjA6aLjwdX+dGURagKwF/84nl5cmDcMNc4UrdKlIxNx5YnkaRq5JcrTap+s
         mzvybc5TP8uXA1O0ERowcthPUU0rD4npO8AbxshEMxwW+nz9vFHz6ec4Iz7a9aPAlh0a
         C1sON7N1Ae6iwlOWBNFya2YvNOJjfX5mCkmHHxo/AJUSTWBvzr3Gb0my7WcsByr22reJ
         PERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900620; x=1722505420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=084GPfdeuP46Jz6Dyrdsi8DzZT3jnbvpNucHJZ1TuaA=;
        b=BfDuuI50nK/XXGg+Vknw4TldXF7FvrJoOvDAwO4n2iMbt0KILPPyibUBwlp+lq7i/l
         VIWE64jiVWCJ3VOF3x0TgyIR2Yn3NfDcduPZ3sWbMvxruEMUJ/OoPsZZrmfln/e0WrLU
         ccYsfOBZRpolupdbjiADyOMq3JRxB2B9mEk1Tj79bf/KF8o/IaOqYM7igFTR3gtiFKbR
         HfclgE87VmW1ZY80u5HNqjpbWaSAngN4O4xs3NuP+rfYJf7mhgap/NyVVXL5nDc7Q2+s
         29Zuq2PrHiHuGJ5mbO5LI0+OCH9KjXXchR2nUOGrQoWOlkiIILLfo/vpFfcfKqPMR5CZ
         pCiw==
X-Forwarded-Encrypted: i=1; AJvYcCX01d9JE/jrKpUG21hvcufSSa3gqKYZ1TkKHcYkEddcm0IPxuPRr+aQx9h6fBQqLAoONhwcJ+UOduB8G3j4DU/WFWB7ItZQ9FutjKKg
X-Gm-Message-State: AOJu0YxcgijPYS6TNzKVtuYPaRbuW4AkKOxP0utKTaAVeXlYDLufiT2e
	4fADtjZe9yokUU9Afws4DppjscVG4LntjWauC7Quesysfr6NoVRjKtTPb/llF8+oGI1xnyLOLw1
	nCYdILRl8iPuwu1xDghP71WFO7tL50uNjygyb
X-Google-Smtp-Source: AGHT+IE6X14IZDQ5Pvi0EHuAL+bLPA+DtdyDVXsBLCAhdXaKVx0/zepn3uPZTG5qlk+pSFE1iO35aByaX/zvkbfjpw4=
X-Received: by 2002:a05:6000:b81:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-36b31baa2d5mr1493373f8f.30.1721900619824; Thu, 25 Jul 2024
 02:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724161501.1319115-1-ojeda@kernel.org>
In-Reply-To: <20240724161501.1319115-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 25 Jul 2024 11:43:28 +0200
Message-ID: <CAH5fLgiCLxe3bjHtf3frY3vOsYucu4cFDtDR1UUZYXCGwxLv8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Rust: support `CPU_MITIGATIONS` and enable `objtool`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 6:15=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Hi,
>
> This is an updated series to the CPU mitigations support for Rust. It
> also has the patch to enable `objtool`, so that we can start running it
> for Rust.
>
> It would be nice to get this applied soon, so that we start being
> warning-free (since we already get warnings under IBT builds via
> `vmlinux.o`). I am happy to take it through the Rust tree if the x86 and
> objtool maintainers give an Acked-by, or through any of the other trees,
> as you prefer. Otherwise, I think at this point we would need to make
> Rust exclusive to the mitigations, which isn't great.
>
> With this series, again, x86_64 is warning-free with `objtool` enabled. I
> tested `-O2`/`-Os` and the Rust versions we support under `-O2` (mainly
> for the `noreturn` patch, which uses heuristics), as well as IBT vs. no
> IBT (i.e.  running on individual object files vs. in `vmlinux`). I also
> did an arm64 build.
>
> Testing is very welcome for this one!

Verified that this eliminates the relevant warnings in an x86 build of
the android-mainline kernel.

Tested-by: Alice Ryhl <aliceryhl@google.com>

