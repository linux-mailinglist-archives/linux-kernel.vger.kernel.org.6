Return-Path: <linux-kernel+bounces-546733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306F1A4FE22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 939AD7A2C94
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29A823370F;
	Wed,  5 Mar 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoUE60Qu"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0EF205AA2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176109; cv=none; b=g/p5A0UCjoxUqaQUpLyB77CpKWnpSJB1djRu7U8P2173hKAOjw7AYzTnhbjISvIvOsMB/T3WWugHYxJ7WnmCQnXBMr2i0mn2uBwIT9O9M6uG0Cd9ZUAy5rBAE/epkiTbi8hiX1diLpqCuKnAbvqlUR5OknBG9CY69nsD/zkr4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176109; c=relaxed/simple;
	bh=N5xuZkhTIdUqJxHvjuChPfUtp5Qc1sdPzxMmrBiezBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNEjHrEhM/7OzujwJk0ndoupLQFrrlF/xTM1nZPKNJ7YrbQJIBDqUmxwZtA6WSozpG959w7kOxOBZM4JhOS08a5Hu0nKTRFJo/yOpDF2wJ9/1NfYONRY7NEUuUiL8trqA+l8NOByH+MIkx0ljIYR2bsDZvKve8AX1EKMYvmoE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoUE60Qu; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso152079666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741176106; x=1741780906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfmFkbc+JSsWE/PQNqOgO/asaC1Fe2OXP3J2ULbe0o4=;
        b=GoUE60QuGGvuRim+J4IPl1s+aWBYvwQPcZXl1FqKMEJlahBnTeaq9LT7YZGEk9kdBK
         yI+gaezGMAMGk8bwZ9+zeukPZjINiHoCwEOqUcUoWBgXQ6unb1Q74P57udvuBeAi6ZbI
         DiL3AwF+ukfmKHfU5uyWdZ4BxntcR8o9PiWYEo6DiZYIe/uVQlGglVmlG4R95QvMSViY
         DMFdEJC8LgiG4R1RupuyPVmldhwbb7JPMrc6RTZXif1F9zl13RKDB4h5Y3la8zVwg/+k
         hkhvprqHUP7Sa/1alY0AXBY0U3fG4DH/BpKU7zmyg+LZ5ZAgeVy/EgDf7aai9Mmfmdke
         d0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741176106; x=1741780906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfmFkbc+JSsWE/PQNqOgO/asaC1Fe2OXP3J2ULbe0o4=;
        b=weZv4oPm2g8vwncihPCDVvLE14zxx5cLojlhu3hxKR0I260txbFeCpp+lguEYGJfRQ
         hS9vUF5Eh2ULocbE3oqg8HzV+qAEBwgyk7TFChgb71v29qc5F7mLrp3hLrTSB2196+Ct
         HA3TagIMmMwsFMGca6fniiZ1in8d7n/1tjA40pLMGGefA30/1Q4fMWeRcHRfKxrWw5Rf
         RhIUSGAXAI3QFOgaOka3WZUuHc35My0F6bvV6mmxqpA9j2qjxbJ/LALXdm8ZlrdtjDdD
         7QiaKmVieWe27zen8nyystySX0+uJYCoCAeXDlrPL7SSgkGCCyeBfDuwz78UHwNugEHe
         6bYA==
X-Forwarded-Encrypted: i=1; AJvYcCUHJ5NTEKd59+JGeKKLhes6cuUYQvSDGjfKn8Wnmo05AW6tzHka9bBRLNgD2LpeEhLOh/+MdW4BHFNH6bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyjlEz8pT8R7rnd67IXI0kPbxflIzVKWOoMavVx84VF6Dmllpv
	wPNgqahPCghgFc+7mkkzrBYy5cirztbzSRH7X/CZukZrqDhtefftvNUqghMRrZZiKR03olxmxy7
	y9OH1FhminCzUb2gU8K5y3q6t+Ls=
X-Gm-Gg: ASbGncu7gTazFbP12y0PM3pyZmXI+2gWVf7eh2CjO1lhGAGrjBCNhdlP7HDAGiGh72E
	efJXWMPB4Oa/SL2hNl4Tjvp0J+1YawyUG4m1JPU0C+biulRFxoYkJGgNZKwHHXiXH3ekP53N9+6
	Bvu2zNrROpSYipoB8iousSSXVq
X-Google-Smtp-Source: AGHT+IGq2YT8yUStV2o0B751wn9zVquqD8Job6QdGTJ13GQ95PRoTeKTzjFlOaP2jqj7/lBugEpAR/Tj37Of+wJCrbQ=
X-Received: by 2002:a17:907:1c8e:b0:abf:6a8d:76b8 with SMTP id
 a640c23a62f3a-ac1f0ef6981mr739837766b.11.1741176104289; Wed, 05 Mar 2025
 04:01:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <20250123190747.745588-5-brgerst@gmail.com>
 <tns2rrzk7vs3linnjevr24qyg4sm6hakndsgqvqsowqwwlrdcj@zus5wu6u3ju3>
 <56A91DC4-1A8C-4134-976E-BBCBF9BC784F@zytor.com> <CAGudoHEQbBEbjXKfPR6+ktxj5GzBpQ+CjMXi+G7wqR-UQmW9Fw@mail.gmail.com>
 <CAFULd4ZJ=Ysz+JxSUA_n_qst9AWYGvK9OvEjZCm8vQ3wQ7qfGw@mail.gmail.com>
In-Reply-To: <CAFULd4ZJ=Ysz+JxSUA_n_qst9AWYGvK9OvEjZCm8vQ3wQ7qfGw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Mar 2025 13:01:30 +0100
X-Gm-Features: AQ5f1JpBpPgLE5G6KPRfqD3XCiDWFB9yrHft_zMBtt8HcAjuErP-_1DM62iTckM
Message-ID: <CAGudoHG3pogGkTG5M+jMevn16hYLsy5zdbM0y5gBP0XMOK1vNw@mail.gmail.com>
Subject: Re: [PATCH v6 04/15] x86/pvh: Use fixed_percpu_data for early boot GSBASE
To: Uros Bizjak <ubizjak@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:16=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Wed, Mar 5, 2025 at 12:49=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> >
> > On Wed, Mar 5, 2025 at 12:45=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> =
wrote:
> > >
> > > On March 4, 2025 2:26:20 PM PST, Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
> > > >On Thu, Jan 23, 2025 at 02:07:36PM -0500, Brian Gerst wrote:
> > > >> Instead of having a private area for the stack canary, use
> > > >> fixed_percpu_data for GSBASE like the native kernel.
> > > >>
> > > >> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > > >> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > > >> ---
> > > >>  arch/x86/platform/pvh/head.S | 15 +++++++++------
> > > >>  1 file changed, 9 insertions(+), 6 deletions(-)
> > > >>
> > > >> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/=
head.S
> > > >> index 4733a5f467b8..fa0072e0ca43 100644
> > > >> --- a/arch/x86/platform/pvh/head.S
> > > >> +++ b/arch/x86/platform/pvh/head.S
> > > >> @@ -173,10 +173,15 @@ SYM_CODE_START(pvh_start_xen)
> > > >>  1:
> > > >>      UNWIND_HINT_END_OF_STACK
> > > >>
> > > >> -    /* Set base address in stack canary descriptor. */
> > > >> -    mov $MSR_GS_BASE,%ecx
> > > >> -    leal canary(%rip), %eax
> > > >> -    xor %edx, %edx
> > > >> +    /*
> > > >> +     * Set up GSBASE.
> > > >> +     * Note that, on SMP, the boot cpu uses init data section unt=
il
> > > >> +     * the per cpu areas are set up.
> > > >> +     */
> > > >> +    movl $MSR_GS_BASE,%ecx
> > > >> +    leaq INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> > > >> +    movq %edx, %eax
> > > >
> > > >       movl
> > > >
> > > >I'm bisecting perf breakage and landing on this commit breaks the bu=
ild.
> > >
> > > Breaks the build how?
> >
> >   AS      arch/x86/platform/pvh/head.o
> > arch/x86/platform/pvh/head.S: Assembler messages:
> > arch/x86/platform/pvh/head.S:183: Error: incorrect register `%eax'
> > used with `q' suffix
> >
> > Per the above, I presume it was meant to be a movl.
>
> Please note that this part is further changed in [PATCH 8/15] [1], so
> the breakage is temporary.
>
> [1] https://lore.kernel.org/lkml/20250123190747.745588-9-brgerst@gmail.co=
m/
>

Top of the tree does build, so I assumed this did get addressed in
later patches.

I am saying I ran into this build breakage while bisecting. Other
people may be in the same spot.

It should pose no difficulty to s/movq/movl/ in the branch and be done with=
 it.

--=20
Mateusz Guzik <mjguzik gmail.com>

