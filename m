Return-Path: <linux-kernel+bounces-230358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20D8917BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FBE281D19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E801684A1;
	Wed, 26 Jun 2024 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFsKfjT7"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA49815F33A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392842; cv=none; b=apFPs+w+1Vk4HdmPFuDgxYzZQAADL0BUeNfvTrY7Voq38mSXG/kA3Kibyv1f6xxgQLIgbfnIHT/aFJdk0bjshWVvP8ZuxTACIJ5XTBLN1cSCU6uxh8StkICNnMkLjFyz65i9bP4xwXIPiPhObTyaQPdl8J7ktHXg76aXanAPlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392842; c=relaxed/simple;
	bh=jyKpEKUVlq/lY8qtzzG37clBDo3AcY8FiQLLGdnjJrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3l3hUtys0bEDnc27xpdQio8kZkGg1364o+/oXsopNpgbIBRsdRt9+QC9voMZ7pJTi7zxi1bWPjm4r7YRVcSAf1VAeJVQ7zXafTVmqcr/+9EPhj9h63y522jdU/qo/tgKvyZraXhOPmwR+TrB9T1dzVn8ID+uvHOGj7nMBTQvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFsKfjT7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec1620a956so77512271fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719392839; x=1719997639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ5MPl2JCBfX2ZFWJC9/OLFAr1UniKx13nANchHooqY=;
        b=lFsKfjT7hxaI4qdi5p/1/sne3/9CG8ACQlyQEjSuPd3FmM4ucar5ezGEFSAa7/QQMt
         WjiHLLpMarBKEu4brgYXiYfubB/p74U+igVvbsIgztKsLZpIqMdafSIVUWiBSwBDlMxO
         od6oNw4grpJNt6k72y1MRXUCcZCu9W+LX4E4COKBuGOrqY9LwaMZ0AUg71KbsHuKqgma
         +hAIkqejw46XQ5m5zy52jv1NPLxs7OlsUfvkBouVc5qVNePopAHbIlJJHNPNcOKn7Zff
         ShLGvUtoNJE8Ho3aBo3xDllIxp34xl7+LJVDeN+U/Mo2WZiqHInT+gKMjiBwub+C7HjM
         FIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719392839; x=1719997639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ5MPl2JCBfX2ZFWJC9/OLFAr1UniKx13nANchHooqY=;
        b=sdA66HGfpu42pkzOfGUcYYjuGW7qyx85qiLDwyzadmkLTCZ9POWsDvwcEnFUxC7DQU
         +53rUDhzWssxpfHponu6r9p8jwoWfFuE7n09dk8zzxV2WDqL++vAam/+zeXpdUwfI8Zr
         cI3/ap5HyjgVDrntEFWrR0wombNc+r04Dl6v54TUIJomGp20dFKZ754RlvDN/rdV7jTU
         ddnRjBpRVgn9nbLTDEbMwhzAxaTBsw3wbPDyiBlpZbsSpMABY+kmn9ly9iv2WNC0c/3/
         sn5c/T30K2TlO6rWVCRgLrfMq7aqlQlt3M+OkCWdG5/lNy6i/y4e9cCgh3pZL97LJ/Y2
         wktw==
X-Forwarded-Encrypted: i=1; AJvYcCWNZ5nzKw9OAjyC7pmdP3Ddj0sZJVEqQIeTJ31DyTvDJu+t2jP2BZlXinyr0DSnDg4fnChaCjQi+mgZMmUJ1YQWaTKFc+Kn7hJbyzfW
X-Gm-Message-State: AOJu0Yyh2tlKXlRbmaj+0rDds6BN4TyiB/HI4qYpRrd28mN+msxNilzF
	u9DYGA0A7hnCftImhQu8yIJLupZY9/Hy4CstHAZ0ZKKrObskHHSZB89rViGQcKbbr5Kv+RYbBWL
	q0Jhi/D6xLW5LVjTDk0wu46pU9Ow=
X-Google-Smtp-Source: AGHT+IH8y3gmJu6E6jCdBP+C5mKJemJ3soTyR6moedxS2bBbIeBa8beuQAnKj9rJZ7vascRqwqb5Enzo5VyqJ+g5Cw4=
X-Received: by 2002:a2e:96d4:0:b0:2ec:56d2:de6e with SMTP id
 38308e7fff4ca-2ec5b39c287mr54975171fa.46.1719392838490; Wed, 26 Jun 2024
 02:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
 <20240626010924.478611-2-torvalds@linux-foundation.org> <CAFULd4YUBGO1wmsacsxm5ZdbKu++evNC0NbLpGjZVQFTeJze7A@mail.gmail.com>
In-Reply-To: <CAFULd4YUBGO1wmsacsxm5ZdbKu++evNC0NbLpGjZVQFTeJze7A@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 26 Jun 2024 11:07:06 +0200
Message-ID: <CAFULd4Y5ROJjj_6ZA_A9F=xq8oOEWaq5Kodsj24T=PCFFeYf7w@mail.gmail.com>
Subject: Re: [PATCH] x86-32: fix cmpxchg8b_emu build error with clang
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 9:39=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Wed, Jun 26, 2024 at 3:13=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The kernel test robot reported that clang no longer compiles the 32-bit
> > x86 kernel in some configurations due to commit 95ece48165c1
> > ("locking/atomic/x86: Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor=
}()
> > functions").
> >
> > The build fails with
> >
> >   arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly requi=
res more registers than available
> >
> > and the reason seems to be that not only does the cmpxchg8b instruction
> > need four fixed registers (EDX:EAX and ECX:EBX), with the emulation
> > fallback the inline asm also wants a fifth fixed register for the
> > address (it uses %esi for that, but that's just a software convention
> > with cmpxchg8b_emu).
> >
> > Avoiding using another pointer input to the asm (and just forcing it to
> > use the "0(%esi)" addressing that we end up requiring for the sw

A nit: offset 0 is required only for %ebp, so the above should read "(%esi)=
".

> > fallback) seems to fix the issue.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202406230912.F6XFIyA6-lkp=
@intel.com/
> > Fixes: 95ece48165c1 ("locking/atomic/x86: Rewrite x86_32 arch_atomic64_=
{,fetch}_{and,or,xor}() functions")
> > Link: https://lore.kernel.org/all/202406230912.F6XFIyA6-lkp@intel.com/
> > Suggested-by: Uros Bizjak <ubizjak@gmail.com>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > ---
> >
> > Added commit message, and updated the asm to use '%a[ptr]' instead of
> > writing out the addressing by hand.
> >
> > Still doing the 'oldp' writeback unconmditionally.  The code generation
> > for the case I checked were the same for both clang and gcc, but until
> > Uros hits me with the big clue-hammer, I think it's the simpler code
> > that leaves room for potentially better optimizations too.
>
> You probably want to look at 44fe84459faf1 ("locking/atomic: Fix
> atomic_try_cmpxchg() semantics") [1] and the long LKML discussion at
> [2].
>
> --quote--
> This code is broken with the current implementation, the problem is
> with unconditional update of *__po.
>
> In case of success it writes the same value back into *__po, but in
> case of cmpxchg success we might have lose ownership of some memory
> locations and potentially over what __po has pointed to. The same
> holds for the re-read of *__po. "
> --/quote--
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?i=
d=3D44fe84459faf1a7781595b7c64cd36daf2f2827d
> [2] https://lore.kernel.org/lkml/CACT4Y+bG+a0w6j6v1AmBE7fqqMSPyPEm4QimCzC=
ouicmHT8FqA@mail.gmail.com/
>
> Uros.
>
> >
> > This falls solidly in the "looks ok to me, but still untested" category
> > for me.  It fixes the clang build issue in my build testing, but I no
> > longer have a 32-bit test environment, so no actual runtime testing.   =
                                  \

...

> >                                                                        =
 \
> > -       if (unlikely(!ret))                                            =
 \
> > -               *(_oldp) =3D o.full;                                   =
   \
> > +       *(_oldp) =3D o;                                                =
   \

With the above part changed to:

       if (unlikely(!ret))                                             \
-               *(_oldp) =3D o.full;                                      \
+               *(_oldp) =3D o;                                           \

Reviewed-and-Tested-by: Uros Bizjak <ubizjak@gmail.com>

Runtime tested with .config provided by test robot on qemu-i386 with
both clang and GCC compiler:

LKP: ttyS0: 229: Kernel tests: Boot OK!

Thanks,
Uros.

