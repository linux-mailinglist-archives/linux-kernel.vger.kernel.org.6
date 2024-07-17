Return-Path: <linux-kernel+bounces-255381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A7E93400B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00FD5B21CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D831E87C;
	Wed, 17 Jul 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9Ok8yUY"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3688566A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231640; cv=none; b=uxhPvW7QoD3dEiiiSVHKrwT3UKvT2olpENgOEfJ0ZiZzYq51bt+lpOa9j9o0pIddGab6pqenbmfpzbZokWb7f37YXg6SIYYU9iZtQQcxjD6dxM72UI8ZxnzUeDoBX0z4IGmLjczDmkTs2+p+GI1IdncKC5g+soCsByANEZXPSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231640; c=relaxed/simple;
	bh=Wp07UcAhRL1R8uio7WTjm5z67oRHHmiAHs6r7E4fMQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYf3IqR4jxRTvtlVBJ9ELVTLePxHeB5s2p2Q9XlwQOxbQEaVcMSKhsJ+PFf9UZM8x6mOUZwhV3Av2pRvtVN0niKskg9wfq94USnDnhvKWH+cPNqQ22Ry8xbb69rRKuR2YHvDSDdO0AqP7sdRb5q6+1fXMVEmJ32F5AG1TUScAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9Ok8yUY; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eede876fccso60903861fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721231637; x=1721836437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0TYXvXsyKDm9Gm/9jOvNezoSc7ZaWUr4fn7rE/8S8Y=;
        b=A9Ok8yUY4RXCCIrM7rx623r0OUtVl2kK86EaErl2JsByTtAvqXOupksU9f5bvYdRKd
         OQja9N4BDIKy332alnLqQilAnhhwNX544AY9JMBwNkkDFabg7qqmwcnSvTqD/RnJv4H2
         +7FdhbCTqJBHDBWCrBZzfEFmUsMAEMRU9ufhsULFf6XdP5FxMcVmYjX1I7pP01x33X/I
         I0OzREOF0cfdFipzfyHCesLjNQtYesChmAsO3Ckc6Fbjd1JVE1anzdOhyIT/tZ77TN9S
         6oqXIREv9o74HNcQhh4z/T7BpQpYMqg5xgm0/n+7uMsGsb4wGM01pCYjRnBF9rah+7BV
         cPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721231637; x=1721836437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0TYXvXsyKDm9Gm/9jOvNezoSc7ZaWUr4fn7rE/8S8Y=;
        b=FkNPjPAILqx+QFm9ZbOGw8qUvmM22vHBtXMkcNI8VGnwLJXqq7cZHaNhC7y+KE2QiK
         rLc9/ltc2ta5kHdnix2Oon5Gi055rK68PnjGOauo4SPXbNd8PyKkIw14X7QAgYY/00t/
         Kzfw78DAxrNUueOxRoLRX5YQ4lFjfO3U4QK324eb0uOven8vzMW74b9YVHcv4tpxcnSY
         U7sPlqQoAI83rrQKas9IAiDOe1a2QBFdlhrT6M1GLLTYb6i3LqTA9sQnd/GMO441eH1I
         UplTY9HVW4fUJN06dDQ6j/1vggp52r1B1NUKjmV94qSDtnVdNSG/WI+ouCtNFAyeCe6m
         8VGA==
X-Forwarded-Encrypted: i=1; AJvYcCV2oEun6DYPAq25RI1GqFtJfV+rw9Ugd7GP5//NNJzSAYFkP641Y/d/vt/uarLQnQzDv4dEXWv9Xr3NSUqoU7Elzck2HhvezPG26FC9
X-Gm-Message-State: AOJu0YzB59CndKO13OQnG3Uf7VL9bzA1N24NXr/tMQQYo2Rg8E3t/cOC
	3fyDGhux3ZcLPngCWwEtOwRGlwSMFV0Gd5SK+2ou1C5YL1rwIRpd4Iz51RoFNZjg4vcOckYnqKR
	h/XHoMMSrIZ9byHZLtEjfYSsvSa0=
X-Google-Smtp-Source: AGHT+IFNav3o99G1G2XxxGKHijLrtShRGKEGj6GgPTIRzOWdanAGWRINlj3DG/YMJbdC5qahMmsK20OvTUaf4xOp83w=
X-Received: by 2002:a2e:7304:0:b0:2ee:7b7d:66df with SMTP id
 38308e7fff4ca-2eefd0c3f91mr14440341fa.9.1721231636473; Wed, 17 Jul 2024
 08:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526175655.227798-1-ubizjak@gmail.com> <ZpfX4KelYaXsHlHe@gmail.com>
In-Reply-To: <ZpfX4KelYaXsHlHe@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 17 Jul 2024 17:53:44 +0200
Message-ID: <CAFULd4YyoVvM3BnF8Ln3XD-kacavERjMCpw=1hXwCACvTPF1gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/percpu: Fix "multiple identical address spaces
 specified for type" clang warning
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 4:40=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > The clang build with named address spaces enabled currently fails with:
> >
> > error: multiple identical address spaces specified for type [-Werror,-W=
duplicate-decl-specifier]
> >
> > The warning is emitted when accessing const_pcpu_hot structure,
> > which is already declared in __seg_gs named address space.
> >
> > Use specialized accessor for __raw_cpu_read_const() instead, avoiding
> > redeclaring __seg_gs named address space via __raw_cpu_read().
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Bill Wendling <morbo@google.com>
> > Cc: Justin Stitt <justinstitt@google.com>
> > ---
> >  arch/x86/include/asm/percpu.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percp=
u.h
> > index c55a79d5feae..aeea5c8a17de 100644
> > --- a/arch/x86/include/asm/percpu.h
> > +++ b/arch/x86/include/asm/percpu.h
> > @@ -160,7 +160,10 @@ do {                                              =
                       \
> >       *(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) =3D (val);      =
 \
> >  } while (0)
> >
> > -#define __raw_cpu_read_const(pcp)    __raw_cpu_read(, , pcp)
> > +#define __raw_cpu_read_const(pcp)                                    \
> > +({                                                                   \
> > +     *(typeof(pcp) *)(__force uintptr_t)(&(pcp));                    \
> > +})
>
> So shouldn't this be carried together with the patch that enables named
> address spaces on Clang? Is it possible that this patch might not be need=
ed
> in a Clang version where named address spaces work as expected?

No, as diagnosed by Clang, there are indeed two identical specifiers,
so the patch also applies as a general patch.

Regarding Clang, before enabling the feature, issue #93449 [1]
(internal compiler error) has to be fixed.

[1] https://github.com/llvm/llvm-project/issues/93449

Uros.

