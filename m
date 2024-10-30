Return-Path: <linux-kernel+bounces-389454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C939B6D46
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F51A1F21A05
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAEC1D14E5;
	Wed, 30 Oct 2024 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bjohu4Rz"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86E1BD9D8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318947; cv=none; b=HXbof/gS/imVuP/m6ROn9R8r08etgsUEsNrfOKvoZMydLwEWfufSgx8thSzLXkS91lV4sIt1tEofX2fLOtYrd5lS4ZCuQsthGd/z+NVVQnjCiXBhalnzT5D7uV9dc6exVQFGpHfUlwlct+74lwMIaKZsAUr+j1J47DlikC3fZ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318947; c=relaxed/simple;
	bh=2wMIjMJ9U3vIM+8QqfNF8Rkv4RTWgD3KpGp1QHT7ZD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yb5VBxEMeICTIoP4QWzFn6zwFnF14LK6Olr47GXshmsm2LgXmxc6hl6i2sWAXolAgWO3nXJmdlrUSdcZ6JzkDxilab6G11kH8XJ3AxcaFy7t5SGjZXlHvmzY8jI82jH/kDAgTQvQ7qz/00nXF+iR9ZIJwWb1V1LbDVVW8t/dJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bjohu4Rz; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e34339d41bso1621647b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730318945; x=1730923745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngwfEIYbdyLNTkAD5QHGkC0QUp0XJJcJX0AQ5QRONt0=;
        b=Bjohu4Rza8oI+U2SYOicAlVpOOxaA6u/+Y6+u2VikBqKfA/ThD11cmRLPoZU2AoNG/
         omnuYBN1kHBOy76lVdpwt2T6iepTo9yZCsLQ9d/pVfgI/0ZNXuS5kTXghS6lMo5AA3UM
         7dbU7cz63zMwWp1ji9i4b+vGMC3sdU9eYGGT3Ic2t8+reWhsfBu8e35EsY5wEJMHiu9+
         B6c5R4qqRRzdHwkBwUnIDCExaRSiUzoQ3MyFFveu6Q1/GW0myEEgD6PcPWLYUiMSvzI4
         1VTfKBNsTkOmM4IYOx3wqVyorzY20eAwylZb5CJWkQPC7pK9VHP2rMM/z+HFRtwmzlrD
         Zg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730318945; x=1730923745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngwfEIYbdyLNTkAD5QHGkC0QUp0XJJcJX0AQ5QRONt0=;
        b=Zl67wp6gX1MHnQoOrZZWJ2otur0cY+FTB4tPWBwLPi8d7UlYl8mykVlKICsgjWKwGu
         mD4QAVCXUpGDplML6sEWEm3koX/9z4Q9OCx7gDiogCwd6cZas9CycAgGjpLtZqSMd/rX
         Vh8Yk7ezDtPIvZOaN/lIaeqS0UlAUuhyEjms26HFGi/ESQNv2BrhmSxyXpSBU9i7SPrE
         6Jfxd6h3RMNM9pM1NyV09lYrSKaJyjq2RtLBhK2JImMjizj0SL4mSHgGFeKMorlXNx5d
         /gKKprjzLvoD0YJ3tyQ3cMn34B2P9LjGgxtwYjHFmBMxSPpXUOHWFMerBJNbVuuC1psz
         s0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYIdBC6mGHuOUO9AHbDPGmqnGgoGeLs7mSc30KprTllec5o+frWXmA3i92Io9GMV4ZlbQg+pW6j2Mtvs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrswfaUPlTux64iagIX1evFHjO6Y5GE6vh1HZo3dtHnZSn7JN
	6Um3YbP7LTFEaoNs2Fi4urfbDJR/09bP6DTwDi8aOPNqgdamEaywVf372mjztosuAHGkJ2zJuQw
	422r7UAO7SGER11ACFENNOptuy8XKjyOQZlCA
X-Google-Smtp-Source: AGHT+IEASnFEOXc7vIoVIxbHZd9ySrbyhS7FOE7XZ3rBN9+qGykABsi2adr6i/4YVKA4HnTxwK7D/2FyJzndDRYeKZw=
X-Received: by 2002:a05:690c:2f89:b0:6e2:10d3:e13 with SMTP id
 00721157ae682-6e9d893fb09mr133553167b3.17.1730318944578; Wed, 30 Oct 2024
 13:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXEEbrI7K6XGr2dN@google.com> <20240913204711.2041299-1-jthoughton@google.com>
In-Reply-To: <20240913204711.2041299-1-jthoughton@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 30 Oct 2024 13:08:28 -0700
Message-ID: <CADrL8HXv6qG5ewYP07_b7a+FOKB5GAowQjV=6_sBPOrREi-c1Q@mail.gmail.com>
Subject: Re: [PATCH 03/11] objtool: Convert ANNOTATE_RETPOLINE_SAFE to ANNOTATE
To: peterz@infradead.org
Cc: seanjc@google.com, jpoimboe@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 1:47=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> On Wed, 6 Dec 2023, Sean Christopherson wrote:
> > On Mon, Dec 04, 2023, Peter Zijlstra wrote:
> > >
> > > --- a/arch/x86/include/asm/nospec-branch.h
> > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > @@ -193,12 +193,7 @@
> > >   * objtool the subsequent indirect jump/call is vouched safe for ret=
poline
> > >   * builds.
> > >   */
> > > -.macro ANNOTATE_RETPOLINE_SAFE
> > > -.Lhere_\@:
> > > -   .pushsection .discard.retpoline_safe
> > > -   .long .Lhere_\@
> > > -   .popsection
> > > -.endm
> > > +#define ANNOTATE_RETPOLINE_SAFE    ANNOTATE type=3DANNOTYPE_RETPOLIN=
E_SAFE
> > >
> > >  /*
> > >   * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instruc=
tions
> > > @@ -317,11 +312,7 @@
> > >
> > >  #else /* __ASSEMBLY__ */
> > >
> > > -#define ANNOTATE_RETPOLINE_SAFE                                    \
> > > -   "999:\n\t"                                              \
> > > -   ".pushsection .discard.retpoline_safe\n\t"              \
> > > -   ".long 999b\n\t"                                        \
> > > -   ".popsection\n\t"
> > > +#define ANNOTATE_RETPOLINE_SAFE ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE=
)
> >
> > This fails for some of my builds that end up with CONFIG_OBJTOOl=3Dn.  =
Adding a
> > stub for ASM_ANNOTATE() gets me past that:
> >
> > @@ -156,6 +171,7 @@
> >  #define STACK_FRAME_NON_STANDARD(func)
> >  #define STACK_FRAME_NON_STANDARD_FP(func)
> >  #define ANNOTATE_NOENDBR
> > +#define ASM_ANNOTATE(x)
> >  #define ASM_REACHABLE
> >  #else
> >  #define ANNOTATE_INTRA_FUNCTION_CALL
> >
> > but then I run into other issues:
> >
> > arch/x86/kernel/relocate_kernel_32.S: Assembler messages:
> > arch/x86/kernel/relocate_kernel_32.S:96: Error: Parameter named `type' =
does not exist for macro `annotate'
> > arch/x86/kernel/relocate_kernel_32.S:166: Error: Parameter named `type'=
 does not exist for macro `annotate'
> > arch/x86/kernel/relocate_kernel_32.S:174: Error: Parameter named `type'=
 does not exist for macro `annotate'
> > arch/x86/kernel/relocate_kernel_32.S:200: Error: Parameter named `type'=
 does not exist for macro `annotate'
> > arch/x86/kernel/relocate_kernel_32.S:220: Error: Parameter named `type'=
 does not exist for macro `annotate'
> > arch/x86/kernel/relocate_kernel_32.S:285: Error: Parameter named `type'=
 does not exist for macro `annotate'
>
> Sean pointed me at this series recently. It seems like these compile erro=
rs
> (and some others) go away with the following diff:
>
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/=
nospec-branch.h
> index 0bebdcad7ba1..036ab199859a 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -489,7 +489,7 @@ static inline void call_depth_return_thunk(void) {}
>         "       .align 16\n"                                    \
>         "903:   lea    4(%%esp), %%esp;\n"                      \
>         "       pushl  %[thunk_target];\n"                      \
> -       "       ret;\n"                                         \
> +       "       ret;\n",                                        \
>         X86_FEATURE_RETPOLINE,                                  \
>         "lfence;\n"                                             \
>         ANNOTATE_RETPOLINE_SAFE                                 \
> diff --git a/include/linux/objtool.h b/include/linux/objtool.h
> index f6f80bfefe3b..e811b2ff3a9c 100644
> --- a/include/linux/objtool.h
> +++ b/include/linux/objtool.h
> @@ -159,6 +159,7 @@
>  #define STACK_FRAME_NON_STANDARD_FP(func)
>  #define ANNOTATE_NOENDBR
>  #define ASM_REACHABLE
> +#define ASM_ANNOTATE(x)
>  #else
>  #define ANNOTATE_INTRA_FUNCTION_CALL
>  .macro UNWIND_HINT type:req sp_reg=3D0 sp_offset=3D0 signal=3D0
> @@ -169,7 +170,7 @@
>  .endm
>  .macro REACHABLE
>  .endm
> -.macro ANNOTATE
> +.macro ANNOTATE type:req
>  .endm
>  #endif
>
> This series applies on top of the latest kvm-x86/next with only a few tri=
vial
> conflicts, so I hope you are able to send a new version.
>
> I could send one for you, but I have no idea how to properly test it.

Hi Peter,

I'll go ahead and repost this series soon unless you tell me otherwise. :)

