Return-Path: <linux-kernel+bounces-221887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A464C90FA1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D177B22EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A7515B578;
	Wed, 19 Jun 2024 23:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="fAG+47x3"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0128248E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841584; cv=none; b=uWynxINYLR5RYqFGVR3nJjhs1Rx97guWJQznUeCjlXeEH7DN7rzTjt8B9cnt391hPMhdMSG9LnWC8RRq+6Z70EPjAm6UuD3hH7Y8DjFoRVLNDXjy+3w2rpY2PSiv5zrhTV6aWE3LZi1RSNHsl6U8BFqaTOOKhIoT5GDd3jirGFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841584; c=relaxed/simple;
	bh=w2btu4P5BXW3/ezHdF5Vx16SW74qJCbWOfRSjRu+n6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kt3U5EmJbcgECiEVzoSd3MTeL3/CR3ZZWlSC2FQ0G9SB8gtIm2oBYL1jq4Dv2DOq6AUTL6bDFxItKESK54jOM94MddJcpMIoccXUMj9QTG5mMF7htl5LcQd61lj7KsLt5Kj7M/eE0N9HT0ibWyO0voqbgZhCnFkukR8r452w4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=fAG+47x3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c7aafe3094so66881a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1718841582; x=1719446382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPIWffzVniZY30jt5CUBA5ztypiy6lkcOF4OsPdrjrA=;
        b=fAG+47x3b+BgLYxPFgR3rC86w3sX9BDlZ7bFrZscAFjVq59x+CIglg2DcQxJik2Sdh
         q47awA3CrZP/NRxkvf8hoJgxR8gt75XY4ex2y8+zb/6+PUmNKAGS5RuKjuhnopQ/hmsc
         dg4aiMUPmx2VmsTeoeipdJLY+xjGgz+QrMsWQQD4AtGVzfULC5Ua2Wp3DH3rkVW0ptAH
         YyVKjwR6ysG+x0tlePmWOLh/wuugxBB1r9q/L2EdQIn4JgANst7L38Cf67VlYICbnrTF
         57e+eD3nDuTd0+550cZ0aZNAifzBwrrXgSkkrn5mCw3kVO5sZtlA/VrvfLVQlycrLn/y
         RBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718841582; x=1719446382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPIWffzVniZY30jt5CUBA5ztypiy6lkcOF4OsPdrjrA=;
        b=PGS+1d+y2GcizW/6/0ZknBTQTPp7Bweye10KCODCsQVi+6VbIreSx1t18lUeWLu6mB
         47cHFC3tfnnLefEi0J5Ug83upPzz17PWmePjlCgb8qWHyWdv7llzuBfclrXiuMj/Dy6e
         vnnJyk7b2I5FILSH2ILIE4MWi6GG0MIsktdhGm0aoFmiUWXlOs0VbAK2PCrhQ1idxX57
         Af7xnpC0XDhHijYhuZYCm8XnMkeCzholqe12d0AIuxvQAasrQwwdN4Du62aWjJ/he3BQ
         0egtxV7hcseWYvjgni+cg1ghG76Scdb14JTS3Mod53vjQR3djnj6jUVTAbYqbc/dWE3c
         og9w==
X-Forwarded-Encrypted: i=1; AJvYcCXryfMaI2D/+EvUJDOQ2Fo34twhSXfCP/fmCwYagaatB5EF1tzHj89EXuTzmpBLDwp0wXbNrvLm+IovvNZu62eBn0r/IULKxD+kD7AS
X-Gm-Message-State: AOJu0YxBVaqzNPgKRIbVUd9AJtr5e976ztXud/6beu9SymToIkZKMGHZ
	ymeLTvN/JQkuzp19G90iPtrT8llvSg0ddaDgvSs0F39hjcZMhYUDXiGGk60JkhugF1H42nQFASy
	3y15QZzI7FACFHvRUcK64lWsIb0B9fpAQprv4
X-Google-Smtp-Source: AGHT+IGDy54gwmtH82mfmVUG3BVW+uVDtF6f1DEOMp25r37WxWLMBLNrcKUmvJJ5UTrM6dq2WaFLjtA2UFy1eXQ4iNI=
X-Received: by 2002:a17:90a:ead5:b0:2c4:e2cd:996d with SMTP id
 98e67ed59e1d1-2c7b5d95b07mr3787651a91.3.1718841581837; Wed, 19 Jun 2024
 16:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616170553.2832-1-jszhang@kernel.org> <CANtDSir9O+B1mZx-k+j0+bHo03A653itida8f34frFaY2doM0Q@mail.gmail.com>
 <ZnL1OV1GQxV4nS2h@xhacker>
In-Reply-To: <ZnL1OV1GQxV4nS2h@xhacker>
From: Cyril Bur <cyrilbur@tenstorrent.com>
Date: Thu, 20 Jun 2024 09:59:31 +1000
Message-ID: <CANtDSipLW3g558mqtRmdh4O_j0mKpz+f+zMAqoDAeDEmbxObCg@mail.gmail.com>
Subject: Re: [CAUTION - External Sender] Re: [PATCH 0/6] riscv: convert bottom
 half of exception handling to C
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 1:25=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Wed, Jun 19, 2024 at 08:16:58AM +1000, Cyril Bur wrote:
> > On Mon, Jun 17, 2024 at 3:21=E2=80=AFAM Jisheng Zhang <jszhang@kernel.o=
rg> wrote:
> > >
> > > For readability, maintainability and future scalability, convert the
> > > bottom half of the exception handling to C.
> > >
> > > During the conversion, I found Anton fixed a performance issue
> > > and my patches will touch the same exception asm code, so I include
> > > Anton's patch for completeness. I also cooked a similar patch to avoi=
d
> > > corrupting the RAS in ret_from_fork() per the inspiration.
> > >
> > > Mostly the assembly code is converted to C in a relatively
> > > straightforward manner.
> > >
> > > However, there are two modifications I need to mention:
> > >
> > > 1. the CSR_CAUSE reg reading and saving is moved to the C code
> > > because we need the cause to dispatch the exception handling,
> > > if we keep the cause reading and saving, we either pass it to
> > > do_traps() via. 2nd param or get it from pt_regs which an extra
> > > memory load is needed, I don't like any of the two solutions becase
> > > the exception handling sits in hot code path, every instruction
> > > matters.
> > >
> > > 2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
> > > alternative mechanism any more after the asm->c convertion. Just
> > > replace the excp_vect_table two entries.
> > >
> > >
> > >
> > > Anton Blanchard (1):
> > >   riscv: Improve exception and system call latency
> > >
> > I've retested this patch with the rest of the series applied. I can con=
firm
> > that the performance improvement is still there. Definitely thumbs up o=
n my end.
>
> Thanks! The 2nd patch is inspired by Anton's patch. The remainings
> are just to convert the asm to c in straight forward style.
>
> If possible, could you please add your Tested-by tag? Or even better
> review the series ;)
>
I only saw this response after having a look at 3/6. I'm a little
nervous about a full review
as I don't know all the riscv catches yet.

I'll say that the testing of the series wasn't massive. I just booted
it enough to exercise
that codepath and get some numbers. Having said that I'm fine putting
a Tested-by
for the series, it did boot to userspace after all :).

> Thanks
> >
> > > Jisheng Zhang (5):
> > >   riscv: avoid corrupting the RAS
> > >   riscv: convert bottom half of exception handling to C
> > >   riscv: errata: remove ALT_INSN_FAULT and ALT_PAGE_FAULT
> > >   riscv: errata: sifive: remove NOMMU handling
> > >   riscv: remove asmlinkage from updated functions
> > >
> > >  arch/riscv/errata/sifive/errata.c         | 25 +++++++---
> > >  arch/riscv/errata/sifive/errata_cip_453.S |  4 --
> > >  arch/riscv/include/asm/asm-prototypes.h   |  7 +--
> > >  arch/riscv/include/asm/errata_list.h      | 21 ++------
> > >  arch/riscv/kernel/entry.S                 | 61 ++-------------------=
--
> > >  arch/riscv/kernel/stacktrace.c            |  4 +-
> > >  arch/riscv/kernel/traps.c                 | 57 ++++++++++++++++++---
> > >  7 files changed, 81 insertions(+), 98 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

