Return-Path: <linux-kernel+bounces-528333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED28A41668
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEEA3B1E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68851CEAB2;
	Mon, 24 Feb 2025 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pab/6lII"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3E71BC3C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740382776; cv=none; b=u7QdbaxENfx7EPfPQFlIwdx4csbyv5tSDtg6ZxvGug/Z0po7AFEqMCjumpjCFioJVS7ZRycF78D3j9zkh3FD3NZ7PxSSTRZ945QjjHZ85Gt62f3OMJP57+bWzlpeuO9MrqiN1a4Zxst3XIbkTIOsyRX9uCdpYWAQ9JbCzNGg2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740382776; c=relaxed/simple;
	bh=h5HmL4ux6ka3aBEH0fnT357JpL0NSonRdagSE/kWD6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHc+qb0vzPAqb8zSbKD9r0iSJ4ShbQSPidHuo4sSaa6c3YWKMcMia5lgBgyu7p6weSGDeFfBv/rTMhBCA0Y9Trm4xmFUCArOjHbgP0kROo5aSgVaq/lp/yXfzN9V0uZGJcDVL6LgqYCY1iYO+XDRac5MGDg0sd5TF01JwU010mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pab/6lII; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso47002241fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740382772; x=1740987572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDC95XXrsQXG7FJZ558W140W31vF1F5itAr9zVKo84Y=;
        b=Pab/6lII1zVMmSNP+KdHUTN1edfLymsI9OjV16kpgComgaNcwmQtMYg+3FEbBrqklC
         mb+wE8pNJHVc30mzNAy2pfyekYFCGCHT7R1urgu2h9ke9ZwmpnH/zTth5rdETTtpkU99
         5Bfq5eaUk/voCUCWkpb2MCVML9TZ75j3tKxzYYFKtP6nVxoT/ZzN5/ZUc8R0/I8OrZQj
         L6rOZR+dPqzrJaLtD+YY/aH5H3RfVGivjoELr/RkVkcV8iujwnq4asvE0I0OQL/xjxPv
         h576FuEfKZORyz4esAIPeIU1qCNXRpLym4JLn77tP+IVLZ3CRm260mnKnKF6Er1tzGHE
         MMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740382772; x=1740987572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDC95XXrsQXG7FJZ558W140W31vF1F5itAr9zVKo84Y=;
        b=KgmHxoDOLW6pOZWyZIv14ZoUjcZJx3eXHevJVPiq0SGcxXM/Guhh2b3gx9ze3qdbed
         v7YRZm1bl/vfMY/VDUzRgQNr3VjfhzfP/2EuLfAe1dmFuqEiKf9fATFqYjQakrppX+jM
         SzC6QeibYuNRHcLjFU6VCLTUYvCmnVcABGi27gE5Fi3jwJhR0aXInE3nLzP3mMPdotgx
         jqLOPqS1ZQh9oQsCkV85c61sZpfvUwqlNwHx3fPj1GWoudT3QNEtXoEL1cYd9uKY/L4L
         nUB1gqRBMAGMWMNJqhIdsROppHTxYWtUC/Q+2Tfg4orcUXWcXbH0VlPZCk4Df9zHm/Jt
         L0KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBEAI49Gl8lnQmJqo6lrRvKpYlpKyOhytqibDTdYVVHyYfAQnBwJbuzFR531IMhuvA4qJAYOdzifSoolo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbURq+Trs190SiF9k+BPbXpqzuMlYJAliCpQoSfkK3ZCN9T1fe
	8AhemShFQXnH9aKCuOC9Kp8EHeolSyYHtfKNeR7D4z9+qwV4xDOJTntA6wb1OunhXzF0LLOAzXg
	p3WZrjsp06uw0hmLKKPg8sKWFodtISy1lP+xfPw==
X-Gm-Gg: ASbGncuFuntOgpNDMwidDIthxz99bvzUiNA9KHGMCybJ+Wv9ZA/dNkswyiuzgqz7nXo
	bLWo1MWU4vu1dbgphF4gEaVO77Wuw3hW5B/YlNsL74c0PaourTYA9duBjHsgFFpP0zAWVRcp9T/
	rEOn5tj3Y=
X-Google-Smtp-Source: AGHT+IGbmFvy7R+Zs+dq7E9bRH4G25KnkTK+0Zys+P2vdYpnWunQVIzfoWzm9Kmjin7MNwQhig696R3wR+9e/+dIm9M=
X-Received: by 2002:a2e:95c4:0:b0:302:175e:5abb with SMTP id
 38308e7fff4ca-30a5b167c85mr28332211fa.3.1740382772217; Sun, 23 Feb 2025
 23:39:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129154920.6773-1-ubizjak@gmail.com> <31e1c7e4-5b24-4e56-9f17-8be9553fb6f9@kernel.org>
 <CAFULd4a4qbMiP3dYXDp0_vPapkoi-i-ApOY5pHfKG1h7=vfbbA@mail.gmail.com> <43c41ab4-1771-4b01-853e-08e1689df7f3@kernel.org>
In-Reply-To: <43c41ab4-1771-4b01-853e-08e1689df7f3@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 24 Feb 2025 08:39:20 +0100
X-Gm-Features: AWEUYZmbkMTZP4BmVrHdGTBrflrjlMAK2lY7kKTlIxA4zcjjUR8W05Qsr5XFirw
Message-ID: <CAFULd4bTYudfNap1trVyjqA0xv5cQQeWxSZ8numv_uHqxz1Afw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/bootflag: Change some static functions to bool
To: Jiri Slaby <jirislaby@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:27=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 24. 02. 25, 8:24, Uros Bizjak wrote:
> > On Mon, Feb 24, 2025 at 8:18=E2=80=AFAM Jiri Slaby <jirislaby@kernel.or=
g> wrote:
> >>
> >> On 29. 01. 25, 16:47, Uros Bizjak wrote:
> >>> The return values of some functions are of boolean type. Change the
> >>> type of these function to bool and adjust their return values.
> >>>
> >>> No functional change intended.
> >>>
> >>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>> Cc: Ingo Molnar <mingo@kernel.org>
> >>> Cc: Borislav Petkov <bp@alien8.de>
> >>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >>> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >>> ---
> >>>    arch/x86/kernel/bootflag.c | 12 ++++++------
> >>>    1 file changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
> >>> index 3fed7ae58b60..4d89a2d80d0f 100644
> >>> --- a/arch/x86/kernel/bootflag.c
> >>> +++ b/arch/x86/kernel/bootflag.c
> >>> @@ -20,7 +20,7 @@
> >>>
> >>>    int sbf_port __initdata =3D -1;       /* set via acpi_boot_init() =
*/
> >>>
> >>> -static int __init parity(u8 v)
> >>> +static bool __init parity(u8 v)
> >>>    {
> >>>        int x =3D 0;
> >>>        int i;
> >>> @@ -30,7 +30,7 @@ static int __init parity(u8 v)
> >>>                v >>=3D 1;
> >>>        }
> >>>
> >>> -     return x;
> >>> +     return !!x;
> >>
> >> This "!!" is unnecessary and only obfuscates the code, right?
> >
> > Not really, this idiom is used in place of (x !=3D 0) to change the typ=
e
> > to the return type of the function in a pedantic way.
>
> Care to explain what exactly it changes?

The internal compiler representation of the following testcase:

_Bool foo (int x) { return x; }

is:

--cut here--
_Bool foo (int x)
{
 _Bool _2;

 <bb 2> [local count: 1073741824]:
 _2 =3D x_1(D) !=3D 0;
 return _2;
}
--cut here--

For me, !!x in the source means that the change of types was
intentional. Surely, the compiler can do it by itself, so at the end
of the day, it is just a matter of personal taste.

FYI, the whole function will soon be removed and replaced with a
generic parity8() function.

Uros.

