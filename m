Return-Path: <linux-kernel+bounces-227463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B8915191
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9708BB25CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED02419E806;
	Mon, 24 Jun 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWM22yEr"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B119E7F2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241781; cv=none; b=AL/IWqC9lZTAF26oCCQxdPAXV/WR4dicGlmtAIwXZVZgjIB4CmUauOSBhe/T+nR5nm9eChcKodA/ikYAAMoQ9In0DBHiqSY/kQUBH9lGnv0DbmDALhVG05mXvp9lHg7agcIo0KxKbvIw6q6Pd7tipkr9UFf/mYaC+k2TGyIwYUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241781; c=relaxed/simple;
	bh=ZeHguHJLSQMs/OvZ126Ahbls3DDX9MrLdPV5rcWU6ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HucgBcxl3PlKYgAs01ylOOMVZKmY9waSXhHucHIwM4p6vui/wB7RhnQ5+ui7lUD8i3Bupev3lHsD0l9VA4eZ5pm224MX3l8SbqeW/Jxme40mSenWFcZa4671NdAyNnUZ4zq496dAszlEqiraUtr0R7CIRaW9ZKjWPGAw0QvnzAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWM22yEr; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so4246706276.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719241778; x=1719846578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XB2Z55p2RQm6Jx8UoWGvATXSa1oeJWFP0qatckj0zVY=;
        b=YWM22yEr+7lSqS0xs50gVH0Mj+kkt4h2Ud4O9TN7Aw3B/uDDy2YsgDfX0qyTSJSJ+9
         qE7V7Ipy+KNYsmS1POyFt6BMatUm39U1ORUjP10Zk5lKNZPPcWukcOggO9W24zleJHJm
         cKNbua/ZUjhAq0IRVWcrvDyB7wgUbzfGY3JL1KyCQUGpF1fceFO6ls/G/9UrWxFrPCPI
         W8G+SzTzXmh9DJ/1Nz8erIWV0A1bey6W1fkuz663rx2e8TFQEbKL0Zu7KiE63d6vh38k
         vlMOVNkQBuAZAbnKhQqxgpJdZ8Xgu1YpYS7dIsT3yodIY6fGUHI5BCCLAHpDtFqLvbBH
         etgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241778; x=1719846578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XB2Z55p2RQm6Jx8UoWGvATXSa1oeJWFP0qatckj0zVY=;
        b=L+4fwlHP6BrYBZYXS8DkgSSabkxj0QgFhq7jMA8uI4did55R9ivuvkBUq5U4bW2i1I
         yxPW/8IKNtE8I11MeC0RmkPpJSoEWqX0jIqIvBaTxHxMOuHLQO4lb0sQB4vhB7qLnUgI
         AHtHeC3M3KQmcdvDS+CD09xSaRNpgIsZZpJg0ILASSG0B+pEk68nktINn4HUgGTE5FO+
         p2iugSKcwqaoVR+JO2FhQKbDdOLACY7CrhWLyzyt7SUjcAFPBNVPlU+9Sa1UdrYSRi2X
         CCi215h9mwPamwT94nuz/99XVxXZrARtgn1DNxomcHtPlKVYR3YDL3CNJDmYD1g+XAPL
         aJhA==
X-Forwarded-Encrypted: i=1; AJvYcCVxmpA7W2oJYUwFvY8M5nJVtR0MFTwYrhiTkFg1ArSwYfxTn08iXAt4Lq8TDpozFJh2NizQL/FkKSuzRXx4bQxL1qf/UNfo+TDB3nI1
X-Gm-Message-State: AOJu0YyLUP+hu7ogHtYVaZrFNGysdS6KbCuByvLHDhoR2CcRxCgol6dS
	Jse/OhDMTTDn+i/hYtg+XyyrE2Gqpi54YHDQCzsmaBQlCqI7sH+NNJywb35TMk4qJKF2Zl83/Is
	z8UkGHf/zkg48ftDdCEFWYbGYt9Whof+baCMM
X-Google-Smtp-Source: AGHT+IEujGTFTwEXZeQBnOGhiY0sG4QE3pZi6IqrKJLpGcBDvYBKkU4v6WVwnIdOyHeffDpq6hUn1kyjnYujnmAypFk=
X-Received: by 2002:a25:b21d:0:b0:df7:6030:bb4e with SMTP id
 3f1490d57ef6-e0304049965mr5486434276.61.1719241778220; Mon, 24 Jun 2024
 08:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f214f15e-4a0a-4f24-9bd7-8f84cbc12e5a@p183> <CANpmjNO=zv6D807cNLAQ3eGLrigUs9xtYNxoHhyuYvHkhhSUWg@mail.gmail.com>
 <2aab04d1-c16b-44e4-a283-7bbf8cba28e7@p183>
In-Reply-To: <2aab04d1-c16b-44e4-a283-7bbf8cba28e7@p183>
From: Marco Elver <elver@google.com>
Date: Mon, 24 Jun 2024 17:09:02 +0200
Message-ID: <CANpmjNMZU=T6J5OBpELxB=ZqOnrkou2iRG7zaqoNy7bCGgH9hA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: simplify data_race() macro
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 16:43, Alexey Dobriyan <adobriyan@gmail.com> wrote:
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
> >
> > > ---
> > >
> > >  include/linux/compiler.h |    5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >
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
>
> I just realized, comma expression should not be necesary.
> -Wdeclaration-after-statement prohibited simple
>
>         ({
>                 __kcsan_disable_current
>                 auto v = (expr);
>                 __kcsan_enable_current
>                 v;
>         })

Even better.

