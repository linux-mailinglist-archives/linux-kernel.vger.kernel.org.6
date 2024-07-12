Return-Path: <linux-kernel+bounces-250105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886C092F44D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA931C22A56
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B76D272;
	Fri, 12 Jul 2024 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOv1ke1r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD4C2C8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753979; cv=none; b=Eh4zcV8iNT2Yr0nypCJMxgXZqc/BeqI9yj/6ordpPdcDJiqMTK4uZw4Dg7W+c73gar/dotKPoLAI6lNES510fAknALDi6mH6beFPcekhz2Wx5ALAMevSybAcQrcyVimJDsIAPMjoX3fDAFdgHelmrBQQzFxpOPOPR2WI6Ev7Qrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753979; c=relaxed/simple;
	bh=4CMnMmZKlqqfGQs63MdCFUNUoJWF+9xTEqu+cn+eEz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgDvQdUHWFGWShy0Tg2zLQasIeySXevaZC93rXyTC1WZ9zYIlARotmemIlEhdZM8DOdtYhr3i2jdV7Ltp4pmW7wnej5h0IpgGQpI7himMQObgiAJwAL93ocIImESFfzMcdnstXBWU9J+cqRafAjGNSCbSBkPwvTgoBAl9gjYfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOv1ke1r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720753976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXY/sZpO06n+Rdcmg5Em3FyGZZSOlUrDiJ4rTK+vojA=;
	b=jOv1ke1rDH2TAwQEBORqbNaj3C9fBblJxVihhQLiq1Dyx/RqYLU4mfq9QPioY+9WuxVn/Q
	bCgmgNFVOZISmdMDTUeRbUuRaFxfxrHxbAoX0gI98C34RWe4/FTtorZtiKqMC8hC13QiS5
	i3nP0qiFMaGqkC5EE7cog3JVBzCKwlQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-Yv-i1pd9PT6wjftiDvpOQQ-1; Thu, 11 Jul 2024 23:12:54 -0400
X-MC-Unique: Yv-i1pd9PT6wjftiDvpOQQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c9015b0910so1965297a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720753974; x=1721358774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXY/sZpO06n+Rdcmg5Em3FyGZZSOlUrDiJ4rTK+vojA=;
        b=e84QypFsmeDPUHJUMHQSjpFbC8X7tR7K2iV7x1zKuuwr3TY+AltzDVT8KqxZhkEYlG
         1NBMMs/62tDAteGl2KSTLC5q/A1fac0xpcFfzsb1M7wrkxGw72A+7TCuk10j35FFN+Jk
         Ql2enUnRwQDfWU5MJChhvqjKrpPyzbhd43QEVHImQAtolzVklSScpToyln4nkJT91Ovg
         fb+3+aXfL5o7xjWhX8oB+eipLS9dRKHcMYTC717qfttdx3PLX9VaDQShWuaz/61SF0/3
         cGA+0mMoI2YvCjVaL1XucKSssl2uKbxXtSuv2gPHkUYuGwKveomzcTVUB+Wf7XsWz+6l
         QuQA==
X-Forwarded-Encrypted: i=1; AJvYcCXD3UgfPqQ7s4uA/6TQ6uLcTN9njLTersDYUE73SEy2npF6UeLGUo8ZFBYaacukKsqI+4czNH0rOqxwp21xRuubm2AVcu00ngq2TIup
X-Gm-Message-State: AOJu0Yz0M+mqO7JR0QlbsnoSPhWAsT8ALGaT8ilRA3SwBlwKpt6kt1O6
	/O+/G2IXH3USNcDLxYC91ckqH3leFnAbe1KpKV13/NyEoyefXxjU+4P4cddkUIBZBX4hw24dJHy
	q/LJ0GtbBcBSeyMFXTE4S+mvh8aAC/oNigUfVBV4RMLMILeRTcUUUWPKpty6OyFsY8RxfjMz6hl
	BQvX4IorTq8MmzqetNMkH9Y3JC//LtJw3Fri/8
X-Received: by 2002:a17:90b:1bc3:b0:2c8:2236:e2c3 with SMTP id 98e67ed59e1d1-2cac509b515mr2201880a91.17.1720753973688;
        Thu, 11 Jul 2024 20:12:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtAK2n6iWFwX5bM16eYpsf4GlrruFMJ7fNUbwgy0bcVCD8qdJ7sxCfFWVabHQR0P0ve6dq9fYfAk7ofO0SHvs=
X-Received: by 2002:a17:90b:1bc3:b0:2c8:2236:e2c3 with SMTP id
 98e67ed59e1d1-2cac509b515mr2201859a91.17.1720753973198; Thu, 11 Jul 2024
 20:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701191319.087b227e@canb.auug.org.au> <20240701171901.GA882812@thelio-3990X>
 <20240712122843.312313a4@canb.auug.org.au>
In-Reply-To: <20240712122843.312313a4@canb.auug.org.au>
From: David Airlie <airlied@redhat.com>
Date: Fri, 12 Jul 2024 13:12:41 +1000
Message-ID: <CAMwc25oaX1K1Co0vSsN1H3busBLH9xA3-f4OAHZXN4iB4_d=gg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Nathan Chancellor <nathan@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	DRI <dri-devel@lists.freedesktop.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:28=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> On Mon, 1 Jul 2024 10:19:01 -0700 Nathan Chancellor <nathan@kernel.org> w=
rote:
> >
> > On Mon, Jul 01, 2024 at 07:13:19PM +1000, Stephen Rothwell wrote:
> > >
> > > After merging the drm tree, today's linux-next build (powerpc
> > > allyesconfig) failed like this:
> > >
> > > In file included from arch/powerpc/include/asm/mmu.h:144,
> > >                  from arch/powerpc/include/asm/paca.h:18,
> > >                  from arch/powerpc/include/asm/current.h:13,
> > >                  from include/linux/sched.h:12,
> > >                  from include/linux/ratelimit.h:6,
> > >                  from include/linux/dev_printk.h:16,
> > >                  from include/linux/device.h:15,
> > >                  from include/linux/dma-mapping.h:8,
> > >                  from drivers/gpu/drm/omapdrm/omap_gem.c:7:
> > > drivers/gpu/drm/omapdrm/omap_gem.c: In function 'omap_gem_pin_tiler':
> > > arch/powerpc/include/asm/page.h:25:33: error: conversion from 'long u=
nsigned int' to 'u16' {aka 'short unsigned int'} changes value from '65536'=
 to '0' [-Werror=3Doverflow]
> > >    25 | #define PAGE_SIZE               (ASM_CONST(1) << PAGE_SHIFT)
> > >       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/gpu/drm/omapdrm/omap_gem.c:758:42: note: in expansion of macr=
o 'PAGE_SIZE'
> > >   758 |                                          PAGE_SIZE);
> > >       |                                          ^~~~~~~~~
> > > drivers/gpu/drm/omapdrm/omap_gem.c: In function 'omap_gem_init':
> > > arch/powerpc/include/asm/page.h:25:33: error: conversion from 'long u=
nsigned int' to 'u16' {aka 'short unsigned int'} changes value from '65536'=
 to '0' [-Werror=3Doverflow]
> > >    25 | #define PAGE_SIZE               (ASM_CONST(1) << PAGE_SHIFT)
> > >       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/gpu/drm/omapdrm/omap_gem.c:1504:65: note: in expansion of mac=
ro 'PAGE_SIZE'
> > >  1504 |                         block =3D tiler_reserve_2d(fmts[i], w=
, h, PAGE_SIZE);
> > >       |                                                              =
   ^~~~~~~~~
> > > cc1: all warnings being treated as errors
> > >
> > > Exposed by commit
> > >
> > >   dc6fcaaba5a5 ("drm/omap: Allow build with COMPILE_TEST=3Dy")
> > >
> > > PowerPC 64 bit uses 64k pages.
> > >
> > > I have reverted that commit for today.
> >
> > FWIW, I sent a patch to address this in a bit of a more targeted manner
> > over a week ago:
> >
> > https://lore.kernel.org/20240620-omapdrm-restrict-compile-test-to-sub-6=
4kb-page-size-v1-1-5e56de71ffca@kernel.org/
> >
> > Although somehow, I left off Ville from that patch :/
>
> I am still reverting that commit (as of yesterday, the failure still
> occurs) ...

I'll merge this directly to drm-next today.

Dave.


