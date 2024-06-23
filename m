Return-Path: <linux-kernel+bounces-226383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A958913D93
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACD8B214B2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B6218410F;
	Sun, 23 Jun 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUK5SBPm"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823511822E2
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719166479; cv=none; b=XSQMiNa2i92tOAalmUT/6IJGUkdPUcIUoG9WU6oXsYTMrGnnjS8frZgZVeAcs4cn2gnHcO+zt6v5cPJtZhm1Zo3fi4QUyZ8NfwZElbvdZtP9FN+I8Nq/IlLCg5qYegpdcS5U2F8aybRHYKPStOzZ6GbyVXj7+llsOepaqUU6obM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719166479; c=relaxed/simple;
	bh=hrw2cWL1A7ev4AhwQWmduHTm6s1CxAkOpYTqIGX8hfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRPE1kNgMdyV/kl+lXyKPhX2ArcJC4TSpX4o8S3RBhXZ5NL8qw0KZklXcbexrhKEMZArxOcPECj9VpdZCXw9Pu7Nxc1tiGrIFZmYTyKIv2R/fBq9hq1yol1RvDADdkeCUQjc3xtwNtC/v3G+4GDTCr0UHCizpory2d61qfJHX3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUK5SBPm; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso38554511fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719166475; x=1719771275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAmqARKrHui/NaUmZfz82SlsXm+I+AB9Qkw5ktB+JRw=;
        b=XUK5SBPmZ2LICoxpsDSI4ynCs5tfKg0WbOUs7AzffYDrKwMkVAYPu6PrQG1//qV9zo
         LNDCOzHpvCmbTlgvwMeRNRtsBLKPtbf71fUsfyVpBWJ/Hh0H6q0k4N4XemAznIgJ4zL+
         vFzdA+FndEs4Dh+gyEkQhLxEVN2Wy6YcILFtuzQPmUVW4QTXh/a8Q1hPf1MA/7zFpjXu
         6Np7jrJz9ZNAiOTsthDR9dPi/CUKBH/wv7ZPyE9UY0EavZ5E3o3N89IPSpQHglDQdFyQ
         mF0qKtwhujTJTAon/JUKt4ullSswSLmhSg8axZtShiQSJvKqdSJLo+LPaZPqVbdImPub
         w8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719166475; x=1719771275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAmqARKrHui/NaUmZfz82SlsXm+I+AB9Qkw5ktB+JRw=;
        b=PdsDLUzqgtPxpkj/Z5mOMMmgX97tD6CaiCLqGyki/52ybVMK4xApyGikkw8JwHZUI0
         v0PLC3jRG1gfXtP4Gsv4HCSDmLMteI09SJcEEWPLwA5v9TotErZdZAuefMx/Yd8hxgK8
         HqYRhJkiMDUniKmt5HxGo6/H0TSqlsXjbj57e7ShuRIPk8JflZ/SMKRE5sHEuHF/6vFZ
         4W0T3HrBsFPsO8jvGzVT1LGgXQPjQTHSnD405AVXwzPRYC8VzlxSQjcT3/L4sZ+SPQaP
         iYw0Ut5o1gGfHpuSXFDtoKOqcxkF69V63/lcss95/erHSoZ/aSh1c0MzmOa0advMJ09e
         +jQA==
X-Forwarded-Encrypted: i=1; AJvYcCWy5zCrW2SQdPuvo6kOR+y2jYayCECpOqyrinFCptmJSVKEQl7abw39rsF8ZVDXZeP0nLRDxoM5tSIdYEqyQqMUONHOS2Z4AsRDnnp+
X-Gm-Message-State: AOJu0YzKofP6z4D0G+BuTZFCTQCRwhzD7ehDmNqgVesUBUsWEoOsgPGq
	Ykw1F6gcTvIxY47RC/cMcaZWbBeVqFgeN4YClr995IBSu+6MWQh6hdjQbuzMZJdVvqvsOHNZYqC
	avRk1Bd56jVbEcwfH7MvJOzn7Th4=
X-Google-Smtp-Source: AGHT+IFfyeGk4zOz61lEAAHkBgCnNzNpNQ5zKKohl4iOtOMwSULMnFWDfEm5WgxFRuCqdzcbSOjtLA7Gf6alclZRR0k=
X-Received: by 2002:a2e:9b4b:0:b0:2ec:5921:bb21 with SMTP id
 38308e7fff4ca-2ec593bea06mr18882271fa.10.1719166475181; Sun, 23 Jun 2024
 11:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
 <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com> <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
In-Reply-To: <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 23 Jun 2024 20:14:29 +0200
Message-ID: <CAFULd4b43=pTnAMKusJmGCeF1Bk-f6AyeOR8wGM8EieqhuH5WQ@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 7:49=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 23 Jun 2024 at 13:43, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > I disagree with the above.
>
> Your disagreement just doesn't matter.
>
> We don't introduce regressions and then blame others.
>
> There's a very clear rule in kernel development: things that break
> other things ARE NOT FIXES.
>
> EVER.
>
> They get reverted, or the thing they broke gets fixed.
>
> This is not debatable, or something you can "disagree"' with. This is
> how we work, and if you disagree with that, you had better get out of
> kernel development.

I disagree with *I tried to shift the blame to others*! I take full
responsibility for my patch, and I'm perfectly capable of fixing the
breakage with an alternative approach.

I'm OK with the revert, but it won't fix the underlying problem.
Please see the definition of __arch_cmpxchg64_emu - it forces the
address to %esi registers in the same way as __arch_try_cmpxchg64_emu.
Effectively, the compiler allocates 5 input registers just for the
instruction.

The alternative is to implement atomic64_{and,or,xor} as an outline
function, in the same way as e.g. arch_atomic64_add is implemented.
This will avoid the call to __arch_try_cmpxchg64_emu, and the whole
"instruction" will use just:

__alternative_atomic64(add, add_return,
      ASM_OUTPUT2("+A" (i), "+c" (v)),
      ASM_NO_INPUT_CLOBBER("memory"));

> Now, from having looked a bit at this, I can point you to the
> differences introduced by having to have the emulation fallback.

Yes, I know this - I also (runtime!) tested the emulation, but with GCC onl=
y.

> And I would personally be ok with leaving Pentium etc entirely behind,
> and getting rid of said fallback, but that's an entirely separate
> thing that will require much more discussion.
>
> Some people still wanted to support old 486 clones not that long ago.

This can be achieved by implementing atomic64_{and,or,xor} as an
outline function.

Uros.

