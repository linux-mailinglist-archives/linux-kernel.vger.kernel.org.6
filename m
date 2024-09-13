Return-Path: <linux-kernel+bounces-328556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3359785BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304831F25D64
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43876F17;
	Fri, 13 Sep 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lIKr8Ay"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644157CBB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244854; cv=none; b=OJK4nyI0akhh/VssRjR9v971mjwOv+zYPW/65/8mabI/QXT3UE/OmmpBV+FtqCpw6CG9P0QPxQ2TCDc6Dgyd2DYnbzkgtp49ZJG7cSoXKH6FECBD6bkZAPZ9TS0xqsNU1hRUdWj37eY3es7UzzzzygaTE6XWcdJLvp3Fi0Ui7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244854; c=relaxed/simple;
	bh=8h5Rfxoes1F/EQEOg2e1jm/KAtjsu5tZuD6b6E74r4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6e+y8JJva82t4hLUufvbOq06by77jQMkcLSr7amBT5S+MQzPeLYfLamOGrkHkSXz2zfliYFKV2xsfAuMooHiRTrLjtnJ8djv8ZNYkWz6vkveES2B2WZrnS5ednfQsA/MfEXT0mphVr5zo4WROeKWWONFO0O0is+CCL/oX7aueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1lIKr8Ay; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4582a5b495cso234251cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726244850; x=1726849650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kaogzt0x83O50oW2Cdc8KsfEPIv2RHrKFooPdPcHuF0=;
        b=1lIKr8AyxHNKFxB554AF19Kd7F/bHOqYVm/pVuG+G0WrUVcZuqqCzq9KxHJfXdWqJp
         cGNvgw8gg25neqbex5UV34ycxw1WLIcmE6GfKsnv0iABDTaZBAjHKGYHm91kfSq6Eh55
         YEzW2DX2WJFTqNPrAZ480SCCFDriNj/8NguAiPbhHB/UxKW5c5DLJoGjSJ49iePULnCZ
         rCvAVpz27l0IM/ee0+s18oZWcS4T/YHEztinmwZB88EVUQ0YlRsM2VeLhmUWaMx9LL1o
         R1mntdJCnidd2wxb5fhh292QM9LqPd/tbqce61hgmOflFDg0564WrCKQr0DryT1hzS72
         a5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726244850; x=1726849650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kaogzt0x83O50oW2Cdc8KsfEPIv2RHrKFooPdPcHuF0=;
        b=rbhL9QcnF4ht01tl7v5FxQ9dWwfo0O+aqKUHuo0f1oNBpENk6kvX+0np9ITvgHkmka
         xlQJa4yPq3TbkjQVpiO2Eh23GMF02YR9FdW48cR7J4IeGWqCDjHfc5knggU7bzi/MXYK
         sM+TMryh3lgzXFMmP9htN9hD37hR58Ek2DHDbqehqi1EPkujnCbteHUSSOwcmK5bygoR
         fgtqAtRiYu1J0yxGmA9mpPo77Wuz9PxdGbT3LR19ez6QHrAkxEvo/dGbPVjaVnG26Ssy
         RUyct+qav1UZ8nJlJYOGYc5YGZtuU4/sFalVDsGc6ontPFlu5//Xlqf3kxzRrmRONFtC
         0aFA==
X-Forwarded-Encrypted: i=1; AJvYcCVwmnsnqN0oW5CuOb28ctUl/rx7Xmw+Iltqk16qnZNq+Vc8MrkeR9QXQzKtZ7qxJsa+qQ6k+pS0xEbEDKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvTQyLmrVb5VKJV+uG5/PoVfQ5SsmvO0tymqt27T9i1bsEc3B9
	WnYdEFBUkakuAlpT68W84oy8Bnz61L/wkLqefWjUgK4WjazOS0/avnKkz2GRtgwB0J8fUWlVPSg
	NVeKj+/P5yIJqU6XufeuJNKrVA0/j4/f3f6p5
X-Google-Smtp-Source: AGHT+IFLIVO3GAQiV32AIRq5tRq8/+Y6XmNS4xK792rwOjota6Ua04VI9PjqMQ/wHusA5aDseJUdCQZv6B0+BHgZ16k=
X-Received: by 2002:a05:622a:4cc:b0:456:796b:2fe5 with SMTP id
 d75a77b69052e-45864512051mr7158501cf.9.1726244849858; Fri, 13 Sep 2024
 09:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913125302.0a06b4c7@canb.auug.org.au> <20240912200543.2d5ff757@kernel.org>
 <20240913204138.7cdb762c@canb.auug.org.au> <20240913083426.30aff7f4@kernel.org>
 <20240913084938.71ade4d5@kernel.org> <913e2fbd-d318-4c9b-aed2-4d333a1d5cf0@cs-soprasteria.com>
In-Reply-To: <913e2fbd-d318-4c9b-aed2-4d333a1d5cf0@cs-soprasteria.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Sep 2024 09:27:17 -0700
Message-ID: <CAHS8izPf29T51QB4u46NJRc=C77vVDbR1nXekJ5-ysJJg8fK8g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To: christophe.leroy2@cs-soprasteria.com
Cc: Jakub Kicinski <kuba@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 9:13=E2=80=AFAM LEROY Christophe
<christophe.leroy2@cs-soprasteria.com> wrote:
>
>
>
> Le 13/09/2024 =C3=A0 17:49, Jakub Kicinski a =C3=A9crit :
> > On Fri, 13 Sep 2024 08:34:26 -0700 Jakub Kicinski wrote:
> >>> The second "asm" above (CONFIG_PPC_KERNEL_PREFIXED is not set).  I am
> >>> guessing by searching for "39" in net/core/page_pool.s
> >>>
> >>> This is maybe called from page_pool_unref_netmem()
> >>
> >> Thanks! The compiler version helped, I can repro with GCC 14.
> >>
> >> It's something special about compound page handling on powerpc64,
> >> AFAICT. I'm guessing that the assembler is mad that we're doing
> >> an unaligned read:
> >>
> >>     3300         ld 8,39(8)       # MEM[(const struct atomic64_t *)_29=
].counter, t
> >>
> >> which does indeed look unaligned to a naked eye. If I replace
> >> virt_to_head_page() with virt_to_page() on line 867 in net/core/page_p=
ool.c
> >> I get:
> >>
> >>     2982         ld 8,40(10)      # MEM[(const struct atomic64_t *)_94=
].counter, t
> >>
> >> and that's what we'd expect. It's reading pp_ref_count which is at
> >> offset 40 in struct net_iov. I'll try to take a closer look at
> >> the compound page handling, with powerpc assembly book in hand,
> >> but perhaps this rings a bell for someone?
> >
> > Oh, okay, I think I understand now. My lack of MM knowledge showing.
> > So if it's a compound head we do:
> >
> > static inline unsigned long _compound_head(const struct page *page)
> > {
> >          unsigned long head =3D READ_ONCE(page->compound_head);
> >
> >          if (unlikely(head & 1))
> >                  return head - 1;
> >          return (unsigned long)page_fixed_fake_head(page);
> > }
> >
> > Presumably page->compound_head stores the pointer to the head page.
> > I'm guessing the compiler is "smart" and decides "why should I do
> > ld (page - 1) + 40, when I can do ld page + 39 :|
> >
> > I think it's a compiler bug...
> >
>
> Would it work if you replace it with following ?
>
>         return head & ~1;
>

I was able to reproduce with the correct compiler version, and yes,
this fixes the build for me. Thanks!

Probably healthy to add UL, yes?

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5769fe6e4950..ea4005d2d1a9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -239,8 +239,8 @@ static inline unsigned long _compound_head(const
struct page *page)
 {
        unsigned long head =3D READ_ONCE(page->compound_head);

-       if (unlikely(head & 1))
-               return head - 1;
+       if (unlikely(head & 1UL))
+               return head & ~1UL;
        return (unsigned long)page_fixed_fake_head(page);
 }

Other than that I think this is a correct fix. Jakub, what to do here.
Do I send this fix to the mm tree or to net-next?

--=20
Thanks,
Mina

