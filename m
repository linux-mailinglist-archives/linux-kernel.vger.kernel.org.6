Return-Path: <linux-kernel+bounces-564879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548EA65C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326F019A13EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B21D61A4;
	Mon, 17 Mar 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DrKnPnNw"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A411CAA92
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235290; cv=none; b=jpFpWqFvkdCVZRrP2cTAvlUVZAGd4rDE+5+iUM22iV1VfvemZZ8kUGPIGEkKYDM4zY2dsnIhLPNudOjyTrKYlkgXzj8V20fNLL9A1WCDYk9Ui2Ay4u0ojEciQcRZAX+LrPra3b88bQh4lHwTi1Nb3aCLNdBQJRFzbSGUR/GpMv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235290; c=relaxed/simple;
	bh=z0RJ2vq5BFM+TwAdCAzQmXT2Np1rybm8jXQU+12aXh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEQAFxF1s1DV2nJYbdpNBvwbInXztaJCiCCA3rIAYUE7O1KiszhkSyvOZpzkqfb0j2heeEFFl1AU4lNi0W8v/+gxt/ga6wgDJke54u5rQ1AmnQMLeDtTuupsdOGktmgRiJaFc42N/uSgpT0x0rfaklz+rUBJBQZydxPkQLHSs1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DrKnPnNw; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6000f9179f8so586027eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742235287; x=1742840087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6G5kH1/17mAckBVSQ+0GeycayRC8uYE+FPvjcc3V28=;
        b=DrKnPnNw6/5qrQxbLZ7qLlGGMQxtRAEWTTGT773nUELhAxyKiy5aGvqAbezOJdVjhT
         QD80epzImVS47Jc/u72zg60tdNBgTg1k7GzQOknWZJNF/j5kuKEHLC+4Uqoqfe5fJW2W
         0X76TAkyPgirzxBFM8AK33+dk/dEIyIhyQjYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235287; x=1742840087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6G5kH1/17mAckBVSQ+0GeycayRC8uYE+FPvjcc3V28=;
        b=UA8U8I2rpIf86Lc4F0+oHrHiEA58pjqe4qJZhm7u9uoXJSrMDiO8ofss5ufWx64yXy
         7bUQX9MV5Pp1kX3gDqaztLV/uZ3Ern7Oyw0jqTCW+hTXAuoMnl7Z8zMEyRUQ2wfm/sGh
         dYGh836RHyMX+52xIyZe7mE/tFH+7LpnyI/PqacpD6eVBIzBQj9EjL6bsytSUPLYwbUL
         IJznU4vxMIQ1okv3CD+Cxw6zkfZgBQkdt6XiABR447/smYr4t5q6m59HzCUneQ/nws2e
         xRjVF60tglOUBLbmuMlPzMMtW4TkhRQN58eUyR6eRjHy7/2Za7S8Q4wWvOtK9PVzpSuk
         wnfA==
X-Forwarded-Encrypted: i=1; AJvYcCUagLUpu+Ltw65F//38BhVsi9trTrRGFHl54umz0w1/zI5fTqTNJBgt2ndx2x9Nq3DbUSpsiCGoVo8CFpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJGKJmw4/7YPQy66K1GaHRioyXQTNRmAAJs8cj0evQKN+jtG8
	C8xHwF2HpFBaanqbUWJaJgroSbttVgJbeQpU+ACI9sNk5pIlFTs0cN5H5hm3S+8SflzQFvzMMj4
	oky8qwA7MKiaGjofTU5yLFBag4X57H1Fzdcol
X-Gm-Gg: ASbGncsAbGQJS7gEcY444Ox7bBxagz/TBqiSDUVDTyQoDolPOLuMoqeRuh1haTc/HxA
	gokPuYI0fF6ZOeOrF5e0CijND4ZGSlqLCHbQQgPcsozNYgCSW0Qr1wE1AblF+W+bE2Ev3/m86RG
	yi6lERfcd/n4qV4NT43OBfSh3attcAa3AEdkUvhZkyvdfdonqODlPIgjwG+Wrq7fClmA==
X-Google-Smtp-Source: AGHT+IEIdIYyMphC9KIRv92mrEbk+JX8VcCMwxxmGXlhbHWC4pSDXwXa/exE7SgnK3ZFiIrx1hS6WPeWtb5d+k0lU44=
X-Received: by 2002:a05:6871:723:b0:296:c3e9:507c with SMTP id
 586e51a60fabf-2c691117825mr2878352fac.10.1742235287446; Mon, 17 Mar 2025
 11:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313000623.3192896-1-jeffxu@google.com> <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
 <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com> <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 17 Mar 2025 11:14:36 -0700
X-Gm-Features: AQ5f1Jr_ytqLHdovq4sBSX1pY1QSS_G7YR5AiuDQM9up-FcK9NgtAti-NP6kOSg
Message-ID: <CABi2SkWU6orm-wBFKVt9rsSpYURHPb7fjHRzkOiPGd=Lh-DdkA@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, kees@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, svens@linux.ibm.com, thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 3:41=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Jeff,
>
> On Thu, 13 Mar 2025 at 23:26, Jeff Xu <jeffxu@chromium.org> wrote:
> > On Wed, Mar 12, 2025 at 10:21=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > Add Documentation/features/core/mseal_sys_mappings/arch-support.txt
> > > >
> > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> Thanks for your patch!
>
> > > > --- /dev/null
> > > > +++ b/Documentation/features/core/mseal_sys_mappings/arch-support.t=
xt
> > > > @@ -0,0 +1,30 @@
> > > > +#
> > > > +# Feature name:          mseal-system-mappings
> > > > +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > > > +#         description:   arch supports mseal system mappings
> > > > +#
> > > > +    -----------------------
> > > > +    |         arch |status|
> > > > +    -----------------------
> > > > +    |       alpha: | TODO |
> > > > +    |         arc: | TODO |
> > > > +    |         arm: |  N/A |
> > > > +    |       arm64: |  ok  |
> > > > +    |        csky: | TODO |
> > > > +    |     hexagon: | TODO |
> > > > +    |   loongarch: | TODO |
> > > > +    |        m68k: | TODO |
> > > > +    |  microblaze: | TODO |
> > > > +    |        mips: | TODO |
> > > > +    |       nios2: | TODO |
> > > > +    |    openrisc: | TODO |
> > > > +    |      parisc: | TODO |
> > > > +    |     powerpc: | TODO |
> > > > +    |       riscv: | TODO |
> > > > +    |        s390: |  ok  |
> > > > +    |          sh: | TODO |
> > > > +    |       sparc: | TODO |
> > > > +    |          um: | TODO |
> > > > +    |         x86: |  ok  |
> > > > +    |      xtensa: | TODO |
> > > > +    -----------------------
>
> > > Plus I feel this need expansion a bit 'N/A' is because of being non-6=
4 bit
> > > right?
> > >
> > Below is the definition of N/A in Documentation/features/arch-support.t=
xt
> >    | N/A|  # feature doesn't apply to the architecture
> >
> > It fits the arm case because mseal is not supported in 32 bit.
>
> IIUIC, you can already s@TODO@N/A@ for all other 32-bit architectures,
> so we don't accidentally spend time on looking into adding the support?
>
Sure, my architecture knowledge is limited.

I just checked this, it seems to me that csky, m68k, nios2, sh, xtensa
doesn't have 64 bits support, the rest have 64 bits. Is this correct ?

Thanks
-Jeff



> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

