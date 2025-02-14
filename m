Return-Path: <linux-kernel+bounces-514507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B87A357DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBBB16A42D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FAA20B1EC;
	Fri, 14 Feb 2025 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hymE1Xy3"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5566A2080E1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517971; cv=none; b=uOx0f80VdAQMPcGNoQhuDyJ/55KIDparHD7PR9sXuoNpojt57NKCf7l2AMVHfHH8PK9dy5lZx1Ie6YQE4tWeAogHgtYAWBpQpCVJcLgS0rqTl0Y5wlO4lXvd4yK/35naRP3kZHOqTcCuIWtymMJkGaYF6SD7zYYRpDsifUipNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517971; c=relaxed/simple;
	bh=wJEymyGF0Wl7CGuwgbwVpxZX5racDUxvBrJQWj4ZgSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikSPbCR3Ah1o0XAEpLAF1cMJnPTyxsRKdAP6slghV3vqYOcDx8qc4jc+wEYtHgihS6TCf/G6Mn+oFTOV/2hOiv4Ce0f0KcsR2y/16npbxP9dSY8qP+wzZQV/Vpig/mIAhEB+0tRTQTV4SXWkff43CeGd0ZFzI7WeVamY0zFLNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hymE1Xy3; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30797730cbdso18434451fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739517967; x=1740122767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38pYU+65ovTN19/hqSg/fVJVSZjgbnGfZhqllgCvemQ=;
        b=hymE1Xy3UptQ6WPy5L5FmwSihlb45t7LGJFZ6EWEqsJxMp+gTyrAYvKKjzj5iYFEwp
         zlbpki646MJbwlSAa5vXIbeNB2ng/JOzOLmCFtsImltLwHy4xJATqFu+2hIIfmB6/E/M
         FOJewhQ8PtmXslSdqvEIkTyff0ruK4zG06TqOO6ra62FQVX47JFHiQxS0MJJCHt/YIAI
         pFJVgmX/2icDtKIyoYgHYtvsvL9xkiCuffczZZmO58ewNDKtfUMYVhjKDAypEbyEtruN
         ebCmT/c9kYd72npqWu9+Bawv5YXbi1PP4JmoBp3/84yYLkOPc3SvqXexcHZLFaZ9hp/v
         B0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739517967; x=1740122767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38pYU+65ovTN19/hqSg/fVJVSZjgbnGfZhqllgCvemQ=;
        b=BYVArPDGb7Pgcum1PeWwPvhYrIwui2PPjToEsIBEA6KUxl4bcOuzGbaHA/g3Ct67QD
         x0SnDILs949zfjoe7d2M6V3F23pU5XMVhVOU0ySQR1ElJDD7xa7zJJHhRZG+4RvTVKLw
         RYuKFE+LReabNMqeyY7oiaxEi6QDyfZQpd7xE1WUA9kTY04WmiizPNAxOkDhRWFT+z3E
         L3hGewgA9CujGxTl3KRtPp0NvH4a2F7luc07yvXDHZQLrq0FcQMhoXtcBP6H5kmZeu/e
         kBWpH6h2MNBpNywiYnQJt34iqMAainqsE8+r2l9hGwQ6xv5ZvjKjW47ikEq/2oeuXiBi
         fWGg==
X-Forwarded-Encrypted: i=1; AJvYcCUncVGtR7w0k0n2lgNmsEyGAqGX2pXuG0HdovrcH1AESq/XPwRpO3AIPFKwxoXdECOIArqtm7+DA81pyZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3E/0lwuzVwYLxeWjbIVr/RRLXKaxbYW2qLKrU4kv+6GCwy5Ro
	+HH+iMjsEFnRXMMESn+p6mM3Q/NPSXUYSCxkU2EbmcLG9SgK77wweGHpOL+RnUimLXyALldQWJp
	uD/8L9EO76pnF+fUcE5/Af06Ph6c=
X-Gm-Gg: ASbGncsX+H/4a8eGdVs4DRmC9EO2ioDyDiVOYslcoJOr7vedLEUVNtCW5//jTffg4X4
	scrAlMxvY6fde8UvWzXqfbG/b3n1iEA+6oD2gb11bicXeVkbDyCHE8VJHAf/2skdrx8LRLUFE
X-Google-Smtp-Source: AGHT+IF0qiv6mckgLE92LpM+wmWQ7kbCCAFlQgv+ICaPlczv2yFTt9B4STFkKc9CrzcR2usAuXLG4ZubeGOzBf6XIj0=
X-Received: by 2002:a2e:a405:0:b0:307:9054:2a20 with SMTP id
 38308e7fff4ca-309036d9711mr30490291fa.21.1739517966952; Thu, 13 Feb 2025
 23:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213191457.12377-1-ubizjak@gmail.com> <20250213191457.12377-2-ubizjak@gmail.com>
 <62965669-bf1d-461f-9401-20e303c6d619@intel.com> <CAFULd4ZyCNy3MaCLqcuqyJKABMvbiToA5aZxfEt3iMgdRuLuYg@mail.gmail.com>
 <87194c62-7e97-41d3-98bd-14288e8bde8f@intel.com>
In-Reply-To: <87194c62-7e97-41d3-98bd-14288e8bde8f@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 14 Feb 2025 08:25:55 +0100
X-Gm-Features: AWEUYZkSNoFddTZnJtwGsd6M2G4C4JcnNyWzAdNRaSiO5ps3kzNqSuA9poXcr6c
Message-ID: <CAFULd4Y+xWW3Xq+SeRo7n7BS__epyYZC9ygnNU4EmWb+BPzC4w@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 11:52=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 2/13/25 14:13, Uros Bizjak wrote:
> > On Thu, Feb 13, 2025 at 9:48=E2=80=AFPM Dave Hansen <dave.hansen@intel.=
com> wrote:
> >> On 2/13/25 11:14, Uros Bizjak wrote:
> >>> According to [1], the usage of asm pseudo directives in the asm templ=
ate
> >>> can confuse the compiler to wrongly estimate the size of the generate=
d
> >>> code. ALTERNATIVE macro expands to several asm pseudo directives, so
> >>> its usage in {,try_}cmpxchg{64,128} causes instruction length estimat=
e
> >>> to fail by an order of magnitude (the compiler estimates the length o=
f
> >>> an asm to be more than 20 instructions).
> >>
> >> Just curious, but how did you come up with the "20 instructions" numbe=
r?
> >
> > Currently, a patched GCC compiler is needed (please see
> > asm_insn_count() and asm_str_count() functions in gcc/final.cc on how
> > the asm length is calculated) to report the length. For historic
> > reasons, the length of asm is not printed in asm dumps, but recently a
> > GCC PR was filled with a request to change this).
>
> So, that's also good info to add. You can  even do it in the changelog
> with little more space than the existing changelog:
>
>         ... fail by an order of magnitude (a hacked-up gcc shows that it
>         estimates the length of an asm to be more than 20 instructions).
>
> ...
> >> Is any of this measurable? Is there any objective data to support that
> >> this change is a good one?
> >
> > Actually, "asm inline" was added to the GCC compiler just for this
> > purpose by request from the linux community [1].
>
> Wow, that's really important important information. Shouldn't the fact
> that this is leveraging a new feature that we asked for specifically get
> called out somewhere?
>
> Who asked for it? Are they on cc? Do they agree that this feature fills
> the gap they wanted filled?

asm_inline is already used in some 40-50 places throughout the tree,
but there still remain some places that could benefit from it.

> > My patch follows the
> > example of other similar macros (e.g. arch/x86/include/alternative.h)
> > and adds the same cure to asms that will undoubtedly result in a
> > single instruction [*].  The benefit is much more precise length
> > estimation, so compiler heuristic is able to correctly estimate the
> > benefit of inlining, not being skewed by excessive use of
> > __always_inline directive. OTOH, it is hard to back up compiler
> > decisions by objective data, as inlining decisions depend on several
> > factors besides function size (e.g. how hot/cold is function), so a
> > simple comparison of kernel sizes does not present the full picture.
>
> Yes, the world is complicated. But, honestly, one data point is a
> billion times better than zero. Right now, we're at zero.
>
> >> It's quite possible that someone did the "asm" on purpose because
> >> over-estimating the size was a good thing.
> >
> > I doubt this would be the case, and I would consider the code that
> > depends on this detail defective. The code that results in one asm
> > instruction should be accounted as such, no matter what internal
> > details are exposed in the instruction asm template.
>
> Yeah, but defective or not, if this causes a regression, it's either not
> getting applied to gets reverted.
>
> All that I'm asking here is that someone look at the kernel after the
> patch gets applied and sanity check it. Absolutely basic scientific
> method stuff. Make a hypothesis about what it will do:
>
>         1. Inline these locking functions
>         2. Make the kernel go faster for _something_
>
> and if it doesn't match the hypothesis, then try and figure out why. You
> don't have to do every config or every compiler. Just do one config and
> one modern compiler.
>
> Right now, this patch is saying:
>
>         1. gcc appears to have done something that might be suboptimal
>         2. gcc has a new feature that might make it less suboptimal
>         3. here's a patch that should optimize things
>         ...
>
> but then it leaves us hanging.  There's a lot of "mights" and "shoulds"
> in there, but nothing that shows that this actually does anything
> positive in practice.

Let me harvest some data and report the findings in a V2 ChangeLog.
However, these particular macros are rarely used, so I don't expect
some big changes in the generated asm code.

> Maybe I'm just a dummy and this is just an obvious improvement that I
> can't grasp. If so, sorry for being so dense, but I'm going to need a
> little more education before this gets applied.

Thanks,
Uros.

