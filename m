Return-Path: <linux-kernel+bounces-330801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC43297A471
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D19C2811E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFE715855D;
	Mon, 16 Sep 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmALsNfg"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77085155A3C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498164; cv=none; b=lign6SC3SYxPMP07IsOVpLbnghHiZmDwCo72NqWaOTWQR3215ZztvBwC0mCX3WlSZ/CSX2X2uoB8gnExxcuoUwIk+meoZT+nXuk8CP6VjTjcnQSQ4MCL6QeR3p3FlRwFm1ReFsF1jKyaUFqx6YtPWCGLqklGBVrJYPDweqgUXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498164; c=relaxed/simple;
	bh=8gc7jRbFljRiei4ZFyXApkTdd/FDenJMtMZivhjc88Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myFjrKl8fPHGCXy1tbHznHA6UM88Dgq+Su2KUIL/mXBNg5hYF30E59xPF1Tx4wuwEPXwJGOGl8/A9l/D1CJXqpKMnI2LIUbhWgbIY+to7Nu8fbJCM0EWFi+RrScBwhaWhloUwS6UJd2yGHeQ0dVLzsH+H51FmOjnlcAFM6FYwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmALsNfg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4582fa01090so661971cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726498161; x=1727102961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMelMzTkoJmecj8Ec280QAFHRxkxEeMzZsfbZtByo7k=;
        b=TmALsNfgcokBj4u/1P6m853j75zO9RwHTxyKQkfft+n7nUGN7pRrRpnaY+GJLhJSMq
         pT3nHPkZvqk7yXGipf/r+SPNxD+/aySyjq8dTzaPHPysmivho3tLRSuPUIQHmGz9aH4c
         bFUkUXedWjXZeQ0PbegXvDo/YfZEPPer0hacOyl98KXljYZTXLWao6srBcoaG/fMlZFo
         SqB86Ncjr8XB9rkrDmFahgXIfZlyHGu/XiB84N8xOC21IHAIb2AdCnbSaMQRLwixMWaB
         63i3/pn1MUC9sm+MPH7oKCCvODxRJ+RPO/6uJlWLtkwj0z0qH/cTnjwz5g3ocffv9hx9
         8r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726498161; x=1727102961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMelMzTkoJmecj8Ec280QAFHRxkxEeMzZsfbZtByo7k=;
        b=jTUTuNSs1PWWZhZ8o8PIVzgr5sE90SgPbhe2O960FSgDj/HxPtmmFYE5tNZGPjIj0F
         8Aj8PqKePEA80NjF6lhM73i6NtglU4cZYF5aisT5K3qdjV3RuMD1nkgU/zvv+18mmrnc
         1RJg8yOsDbYyVK1QWVdprphm6Bh3ianRILS1S7zjWhxhoDRpvX2lLjqJgcvjGb1GJtxc
         WNbgGbv0sXrkojvWOQ98nZEpWlv+hxiHWkSf88n7B6cX1pioTjaDVq8c+iNYg9hhglZv
         DTfn2mBIh0icCsPbcHxPFxmnpI9zcYDCGuxc5axN3VWACJV7aFMHczYHbixRBjhTuEQp
         a4xA==
X-Forwarded-Encrypted: i=1; AJvYcCUCco+mJHNDydAhIKhoTmGqSHROWS2NiwcCoOh6nwdJbbPQJ4LnBCfAfCBvUbZFhREbJExd3gVTdxjO8G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwccB28L3580YlhfKvwLxTDZJ5VsFrqIH554Vt0NeXmJne9nleK
	NyACW4uvCSd3ruzN7Ag92NUL5LKOITpolre68hinq63Rdkk374ALUDS2t8nNDU2peNnlxN89704
	qSi45HVCkXFOcRhFt/CnaqkAQFAykaokq5rdE
X-Google-Smtp-Source: AGHT+IGG1zTJv0c5bKWcBL6ppyd+R0pFs7s6AY9gInCgYJM1VZD4gWzAvaBlLTTRQ29SZSznByKAx07pm4J3HlYVrNA=
X-Received: by 2002:a05:622a:413:b0:456:77a8:ea2d with SMTP id
 d75a77b69052e-458644f9fd7mr12223071cf.17.1726498160849; Mon, 16 Sep 2024
 07:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916120510.2017749-1-mpe@ellerman.id.au>
In-Reply-To: <20240916120510.2017749-1-mpe@ellerman.id.au>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 16 Sep 2024 07:49:09 -0700
Message-ID: <CAHS8izM-3DSw+hvFasu=xge5st9cE9MrwJ3FOOHpYHsj5r0Ydg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/atomic: Use YZ constraints for DS-form instructions
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu, 
	segher@kernel.crashing.org, sfr@canb.auug.org.au, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 5:05=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> The 'ld' and 'std' instructions require a 4-byte aligned displacement
> because they are DS-form instructions. But the "m" asm constraint
> doesn't enforce that.
>
> That can lead to build errors if the compiler chooses a non-aligned
> displacement, as seen with GCC 14:
>
>   /tmp/ccuSzwiR.s: Assembler messages:
>   /tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is not a multipl=
e of 4)
>   make[5]: *** [scripts/Makefile.build:229: net/core/page_pool.o] Error 1
>
> Dumping the generated assembler shows:
>
>   ld 8,39(8)       # MEM[(const struct atomic64_t *)_29].counter, t
>
> Use the YZ constraints to tell the compiler either to generate a DS-form
> displacement, or use an X-form instruction, either of which prevents the
> build error.
>
> See commit 2d43cc701b96 ("powerpc/uaccess: Fix build errors seen with
> GCC 13/14") for more details on the constraint letters.
>
> Fixes: 9f0cbea0d8cc ("[POWERPC] Implement atomic{, 64}_{read, write}() wi=
thout volatile")
> Cc: stable@vger.kernel.org # v2.6.24+
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20240913125302.0a06b4c7@canb.auug.org=
.au
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

I'm not familiar enough with the code around the changes, but I have
been able to confirm cherry-picking this resolves the build issue I'm
seeing on net-next, so, FWIW,

Tested-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

