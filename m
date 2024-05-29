Return-Path: <linux-kernel+bounces-194118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BEB8D36D8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FE81F22CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE28EF9EC;
	Wed, 29 May 2024 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O4vT9H1X"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E504D52E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987372; cv=none; b=Yqvhig5qT/yNKrAlP6ww04MtbueohoGV7wYxSU/fC4r4wWrMS1l9iroqSXZfdfiyi2A1csTtHJY0LNFuOv7UdPs+am+PJI422RBx6tGcZRdjbhPW6JgDc9Mylyp8JsC7mS7yotCbk6CiytolPCT6vRSycAsrSvaIrj5d8kg62Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987372; c=relaxed/simple;
	bh=ZswRo9CCBUa07cVg9bCL+lMt2x/W4xXLb1fAdy1GxqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufpJb6wT14QRekWmfODrPCZJEhDeK+sXA/Z8bbckABGYYR0AQfFsdEWROBcpBXfqzZwPWKfrBl/tjc23Zi7GxhusyUcUwidtDrqbVcv0qXqoUea2kdeMJvOZ0I3QDBmYFglgzBC3Rnr3d9K/sCfrkxUtWFMIXRizsI4AkwDzOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O4vT9H1X; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6266ffdba8so201320066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716987369; x=1717592169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=km2JkQ5ctJj0MJYq+rdmwY806xDsfrDcZz255+ragDo=;
        b=O4vT9H1X/9QI2rjcgwoD/Ne6NQsG1Oo2fFf0jKWAkvIKmZulIPQBz4avzgaBeuKqdy
         phM0/nCcytGu7PbvxIhTwCvs55Z0cd/ym7m/1LCtFxwDHrW5HBqdvBFmyiPtFnRC7BfG
         gj9hg0ao5IyEET7jRl2FWhKDqpmwMafmHE7phc6kY++NEmMgiQd0he/w/o1VOYPJDw2T
         saGvytSH4ygLQJib8l0/rcP0dbWCjwLJcSWxCFfoH81jpYe7eYZ4hAQxcHfach1Mku27
         nMjdDFJY1hIrWxC0HXOJyPXkUPwxRs3kuuJGUl8foOpZK1ovmWN+qsg11SjulH+6XB2W
         F/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716987369; x=1717592169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=km2JkQ5ctJj0MJYq+rdmwY806xDsfrDcZz255+ragDo=;
        b=VH9giip5XjMxzSWr6s/EAqI4BUs1lUeUljG8b1rh/jUwedIzteOlTstlZUYcM17x1S
         LTvOLZvbBTNEqirh5hRI5wuTcZkgF/y7EbsOFDF2PcKUKP5ukpAfz5GuausyzGeXO0Ke
         DdlpFZReyviZp2dw/EDJGXsALW6SDJcckKU2ZOo0c6TLqa70SnlqLXdmkm8fTA4dMgmQ
         G6dUUD+wNfSwRZZZXTC8trOAw2UaZJrKgblVSX8rFVUaewVIvnYKEJfFtXdyVpgpX5Ha
         azIZKy1MMvRgvYKUShny+LRREJD0Ogq0Wb8tPkTsu/eaCqrTrJDctg8xUtRJN2p0/iAA
         rUog==
X-Forwarded-Encrypted: i=1; AJvYcCWmecaDRpq34LMMe2bR5vpK3oZDyokvyqL36gjMY2Cn1O49rbjs4153lKp+5NWA9EEjYDF+OgIuBJPMYtcIl8vtLn5uib/FsJrj0SG0
X-Gm-Message-State: AOJu0Yw+aCWyA4sff8nYH+J0agO/dNTsiaoWvDqyIDy8OVqt8itbF9WG
	d/ZypIiFs3cwQVwQZHDHb2BhVQ83eOJYxlz5/Sn0WUnkKBSr+IuXMMk2thvaCyW4T/FXF32QY1r
	hSP1cm0kFK/L5REhFWxmoAhUbNMiK6zUz1BQF7g==
X-Google-Smtp-Source: AGHT+IH0vOZfyMkMWjnkaaZK40pKjAqSY52a2HgHvxw27fqLFne63Zuz6Oyl4uIA4uXNRiyl5WY3rMhK7Cfm5L00l5U=
X-Received: by 2002:a17:907:25ca:b0:a59:c833:d272 with SMTP id
 a640c23a62f3a-a626417a32amr1191230666b.13.1716987368948; Wed, 29 May 2024
 05:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-3-alexghiti@rivosinc.com> <ZlZurXUUUfXHZJaX@andrea> <CAHVXubj1RpN80f0vNQwFtaNKORnw2F3yzA1_0txa3A+9-usdFw@mail.gmail.com>
In-Reply-To: <CAHVXubj1RpN80f0vNQwFtaNKORnw2F3yzA1_0txa3A+9-usdFw@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 29 May 2024 14:55:58 +0200
Message-ID: <CAHVXubgGQ1whBsAVbfZryqxzTu+uNaUQoAs_AUhM2ofN9h9BDA@mail.gmail.com>
Subject: Re: [PATCH 2/7] riscv: Implement cmpxchg8/16() using Zabha
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:29=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
com> wrote:
>
> On Wed, May 29, 2024 at 1:54=E2=80=AFAM Andrea Parri <parri.andrea@gmail.=
com> wrote:
> >
> > > +zabha:                                                              =
         \
> > > +     __asm__ __volatile__ (                                         =
 \
> > > +             prepend                                                =
 \
> > > +             "       amocas" cas_sfx " %0, %z2, %1\n"               =
 \
> > > +             append                                                 =
 \
> > > +             : "+&r" (r), "+A" (*(p))                               =
 \
> > > +             : "rJ" (n)                                             =
 \
> > > +             : "memory");                                           =
 \
> >
> > Couldn't a platform have Zabha but not have Zacas?  I don't see how thi=
s
> > asm goto could work in such case, what am I missing?
>
> Zabha amocas.[b|h] instructions are only implemented if Zacas is
> present, as the specification states: "If Zacas [2] extension is also
> implemented, Zabha further provides the AMOCAS.[B|H] instructions."
>
> But the code you mention is only for 8 and 16bit operations, so I
> think we are good anyway?

And I was wrong like Andrea noted privately. So I'll fix that too, thanks!

>
> Thanks,
>
> Alex
>
> >
> >   Andrea

