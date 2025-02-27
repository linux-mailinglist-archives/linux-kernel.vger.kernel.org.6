Return-Path: <linux-kernel+bounces-537301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB1A48A33
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184143AC70D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B60D270EBE;
	Thu, 27 Feb 2025 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yk4QDm37"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63779270ECD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689877; cv=none; b=Krxn6H22QRwBw2KoSsXqEGigGXx/TI0JgGMT9THKX10rTvWTahyuhou2p3kz7RqXEcoZkdlmlbL8zPiRk6i2JKBYm0Rje9Q6A0IJGhr/oC7e1U9As8UQXOOAkjP8twdMg564B6cz2YFRlMKYgHE3PjPHpf7t/dqi15WjT7AxXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689877; c=relaxed/simple;
	bh=gluXi5xULvfSCmFO6bHH+tGO6TqITSnpduH9eMYOsUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsYCfIIO4odwstsoDqnNuBgHuKQyu0x8hPTFU41zYN/t2Rio2I0kyUJQh2a/m7aa6IxkJXkJp9DoSFHUYZUrDnvVfMOJgz+fxxl8hfq4u7epFHO5gNalruuXX978ls+XnI5/0VLAmAecSIXjOS97qM9liIagnqmI20gqZ1U6zro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yk4QDm37; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb81285d33so274750266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740689873; x=1741294673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJveyoIEMTCh14ljLF9QNtY0D/cKkIOCAKuSFjWQyQU=;
        b=Yk4QDm37IoKFV9tJBXLxGIS45Lg0tjq1WB9guLI02AVdR+uU5xWLCz7eZwJ/CR0AIT
         1DBdJi1vijinLVhRSFCjNjMDtJNXAg/UB4/I7LOwEmNmaWB6ANsGGc2YAjTH9CxL0aih
         bkMxJ4Kh3nnYqvJPVByTJy1ysSi562c2hzlwISLhRLxst45GVfodZmGjqwDz1vaM1bhL
         baykfu8kK1S6ucg8/6v2IwBgJMtOnwXilrhbOUJTrKaeFWjkXFm6r8EO7/GAmbwnRzAZ
         vIr5kEQYRwOhTpYEkoM9HMjW9rFSdLmsgkrFECdR4SxmnGxrBSycQvAkZTXM5svLGBDp
         DXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740689873; x=1741294673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJveyoIEMTCh14ljLF9QNtY0D/cKkIOCAKuSFjWQyQU=;
        b=CFz6/UO8EtaYkqBK+HKp9EnQlMLCQDibYVDhQWBr1I/J1pv/q8Jqm3er3tKWKABNOj
         1WDpLfx20UiOUwCaY13jopc2T5Jpy8ovOOvKuPHKVsG9lBAYFvsEeQYTtxdZ26Egtu0P
         J6qzy2VSMoh3Mjn1U6kY4b3jQvx3dL+aV0mqY5WgBVzSCAkYPikKdJiFWVJ72lA67w0T
         7JBSzSdazOiAO846msYif5ByO2BDhwJiChh9aWt53WlkGX0oDvTEWetxtzYs9xtEn5cX
         3158/ePU1KkFgSUhGKcuBbRdOERS3zzoYXfwPHo34TCtvhhbi4+Q+0rBFN0PTpCT8oxR
         Mzuw==
X-Forwarded-Encrypted: i=1; AJvYcCUZFVqsIZWehGZGDgy7h0RiMm2tMPb2UrppKlfV+wbHk+Xz/FLuW/nZ7QCQPAm1dlmiEvKslrmpQt9KUfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBRsrMt2ws7VvnQABWx5bF4oNtPQ0djoUU5qVm0G43zwitJfI
	bOYeN6H4rb98H7L9BZZXBAJNhRT25y+ngUKpJ6XrAKknfuw9h5MGd67wnxsR98vgeDqVQX3Hl4W
	i/4StHoq70XXNwozNYSGOagmvbWQfNfNdQr8=
X-Gm-Gg: ASbGncuwd31T15K++ErQ25FsY2mK2p1X767VEVzP1vU+5+hrsiiotGTO3/pgKv3HuJd
	QriUeA+FZ6g+NXFoj6FwvIQ8caNPUW7yjbjLIcV2CXv8C80JGxJ4DjhpXOFASC2dwLLLpaaruXy
	Lvhrxu
X-Google-Smtp-Source: AGHT+IE9iCZk4QUBD23F1Zo14MgZCt7ts5AldRQifiXQN5G9EbVneoxaBJ6AVE8QPXPRd/nmSnWTsNZQXx3ANeOOKU0=
X-Received: by 2002:a17:906:6a13:b0:abe:c849:7aa7 with SMTP id
 a640c23a62f3a-abf265cee71mr95608566b.41.1740689873533; Thu, 27 Feb 2025
 12:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGG=3QVi27WRYVxmsk9+HLpJw9ZJrpfLjU8G4exuXm-vUA-KqQ@mail.gmail.com>
 <d20da175-2102-4ac0-bf91-0ab8f6b6b317@intel.com>
In-Reply-To: <d20da175-2102-4ac0-bf91-0ab8f6b6b317@intel.com>
From: Bill Wendling <morbo@google.com>
Date: Thu, 27 Feb 2025 12:57:37 -0800
X-Gm-Features: AQ5f1JrXKNJ9dmAYpGPhTl0lhC69TTiwaOh5i19eVrAfWoRfJbsOGd1OSppC628
Message-ID: <CAGG=3QX-msHuRffAtNCBoqYo=15Z--5RXbPbJ=Tzkb+C9zNSaw@mail.gmail.com>
Subject: Re: [PATCH] x86/crc32: use builtins to improve code generation
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Eric Biggers <ebiggers@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 8:26=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
> On 2/26/25 22:12, Bill Wendling wrote:
> >  #ifdef CONFIG_X86_64
> > -#define CRC32_INST "crc32q %1, %q0"
> > +#define CRC32_INST __builtin_ia32_crc32di
> >  #else
> > -#define CRC32_INST "crc32l %1, %0"
> > +#define CRC32_INST __builtin_ia32_crc32si
> >  #endif
> >
> >  /*
> > @@ -78,10 +78,10 @@ u32 crc32c_le_arch(u32 crc, const u8 *p, size_t len=
)
> >
> >         for (num_longs =3D len / sizeof(unsigned long);
> >              num_longs !=3D 0; num_longs--, p +=3D sizeof(unsigned long=
))
> > -               asm(CRC32_INST : "+r" (crc) : "rm" (*(unsigned long *)p=
));
> > +               crc =3D CRC32_INST(crc,  *(unsigned long *)p);
>
> Could we get rid of the macros, please?
>
> unsigned long crc32_ul(unsigned long crc, unsigned long data)
> {
>         if (IS_DEFINED(CONFIG_X86_64))
>                 return __builtin_ia32_crc32di(crc, data)
>         else
>                 return __builtin_ia32_crc32si(crc, data)
> }
>
> I guess it could also do some check like:
>
>         if (sizeof(int) =3D=3D sizeof(long))
>
> instead of CONFIG_X86_64, but the CONFIG_X86_64 will make it more
> obvious when someone comes through to rip out 32-bit support some day.

I vastly prefer the first way if made "static __always_inline".

-bw

