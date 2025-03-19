Return-Path: <linux-kernel+bounces-567301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C87A68455
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F354C19C15AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB111224889;
	Wed, 19 Mar 2025 04:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXqnwOAZ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED318E25
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360291; cv=none; b=BksMc9SuLoChv9ux1eywYWmby8C5vnQSkrMNmsV9Oc1tCyxtwo03pQzNmP3MPGDVTv5ES3JPYROhJvJHX/4negz1N/Q3hz6aKl8pxzPm4XTM/IZHpCSFFg3yF8BCP2UjTLILl+HoMRcbTXT5sdA8sd8DT2UhflsNWtaLsURPJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360291; c=relaxed/simple;
	bh=6dmLteYbfB8fzknUcrreaVbsbiPRSTkIkVds4uETTQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNyE/lJZN53CNA/2e+kgW+uc+/2FSduXB9RAJtxKcuKEtwJqNuowcGWiby6jJ7nR65dZxm3xN+p/AqG0SWlYRl9pjcZwIW0m2qjoz2uFObkPuwy5uB6fkrn0vzbpBrbprB3NgzRCEhGpAsfpZRsTZkXTU7A2x2rGlT65Rt6i2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXqnwOAZ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bf1d48843so60862331fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742360287; x=1742965087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y9xlcf+WRl5l1Cpty9Df+XkqeQ6jRu02q2TKExCcK0=;
        b=SXqnwOAZtRR21EZA7WxQxFZieNqflIyptfkLX8/AwzKylM+HJobt8Vs/eW1+6GGx4G
         2F7qlRvaBeUkVm7wY1zLjhdW3Smoi6dfHIeteVRnNqrSRafwowSH7Tu09W8p4z/cHm3n
         jnE27QDp4nENpMYwO3SHy8cmYLkOrNAZSJ+MpLyw7YINKHisudYacYc9XFxhT8zOX1vP
         doAwBCAdMF1FjifDwdyv4ujG5QzZ0vDTVQQbhm10QEyXCMR+tWFakir2Vs5xXAAQWOSd
         jUU9GeMPCYQI5r1bRyKkMwXFvNAYppJQeBNrJI9I0cfodOBqHvuqdomUPxrGAlES4LaH
         gFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360287; x=1742965087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8y9xlcf+WRl5l1Cpty9Df+XkqeQ6jRu02q2TKExCcK0=;
        b=RIw2oLD93388HxkO9NJ0KfCqnHJsM2VCv4K0lgkSazg2IiiSCgDOsM5uScWAtzalC8
         qht2D1xe8s4XB5fvWs373344M19UNSt+NRMu/Q552wC/XqZnjKjCftyeJmunw27043B5
         rKC+bJMIw8cEXrZuRpPMEuyQFAzZApMoM9MybBXo40yrwTuBJ8z9+4Tq4g3KHRKSSwKg
         1wGwaaPQ+/8MsC1HgGkVBviA1dRn1itKaj7PK+q2Gs4ebIGUEGFSbhy2I/YcxO/qEKaj
         fqaN9vFfLFVMvUMPmMnL1UmI1hjR8ftBV8Ms8D/1MLlSCeRdze3m+VeBNOqO4BSm8krY
         pKoA==
X-Forwarded-Encrypted: i=1; AJvYcCUACHn1yUzXpVdSPuHFtqD3mS78tukWiw76mBBEcFCKXZotBUIdThWntKAW+8bv6sZ/NImOa1HGj7JsKuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59QDIiGDpB5XnV0nPjea9SOuS+RDLcK5b4JDI1TUELBSHXXuM
	V1eSuqu/O9gGQz9HdNqx5U2rsCIk3EhbQzWY6gkuw3wPl8vTHA3AUVeJ1NYSZyThfOWPD9blPdg
	TtfoNlP1C9w1NzH/C43iJWQdmOiE=
X-Gm-Gg: ASbGncuOC9zzVlqx3SbGfYWubBNIZVy7fYM8rpzzBSF2yQfQYpTczPjvWc2QL7kCdJg
	NdsBu+4Ja8ZqgDv+Zx3aeAMQeBHXhTvULjuVSn+gorqVkjNWs+mHN7636BDdZ9ndiDntge+0A24
	Ag4g7hrXVrGyC9uvrW2Sb9IKffc2Huz+Ai2G/P
X-Google-Smtp-Source: AGHT+IEzPCSXi92LROu2RvtNr4QyUJ084aTODRGGuZlKnAwO/KIISOkdVYCGg4GsmJRu8fxHJAT8pdaQG9RYdJ/L+UI=
X-Received: by 2002:a05:651c:221c:b0:30b:cc6a:fff7 with SMTP id
 38308e7fff4ca-30d6a3ad0f1mr3988031fa.6.1742360287231; Tue, 18 Mar 2025
 21:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317221824.3738853-1-mingo@kernel.org> <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
 <Z9m1rtmlk1PxGIQA@gmail.com> <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>
 <Z9m_kUqxqMPfU8Fl@gmail.com> <Z9nTfFiPv0-Lxm-_@gmail.com>
In-Reply-To: <Z9nTfFiPv0-Lxm-_@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 19 Mar 2025 05:57:55 +0100
X-Gm-Features: AQ5f1Jo4SXhdBwCTJocR4Z3vk4_J_q9D0yyewYetdCnIk9RK-JFetp4ByFfg_Rg
Message-ID: <CAFULd4aFUun7+1izxbDM8nTEEta5PApysyTGsn1hjvQND=2UtQ@mail.gmail.com>
Subject: Re: [PATCH] compiler/gcc: Make asm() templates asm __inline__() by default
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, "Ahmed S . Darwish" <darwi@linutronix.de>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, John Ogness <john.ogness@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 9:11=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:

>  #ifdef CONFIG_CC_HAS_ASM_INLINE
>  # define asm_inline __asm__ __inline
>  # define asm(...) asm_inline(__VA_ARGS__)
>  #else
>  # define asm_inline asm
>  #endif
>
> And I fixed up the places where this isn't syntactically correct:
>
>  35 files changed, 82 insertions(+), 79 deletions(-)
>
> I haven't looked at code generation much yet, but text size changes are
> minimal:
>
>       text         data     bss      dec            hex filename
>   29429076      7931870 1401196 38762142        24f769e vmlinux.before
>   29429631      7931870 1401200 38762701        24f78cd vmlinux.after
>
> Which is promising, assuming I haven't messed up anywhere.

Please use bloat-o-meter, it is more precise.

Actually, functions with the most impact (x86 locking functions and
__arch_hweight) were recently converted to asm_inline, so besides
__untagged_addr, the remaining have very little impact, if at all
(c.f. amd_clear_divider() ). There is also no need to convert asm()
without directives inside.

My proposal would be to convert the remaining few cases (the remaining
asms involving ALTERNATIVE and exceptions) "by hand" to asm_inline()
and stick a rule in checkpatch to use asm_inline() in the code
involving asm(), like we have the rule with asm volatile.

I don't think redefining an important C keyword is a good approach, it
obfuscates its meaning too much. And as has been shown by Ingo's
experiment, there is a substantial effort to fix false positives.
Instead of fixing these, we can trivially convert the remaining cases
to asm_volatile() as well, without obfuscating asm(). Checkpatch can
take care of future cases.

Thanks,
Uros.

