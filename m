Return-Path: <linux-kernel+bounces-227383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABC4915037
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9844EB23769
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8074F19AD67;
	Mon, 24 Jun 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFU0MxzJ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053419AD45
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240179; cv=none; b=fPIeqnltNIUueO6BDWnQJbRbArG6sbjcs8eh18D1euAanGrzEp9FrUYAfiz8U0ATfEUb39u8WU3jcF9FsjVuGii66e7bL/CZy/VjG1nJS3vyrKDalovX88+ohXGNOX5b87prANqM3m5zpMb0rPJOlVsY20X8FznCD26akmI2u1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240179; c=relaxed/simple;
	bh=j/qu9btZ0MeXIISsfhrMqOHbPrmGyk4ZFkGEdqSOz9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siUgUzkixYH/3LKIETQ0povOR4xHYpu4mge5Yn7sjh4b8g7heVzuaf54AMFOVG6ickOwU9Cht88if8pBN1FtiTW9KfQI/xuhJzstCKy0IivyqicEiqnrvmhy1Hom+GrcnvgvDYOpwFAB9OnWXSRB7vDLBQDJtlI3Uy60jE0+Ms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFU0MxzJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d044aa5beso4968911a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719240177; x=1719844977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3Be+yUO/6f73NdwtnKZoM8RVqIjuuRKBwPY3MWzE24=;
        b=fFU0MxzJPD4zOcxW1n8AD6/HXnhrUgMNmbt2NH/rHvY/Bhq/u/qDiJ3GpJsd7q/BGr
         g/iJubzX38obzfOrQW8zJ2f0+HlgXXRWsHYeJ0dHOuT+OkwrR5tw5cxxs823bBk3H6MU
         fAMcMmdQC7dN6s1Ur7BR4LTDw48TrMc7TVLDzXq3u9p+0CQl90Yh3tLktx/1a9PqPVuP
         2lK0Yx4fpzSJgcdbHdKhWAneZBTX2o5dr9VBD23xHc7OGTmFEToe9gXTkQDY8LWHbG4P
         runVe5Nq9DGts4SwKrGUiEMt0AF7j7zYiHDaa0P3/nViDd77CZqRf4QZmawQisEZ+mSa
         E7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240177; x=1719844977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3Be+yUO/6f73NdwtnKZoM8RVqIjuuRKBwPY3MWzE24=;
        b=TcZrzBvqLyV18KLyTUhKK6+z1Z+fwM2y9AY6T3UcVsx8JomL7BkoDTPgDM3/Z0nWo6
         1P+jmtsPHI4YDNnVz0qPtA5VG0RHeZyiUWsFgfgZbvX8KJ4CXZ+3Ru3WdYSth3m6LlzT
         IpMxfFgtP5IAUWhPLnS2ny6OQq4iSde5tRbHp/h6qIjscLOgdUmYyYGwWBr7dJ5nacGX
         rLAfE51x8h5CplGvfqcVsnXopcU1RJubsqR1at1J3/LkPPXbFvQ54G/Rxf9r2WA501yh
         16rvS2emit0HGSL4q/afYUw6Atx7ej0KF2N6HLQvHU6YLZyjCG3l72xoL6CgSVhfg0/u
         n8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX437udgMcfnsxg4fGKtDgdT/HyxErLFflhJOpbJ0NSGcKpu+EP9pgFuhCzqB9ZEEk/wp+ALGIj+4jWf0EeqSi+SYjTgMwolRoSVNi+
X-Gm-Message-State: AOJu0YxjVWkB27BhWZJtptDyS2zRLwe8svbyhZm75WoNBUKjuRfjpZQR
	pxaV0cubgorZNL/CC4nsKZXkbjtY17GqOTpLuspbXlUKBdxi+rc=
X-Google-Smtp-Source: AGHT+IE3J1tIFwCJNX4EeUflSPZ6nTJh6CqbjxuB6465Fe89Wq8k4OmB5CRJEDi67R95Bf+EimwGjQ==
X-Received: by 2002:a17:906:2711:b0:a6f:b3af:2add with SMTP id a640c23a62f3a-a7245badbf4mr281865966b.45.1719240176418;
        Mon, 24 Jun 2024 07:42:56 -0700 (PDT)
Received: from p183 ([46.53.250.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72649a149asm16859066b.3.2024.06.24.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:42:56 -0700 (PDT)
Date: Mon, 24 Jun 2024 17:42:54 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Marco Elver <elver@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] compiler.h: simplify data_race() macro
Message-ID: <2aab04d1-c16b-44e4-a283-7bbf8cba28e7@p183>
References: <f214f15e-4a0a-4f24-9bd7-8f84cbc12e5a@p183>
 <CANpmjNO=zv6D807cNLAQ3eGLrigUs9xtYNxoHhyuYvHkhhSUWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNO=zv6D807cNLAQ3eGLrigUs9xtYNxoHhyuYvHkhhSUWg@mail.gmail.com>

On Mon, Jun 24, 2024 at 02:27:43PM +0200, Marco Elver wrote:
> On Mon, 24 Jun 2024 at 13:49, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Use auto type deduction and comma expression to decrease macro expansion
> > size.
> >
> > __unqual_scalar_typeof() is quite wordy macro by itself.
> >
> > "expr" can be arbitrary complex so not expanding it twice is good.
> > Should be faster too because type is deduced only once
> > from the initializer.
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Thanks for cleaning up.  That code certainly predates the availability
> of __auto_type. Although if I recall correctly, __unqual_scalar_typeof
> became the first user of _Generic (the first C11 keyword we used in
> the kernel?), but we used some ifdef to still support ancient
> compilers initially (that definitely also didn't have __auto_type).
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> Which tree is this for?
> 
> > ---
> >
> >  include/linux/compiler.h |    5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -200,10 +200,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >   */
> >  #define data_race(expr)                                                        \
> >  ({                                                                     \
> > -       __unqual_scalar_typeof(({ expr; })) __v = ({                    \
> > -               __kcsan_disable_current();                              \
> > -               expr;                                                   \
> > -       });                                                             \
> > +       __auto_type __v = (__kcsan_disable_current(), expr);            \
> >         __kcsan_enable_current();                                       \
> >         __v;                                                            \
> >  })

I just realized, comma expression should not be necesary.
-Wdeclaration-after-statement prohibited simple

	({
		__kcsan_disable_current
		auto v = (expr);
		__kcsan_enable_current
		v;
	})

