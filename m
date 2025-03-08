Return-Path: <linux-kernel+bounces-552423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E71C9A579BB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D80189553A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E551B0421;
	Sat,  8 Mar 2025 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAuTpGZt"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DD1758B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741428789; cv=none; b=C+9o5ahxYASBdMT04kc6NBX151hcflG+a+qd/TzqrzW+xmLu3g442eYSodAwQ3uqLqQxi0cIfFUA5dEe0ja4pIttmxoT1mgvTqjPCX7B46KYTAe/oWPmKD5ly6BGzzhSnJKbb1uksgqehp8bJpcF/iATZaP17yOPbP8B4ClSmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741428789; c=relaxed/simple;
	bh=k2MOMlL9ZCuJ7YH0I9Hswg0TOanRtc0RAENqsFnLU0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yn6xF1wKhC+0EG4hZ0WPwl0pNaO9pS3YoKj/Pz5VCelkgb+pf+TyNuaDsr+M3wfPXkNfECXs/T1XwQDj93kt4VJrblAynlYzWt2nfn92yERaJ8x3i/BP40mywX+cPmiSXAP4B0H3VYDbtFBhxL5bXkFVBYE9Pt+dr7yA2o+takI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAuTpGZt; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bd11bfec6so27001951fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 02:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741428786; x=1742033586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIOS1SrqLrAJZJV2y5Le0bs3hgHTkMyfIHXS+LpjmUY=;
        b=TAuTpGZtYMv0tMfrRr0uPoV9kdarpFTHIXIuBb4AJahIYmhm9ofS6RO2dDVCegQp23
         HddODUsq+Nu7nR1jlZtVlqJafF2p9TeEuvCvR8oLPS/QRtWbuaY+5aCSzCcwu87TwBLO
         M8wSePcI5O2Jt57lBaIWgh49ZG3vnvJVT4jy74vHY7zcNqozWHYA62z61DYdp0UVi44/
         lCYxuvuAGPVUhvgF1QezTwMq5k78bi2AWZCprqxxP2Mmwhxk7RXT8DJ6caa9MuppsxvV
         +bZtPZ0g7Ij5kN+aBI9Fdd37C+FN7hqkDwcdtTkygZtzYXo9ONJHU1Nyb07hkeTpboNB
         2O2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741428786; x=1742033586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIOS1SrqLrAJZJV2y5Le0bs3hgHTkMyfIHXS+LpjmUY=;
        b=Ekxd81MTEZiUhNwIcN1zQgUmt2jBCYlKNex4XL5T65qKN16hk6nbsiHAWMblSlpW7n
         1mtRYSgE8ORGSnudJoPAqmFAoiEwFf4uxYKdyklNjwY2tHktvYA9AznzTBQ8IiS1n8yj
         3T1IQtVhiiXoPx4HbX/w6TZDtV5fyNAef6PTtJfyvSUScjI4bHNgHYHUXaIpglR+fx2V
         TCWE1ZObckqysdsid7M1ZqlsSrC/Yc1COADLw15Ri0mxIVwKF1ziNg/0XUbHuzIAeUcM
         gtNDlE/nTSiMecmC/Qlx4KkfJ/h2cZo0N7xNL3uOEqCUMRZICvcQB0run4zB3aNCISVu
         4ZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB1F8DZR7jFF5rDrPXqOsdez+iqLnqEfYuWH9R7USMwjn0WV2daFxAnG5Zd2U4s2KdwTGBBo+KluLmj7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAKYuNpOH8ClcvKSc9q4883qswzaaWKIt8+ytljTC/FS7CUS2
	NmTdhDgDTAaa8khFEsBd9t0Nx1FFGhnSrqiT22c4h32okjxAFSaPc7NCaV9fjWMcXAt0Mme7+b8
	Uo8x4UOkOEOcYH4cqTeMKFASsRYg=
X-Gm-Gg: ASbGnct9SQr8OTGI7uP/ff+zr5i0gpHgHdsPaS5uypmKZi6Lze/OH861aa5sRTDeL37
	rUlUIjiMPCfLWRE12aPw/L5YkQVS90utN5WiVJboxacJqXqEOdWNXsE8H7ADjbLCHLdOflxVkBD
	jK/+K78RMdMc8DjBwrjUum2lW9sQ==
X-Google-Smtp-Source: AGHT+IFT0s8xsaUOuBbfyIDrSuxmQ4P1UliHIpCaO732xo06npLc9nsB77LTc9i42T19++aN/AtNnp9oWSLXk935Lt8=
X-Received: by 2002:a2e:7c03:0:b0:30a:448a:467 with SMTP id
 38308e7fff4ca-30bf452432dmr19654161fa.21.1741428785859; Sat, 08 Mar 2025
 02:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307091022.181136-1-ubizjak@gmail.com> <DC668A65-3173-4A0C-BF78-1CECF60D300B@zytor.com>
 <CAFULd4aMkxYp6L=grE7TrvvfdX7gTGOTAJgojJ=mjHfDLJ=kVQ@mail.gmail.com>
 <E3E112F8-CC41-4933-9FEC-B53D6A0AFA7A@zytor.com> <CAFULd4Z=ZU0z3g3yc6FTBkN38tsgF86ps2P7Dhc+bdF8A416Uw@mail.gmail.com>
 <5147E060-2F35-4B55-ACAA-56D9DB0DD818@zytor.com>
In-Reply-To: <5147E060-2F35-4B55-ACAA-56D9DB0DD818@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 8 Mar 2025 11:12:58 +0100
X-Gm-Features: AQ5f1Jo4x2qMbgxNkIuWUMo1ogyRsYq8EP9r4bKNCt2ai_bJPgrh7ZlXxEDlTNE
Message-ID: <CAFULd4bo15jj76v5y8pZgHmbYwuUMFPRu5iwim0spHF2pGKunA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Do not test if AC and ID eflags are changeable
 on x86_64
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 3:46=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> On March 7, 2025 5:45:42 AM PST, Uros Bizjak <ubizjak@gmail.com> wrote:
> >On Fri, Mar 7, 2025 at 2:13=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wr=
ote:
> >
> >> >> PUSF et al =E2=86=92 pushf
> >> >>
> >> >> The -l and -q suffixes have been optional for a long time.
> >> >
> >> >No, not in this case. Please see the comment:
> >> >
> >> >/*
> >> >* For building the 16-bit code we want to explicitly specify 32-bit
> >> >* push/pop operations, rather than just saying 'pushf' or 'popf' and
> >> >* letting the compiler choose.
> >> >*/
> >> >
> >> >We are building 16-bit code here, and we want PUSHFL, the one with
> >> >operand size prefix 0x66.
> >> >
> >> >Please consider the following code:
> >> >
> >> >    .code16
> >> >    pushf
> >> >    pushfl
> >> >
> >> >as -o push.o push.s
> >> >
> >> >objdump -dr -Mdata16 push.o
> >> >
> >> >0000000000000000 <.text>:
> >> >  0:   9c                      pushf
> >> >  1:   66 9c                   pushfl
> >> >
> >> >Uros.
> >> >
> >>
> >> *plonk* I should have remembered (.code16gcc is different then .code16=
 though.) I wrote the damned things after all...
> >
> >Please note that while "gcc -m16" emits .code16gcc, "clang -m16" emits
> >.code16, so in the latter case we don't have =E2=80=98pushf=E2=80=99, an=
d =E2=80=98popf=E2=80=99
> >instructions default to 32-bit size. So, the only solution is to
> >decorate pushfl with operand size prefix in this specific case.
> >
> >Uros.
> >
>
> Can you please beat up the clang people who do gratuitously incompatible =
things like this?

:)

BTW: This patch is actually the implementation you requested at some
previous discussion [1], but I took the approach similar to the
definition of have_cpuid_p() in cpuid.h [2].

[1] https://lore.kernel.org/lkml/0A743606-067F-450C-85A5-55ECE4378E22@zytor=
.com/#t
[2] https://elixir.bootlin.com/linux/v6.14-rc5/source/arch/x86/include/asm/=
cpuid.h#L32

Uros.

