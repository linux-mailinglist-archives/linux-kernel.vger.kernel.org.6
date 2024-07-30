Return-Path: <linux-kernel+bounces-268356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5F294239A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7401C2097B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9774E192B79;
	Tue, 30 Jul 2024 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ar90ReYp"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1185190489
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722383705; cv=none; b=BaDhXiMSAgPKJdoHp19wmt52bwWzdOynPEGrxI8s7TMMLnSXezf2MernEHZymqdVc/DtgD58phGjFxL4Vn60jrj0nCFhowMq7TSvki0PQJzYHDQz4hPxIhBgXD1LTihqSbDG/EUXnEOLJaBfRKbga/uKqDOGjYsGSfRiE32QCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722383705; c=relaxed/simple;
	bh=1cvDHSIeWCh4irvhkOnpQ9IFdSE1EHCGLYCzwNCSVXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUXEy2QkzdTdTDNa62ozffU+KyGjCTM2fGYxLNOAF3C1ckQ1a1f9pcNGAkagLK3cdBVY+90I2t1amcaDBvFe3vbbA50IA+be6IJO0vc8lYowM7PRvEZffKCQdImETbESj3Juxh3AuBfebbtKbg0+dkvEu3rLFlv9cLmT1RwdLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ar90ReYp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efba36802so8793130e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722383702; x=1722988502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DBWEEXyiyfI+ZBd1tpUb48flyp1AGk5OtAn9JnhJfA4=;
        b=Ar90ReYp3Po20u2mFb3awj7caYDYbW31jjsNKMM3Q+MBA3Se4FGhoMKmNT3eH7Porr
         2U2eH4xnALPQ0SSc7hEAeyiSl4YL73/DxcB9QGk5zZ1OTfwWrKnBHfircRWCdIc59e2F
         aMa4KHO6ctA6CUk6ni4KoDS0fkd7BLt/e4G40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722383702; x=1722988502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBWEEXyiyfI+ZBd1tpUb48flyp1AGk5OtAn9JnhJfA4=;
        b=i+exChzXIOT0rdwx5H/5PvGJ9lKP00rjl0Nn5/A+uEd2F5tGBLXNy0MkINDrmxsUuQ
         fgAicWGg890ehU+XZTejFyjmJLZx7ndwuPh/BQDF1yzXDTYsL4GSjXZWO/DrCELZvQX5
         /E5K9GXvfKalPU9vRGWcr7vPYecSlt+QenzmvFXtJ1NAerbzTDxJDFizCOU6TOmAlRgm
         pRvT29LL4ise+6GI1kLkM0cgULJBnLOZzAWfnKN45dzHvlj4RMa37Ms/9+j0u5f+fJdb
         mJoWv4B2ooGMnPrHklVeMtwkVZklzckgzUwOmTFQlM5lx/WcjXM2B8fRdqd3vv0eyhTA
         +9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRNAMpsjgUzqqlau0DssARbI96xBDouVUdaGrUdC7sote+li7RJ2kP9VL4uFiDxyhuNB2PGW9PAw/nUnDLOJPIn5LCbJ9OtMTTUu0v
X-Gm-Message-State: AOJu0Yy6LhoM75yx3UlBSeY/Y3PUCbcYevCWRe8nNmkvSoYNCHLAcRY8
	epjQadpQNVVeUzE1ZipTamBKXESez2NdKDjLq6eyJdRNOk/M1yTADjwz/pvuJacgc9kLmLADckl
	jX/Ix2Q==
X-Google-Smtp-Source: AGHT+IHLMSLim/mM6LdLVmY38ntpyPYJp2R8nWM1wfcuhDcyluDgydRn76pebz3czScB/lWEmFxNMQ==
X-Received: by 2002:ac2:5a1c:0:b0:52c:f3fa:86c with SMTP id 2adb3069b0e04-5309b270ad7mr8190493e87.18.1722383701934;
        Tue, 30 Jul 2024 16:55:01 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2cc4csm2050406e87.261.2024.07.30.16.55.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:55:01 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so66542271fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:55:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXV+5Feup8CBlmqd52Jaecc3nRy2t2GnUerhr85ySu1pPX3bET+MqODOjvxLiOHnoGHCG9op5229uxF0QkUTYO+AQ+vsAIAs0/JLs1i
X-Received: by 2002:a05:651c:201:b0:2ef:2b38:8796 with SMTP id
 38308e7fff4ca-2f12ee23df3mr94667651fa.32.1722383700564; Tue, 30 Jul 2024
 16:55:00 -0700 (PDT)
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
 <20240730200947.GT33588@noisy.programming.kicks-ass.net> <e791c078-a821-4636-b44d-e02c22c046cc@roeck-us.net>
In-Reply-To: <e791c078-a821-4636-b44d-e02c22c046cc@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jul 2024 16:54:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnmrbQhnXdpi=sY68m4OJff+qSiOUY-L8SF_u8JkHe8A@mail.gmail.com>
Message-ID: <CAHk-=wgnmrbQhnXdpi=sY68m4OJff+qSiOUY-L8SF_u8JkHe8A@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 16:29, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Baffled. Is it possible that the crashing code catches some page boundary ?

We've definitely seen things like that before. Some alignment change
makes something cross a cacheline or page boundary, and it magically
causes a huge regression.

Usually it's about performance, though, not this kind of thing.

But I could imagine that some odd instruction rewriting thing goes
wrong only when the instruction crosses a page boundary, and that
we've never happened to hit that case, and then some kernel config
just moves the affected code around just enough.

That would then indirectly also explain why only some compiler
versions hit it - because it all depends on hitting that exact page
crosser.

You also seemed to say that it only happened with some CPU selections.
Maybe there's something wrong with the ALTERNATIVE() cleanups - I'm
looking at that new "nested alternatives macros" thing, and the odd
games we play with the origin and replacement lengths etc.

That all looks entirely crazy. That file was hard to read before, now
it's just incomprehensible to me.

                  Linus

