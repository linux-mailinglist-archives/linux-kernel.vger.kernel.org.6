Return-Path: <linux-kernel+bounces-525847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1176DA3F63F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAED3ADC01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460122066F4;
	Fri, 21 Feb 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNjwMJYC"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC51EEE9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145242; cv=none; b=B6cxVQWoOHAC3Rgra90CkP/drcItA8pPn/oGjNt8a2bT3xbTszq5dlGc0a1KuS+62sHLF2rHllyDllxgCrTk6jFruOo6ndJq7kMyb+L6GBnVT7tMEIr+C0q5HJQxhBTXHaIbiz/aCV7iG1MLrgmmSxEhm/70WelcPSkLfL+KJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145242; c=relaxed/simple;
	bh=abE3OC7GtERuTQujE4zWkuiliPU4Mj84D9MUmUiGcKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOkXHjTt1LnKFAe9LC4Z6/WNtkcui0fM28tdAinXPyZqLbiM3Ammgl3ECDSnsrWnZIHP9t8f+GvI9dF1E+v5pXBM7nGLi+ApIOR/gnsmkiR5KBF7Vxta4C+Ts3oqjYa9IA02/oXYwuUyLiMERqAbDblEG4PFefD8qp2We+cBedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNjwMJYC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43994ef3872so12826865e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740145239; x=1740750039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IF+xmLACmUdx50AqWMzfcLJrRt8WfUsj+P446cVoCHs=;
        b=dNjwMJYCV198DJ7M0nvNg2cRVuFUrVlBDmus8NLlHvfUJLP7liUZeDllUVGNrQN4/N
         /b3MePIsY6gIrUTZnYASHJ49SgNZET2JNm/sPmcukStVZlZoC6oUR7hqsW4b+oP61QrA
         0ul2hsn7LOFYu6+AKq4BQ6W+JJ9bv6V/ccDkmLgjruKXIOXd14bLPAwO5Jeyt9S2bhYI
         1lazRQDa+1TQ1fxDLSZYh5wOQhH5DLChIOnBPoKgrxjNkZ1Vb5BnWuCsNNOEJrvXF31/
         38Kk9PJehO7tMm7OKHmkNd/gwXugVThIQ5ecU/lZ7ZeOk7uHvR/5gWKEMu7fdzB+NyK6
         V7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145239; x=1740750039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IF+xmLACmUdx50AqWMzfcLJrRt8WfUsj+P446cVoCHs=;
        b=lqTGpKLId20HFmB5CYSVyw60Z3GrIbP2KjM3X5J8+ZxTZ1QCcYNJdnC0Gm0DxhAl94
         ZIGB5BI4FfK8uIxAMGfCjmJIBMbGulGxoI+U57Og/kIBA/FyDzov3ENdypX7GIkBiBaZ
         wEuUpyKJ050YZDuHyp4fLUgSaDxcznBC1v3NYZMZ6FUoalg9N6BGiLWPQqExtgI0hMPr
         CN+1Eu0DonfuTtusMx11kROR0dBzcipcb7cgpKtW/ERUw7ObS33CgMGjwvwYI4CuZx/l
         ih+rAF9LclTMNfQiL8e6CceIW0bznc8cWDniJ+Q1uub4JFojuUQBjBf/nsgnpO2U5uTq
         jA9w==
X-Forwarded-Encrypted: i=1; AJvYcCXbNoiEVIYws9kva0X6Q9ZU+orBf3UGkAH2SPQvzFr96BmpExdjWuviwAF8/drSzuQcE1LnsSFYRzksC50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzy1D8JIj5dtZrJESOdRKWgqtx7JIU+m8sojFPnsqvUKesT+Ya
	NlC2JMEjghUiYlEC+5Q73aW07H/Y/qfg6GN8uEE6iKSHKaimEwnY
X-Gm-Gg: ASbGncv13QQdmS9bYYrtaolLlrOthWjUwte5+qiFToGnN0Tm+HqjqNELqZQ9tSTaVLK
	CG63hKjvOrLXbqybw26qzllwmtgQz/Ac0eMb34Z0oADQMmCNHscg9sVTLGcJgMysDHp4xeEyOhD
	fEffnh0RF4R146zmktFeOipuSZZwm2QXVHWjk+gBWnA1QJnHxHN91IzhcDN/LjTj5GfAkilpklL
	h/epmbr+2qewRKbi2ktBu9HOafuAEx5NaSFm+aIqS+gAzoU8Gwmuw50q2UsyWTuzwSIgds7Ddsm
	VBq5Vbr9zcF6XjNOWScyveroYLfiEvSg+zniUhIRiYXatz+lGrpISVrpstuPp75z
X-Google-Smtp-Source: AGHT+IHaPhuRwsxoquKOE8oIkozBO9v1g1QBNoPYKR7i00UriawAvUTL3jletdI5nYPKotPL6P5f9g==
X-Received: by 2002:a05:600c:3c93:b0:439:9f12:1809 with SMTP id 5b1f17b1804b1-439b155cd92mr16741525e9.20.1740145238777;
        Fri, 21 Feb 2025 05:40:38 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce404sm17995605e9.7.2025.02.21.05.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:40:37 -0800 (PST)
Date: Fri, 21 Feb 2025 13:40:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, joao@overdrivepizza.com, jpoimboe@kernel.org,
 jose.marchesi@oracle.com, hjl.tools@gmail.com, ndesaulniers@google.com,
 samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
 kees@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
 jmill@asu.edu
Subject: Re: [PATCH v3 07/10] x86/ibt: Add paranoid FineIBT mode
Message-ID: <20250221134036.641af213@pumpkin>
In-Reply-To: <dc7c570e-153e-4e46-ae40-d1590682d50c@citrix.com>
References: <20250219162107.880673196@infradead.org>
	<20250219163515.040300905@infradead.org>
	<dc7c570e-153e-4e46-ae40-d1590682d50c@citrix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Feb 2025 17:31:39 +0000
Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> On 19/02/2025 4:21 pm, Peter Zijlstra wrote:
> > --- a/arch/x86/include/asm/cfi.h
> > +++ b/arch/x86/include/asm/cfi.h
> > @@ -1116,6 +1129,52 @@ extern u8 fineibt_caller_end[];
> > =20
> >  #define fineibt_caller_jmp (fineibt_caller_size - 2)
> > =20
> > +/*
> > + * Since FineIBT does hash validation on the callee side it is prone to
> > + * circumvention attacks where a 'naked' ENDBR instruction exists that
> > + * is not part of the fineibt_preamble sequence.
> > + *
> > + * Notably the x86 entry points must be ENDBR and equally cannot be
> > + * fineibt_preamble.
> > + *
> > + * The fineibt_paranoid caller sequence adds additional caller side
> > + * hash validation. This stops such circumvetion attacks dead, but at =
the cost
> > + * of adding a load.
> > + *
> > + * <fineibt_paranoid_start>:
> > + *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
> > + *  6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
> > + *  a:   4d 8d 5b <f0>           lea    -0x10(%r11), %r11

I think that 0x10 is the size of the cfi premable?
There should probably be at least a comment to that effect.
(Maybe there is, but I'm missing the actual patch email.)

> > + *  e:   75 fd                   jne    d <fineibt_paranoid_start+0xd>
> > + * 10:   41 ff d3                call   *%r11
> > + * 13:   90                      nop
> > + *
> > + * Notably LEA does not modify flags and can be reordered with the CMP,
> > + * avoiding a dependency.

Is that even worth saying?
Given that the cpu does 'register renaming' the lea might execute in the
same clock as the mov.

What you do get is a few clocks of stall (maybe 4 if in L1 cache, but
a data read of code memory is unlikely to be there - so it'll be from
the L2 cache) for the memory load.
That means that the jne is speculatively executed (and I think that is
separate from any prefetch speculation), I'll give it 50% taken.
(Or maybe 100% if backwards branches get predicted taken. I don't think
current Intel cpu do that - they just use whatever in in the branch
prediction slot.)

> > + * Again, using a non-taken (backwards) branch
> > + * for the failure case, abusing LEA's immediate 0xf0 as LOCK prefix f=
or the
> > + * JCC.d8, causing #UD.
> > + */ =20
>=20
> I don't know what to say.=C2=A0 This is equal parts horrifying and beauti=
ful.

Agreed.

Are you absolutely sure that all cpu have (and will) always #UD the unexpec=
ted
LOCK prefix on a Jcc instruction.
My 80386 book does say it will #UD, but I can imagine it being ignored
or even repurposed.

	David



