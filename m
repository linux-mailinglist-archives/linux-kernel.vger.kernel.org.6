Return-Path: <linux-kernel+bounces-432363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC769E49DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7897718832D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7F207E1B;
	Wed,  4 Dec 2024 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WQ6my0+P"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE331F5422
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355221; cv=none; b=ruNekEZGjoUWi7o5zuyC1+rBDilNS5AySuhAQlCUSsJDe3JgsKqf1L5xyXX4hQtBY0GOXzeiCMv8nspv8dVaUEXlz6QDZbmYOlP1BiSnaomTL97bwugZto8IOsVy7upSx2haAQQKairA7oar1AHRLcwP9G3EUEbciy1Y58y4yDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355221; c=relaxed/simple;
	bh=sZe8DIbzPwMfs/xLDhyn+o7Khr47svgEAlMqJ5RfcI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPjGiPKvNzbhWWq96lfR7duEBUVM4l+eDbkwl4Js7/vo8zDdB5QDC8o2iAk64HkB7z+0GSHNzFIIEnwUzUbtqvMWRbAZVStD4/nxrSB66Ea59CISYkGM1BWAOeFWGMLosURR/8aPfmPtrrq7sZAUeS/SxGmDjGsF7fzNstNLd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WQ6my0+P; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0c098c870so624192a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 15:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733355217; x=1733960017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NWC7guZheExcmhaMVwsCPe87jgz0IEzjxPFX8O+PaBg=;
        b=WQ6my0+POj/B26Id5fDFdzhQNxklocPA8f8NRNS+RMrpgcBHoYJ0a6DiaeHvPuIvvK
         Fsi/e6obTC9jcE1SGGpK2XdBo8lB5wFGhmUn5AdkoS604AL8QuhuFfxQ4obwiTtWvmWm
         xzcqGH123jsbZGYIfFeT3nlAYT6mFnnUQAFOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733355217; x=1733960017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWC7guZheExcmhaMVwsCPe87jgz0IEzjxPFX8O+PaBg=;
        b=qdrpEnOvcWAxZVM1GvOuqPo/Kc301XWGLut04rQAXzxnS0o4+SA6/1Io5VJGaQVqYl
         ToDCt2ruqMRT4Vmqn7siZf57sey608e2h47tXW4NdWHsEEwsBWC2RHPbI7WZVmSbeshM
         G/eMEJvE4Bwu5j/4aR9TxB2khRZ3M4434cogV3161sEcralskA8b0XQjXQD13xO9zFHq
         eGN3gG9iHqrsNv7GaYwLAUjQ1VK/RkRCRqeOKLf1U53Riem6c5NIj+t3Gg8Hq7w1VSgC
         qNI5phGoZ+9uMUwJqGTF3BafJnM8QDiRGnFYufUB0erfTDz4kpAN748ZihaQePPiWenj
         thfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd2bIjDUfsIoaiI2Y41wVtjIph/3VGe0ALBfeyFvnLJELRH12xRLOAkGDnI2mo0G9RAs+l/KtByGx5XpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKmk1fOpJU7nGmCNAZWLdWUTtYGX+klOvKYblLXXLOqpNPE0y
	7loFFuPxeedTBpMhgCoiqb+4jgzZDhK7LiiyAYOqicqWRxNJeqUrhPE7JMHKTewwEfpanwIIwJn
	Ml9o=
X-Gm-Gg: ASbGnculZFBJIIJsw8uH0sQPujhdbHJRBIWazdBuCEVN+43NG+pZOZyhtperdsAaaQA
	ZeuWQcqMUXWOnJznV8McHJFwjuaeLTuv7sWl0MANcw6BdU0I2FbnyKNbAeVfknr5A8fuO0YXfUQ
	mT8CIZ0YByrUUoxe5OPiOyoCSNlf5Y84/cycdwdaG2/Zj+ZfypdScTTIewCWvNh4DthkBgR1kS/
	4w9DHNEJMWIHGhPucZP2MbGJZ5wzbrRyRowDh7ptXs6A7VBDUpxLUYxJxeuIDwDHRcaQAdarfj1
	EEttGIjA6cJ1E4bJ2+mHxy41
X-Google-Smtp-Source: AGHT+IHT6MJgGSWFF/G0uGyraLDHUM3mzZ/x7L2MWFEPMsGRCShM/mIcl57oVpvnXp8QuT3i8tuECg==
X-Received: by 2002:a05:6402:2711:b0:5d0:d845:2882 with SMTP id 4fb4d7f45d1cf-5d124fe209emr1067248a12.13.1733355217342;
        Wed, 04 Dec 2024 15:33:37 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b620sm13636966b.125.2024.12.04.15.33.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 15:33:36 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa55171d73cso276313466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 15:33:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtQalCmtsy9PjKK7Ix+Q/d0nYNefOb8OhL3StfZJ24u726gpnqszKeh71CyerEvVwW7PLEMj4mE8mu5w0=@vger.kernel.org
X-Received: by 2002:a17:906:f5a3:b0:aa6:112f:50ba with SMTP id
 a640c23a62f3a-aa62188c9e3mr133284866b.13.1733355215584; Wed, 04 Dec 2024
 15:33:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204103042.1904639-1-arnd@kernel.org> <20241204103042.1904639-10-arnd@kernel.org>
 <CAHk-=wh_b8b1qZF8_obMKpF+xfYnPZ6t38F1+5pK-eXNyCdJ7g@mail.gmail.com> <d189f1a1-40d4-4f19-b96e-8b5dd4b8cefe@app.fastmail.com>
In-Reply-To: <d189f1a1-40d4-4f19-b96e-8b5dd4b8cefe@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Dec 2024 15:33:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wji1sV93yKbc==Z7OSSHBiDE=LAdG_d5Y-zPBrnSs0k2A@mail.gmail.com>
Message-ID: <CAHk-=wji1sV93yKbc==Z7OSSHBiDE=LAdG_d5Y-zPBrnSs0k2A@mail.gmail.com>
Subject: Re: [PATCH 09/11] x86: rework CONFIG_GENERIC_CPU compiler flags
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Davide Ciminaghi <ciminaghi@gnudd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 11:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I guess the other side of it is that the current selection
> between pentium4/core2/k8/bonnell/generic is not much better,
> given that in practice nobody has any of the
> pentium4/core2/k8/bonnell variants any more.

Yeah, I think that whole part of the x86 Kconfig is almost entirely historical.

It's historical also in the sense that a lot of those decisions matter
a whole lot less these days.

The whole CPU tuning issue is happily mostly a thing of the past,
since all modern CPU's do fairly well, and you don't have the crazy
glass jaws of yesteryear with in-order cores and the insane
instruction choice sensitivity of the P4 uarch.

And on our side, we've just also basically turned to much more dynamic
models, with either instruction rewriting or static branches or both.

So I suspect:

> A more radical solution would be to just drop the entire
> menu for 64-bit kernels and always default to "-march=x86_64
> -mtune=generic" and 64 byte L1 cachelines.

would actually be perfectly acceptable. The non-generic choices are
all entirely historical and not really very interesting.

Absolutely nobody sane cares about instruction scheduling for the old P4 cores.

In the bad old 32-bit days, we had real code generation issues with
basic instruction set, ie the whole "some CPU's are P6-class, but
don't actually support the CMOVxx instruction". Those days are gone.

And yes, on x86-64, we still have the whole cmpxchg16b issue, which
really is a slight annoyance. But the emphasis is on "slight" - we
basically have one back for this in the SLAB code, and a couple of
dynamic tests for one particular driver (iommu 128-bit IRTE mode).

So yeah, the cmpxchg16b thing is annoying, but _realistically_ I don't
think we care.

And some day we will forget about it, notice that those (few) AMD
early 64-bit CPU's can't possibly have been working for the last year
or two, and we'll finally just kill that code, but in the meantime the
cost of maintaining it is so slight that it's not worth actively going
out to kill it.

I do think that the *one* option we might have is "optimize for the
current CPU" for people who just want to build their own kernel for
their own machine. That's a nice easy choice to give people, and
'-march=native' is kind of simple to use.

Will that work when you cross-compile? No. Do we care? Also no. It's
basically a simple "you want to optimize for your own local machine"
switch.

Maybe that could replace some of the 32-bit choices too?

             Linus

