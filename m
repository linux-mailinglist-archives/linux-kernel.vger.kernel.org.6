Return-Path: <linux-kernel+bounces-253781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18249326E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0541F2238C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2720A19AA5B;
	Tue, 16 Jul 2024 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TV0uZYw3"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA71E498
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134327; cv=none; b=SddeN6Lk8IVZXX3e1OjR3KQDpaHLsuL0bUj68PFmrfZQdX24uuYauPfyScf3fJel0BYXop4MbG9SZtZeTplZU++AAH03j8YN0BoKqOMdALPf8ybwPY+1HgkBDYj4HXBUUtETcY/E80mscLs2f1jv5BE0hMNAySBx3i3qx0HhXdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134327; c=relaxed/simple;
	bh=e0SWJEUSDBcmCaJlAY3egCuJoWSuhIdBw351j84h4FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgPv42GmRYU9x/1YSACrUEhie4jxMT5bv48ZOgZrYNOzmsbCEBhoU147YPE5Qj7trY0zE93wpWCOXFKYVUO0ycXPXvl3NRySVjiv4wmO6vefZKMhXn4aOC7B690qjn+tP9BDudk9HfyIAtG8terGwuLJQyu0Pxd6EiNM7rnbYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TV0uZYw3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77c7d3e8bcso682300066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721134323; x=1721739123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7+w9bkd9D4WYRxHawDQydf2cet0vU3fFZo/w1oAbIQ=;
        b=TV0uZYw3LPHL0cp4gfIV3kapWK9IZmCHfVqKWq0stCot3TXyh4g+PM2i7bHpH2bqcZ
         v5i6Gxd1eEVy31b4ItRORD4WZQITdsMOuR3mEqowWqrXXWaJ5YUsinXeixr0XeEEUw6y
         tlBC5KxtL3KSAtn46zBCKeiMW9CJG28m2N0oXB8eZi5g+g27gmYLPpc3psOSN50PGqaj
         Nlc5TO0pyibgebdyjJXuIPZ1a+h3zwcJZv6IjvC3omLtKr+cNDhnwloR37gm+6Es+zMY
         YcZmaTO5yCeTYEJDfMwqycqtm7DKh4wcDiBi2K6nPd880TTPLBPHObsl9tv+GUrPoyDZ
         Gbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721134323; x=1721739123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7+w9bkd9D4WYRxHawDQydf2cet0vU3fFZo/w1oAbIQ=;
        b=bOY6JBkLZBforq9j3SYi1QMfYMFy5nEbtq42Ric2YsC7eKEhVQy7B13IQp66wnVoNl
         QA5nHKiAQwulQ9qjRPSzfVjVOr7CHNsDWgCIH2PNau4Fg1F5yN/wBBQpz62xGYGzy1za
         4NlJlhZ7Z3dt8OJ6Uw1aO2famktw3effCKFGJhp395TVmdTq17n4veC7aoKptRefJox9
         4VeIsNkWuTOzg3yBldWd66MCWr4/lobdk+d9sIprwmmcxzK20DykuUQ1lyEBhjeOc/Hf
         +ZhTxzYjSBbt0PcqR6iIoXiXgqmNntrj0loFOtYx7G2fp7dsaGwV8frZGRLbXv/i2X1O
         sE/g==
X-Forwarded-Encrypted: i=1; AJvYcCVmBl9l4swMQaR3FHOuQnuoSBmeBJ95rijkRZPvwzxf0KixIufB02p5h1SfiI5oMUyrPRgTeHOtSx9ej5500UWwcSGXsPp7HxI8t9M7
X-Gm-Message-State: AOJu0Yw4tCJJWqN0EFMAMdSo3q+nL0xZPeKyUlZsNkHgXJqVqm9JKb3m
	/LrtEFJtV91DjKE8HRjaIJCqbN52o7gVQ+4JbEZhrfUwNPDOkq4qduCVDQctQAj84v9Nv2OTFVu
	GopvaVsoIaxwAfh29l9Q7J9SWEIyfjBzxbFriQg==
X-Google-Smtp-Source: AGHT+IFHI+LpY3Rjtw+Wap1S6YbeGwamwJAp37Zyis//DADUxLGXkDzAfNSjbEYioCualL3c5SOYYwCCDInqEYp4Iwc=
X-Received: by 2002:a17:906:6447:b0:a77:c84b:5a60 with SMTP id
 a640c23a62f3a-a79ea42c99emr151830166b.26.1721134322940; Tue, 16 Jul 2024
 05:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_7721F6B72F58AA6154DFBDFF@qq.com> <CAHVXubhkrDv3Fx1KH-jjjWjo-LGKBMabvafAPsDZeSpGMEt-gg@mail.gmail.com>
 <592DAA3973EEA52F+9b62c73a-cc43-498c-8afb-da2d43e56b5c@nucleisys.com>
In-Reply-To: <592DAA3973EEA52F+9b62c73a-cc43-498c-8afb-da2d43e56b5c@nucleisys.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 16 Jul 2024 14:51:51 +0200
Message-ID: <CAHVXubhy6tfAEfTF=fsZ90UDc+_vnWurWpK4xDqciwptzuvg6A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Only flush the mm icache when setting an exec pte
To: guibing <guibing@nucleisys.com>
Cc: aou <aou@eecs.berkeley.edu>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, palmer <palmer@dabbelt.com>, 
	"paul.walmsley" <paul.walmsley@sifive.com>, =?UTF-8?B?5pa55Y2O5ZCv?= <hqfang@nucleisys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guibing,

First, sorry for the delay, I was out last week.

On Wed, Jun 26, 2024 at 5:59=E2=80=AFAM guibing <guibing@nucleisys.com> wro=
te:
>
> Hi Alex,
>
> Sorry, yesterday I clicked the mouse by mistake to sent an empty email.
>
> > Is it a multithreaded application? You mean that if the application
> > always runs on core1/2/3, you get an illegal instruction, but that
> > does not happen when run on core0?
> test_printf is not a multithread application, just output "hello world"
> strings.
>
> #include <stdio.h>
>
> int main()
> {
>          printf("hello world!\n");
>          return 0;
> }
>
>  From testing results, illegal instruction always occur on core1/2/3, no
> core0.
>
> > Did you check if the instruction in badaddr is different from the
> > expected instruction? The image you provided is not available here,
> > but it indicated 0xf486 which corresponds to "c.sdsp  ra, 104(sp)", is
> > that correct?
> this badaddr is same with the expected instruction, but i meet the
> different.
>
> /mnt # ./test_printf
> [   76.393222] test_printf[130]: unhandled signal 4 code 0x1 at
> 0x0000000000019c82 in test_printf[10000+68000]
> [   76.400427] CPU: 1 PID: 130 Comm: test_printf Not tainted 6.1.15 #6
> [   76.406797] Hardware name: asrmicro,xlcpu-evb (DT)
> [   76.411665] epc : 0000000000019c82 ra : 000000000001ca36 sp :
> 0000003fc5969b00
> [   76.418941]  gp : 000000000007e508 tp : 0000003f8faec780 t0 :
> 000000000000003d
> [   76.426244]  t1 : 0000002abe28cecc t2 : 0000002abe369d63 s0 :
> 0000003fc5969d98
> [   76.433524]  s1 : 0000000000082ab8 a0 : 0000003fc5969b00 a1 :
> 0000000000000000
> [   76.440835]  a2 : 00000000000001a0 a3 : 0000000001010101 a4 :
> 0101010101010101
> [   76.448108]  a5 : 0000003fc5969b00 a6 : 0000000000000040 a7 :
> 00000000000000dd
> [   76.455432]  s2 : 0000000000000001 s3 : 0000003fc5969d38 s4 :
> 0000000000082a70
> [   76.462695]  s5 : 0000000000000000 s6 : 0000000000010758 s7 :
> 0000002abe371648
> [   76.469995]  s8 : 0000000000000000 s9 : 0000000000000000 s10:
> 0000002abe371670
> [   76.477275]  s11: 0000000000000001 t3 : 0000003f8fb954cc t4 :
> 0000000000000000
> [   76.484576]  t5 : 00000000000003ff t6 : 0000000000000040
> [   76.489948] status: 0000000200004020 badaddr: 00000000ffffffff cause:
> 0000000000000002
> Illegal instruction
>
> > No no, we try to introduce icache flushes whenever it is needed for suc=
h uarch.
> >
> core0 is responsible for reading data from sd cards to dcache and ddr.
>
> before core1/2/3 continue to execute the application, it only execute
> fence.i instruction.
>
> in our riscv hardware , fence.i just flush dcache and invalidate icache
> for local core.
>
> in this case, how core1/2/3 can get application instruction data from
> the core0 dcache ?

I don't understand this point ^: you mean that core1/2/3 can't access
the data in the core0 dcache? And they go straight to main memory? To
me, the cores dcaches should be coherent and then a fence.i on any
core would sync the icache with the content of any dcache and that
should not happen.

To me, the patch is correct, but maybe I did not fully understand your
issue. Don't hesitate to give more details.

Thanks,

Alex

>
> i try to send remote fence.i to core0, iilegal instruction cannot
> reproduced, it can work well.
>
> @@ -66,8 +66,11 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>                   * messages are sent we still need to order this hart's
> writes
>                   * with flush_icache_deferred().
>                   */
> +              sbi_remote_fence_i(cpumask_of(0));
>                  smp_mb();
>          } else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
>                  sbi_remote_fence_i(&others);
>          } else {
>
>
> thank you for your reply! =EF=BC=9A=EF=BC=89
>
>
> =E5=9C=A8 2024/6/25 19:45, Alexandre Ghiti =E5=86=99=E9=81=93:
> > Hi Guibing,
> >
> > You sent your email in html, so it got rejected by the ML, make sure
> > you reply in plain text mode :)
> >
> > On Tue, Jun 25, 2024 at 10:45=E2=80=AFAM =E6=A1=82=E5=85=B5 <guibing@nu=
cleisys.com> wrote:
> >> Hi alex=EF=BC=8C
> >>
> >> We have encountered a problem related to this patch and would like to =
ask for your advice, thank you in advance!
> >>
> >> Problem description:
> >> When we use the v6.9 kernel, there is an illegal instruction problem w=
hen executing a statically linked application on an SD card, and this probl=
em is not reproduced in v6.6/v6.1 kernel.
> >> SD card driver uses PIO mode, and the SD card interrupt is bound to co=
re0. If the system schedule the apllication to execute on core1, core2, or =
core3, it will report an illegal instruction, and if scheduled to execute o=
n core0, it will be executed successfully.
> > Is it a multithreaded application? You mean that if the application
> > always runs on core1/2/3, you get an illegal instruction, but that
> > does not happen when run on core0?
> >
> >> We track the source code, flush_icache_pte function patch leads to thi=
s issue on our riscv hardware.
> >> If you merge this patch into the v6.1 kernel, the same problem can be =
reproduced in v6.1 kernel.
> >> If using flush_icache_all() not flush_icache_mm in v6.9 kernel ; this =
issue can not be reproduced in v6.9 kernel.
> >>
> >> +void flush_icache_pte(struct mm_struct *mm, pte_t pte)
> >>   {
> >>   struct folio *folio =3D page_folio(pte_page(pte));
> >>
> >>   if (!test_bit(PG_dcache_clean, &folio->flags)) {
> >> -=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82flush_icache_all();
> >> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82flush_icache_mm(mm, false);
> >>   set_bit(PG_dcache_clean, &folio->flags);
> >>   }
> >>   }
> > Did you check if the instruction in badaddr is different from the
> > expected instruction? The image you provided is not available here,
> > but it indicated 0xf486 which corresponds to "c.sdsp  ra, 104(sp)", is
> > that correct?
> >
> >>
> >> Our riscv cpu IP supports multi-core L1 dcache synchronization, but do=
es not support multi-core L1 icache synchronization. iCache synchronization=
 requires software maintenance.
> >> Does the RISCV architecture kernel in future have mandatory requiremen=
ts for multi-core iCache hardware consistency?
> > No no, we try to introduce icache flushes whenever it is needed for suc=
h uarch.
> >
> >> Thank you for your reply!
> >>
> >>
> >> Link=EF=BC=9A[PATCH] riscv: Only flush the mm icache when setting an e=
xec pte - Alexandre Ghiti (kernel.org)
> >>
> >> ________________________________
> >> =E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84=E4=BC=81=E4=B8=9A=E5=BE=AE=E4=BF=
=A1
> >>
> >>
> > Thanks for the report,
> >
> > Alex
> >
>

