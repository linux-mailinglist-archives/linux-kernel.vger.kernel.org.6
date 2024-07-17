Return-Path: <linux-kernel+bounces-254957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D919339C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C24F283D42
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642793032A;
	Wed, 17 Jul 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2n83LVYC"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B0D9445
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208055; cv=none; b=Bja5OUor6n16bEn+qhypQSX8Olk+IwomVXpVZBkXrYVHOeKdZwJh2i0cGFrN/ZVQphyuS6ieyraV5PFBg1U1eSi8L7NB67mkh+WX6bX5LHVh2eFn8UUrHTHPFM2FW10Z5zfNEVI5A4cnNkxBe+GFLkmndWkJAwrF7JUlBrjBMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208055; c=relaxed/simple;
	bh=ROWFeKDiRJqhr9pvHTAd5iwXLQiJfhRNkWnl6SmGY8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJEFkADRkdOxabuyeVOFC+IK8qpn7WUjhfQYpxIH5DCK94SS5XZh1BT9XWt1+l8aBcL+MNykDZCMSrsWTZE35tTckyYjE4W7E56vm2QTzIJi+HQHM04Uj0K5nYtNkM4heLWuB/wGBW8NQZrtVgQuMx3T0vzFGBiasqnHkOk07Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2n83LVYC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367aa05bf9dso3784728f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721208051; x=1721812851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCHbItlBrNuj7Ki4Eb0wf4SsAFA7F48JiYh8KRmiQ5Y=;
        b=2n83LVYC4ZG797lfjwjRm/IAJPGr9CUQHip1n+QS0fLZeFBvkv0tgKditur4nrxNc0
         AndvKfTDCyi+K/4Hso5aW7pBR8N67JxBfJljRM8N+ahJjoTgCTWjXeQl93q4QWwM/fW/
         HXxxIyquNPfundj8Vq1HAuX4UiDd1gdzSsEWDs+YEFLu5kF/FA8dkUTPEXl2BqcGbXdQ
         QnM1dGK++KtSNzM81h4zi6jhtvixMt65DakQb3Q+WlBgdv8tR3mDjsdNrw4341kjEIan
         8fdnV5HPVNYB9d1QS74ZIzHO1TujzZ2JPyPQBGFm2XFPrFsMFgT8qVsXJXgcM9CQPoLC
         vA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721208051; x=1721812851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCHbItlBrNuj7Ki4Eb0wf4SsAFA7F48JiYh8KRmiQ5Y=;
        b=AwLZVq11MRRUHXDMvqXvQU/Ld017YFRzfjcjq7uTNc7AW1gG6sIWMnecvUVeyrwHdF
         oXd8uH+IEctHYY0iPfNtszTBJXyv6VJw7rkjdnIjtKsC7WX1xBPFDywquismFcRQXwm9
         cbr05QWbQoWkN3AwwZ7pPRahTPE/h6wlZ6npLfR2I7Ba45gsuBnNIliJtyWOvhuZASCf
         G/C9kHjzsJXXwEvG9Z3pVGcsshAOAnnKiP+3tCh9fef4RYURxdC65ug7aO58h/eF0ymI
         /HEpYhrmDcgR5Clu9NP18JAqdNdX5yuEhRSLcV9IVDwJJTJT3LGm1x3adfsAuKQcnpL2
         77Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXToU0NQeMjsgTG2Gi8vXvowJibxnq0e5vmH+tFr3mDxrWW4JKvEwCrNaJrTWPUyCk6xbJ0x3w9rY7K5oqrHCtIkggqTQlZGCgnBsa0
X-Gm-Message-State: AOJu0Yx4p9z3zQeGxK940jV1dHmTztMcHHrXN2ckNEifQG/dl5PxFGKQ
	POM2rKglRdqNRDRjTc2zgbHNFua7EBMfA044PWva5P+YpQ4lhgBQJcyDpWR/isJ2nsua85NgE6v
	c7qJo86YE165K/2Ibo/n8t1Td4T0rxS2DoGVPJg==
X-Google-Smtp-Source: AGHT+IEHX+/mum67Owzn09wNfyB5gYmZx0v+qCYJtFyuTXjLXh2OG3vP9TYsFn7pFzTO+x5Kyz+S/HxF57Fvz2XPCJA=
X-Received: by 2002:a5d:428a:0:b0:363:e0e2:eeff with SMTP id
 ffacd0b85a97d-368315fab1cmr660134f8f.20.1721208051569; Wed, 17 Jul 2024
 02:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_7721F6B72F58AA6154DFBDFF@qq.com> <CAHVXubhkrDv3Fx1KH-jjjWjo-LGKBMabvafAPsDZeSpGMEt-gg@mail.gmail.com>
 <592DAA3973EEA52F+9b62c73a-cc43-498c-8afb-da2d43e56b5c@nucleisys.com>
 <CAHVXubhy6tfAEfTF=fsZ90UDc+_vnWurWpK4xDqciwptzuvg6A@mail.gmail.com> <C3FA50DD88E41384+a8e54b7c-d4ec-45c3-9fea-bedc44a4a6f6@nucleisys.com>
In-Reply-To: <C3FA50DD88E41384+a8e54b7c-d4ec-45c3-9fea-bedc44a4a6f6@nucleisys.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 17 Jul 2024 11:20:40 +0200
Message-ID: <CAHVXubjRMSDuu3b2idnf1Gnt-cxqPeY-x4tSuyZu7z7ROUd7+w@mail.gmail.com>
Subject: Re: [PATCH] riscv: Only flush the mm icache when setting an exec pte
To: guibing <guibing@nucleisys.com>
Cc: aou <aou@eecs.berkeley.edu>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, palmer <palmer@dabbelt.com>, 
	"paul.walmsley" <paul.walmsley@sifive.com>, =?UTF-8?B?5pa55Y2O5ZCv?= <hqfang@nucleisys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guibing,

On Tue, Jul 16, 2024 at 4:31=E2=80=AFPM guibing <guibing@nucleisys.com> wro=
te:
>
> Hi Alex=EF=BC=8C
>
>  From RISC-V Unprivileged ISA Spec=EF=BC=8Cor zifencei.adoc :
>
> FENCE.I does not ensure that other RISC-V harts=E2=80=99 instruction fetc=
hes
> will observe the local hart=E2=80=99s stores in a multiprocessor system.

Which is immediately followed by: "To make a store to instruction
memory visible to all RISC-V harts, the writing hart also has to
execute a data FENCE before requesting that all remote RISC-V harts
execute a FENCE.I.".

Maybe you're just lacking a data fence on core0?


>
> thanks.
>
> =E5=9C=A8 2024/7/16 20:51, Alexandre Ghiti =E5=86=99=E9=81=93:
> > Hi Guibing,
> >
> > First, sorry for the delay, I was out last week.
> >
> > On Wed, Jun 26, 2024 at 5:59=E2=80=AFAM guibing <guibing@nucleisys.com>=
 wrote:
> >> Hi Alex,
> >>
> >> Sorry, yesterday I clicked the mouse by mistake to sent an empty email=
.
> >>
> >>> Is it a multithreaded application? You mean that if the application
> >>> always runs on core1/2/3, you get an illegal instruction, but that
> >>> does not happen when run on core0?
> >> test_printf is not a multithread application, just output "hello world=
"
> >> strings.
> >>
> >> #include <stdio.h>
> >>
> >> int main()
> >> {
> >>           printf("hello world!\n");
> >>           return 0;
> >> }
> >>
> >>   From testing results, illegal instruction always occur on core1/2/3,=
 no
> >> core0.
> >>
> >>> Did you check if the instruction in badaddr is different from the
> >>> expected instruction? The image you provided is not available here,
> >>> but it indicated 0xf486 which corresponds to "c.sdsp  ra, 104(sp)", i=
s
> >>> that correct?
> >> this badaddr is same with the expected instruction, but i meet the
> >> different.
> >>
> >> /mnt # ./test_printf
> >> [   76.393222] test_printf[130]: unhandled signal 4 code 0x1 at
> >> 0x0000000000019c82 in test_printf[10000+68000]
> >> [   76.400427] CPU: 1 PID: 130 Comm: test_printf Not tainted 6.1.15 #6
> >> [   76.406797] Hardware name: asrmicro,xlcpu-evb (DT)
> >> [   76.411665] epc : 0000000000019c82 ra : 000000000001ca36 sp :
> >> 0000003fc5969b00
> >> [   76.418941]  gp : 000000000007e508 tp : 0000003f8faec780 t0 :
> >> 000000000000003d
> >> [   76.426244]  t1 : 0000002abe28cecc t2 : 0000002abe369d63 s0 :
> >> 0000003fc5969d98
> >> [   76.433524]  s1 : 0000000000082ab8 a0 : 0000003fc5969b00 a1 :
> >> 0000000000000000
> >> [   76.440835]  a2 : 00000000000001a0 a3 : 0000000001010101 a4 :
> >> 0101010101010101
> >> [   76.448108]  a5 : 0000003fc5969b00 a6 : 0000000000000040 a7 :
> >> 00000000000000dd
> >> [   76.455432]  s2 : 0000000000000001 s3 : 0000003fc5969d38 s4 :
> >> 0000000000082a70
> >> [   76.462695]  s5 : 0000000000000000 s6 : 0000000000010758 s7 :
> >> 0000002abe371648
> >> [   76.469995]  s8 : 0000000000000000 s9 : 0000000000000000 s10:
> >> 0000002abe371670
> >> [   76.477275]  s11: 0000000000000001 t3 : 0000003f8fb954cc t4 :
> >> 0000000000000000
> >> [   76.484576]  t5 : 00000000000003ff t6 : 0000000000000040
> >> [   76.489948] status: 0000000200004020 badaddr: 00000000ffffffff caus=
e:
> >> 0000000000000002
> >> Illegal instruction
> >>
> >>> No no, we try to introduce icache flushes whenever it is needed for s=
uch uarch.
> >>>
> >> core0 is responsible for reading data from sd cards to dcache and ddr.
> >>
> >> before core1/2/3 continue to execute the application, it only execute
> >> fence.i instruction.
> >>
> >> in our riscv hardware , fence.i just flush dcache and invalidate icach=
e
> >> for local core.
> >>
> >> in this case, how core1/2/3 can get application instruction data from
> >> the core0 dcache ?
> > I don't understand this point ^: you mean that core1/2/3 can't access
> > the data in the core0 dcache? And they go straight to main memory? To
> > me, the cores dcaches should be coherent and then a fence.i on any
> > core would sync the icache with the content of any dcache and that
> > should not happen.
> >
> > To me, the patch is correct, but maybe I did not fully understand your
> > issue. Don't hesitate to give more details.
> >
> > Thanks,
> >
> > Alex
> >
> >> i try to send remote fence.i to core0, iilegal instruction cannot
> >> reproduced, it can work well.
> >>
> >> @@ -66,8 +66,11 @@ void flush_icache_mm(struct mm_struct *mm, bool loc=
al)
> >>                    * messages are sent we still need to order this har=
t's
> >> writes
> >>                    * with flush_icache_deferred().
> >>                    */
> >> +              sbi_remote_fence_i(cpumask_of(0));
> >>                   smp_mb();
> >>           } else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
> >>                   sbi_remote_fence_i(&others);
> >>           } else {
> >>
> >>
> >> thank you for your reply! =EF=BC=9A=EF=BC=89
> >>
> >>
> >> =E5=9C=A8 2024/6/25 19:45, Alexandre Ghiti =E5=86=99=E9=81=93:
> >>> Hi Guibing,
> >>>
> >>> You sent your email in html, so it got rejected by the ML, make sure
> >>> you reply in plain text mode :)
> >>>
> >>> On Tue, Jun 25, 2024 at 10:45=E2=80=AFAM =E6=A1=82=E5=85=B5 <guibing@=
nucleisys.com> wrote:
> >>>> Hi alex=EF=BC=8C
> >>>>
> >>>> We have encountered a problem related to this patch and would like t=
o ask for your advice, thank you in advance!
> >>>>
> >>>> Problem description:
> >>>> When we use the v6.9 kernel, there is an illegal instruction problem=
 when executing a statically linked application on an SD card, and this pro=
blem is not reproduced in v6.6/v6.1 kernel.
> >>>> SD card driver uses PIO mode, and the SD card interrupt is bound to =
core0. If the system schedule the apllication to execute on core1, core2, o=
r core3, it will report an illegal instruction, and if scheduled to execute=
 on core0, it will be executed successfully.
> >>> Is it a multithreaded application? You mean that if the application
> >>> always runs on core1/2/3, you get an illegal instruction, but that
> >>> does not happen when run on core0?
> >>>
> >>>> We track the source code, flush_icache_pte function patch leads to t=
his issue on our riscv hardware.
> >>>> If you merge this patch into the v6.1 kernel, the same problem can b=
e reproduced in v6.1 kernel.
> >>>> If using flush_icache_all() not flush_icache_mm in v6.9 kernel ; thi=
s issue can not be reproduced in v6.9 kernel.
> >>>>
> >>>> +void flush_icache_pte(struct mm_struct *mm, pte_t pte)
> >>>>    {
> >>>>    struct folio *folio =3D page_folio(pte_page(pte));
> >>>>
> >>>>    if (!test_bit(PG_dcache_clean, &folio->flags)) {
> >>>> -=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82flush_icache_all();
> >>>> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82flush_icache_mm(mm, false);
> >>>>    set_bit(PG_dcache_clean, &folio->flags);
> >>>>    }
> >>>>    }
> >>> Did you check if the instruction in badaddr is different from the
> >>> expected instruction? The image you provided is not available here,
> >>> but it indicated 0xf486 which corresponds to "c.sdsp  ra, 104(sp)", i=
s
> >>> that correct?
> >>>
> >>>> Our riscv cpu IP supports multi-core L1 dcache synchronization, but =
does not support multi-core L1 icache synchronization. iCache synchronizati=
on requires software maintenance.
> >>>> Does the RISCV architecture kernel in future have mandatory requirem=
ents for multi-core iCache hardware consistency?
> >>> No no, we try to introduce icache flushes whenever it is needed for s=
uch uarch.
> >>>
> >>>> Thank you for your reply!
> >>>>
> >>>>
> >>>> Link=EF=BC=9A[PATCH] riscv: Only flush the mm icache when setting an=
 exec pte - Alexandre Ghiti (kernel.org)
> >>>>
> >>>> ________________________________
> >>>> =E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84=E4=BC=81=E4=B8=9A=E5=BE=AE=E4=
=BF=A1
> >>>>
> >>>>
> >>> Thanks for the report,
> >>>
> >>> Alex
> >>>
>

