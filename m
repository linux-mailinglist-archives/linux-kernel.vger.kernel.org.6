Return-Path: <linux-kernel+bounces-252561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43980931539
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19B71F21BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B2A18E771;
	Mon, 15 Jul 2024 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QexLbJ93"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19C18732C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048208; cv=none; b=sDyi/Qmtwy7CozB4GtxJEpa6Yhe1e3WrU86x6aeMaxpNZGgCMCMsqAEQLLjlPOmvb4ADtPKlE4dVAuNSUI+JYMm8QHRLB7CP9n5B9ITVORBmyW4p29A2NseBuhikySvufhBm9aA8e9pMG8PPr77+eThPZQ57ggpqWizuftUbQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048208; c=relaxed/simple;
	bh=FXxvxDNMjpNVzwzqZhWBa1tOHGY8zYU9VrOR2o556sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGK0uuxUdm0KuMS2xlz+ZrFtFniiTqQj9p/jwXJXgzBH7RObYkcfIneP8/LCgyKi7tpNp6+cCNQpesL2Qd4wtWVD1owfAjFuHeWoQI2PQUX+/+MBoqGnqRRQfpcYfP6BvjsO0rl+NB/FnbzIJHp+UxF7P5NA0bwq6yEUETlC7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QexLbJ93; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77c7d3e8bcso538552766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721048205; x=1721653005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxfNNMp1rG3SXkek7cMYvB8iok7DNluaUVkXIU0Xf14=;
        b=QexLbJ93JEyxZvu628I2UWvMqo8uXieaqS/fpZhsOWLWPD7aNNjLthPyQ+49lhkSOc
         qBjx9AIiFwKY/lNLixLAfIQz2hzT5G7i6k5CwSz9v7RP7JSMJ9+s20TdV0yoeKMbvnZT
         WOLcvr9D9LEDKan+HDj9esjlMQw+nFMmFFev9OreNwxHm1MiohItvszOBqAuUqUKDwD7
         dea37r/x4Z3bbgHq3VXaYPO7JatHogAuW+EY01pM2U9RW4x5BtaP25v8zs105zzVVCC1
         a/pXz1USpbpACQ4j4UzbXoybrK7WwMrDj2A7pqPyeZ4DBneAcs+eknHi0Vrj2wyeivK3
         4sDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048205; x=1721653005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxfNNMp1rG3SXkek7cMYvB8iok7DNluaUVkXIU0Xf14=;
        b=BzI+P7up3LoChTsxr46fF8yW6YYqKtjym0Xj0Yy5e3iL5FLnE55oprehlOsgKlIyAu
         gq0Gy4U+erhAAfE6pahd8fZx5x3CT8O7rGwNTD9XoiL8JVWsDKwFrkf/th/YZX1RjDBa
         oRelvF18LJ/nD5kWjI551Ryy5eymUPDCMo1jUI/791W+1xSoTnyfbyYktpih0PeA1Vu2
         36HCR8lxi9qVa/Zt5ZjD0iE22XkrtaAJf+xnEjQqjmvPHmwnFtBuemYheauQoXc27JKQ
         PuHQpa0Ti/AmfIeK0DuyvudGXQvxzSs6Y322oneFERrqaPHccQeqDrfueHymSW71jiQp
         ad/g==
X-Forwarded-Encrypted: i=1; AJvYcCU4/gFntfPzA1TX7WRoKtr1o0z3RjxCCnqekTB3tDDGizEqCqDFRhEZVs1tvS4ws5CAmmFKnNdUMLj9PE1tAHwoRIBIncf48IDX8Jpu
X-Gm-Message-State: AOJu0YwUZaj4cL+N3x1HwT7OMquLVrSfNGEypYopkxDjWHrNbxyJDBQL
	7ZE/QEv1FTSRQLPDvyst1kiz/KNIBgeVX7fyXhTg7dpi+2tWkfZ9A1YJECkIgIpsdDRXbw4qmep
	IGNlxrZDZvNdWqYfg0U/AdxMZXmu9HAbd3Nk05A==
X-Google-Smtp-Source: AGHT+IEQxCwmk3v9bZId3rguAE4ZhEMOX7OQcvnvy46JJ2wjs4mq+MuCAlAfeu4173n5ppDi6qdRzxNLjJYPZQTWSyo=
X-Received: by 2002:a17:906:fa08:b0:a72:b811:4d43 with SMTP id
 a640c23a62f3a-a780b883462mr1101581166b.59.1721048205077; Mon, 15 Jul 2024
 05:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-4-alexghiti@rivosinc.com> <Zn1StcN3H0r/eHjh@andrea>
 <1cd452af-58cd-468c-9bb6-90f67711d0b0@ghiti.fr> <Zo3NBHUEMMec/6uD@andrea>
In-Reply-To: <Zo3NBHUEMMec/6uD@andrea>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 15 Jul 2024 14:56:34 +0200
Message-ID: <CAHVXubjCdse-3z3hKR81VpdvjxVaxPUZdmTwc4fvHordcfHVng@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] riscv: Implement cmpxchg8/16() using Zabha
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Wed, Jul 10, 2024 at 1:51=E2=80=AFAM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> > > I admit that I found this all quite difficult to read; IIUC, this is
> > > missing an IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) check.
> >
> > I'm not sure we need the zacas check here, since we could use a toolcha=
in
> > that supports zabha but not zacas, run this on a zabha/zacas platform a=
nd it
> > would work.
>
> One specific set-up I was concerned about is as follows:
>
>   1) hardware implements both zabha and zacas
>   2) toolchain supports both zabha and zacas
>   3) CONFIG_RISCV_ISA_ZABHA=3Dy and CONFIG_RISCV_ISA_ZACAS=3Dn
>
> Since CONFIG_RISCV_ISA_ZABHA=3Dy, the first asm goto will get executed
> and, since the hardware implements zacas, that will result in a nop.
> Then the second asm goto will get executed and, since the hardware
> implements zabha, it will result in the j zabha.  In conclusion, the
> amocas instruction following the zabha: label will get executed, thus
> violating (the semantics of) CONFIG_RISCV_ISA_ZACAS=3Dn.  IIUC, the diff
> I've posted previously in this thread shared a similar limitation/bug.

So you mean that when disabling Zacas, we should actually disable
*all* the CAS instructions, even the Zabha ones. It makes sense and
allows for a single way to disable the CAS instructions but keeping
the other atomic operations.

I'll fix that and add a comment.

Thanks,

Alex

>
>   Andrea

