Return-Path: <linux-kernel+bounces-268187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03C94215D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F4B1C23EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4618DF7C;
	Tue, 30 Jul 2024 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FDBoiJXU"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B96318CBE5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370419; cv=none; b=l1sWYQPTPh9VcMHhrofVQs0hwlf+VNb4fqh+GOAzGMpmlo/+ZPwc8D1v9RfKXWsUQV11PKLsVKYNiZM/DfV3mhjCIugY3aTlsn6ImQcNuITR0SQAq5qBv0fqv2iXf6+D94dzCbgTDlTkncD1UI0LjooeprgCFLCB5VbtyyXzQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370419; c=relaxed/simple;
	bh=1oAQAjWkyXxMDZIqrGEyW21lb/Plvhu6Sfw3JcW5KXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3zeYM/uXzdvXKASexTHAG1dVA6dv9gcAWBM6sG9ttP9qYr1s1BcPEPvSVXqau0x987IhN4jgVmy1c1tpvJX6VFfKO2En2twJTuXK5oeiqWCAKjn1SF81ncifTE/lKtLW7MO8uEUiFH2URdgFNeGNpGy5FZAQhJV67TUr/uqqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FDBoiJXU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a843bef98so526264866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722370416; x=1722975216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aSHxVLCAgYGit7wdHTLbyyl/99zk6hdyVuKsPg01NIQ=;
        b=FDBoiJXUw3+3uwcK3UfOW/IxRrsBC0RvRBgep//rylh/+OfnjcBfm1PXvzT5bADDs5
         LtR70jv9B4W7rfhyGIWe//f0FucJbZNrCkASQKEJBR/KaJekxutFln8ViLtdGXvDS14C
         762z7Hw1pFJA6CcMVFNNzUIlqvMcdh6cdWRXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722370416; x=1722975216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSHxVLCAgYGit7wdHTLbyyl/99zk6hdyVuKsPg01NIQ=;
        b=tWuG+KA9k/GFwL7PMf1IU9ENq7vYFSRCZEBr7/3dvtZfNxGZm8hhGJh2HMSe6+k7JZ
         fSJHxjaQiju+wfhm7dOctnS1wntO/3i7aTBuQGMZ0Q7eH0G1H3NfEmIf3+nWQwm7+QGU
         3FHe5LYXwrJ8MIXvwi+2S2n+A+FxrTCv8X4i1zYwYRis7c9K5x0EfI9D3+tcDYx52rm9
         ZM2+qhpi49J8u5IJDr1kejIqe8ri2h085kjR24KWQZ7GIy9DidwyaRx3Q0km4cJeztSO
         eILp/Ck+oUXkuz7ThWLrhi3R7egJfOZkQypL78VdnCv/xuwhugej8i7CHrSZU6xmooFE
         Ksuw==
X-Forwarded-Encrypted: i=1; AJvYcCXTMH0T6AFXTMvK7x+a/PvUIfLRYhmKH2hNZ0Wx/nw7puDdw/W1WAP7x8MP/wD6EOj9RlKDvHvCPLL1fqLx5L/bUZ8kNOB0tWnpnJ6P
X-Gm-Message-State: AOJu0YyrtwjaaQ32SOzV/VDmc2GAoFkbENNL0npBDgM96AMKlQ+9knrM
	9ukurK304axYvt9u4FXsNfnWu0O1ZYBTMMDInW0YS4dKdy8FEVLROknB1ZWYKb2g4j0A82Iv6Mm
	T/itjOg==
X-Google-Smtp-Source: AGHT+IENDm3ZrpqFIh7VFgcM3mteFQ8orO+IzZyNg6zDaMqc6xH96WkAdL5oAY3Hvug5PHNyvnm6gA==
X-Received: by 2002:a17:906:f583:b0:a77:dde0:d669 with SMTP id a640c23a62f3a-a7d40166362mr878912766b.45.1722370415917;
        Tue, 30 Jul 2024 13:13:35 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acada29f2sm684443466b.162.2024.07.30.13.13.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 13:13:35 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a9e25008aso650854966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:13:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+1jhGWhuotuZMmNK1ZMx7q2ffKabVQpOmKt4elzEYLaV9fjy0J91YFOXKKWZ9CBsq7M6xzpZFQV1eLxt0nXdF3Vql0lbwkERberrM
X-Received: by 2002:a17:907:6d16:b0:a72:633d:5fd6 with SMTP id
 a640c23a62f3a-a7d99cf9dbamr10961966b.32.1722370415021; Tue, 30 Jul 2024
 13:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net> <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net> <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net> <f395b9d1-9515-434b-8ea5-c3bcaac10fd1@roeck-us.net>
In-Reply-To: <f395b9d1-9515-434b-8ea5-c3bcaac10fd1@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jul 2024 13:13:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whH0EXPeWBCDT8Hf_6Dai7sd6KjccKXzixyZbWxREh3Cg@mail.gmail.com>
Message-ID: <CAHk-=whH0EXPeWBCDT8Hf_6Dai7sd6KjccKXzixyZbWxREh3Cg@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 13:04, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Maybe I should just switch to a more recent version of gcc and call it a day,
> in the hope that it is a compiler (or qemu) problem and doesn't just hide
> the problem.

Well, if it's a gcc-11 problem, I think we still really want to know
what is going on. We are *not* all that close to dropping support for
gcc-11 yet.

And honestly, while it's often very convenient to blame the compiler,
compiler bugs are still very rare.

It's *much* more common that bad code just happens to work with a good
compiler than that good code happens to break with a bad compiler.

Yes, we obviously do hit real compiler bugs, but still ... We'd need
to actually see what goes wrong in the code generation before blaming
a compiler bug.

                  Linus

