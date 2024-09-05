Return-Path: <linux-kernel+bounces-317107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB50796D942
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852A628A0C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D7C19FA99;
	Thu,  5 Sep 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+IFx1Yv"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645591A00C9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540398; cv=none; b=tUKfUI/3ZgVY5+cvpLkXcFI04+LwxHtrhFBoxEtZ6xJLvvvstzgKO9K2R3I3q5hk4lmPDZH0tW/Rskj1UrFzm7Tb+TVG6XciKVo39o+t0quWkS1dQAgxL7+3fx6NAR40W7PfrAnzK529HauHm+/tgyHUM8zCLOJ89pZnCpOPd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540398; c=relaxed/simple;
	bh=tsy3aKztKoMdnRoNlk4OsNhbjbtbnTCAJolm+ReCOX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTnHKF59snJFsmeFLbg8cwx5Ptvu1AbMz3CP7WmSkJcUA42JQVTdAh19Oz892kbFDUmE85mH9j8Ynw2m4D0z0uKj+A/sXvdjkBQOoRhpl9FmRLRL+tYGRINvcsKXf8jBO1uilfLj1aStNrwLkxMI6Hs9ewBkPhtCv2FtPeMdrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+IFx1Yv; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3edb2d908so8830691fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725540394; x=1726145194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGTp8TAmCD1hKDADwdDk6+QN7IQWNfgm+wMD3F/LVm4=;
        b=R+IFx1Yv+8Y700DeJRNdGtfD39bp4iLEylgZmwXoenadn968KrLOWwNqrtJqPdMw1o
         3/9019LYjtiS4x9sOnola88OCjIAwM8ABaHAGhPK4IypOgtgYBrFovpgGG5zRQ+a6Dv5
         +GZNybcbWl8GRX6HVOyWrnAKiAFfB9EjNF1d9UOcKW6/+Q1mfQj2WoKu78SFWZSgI/uw
         G2W7m/7uvuYZojhL+NLF9PPT1yURniZEhiv7DI55Ag1C6utcF+fZT3sTdiVcu3pl6pgY
         LZEjGk3DAwMelDNt1cGj7NM6/n1A/xoGmItwlGqzTsW6UkieZiX18wNgKmyAhXqHcwAO
         /v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725540394; x=1726145194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGTp8TAmCD1hKDADwdDk6+QN7IQWNfgm+wMD3F/LVm4=;
        b=b10JAwqYNP8Zg8G4C3LV0pYckov9Rbi+F3s5Pjy43toxlKsLEOVP7pAVc8c18xiSg1
         74bFFXt0lbuQem84GrPCQ5IcLjGJo0Mn81GRO3P20Jzbmxlpcdc/gZQwQlMa/nOwa0ue
         mtiUZUDVjPEcQGlvI5rBQruPB2cd728YqQzaH0CCeUgPy5cHjOR0r40DICTCfL5IUq4e
         gonnuz6Eg0n0w20yJ/rhH63J4e0ONxXeBg8ZinBjwHNb+6Zc8Mj0hUMWIX9Y5+Siiyuu
         DMQniBANiYmTeL6d3P3u9vn70D88CmmEx9ngM/C/E5WW62lxHj6uhLyqTplWd1O9Sq3P
         /TZA==
X-Forwarded-Encrypted: i=1; AJvYcCW3ZEY+tWe9C0JoIeMKXOBJZRj9lrEOkPAy0J3AiOXIYbg7cYwXZ2/4MBz4VwlTAHQaeZLtMiV5qAK1CNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKqcKyy3rbxkjvqCRFGZcSRxE7ESLD94Rx8x4r4CxAGw1Io6Z
	KrzDnPEej2y+IcMyXbRhK4FVeClZBODfhZTEpvPv0N/IgpBm0XKhiwGLdxfQJs1uBuVIKDa3Xqm
	I/akwpn7bxXzl3O5TW1wCIJr1OiUsWu4yAr4=
X-Google-Smtp-Source: AGHT+IF7bvh0ZDmvjwBjc2Uwx4AItUuySYgh4nJMg336oNf7Ilf34tyu/XPYlcueqzXZVMwnqvs3UBZ6iPTAt0K06A4=
X-Received: by 2002:a2e:b8c4:0:b0:2f4:f255:4fd2 with SMTP id
 38308e7fff4ca-2f64446e111mr80799021fa.39.1725540394225; Thu, 05 Sep 2024
 05:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905065438.802898-1-ubizjak@gmail.com> <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
 <CAFULd4Z4QzS0J_BztD7jDSNwoXM2vF9PWNX5eJBrQZsUbu-gJQ@mail.gmail.com>
 <361bf35ccf308d2fbce14f69f156cb42eef0f095.camel@xry111.site> <CAFULd4ZqD2L=B5YfKjGR4s0mOM-fABb5+83Z5KfmX0YRaxWw-A@mail.gmail.com>
In-Reply-To: <CAFULd4ZqD2L=B5YfKjGR4s0mOM-fABb5+83Z5KfmX0YRaxWw-A@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 5 Sep 2024 14:46:22 +0200
Message-ID: <CAFULd4b9pV2Rpb+X8gTsDdePtcAppmh7jDVcXBQsk39sicRbhw@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:16=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Thu, Sep 5, 2024 at 2:09=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
> >
> > On Thu, 2024-09-05 at 14:02 +0200, Uros Bizjak wrote:
> > > > If the input value is less than 0xff, then "& 0xff" is meaningless,=
 if
> > > > the input value is more than 0xff, this conversion still cannot giv=
e a
> > > > correct result for the caller. So I think for all sizes it is enoug=
h
> > > > to just use "((unsigned long) val)".
> > >
> > > This part is used to force unsigned extension, otherwise the compiler
> > > will use sign-extension of the possibly signed variable.
> >
> > It's not relevant.  For example when size is 2 __pcpu_op_##size("stx")
> > is expanded to stx.h, and stx.h only stores the lower 16 bits of a
> > register into MEM[r21 + ptr], the high bits are ignored anyway.
> >
> > Thus we can just have
> >
> > +#define _percpu_write(size, _pcp, _val)                               =
         \
> > +do {                                                                  =
 \
> > +       if (0) {                                                       =
 \
> > +               typeof(_pcp) pto_tmp__;                                =
 \
> > +               pto_tmp__ =3D (_val);                                  =
   \
> > +               (void)pto_tmp__;                                       =
 \
> > +       }                                                              =
 \
> > +       __asm__ __volatile__(                                          =
 \
> > +               __pcpu_op_##size("stx") "%[val], $r21, %[ptr]   \n"    =
 \
> > +               :                                                      =
 \
> > +               : [val] "r"(_val), [ptr] "r"(&(_pcp))           \
> > +               : "memory");                                           =
 \
> > +} while (0)
>
> Nice, the less code, the better. If it works for loongson target, then
> we don't need this paranoia.
>
> I just played safe and took the approach that x86 took.

Please note that the original code extended the value to a long type.
If the simplified macro works, then the usage of macros will result in
a better assembly code, where zero-extends will be omitted.

Uros.

