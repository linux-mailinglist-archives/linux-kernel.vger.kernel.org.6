Return-Path: <linux-kernel+bounces-307653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D549650D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210211C232F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFAF1BAEC0;
	Thu, 29 Aug 2024 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38iVYzga"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78091B86CB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963937; cv=none; b=Op8U5GIXgxdv75J+vJA47SrCnaRxk5CbSl6McmFnQWEwFIt7RK3VuE1NFOlcI8BdkQABWlmRX2UilmaJn/0N9L1psSEqa8oGUVsKKf3DlEUJmaQXL3lQjwgXuCyNpNxi1TtiTyXNxnjseKL6ttkDXziO86X79yOuQ6mlprBv2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963937; c=relaxed/simple;
	bh=fgcOfTEE1Q4Fc7yKoXLU28UYvHPI7osOrSgNsxvCigw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aY8JEPDf9swHO+13od1jo1cqsU4gzkdmrHC6xzzGBvIsDj+83cMqR+t8DshJRyQt+yYC5rnqP2NZ/3cGdluUOajctfUs9H9uYEtOxGLmhlU2xUaIsrceoirKtNOl/TcG53APk1eLDWy3M3BJKSj8h3QEEC8YoBmeYGKjWFZENeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38iVYzga; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201fed75b38so17535ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724963935; x=1725568735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgcOfTEE1Q4Fc7yKoXLU28UYvHPI7osOrSgNsxvCigw=;
        b=38iVYzgaQu9FNLnAcC1CmUv70cKRwyFTnna3JIE7q+6cUCzYaaAtsaXFqody0XPw2D
         8wAbEANk+X+/U7TwtRrFamZiJwP7kfj/LkALb9WntUEno/8AIsPNUe+WBdkucypVkRM/
         /vZAYpVOVUmUpq2WJaE4IsmB300Wo4cwa3B7BDrszBn2eWmRDiRwTNw28eKJgjiGgo5+
         WUo7gXrRaI7VtOARkLExqZqfAR/OXtfnNRUSZqhk67MJxF9MIxy1GHuludoqtABtxI47
         5PiyeoYletm8Nizv8AXCCNMUBHmQFLpMT83rQ130vT+iE5fD1XNOeqvp8VhRfp2MZLhz
         PoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724963935; x=1725568735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgcOfTEE1Q4Fc7yKoXLU28UYvHPI7osOrSgNsxvCigw=;
        b=KW1Xn5tsFveoC0bXSMt6VVATaGEN2DkbQHfx0LnzlTXVkHaQU9wrg7rnjZ3snpsRmv
         C203ErJvUEdffMKSuaCdPk8QhUieYa40Lh7UdrfyARWnCnEnngVWZ1i8rUhMnK+4Qb6h
         EJEqzpsvDI+JLuWNMSQz4N18Ym1QAtCOqWp8w/HyrcLBue3HlhLOm4D3hPCv51oBlU6F
         4bNryBx2umtxWUxGWEdzGhOYfTqTK4Cpy0YiPs5kE/Rnxq5Abpe2ayi0k5viQ0eqDFrn
         qOfgJSwuVgOwL1JewMRXf18uzEVd3ykgrocYjGkdlNFLQvK3D3Ilk4oHS8eoPyC+okzz
         REbg==
X-Forwarded-Encrypted: i=1; AJvYcCXdTnDriWd+XaBdvX7qqGahYHit9r4o3WCZUADyKf+3A3iacETrJV/aPAA/E3YfWp+KQPCY+FE1PpVZtHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtfLIV3jNMxteUs5EIvRwFr54sp4I1nxGLCu5swrG7yNb5I2dr
	EcDoKAFQykzx+DiRPBqo/+CKm3GUlniMQkyKDPaEEmJxVeE1X0e4zk+OYx5u+2sZwQFattnh+1l
	BW12APMp6+yOdNindr5cqYXmcXnvzT0YNtZOU
X-Google-Smtp-Source: AGHT+IGLgIVQ+svp/WpM2KGiS4B6Z/kEf5/+zWxQfmCatTs/970Zp4ORDHg46mCC204OTUqD9R+C82hj2l7GZzW8YYA=
X-Received: by 2002:a17:902:c94c:b0:201:e2db:7bd1 with SMTP id
 d9443c01a7336-205287d0c31mr11755ad.19.1724963934596; Thu, 29 Aug 2024
 13:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANikGpf0OmGMSkksH_ihW9_yXVAL25xKD4CBy8d1gpKj0inPjQ@mail.gmail.com>
 <CAG48ez3b-FCz7+4MH=CmhbhmSfTT4FTrDAJfbL5UvufRut7ixg@mail.gmail.com> <CANikGpcNj6P1jH8v0NjZJeQdn2=FbPr71CJ8W8GE+OeiCMgucA@mail.gmail.com>
In-Reply-To: <CANikGpcNj6P1jH8v0NjZJeQdn2=FbPr71CJ8W8GE+OeiCMgucA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 29 Aug 2024 22:38:14 +0200
Message-ID: <CAG48ez3wzKpYtAtiAcv=QBrMhETfF8UhnnpyVGXa4jb9Py2Zvw@mail.gmail.com>
Subject: Re: BUG: kernel panic: corrupted stack end in worker_thread
To: Juefei Pu <juefei.pu@email.ucr.edu>
Cc: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wow, that's weird. I think that basically implies that you're hitting
recursion that precisely goes deep enough to overwrite the lowest 8
bytes on the stack, but doesn't access anything below those 8 bytes...

On Thu, Aug 29, 2024 at 10:29=E2=80=AFPM Juefei Pu <juefei.pu@email.ucr.edu=
> wrote:
>
> Hi Jann,
>
> I checked the kernel configuration we used and I found that we did
> enable CONFIG_KASAN_VMALLOC and CONFIG_VMAP_STACK during fuzzing.
> I've uploaded the full configuration to
> https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
>
> On Thu, Aug 29, 2024 at 1:23=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Wed, Aug 28, 2024 at 1:49=E2=80=AFAM Juefei Pu <juefei.pu@email.ucr.=
edu> wrote:
> > > Hello,
> > > We found the following issue using syzkaller on Linux v6.10.
> > > The PoC generated by Syzkaller can have the kernel panic.
> > > The full report including the Syzkaller reproducer:
> > > https://gist.github.com/TomAPU/a96f6ccff8be688eb2870a71ef4d035d
> > >
> > > The brief report is below:
> > >
> > > Syzkaller hit 'kernel panic: corrupted stack end in worker_thread' bu=
g.
> > >
> > > Kernel panic - not syncing: corrupted stack end detected inside sched=
uler
> >
> > I assume you're fuzzing without CONFIG_VMAP_STACK? Please make sure to
> > set CONFIG_VMAP_STACK=3Dy in your kernel config, that will give much
> > better diagnostics when you hit a stack overrun like this, instead of
> > causing random corruption and running into the corrupted stack end
> > detection.
> >
> > (Note that if you're using KASAN, you have to enable
> > CONFIG_KASAN_VMALLOC in order for CONFIG_VMAP_STACK to work.)

