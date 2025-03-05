Return-Path: <linux-kernel+bounces-546207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6614BA4F7BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57353AA76A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18061DDC12;
	Wed,  5 Mar 2025 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtkCjWfO"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF015666B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159009; cv=none; b=pGuAqXhPQnupPjJioin5uaOZ4/t3CGgIVdu3g6kskGHUt9VjmCM8zokzaui+z1hOPPMi3Ippii3KE2qRHPKOK46QnVVM9GklQO6bOaqbpTyZSfPM6W3O5krlTpB0/JzFVTxoJd5wr+QqwGN33RM6FogEBSjWLntwQTiu6K0R64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159009; c=relaxed/simple;
	bh=1x1yz8gzYXTL2IR5s5/coZ1wMGjZJeRUom+wBthjo/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sR/Bb0WnaA8kBiUQalxYXneV7//Ha6kSdwQGnC8A584lJoZ/aL/xf4e9En3bLbs/jxYvd4JTl3hNW+75iSrk2ol9uCL8umOKsEuIDOme/cuYkKvd2K/COyk+fIg+xG86uRzlhbHwtxbrFCCHuXUT+pGmEoN/U3yW7cC6ijP/WiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtkCjWfO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5495078cd59so5338614e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 23:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741159005; x=1741763805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsiMy6Wrm6MrI1vb64ocVMXgjxkdI9Xm3hSLyWPY3S0=;
        b=BtkCjWfOkvNuW+DBgeVBtBmVWV/2Dd/5N0UMB3/ulB7XmMGp/IRLa8Qt7OlpTpO9tB
         AmqmKatdM2+PHM/+wVVgELuw8+CDGHHTtgHzVYRlDuffsC3+G6i6OHvrHWrK0AFZDgxa
         /G63saS7LmQZFXI7AF+eZfj6Dv4D1yQjgd7TM/JiSinIDfC6HbOZaa2dXZct/qOp2S46
         FKDGwO65EMICVJ1/4pBG6SIf1Pf7l5kk2tlU8dWD/fbKzyN842gWB78mfVRJ/+WGbfD2
         9Pa9gIAgBZx+1P9qGigwr/ijOSwbV2Sm2+W99jJeoffPmEKa5EeB3VZylTUfBMR5aows
         s8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741159005; x=1741763805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsiMy6Wrm6MrI1vb64ocVMXgjxkdI9Xm3hSLyWPY3S0=;
        b=Y+NS/Tq6aX52b3qWtqbOp29Mm2F5LtPGjmcYI4ZqFQ7zwMU82r+YyDogmJ2ZKW13sG
         Q6svDXLtG/AMbxeN6pYMDzhHEHFAp2Q2IIkXdnE01A7ACKF1QRqPuLtjdkFRGDZhR9gU
         lO2u40wrKRiHj6fQuMd9frldQJo3laKI0ISMePH2AMYiHp/2Gw9z1D6ZrCNgQxGLlLO3
         mA556chgK0Z4NuTR9vZCyktRwkMw+qP4fE1qAj6fItdhEwtGNL7rouWv7ZXoc+pq/XNM
         yR0yB0mSiv4SblOtYNCewN3mMn0nw9KvoQUqO2pQbys45OxMRskvrBn0mkMgoGJCKcNj
         qEpw==
X-Forwarded-Encrypted: i=1; AJvYcCXsmvXkbWNCVkortkChhfaw3E5aVUuCPqwtqdpWWLAn+hjM0IqTOMFSj6aZn5X0LDriVqlEBnB5RC/ffO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGEfytTJTOGJ+xe/2OA9x6T3OZ+bMAV9rrwSvfd3yuiexjLFdP
	b44+wp9v3qNj6rArObWwYObp6bktGp02olXqQ0gCaMvUkf8p4K/1KL8qUDF2eplolVRV7lvpdIi
	nZrpW7V7NYGb4B8LWzmw36bJIq7k=
X-Gm-Gg: ASbGncs6R8gIw313ETyctb3yuxooR8QTEhPiVK8qoCfBWwUoQGtjvUCqy0wDKsc9puQ
	9JUmHzf4VDQcJDGikDNYmDmYK5Q4sokK6DC+KwawUkM6JZHlxRIw/I8YGruyk4Swz1XJXsVL9US
	xPVpuWgyIfs6Q2Ow2Ea+spGvSZVg==
X-Google-Smtp-Source: AGHT+IF3NVCYdq9rzSrlxgZTuYpv3l+kB+oFvAwd+PCAX3TRB0NoG9/6oZrW9kKhLOg4nrs8xeAHk8Tdx8O6oJbWF/U=
X-Received: by 2002:a05:6512:a93:b0:545:cc2:accb with SMTP id
 2adb3069b0e04-5497d34dbc9mr695923e87.28.1741159005159; Tue, 04 Mar 2025
 23:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <20250123190747.745588-5-brgerst@gmail.com>
 <tns2rrzk7vs3linnjevr24qyg4sm6hakndsgqvqsowqwwlrdcj@zus5wu6u3ju3>
 <56A91DC4-1A8C-4134-976E-BBCBF9BC784F@zytor.com> <CAGudoHEQbBEbjXKfPR6+ktxj5GzBpQ+CjMXi+G7wqR-UQmW9Fw@mail.gmail.com>
In-Reply-To: <CAGudoHEQbBEbjXKfPR6+ktxj5GzBpQ+CjMXi+G7wqR-UQmW9Fw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 5 Mar 2025 08:16:39 +0100
X-Gm-Features: AQ5f1JoiGd6ds57AZ6QtwMe4c-Bb8fK9Gpauwv9fzavPqHLipjoe3UY6ZQhp0q4
Message-ID: <CAFULd4ZJ=Ysz+JxSUA_n_qst9AWYGvK9OvEjZCm8vQ3wQ7qfGw@mail.gmail.com>
Subject: Re: [PATCH v6 04/15] x86/pvh: Use fixed_percpu_data for early boot GSBASE
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 12:49=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Wed, Mar 5, 2025 at 12:45=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wr=
ote:
> >
> > On March 4, 2025 2:26:20 PM PST, Mateusz Guzik <mjguzik@gmail.com> wrot=
e:
> > >On Thu, Jan 23, 2025 at 02:07:36PM -0500, Brian Gerst wrote:
> > >> Instead of having a private area for the stack canary, use
> > >> fixed_percpu_data for GSBASE like the native kernel.
> > >>
> > >> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > >> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > >> ---
> > >>  arch/x86/platform/pvh/head.S | 15 +++++++++------
> > >>  1 file changed, 9 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/he=
ad.S
> > >> index 4733a5f467b8..fa0072e0ca43 100644
> > >> --- a/arch/x86/platform/pvh/head.S
> > >> +++ b/arch/x86/platform/pvh/head.S
> > >> @@ -173,10 +173,15 @@ SYM_CODE_START(pvh_start_xen)
> > >>  1:
> > >>      UNWIND_HINT_END_OF_STACK
> > >>
> > >> -    /* Set base address in stack canary descriptor. */
> > >> -    mov $MSR_GS_BASE,%ecx
> > >> -    leal canary(%rip), %eax
> > >> -    xor %edx, %edx
> > >> +    /*
> > >> +     * Set up GSBASE.
> > >> +     * Note that, on SMP, the boot cpu uses init data section until
> > >> +     * the per cpu areas are set up.
> > >> +     */
> > >> +    movl $MSR_GS_BASE,%ecx
> > >> +    leaq INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> > >> +    movq %edx, %eax
> > >
> > >       movl
> > >
> > >I'm bisecting perf breakage and landing on this commit breaks the buil=
d.
> >
> > Breaks the build how?
>
>   AS      arch/x86/platform/pvh/head.o
> arch/x86/platform/pvh/head.S: Assembler messages:
> arch/x86/platform/pvh/head.S:183: Error: incorrect register `%eax'
> used with `q' suffix
>
> Per the above, I presume it was meant to be a movl.

Please note that this part is further changed in [PATCH 8/15] [1], so
the breakage is temporary.

[1] https://lore.kernel.org/lkml/20250123190747.745588-9-brgerst@gmail.com/

Uros.

