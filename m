Return-Path: <linux-kernel+bounces-533476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE995A45B07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816F01886708
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84F720F076;
	Wed, 26 Feb 2025 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdiTqZPC"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82939258CE0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564025; cv=none; b=Wj/PPcdoJDe61pktpLDHmPPCaWJHHDT4+vqKGbced+5tCD/t9lLYVQmAj2FydQ0WZ8HD/HXcrlTJWH9yZbCkwVZpmakK7cEKrkjhKJnHNfSfiTLm/MRGeCgSu7DSHtcOtZWsp5qdAOctQYB4OS9OXjx9jHM74qZSb4SN1aIKbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564025; c=relaxed/simple;
	bh=kqmShXt5ryFIF4hMkWk32/80MUCwQhCRWauv2dnNPBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxtm5Nawdsn76gQvaRSKQ2Hi00POSLmjLLvYSE1UdHju4tFm4CmrqdkOUBWYDPhxFTspxEYJlFSOtp4sZka0Gf6oH501QWLlgq9VmnSRB7s/1UZ9WYUe6VY8nDiz5Oz/VhoMCIsl6L9ESuNz+k2Q0DFTsfRhhH5DgKDthVwR9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FdiTqZPC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-546210287c1so6658363e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740564021; x=1741168821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqmShXt5ryFIF4hMkWk32/80MUCwQhCRWauv2dnNPBs=;
        b=FdiTqZPCNjbkFI4F1MR79dDhDR7E5sdaCiyxmKtOgZPshp1NJ0WTyI0bhvWGwUYw6I
         cXguj0aLsHlO1r8kJ8bYzrUCRzgiq2VAZORalcFd/Bi6cR80KUhPcB34lywiMwkcYgyj
         TTRXN4pfYW3bswxKPxtJLWvzrwPGPEDLHub4d33UICQYi773oKninMlyvAc9uxSmDUj1
         p/U/GtH4I8fIHKLx2Z81tL8fSmZUjzy/aRTuxhxBZk6UNp7J0tyn3BjmykcQI5g2w4bh
         LNX6Jm3ScCgolwJbJZDZqvwT8GWba/u//vUtXtwp2wi9bIl6LvZLxi600kBaOTx7vrON
         tCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740564021; x=1741168821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqmShXt5ryFIF4hMkWk32/80MUCwQhCRWauv2dnNPBs=;
        b=eUz+iLhSLarrqevksnrSJPEcn5IMzAK7LH5Fr6kky1tJ96DYChMiZPOGW1Uwv992OC
         OmbXvIxrix/AZK24nbRI+dVhJVBeILNC7o5fXjgnoIgZvVZRWPEB71DK/ZfBQXrzeiO5
         +t0cO3T2ObWw1NqUQvUBz03rAkwrCLxD8a++dPSgKbHwIsFYKwUMouly9H4GgbsPXX7g
         by6+7zMPdxFBxqLcS4TSO2qfohC0lckk2T6vJ2YLoAdX/gYTFGIdoIsjU8lrxtfJpJjL
         6SPjYzlQY2ipFJzPl11CT35T4e8/K8DycUmGDX3StXZ4Rr7dibriCOzdolTBQbPaEZs6
         mYhw==
X-Forwarded-Encrypted: i=1; AJvYcCXKlQ+6/G73lF3nTGosH+v+1Vw5T4lm4dRLFHHHWiByQtstlHnCnsWLWv21G8/GU7PLa0RA5gA4W8gy2UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRbV/VM5VKpO8CNAt0ZhpluezJQG+pycaWYDKiZqHOAHkfi4c
	JHzwrBUkU5WJNUkVKGV5naYNH7jr8PxiY/hlYNslW6TEK4PCFf8Vu2oFrjwugf1MetPfAU6+fPW
	tEeg3Bwo3z+tM17hFnk0seu6igcH3maJ4jU+L
X-Gm-Gg: ASbGncuTw0UhGsqn5NsQi21z+4ti0g2ZyXXFq6yuZc1i22iOmHdlRvRxHsVNruwsV0U
	atX3rlacJK/IpMmvW+IgbdO7xyHZBLUWu9L9YiwmDrbtJooFeUZ80mN4mELxxDAmf758ZxO7Xai
	p1JdnicpQDA4QssyxeGEWWcmdNERuctUhfLSuzQRyS
X-Google-Smtp-Source: AGHT+IH4RRTXCYHyG8NuSUXvZw6gAqUmlh2UQb699E0ri/CYuCCym2rRgWREckEjuHRqBI/LpjvgxwkOS1OjqfaT/Ws=
X-Received: by 2002:a05:6512:3f17:b0:545:2ddf:1189 with SMTP id
 2adb3069b0e04-5483912fc63mr9782576e87.6.1740564021354; Wed, 26 Feb 2025
 02:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com> <ffd123bb0c73df5cdd3a5807b360bd390983150b.1739790300.git.dvyukov@google.com>
 <32af68b8-4280-4c15-8e5c-be807c282f94@intel.com> <CACT4Y+YmWrEW9m5zxKoD-Hu0TXKWPVAr0_Xe_X9WGtZWH5W1_g@mail.gmail.com>
 <d352ab70-6c13-453b-a018-dcf19d1a9924@intel.com> <CACT4Y+Ynq=21v0gwZxQ2sQhrJHibYoP6QvcfPoGBFYNXjzodDA@mail.gmail.com>
In-Reply-To: <CACT4Y+Ynq=21v0gwZxQ2sQhrJHibYoP6QvcfPoGBFYNXjzodDA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 26 Feb 2025 11:00:10 +0100
X-Gm-Features: AQ5f1JqZR8q6hmhWfJ4tB-uDoTRxgHJ8hRMeL6gBhIcMT8N368t4G9CTcg2RoGc
Message-ID: <CACT4Y+awOeS8aDkCTJbf4DQXui6pGhVadMkU6ukxnNA6ue88pA@mail.gmail.com>
Subject: Re: [PATCH 1/4] pkeys: add API to switch to permissive pkey register
To: Dave Hansen <dave.hansen@intel.com>
Cc: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 22:56, Dmitry Vyukov <dvyukov@google.com> wrote:
> > >>> +#ifndef CONFIG_ARCH_HAS_PERMISSIVE_PKEY
> > >>> +
> > >>> +/*
> > >>> + * Common name for value of the register that controls access to PKEYs
> > >>> + * (called differently on different arches: PKRU, POR, AMR).
> > >>> + */
> > >>> +typedef int pkey_reg_t;
> > >> Tiny nit: Should this be an unsigned type?
> > >>
> > >> Nobody should be manipulating it, but I'd be surprised if any of the
> > >> architectures have a signed type for it.
> > > Since this is a stub type, can matching the real types do any good
> > > besides masking programming errors?
> > > I've changed it to char in v4 to surface more potential programming errors.
> >
> > I was more worried about copy-and-paste.
> >
> > I agree that 'char' is the most fragile, but it's going to fragile in
> > subtle ways and I'm not sure subtly broken code (whether it's expected
> > to be compiled in or not) is great to have in a code base.
> >
> > Do we have any types in sparse that would be appropriate? Could we mark
> > the pkey_reg_t as being in a different address space when pkeys is
> > compiled out so that sparse knows not to let it interact with other types?
>
> We could typedef it to some fake struct. Such a struct can't be passed
> to any function accepting an integer type (real pkeys), and any
> arithmetic won't work on it.

Dave, how should we proceed? Do you think this is a potential misuse
worth preventing proactively? If yes, I can send v7.

