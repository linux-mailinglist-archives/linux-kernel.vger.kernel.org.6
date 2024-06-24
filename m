Return-Path: <linux-kernel+bounces-227379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437F6915031
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5FD28177D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6481619AD5B;
	Mon, 24 Jun 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0Gq69Jy"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE713D539
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240110; cv=none; b=D+Wsu0yKQnCHtMXl6UR467rxYWMGE/Kvsie1WY+rV2f1vWVBfY5aWHIiml6oHD//tPs8CImW05beQ97yC72rphV/zDVx677qhP/J3fxdqvku7DWrjpRNcEwPFYwI/glzV9TMszN2Fp/tNUJq4q0WxEdRRIMSvoVv20gc1GTeba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240110; c=relaxed/simple;
	bh=csSoRtkxTxD8epJzDI2lLRw9n1KypbFaa5GoXLXWd28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMrT1ilWEshnoVyaNyko/gN6IlloYN6AjDZBJLXOMZxKInGjlKikJT5af7AgF0J4Owi9GsWhAav29S4wmuT/z6YCQUqLKEXpIc/IafhgyLFynqAPkkBSdpiI5DWCROy7TLbi231sn2a1Oa11Z3C7cwkaNtiquC/eIj9HL9DKERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0Gq69Jy; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48f59584cbbso460873137.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719240108; x=1719844908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B0ascaAmVdSHgHq6Jjh/ltNfhyTAc/7r/7JCayNGg/E=;
        b=S0Gq69Jyi+K0+Butup+kcouBWoIrH2wGC0w+G2ojiM383N3TT978kii3L6LBajaMVU
         VrkFnSe3BsYsaYdpsPvRuJ7oOW5FNjMOJsdK62xIcI1qfjcLqoW+TTD+Se7jVmWK9bFs
         nqzytBDT8hnKMzXlMdfj4ZfRk9RgP8oR9A/nkWX0Y97nWOhrNhOxqmJ+WQ3wNXyj9mlb
         rmblrKjv/semj3dWyTpvT5pHtOFTshh3bkIVmzJp2IEWGm7iWTkACV8e3vjYN/Yi9Ki7
         a465CB+NphK0eaIeuKc1T/OxRdXytLncd5B8y5aOxcwHyFhj3zDmIidCf/jWFGwy517A
         KkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240108; x=1719844908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0ascaAmVdSHgHq6Jjh/ltNfhyTAc/7r/7JCayNGg/E=;
        b=OEHRoVXddWas+ePxolC3xTA3u6Fjp0KsTIEaVBsxbBfQJkJl//WU7phWzl1ypAtZLj
         AZjKv/9+oPvVOCYaAPhc/Le6k3q5ihnOHoe7eNGEcmPDXNC7sVWzylBe8wV+wB+n0/Tz
         8gIpboW1i7DmgR1Cm6FkkMiNSmBZclTjHqSM0617+PYoKVpC+ab6EE7M8SGF3uSYKwR6
         F5s4mLUINad5Ctjv0Jcixf7X6vjWTzQCY9vAmJM4QgORFQJld2uzhbf9AZjRApHq8xP6
         3ItehYPly8qu4vghH8MaL7IBFprtcfZDwFHjnZzkQiF15ipvGJEhiRPSuTOvtNdPWxLW
         BTOw==
X-Forwarded-Encrypted: i=1; AJvYcCUhF2Si1qoAHXY1jgenZwCxlMCYl4LnvV2g4Se84nb0IpY1Xewtkwfef/t73EEjcCXJxy72ZU4vUI0DFHgMI8s2aTE18n/Qv4AdPsnJ
X-Gm-Message-State: AOJu0YyR9nkbTaeaVmXZ+22S8lpjg0CeaS58DYd/JWPT8pNtOCoZu46V
	vyx7sfIogN7SSnQth+lOMZbuacz5X+10PBvCGn9Rpc8NW6Ew/tcTdjZtP8bwdMIzmOg/jJz1E8z
	Oko1u0IWZFDb+mEsQMMXQsVm66m6lTAECGjxt
X-Google-Smtp-Source: AGHT+IFln/MIfYS2SnTsMMe5FV/CZ5NcBcZW/o10ew1Z+54HbDGSpJeePin4igPczVnsSB76cpERmukQRq+qaiHGtRs=
X-Received: by 2002:a67:ee41:0:b0:48f:3f55:c550 with SMTP id
 ada2fe7eead31-48f52a356dfmr4630072137.16.1719240107942; Mon, 24 Jun 2024
 07:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f214f15e-4a0a-4f24-9bd7-8f84cbc12e5a@p183> <CANpmjNO=zv6D807cNLAQ3eGLrigUs9xtYNxoHhyuYvHkhhSUWg@mail.gmail.com>
 <c46bf4ac-91e8-4594-966b-b46fbdc140ce@p183>
In-Reply-To: <c46bf4ac-91e8-4594-966b-b46fbdc140ce@p183>
From: Marco Elver <elver@google.com>
Date: Mon, 24 Jun 2024 16:41:09 +0200
Message-ID: <CANpmjNOsVYG8+w64pPrAiDm23WPHnH1-7hFHFgMmKPxeqL7yYg@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: simplify data_race() macro
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 16:38, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Mon, Jun 24, 2024 at 02:27:43PM +0200, Marco Elver wrote:
> > On Mon, 24 Jun 2024 at 13:49, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > > Use auto type deduction and comma expression to decrease macro expansion
> > > size.
> > >
> > > __unqual_scalar_typeof() is quite wordy macro by itself.
> > >
> > > "expr" can be arbitrary complex so not expanding it twice is good.
> > > Should be faster too because type is deduced only once
> > > from the initializer.
> > >
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >
> > Thanks for cleaning up.  That code certainly predates the availability
> > of __auto_type. Although if I recall correctly, __unqual_scalar_typeof
> > became the first user of _Generic (the first C11 keyword we used in
> > the kernel?), but we used some ifdef to still support ancient
> > compilers initially (that definitely also didn't have __auto_type).
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> >
> > Which tree is this for?
>
> This is against mainline. Should not really matter, -next has the same code.

I meant which maintainer/tree should pick this up?

> > > --- a/include/linux/compiler.h
> > > +++ b/include/linux/compiler.h
> > > @@ -200,10 +200,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > >   */
> > >  #define data_race(expr)                                                        \
> > >  ({                                                                     \
> > > -       __unqual_scalar_typeof(({ expr; })) __v = ({                    \
> > > -               __kcsan_disable_current();                              \
> > > -               expr;                                                   \
> > > -       });                                                             \
> > > +       __auto_type __v = (__kcsan_disable_current(), expr);            \
> > >         __kcsan_enable_current();                                       \
> > >         __v;                                                            \
> > >  })

