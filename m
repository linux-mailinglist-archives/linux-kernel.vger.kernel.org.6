Return-Path: <linux-kernel+bounces-513984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE86A35107
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E93C3A6E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E2269888;
	Thu, 13 Feb 2025 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udnso0KV"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334920CCE2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484841; cv=none; b=M7k35lTKIlh8tgqeTPLD/ComirwzVSuNWmK6FjdzPzMiykFljZnfzNwgCjUq4IQ7orUg3nxjLQKF+VSBWtNt6A32h80r8vb1GfvW71mIz6DOkUoJJ8dU24ytfqA5Gyw6b+L9RLvOa4HLIm9O5JnC3R+yrW2YEBnBMEkTtCdIkN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484841; c=relaxed/simple;
	bh=DxQrmkFZyKEe0Cm3qvWvN7BKrG8dCo9NSN3PRsjyOxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldj/1/vIihM+NtO7ZdTNCv8ayUAyxvNWsjB6S5azm3djoxrMPgNnhug772y6wiVrnO4PlG4QxArk/l0NPOkaNuEd1NXs+TxXVJdZAdVnIajGZuyMErabBGrDyfQAQynIgWs2Q43leFjOLeM67I4NsBMsq4QaExTju+uegdh2iTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Udnso0KV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-308eebd4938so13824151fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739484837; x=1740089637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBPXpf/lt1Re8L6uGMmeTBCcROMhpPVB+uEyhjkPLFY=;
        b=Udnso0KV7Um1INZjl8y86wkgGmqCFgLLsjFwUHbewQfGYBC/LQI8Nf8/FxjdMIPqLA
         E+Zmg3t/VFoQm4H41c/hN5gxO+tR1XT7RFuYnCgYWH2Y/Vmoh1HpMVatd5irD0nv/DHI
         gZ+ykgYZyFurjYA1Pj5qUnFKuTMcGchrY/4xbPXgLjfXoyOsxmXJwiGhcItaMpI2ICsq
         A5mkHE1gUlsvPv1Lfq+GUjtDwG+xlKLPct6q3rWVxIjJU8VEPu/WbeC8iGAiqX4bLju0
         paPABp/AmUVSG69VIqu/E7hox9PbfOJCityRYb156s9VXdwjXM1pqsqz3dAYjiWEQZ+x
         r69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484837; x=1740089637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBPXpf/lt1Re8L6uGMmeTBCcROMhpPVB+uEyhjkPLFY=;
        b=VrXhst636EuEd9j3ZCLSop8bXTpWIUAMP6fT9Nef5frLFFZWBBJnasdolLHHaT9D/p
         RBFJHo3z2qNsPGtIqFHKpOzyiQDT5PbMPQGvnWaJ6wm2KqSYZJHHhfjZ/lco5Jxr3y6/
         ZMDnZ3H8KoDCaJU98F7E0y+5tgHeeQ7ecLKRTyESSRduLNGQYFd9dhU/tsMdIKmKdgX9
         pRKJOD5LRZYNUD3f1i60LkyhFoJTiAE+4BJrSjR37II6BnoXkXTlfAzwQDcrmbvhlTFR
         t9wQc/OtpPuQd/z1UY3oaA+vylii/rBRfq7VUIlHFawOEZx2SzrG1BMkrb7MaVc15JCA
         v2dA==
X-Forwarded-Encrypted: i=1; AJvYcCWwF11I48tho2JypasdMMEFfynivN/gdO5fN7CiEWAVv4T4YsfFkHWSHDC5yA7Bxp4IBUQd22E0hvcY+u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysZEtotKzeNFWEOCS5qm50Qp7Rf6SsOAQk2BwztCBHflfAT189
	GGyjvtMsgcuT1VErkYHyMrDkDZPKFxOmblhgkDdKDkOCJR50XRxuiJ0Nz0ZpNzC0PLMtbUby+tg
	lRM6r5pJFlmJuA885NQZ1MduK5W8=
X-Gm-Gg: ASbGncsPLlTZorgbhsLNMAHaLzSr4Nhu418598mI537rziO4TkN8Ani8CIFyvxmO4Y0
	ePXligW4wbhjfujK441OwrZh36QfwbfcNQfbC3fHDKe95aHMgSZj5QSeAOnlMf0aVp7VC0TIt
X-Google-Smtp-Source: AGHT+IHl869c/vhlrP9L11tJcUZj4Gj4SbPL20iiYmlSLs9jNRrYwRe7mQ9DoM2Z41cfTV+TkIZRS89bB8mPBb9gVlI=
X-Received: by 2002:a05:651c:2121:b0:308:f6cf:3607 with SMTP id
 38308e7fff4ca-309037abe87mr30937061fa.3.1739484836480; Thu, 13 Feb 2025
 14:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213191457.12377-1-ubizjak@gmail.com> <20250213191457.12377-2-ubizjak@gmail.com>
 <62965669-bf1d-461f-9401-20e303c6d619@intel.com>
In-Reply-To: <62965669-bf1d-461f-9401-20e303c6d619@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 13 Feb 2025 23:13:43 +0100
X-Gm-Features: AWEUYZmtdkzZDqhBdjEAzNtz89ohQz-Hv1552tFAj3hAGo3iv7K2qa1i-_hhuBg
Message-ID: <CAFULd4ZyCNy3MaCLqcuqyJKABMvbiToA5aZxfEt3iMgdRuLuYg@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] x86/locking: Use asm_inline for
 {,try_}cmpxchg{64,128} emulations
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 9:48=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/13/25 11:14, Uros Bizjak wrote:
> > According to [1], the usage of asm pseudo directives in the asm templat=
e
> > can confuse the compiler to wrongly estimate the size of the generated
> > code. ALTERNATIVE macro expands to several asm pseudo directives, so
> > its usage in {,try_}cmpxchg{64,128} causes instruction length estimate
> > to fail by an order of magnitude (the compiler estimates the length of
> > an asm to be more than 20 instructions).
>
> Just curious, but how did you come up with the "20 instructions" number?

Currently, a patched GCC compiler is needed (please see
asm_insn_count() and asm_str_count() functions in gcc/final.cc on how
the asm length is calculated) to report the length. For historic
reasons, the length of asm is not printed in asm dumps, but recently a
GCC PR was filled with a request to change this).

> > This wrong estimate further causes unoptimal inlining decisions for
> > functions that use these locking primitives.
> >
> > Use asm_inline instead of just asm. For inlining purposes, the size of
> > the asm is then taken as the minimum size, ignoring how many instructio=
ns
> > compiler thinks it is.
>
> So, the compiler is trying to decide whether to inline a function or
> not. The bigger it is, the less likely, it is to be inlined. Since it is
> over-estimating the size of {,try_}cmpxchg{64,128}, it will avoid
> inlining it when it _should_ be inlining it.
>
> Is that it?

Yes, because the calculated length of what is effectively one
instruction gets unreasonably high. The compiler counts 20
*instructions*, each estimated to be 16 bytes long.

> Is any of this measurable? Is there any objective data to support that
> this change is a good one?

Actually, "asm inline" was added to the GCC compiler just for this
purpose by request from the linux community [1]. My patch follows the
example of other similar macros (e.g. arch/x86/include/alternative.h)
and adds the same cure to asms that will undoubtedly result in a
single instruction [*].  The benefit is much more precise length
estimation, so compiler heuristic is able to correctly estimate the
benefit of inlining, not being skewed by excessive use of
__always_inline directive. OTOH, it is hard to back up compiler
decisions by objective data, as inlining decisions depend on several
factors besides function size (e.g. how hot/cold is function), so a
simple comparison of kernel sizes does not present the full picture.

[1] https://gcc.gnu.org/pipermail/gcc-patches/2018-December/512349.html

[*] Please note that if asm template is using CC_SET, the compiler may
emit an additional SETx asm insn. However, all GCC versions that
support "asm inline" also support flag outputs, so they are guaranteed
to emit only one asm insn.

> It's quite possible that someone did the "asm" on purpose because
> over-estimating the size was a good thing.

I doubt this would be the case, and I would consider the code that
depends on this detail defective. The code that results in one asm
instruction should be accounted as such, no matter what internal
details are exposed in the instruction asm template.

Uros.

